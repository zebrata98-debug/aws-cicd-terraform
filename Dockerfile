FROM node:18-alpine
WORKDIR /app
COPY . .
RUN echo "console.log('App running!')" > index.js
EXPOSE 3000
CMD ["node", "index.js"]
