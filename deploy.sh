docker build -t fanlima/multi-client:latest -t fanlima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fanlima/multi-server:latest -t fanlima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fanlima/multi-worker:latest -t fanlima/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fanlima/multi-client:latest
docker push fanlima/multi-server:latest
docker push fanlima/multi-worker:latest
docker push fanlima/multi-client:$SHA
docker push fanlima/multi-server:$SHA
docker push fanlima/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fanlima/multi-server:$SHA
kubectl set image deployments/client-deployment client=fanlima/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fanlima/multi-worker:$SHA


