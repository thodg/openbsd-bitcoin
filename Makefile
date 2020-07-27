# $OpenBSD: $

COMMENT =	Peer to peer money system

VER =		0.20.0
DISTNAME =	bitcoin-${VER}
PKGNAME =	bitcoin-${VER}
CATEGORIES =	coin
MASTER_SITES =	https://bitcoincore.org/bin/bitcoin-core-${VER}/
EXTRACT_SUFX =	.tar.gz

SHARED_LIBS+=	bitcoinconsensus	  0.0
SHARED_LIBS+=	secp256k1		  0.0
SHARED_LIBS+=	univalue		100.3

HOMEPAGE =	https://github.com/bitcoin/bitcoin/

MAINTAINER =	Thomas de Grivel <thoxdg@gmail.com>

# MIT
PERMIT_PACKAGE =	Yes

LIB_DEPENDS+=	coin/db48
LIB_DEPENDS+=	devel/boost
WANTLIB += ${COMPILER_LIBCXX} event m
WANTLIB += boost_system-mt boost_filesystem-mt boost_program_options-mt
WANTLIB += boost_thread-mt boost_chrono-mt
WANTLIB += ssl crypto

LIB_DEPENDS+=	coin/db48

COMPILER = base-clang

CONFIGURE_STYLE =	gnu

CONFIGURE_ARGS =	--with-unsupported-ssl \
			CXXFLAGS="-O2 -pipe -I/usr/local/include/db4.8 -I/usr/local/include" \
			LIBS="-L/usr/local/lib/db4.8 -ldb_cxx-4.8 -L/usr/X11R6/lib" \
			CC=cc CXX=c++ MAKE=gmake

MAKE_ENV =		AUTOCONF_VERSION=2.69 \
			AUTOMAKE_VERSION=1.16

USE_GMAKE = Yes

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

pre-install:
	cd ${WRKSRC}/src/secp256k1 && gmake install
	cd ${WRKSRC}/src/univalue && gmake install

.include <bsd.port.mk>
