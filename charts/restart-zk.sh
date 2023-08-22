#!/bin/bash

NAMESPACE=vds
STATEFULSET_NAME=zk_zookeeper
ZOOKEEPER_CONTAINER_NAME=zookeeper
URL=http://localhost:8080/commands/mntr
TIMEOUT=300s

# Function to fetch data from a pod and print the output
fetch_data() {
  local pod_name=$1
  local output=$(kubectl exec -it "$pod_name" -c "$ZOOKEEPER_CONTAINER_NAME" -n "$NAMESPACE" -- curl -s "$URL")
  if [ -z "$output" ]; then
    echo "Output for $pod_name: Pod not found or no output received."
  else
    echo "Output for $pod_name: $output"

    # Check if the server_state field in the JSON output is "leader" or "follower"
    if [[ $output == *"\"server_state\" : \"leader\""* ]]; then
      leader="$pod_name"
    elif [[ $output == *"\"server_state\" : \"follower\""* ]]; then
      followers+=("$pod_name")
    fi
  fi
}

# Function to wait for a pod to be ready and in the "Running" status
wait_for_pod_ready() {
  local pod_name=$1
  echo "Waiting for $pod_name to be ready..."
  kubectl wait pod "$pod_name" -n "$NAMESPACE" --for=condition=Ready --timeout=$TIMEOUT
}

# Function to delete a follower pod and wait for its readiness
delete_and_wait_for_follower() {
  local pod_name=$1
  echo "Deleting $pod_name..."
  kubectl delete pod "$pod_name" -n "$NAMESPACE"
  
  # Wait for the pod to be in the "Running" and "Ready" state
  wait_for_pod_ready "$pod_name"
}

# Get the names of the ZooKeeper pods
pod_names=$(kubectl get pods -n "$NAMESPACE" -l "app.kubernetes.io/name=zookeeper" -o 'jsonpath={.items[*].metadata.name}')

leader=""
followers=()

# Fetch data from each ZooKeeper pod and identify the leader and followers
echo "Fetching data from $URL in pods: $pod_names..."
for pod_name in $pod_names; do
  fetch_data "$pod_name"
done

# Sort the followers in descending order (higher to lower)
IFS=$'\n' followers=($(sort -r <<<"${followers[*]}"))
unset IFS

# Delete the followers with higher numbers first
if [ "${#followers[@]}" -gt 0 ]; then
  wait_for_pod_ready "${followers[0]}"
  for follower in "${followers[@]}"; do
    delete_and_wait_for_follower "$follower"
  done
fi

# Wait for the leader to be ready and then delete it
if [ -n "$leader" ]; then
  wait_for_pod_ready "$leader"
  kubectl delete pod "$leader" -n "$NAMESPACE"
fi
