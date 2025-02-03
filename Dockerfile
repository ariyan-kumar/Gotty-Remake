from ubuntu:latest

RUN apt update
RUN apt upgrade
RUN apt install tmate -y
RUN tmate -F
