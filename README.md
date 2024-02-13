# My Personal Gentoo Linux Repository

This overlay contains:

- Ebuilds for new xe driver [^1]
    - dev-libs/intel-compute-runtime
    - media-libs/mesa
    - media-libs/libva-intel-media-driver

- Yuzu and dependencies
    - games-emulation/yuzu
    - dev-libs/xbyak
    - dev-libs/vulkan-memory-allocator

- oksh
- MangoHud
- gamescope-session and gamescope-session-steam


### Installation
  - Create a new file `/etc/portage/repos.conf/kisekinopureya.conf` with the following contents:
```
[kisekinopureya]
sync-uri = git://git.kisekinopureya.info/gentoo-repo.git
sync-type = git
location = /var/db/repos/kisekinopureya
sync-depth = 1
```
  - Sync this new repo using `emaint sync -r kisekinopureya` or `emerge --sync kisekinopureya`

[^1]: To enable Xe support, set VIDEO_CARDS="intel xe" on /etc/portage/make.conf
