FROM lsiobase/kasmvnc:ubuntunoble

ARG ANKI_VERSION=25.07.2

RUN \
  apt-get update && \
  apt-get install -y wget zstd xdg-utils libxcb-xinerama0 libxcb-cursor0 libnss3 libxcb-icccm4 libxcb-keysyms1 libxkbcommon-x11-0 libatomic1 && \
  wget https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-linux.tar.zst && \
  tar --use-compress-program=unzstd -xvf anki-linux.tar.zst && \
  cd anki-launcher && ./install.sh &&  cd .. && \
  rm -rf anki-launcher anki-linux.tar.zst && \
  apt-get purge -y --auto-remove wget zstd && \
  apt-get clean
RUN \
  mkdir -p /config/.local/share/AnkiProgramFiles && \
  echo software >/config/.local/share/AnkiProgramFiles/gldriver6

COPY ./root /