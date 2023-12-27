#! /bin/bash

apt-get install -y ruby
gem install fpm && fpm --version

version=${{steps.<step-id>.outputs.tag_name}}

fpm \
  -s dir -t deb \
  -p LeoCAD-${version}-1-amd64.deb \
  --name LeoCAD \
  --license agpl3 \
  --version ${version} \
  --architecture amd64 \
  --depends bash --depends libfuse2 \
  --description "A CAD application for creating virtual LEGO models." \
  --url "https://www.leocad.org/" \
  --maintainer "debilin <croninlucio@gmail.com>" \
  --after-install ./afterinstall.sh \
    ./${{ fromJson(steps.<step-id>.outputs.downloaded_files)[0] }}=/usr/local/bin/leocad