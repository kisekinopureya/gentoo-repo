# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib flag-o-matic

if [[ ${PV} == *9999 ]] ; then
	: ${EGIT_REPO_URI:="https://github.com/intel/media-driver"}
	if [[ ${PV%9999} != "" ]] ; then
		: ${EGIT_BRANCH:="release/${PV%.9999}"}
	fi
	inherit git-r3
else
	MY_PV="${PV%_pre}"
	SRC_URI="https://github.com/intel/media-driver/archive/intel-media-${MY_PV}.tar.gz"
	S="${WORKDIR}/media-driver-intel-media-${MY_PV}"
	if [[ ${PV} != *_pre* ]] ; then
		KEYWORDS="~amd64"
	fi
fi

DESCRIPTION="Intel Media Driver for VA-API (iHD)"
HOMEPAGE="https://github.com/intel/media-driver"

LICENSE="MIT BSD redistributable? ( no-source-code )"
SLOT="0"
IUSE="+redistributable test X video_cards_xe"

RESTRICT="!test? ( test )"

DEPEND=">=media-libs/gmmlib-22.3.14:=[${MULTILIB_USEDEP}]
	>=media-libs/libva-2.20.0[X?,${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

multilib_src_configure() {
	# https://github.com/intel/media-driver/issues/356
	append-cxxflags -D_FILE_OFFSET_BITS=64

	local mycmakeargs=(
		-DMEDIA_BUILD_FATAL_WARNINGS=OFF
		-DMEDIA_RUN_TEST_SUITE=$(usex test)
		-DBUILD_TYPE=Release
		-DPLATFORM=linux
		-DUSE_X11=$(usex X)
		-DENABLE_NONFREE_KERNELS=$(usex redistributable)
		-DLATEST_CPP_NEEDED=ON # Seems to be the best option for now
	)

	if use video_cards_xe; then
		ewarn "LIBVA_DRIVER_NAME=iHD variable is required for xe driver to work"
		mycmakeargs+=(
		-DENABLE_PRODUCTION_KMD=FALSE
		-DENABLE_NEW_KMD=TRUE
		-DGEN8=OFF
	)
	fi

	local CMAKE_BUILD_TYPE="Release"
	cmake_src_configure
}
