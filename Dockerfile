FROM centos

MAINTAINER zhugaoxiao <zhugaoxiao@gmail.com>

RUN yum install -y epel-release gcc python-devel libxml2-devel libxslt-devel git httpd

RUN yum install -y python-pip; \
    yum clean all
    
RUN pip install tox

RUN mkdir /home/git; \
    cd /home/git; \
    git clone https://github.com/openstack/openstack-manuals.git; \
    cd openstack-manuals; \
    tox -e checkbuild

RUN ln -sf /home/git/openstack-manuals/www /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
