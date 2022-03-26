Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA24E84AD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 00:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiCZXwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 19:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCZXwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 19:52:49 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C5E13;
        Sat, 26 Mar 2022 16:51:11 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6371C1C0BB0; Sun, 27 Mar 2022 00:51:09 +0100 (CET)
Date:   Sun, 27 Mar 2022 00:51:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Subject: [GIT PULL] LEDs changes for v5.18-rc1
Message-ID: <20220326235108.GA4456@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
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


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/=
leds-5.18-rc1

for you to fetch changes up to e26557a0aa68acfb705b51947b7c756401a1ab71:

  leds: pca955x: Allow zero LEDs to be specified (2022-03-02 09:51:40 +0100)

----------------------------------------------------------------
LED updates for 5.18-rc1. Nothing major here, there are two drivers
that need review and did not make it.

----------------------------------------------------------------
Andrew Jeffery (2):
      leds: pca955x: Make the gpiochip always expose all pins
      leds: pca955x: Allow zero LEDs to be specified

Andr=E9 Apitzsch (2):
      dt-bindings: vendor-prefixes: Add ocs prefix
      leds: sgm3140: Add ocs,ocp8110 compatible

Hans de Goede (2):
      leds: simatic-ipc-leds: Make simatic_ipc_led_mem_res static
      leds: simatic-ipc-leds: Don't directly deref ioremap_resource() retur=
ned ptr

Krzysztof Kozlowski (1):
      dt-bindings: leds: common: fix unit address in max77693 example

Uwe Kleine-K=F6nig (1):
      leds: lm3692x: Return 0 from remove callback

 Documentation/devicetree/bindings/leds/common.yaml |  9 ++-
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 drivers/leds/flash/leds-sgm3140.c                  |  1 +
 drivers/leds/leds-lm3692x.c                        |  5 +-
 drivers/leds/leds-pca955x.c                        | 67 +++++++++++-------=
----
 drivers/leds/simple/simatic-ipc-leds.c             | 34 ++++++-----
 6 files changed, 65 insertions(+), 53 deletions(-)

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYj+m7AAKCRAw5/Bqldv6
8lehAJ9M/Ba9JIj+fa2Sdovh06xaN60jxwCeP6p5m0OSkx3IAPL4e6CZDXuFAVg=
=Zb1J
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
