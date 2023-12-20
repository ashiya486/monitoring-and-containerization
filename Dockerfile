




version: '3'
services:
  prometheus:
    image: docker.io/prom/prometheus:latest
    container_name: prometheus-container
    user: root
    networks:
      -  monitor-net
    ports:
      - "9090:9090"
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'
    volumes:
        - ./prometheus:/etc/prometheus
        - ./prometheus-data:/prometheus
  grafana:
	 image: docker.io/grafana/grafana:latest
    container_name: grafana-container
    ports:
      - "3000:3000"
    networks:
      -  monitor-net
    environment:
      - GF_SECURITY_ADMIN_USER=${ADMIN_USER:-admin}
      - GF_SECURITY_ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
    volumes:
      - grafana-data:/var/lib/grafana
depends_on:
      -  prometheus
  node-exporter:
   image: docker.io/prom/node-exporter:latest
   container_name: node-exporter
   volumes:
     - /proc:/host/proc:ro
     - /sys:/host/sys:ro
     - /:/rootfs:ro
   command:
     - '--path.procfs=/host/proc'
     - '--path.rootfs=/rootfs'
     - '—-path.sysfs=/host/sys'
 - '--collector.filesystem.mount-points-    exclude=^/(sys|proc|dev|host|etc)($$|/)'
   expose:
     - 9100
   networks:
     - monitor-net
  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    container_name: cadvisor
    user: root
    ports:
      -  8080:8080
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/containers/storage:/var/lib/containers/storage:ro
  springboot_app:
    image: 018550248565.dkr.ecr.us-east-1.amazonaws.com/demo-repo:latest
container_name:  demo-springboot-app
    ports:
      - "8081:8081"
    networks:
      -  monitor-net
networks:
  monitor-net:
    driver: bridge
volumes:
  prometheus-data:
  grafana-data: