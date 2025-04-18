# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 & IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="https://bird.network.cz/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86 ~x64-macos"
IUSE="+client debug"

RDEPEND="client? ( sys-libs/ncurses )
	client? ( sys-libs/readline )"
DEPEND="app-alternatives/lex
	app-alternatives/yacc
	sys-devel/m4"

PATCHES=(
	"${FILESDIR}/${P}-gcc10.patch"
)

src_configure() {
	econf \
		--localstatedir="${EPREFIX}/var" \
		$(use_enable client) \
		$(use_enable debug)
}

src_install() {
	if use client; then
		dobin birdc
	fi
	dobin birdcl
	dosbin bird
	newinitd "${FILESDIR}/initd-${PN}-2" bird
	dodoc doc/bird.conf.example
}
