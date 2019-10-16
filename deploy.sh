docker build -t thecosmicfrog/multi-client:latest -t thecosmicfrog/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thecosmicfrog/multi-server:latest -t thecosmicfrog/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thecosmicfrog/multi-worker:latest -t thecosmicfrog/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thecosmicfrog/multi-client:latest
docker push thecosmicfrog/multi-client:$SHA
docker push thecosmicfrog/multi-server:latest
docker push thecosmicfrog/multi-server:$SHA
docker push thecosmicfrog/multi-worker:latest
docker push thecosmicfrog/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=thecosmicfrog/multi-client:$SHA
kubectl set image deployments/server-deployment server=thecosmicfrog/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=thecosmicfrog/multi-worker:$SHA

