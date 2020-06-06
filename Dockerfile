FROM ubuntu:18.04

ENV HOME=/opt/build

WORKDIR /opt/build

# install ubuntu packages
RUN apt-get update -q \
 && apt-get install -y \
    git \
    curl \
    locales \
    build-essential \
    autoconf \
    libncurses5-dev \
    libwxgtk3.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev \
    gnupg \
 && apt-get clean

ENV ASDF_ROOT $HOME/.asdf
ENV PATH "${ASDF_ROOT}/bin:${ASDF_ROOT}/shims:$PATH"

RUN git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT} --branch v0.7.8  \
 && asdf plugin-add erlang \
 && asdf plugin-add elixir

RUN touch $HOME/.bashrc 
RUN touch $HOME/.profile

RUN echo '. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc 
RUN echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

RUN echo '. $HOME/.asdf/asdf.sh' >> $HOME/.profile
RUN echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.profile

# set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# install erlang
ENV ERLANG_VERSION 22.3.4.1
RUN asdf install erlang ${ERLANG_VERSION} \
 && asdf global erlang ${ERLANG_VERSION}

# install elixir
ENV ELIXIR_VERSION 1.10.3-otp-22
RUN asdf install elixir ${ELIXIR_VERSION} \
 && asdf global elixir ${ELIXIR_VERSION}

# install local Elixir hex and rebar
RUN mix local.hex --if-missing --force \
 && mix local.rebar --force

CMD ["/bin/bash"]