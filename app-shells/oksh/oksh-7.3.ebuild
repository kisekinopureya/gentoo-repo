# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Portable OpenBSD ksh, based on the Public Domain Korn Shell (pdksh)."
HOMEPAGE="https://github.com/ibara/oksh"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ibara/oksh.git"
	KEYWORDS=""
else
	SRC_URI="
		https://github.com/ibara/oksh/releases/download/oksh-${PV}/oksh-${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="-* ~amd64"
fi

LICENSE=""
SLOT="0"
IUSE="+curses ksh lto small static"

REQUIRED_USE="
	?? ( small curses )"

BDEPEND=""

DEPEND="
	curses? (
		sys-libs/ncurses
	)"

RDEPEND="${DEPEND}"

if ! [[ ${PV} == "9999" ]]; then
    S="${WORKDIR}"/oksh-${PV}
fi

src_unpack() {
    if [[ ${PV} == "9999" ]]; then
        git-r3_src_unpack
    fi
    default
}

src_configure() {
	econf \
		--cc=${CC} \
		--cflags=${CFLAGS} \
		$(use_enable curses) \
		$(use_enable ksh) \
		$(use_enable lto) \
		$(use_enable small) \
		$(use_enable static)
}

src_compile(){
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install
}
