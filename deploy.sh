docker build -t gohan01/multi-client:latest -t gohan01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gohan01/multi-server:latest -t gohan01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gohan01/multi-worker:latest -t gohan01/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gohan01/multi-client:latest
docker push gohan01/multi-client:$SHA
docker push gohan01/multi-server:latest
docker push gohan01/multi-server:$SHA
docker push gohan01/multi-worker:latest
docker push gohan01/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gohan01/multi-server:$SHA
kubectl set image deployments/client-deployment client=gohan01/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gohan01/multi-worker:$SHA