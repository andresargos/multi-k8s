docker build -t gorillavila/multi-client:latest -t gorillavila/multi-client:$SHA -f ./client/Dockerfile./client
docker build -t gorillavila/multi-server:latest -t gorillavila/multi-server:$SHA -f ./server/Dockerfile./server
docker build -t gorillavila/multi-worker:latest -t gorillavila/multi-worker:$SHA -f ./worker/Dockerfile./worker
docker push gorillavila/multi-client:latest
docker push gorillavila/multi-server:latest
docker push gorillavila/multi-worker:latest

docker push gorillavila/multi-client:$SHA
docker push gorillavila/multi-server:$SHA
docker push gorillavila/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gorillavila/multi-server:$SHA
kubectl set image deployments/client-deployment server=gorillavila/multi-client:$SHA
kubectl set image deployments/worker-deployment server=gorillavila/multi-worker:$SHA