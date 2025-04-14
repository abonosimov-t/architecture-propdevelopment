#!/bin/bash

# Создание namespace
kubectl create namespace prod
kubectl create namespace dev

# Применение ролей и привязок
kubectl apply -f roles/cluster-roles.yaml
kubectl apply -f roles/role-bindings.yaml

# Проверка прав
echo "Проверка прав security-officer:"
kubectl auth can-i get secrets --as security-officer
kubectl auth can-i get pods/log --as security-officer

echo "Проверка прав devops-user:"
kubectl auth can-i create deployments --as devops-user
kubectl auth can-i get pods --as devops-user
