Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E654784E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhLQG3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:29:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41543 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhLQG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:29:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFfGN2Hg3z4xd4;
        Fri, 17 Dec 2021 17:29:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639722579;
        bh=PyKtBzR8c50cKGocDdxfifUNGLAEUQhPnkXBDZyrg4w=;
        h=Date:From:To:Cc:Subject:From;
        b=bp5xB5rmc0ORNIz0UvkioJquiNJ5eOxSiEg896tMt5iWPiNXyzIRNJr7/ybSV0k6k
         uWEAJZMABdPPCnDeoBd7RYHvNmuJZ4t5ogcSz7w21AAcAzxkUEzQFGJDGAmJi0tpb0
         RcATTrCOtWOYN1aN/6bcJckk5TSJZqjT0X2IdEOgerdObeIkT9x/KjzVbeTwhu2DvA
         6CrUdSE2kaCcauEbYUhvxY/jdk54SHuh9mu0H6B0fsUgYfSxwP84b+6osxt9fBOtUk
         uIxN5BsIwOfOxZhPEu5Idm3R3bc8W/xhvtpycxZsoVXtDiLqYbxCTky28TqPS1yqKr
         CbPk3DXTxs8sg==
Date:   Fri, 17 Dec 2021 17:29:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Huan Feng <huan.feng@starfivetech.com>,
        Kiran Kumar S <kiran.kumar1.s@intel.com>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the arm-soc tree
Message-ID: <20211217172931.01c24d4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HD1C4JCz8G1vcelywszRg2x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HD1C4JCz8G1vcelywszRg2x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got conflicts in:

  drivers/pinctrl/Kconfig
  drivers/pinctrl/Makefile

between commit:

  ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")

from the arm-soc tree and commits:

  12422af8194d ("pinctrl: Add Intel Thunder Bay pinctrl driver")
  b124c8bd50c7 ("pinctrl: Sort Kconfig and Makefile entries alphabetically")

from the pinctrl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pinctrl/Kconfig
index 0d5b61e4c21e,c27c9ee89f0e..000000000000
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
diff --cc drivers/pinctrl/Makefile
index f5bdd6b209a6,6be6c3fc6663..000000000000
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@@ -30,26 -39,16 +39,17 @@@ obj-$(CONFIG_PINCTRL_OXNAS)	+=3D pinctrl-
  obj-$(CONFIG_PINCTRL_PALMAS)	+=3D pinctrl-palmas.o
  obj-$(CONFIG_PINCTRL_PIC32)	+=3D pinctrl-pic32.o
  obj-$(CONFIG_PINCTRL_PISTACHIO)	+=3D pinctrl-pistachio.o
+ obj-$(CONFIG_PINCTRL_RK805)	+=3D pinctrl-rk805.o
  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+=3D pinctrl-rockchip.o
  obj-$(CONFIG_PINCTRL_SINGLE)	+=3D pinctrl-single.o
- obj-$(CONFIG_PINCTRL_SX150X)	+=3D pinctrl-sx150x.o
- obj-$(CONFIG_ARCH_TEGRA)	+=3D tegra/
- obj-$(CONFIG_PINCTRL_XWAY)	+=3D pinctrl-xway.o
- obj-$(CONFIG_PINCTRL_LANTIQ)	+=3D pinctrl-lantiq.o
- obj-$(CONFIG_PINCTRL_LPC18XX)	+=3D pinctrl-lpc18xx.o
- obj-$(CONFIG_PINCTRL_TB10X)	+=3D pinctrl-tb10x.o
+ obj-$(CONFIG_PINCTRL_STMFX) 	+=3D pinctrl-stmfx.o
  obj-$(CONFIG_PINCTRL_ST) 	+=3D pinctrl-st.o
 +obj-$(CONFIG_PINCTRL_STARFIVE)	+=3D pinctrl-starfive.o
- obj-$(CONFIG_PINCTRL_STMFX) 	+=3D pinctrl-stmfx.o
- obj-$(CONFIG_PINCTRL_ZYNQ)	+=3D pinctrl-zynq.o
+ obj-$(CONFIG_PINCTRL_SX150X)	+=3D pinctrl-sx150x.o
+ obj-$(CONFIG_PINCTRL_TB10X)	+=3D pinctrl-tb10x.o
+ obj-$(CONFIG_PINCTRL_THUNDERBAY) +=3D pinctrl-thunderbay.o
  obj-$(CONFIG_PINCTRL_ZYNQMP)	+=3D pinctrl-zynqmp.o
- obj-$(CONFIG_PINCTRL_INGENIC)	+=3D pinctrl-ingenic.o
- obj-$(CONFIG_PINCTRL_RK805)	+=3D pinctrl-rk805.o
- obj-$(CONFIG_PINCTRL_OCELOT)	+=3D pinctrl-ocelot.o
- obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+=3D pinctrl-microchip-sgpio.o
- obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   +=3D pinctrl-equilibrium.o
- obj-$(CONFIG_PINCTRL_K210)	+=3D pinctrl-k210.o
- obj-$(CONFIG_PINCTRL_KEEMBAY)	+=3D pinctrl-keembay.o
+ obj-$(CONFIG_PINCTRL_ZYNQ)	+=3D pinctrl-zynq.o
 =20
  obj-y				+=3D actions/
  obj-$(CONFIG_ARCH_ASPEED)	+=3D aspeed/

--Sig_/HD1C4JCz8G1vcelywszRg2x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8LksACgkQAVBC80lX
0GxP6Qf/c1I1xsfjER99HnkzpIjmyBgjuRuszMG5rZEh39DOdOQJ8Nvz/wNTXDi0
qYO691MJMg7sg0OipR50Hsjrx1Mjy3mLxH6ausyuVAFQWdjME1zCKBCuvc636bdT
Tsz3Jejfb8EqBtAvQATBqiIYYboReheDefNuK6cPXof08Hx3I0QUw1SU+lldRpC4
j2L26Es8yWo7xP3RNdaNzTD+VcVAOv7+dcUtsLCz1ZYFbvbdNiNp8S6tzWduf96Z
wvNJeykTVwbj6T7MOHVRSxwrNlJxS9QimgDv5v1iR+SmL9di1cEWkv4YaKM0ET0G
h3N2i5+UiorRK9YIdOj+og0RAYItDA==
=cfYN
-----END PGP SIGNATURE-----

--Sig_/HD1C4JCz8G1vcelywszRg2x--
