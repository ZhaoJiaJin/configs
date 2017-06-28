#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

#if [ -f "$userresources" ]; then
#
#
#
#
#
#
#
#    xrdb -merge "$userresources"
#
#fi
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
#export XMODIFIERS="@im=fcitx"
#export QT_IM_MODULE=fcitx
#export GTK_IM_MODULE=fcitx

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx&
#ch_moni
#exec i3 
#ch_moni
#启用gnome的主题
gnome-settings-daemon &    
#电源管理程序
gnome-power-manager &      
#网络管理程序
nm-applet --sm-disable &                           
#自动更新程序
update-notifier &

exec awesome
