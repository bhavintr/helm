# common-services

![Version: 1.0.5](https://img.shields.io/badge/Version-1.0.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.2](https://img.shields.io/badge/AppVersion-1.2-informational?style=flat-square)

A Helm chart for RadiantOne Common Services on Kubernetes

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| pgodey | <pgodey@radiantlogic.com> | <https://www.radiantlogic.com> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argo-cd | 5.6.0 |
| https://charts.bitnami.com/bitnami | postgresql | 12.1.3 |
| https://charts.bitnami.com/bitnami | zookeeper | 11.0.0 |
| https://fluent.github.io/helm-charts | fluent-bit | 0.24.0 |
| https://grafana.github.io/helm-charts | grafana | 6.40.0 |
| https://haproxytech.github.io/helm-charts | haproxy | 1.17.3 |
| https://helm.elastic.co | elasticsearch | 7.17.3 |
| https://helm.elastic.co | kibana | 7.17.3 |
| https://helm.runix.net | pgadmin4 | 1.13.8 |
| https://opensearch-project.github.io/helm-charts | opensearch | 2.11.1 |
| https://opensearch-project.github.io/helm-charts | opensearch-dashboards | 2.9.0 |
| https://prometheus-community.github.io/helm-charts | prometheus | 15.13.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| argo-cd.applicationSet.enabled | bool | `false` |  |
| argo-cd.configs.params."server.insecure" | bool | `true` |  |
| argo-cd.configs.params."server.rootpath" | string | `"/argocd"` |  |
| argo-cd.controller.nodeSelector | object | `{}` |  |
| argo-cd.crds.keep | bool | `false` |  |
| argo-cd.dex.enabled | bool | `false` |  |
| argo-cd.enabled | bool | `true` |  |
| argo-cd.fullnameOverride | string | `"argocd"` |  |
| argo-cd.notifications.enabled | bool | `false` |  |
| argo-cd.redis.nodeSelector | object | `{}` |  |
| argo-cd.repoServer.nodeSelector | object | `{}` |  |
| argo-cd.server.nodeSelector | object | `{}` |  |
| argo-cd.server.service.type | string | `"NodePort"` |  |
| elasticsearch.enabled | bool | `true` |  |
| elasticsearch.nodeSelector | object | `{}` |  |
| elasticsearch.replicas | int | `1` |  |
| elasticsearch.singleNode | bool | `true` |  |
| elasticsearch.volumeClaimTemplate.resources.requests.storage | string | `"30Gi"` |  |
| fluent-bit.config.customParsers | string | `"[PARSER]\n    Name docker_no_time\n    Format json\n    Time_Keep Off\n    Time_Key time\n    Time_Format %Y-%m-%dT%H:%M:%S.%L\n"` |  |
| fluent-bit.config.inputs | string | `"[INPUT]\n    Name              tail\n    Tag               backend.log\n    Path              /var/log/containers/eoc-backend-*.log\n    Exclude_Path      /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*\n    Parser            docker\n    DB                /var/log/flb_kube.db\n    Skip_Long_Lines   On\n    Refresh_Interval  10\n\n[INPUT]\n    Name              tail\n    Tag               orchestrator.log\n    Path              /var/log/containers/eoc-orchestrator-*.log\n    Exclude_Path      /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*, /var/log/containers/eoc-backend-*.log\n    Parser            docker\n    DB                /var/log/flb_kube.db\n    Skip_Long_Lines   On\n    Refresh_Interval  10\n\n[INPUT]\n    Name              tail\n    Tag               agents.log\n    Path              /var/log/containers/sdc-agent*.log\n    Exclude_Path      /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*\n    Parser            docker\n    DB                /var/log/flb_kube.db\n    Skip_Long_Lines   On\n    Refresh_Interval  10\n\n[INPUT]\n    Name              tail\n    Tag               clientrouter.log\n    Path              /var/log/containers/client-*.log\n    Exclude_Path      /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*\n    Parser            docker\n    DB                /var/log/flb_kube.db\n    Skip_Long_Lines   On\n    Refresh_Interval  10\n\n[INPUT]\n    Name              tail\n    Tag               acmeco.log\n    Path              /var/log/containers/acmeco*.log\n    Exclude_Path      /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*\n    Parser            docker\n    DB                /var/log/flb_kube.db\n    Skip_Long_Lines   On\n    Refresh_Interval  10\n"` |  |
| fluent-bit.config.outputs | string | `"[OUTPUT]\n    Name               {{ .Values.outputSearchType }}\n    Match              backend.log\n    Host               elasticsearch-master\n    Trace_Error        On\n    Replace_Dots       On\n    Logstash_Format    off\n    Index              backend-index\n    Retry_Limit        False\n\n[OUTPUT]\n    Name               {{ .Values.outputSearchType }}\n    Match              orchestrator.*\n    Host               elasticsearch-master\n    Trace_Error        On\n    Replace_Dots       On\n    Logstash_Format    off\n    Index              orchestrator-index\n    Retry_Limit        False\n\n[OUTPUT]\n    Name               {{ .Values.outputSearchType }}\n    Match              agents.log\n    Host               elasticsearch-master\n    Trace_Error        On\n    Replace_Dots       On\n    Logstash_Format    off\n    Index              sdc-index\n    Retry_Limit        False\n\n[OUTPUT]\n    Name               {{ .Values.outputSearchType }}\n    Match              clientrouter.log\n    Host               elasticsearch-master\n    Trace_Error        On\n    Replace_Dots       On\n    Logstash_Format    off\n    Index              router-index\n    Retry_Limit        False\n\n[OUTPUT]\n    Name               {{ .Values.outputSearchType }}\n    Match              acmeco.log\n    Host               elasticsearch-master\n    Trace_Error        On\n    Replace_Dots       On\n    Logstash_Format    off\n    Index              acmeco-index\n    Retry_Limit        False\n"` |  |
| fluent-bit.config.service | string | `"[SERVICE]\n    Daemon Off\n    Flush {{ .Values.flush }}\n    Log_Level {{ .Values.logLevel }}\n    Parsers_File parsers.conf\n    Parsers_File custom_parsers.conf\n    HTTP_Server On\n    HTTP_Listen 0.0.0.0\n    HTTP_Port {{ .Values.metricsPort }}\n    Health_Check On\n"` |  |
| fluent-bit.enabled | bool | `true` |  |
| fluent-bit.flush | int | `1` |  |
| fluent-bit.fullnameOverride | string | `"fluent-bit"` |  |
| fluent-bit.logLevel | string | `"info"` |  |
| fluent-bit.metricsPort | int | `2020` |  |
| fluent-bit.nodeSelector | object | `{}` |  |
| fluent-bit.outputSearchType | string | `"es"` |  |
| fluent-bit.prometheusRule.enabled | bool | `false` |  |
| fluent-bit.service.type | string | `"ClusterIP"` |  |
| fluent-bit.serviceMonitor.enabled | bool | `false` |  |
| fluent-bit.volumeMounts[0].mountPath | string | `"/fluent-bit/etc/fluent-bit.conf"` |  |
| fluent-bit.volumeMounts[0].name | string | `"config"` |  |
| fluent-bit.volumeMounts[0].subPath | string | `"fluent-bit.conf"` |  |
| fluent-bit.volumeMounts[1].mountPath | string | `"/fluent-bit/etc/custom_parsers.conf"` |  |
| fluent-bit.volumeMounts[1].name | string | `"config"` |  |
| fluent-bit.volumeMounts[1].subPath | string | `"custom_parsers.conf"` |  |
| grafana."grafana.ini"."auth.anonymous".enabled | bool | `true` |  |
| grafana."grafana.ini"."auth.anonymous".org_role | string | `"Viewer"` |  |
| grafana."grafana.ini"."log.console".format | string | `"text"` |  |
| grafana."grafana.ini"."log.console".level | string | `"info"` |  |
| grafana."grafana.ini".analytics.check_for_updates | bool | `false` |  |
| grafana."grafana.ini".log.mode | string | `"console"` |  |
| grafana."grafana.ini".panels.disable_sanitize_html | bool | `true` |  |
| grafana."grafana.ini".security.allow_embedding | bool | `true` |  |
| grafana."grafana.ini".server.root_url | string | `"%(protocol)s://%(domain)s/grafana"` |  |
| grafana."grafana.ini".server.serve_from_sub_path | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".apiVersion | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].allowUiUpdates | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder | string | `""` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name | string | `"fid"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path | string | `"/var/lib/grafana/dashboards/fid"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].updateIntervalSeconds | int | `10` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].allowUiUpdates | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].folder | string | `""` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].name | string | `"zookeeper"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].options.path | string | `"/var/lib/grafana/dashboards/zookeeper"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].updateIntervalSeconds | int | `10` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].allowUiUpdates | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].folder | string | `""` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].name | string | `"elasticsearch"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].options.path | string | `"/var/lib/grafana/dashboards/elasticsearch"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].updateIntervalSeconds | int | `10` |  |
| grafana.dashboardsConfigMaps.elasticsearch | string | `"audit-logs-elastic-dashboard"` |  |
| grafana.dashboardsConfigMaps.fid | string | `"fid-dashboard"` |  |
| grafana.dashboardsConfigMaps.zookeeper | string | `"zookeeper-dashboard"` |  |
| grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| grafana.datasources."datasources.yaml".datasources[0].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[0].isDefault | bool | `true` |  |
| grafana.datasources."datasources.yaml".datasources[0].name | string | `"Prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://prometheus-server"` |  |
| grafana.datasources."datasources.yaml".datasources[1].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[1].database | string | `"vds_server_access.log*"` |  |
| grafana.datasources."datasources.yaml".datasources[1].isDefault | bool | `false` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.esVersion | string | `"7.17.3"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.logLevelField | string | `"fields.level"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.logMessageField | string | `"message"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.maxConcurrentShardRequests | int | `5` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.timeField | string | `"@timestamp"` |  |
| grafana.datasources."datasources.yaml".datasources[1].name | string | `"Elasticsearch"` |  |
| grafana.datasources."datasources.yaml".datasources[1].password | string | `""` |  |
| grafana.datasources."datasources.yaml".datasources[1].readonly | bool | `true` |  |
| grafana.datasources."datasources.yaml".datasources[1].type | string | `"elasticsearch"` |  |
| grafana.datasources."datasources.yaml".datasources[1].url | string | `"http://elasticsearch-master:9200"` |  |
| grafana.datasources."datasources.yaml".datasources[1].user | string | `""` |  |
| grafana.datasources."datasources.yaml".datasources[2].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[2].name | string | `"Alertmanager"` |  |
| grafana.datasources."datasources.yaml".datasources[2].type | string | `"alertmanager"` |  |
| grafana.datasources."datasources.yaml".datasources[2].url | string | `"http://prometheus-alertmanager"` |  |
| grafana.enabled | bool | `true` |  |
| grafana.fullnameOverride | string | `"grafana"` |  |
| grafana.nodeSelector | object | `{}` |  |
| grafana.persistence.enabled | bool | `true` |  |
| grafana.persistence.size | string | `"8Gi"` |  |
| haproxy.config | string | `"defaults\n  timeout connect 10s\n  timeout client 30s\n  timeout server 30s\n  log global\n  mode http\n  option httplog\n  maxconn 3000\nfrontend http-in\n  bind *:80\n\n  stats enable\n  stats refresh 30s\n  stats show-node\n  stats uri /stats\n  monitor-uri /healthz\n\n  use_backend argocd_backend if { path /argocd } or { path_beg /argocd/ }\n  use_backend grafana_backend if { path /grafana } or { path_beg /grafana/ }\n  use_backend kibana_backend if { path /kibana } or { path_beg /kibana/ }\n  #use_backend elasticsearch_backend if { path /elasticsearch } or { path_beg /elasticsearch/ }\n  #use_backend prometheus_backend if { path /prometheus } or { path_beg /prometheus/ }\n  #use_backend alertmanager_backend if { path /alertmanager } or { path_beg /alertmanager/ }\n  #use_backend pushgateway_backend if { path /pushgateway } or { path_beg /pushgateway/ }\n  #use_backend pgadmin4_backend if { path /pgadmin4 } or { path_beg /pgadmin4/ }\n  #use_backend slamd_backend if { path /slamd } or { path_beg /slamd/ }\n  #use_backend shellinabox_backend if { path /shellinabox } or { path_beg /shellinabox/ }\n  #use_backend eocui_backend if { path /eoc } or { path_beg /eoc/ }\n  #use_backend eocapi_backend if { path /eoc-backend } or { path_beg /eoc-backend/ }\n  #use_backend sdcapi_backend if { path /sdc } or { path_beg /sdc/ }\n\nbackend argocd_backend\n  server argocd argocd-server:80\nbackend grafana_backend\n  http-request set-path %[path,regsub(^/grafana/?,/)]\n  server grafana grafana:80\nbackend kibana_backend\n  http-request set-path %[path,regsub(^/kibana/?,/)]\n  server kibana kibana:5601\nbackend elasticsearch_backend\n  http-request set-path %[path,regsub(^/elasticsearch/?,/)]\n  server elasticsearch elasticsearch-master:9200\nbackend prometheus_backend\n  http-request set-path %[path,regsub(^/prometheus/?,/)]\n  server prometheus prometheus-server:80\n#backend alertmanager_backend\n  #http-request set-path %[path,regsub(^/alertmanager/?,/)]\n  #server alertmanager prometheus-alertmanager:80\nbackend pushgateway_backend\n  http-request set-path %[path,regsub(^/pushgateway/?,/)]\n  server pushgateway prometheus-pushgateway:9091\n#backend pgadmin4_backend\n  #server pgadmin4 pgadmin4:80\nbackend slamd_backend\n  server slamd slamd:80\nbackend shellinabox_backend\n  http-request set-path %[path,regsub(^/shellinabox/?,/)]\n  server shellinabox shellinabox:8080\n#backend eocui_backend\n  #server eocui eoc-ui-service:80\n#backend eocapi_backend\n  #server eocapi eoc-backend-service:80\n#backend sdcapi_backend\n  #server sdcapi sdc-agent:80\n"` |  |
| haproxy.enabled | bool | `true` |  |
| haproxy.fullnameOverride | string | `"haproxy"` |  |
| haproxy.nodeSelector | object | `{}` |  |
| haproxy.service.type | string | `"NodePort"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `"alb"` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| kibana.enabled | bool | `true` |  |
| kibana.fullnameOverride | string | `"kibana"` |  |
| kibana.kibanaConfig."kibana.yml" | string | `"server.basePath: \"/kibana\"\ntelemetry.optIn: false\nsecurity.showInsecureClusterWarning: false\n"` |  |
| kibana.nodeSelector | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| opensearch-dashboards.config."opensearch_dashboards.yml" | string | `"server:\n  basePath: \"/opensearch-dashboards\"\n  rewriteBasePath: true\n"` |  |
| opensearch-dashboards.enabled | bool | `true` |  |
| opensearch-dashboards.extraEnvs[0].name | string | `"DISABLE_SECURITY_DASHBOARDS_PLUGIN"` |  |
| opensearch-dashboards.extraEnvs[0].value | string | `"true"` |  |
| opensearch-dashboards.fullnameOverride | string | `"opensearch-dashboards"` |  |
| opensearch-dashboards.nodeSelector | object | `{}` |  |
| opensearch-dashboards.opensearchHosts | string | `"http://opensearch-cluster-master:9200"` |  |
| opensearch-dashboards.plugins.enabled | bool | `false` |  |
| opensearch-dashboards.plugins.installList | list | `[]` |  |
| opensearch-dashboards.replicaCount | int | `1` |  |
| opensearch-dashboards.service.annotations | object | `{}` |  |
| opensearch-dashboards.service.httpPortName | string | `"http"` |  |
| opensearch-dashboards.service.labels | object | `{}` |  |
| opensearch-dashboards.service.loadBalancerIP | string | `""` |  |
| opensearch-dashboards.service.loadBalancerSourceRanges | list | `[]` |  |
| opensearch-dashboards.service.nodePort | string | `""` |  |
| opensearch-dashboards.service.port | int | `5601` |  |
| opensearch-dashboards.service.type | string | `"ClusterIP"` |  |
| opensearch.clusterName | string | `"opensearch-cluster"` |  |
| opensearch.enabled | bool | `true` |  |
| opensearch.extraContainers | list | `[]` |  |
| opensearch.extraEnvs[0].name | string | `"DISABLE_SECURITY_PLUGIN"` |  |
| opensearch.extraEnvs[0].value | string | `"true"` |  |
| opensearch.extraInitContainers | list | `[]` |  |
| opensearch.extraVolumeMounts | list | `[]` |  |
| opensearch.extraVolumes | list | `[]` |  |
| opensearch.fullnameOverride | string | `"opensearch"` |  |
| opensearch.masterService | string | `"opensearch-cluster-master"` |  |
| opensearch.nodeGroup | string | `"master"` |  |
| opensearch.nodeSelector | object | `{}` |  |
| opensearch.podSecurityContext.fsGroup | int | `1000` |  |
| opensearch.podSecurityContext.runAsUser | int | `1000` |  |
| opensearch.rbac.create | bool | `false` |  |
| opensearch.rbac.serviceAccountAnnotations | object | `{}` |  |
| opensearch.rbac.serviceAccountName | string | `""` |  |
| opensearch.replicas | int | `3` |  |
| opensearch.service.annotations | object | `{}` |  |
| opensearch.service.httpPortName | string | `"http"` |  |
| opensearch.service.nodePort | string | `""` |  |
| opensearch.service.transportPortName | string | `"transport"` |  |
| opensearch.service.type | string | `"ClusterIP"` |  |
| opensearch.singleNode | bool | `true` |  |
| pgadmin4.enabled | bool | `true` |  |
| pgadmin4.env.contextPath | string | `"/pgadmin4"` |  |
| pgadmin4.fullnameOverride | string | `"pgadmin4"` |  |
| pgadmin4.nodeSelector | object | `{}` |  |
| pgadmin4.persistentVolume.enabled | bool | `false` |  |
| postgresql.databases.eoc.databaseName | string | `"eocdb"` |  |
| postgresql.databases.eoc.password | string | `"TSXojYsPF4AeZgTq"` |  |
| postgresql.databases.eoc.schema | string | `"eoc"` |  |
| postgresql.databases.eoc.user | string | `"eocadmin"` |  |
| postgresql.databases.sdc.databaseName | string | `"agentsdb"` |  |
| postgresql.databases.sdc.password | string | `"iJukleKLG9fNihIQ"` |  |
| postgresql.databases.sdc.schema | string | `"agents"` |  |
| postgresql.databases.sdc.user | string | `"agentsadmin"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.fullnameOverride | string | `"postgresql"` |  |
| postgresql.primary.initdb.scriptsConfigMap | string | `"postgres-init-script"` |  |
| postgresql.primary.nodeSelector | object | `{}` |  |
| postgresql.primary.persistence.size | string | `"10Gi"` |  |
| prometheus.alertmanager.config.global.slack_api_url | string | `"https://hooks.slack.com/services/XXXXXXXXXXXX"` |  |
| prometheus.alertmanager.config.global.smtp_auth_password | string | `""` |  |
| prometheus.alertmanager.config.global.smtp_auth_username | string | `""` |  |
| prometheus.alertmanager.config.global.smtp_from | string | `"saas@radiantlogic.com"` |  |
| prometheus.alertmanager.config.global.smtp_smarthost | string | `"smtp-server:25"` |  |
| prometheus.alertmanager.config.inhibit_rules[0].equal[0] | string | `"alertname"` |  |
| prometheus.alertmanager.config.inhibit_rules[0].source_matchers[0] | string | `"severity=\"critical\""` |  |
| prometheus.alertmanager.config.inhibit_rules[0].target_matchers[0] | string | `"severity=\"warning\""` |  |
| prometheus.alertmanager.config.receivers[0].email_configs[0].to | string | `"username_to@example.com"` |  |
| prometheus.alertmanager.config.receivers[0].name | string | `"team-fid-devops"` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].channel | string | `"#devops"` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].send_resolved | bool | `true` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].text | string | `"{{ range .Alerts -}} *Alert:* {{ .Annotations.title }}{{ if .Labels.severity }} - `{{ .Labels.severity }}`{{ end }} *Description:* {{ .Annotations.description }} *Details:*\n  {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`\n  {{ end }}\n{{ end }}"` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].title | string | `"[{{ .Status | toUpper }}{{ if eq .Status \"firing\" }}:{{ .Alerts.Firing | len }}{{ end }}] {{ .CommonLabels.alertname }} for {{ .CommonLabels.job }}\n{{- if gt (len .CommonLabels) (len .GroupLabels) -}}\n  {{\" \"}}(\n  {{- with .CommonLabels.Remove .GroupLabels.Names }}\n    {{- range $index, $label := .SortedPairs -}}\n      {{ if $index }}, {{ end }}\n      {{- $label.Name }}=\"{{ $label.Value -}}\"\n    {{- end }}\n  {{- end -}}\n  )\n{{- end }}"` |  |
| prometheus.alertmanager.config.route.group_by[0] | string | `"alertname"` |  |
| prometheus.alertmanager.config.route.group_interval | string | `"3h"` |  |
| prometheus.alertmanager.config.route.group_wait | string | `"30s"` |  |
| prometheus.alertmanager.config.route.receiver | string | `"team-fid-devops"` |  |
| prometheus.alertmanager.config.route.repeat_interval | string | `"3h"` |  |
| prometheus.alertmanager.config.route.routes[0].matchers[0] | string | `"monitor=~\"fid|radiantone|vds\""` |  |
| prometheus.alertmanager.config.route.routes[0].receiver | string | `"team-fid-devops"` |  |
| prometheus.alertmanager.config.templates[0] | string | `"/etc/alertmanager/*.tmpl"` |  |
| prometheus.alertmanager.configmapReload.enabled | bool | `false` |  |
| prometheus.alertmanager.enabled | bool | `false` |  |
| prometheus.alertmanager.fullnameOverride | string | `"prometheus-alertmanager"` |  |
| prometheus.alertmanager.nodeSelector | object | `{}` |  |
| prometheus.alertmanager.replicationCount | int | `1` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.kubeStateMetrics.enabled | bool | `false` |  |
| prometheus.nodeExporter.enabled | bool | `false` |  |
| prometheus.pushgateway.fullnameOverride | string | `"prometheus-pushgateway"` |  |
| prometheus.pushgateway.nodeSelector | object | `{}` |  |
| prometheus.server.configmapReload.enabled | bool | `false` |  |
| prometheus.server.extraFlags[0] | string | `"web.enable-lifecycle"` |  |
| prometheus.server.extraFlags[1] | string | `"web.route-prefix=/"` |  |
| prometheus.server.extraFlags[2] | string | `"web.external-url=http://prometheus-server/prometheus/"` |  |
| prometheus.server.extraFlags[3] | string | `"web.enable-admin-api"` |  |
| prometheus.server.fullnameOverride | string | `"prometheus-server"` |  |
| prometheus.server.nodeSelector | object | `{}` |  |
| prometheus.server.persistentVolume.size | string | `"8Gi"` |  |
| prometheus.server.statefulSet.enabled | bool | `true` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].name | string | `"FID alerts"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].alert | string | `"FID memory is high"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].annotations.description | string | `"warning! {{ $labels.job }} on {{ $labels.instance }} found FID memory usage is more than 80% for 120s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].annotations.title | string | `"FID Memory usage on {{ $labels.instance }} is more than 80%"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].expr | string | `"(ldap_memory_used{job=\"fid-targets\"}/ldap_memory_max{job=\"fid-targets\"}) * 100 > 80"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].for | string | `"120s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[0].labels.severity | string | `"warning"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].alert | string | `"FID connections are high"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].annotations.description | string | `"warning! {{ $labels.job }} on {{ $labels.instance }} found FID connections are morethan 5 for 10s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].annotations.title | string | `"FID connections on {{ $labels.instance }} are more than 800"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].expr | string | `"ldap_current_connections{job=\"fid-targets\"} > 800"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].for | string | `"10s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[1].labels.severity | string | `"warning"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].alert | string | `"FID node disk usage is high"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].annotations.description | string | `"warning! {{ $labels.job }} on {{ $labels.instance }} found FID node disk usage are more than 80% for 120s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].annotations.title | string | `"FID node disk usage on {{ $labels.instance }} is more than 80%"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].expr | string | `"(ldap_disk_used{job=\"fid-targets\"}/ldap_disk_total{job=\"fid-targets\"}) * 100 > 80"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].for | string | `"120s"` |  |
| prometheus.serverFiles."alerting_rules.yml".groups[0].rules[2].labels.severity | string | `"warning"` |  |
| shellinabox.affinity | object | `{}` |  |
| shellinabox.enabled | bool | `true` |  |
| shellinabox.image.pullPolicy | string | `"IfNotPresent"` |  |
| shellinabox.image.repository | string | `"sspreitzer/shellinabox"` |  |
| shellinabox.image.tag | string | `"ubuntu"` |  |
| shellinabox.imagePullSecrets | list | `[]` |  |
| shellinabox.nodeSelector | object | `{}` |  |
| shellinabox.podAnnotations | object | `{}` |  |
| shellinabox.podSecurityContext | object | `{}` |  |
| shellinabox.replicaCount | int | `1` |  |
| shellinabox.resources | object | `{}` |  |
| shellinabox.securityContext | object | `{}` |  |
| shellinabox.service.port | int | `8080` |  |
| shellinabox.service.type | string | `"ClusterIP"` |  |
| shellinabox.tolerations | list | `[]` |  |
| slamd.affinity | object | `{}` |  |
| slamd.autoscaling.enabled | bool | `false` |  |
| slamd.autoscaling.maxReplicas | int | `100` |  |
| slamd.autoscaling.minReplicas | int | `1` |  |
| slamd.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| slamd.client.affinity | object | `{}` |  |
| slamd.client.autoscaling.enabled | bool | `false` |  |
| slamd.client.autoscaling.maxReplicas | int | `100` |  |
| slamd.client.autoscaling.minReplicas | int | `1` |  |
| slamd.client.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| slamd.client.image.pullPolicy | string | `"IfNotPresent"` |  |
| slamd.client.image.repository | string | `"pgodey/slamd-client"` |  |
| slamd.client.image.tag | string | `"latest"` |  |
| slamd.client.nodeSelector | object | `{}` |  |
| slamd.client.podAnnotations | object | `{}` |  |
| slamd.client.podSecurityContext | object | `{}` |  |
| slamd.client.replicaCount | int | `0` |  |
| slamd.client.resources | object | `{}` |  |
| slamd.client.securityContext | object | `{}` |  |
| slamd.client.tolerations | list | `[]` |  |
| slamd.enabled | bool | `true` |  |
| slamd.image.pullPolicy | string | `"IfNotPresent"` |  |
| slamd.image.repository | string | `"pgodey/slamd"` |  |
| slamd.image.tag | string | `"latest"` |  |
| slamd.imagePullSecrets | list | `[]` |  |
| slamd.nodeSelector | object | `{}` |  |
| slamd.podAnnotations | object | `{}` |  |
| slamd.podSecurityContext | object | `{}` |  |
| slamd.replicaCount | int | `1` |  |
| slamd.resources | object | `{}` |  |
| slamd.securityContext | object | `{}` |  |
| slamd.service.port | int | `80` |  |
| slamd.service.type | string | `"ClusterIP"` |  |
| slamd.tolerations | list | `[]` |  |
| smtp.affinity | object | `{}` |  |
| smtp.enabled | bool | `true` |  |
| smtp.image.pullPolicy | string | `"IfNotPresent"` |  |
| smtp.image.repository | string | `"bytemark/smtp"` |  |
| smtp.image.tag | string | `"latest"` |  |
| smtp.imagePullSecrets | list | `[]` |  |
| smtp.nodeSelector | object | `{}` |  |
| smtp.podAnnotations | object | `{}` |  |
| smtp.podSecurityContext | object | `{}` |  |
| smtp.relay.enabled | bool | `true` |  |
| smtp.relay.host | string | `"smtp.sendgrid.net"` |  |
| smtp.relay.password | string | `""` |  |
| smtp.relay.port | string | `"587"` |  |
| smtp.relay.username | string | `""` |  |
| smtp.replicaCount | int | `1` |  |
| smtp.resources | object | `{}` |  |
| smtp.securityContext | object | `{}` |  |
| smtp.service.port | int | `8080` |  |
| smtp.service.type | string | `"ClusterIP"` |  |
| smtp.tolerations | list | `[]` |  |
| zookeeper.enabled | bool | `false` |  |
| zookeeper.fullnameOverride | string | `"zookeeper"` |  |
| zookeeper.nodeSelector | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
