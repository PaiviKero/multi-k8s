docker build -t paivikero/multi-client:latest -t paivikero/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paivikero/multi-server:latest -t paivikero/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paivikero/multi-worker:latest -t paivikero/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paivikero/multi-client:latest
docker push paivikero/multi-server:latest
docker push paivikero/multi-worker:latest

docker push paivikero/multi-client:$SHA
docker push paivikero/multi-server:$SHA
docker push paivikero/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paivikero/multi-server:$SHA
kubectl set image deployments/client-deployment client=paivikero/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paivikero/multi-worker:$SHA