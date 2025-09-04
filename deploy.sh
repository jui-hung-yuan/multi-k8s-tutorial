docker build -t juihungyuan/multi-client:latest -t juihungyuan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t juihungyuan/multi-server:latest -t juihungyuan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t juihungyuan/multi-worker:latest -t juihungyuan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push juihungyuan/multi-client:latest
docker push juihungyuan/multi-client:$SHA
docker push juihungyuan/multi-server:latest
docker push juihungyuan/multi-server:$SHA
docker push juihungyuan/multi-worker:latest
docker push juihungyuan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=juihungyuan/multi-server:$SHA
kubectl set image deployments/client-deployment client=juihungyuan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=juihungyuan/multi-worker:$SHA