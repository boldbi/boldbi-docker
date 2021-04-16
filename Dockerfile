#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base

RUN apt-get update && apt-get install -y fontconfig
RUN apt-get update && apt-get install -y libgdiplus

ENV OPENSSL_CONF=/etc/ssl/

RUN apt-get update && apt-get install -y nginx
RUN apt-get install -y procps
RUN apt-get install -y jq

WORKDIR /boldbi

EXPOSE 80
EXPOSE 443

COPY /boldbi .

CMD ./entrypoint.sh