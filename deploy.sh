docker build -t rmrjaiswal/multi-client-k8s:latest -t rmrjaiswal/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t rmrjaiswal/multi-server-k8s:latest -t rmrjaiswal/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t rmrjaiswal/multi-worker-k8s:latest -t rmrjaiswal/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push rmrjaiswal/multi-client-k8s:latest
docker push rmrjaiswal/multi-server-k8s:latest
docker push rmrjaiswal/multi-worker-k8s:latest

docker push rmrjaiswal/multi-client-k8s:$SHA
docker push rmrjaiswal/multi-server-k8s:$SHA
docker push rmrjaiswal/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rmrjaiswal/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=rmrjaiswal/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=rmrjaiswal/multi-worker-k8s:$SHA