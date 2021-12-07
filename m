Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9126D46B21D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhLGFRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:17:02 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50521 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhLGFRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:17:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7T3C0T05z4xgY;
        Tue,  7 Dec 2021 16:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638854010;
        bh=3+qmB/ds23kimJCqQdonk71tq0ufD8t/epgsmFU3AoA=;
        h=Date:From:To:Cc:Subject:From;
        b=fQhGxMzrS133Xz++LKf/fs8kI0WWBwmHzhFLDCUp16pRBBsEyVx7sMkDmlBxP/6op
         O5Y6xqihmxOifVhysLXv45Ti/pcTL/mu+wJaMCQCOA65frb6id11Y/nh4NT71OlaJb
         0VYkKgXFMH8+Hx24ewVRLYVxKtVzWVs/wn6Y9NIgVqh3F4HlnWdAle4z+PtsmuZbEp
         KP9RSN04j0s2P+Xz2IeasAG7y0to5SZ51mfpJtp+zE+rsPKOImrJdeFql9QN7TXgkI
         O0xlku+q9N28/01iF0/qdsEpGYOpDv5czojAbEWQs5H4kuMhzMc3UvTi7wrsb8iD3U
         +qMCh0pCwwMwA==
Date:   Tue, 7 Dec 2021 16:13:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20211207161326.22d81aaf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6aFJR8PkEMnhtrWICOf5Tma";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6aFJR8PkEMnhtrWICOf5Tma
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  scripts/kconfig/confdata.c

between commit:

  373c0a890520 ("[for -next only] kconfig: generate include/generated/rustc=
_cfg")

from the kbuild tree and commit:

  62cb43b76df3 ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (I basically used the latter version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

Masahiro, you probably don't need that kbuild tree patch any more since
the rust tree has been rebased onto v5.16-rc3.
--=20
Cheers,
Stephen Rothwell

--Sig_/6aFJR8PkEMnhtrWICOf5Tma
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGu7XYACgkQAVBC80lX
0GykyAf7BYbSm2OGBWQjnEZ4eRk0kdL79yiyHOexVdnAId7vQCw76WLj6SlLpHEw
E+fhL8BYGuu1duNuABaYpWS9uKrMmgGgO5TCETUM7xyJ6z2JXQlwZrv7/pRu2U93
9x/rWRAdoQ72LHTlmja0wfWRzrggEZm9SbDnd1otdT4Db7Lb955DJVCqvxlatQES
j1JdO5wNfLD6sc0ic3AaG2k/WB0fkyGFBWPEtTswMx84Lj0enuNMHb2YfozhZdby
4w5OpBeDWkaaItICuvMAJVFMKN33fcZ8ms3bfuHAxIEDBhTjo5TaUhk8Wvx9HgM1
Hk5pn0viSBTQr96cHS/ExIMg0lW8GA==
=IGGO
-----END PGP SIGNATURE-----

--Sig_/6aFJR8PkEMnhtrWICOf5Tma--
