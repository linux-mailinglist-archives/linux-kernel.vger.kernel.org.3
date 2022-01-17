Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C149491186
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiAQWBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAQWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:01:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4055C061574;
        Mon, 17 Jan 2022 14:01:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jd5Sq4q8Zz4y3V;
        Tue, 18 Jan 2022 09:00:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642456859;
        bh=plaNKHLvNQ8OF3ALbYE1GNmcp/NcKkMAXJx6qB0A+FI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nwo8q3N/P+KH04OD3TxNsdgiuVOYyD78+ax81HPu30QckpKKWXlPdcuM0n19AjJ56
         vDwQP5uSkhr5ANItsdYDMK64WPDb8QdmAbF511HodqXBDSbfefQr8kRsz0WUJzUoMA
         l/3XgKlIVO9K47eEag/KKBnTnfDu6z5zREAwgWH0Az29vtM8zS4Z+gl14BVf72cSeg
         EXpVYgbono9YmmEnlDjy+gGsOZGFa9Im263ynZJl0fQGRMsQUtjpcB62ex8m+SYJKL
         GJBVJIfVeXg5jWQ2WLlXir7F8WcUJcV/zc8qbWPc/XZNzUGD5HyDgv26J3vcr9f5yA
         JGIGyStfuhpWw==
Date:   Tue, 18 Jan 2022 09:00:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nds32 tree with the kbuild tree
Message-ID: <20220118090058.2c987ec6@canb.auug.org.au>
In-Reply-To: <20211025093813.2ebe9212@canb.auug.org.au>
References: <20211025093813.2ebe9212@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6/MsRurRevswd7=JCmzhlF9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6/MsRurRevswd7=JCmzhlF9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Oct 2021 09:38:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the nds32 tree got a conflict in:
>=20
>   arch/nds32/Kbuild
>=20
> between commit:
>=20
>   8212f8986d31 ("kbuild: use more subdir- for visiting subdirectories whi=
le cleaning")
>=20
> from the kbuild tree and commit:
>=20
>   37160f01e8ea ("nds32: move core-y in arch/nds32/Makefile to arch/nds32/=
Kbuild")
>=20
> from the nds32 tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc arch/nds32/Kbuild
> index 4e39f7abdeb6,565b9bc3c9db..000000000000
> --- a/arch/nds32/Kbuild
> +++ b/arch/nds32/Kbuild
> @@@ -1,4 -1,4 +1,7 @@@
>   # SPDX-License-Identifier: GPL-2.0-only
> + obj-y			+=3D kernel/ mm/
> + obj-$(CONFIG_FPU)	+=3D math-emu/
> + obj-y			+=3D boot/dts/
>  +
>  +# for cleaning
>  +subdir- +=3D boot

I am still getting this conflict (and another on arch/nds32/Kconfig),
and so am wondering when the nds32 tree will be submitted to Linus for
merging?  It has not been updated since last September.

--=20
Cheers,
Stephen Rothwell

--Sig_/6/MsRurRevswd7=JCmzhlF9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHl5xoACgkQAVBC80lX
0GxOmgf/RnbTKi0FPNEAoeK1HnUlwWI06nlgU7TuRKu7FxAvrZ7wuO+NBtA3e1F7
HYIa73CVhHZ60VsQGCNRjOb8uLHDIq7pAOazgL3XxDVt35BEJ8ckFEETXAwtvQHI
rG3c0STb4kuozncjQ6MxAF8f+W5sMqRU8tddOwXGj0vES8g4/Y8QwWyvgGY1mSgi
ab7QRmjPDBl74kXY6HA4fIMcWYDSGZO4uIrzmW2MRoMEnP7bs6CZ+/9oTJI9h0wT
estOy+6BTgymuaVYZWS8M0m6mEfpXakv9x8V5mD+hMtSWec/4suynHCARQcIa9to
pFP0MWLgavP1I7dsgcR3KYts/24Vbw==
=e4J5
-----END PGP SIGNATURE-----

--Sig_/6/MsRurRevswd7=JCmzhlF9--
