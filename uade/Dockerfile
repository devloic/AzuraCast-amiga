FROM debian:bookworm AS uade-build
USER root
RUN apt-get update \
       && apt-get install -y build-essential libsdl2-dev libao-dev git python3.11-venv python3-pip
RUN git clone https://gitlab.com/uade-music-player/uade 
WORKDIR uade
RUN python3 -m venv .azuvenv && . .azuvenv/bin/activate && pip install tqdm Pillow
RUN . .azuvenv/bin/activate && git clone https://gitlab.com/heikkiorsila/bencodetools && cd bencodetools && pip install -r requirements_dev.txt && ./configure \
   && make && make install
RUN git clone https://gitlab.com/hors/libzakalwe && cd libzakalwe && ./configure && make && make install
RUN ./configure && make && make install

FROM debian:bookworm AS uade
COPY --from=uade-build /usr/local/bin/uade123 /usr/local/bin/
COPY --from=uade-build /usr/local/lib/libzakalwe.so /usr/local/lib/libzakalwe.so
COPY --from=uade-build /usr/local/lib/libbencodetools.so /usr/local/lib/libbencodetools.so
COPY --from=uade-build /usr/lib/x86_64-linux-gnu/libao.so.4 /usr/lib/x86_64-linux-gnu/
WORKDIR /usr/local/share/uade
COPY --from=uade-build /usr/local/share/uade /usr/local/share/uade
WORKDIR /usr/local/lib/uade/
COPY --from=uade-build /usr/local/lib/uade/ /usr/local/lib/uade/
RUN ln -s /usr/lib/x86_64-linux-gnu/libao.so.4 /usr/lib/x86_64-linux-gnu/libao.so
WORKDIR /root
