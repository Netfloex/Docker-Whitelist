FROM alpine

RUN apk add --no-cache iptables bash

COPY . .

CMD ["/setup.sh"]