# $OpenBSD: $

COMMENT =	Peer to peer money system

VER =		0.16.1
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
PERMIT_PACKAGE_CDROM =	Yes

WANTLIB += ${COMPILER_LIBCXX} event m
BUILD_DEPENDS+=	coin/db48

COMPILER = ports-gcc

CONFIGURE_STYLE =	gnu

CONFIGURE_ARGS =	--with-gui=no \
			--with-unsupported-ssl \
			CXXFLAGS="-O2 -pipe -I/usr/local/include/db4.8 -I/usr/local/include" \
			LIBS="-L/usr/local/lib/db4.8 -ldb_cxx-4.8" \
			CC=egcc CXX=eg++

MAKE_ENV =		AUTOCONF_VERSION=2.69 \
			AUTOMAKE_VERSION=1.15

USE_GMAKE = Yes

post-install:
	cd ${WRKSRC}/src/secp256k1 && make install
	cd ${WRKSRC}/src/univalue && make install

.include <bsd.port.mk>
