#!/bin/bash

set -e

BACKEND_DIR="backend"
FRONTEND_DIR="frontend"
BACKEND_PORT=8000
FRONTEND_PORT=3000

echo "Starting Ethvana Development Environment"
echo "============================================"

cleanup() {
    echo ""
    echo "Shutting down services..."
    kill $BACKEND_PID 2>/dev/null || true
    kill $FRONTEND_PID 2>/dev/null || true
    exit 0
}

trap cleanup SIGINT SIGTERM

check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        echo "Port $port is already in use. Killing process..."
        kill -9 $(lsof -ti:$port) 2>/dev/null || true
        sleep 1
    fi
}

wait_for_backend() {
    local max_attempts=30
    local attempt=0
    
    echo "Waiting for backend to be ready..."
    
    while [ $attempt -lt $max_attempts ]; do
        if curl -s http://localhost:$BACKEND_PORT/health >/dev/null 2>&1; then
            echo "Backend is ready!"
            return 0
        fi
        attempt=$((attempt + 1))
        sleep 1
    done
    
    echo "Backend failed to start"
    exit 1
}

check_port $BACKEND_PORT
check_port $FRONTEND_PORT

echo ""
echo "Installing Backend Dependencies..."
cd $BACKEND_DIR
npm install --silent
echo "Backend dependencies installed"

echo ""
echo "Starting Backend Server..."
npm run dev > ../backend.log 2>&1 &
BACKEND_PID=$!
cd ..

wait_for_backend

echo ""
echo "Installing Frontend Dependencies..."
cd $FRONTEND_DIR
npm install --silent
echo "Frontend dependencies installed"

echo ""
echo "Starting Frontend Server..."
npm run dev > ../frontend.log 2>&1 &
FRONTEND_PID=$!
cd ..

echo ""
echo "Waiting for frontend to be ready..."
sleep 5

for i in {1..30}; do
    if curl -s http://localhost:$FRONTEND_PORT >/dev/null 2>&1; then
        echo "Frontend is ready!"
        break
    fi
    sleep 1
done

echo ""
echo "============================================"
echo "All services are running!"
echo "============================================"
echo ""
echo "Frontend URL: http://localhost:$FRONTEND_PORT"
echo "Backend URL:  http://localhost:$BACKEND_PORT"
echo "Health Check: http://localhost:$BACKEND_PORT/health"
echo ""
echo "Logs:"
echo "   Backend: tail -f backend.log"
echo "   Frontend: tail -f frontend.log"
echo ""
echo "Press Ctrl+C to stop all services"
echo "============================================"

wait
