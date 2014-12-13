# Copyright 2014-2014 GenVUU Syndicate
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="GenVUU baseconf and portage hooks"
HOMEPAGE="http://genvuu.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	sys-apps/sed
	dev-perl/rename"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	mkdir -p "${ED}/etc/portage"
	cat <<- EOF > "${ED}"/etc/portage/bashrc
	post_src_install() {
		if [ ! "\${PN}" = "genvuu-baseconf" ]; then
			einfo "Patching installed files..."
			find "${ED-$D}" -type f -exec sed -i -e 's/gentoo/GenVUU/Ig' "{}" \;
			find "${ED-$D}" -iname "*gentoo*" -depth -execdir perl-rename 's/gentoo/GenVUU/g' {} +
		fi
	}
	EOF
}
