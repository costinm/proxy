#!/usr/bin/env bash

curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.22.3/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

sudo -E minikube start \
            --extra-config=apiserver.Admission.PluginNames="Initializers,NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,GenericAdmissionWebhook,ResourceQuota" \
            --kubernetes-version=v1.7.5 --vm-driver=none
sudo -E minikube update-context


sudo -E kubectl cluster-info
