FROM node:alpine

RUN apk add --update \
	curl \
	g++ \
	iptables \
	make \
	python	\
	sudo
RUN addgroup -S app \
	&& adduser -S -g app app -s /bin/ash

WORKDIR /app
COPY . .

RUN yarn install
ENTRYPOINT ["/app/entrypoint.sh", "--"]
