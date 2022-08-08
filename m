Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4358C9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiHHNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiHHNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:52:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA2DEC2;
        Mon,  8 Aug 2022 06:52:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 335EC1C0001; Mon,  8 Aug 2022 15:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659966722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ZJed1eg0BR3JFaZDVZSq8BNrfezpKyNl8ClpnC7ndWM=;
        b=eV2K0sDO4MbvF+WKr91/UOn58Gcym1/3jsssNgsPG3hNjW2vwMZ3HpBmSzuiT8TkY4W35D
        s+nIHY6JKSvqCtZIzbVbR2CXiQqSn4BcyjaLD8MNQkYesnW+gT3YrK2pCSBeM4eR6kAgD/
        kHZl36aP4bDohWc9oSjjhYUH8c+9Hjs=
Date:   Mon, 8 Aug 2022 15:52:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Subject: [GIT PULL] LEDs changes for v5.20-rc1
Message-ID: <20220808135201.GA22949@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/=
leds-5.20-rc1

for you to fetch changes up to 38ba0bb291aacd92d8eaa4a1aa8b63ce4286e797:

  leds: is31fl319x: use simple i2c probe function (2022-08-02 16:43:31 +020=
0)

----------------------------------------------------------------
LED updates for 5.20: new driver for bcm63138, is31fl319x updates,
fixups for multicolor. Clevo-mail driver got disabled, it needs API
fix.

----------------------------------------------------------------
Andy Shevchenko (4):
      leds: is31fl319x: Make use of device properties
      leds: is31fl319x: Make use of dev_err_probe()
      leds: is31fl319x: Fix devm vs. non-devm ordering
      leds: is31fl319x: use simple i2c probe function

Emil Renner Berthing (3):
      leds: pwm-multicolor: Don't show -EPROBE_DEFER as errors
      dt-bindings: leds: pwm-multicolor: Add active-low property
      leds: pwm-multicolor: Support active-low LEDs

Greg Kroah-Hartman (1):
      leds: turris-omnia: convert to use dev_groups

Krzysztof Kozlowski (3):
      dt-bindings: leds: class-multicolor: reference class directly in mult=
i-led node
      dt-bindings: leds: lp50xx: fix LED children names
      dt-bindings: leds: pwm-multicolor: document max-brigthness

Pavel Machek (1):
      leds: clevo-mail: Mark as broken pending interface fix

Rafa=C5=82 Mi=C5=82ecki (5):
      dt-bindings: leds: add Broadcom's BCM63138 controller
      leds: bcm63138: add support for BCM63138 controller
      dt-bindings: leds: leds-bcm63138: unify full stops in descriptions
      leds: add help info about BCM63138 module name
      leds: leds-bcm63138: get rid of LED_OFF

Randy Dunlap (1):
      leds: clevo-mail: fix Kconfig "its" grammar

Vincent Knecht (5):
      leds: is31fl319x: Add missing si-en compatibles
      leds: is31fl319x: Use non-wildcard names for vars, structs and defines
      leds: is31fl319x: Move chipset-specific values in chipdef struct
      leds: is31fl319x: Add support for is31fl319{0,1,3} chips
      leds: is31fl319x: Cleanup formatting and dev_dbg calls

 .../bindings/leds/cznic,turris-omnia-leds.yaml     |   2 +
 .../devicetree/bindings/leds/leds-bcm63138.yaml    |  95 ++++
 .../bindings/leds/leds-class-multicolor.yaml       |  32 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |  10 +-
 .../bindings/leds/leds-pwm-multicolor.yaml         |  15 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   2 +
 drivers/leds/Kconfig                               |  10 +-
 drivers/leds/blink/Kconfig                         |  14 +
 drivers/leds/blink/Makefile                        |   1 +
 drivers/leds/blink/leds-bcm63138.c                 | 307 ++++++++++++
 drivers/leds/leds-is31fl319x.c                     | 529 +++++++++++++----=
----
 drivers/leds/leds-turris-omnia.c                   |   4 +-
 drivers/leds/rgb/leds-pwm-multicolor.c             |   8 +-
 13 files changed, 811 insertions(+), 218 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-bcm63138.ya=
ml
 create mode 100644 drivers/leds/blink/leds-bcm63138.c

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvEVAQAKCRAw5/Bqldv6
8oE7AJ93lneTAVUA7FJRNPblZjCtJps6JwCfRXV65hBkErtzrJVyyptaF62Cfc8=
=lgHM
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
