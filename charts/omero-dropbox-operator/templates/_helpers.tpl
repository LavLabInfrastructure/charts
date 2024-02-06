{{/*
Expand the name of the chart.
*/}}
{{- define "omero-dropbox-operator.name" -}}
{{- default "omero-dropbox" .Chart.Name -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "omero-dropbox-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate the default fullname for resources.
This uses the release name and the chart name.
*/}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "omero-dropbox-operator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "omero-dropbox" .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Standard labels to be used by all resources.
*/}}
{{- define "omero-dropbox-operator.labels" -}}
helm.sh/chart: {{ include "omero-dropbox-operator.chart" . }}
{{ include "omero-dropbox-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels to match resources.
*/}}
{{- define "omero-dropbox-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "omero-dropbox-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Generate the name for the service account to be used, either default or custom.
*/}}
{{- define "omero-dropbox-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "omero-dropbox-operator.fullname" .) .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
Generate the name for the webhook's service account, handling creation flag and overrides.
*/}}
{{- define "omero-dropbox-operator.webhookServiceAccountName" -}}
{{- if .Values.webhook.serviceAccount.create -}}
{{- if .Values.webhook.serviceAccount.name -}}
{{- .Values.webhook.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-webhook" (include "omero-dropbox-operator.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- else -}}
{{- default "default" .Values.webhook.serviceAccount.name -}}
{{- end -}}
{{- end -}}
