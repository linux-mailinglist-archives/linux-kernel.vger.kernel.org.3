Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825F5397BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbiEaUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:06:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800669B76;
        Tue, 31 May 2022 13:06:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 913131C0B82; Tue, 31 May 2022 22:06:19 +0200 (CEST)
Date:   Tue, 31 May 2022 22:06:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Subject: [GIT PULL] LEDs changes for v5.19-rc1
Message-ID: <20220531200619.GA8906@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/=
leds-5.19-rc1

for you to fetch changes up to e98a860f65428a3cae7ed7b3e8ebcf6320d7fc5e:

  leds: qcom-lpg: Require pattern to follow documentation (2022-05-24 22:08=
:10 +0200)

----------------------------------------------------------------
LED updates for 5.19. Most significant here is driver for Qualcomm
LPG. Apparently it drives backlight on some boards, so it is quite
important for some people.

----------------------------------------------------------------
Bjorn Andersson (3):
      dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
      leds: Add driver for Qualcomm LPG
      leds: qcom-lpg: Require pattern to follow documentation

Johan Hovold (1):
      leds: qcom-lpg: add missing PWM dependency

Linus Walleij (3):
      dt-bindings: leds: Add regulator-led binding
      leds: regulator: Add dev helper variable
      leds: regulator: Make probeable from device tree

Markuss Broks (3):
      leds: ktd2692: Avoid duplicate error messages on probe deferral
      dt-bindings: leds: convert ktd2692 bindings to yaml
      leds: ktd2692: Make aux-gpios optional

Satya Priya (2):
      dt-bindings: leds: Add pm8350c pmic support
      leds: Add pm8350c support to Qualcomm LPG driver

Sven Schwermer (4):
      dt-bindings: leds: Optional multi-led unit address
      dt-bindings: leds: Add multicolor PWM LED bindings
      leds: Add PWM multicolor driver
      leds: Move pwm-multicolor driver into rgb directory

Uwe Kleine-K=F6nig (3):
      leds: pca9532: Make pca9532_destroy_devices() return void
      leds: is31fl32xx: Improve error reporting in .remove()
      leds: lp50xx: Remove duplicated error reporting in .remove()

 .../devicetree/bindings/leds/kinetic,ktd2692.yaml  |   87 ++
 .../bindings/leds/leds-class-multicolor.yaml       |    2 +-
 .../devicetree/bindings/leds/leds-ktd2692.txt      |   50 -
 .../bindings/leds/leds-pwm-multicolor.yaml         |   79 ++
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |  174 +++
 .../devicetree/bindings/leds/regulator-led.yaml    |   55 +
 Documentation/leds/leds-qcom-lpg.rst               |   78 ++
 drivers/leds/Kconfig                               |    3 +
 drivers/leds/Makefile                              |    3 +
 drivers/leds/flash/leds-ktd2692.c                  |   15 +-
 drivers/leds/leds-is31fl32xx.c                     |    8 +-
 drivers/leds/leds-lp50xx.c                         |    4 +-
 drivers/leds/leds-pca9532.c                        |   11 +-
 drivers/leds/leds-regulator.c                      |   47 +-
 drivers/leds/rgb/Kconfig                           |   29 +
 drivers/leds/rgb/Makefile                          |    4 +
 drivers/leds/rgb/leds-pwm-multicolor.c             |  186 +++
 drivers/leds/rgb/leds-qcom-lpg.c                   | 1451 ++++++++++++++++=
++++
 18 files changed, 2193 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multico=
lor.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/leds/regulator-led.ya=
ml
 create mode 100644 Documentation/leds/leds-qcom-lpg.rst
 create mode 100644 drivers/leds/rgb/Kconfig
 create mode 100644 drivers/leds/rgb/Makefile
 create mode 100644 drivers/leds/rgb/leds-pwm-multicolor.c
 create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpZ1OwAKCRAw5/Bqldv6
8kiMAJ0a5+dol+qNge3qehwHte/82RC65ACcCC28orvjHM1NNHDcod6ozzTEB3Q=
=NHEq
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
