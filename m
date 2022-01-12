Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523048CB36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356406AbiALSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:46:18 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:32796 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344055AbiALSqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:46:14 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C8BE81C0B76; Wed, 12 Jan 2022 19:46:11 +0100 (CET)
Date:   Wed, 12 Jan 2022 19:46:11 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Subject: [GIT PULL] LEDs changes for v5.17-rc1
Message-ID: <20220112184611.GA2187@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/=
leds-5.17-rc1

for you to fetch changes up to 9e87a8da747bf72365abb79e6f64fcca955b4f56:

  leds: lp55xx: initialise output direction from dts (2022-01-12 19:43:15 +=
0100)

----------------------------------------------------------------
LED updates for 5.17. Nothing major is happening here.

I had to rebase at last moment to fix wrong author of one
commit. Sorry about that.

----------------------------------------------------------------
Andy Shevchenko (2):
      leds: tca6507: Get rid of duplicate of_node assignment
      leds: lgm-sso: Get rid of duplicate of_node assignment

ChiYuan Huang (1):
      dt-bindings: leds: Replace moonlight with indicator in mt6360 example

Gene Chen (2):
      dt-bindings: leds: Add bindings for MT6360 LED
      leds: Add mt6360 driver

Lad Prabhakar (1):
      leds: ktd2692: Drop calling dev_of_node() in ktd2692_parse_dt

Linus Walleij (1):
      leds: leds-fsg: Drop FSG3 LED driver

Merlijn Wajer (1):
      leds: lp55xx: initialise output direction from dts

Sander Vanheule (1):
      leds: led-core: Update fwnode with device_set_node

Sicelo A. Mhlongo (1):
      ARM: dts: omap3-n900: Fix lp5523 for multi color

Sven Schuchmann (1):
      leds: lp50xx: remove unused variable

Yihao Han (1):
      leds: tca6507: use swap() to make code cleaner

 .../devicetree/bindings/leds/leds-mt6360.yaml      | 159 ++++
 arch/arm/boot/dts/omap3-n900.dts                   |  50 +-
 drivers/leds/Kconfig                               |   7 -
 drivers/leds/Makefile                              |   1 -
 drivers/leds/blink/leds-lgm-sso.c                  |   1 -
 drivers/leds/flash/Kconfig                         |  13 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-ktd2692.c                  |   2 +-
 drivers/leds/flash/leds-mt6360.c                   | 910 +++++++++++++++++=
++++
 drivers/leds/led-class.c                           |   6 +-
 drivers/leds/leds-fsg.c                            | 193 -----
 drivers/leds/leds-lp50xx.c                         |   1 -
 drivers/leds/leds-lp55xx-common.c                  |   4 +-
 drivers/leds/leds-tca6507.c                        |   7 +-
 14 files changed, 1130 insertions(+), 225 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6360.yaml
 create mode 100644 drivers/leds/flash/leds-mt6360.c
 delete mode 100644 drivers/leds/leds-fsg.c

--=20
http://www.livejournal.com/~pavelmachek

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYd8h8wAKCRAw5/Bqldv6
8pGQAKCAJya68vaZeC+zqTHeKZZV04f2/wCgwGbjyhj4BXOV2MQRmzNJC3ktCZo=
=BDMv
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
