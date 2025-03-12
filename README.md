## Setup
### on the kiosk machine
1. Install prerequisites
`sudo apt-get install rsync git vim unclutter xdotool`
> Note
> 
> `rsync` for manual deployment
> 
> `git` `vim` for personal set up preferences (optional)
> 
> `unclutter` to hide the cursor when it's not used
>
> `xdotool` to hit `F5` regularly on the opened chromium tabs so they are staying fresh
1. Install `i3` wm
```
sudo apt install i3
```
1. Switch to `i3`
set window manager
`sudo update-alternatives --config x-window-manager`
set lightdm `autologin-user-session=i3` in `/etc/lightdm/lightdm.conf`

1. disable screen blanking
`sudo raspi-config` -> `Display Options` -> `Screen Blanking` -> `disable`

1. Setup cron job for `reload.sh` every 1 minute to refresh all chromium windows
   `crontab -e

### on your machine
1. configure your setup in `src/env.sh`
2. (optional) setup public-key login with `ssh-copy-id` for easier deployment
3. (optional) Edit the config `vim src/launch.sh`
4. Change urls you want to display
   `cp config.example.sh src/config.sh`
5. (optional) Setup script for dynamically updating the config
   `cp update_config.example.sh src/update_config.sh`
6. (optional) Setup script for dynamically updating the layouts
   `cp update_layouts.example.sh src/update_layouts.sh`
7. Deploy the config `./deploy.sh`


### Extensions

* `uBlock` for ad removal
* `Cookie Monster` for auto declining cookie banners

### Troubleshooting

Accessing a logged in user session's i3

* get all windows' classes
`i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) -t get_tree | jq -r '.. | objects | select(.window_properties != null) | "\"\(.window_properties.class)\""'`

* get layout of workspace 1
`i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) -t get_tree | jq '.. | objects | select(.name == "1") | {name, layout, nodes, windows}'`

* restart i3
`i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) restart`