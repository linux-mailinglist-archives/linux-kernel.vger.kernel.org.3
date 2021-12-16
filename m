Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9740A477178
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhLPMQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:16:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54275 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhLPMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:16:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFB1N36qYz4xRC;
        Thu, 16 Dec 2021 23:16:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639657001;
        bh=DHU4k8VPtJVsvokLXfZuX2e2RJV7Pscr9fWZxs1WSEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oU+4pb/wPJRBVeqK3t0ClD2+cAcv02rrwzdBzT/m6qKZ3lfOk3NhiEHDNysnQX8lp
         0a4MyeMi6TlxtLuAOKh9KInhUyInQH9ScoHcHDGCdV8AKcNhH4GmgiXciuhO7YBrZm
         +ZaD7hGdlPO39F8krXtVCa8hvmw32Fodmz0LIEzL3IOCJ0+UJ656zzFnWvKwZedFxo
         Uf3En7k/1qkBK7xb+v1j0ZBL3DFgguQfSuouwC90WgbHLAB5UokSbl+T4tEDnrLxGq
         VTb7u75SGb5Zaz8lgxfhAhBMyoAJbt3676ECfLd91B7F6NDA1tL8tqD46qJ6Gs4EuZ
         GqM4y29+eKm1A==
Date:   Thu, 16 Dec 2021 23:16:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org,
        jeyu@kernel.org, mcgrof@bombadil.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Next/Trees: update the modules tree
Message-ID: <20211216231639.27ff2f80@canb.auug.org.au>
In-Reply-To: <20211208195931.3369500-1-mcgrof@kernel.org>
References: <20211208195931.3369500-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0A=cELd0EvrV1xDla6qX0dI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0A=cELd0EvrV1xDla6qX0dI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Wed,  8 Dec 2021 11:59:31 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Upon Jessica's request I'm helping with modules maintenance
> so this patch reflect this and updates the trees to mine. For
> the last v5.16 merge window I have already sent my first
> pull request which was merged for v5.16-rc1. I'll queue up fixes
> on the modules_linus branch.
>=20
> I'm now queuing up changes for the next release and so will be putting
> those in the modules_next branch to match parity with the same style
> used by Jessica.
>=20
> Cc: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Next/Trees | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Next/Trees b/Next/Trees
> index 1348af7fdb0f..620898543919 100644
> --- a/Next/Trees
> +++ b/Next/Trees
> @@ -46,7 +46,7 @@ input-current	git	git://git.kernel.org/pub/scm/linux/ke=
rnel/git/dtor/input.git#f
>  crypto-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/herbert=
/crypto-2.6.git#master
>  vfio-fixes	git	git://github.com/awilliam/linux-vfio.git#for-linus
>  kselftest-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/=
linux-kselftest.git#fixes
> -modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/lin=
ux.git#modules-linus
> +modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/l=
inux.git#modules-linus
>  dmaengine-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/=
dmaengine.git#fixes
>  backlight-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/ba=
cklight.git#for-backlight-fixes
>  mtd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t#mtd/fixes
> @@ -231,7 +231,7 @@ etnaviv		git	https://git.pengutronix.de/git/lst/linux=
#etnaviv/next
>  regmap		git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap=
.git#for-next
>  sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git=
#for-next
>  sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sou=
nd.git#for-next
> -modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.gi=
t#modules-next
> +modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.=
git#modules-next
>  input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#=
next
>  block		git	git://git.kernel.dk/linux-block.git#for-next
>  device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device-m=
apper/linux-dm.git#for-next

I have updated to use the new tree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/0A=cELd0EvrV1xDla6qX0dI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7LicACgkQAVBC80lX
0GwVcgf/cq6klN16uWVz9IDjDB4zkQ4M5kvfyNLNLDOObHapcZSNPxXwBJQAUrZb
5eksfAvlaKtiEqzbUax31xxZLUMMZXDB8GhqUzFOd2UoWJ6G9CK1kbTZ5VIZroI3
rwjtEwTvIyxNoRdq08xfS1mJRKRpDUlPRxlYYIxhbqK/sSMS6QfoN9NMaQblxbZC
S8cU4fi68HcfplNsbdIZM4HKFgfeDLTvjwqWkMFnIYSgSRqScOWDbSnheqFucFCY
M1Tvbzeyfeek2cpkK53sRz9ww5xjNfptr7xEzxSkIQAnn3deLTnQFZ0k/REEK3SX
jLytospHf6PVN7WEI96cTE8TnHIfhA==
=N16R
-----END PGP SIGNATURE-----

--Sig_/0A=cELd0EvrV1xDla6qX0dI--
