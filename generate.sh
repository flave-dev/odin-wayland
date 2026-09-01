#!/usr/bin/env sh

odin run scanner -- -input:scanner/protocols/wayland.xml
# wlr
# NOTE: layer_surface_v1.get_popup takes an xdg_popup object which lives in the
# xdg package. The scanner cannot qualify cross-package refs, so patch it below.
odin run scanner -- -input:scanner/protocols/wlr-layer-shell-unstable-v1.xml -output:wlr/layer-shell-unstable-v1.odin -package-name:wlr
perl -0pi -e 's/&popup_interface,/&xdg.popup_interface,/; s/\^popup\)/\^xdg.popup)/; s/import wl "\.\."/import wl ".."\nimport xdg "..\/xdg"/' wlr/layer-shell-unstable-v1.odin
# wp
# linux-dmabuf emits the shared libwayland re-exports for the wp package
odin run scanner -- -input:scanner/protocols/linux-dmabuf-v1.xml -output:wp/linux-dmabuf-v1.odin -package-name:wp
odin run scanner -- -input:scanner/protocols/presentation-time.xml -output:wp/presentation-time.odin -package-name:wp -dont-emit-libwayland
odin run scanner -- -input:scanner/protocols/tablet-v2.xml -output:wp/tablet-v2.odin -package-name:wp -dont-emit-libwayland
odin run scanner -- -input:scanner/protocols/viewporter.xml -output:wp/viewporter.odin -package-name:wp -dont-emit-libwayland
# xdg
# xdg-shell emits the shared libwayland re-exports for the xdg package
odin run scanner -- -input:scanner/protocols/xdg-shell.xml -output:xdg/shell.odin -package-name:xdg
odin run scanner -- -input:scanner/protocols/xdg-decoration-unstable-v1.xml -output:xdg/decoration-unstable-v1.odin -package-name:xdg -dont-emit-libwayland
# xx
odin run scanner -- -input:./scanner/protocols/xx-text-input-v3.xml -output:xx/text-input-v3.odin -package-name:xx
