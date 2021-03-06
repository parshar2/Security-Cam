# Security Cam v2
#  - Finds ip address webcam - used for detecting motion
# Version 1.10.00
FROM paradrop/workshop
MAINTAINER Paradrop Team <info@paradrop.io>

# Install dependencies.  You can add additional packages here following the example.
RUN apt-get update && apt-get install -y \
#	<package> \
	apache2 \
	iptables \
	nodejs \
	python-imaging \
	wget \
	curl \
	build-essential \
	cmake \
	python-pip \
	python-dev \
	build-essential \ 
	python-opencv \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN easy_install pip
run wget 'https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg' && /bin/sh setuptools-0.6c11-py2.7.egg && rm -f setuptools-0.6c11-py2.7.egg
run curl 'https://raw.github.com/pypa/pip/master/contrib/get-pip.py' | python2.7
run pip install numpy
run apt-get update && apt-get install -y -q libavformat-dev libavcodec-dev libavfilter-dev libswscale-dev
run apt-get update && apt-get install -y -q libjpeg-dev libpng-dev libtiff-dev libjasper-dev zlib1g-dev libopenexr-dev libxine-dev libeigen3-dev libtbb-dev
add build_opencv.sh	/build_opencv.sh
run /bin/sh /build_opencv.sh
run rm -rf /build_opencv.sh

# Apache site configuration
ADD chute/000-default.conf /etc/apache2/sites-available/

#  Get the web frontend
ADD chute/web /var/www/html

# Install files required by the chute.
#
# ADD <path_inside_repository> <path_inside_container>
#
ADD chute/seccam.py /usr/local/bin/seccam.py
ADD chute/haarcascade_frontalface_alt.xml /usr/local/haarcascade_frontalface_alt.xml
ADD chute/run.sh /usr/local/bin/run.sh

# Set the work dir for nodejs photo server
WORKDIR "/var/www/html"

EXPOSE 80 81 8010

CMD ["/bin/bash", "/usr/local/bin/run.sh"]
