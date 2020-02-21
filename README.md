## Archlinux Configurations

适用于基于Archlinux的发行版，多数可用`pacman`和`yay`/`yaourt`安装。其它发行版可自行寻找对应包名。

### Shell

#### Common
- [zsh](zsh.org)

    必备。安装`oh-my-zsh`，启用`zsh-syntax-highlight`和`fzf`插件。

- [vim](vim.org)

    编辑器。包管理：`vim-plug`。推荐插件：`coc`。

- [mutt](mutt.org)/[neomutt](neomutt.org)

    邮件。

- [tig](https://github.com/jonas/tig)

    `git`的cursors UI。

- [tmux](https://github.com/tmux/tmux)

    远程开发必备。参考`.tmux.conf`。

- [ripgrep](https://github.com/BurntSushi/ripgrep)

    `grep`替代品。Rust的速度值得信赖。

- [icdiff](https://github.com/jeffkaufman/icdiff)

    `diff`替代品。
    ```
    git config --global icdiff.options '--highlight --line-numbers'
    ```
- [lsd](https://github.com/jeffkaufman/icdiff)

    `ls`代替品。推荐搭配icon fonts使用。

- [most](http://www.jedsoft.org/most/index.html)

    `less`代替品。增强`man`体验。参考`.mostrc`设置vim键位。

- [bat](https://github.com/sharkdp/bat)

    `cat`代替品。带Code highlight。依赖`highlight`。

- [fzf](https://github.com/junegunn/fzf)

    搭配`oh-my-zsh`快速查找文件。

- [htop](https://github.com/hishamhm/htop)/[glances](https://github.com/nicolargo/glances)

    `top`代替品。

- [ranger](https://github.com/ranger/ranger)

    文件管理，参考`.config/ranger/rc.conf`启用图片预览。

- [mpd](https://www.musicpd.org/)

    音乐播放器。

- [tldr](https://github.com/tldr-pages/tldr)

    `man`懒人版本。

- [scrot](https://github.com/dreamer/scrot)/[screenfetch](https://github.com/KittyKatt/screenFetch)

    截屏(晒桌面)工具。

#### Development
- [cquery](https://github.com/cquery-project/cquery)/[ccls](https://github.com/MaskRay/ccls)

    C++的LSP，搭配`coc`使用。

- [ctags](http://ctags.sourceforge.net/)/[ptags](https://github.com/dalance/ptags)

    符号分析，搭配`gutentags`项目符号。参考`.vim-plugin-settings.vim`

- [bear](https://github.com/rizsotto/Bear)

    从makefile/cmake生成`compiler_flags`，搭配`coc`使用。

- [bash-language-server](https://github.com/mads-hartmann/bash-language-server)

    bash的LSP实现。`yarn`安装。

### Desktop

#### Management

- [i3](i3-wm.org)/[i3-gaps](https://github.com/Airblader/i3)

    主要WM。参考`.config/i3/`配置。

- [polybar](https://github.com/polybar/polybar)

    工具栏。参考`.config/polybar/`配置。依赖下述字体。

- [rofi](https://github.com/davatorium/rofi)

    启动器。参考`.config/rofi/`配置。

- [compton/picom](https://github.com/yshui/picom)

    Compositor。参考`.config/compton.conf`启用桌面特效。

- arandr/autorandr

    显示管理工具。

- acpid/systemd-logout/laptop\_mode/laptop-mode-tools/xfce4-power-manager/cpupower

    电源管理。

- [networkmanager](https://wiki.gnome.org/Projects/NetworkManager/)/networkmanager-applet

    网络管理。

- [pulseaudio](pulseaudio.org)

    音频管理。

- [libinput](libinput.org)/libinput-gestures

    触摸板管理。参考`.config/libinput-gestures.conf`管理手势。

- [feh](feh.org)/[nitrogen](https://github.com/l3ib/nitrogen)

    壁纸管理。

- [kvantum](https://github.com/tsujan/Kvantum)/qt5ct/lxappearance

    qt/gtk主题管理。

- gnome-settings-daemon

    某些wine应用依赖，如QQ。

- [dunst](dunst-project.org)

    桌面通知。参考`.config/dunst/dunstrc`配置。

#### Desktop softwares
- firefox/google-chrome

    浏览器。

- [fcitx](fcitx-im.org)/rime/anthy

    输入法框架。中文/日文输入法。推荐主题：`fcitx-skin-material`。

- [konsole](https://kde.org/applications/system/org.kde.konsole)

    终端，支持ligatures。

- [dolphin](https://kde.org/applications/system/org.kde.dolphin)

    文件管理。

- [typora](typora.io)

    Markdown文档工具。

- [netease-cloud-music](https://github.com/topics/netease-cloud-music)

    音乐。

- [vlc](vlc.org)

    视频。

- [viewnior](https://github.com/hellosiyan/Viewnior)

    图片。

- [mailspring](mailspring.com)

    邮件。

- [flameshot](flameshot.js.org)

    漂亮的截图工具。

#### Development

- [zeal](zealdocs.org)

    开发文档查询。备选： `devdocs.io`。

- visual-studio-code-bin

    备用开发。

#### Fonts

##### CJK
- noto-fonts-cjk

- wqy-microhei

##### Mono
- ttf-fira-code

    备选`cascadia-code`。支持ligatures。

- nerd-fonts-complete

    支持各种ICON fonts。

##### Icon Fonts
- otf-font-awesome

#### Icons
- arc-icon-theme
- qogir-icon-theme-git
- deepin-icon-thme

#### GTK/Qt themes
- qogir-kde-theme-git
- qogir-gtk-theme-git
- kvantum-theme-qogir-git
