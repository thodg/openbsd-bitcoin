# $OpenBSD: $

COMMENT =	Peer to peer money system

VER =		0.16.0
DISTNAME =	v${VER}
PKGNAME =	bitcoin-${VER}
CATEGORIES =	coin
MASTER_SITES =	https://github.com/bitcoin/bitcoin/archive/
EXTRACT_SUFX =	.tar.gz

HOMEPAGE =	https://github.com/bitcoin/bitcoin/

MAINTAINER =	Thomas de Grivel <thoxdg@gmail.com>

# MIT
PERMIT_PACKAGE_CDROM =	Yes

WANTLIB += ${COMPILER_LIBCXX} event m

COMPILER = base-clang ports-gcc

LIB_DEPENDS =	devel/gettext \
		devel/startup-notification \
		graphics/gdk-pixbuf2

FAKE_FLAGS =	INSTALL_DATA="${INSTALL_DATA}" \
		INSTALL_PROGRAM="${INSTALL_PROGRAM}"

CONFIGURE_STYLE =	gnu
CONFIGURE_ARGS =	--enable-256-color \
			--enable-perl \
			--enable-pixbuf \
			--enable-startup-notification \
			--enable-unicode3 \
			--enable-utmp \
			--enable-wtmp
CONFIGURE_ENV +=	CPPFLAGS="-I${X11BASE}/include" \
			pt_cv_tty_group=yes

.include <bsd.port.mk>
