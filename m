Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0F55724D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiFWEuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiFWDnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:43:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496811A08;
        Wed, 22 Jun 2022 20:43:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LT5gT2f72z4xYL;
        Thu, 23 Jun 2022 13:43:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655955781;
        bh=0Iy4OEIOAU8zNkxPzQHF1oZRYaY+Gs5GZUVJpOQqm6U=;
        h=Date:From:To:Cc:Subject:From;
        b=ljmLcDfgNKT7tCXEBhGwtXtk9yyYQL74Hzrdh9wPpXDUQ416zvWnd3y8nNZhT89L4
         Scm1DNEakRlhCeFuYMh9aLH0DGmgopyCOuDFkAw7Z9BEjFMd9gAeQSjNtbF2N7U1q6
         5mQW0C8ExfJDLRVydjBNwF//EQzF//s+PTEZpUTGR87izG9T0HcrSDidpxGTEuexZa
         u/CdCe2/OFDku+YaC5HVUqBRiLqTTqYERXMumxgYZc/W3K6SIpaaPfO5mV5noQ1Bdt
         +feu50jjzFpOAaL/o1O57pxD9XA8R+5sbgxETbLi8BTsn6XIeZF3/YDDZ+GpHiKzDg
         GGdRz4WVFlDow==
Date:   Thu, 23 Jun 2022 13:42:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the spi tree
Message-ID: <20220623134259.03af40f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E/VbeL2eq.0rP8GbAN0KS4w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E/VbeL2eq.0rP8GbAN0KS4w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  MAINTAINERS

between commit:

  f303c6b26ced ("MAINTAINERS: add spi to PolarFire SoC entry")

from the spi tree and commit:

  4a691b8c157a ("MAINTAINERS: add musb to PolarFire SoC entry")

from the usb tree.

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
index fcaa66ea848b,e73c77d479bb..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -17225,7 -17169,7 +17232,8 @@@ S:	Supporte
  F:	arch/riscv/boot/dts/microchip/
  F:	drivers/mailbox/mailbox-mpfs.c
  F:	drivers/soc/microchip/
 +F:	drivers/spi/spi-microchip-core.c
+ F:	drivers/usb/musb/mpfs.c
  F:	include/soc/microchip/mpfs.h
 =20
  RNBD BLOCK DRIVERS

--Sig_/E/VbeL2eq.0rP8GbAN0KS4w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKz4UMACgkQAVBC80lX
0GwcBQf+OuIXeWzcmZAswkWlIzS3ucWc5npCDzGPxbA7hTkS0tScBpXd0QvajdB7
c0TlhkxBnrcUvlDNitJkx7jypSJYAxRxSItUPq33TOd3SX+KyQveCIYmum7G+MZ6
RO6keSv3ymYOtSBtW8Ma0BgGQM56XwdA6cSc4K1275y2JC/uNco53js6txzN8eX9
D+QBPDpCXAzmygOMGPwRwEC9WP0i3pL+2WjjawrAozr7lIZcKZW1aFeifRXAuTZN
58ifu6UsCXP9PKCKZ5VzXYiuERlAbRBFOvpbIoxNkLZN532GQ5u0tJB31KGSBxfc
yAPMIGAyXaTorNSZkm1piAnh6vK0gw==
=2uj1
-----END PGP SIGNATURE-----

--Sig_/E/VbeL2eq.0rP8GbAN0KS4w--
