# Rota — static site container
#
# This app has no build step (no npm install, no bundler) — it's plain HTML/CSS/JS files
# that talk to Firebase directly from the browser. This Dockerfile just packages those files
# behind a small, production-grade web server (nginx) so any server that can run a container
# can host it.
FROM nginx:1.27-alpine

# Remove nginx's default sample page
RUN rm -rf /usr/share/nginx/html/*

# Copy the app's static files in
COPY index.html /usr/share/nginx/html/index.html
COPY login.html /usr/share/nginx/html/login.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY favicon.ico /usr/share/nginx/html/favicon.ico
COPY favicon-32x32.png /usr/share/nginx/html/favicon-32x32.png
COPY favicon-16x16.png /usr/share/nginx/html/favicon-16x16.png
COPY apple-touch-icon.png /usr/share/nginx/html/apple-touch-icon.png
COPY icon-192.png /usr/share/nginx/html/icon-192.png
COPY icon-512.png /usr/share/nginx/html/icon-512.png

# Custom nginx config: sensible caching + basic security headers
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000

# nginx's official image already runs the server as its entrypoint — nothing else to do.
