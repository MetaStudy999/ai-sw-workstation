FROM nginx:alpine

LABEL org.opencontainers.image.title="ai-sw-workstation-web"
LABEL org.opencontainers.image.description="Mission 1 custom nginx image"
LABEL org.opencontainers.image.version="1.0"

ENV APP_ENV=dev

# 포트 바인딩
EXPOSE 8080

COPY app/ /usr/share/nginx/html/
