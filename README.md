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
