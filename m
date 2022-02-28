Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353D4C64E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiB1IhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiB1IhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:37:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BE66200;
        Mon, 28 Feb 2022 00:36:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6YdB4rdwz4xcq;
        Mon, 28 Feb 2022 19:36:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646037391;
        bh=o9XiM/fNYl1/X2wj9pS/S8olSHtadAELkZb/1vzMIg0=;
        h=Date:From:To:Cc:Subject:From;
        b=Kk7ww8d/UD/aB0CZpdFda/ex6kPHgC6GTIh74rGu7pWVtIg/B+6LE/0w35S9RXlAD
         7LmNHSSLbQ+XOOnW1ewHWdPu1M+dryMQ2lTZygGWVty0rHf+fYIr1KNZDMFHptmfjq
         T6G1g8aI+McqApTT5jMbf2nw5AkJyEIU4osGlrUxHX/Lbv0buA+LzdMWlmC5WMEccP
         v26Uf08c5f4LLqvJk7dKFR+LcAWEJmlLJkzbIdeeahpgJmQIJwvgPlKf5wj4rF/M3n
         luu8jOdYkVknjU18gmaJ7qxE5+LyGsX1gd56f4ZvyhkX1J036ZsSmtFmrT8j+xyVez
         EqvL0wQIKoKkQ==
Date:   Mon, 28 Feb 2022 19:36:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: linux-next: manual merge of the char-misc tree with the spi and tty
 trees
Message-ID: <20220228193630.2e079d89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sNSaGWJL.9iTObOrPWLLF/X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sNSaGWJL.9iTObOrPWLLF/X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  MAINTAINERS

between commits:

  f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
  b48b9f6deacf ("dt-bindings: serial: Add bindings doc for Sunplus SoC UART=
 Driver")
  9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")

from the spi and tty trees and commits:

  9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
  8fb29b450182 ("dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP dri=
ver")

from the char-misc tree.

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
index d1e56ec04e14,37ea1436fc62..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -18642,19 -18578,12 +18678,25 @@@ S:	Maintaine
  F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
  F:	drivers/rtc/rtc-sunplus.c
 =20
+ SUNPLUS OCOTP DRIVER
+ M:	Vincent Shih <vincent.sunplus@gmail.com>
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+ F:	drivers/nvmem/sunplus-ocotp.c
+=20
 +SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 +M:	Li-hao Kuo <lhjeff911@gmail.com>
 +L:	linux-spi@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 +F:	drivers/spi/spi-sunplus-sp7021.c
 +
 +SUNPLUS UART DRIVER
 +M:	Hammer Hsieh <hammerh0314@gmail.com>
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 +F:	drivers/tty/serial/sunplus-uart.c
 +
  SUPERH
  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
  M:	Rich Felker <dalias@libc.org>

--Sig_/sNSaGWJL.9iTObOrPWLLF/X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIciY4ACgkQAVBC80lX
0Gx7BAgAlKzxcIFXzATxZb/KksQOrxcHqxRi+f8AMckNrns6dsjjNTjPEIx/KmRm
b9tj0CLh1+22ECRQvISSHHAwoNltauqjpMTe5VW4rrHgEgRYEDn2ZL/U1u49ymMi
td7vLld++kht5TC/+tzvn6at3O0khd75YtOEL7Y+tufvJpfIUTsUuAYVH2C4tIhg
N//tvzxNJ15uqI7ikaQJaq38941YivWkvo4xYHNrEl6DlirXtF+i+v4ef99jWplw
goPSxwvoFyZIEUxNfptctIxz2y6if2eEeqM4c/DRfP3hdO3Mx7PeO5R4TzjDsvMO
bsdJA85pJvMjkjO7vG0uYwZMRw7hzg==
=wBWw
-----END PGP SIGNATURE-----

--Sig_/sNSaGWJL.9iTObOrPWLLF/X--
