Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536834C647A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiB1IOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB1IN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:13:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F37381B7;
        Mon, 28 Feb 2022 00:13:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6Y6P6QHMz4xcd;
        Mon, 28 Feb 2022 19:13:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646035998;
        bh=rVU/stliaEs+/Qz+lJRU+5I4Zqzz1PASdacjJ3qbeb4=;
        h=Date:From:To:Cc:Subject:From;
        b=C8v8KRwk0R3UHmxztpOrKAmyflMvgaWxfCf0Ftfq+lQ7caMigUH3QbhWnC+kgSxit
         ExKLK8ilqjWmRaAzbDSlTZTygS+Hzaad09vjbc5vXrQSKYVKMl5JSeyZahhQbGYHVB
         x6w6F3/QfZ1UoT7S8BK9sVIpS/qGlBmS2Jh75mrWvc0mROL6546tlIq3YfGsk1ehk+
         qyzrcsC2o4dbiPJIsOT/4wdKnQPATG+z0Gec8+uKDBL0rQe7KLkc+0+hhhBusrDcP5
         Im7xj3vnvVvUEjw6CB+VZaF/W7Wg6bx82VttG5bT4lt6UfC91kmSGw7ExQWYLU1UcJ
         4mOTeoK3DBB5w==
Date:   Mon, 28 Feb 2022 19:13:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the spi tree
Message-ID: <20220228191316.411f1475@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XtCa2FAP8W+ER=Wm7QCOYG5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XtCa2FAP8W+ER=Wm7QCOYG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  MAINTAINERS

between commit:

  f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")

from the spi tree and commits:

  b48b9f6deacf ("dt-bindings: serial: Add bindings doc for Sunplus SoC UART=
 Driver")
  9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")

from the tty tree.

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
index e6b3e94de842,4a30001f6d7b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -18635,13 -18549,12 +18642,19 @@@ S:	Maintaine
  F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
  F:	drivers/rtc/rtc-sunplus.c
 =20
 +SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 +M:	Li-hao Kuo <lhjeff911@gmail.com>
 +L:	linux-spi@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 +F:	drivers/spi/spi-sunplus-sp7021.c
 +
+ SUNPLUS UART DRIVER
+ M:	Hammer Hsieh <hammerh0314@gmail.com>
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+ F:	drivers/tty/serial/sunplus-uart.c
+=20
  SUPERH
  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
  M:	Rich Felker <dalias@libc.org>

--Sig_/XtCa2FAP8W+ER=Wm7QCOYG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIchBwACgkQAVBC80lX
0GwEDwf6A0oRhiKUJHcFl9jqkchDt4xT/xxHFSLY8UadKG2q5UEnXZYG1Rq4qtaQ
qtz7Z7c/ZhIyJaXKWsGiiTG9kWU7pIYUpl8nqSnnUDuC7jcw1bKGeM/C5uwZrqDl
dLZpZDxj9Uq+J5XwHEcB10etKdgKP2Tn4ve0qvrJhlTgdgkhKj60FVO9Sj++A5Nx
s5V5CJjdzKngVNcWWZZ/AGd2nD81kkX9azh98InWQkPll/2sSOmn+4yLaUAxKXkA
fCid/84Aeirk5MxjO6LTrwYZ8WBZxEdbfYyz+bzvuWjfbF+YObcr2Zjihyy6UX9+
zpmFYw21JuLPzvlXfGV6HyXFqnivzA==
=FWvl
-----END PGP SIGNATURE-----

--Sig_/XtCa2FAP8W+ER=Wm7QCOYG5--
