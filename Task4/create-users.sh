#!/bin/bash

# Создание сертификатов для security-officer
openssl genrsa -out security-officer.key 2048
openssl req -new -key security-officer.key -out security-officer.csr -subj "/CN=security-officer/O=security"
openssl x509 -req -in security-officer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key \
  -CAcreateserial -out security-officer.crt -days 365

# Создание сертификатов для devops-user
openssl genrsa -out devops-user.key 2048
openssl req -new -key devops-user.key -out devops-user.csr -subj "/CN=devops-user/O=devops"
openssl x509 -req -in devops-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key \
  -CAcreateserial -out devops-user.crt -days 365

# Добавление пользователей в kubectl config
kubectl config set-credentials security-officer --client-certificate=security-officer.crt --client-key=security-officer.key
kubectl config set-credentials devops-user --client-certificate=devops-user.crt --client-key=devops-user.key

# Создание контекстов
kubectl config set-context security-officer-context --cluster=minikube --user=security-officer
kubectl config set-context devops-user-context --cluster=minikube --user=devops-user
