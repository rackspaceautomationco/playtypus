#
FROM fedora:latest

RUN /bin/dnf install -yq deltarpm && \ 
 dnf install -y git \
		    ruby-2.4.1 \
                    rubygem-rake \
                    ruby-devel \
                    openssl \
                    openssl-devel \
                    redhat-rpm-config \
                    gcc-c++
RUN dnf -y groupinstall development-tools

#    dnf clean all
RUN /usr/bin/gem install rake &&  \
    /usr/bin/gem install bundle && \ 
    /usr/bin/gem install json

ENV HOME /home/user

RUN useradd  user -d $HOME \
	&& chown -R user $HOME

WORKDIR $HOME
USER user
RUN /usr/bin/git clone https://github.com/rackspaceautomationco/playtypus.git /home/user/playtypus
RUN cd /home/user/playtypus && \
    rake build && \
    gem install /home/user/playtypus/pkg/playtypus-*


ENTRYPOINT [ "/home/user/bin/playtypus" ]
CMD ["--help"]

