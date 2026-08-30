#!/usr/bin/env sh

odin run scanner -- -input:scanner/protocols/wayland.xml
# wlr
odin run scanner -- -input:scanner/protocols/wlr-layer-shell-unstable-v1.xml -output:wlr/layer-shell-unstable-v1.odin -package-name:wlr
# wp
odin run scanner -- -input:scanner/protocols/linux-dmabuf-v1.xml -output:wp/linux-dmabuf-v1.odin -package-name:wp
odin run scanner -- -input:scanner/protocols/presentation-time.xml -output:wp/presentation-time.odin -package-name:wp
odin run scanner -- -input:scanner/protocols/tablet-v2.xml -output:wp/tablet-v2.odin -package-name:wp
odin run scanner -- -input:scanner/protocols/viewporter.xml -output:wp/viewporter.odin -package-name:wp
# xdg
odin run scanner -- -input:scanner/protocols/xdg-decoration-unstable-v1.xml -output:xdg/decoration-unstable-v1.odin -package-name:xdg
odin run scanner -- -input:scanner/protocols/xdg-shell.xml -output:xdg/shell.odin -package-name:xdg
# xx
odin run scanner -- -input:./scanner/protocols/xx-text-input-v3.xml -output:xx/text-input-v3.odin -package-name:xx
