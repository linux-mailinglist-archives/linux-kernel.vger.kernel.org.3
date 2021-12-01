Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA8646594F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353705AbhLAWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:35:24 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:38947 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353660AbhLAWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:35:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4DNG2r4bz4xbC;
        Thu,  2 Dec 2021 09:31:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638397919;
        bh=iRuwDkNdeN13qpkG5g/zOreQsdlthg7UtRfcCdHvVNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RjzdCkVHbUwmYBBE9QOCGUgFn7qjI7rNgOoOTqazl/ZdHm0pftntrGPaepBiKVhSd
         pxrHxKK2uSyeudL0yfX8/txvzOGcqCyy9QL1/BFDajJs9odv8AwWLF+aMCydussyUm
         ckkZW9TEzcSrRTbAdhzymnuEsrKlCWtYaXxAtUOMiTeVX/a9aQ3HSm6pXTzOId8gTh
         jrHsk51uxCJ+ZwcN9tIlBERUBkOqZrsz0YZAOpEbdLgrNFo5OPSx0k4gVVKA98yF6f
         acmSHuTrOtsgb4FN2jDsacxFcKNfx0Rr4CGmwB/Cm9rkEVLcK9MRvVPSJprEpc4NDx
         6URp9Omm+pXbQ==
Date:   Thu, 2 Dec 2021 09:31:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20211202093157.0d49044d@canb.auug.org.au>
In-Reply-To: <87wnko6k8z.ffs@tglx>
References: <20211126145201.5aefa68c@canb.auug.org.au>
        <CAK8P3a078LiivyzUiH+D--iRsQGTcQ_hy=-h7crynrbQ6ZYn6A@mail.gmail.com>
        <20211202090540.1f22fa39@canb.auug.org.au>
        <87zgpk6kcz.ffs@tglx>
        <87wnko6k8z.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GTQDfa2LPoVjoK_tEx9N22Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GTQDfa2LPoVjoK_tEx9N22Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, 01 Dec 2021 23:19:40 +0100 Thomas Gleixner <tglx@linutronix.de> wro=
te:
>
> On Wed, Dec 01 2021 at 23:17, Thomas Gleixner wrote:
>=20
> > On Thu, Dec 02 2021 at 09:05, Stephen Rothwell wrote: =20
> >> On Fri, 26 Nov 2021 11:01:52 +0100 Arnd Bergmann <arnd@arndb.de> wrote=
: =20
> >>>=20
> >>> Thanks a lot for the report, I sent a fix now:
> >>>=20
> >>> https://lore.kernel.org/lkml/20211126095852.455492-1-arnd@kernel.org =
=20
> >>
> >> I am still getting this failure (Arnd's fix has not been applied). =20
> >
> > It got applied, but due to tip maintainer confusion the next branch was
> > not updated. Will be fixed tomorrow. =20
>=20
> Actually now. So still today here :)

Thanks, I have that now, so it will go into today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/GTQDfa2LPoVjoK_tEx9N22Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGn990ACgkQAVBC80lX
0GyeyAf/Y7U4lyRORTzVooMypQbcEvT1tKQTS8ME8x38AmDuy0X4q+3Atld6bWxG
vve03VaImP/CRKk2rri1tKN8+SSUT0fzqbc29wdAYJcc+MY8/HT1e+XVja0or+92
hiezfeDNAvAUnwqS4vFzppPw7T0pcMAzhltwWCUosvmTY1+NFq5PQeykpZP3vbg0
m9Q21oS0k1Fp9ynicTQ1QarcmZd4LzcA2f0KRSdAx9ax4VgdFM8LqHUMpRxadiVx
xaJWuI437cg3q5mvbZpkN1i4J2n1zalzcmhtoxVe98XyIONjxuwmsnI2NZDr2R0t
do8wzZ7ragg1EucIA2A4ElIUlg7Dhw==
=YpfX
-----END PGP SIGNATURE-----

--Sig_/GTQDfa2LPoVjoK_tEx9N22Q--
