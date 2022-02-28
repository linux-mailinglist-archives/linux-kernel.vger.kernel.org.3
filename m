Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D155B4C625F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiB1FNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiB1FNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:13:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDE140F5;
        Sun, 27 Feb 2022 21:13:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6T6X1dKjz4xcd;
        Mon, 28 Feb 2022 16:13:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646025188;
        bh=6j8rhBivrfPZGduIH4iD19AK+8/oLIOpS1F/KahJs1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YW733fWk6C1EuZOipeQi3SFB0hk3V04iiVSHXfxVaiZ/V0upT8BjNrv8EHCWmZGgX
         ZVXYRBdeSMifGy1XZyMkzs6SdQV5t3/CcHRdecMYCFcUO2b+MQ3OG7TsZbWM5jNRGl
         qb7iLOYyigDQ2Ddw3aq9QNL5IwhvH0hdZOsQBgaUVIHASZqwObibUpnDcxreSlLvsv
         1/SvhC1YPRmsZLOzf9jZ9OvC5RjBRyiOawn4d3dJA8MCir/HvI4eOKVgew09jN/fW2
         ydpTt22CJwST5cykBis+7z1VZz2tE1l2Rb+f05KuM13kzX7YTE/q7Xig2QDaEW7NQN
         zlPRO3U+f+0Iw==
Date:   Mon, 28 Feb 2022 16:13:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     broonie@kernel.org, Jessica Yu <jeyu@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the modules tree
Message-ID: <20220228161307.0467e4e1@canb.auug.org.au>
In-Reply-To: <YhWAjCTPp3hhxEOG@bombadil.infradead.org>
References: <20220221160721.1627006-1-broonie@kernel.org>
        <YhWAjCTPp3hhxEOG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aTIGVEqzLpgqEHBwoeuy5xl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aTIGVEqzLpgqEHBwoeuy5xl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 22 Feb 2022 16:32:12 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Thanks for the report Mark. Aaron, did you fix this issue on your latest
> series?
>=20
> On Mon, Feb 21, 2022 at 04:07:21PM +0000, broonie@kernel.org wrote:
> > Hi all,
> >=20
> > After merging the modules tree, today's linux-next build (KCONFIG_NAME)

This was a powerpc ppc64_defconfig build.

> > failed like this:
> >=20
> > In file included from /tmp/next/build/include/linux/build_bug.h:5,
> >                  from /tmp/next/build/include/linux/container_of.h:5,
> >                  from /tmp/next/build/include/linux/list.h:5,
> >                  from /tmp/next/build/include/linux/module.h:12,
> >                  from /tmp/next/build/kernel/module/strict_rwx.c:8:
> > /tmp/next/build/kernel/module/strict_rwx.c: In function 'frob_rodata':
> > /tmp/next/build/kernel/module/strict_rwx.c:16:10: error: implicit decla=
ration of function 'PAGE_ALIGNED'; did you mean 'IS_ALIGNED'? [-Werror=3Dim=
plicit-function-declaration]
> >    16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
> >       |          ^~~~~~~~~~~~
> > /tmp/next/build/include/linux/compiler.h:78:42: note: in definition of =
macro 'unlikely'
> >    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> >       |                                          ^
> > /tmp/next/build/kernel/module/strict_rwx.c:16:2: note: in expansion of =
macro 'BUG_ON'
> >    16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
> >       |  ^~~~~~
> > cc1: some warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >   e5973a14d18 ("module: Move strict rwx support to a separate file")
> >=20
> > I have used the -next tree from the 17th. =20

I am still getting this build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/aTIGVEqzLpgqEHBwoeuy5xl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcWeMACgkQAVBC80lX
0Gzbqgf/eYoaiBZ5GHhyYEbitiuw9vHLgF9lt/dNgIft5Y+IhbpbXD2EmXkAWj65
PRgdxaACdzpJyRFiRJqzo5saz+clANGAuXVJfhMMpuWIHH28PK/HPbmrP0Cs1o5k
PJ5SNttis1YHrzsArCqNTPEuUGInZ+nBXez7vADF1u149jcape15X2GNPEOo0W8h
UM9i94OIXun9u/0JTJjSGzYiEXwwAy+9N8EaJxv6Muv2t1dipt9ooZzM1/4Ih0Jh
yVOyTNW73d3PVFSwMvGb+pTXFvR3zPyYVmEWTQ5U/vodv0sdYsnapkYw5EAfJGGk
CjO7oulQ6LwZzXOOVGOIAcgICcMl6Q==
=xEqm
-----END PGP SIGNATURE-----

--Sig_/aTIGVEqzLpgqEHBwoeuy5xl--
