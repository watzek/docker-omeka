# Omeka on Docker

[![Build Status](https://travis-ci.org/WatzekDigitalInitiatives/docker-omeka.svg?branch=master)](https://travis-ci.org/WatzekDigitalInitiatives/docker-omeka) [![](https://images.microbadger.com/badges/version/watzek/omeka.svg)](http://microbadger.com/images/watzek/omeka "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/watzek/omeka.svg)](https://microbadger.com/images/watzek/omeka "Get your own image badge on microbadger.com")

## How to use me:

### I just want a fresh, containerized install of Omeka:

ensure the latest versions of `docker` and `docker-compose` are installed.

```
curl -o https://raw.githubusercontent.com/WatzekDigitalInitiatives/docker-omeka/master/docker-compose.yml
docker-compose up -d
```

navigate to `localhost` in a browser and install your new Omeka. the [Omeka API import plugin](https://omeka.org/add-ons/plugins/omeka-api-import/) is included to easily import data & schema from another Omeka instance.

if you are using a proxy in front of the container like (nginx-proxy)[https://github.com/jwilder/nginx-proxy] with https, you can edit the `HTTPS` parameter in `docker-compose.yml` to force Omeka to use https:// urls to avoid mixed content errors.

### I want to make my own custom Omeka image:

```
git clone https://github.com/WatzekDigitalInitiatives/docker-omeka.git
docker build -t my-custom-omeka .
```

see the wiki for more information on how the Omeka image is built.
