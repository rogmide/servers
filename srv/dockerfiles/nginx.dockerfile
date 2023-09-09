FROM nginx:stable-alpine

WORKDIR /apps


RUN echo "UTC" > /etc/timezone

# Installing bash
RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing git
RUN apk add git
RUN curl https://raw.githubusercontent.com/git-ftp/git-ftp/master/git-ftp > /bin/git-ftp
RUN chmod 755 /bin/git-ftp

RUN sed -i 's/user  nginx/user  nobody/g' /etc/nginx/nginx.conf