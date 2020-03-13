FROM gcc:9.2
#FROM ubuntu:18.04
RUN apt-get -qq update \
    && apt-get -y install git sudo bossa-cli libcanberra-gtk-module libsfml-dev libusb-1.0-0-dev man screen

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 \
    && tar xvf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 --directory usr/local/bin \
    && rm gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2

ENV PATH=$PATH:/usr/local/bin/gcc-arm-none-eabi-9-2019-q4-major/bin

WORKDIR /usr/project

CMD ["bash"]


#sudo docker run -it -v $(PWD):/usr/src/myapp -w /usr/src/myapp --privileged --device=/dev/tty.usbmodem146201:/dev/tty.usbmodem146201 r2d2_build/gcc9-make:1.0 bash
#sudo docker run -it -v $(PWD):/usr/src/myapp -w /usr/src/myapp --privileged -v /dev/tty.usbmodem146201:/dev/tty.usbmodem146201 r2d2_build/gcc9-make:1.0 bash