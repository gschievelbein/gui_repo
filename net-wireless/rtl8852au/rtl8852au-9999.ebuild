# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod linux-info

DESCRIPTION="Realtek USB driver RTL8852AU"
HOMEPAGE="https://github.com/lwfinger/rtl8852au"
EGIT_REPO_URI="https://github.com/lwfinger/rtl8852au"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

BUILD_TARGETS="clean modules" 
MODULE_NAMES="8852au(net/wireless:${S}"

pkg_pretend() {
	if [ ! linux_config_src_exists ]; then
		eerror "Kernel sources not found!"
		die
	fi

	linux-info_pkg_setup

	if [ ! linux_config_exists ]; then
		eerror "Kernel config file (.config) not found!"
		die
	elif  [ ! check_modules_supported ]; then
		eerror "This kernel does not support modules!"
		die
	fi
}

src_configure() {
	set_arch_to_kernel
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf
	fi
}

pkg_setup() {
	linux-mod_pkg_setup
}

src_compile(){
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_preinst() {
	return
}
