#!/usr/bin/env sh

# TODO: uncomment this after Yagna 0.13 upgrade
# echo ">>> Running pre-install script"
# ya-provider pre-install

echo ">>> Importing resources"
golemsp manifest-bundle add /usr/lib/yagna/installer/

echo ">>> Starting Golem"
exec golemsp run
