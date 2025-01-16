#!/bin/bash

i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) workspace next
