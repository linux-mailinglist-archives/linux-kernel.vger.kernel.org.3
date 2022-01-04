Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF0483D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiADICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiADICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:02:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB50C0617A0;
        Tue,  4 Jan 2022 00:02:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSlT93Wdxz4y4H;
        Tue,  4 Jan 2022 19:02:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641283341;
        bh=+jagbjeZ5GOmwxkcHyi/G7QBXs4r6KG+6i3WMny4jw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jCfMZhdmWHtYrCRSPwZ+Jj0qpwDMMp8Vqf7LwjFJ4efZGvlL0AMAQIIqap15b2cir
         qnTDYGasDdXUxo1HTddqDgvggA9BPpF31STucqX8Anm7LO1H0Jt43GTyuFRlkDRFH6
         FqK59tshKGOSjtrr76kV2lI69fKbeOXyES4R9vIdhOV7e8grfrvVuy+HNIQdk9oOmS
         iMQK3MuplH3wqtq8LzKUDMh/iaFmVJcik+QNbjo9F1/BAQgvhAd2h1wO8GK6sATsHP
         5zheHWlV6ZDZj2ATUtRBhr/GMpgXJBuNJsfVVZtgKeOMCjaqYj2YgOOUk+0IVgejsQ
         EbM2ETV5Ik6KQ==
Date:   Tue, 4 Jan 2022 19:02:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Message-ID: <20220104190220.45c8e0cf@canb.auug.org.au>
In-Reply-To: <d485fb62-b576-f9b6-13bc-709a2c409240@gmail.com>
References: <20220104111551.7f26e893@canb.auug.org.au>
        <d485fb62-b576-f9b6-13bc-709a2c409240@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+=Twe.6.+LdJY68sTlUc5zr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+=Twe.6.+LdJY68sTlUc5zr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Tue, 4 Jan 2022 08:29:28 +0100 Heiner Kallweit <hkallweit1@gmail.com> wr=
ote:
>
> The patch in the pm tree annotating pm_runtime_resume_and_get() as __must=
_check
> follows some fixes of pm_runtime_resume_and_get() usage that went through=
 other
> trees. These fixes are in linux-next but don't seem to be in the pm tree.
> We talk about:
> f04b4fb47d83 ("ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_=
and_get()")

In the sound-asoc tree.

> 3d6b661330a7 ("crypto: stm32 - Revert broken pm_runtime_resume_and_get ch=
anges")

In the crypto tree.

Both those are merged into linux-next after the pm tree.  If Linus did
the same, the pm tree commit would break his build.  The only way you
can have that pm tree commit in linux-next is to ask Andrew Morton to
put it in the post linux-next part of his patch series.  Otherwise, it
needs to be removed form the pm tree and wait until after the next
merge window closes (or at least both the above trees have been merged
by Linus).

--=20
Cheers,
Stephen Rothwell

--Sig_/+=Twe.6.+LdJY68sTlUc5zr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHT/wwACgkQAVBC80lX
0Gxw2gf/QRDQaS3RPEIJNBJkkWrvsiD5FZO65gX9xPWSx2baqplxASp/gWY73XtC
5Y1ARgKV2Lb8LkkHuLvr31o+hK7Xa4F9PmwICyACn5CXG8YQBzZ5YikplCC1qaBA
QRpkwYzY1OVKj9o2mP/8EVdCaq08gkQ/9Rju+P4cISyQtcMndmnJVKeGBbrc5t7f
z0ZE1SjzkwNifFMHIeAzY1D8jkRbhWBPVKdKZNwaX4GnYIFUV8MOKelbm/scGgsK
J7hgCFIV1gT21oTyKnyuf+jjb7ezzAyLNcDRXKh86xxVq2KdQXBwyY8VzWtz1tmV
Gi1nSgU/bRmYPv2zjh5JDKsHjpUFBg==
=gFjg
-----END PGP SIGNATURE-----

--Sig_/+=Twe.6.+LdJY68sTlUc5zr--
