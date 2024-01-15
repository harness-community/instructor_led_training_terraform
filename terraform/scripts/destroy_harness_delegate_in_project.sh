#!/bin/bash

kubectl delete -f harness-delegate.yaml || true
sleep 1
rm harness-delegate.yaml || true
#sleep 1
#echo "{\"delegate_name\": \"PLACEHOLDER\"}" > helper.json

# HERE I CAN CALL THE API AND DELETE THE DELEGATE FROM THE UI
