Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF756D78A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGKIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGKIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:14:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58013F46;
        Mon, 11 Jul 2022 01:14:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhGrK2MPwz4xbn;
        Mon, 11 Jul 2022 18:14:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657527266;
        bh=h+M4Jcz3tcEssYonG7T7apPq9JSRl1tVYCyueBu9jkw=;
        h=Date:From:To:Cc:Subject:From;
        b=qhiBd0dOxF+c3g6GKDSUuFXHSb5ZZG7Mem9THLspP5WD1/CfVWSj+4DM0OReU7u/P
         hDTRi1zOqwIZZ58Z6/ZFaOeueruoQPlP2mgUxTjBjeV2R1I9WiCDWu23rKoBPQuOz8
         vIGHnAtryfWaUH5rwraQbcDamUiN6zjoYVIeKWVldgCcBbt0/O4VKN5+EON26coUEd
         PjfpTNwGQNfQYxaPGIW9vcapv63QaVfcZJ8pznXFwP8v6wSzHt0RZiM+mazdNJslmj
         gJ8VLF0oHRPfDrVPn6sqVQ6gM/l8eTtsJesLBdVBNvFmIsi6t5HGLStZoaXH01qqKQ
         IzOoXmHKsFVtQ==
Date:   Mon, 11 Jul 2022 18:14:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rtc tree with the arm-soc-fixes
 tree
Message-ID: <20220711181424.70195b52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X9DcZDdyUOHWlvTL.w1xqt5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X9DcZDdyUOHWlvTL.w1xqt5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rtc tree got a conflict in:

  MAINTAINERS

between commit:

  2058dc831ff8 ("MAINTAINERS: add polarfire rng, pci and clock drivers")

from the arm-soc-fixes tree and commit:

  1bdb08c180e8 ("MAINTAINERS: add PolarFire SoC's RTC")

from the rtc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 2f618be2906f,69a960561e37..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -17443,13 -17141,9 +17443,14 @@@ M:	Daire McNamara <daire.mcnamara@micro
  L:	linux-riscv@lists.infradead.org
  S:	Supported
  F:	arch/riscv/boot/dts/microchip/
 +F:	drivers/char/hw_random/mpfs-rng.c
 +F:	drivers/clk/microchip/clk-mpfs.c
  F:	drivers/mailbox/mailbox-mpfs.c
 +F:	drivers/pci/controller/pcie-microchip-host.c
+ F:	drivers/rtc/rtc-mpfs.c
  F:	drivers/soc/microchip/
 +F:	drivers/spi/spi-microchip-core.c
 +F:	drivers/usb/musb/mpfs.c
  F:	include/soc/microchip/mpfs.h
 =20
  RNBD BLOCK DRIVERS

--Sig_/X9DcZDdyUOHWlvTL.w1xqt5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLL2+AACgkQAVBC80lX
0GxfIQgAoVgli0HBZGny4OhVRSX4257QV2bJyb/+xI9UjpQEUTVo/rnazskKZHgf
rykQetoq3tpP7n04+4s/YrGgg0RibsNS504E/Lk+30dnxN4S63275ZG0lWtIyhmM
NEqNaKEHYh4ZdyIV/i+v1rcyldccT6RzF9A6BjSX0/vsdOgP/+8hOJnJ8CX9WFYI
2HHxVu5BfaRwxhPyv+SxS70sGMbiFee7yCv45wRSH5nup1VPDDXekzijdqBzdSQ3
2llgsGx+ixAMJPb5dB9AmwZ13EuWZ9A99qLs2Z3SmoJtLRTy+oXRFTRZK3TfoCzw
TMWNq47erOa0sInGgnXl/N2SPq0QFg==
=yPvP
-----END PGP SIGNATURE-----

--Sig_/X9DcZDdyUOHWlvTL.w1xqt5--
