FROM ubuntu:20.04

# from https://hardhat.org/tutorial/setting-up-the-environment.html
# and https://github.com/cncjs/cncjs/issues/489
RUN apt update && apt -y install curl git udev gnupg

RUN adduser --disabled-password --gecos "" cnc
RUN usermod -a -G tty cnc
RUN usermod -a -G dialout cnc

USER cnc

ENV NVM_DIR=/home/cnc/.nvm

RUN git clone https://github.com/creationix/nvm.git $NVM_DIR;
RUN cd $NVM_DIR; git checkout `git describe --abbrev=0 --tags`;
RUN . "$NVM_DIR/nvm.sh"; \
    nvm install 12; \
        nvm use 12; \
            npm install -g cncjs@1.9.22;

CMD . $NVM_DIR/nvm.sh && cncjs -p 8080;

# old
#RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
#RUN apt install -y nodejs
#RUN npm install -g cncjs
#RUN npm install --unsafe-perm  -g cncjs

# setup .cncrc file by copying over from current directory (optional)
#COPY .cncrc /root/.cncrc

#WORKDIR /home/${USER}/
#USER ${UID}:${GID}
#CMD ["cncjs","-p","8080"]
#CMD ["cnc"]
