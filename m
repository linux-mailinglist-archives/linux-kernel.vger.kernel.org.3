Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74C47A2E8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhLSWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLSWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:47:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A9EC061574;
        Sun, 19 Dec 2021 14:47:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHHsV2zY2z4xbt;
        Mon, 20 Dec 2021 09:47:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639954033;
        bh=onqWwCRup1TwxiIO9wqteDTvBJCYmIn2z6GK8FMm3QQ=;
        h=Date:From:To:Cc:Subject:From;
        b=AOI9b+Ge9XYD07jF2aB+Cp4YGzpWq5yBHdMrRQlGB+H+Pn52FcE4ox3c/bQxlerJU
         8AQF9qVIxouth13ZTzSfgZJujL2wAz3hY/Mx3/sYNP/eZVQEscRI3eNeyFjXDy1A1w
         XD0yXT0XLAXl+o5mgrBxXSX2hjQmrX7p33ANvjCsbd0LFAba/aj20h5O2WVt64Gmol
         1gf0gld0xJCxNv8tZLdLcItL+1rJPZ3eI34JDvlmp2NWJSueJwMtY1E/gW4JnsJJuw
         VUSG1VtVoCM6+8KGzl2rsUn31L5Bus1Kt7ySFknY2lfGSBnyMU+uaZgTNfVmekK5V+
         oCdXwJ8mJmuOQ==
Date:   Mon, 20 Dec 2021 09:47:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20211220094709.01fb8e36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.q4/M/OZq_Go31nhY69Sekw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.q4/M/OZq_Go31nhY69Sekw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts

between commit:

  cd29cc8ad254 ("riscv: dts: sifive unmatched: Expose the PMIC sub-function=
s")

from Linus' tree and commit:

  dacef016c088 ("riscv: dts: enable more DA9063 functions for the SiFive Hi=
Five Unmatched")

from the risc-v tree.

I fixed it up (they are doing the same thing slightly differetnyl, I
used the latter) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.q4/M/OZq_Go31nhY69Sekw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/tm0ACgkQAVBC80lX
0GwFRAf8CKggcnHeCBo21AruS0NQH+emYs2uBBUaUAK00rZEuVlwu6Zevkv7uJY0
JHeP2ob2WttsBE4xEUQq24zpJ5K3emfPqC0w0c7P2R7YgAyCM8mVpsCli0rKjajI
i3ACbUvzr0HK4MOdevO1DQywT2tXq9x7upB8rMfKXYoro/krJj9livwaZYYUZG0E
Bdd3y1AISVL9a8oEl7epPqirJcs0pMjy6nlQ/AbEZnU6k1mVadPF6JD3HEiEFUrE
3EgLKQanUlrXhgPcSUdZs2T8mjmcIs8G6WpPBacaLFCWPAvl7sFXv0sFSTkI9vrf
H6mTf6k+/+pzJUouCZHClI/B7w6rJA==
=/VqQ
-----END PGP SIGNATURE-----

--Sig_/.q4/M/OZq_Go31nhY69Sekw--
