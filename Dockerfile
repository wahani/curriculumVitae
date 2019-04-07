FROM ubuntu:bionic

WORKDIR /app

RUN ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone \
  && apt-get -y update

RUN apt-get install -y --no-install-recommends \
        texlive

RUN apt-get install -y --no-install-recommends \
        latexmk \
        wget \
        unzip \
        fontconfig
    # && apt-get autoremove -y \
    # && apt-get autoclean -y \
    # && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y --no-install-recommends \
    texlive-xetex

RUN wget --no-check-certificate https://fontlibrary.org/assets/downloads/source-sans-pro/d288e5a9d9111d4041f365469aa2ca97/source-sans-pro.zip \
    && unzip source-sans-pro.zip \
    && mkdir ~/.fonts \
    && cp source-sans-pro-2.020R-ro-1.075R-it/OTF/*.otf ~/.fonts/ \
    && fc-cache -f -v ~/.fonts

## I tried and faild. Something is not working with the fonts in this
## configuration. The following command I wanted to use to compile this CV:
## docker run --rm -v $PWD:/app --user `id -u`:`id -g` tmp latexmk --xelatex cv.tex
