Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B547A8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhLTLcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:32:03 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:52411 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhLTLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:32:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHcr01TMHz4xPw;
        Mon, 20 Dec 2021 22:32:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639999920;
        bh=fopIFAbH6Vd8MvpqCjLGSpihFc035YHLl5HNoj9c59w=;
        h=Date:From:To:Cc:Subject:From;
        b=sbXGtpbG9a7vstaJ+zkOgu3YazzNVWZ8nQf2jk3Uy9Buo++qrFUBHotmUElrs0e2k
         7RGblJJW4fAJKK9Z3BD+a59xarBMd1+PZi5ZV2pAJEsFr88ubqbFpyLacNrfRAfrax
         s0M/hjLaaXDLaNAMIA8MhYlOiOiYnRf6tOAVyHKhljGz/9SVqyQGPPaggGkSEKnygw
         LdfLuM9InK4vNUyMmIcCgFnFg17e1Sf1flez5hzxgPLeFvIKF6RPeKSbnmLVUJLspg
         xNAHz+mrpw5H5HGBx8vszI8pUx+INF/dIQFteZRSt6K0uoFyMAiRq5zqMYPvmpCSUG
         keewGv6S6S69Q==
Date:   Mon, 20 Dec 2021 22:31:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Howard Chiu <howard.chiu@quantatw.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20211220223159.2aa58c74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8s8f2Myafto98/E9hXOdZvZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8s8f2Myafto98/E9hXOdZvZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build
(htmldocs) produced this warning:

Documentation/hwmon/mp5023.rst: WARNING: document isn't included in any toc=
tree

Introduced by commit

  883cb06f2553 ("hwmon: (pmbus) Add support for MPS Multi-phase mp5023")

--=20
Cheers,
Stephen Rothwell

--Sig_/8s8f2Myafto98/E9hXOdZvZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHAaa8ACgkQAVBC80lX
0GzDdwf9FKOuFte7+cpDaktx0UKhcGO/WozDEv93yUYdaQldkXT5M4ZvUgmF2J+b
BHc7jWFo2do8GXOmfc4tejNBUqg3Sz6I/BYMg/izqHPl8SehenEkyMS6VTQ+mm7G
Sp/BZGQLFDY5a3T462mn/ghgUu4js1w563f1aB56NR8W2ErLiWSKVFI3748/iB27
CCpsJ2j+kAbSxIBOGCOii/BQxnzUHGcKGHfe4ZXmYtLSuuiWLcpdVayCPlPBOIr5
qK+iUXLpJJTK407e68bm7JUgC7GiVHvVsTY2jiptVzQJDJMJ4e4fYh5i7ETtZYQ0
0dIsQVQeDl56LQvU+L0f8FuNsqn+Bw==
=IrSd
-----END PGP SIGNATURE-----

--Sig_/8s8f2Myafto98/E9hXOdZvZ--
