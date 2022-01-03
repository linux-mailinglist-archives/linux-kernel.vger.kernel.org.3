Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD34048385C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiACVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiACVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:32:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB315C061761;
        Mon,  3 Jan 2022 13:32:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSTVJ5kgPz4xgr;
        Tue,  4 Jan 2022 08:32:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641245545;
        bh=cUhanP6XMw5vGHncCVGiTAmYM1P4p0DTssMvp2+bL8E=;
        h=Date:From:To:Cc:Subject:From;
        b=r2I16zGKoNcTgjHbVociR0sbEfoADTn0t/3pAtx9Z8GY28gRlQbNDIwrjJXoq7uyR
         RbGGJ8/zqt+1yNU+40uWL7bCvRBagDoGhp8wz6DEWxQR4UbuEu8YAqtOrCwwLKQ/l2
         k2gL7aBB/myfpWK/B3Q/92ZpDJLU6Tyi9Em3C62h+959EfnoQ0eUDhYFbXk4Y3jesV
         Z/kpYA704kMf/zT/TrCv+vH44gI3VvC9llANF8j5hwi9qqQmjXpRbB47w6aOI/5caL
         0hjmbp1WqIqyk0e3n7L748ujw4AXeRVYjxAScxJkQk/xWz0Oihsk4UkmdrKHVCAyJV
         Z3ewwbKk84fKg==
Date:   Tue, 4 Jan 2022 08:32:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tpmdd tree
Message-ID: <20220104083224.3e23e7e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+aP2JWR.8+FQsrkb7siHFqg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+aP2JWR.8+FQsrkb7siHFqg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8ca8e009e216 ("tpm: fix potential NULL pointer access in tpm_del_char_dev=
ice")

Fixes tag

  Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and

has these problem(s):

  - Subject has leading but no trailing quotes

Presumably you meant

Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio=
_bus")

Please do not truncate or split these tag lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/+aP2JWR.8+FQsrkb7siHFqg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTa2gACgkQAVBC80lX
0Gyt4Af/Zo79sy9INWEovEh4knscMLAghA43rv1THbK1kaESMjPEDSXCS4lv20/L
tWrxhDzeCNRDKa6vP4b7SjZ+LWMIgtp+SB3wK8/dT+FskxrZbTHq+7maLpyL+LyD
oDbYBlkwt0LTPbEJ4poqJ8Q/HgLXyziXi3NUdDLhN8+AGkrW/yPoUv01TSm/hHZN
ls7T8NRrJU7M68RO8geOBTJlaRKymVcCpv7NXegXD3gCe+R3VL/PvI39JUXPzfLR
UukZ2pXxNnOnQLmSGOKD1jp2YOUHt7d67dttYqiaEvTOoouRStiJtRQXbTpLefG9
FbNHmb8anFhuJmdt9iPzuP1YD4z70Q==
=0oOy
-----END PGP SIGNATURE-----

--Sig_/+aP2JWR.8+FQsrkb7siHFqg--
