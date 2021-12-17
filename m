Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD04784D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhLQGLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:11:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AECC061574;
        Thu, 16 Dec 2021 22:11:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFdsk4XXLz4xd4;
        Fri, 17 Dec 2021 17:11:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639721499;
        bh=Za/01V58nQo09u7OF+a0FvV7p4G/Co3VNwo5n7//oKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e5ixP0Z1YeWWwmOxEBf4SdIbxyofHMFQm4r5QI+NB8Kso6OIgSQhAZPyMFau+p8rf
         ekXUtgVZtYuQfKLBLScTRiBGFs+UaaqASMfunv2xdeG8OU15f1W735ZKolKjwgvQ8B
         5dOCvEVZlf9fyY8p6wMNKRjEdwNZqoI4QLlUzm0uifwAKO/Tyj0m65lg9GNN+js4mp
         DmKDrhkSpda1g4AGXDFOOJxP5q1EgoKmmKPGy7rKaBjhZsCAWKAFgLWQVApx72C78R
         uhoLLDBG8HueE1RxeqLnKN+PiSoziNuMpimkSvxTp5CCG1TWt5tSkrj7NC7JFNCAPu
         bwO5lXFGg2rMQ==
Date:   Fri, 17 Dec 2021 17:11:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the gpio-sim tree with the
 gpio-brgl-fixes tree
Message-ID: <20211217171136.613b02d3@canb.auug.org.au>
In-Reply-To: <20211116103924.3a26ba23@canb.auug.org.au>
References: <20211116103924.3a26ba23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8r4jz=pFV_Fr_+RTffJGt/I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8r4jz=pFV_Fr_+RTffJGt/I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 16 Nov 2021 10:39:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the gpio-sim tree got a conflict in:
>=20
>   tools/testing/selftests/gpio/Makefile
>=20
> between commits:
>=20
>   92a59d7f381d ("selftests: gpio: fix gpio compiling error")
>   4f4d0af7b2d9 ("selftests: gpio: restore CFLAGS options")
>=20
> from the gpio-brgl-fixes tree and commits:
>=20
>   79d93060a28e ("selftests: gpio: provide a helper for reading chip info")
>   60283bc9fceb ("selftests: gpio: add a helper for reading GPIO line name=
s")
>=20
> from the gpio-sim tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is now a conflict between the gpio-brgl tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/8r4jz=pFV_Fr_+RTffJGt/I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8KhkACgkQAVBC80lX
0GzN6wf9GhM4xpYIOfwBoRup3596AgstRrIRLS6bPOqSDCnU4LWsnEBIVBv1HXAQ
+5BQD2lXbuenU5SRtDlqesXsx08EaX32DycReJ/ySQc+Gslxa801OotDqgm+W5JF
bd/MoHl1g4RJ4Il9Xp6esbMx1W1/po8fRwC8g2WP37wvcUwDhNYx6S0+m3n1XvoZ
ZxrkqfQdqU7E7n+zKfttd0pNsLIY21jTeONeBvdg+jufUfWhGDsdiK5WLAsIvMmN
vtUIG7cGRQslX979OOEexoZQyQJAxOsPxiucHdvJw6s5sIuX0v4bLd3364W+k8HO
983AZE0+aJZYPGTa1wOSz7+CQdTMng==
=IChE
-----END PGP SIGNATURE-----

--Sig_/8r4jz=pFV_Fr_+RTffJGt/I--
