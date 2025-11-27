# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="CMake language server"
HOMEPAGE="
https://github.com/regen100/cmake-language-server
https://pypi.org/project/cmake-language-server/
"
SRC_URI="https://codeload.github.com/regen100/cmake-language-server/tar.gz/refs/tags/v${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="
	>=dev-python/pygls-1.1.1[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-7.2.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-datadir-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-4.0.0[${PYTHON_USEDEP}]
		>=dev-util/cmakelang-0.6.13[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/pdm-backend[${PYTHON_USEDEP}]
	dev-python/pdm[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_compile() {
	export PDM_BUILD_SCM_VERSION="${PV}"
	distutils-r1_src_compile
}

src_install() {
	export DISTUTILS_SKIP_PYTHON_WRAPPER=1
	distutils-r1_src_install
}

python_test() {
	epytest tests
}
