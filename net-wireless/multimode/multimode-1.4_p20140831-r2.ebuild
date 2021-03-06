# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="multimode radio decoder for rtl-sdr devices using gnuradio"
HOMEPAGE="https://www.cgran.org/browser/projects/multimode/trunk"

LICENSE="BSD"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://www.cgran.org/svn/projects/multimode/trunk"
	inherit subversion
else
	#SRC_URI="http://www.sbrac.org/files/${PN}-r${PV}.tar.gz"
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

DEPEND="${PYTHON_DEPS}
	>=net-wireless/gnuradio-3.7:=[grc,utils,${PYTHON_SINGLE_USEDEP}]
	>=net-wireless/gr-osmosdr-0.1.0:="
RDEPEND="${DEPEND}"

src_compile() {
	PYTHONPATH="${S}":"${PYTHONPATH}" emake
}

src_install() {
	newbin ${PN}.py ${PN}
	python_domodule ${PN}_helper.py
	insinto /usr/share/${PN}
	doins ${PN}.grc
	python_fix_shebang "${ED}"/usr/bin
}
