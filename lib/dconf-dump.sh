#!/bin/sh
# dump-dconf.sh --- dump dconf database near the db itself

filter="session-start
geometry
window-position
window-ratio
command-history
check-timestamp
last-panel
application-id
virtual-root
extension-cache-updated
refresh-last-run
history-search-for
installed-apps
document-directory
selected-files
current-folder
window-size
maximized
last-viewed-location
transportation-type
window-maximized
sidebar-width
sidebar-size
save-directory
show-hidden-files
size
state
window-state
window-height
window-width
device-aliases
numlock-state
volume
volume-sound-enabled
num-workspaces
location-mode
last-node-selected
last-window-state
saved-view
selected-color
custom-colors
last-active-tool
last-right-rgba
last-size
last-left-rgba
current-tab
window-pane-position"

/usr/bin/dconf dump / \
    | grep -Ev "^($(echo $filter | tr ' ' '|'))=" \
           > $HOME/cf/lib/dconf.dump
