FROM nginx:alpine
LABEL org.opencontainers.image.title="ai-sw-workstation-web"
ENV APP_ENV=dev
COPY app/ /usr/share/nginx/html/
