# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Steam Big Picture Mode session based on Valve's gamescope"
HOMEPAGE="https://github.com/ChimeraOS/gamescope-session-steam"

inherit git-r3
EGIT_REPO_URI="https://github.com/ChimeraOS/gamescope-session-steam.git"
KEYWORDS="-* ~amd64"

LICENSE="MIT"
SLOT="0"
IUSE=""

REQUIRED_USE=""

BDEPEND=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	default
}

src_install() {
	cp -r "${WORKDIR}"/"${P}"/usr "${D}"/usr || die
}

pkg_postinst() {
	einfo ""
	einfo "If mangohud can't get GPU load, or other GPU information,"
	einfo "and you have an older Nvidia device."
	einfo ""
	einfo "Try enabling the 'xnvctrl' useflag."
	einfo ""
}
