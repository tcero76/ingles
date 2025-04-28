FROM envoyproxy/envoy:v1.33-latest

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update
RUN apt-get install -y gettext

ENTRYPOINT [ "/entrypoint.sh" ]