#!/bin/bash

kubectl create namespace app-namespace
kubectl apply -f deployments.yaml -n app-namespace
kubectl apply -f non-admin-api-allow.yaml -n app-namespace

echo "Проверка деплойментов:"
kubectl get deployments -n app-namespace

echo "Проверка подов:"
kubectl get pods -n app-namespace --show-labels

echo "Проверка сетевых политик:"
kubectl get networkpolicies -n app-namespace
