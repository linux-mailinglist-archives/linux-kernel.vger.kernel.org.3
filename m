Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE4465C96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355130AbhLBDT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:19:56 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37283 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbhLBDT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:19:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4Lhc5lMHz4xZ1;
        Thu,  2 Dec 2021 14:16:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638414993;
        bh=chQ8NEclw7413RXpQelT1+Yqbmzc3Z5o21+Ktq1ipxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EMMpje0zzgfh2lhG3TdqRNWr96P6vpUIKOBG44+e+WmnzuqoAondgPXyP1JAp60jr
         gqDU7LlKjoaL0wE0VePwX0vhUXZ/ImWd31tP7iW0CD5y2KPbayH/tPZ1B7K/L8jrPD
         cigddmqzCk+rIcmnGH9qkbUvd0hOXZTGdh4bw/frInvVAFim/ZbDHxKuSz5/0ZvTA9
         l05Wz5Xx3d8Yvnuw7oQ0qG/Dq0RoEmJL43M9glBCSuzwG1vhCNeFs2oKDv9BF2Z0P/
         GRODPXwaAbpKf1ejdL1h+PaELPb2MTCT81Wb6dbtg6f5yR87jXmTRF5TLYcwOqzZpB
         eteTnf70mFWaw==
Date:   Thu, 2 Dec 2021 14:16:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20211202141630.34528f34@canb.auug.org.au>
In-Reply-To: <20211123130418.17878c41@canb.auug.org.au>
References: <20211116105112.4c99853d@canb.auug.org.au>
        <20211118112951.2b788952@canb.auug.org.au>
        <20211123130418.17878c41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OeT7pLIRbK251tuXYXQtWtz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OeT7pLIRbK251tuXYXQtWtz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Nov 2021 13:04:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 18 Nov 2021 11:29:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 16 Nov 2021 10:51:12 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
> > > drivers/gpio/gpio-xlp.c:300:16: error: 'GPIO_VARIANT_VULCAN' undeclar=
ed here (not in a function)
> > >   300 |  { "BRCM9006", GPIO_VARIANT_VULCAN },
> > >       |                ^~~~~~~~~~~~~~~~~~~
> > >=20
> > > Caused by commit
> > >=20
> > >   ea708ac5bf41 ("gpio: xlp: Remove Netlogic XLP variants")
> > >=20
> > > I have used the gpio-bgrl tree from next-20211115 for today.   =20
> >=20
> > I am still getting this failure :-( =20
>=20
> And still :-( :-(

Its still failing ...

--=20
Cheers,
Stephen Rothwell

--Sig_/OeT7pLIRbK251tuXYXQtWtz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGoOo4ACgkQAVBC80lX
0GzDhAf/SnssGBtdJ+Je/t32yZMvi0NeowCL0bM45/75P5Hlmm57rOZ0TvaqPzVC
LXr6O+pVUE0qu/m7G4XKxO/4c6rG2m0DoAX1uQWX0mQXwxnnOzZautk7Cpk5x55z
YTbqI0qL+2mr9csbv3lTkUWnSEGhZVKsSPTiKiraqzuyCyha/4WRkWMEbR51CP6U
fW5xYVx96XDO8reHiw7fqz8fNKSVxvkJk+GEgynVTzgWtCxejXFZQRkvoDitIyzH
XE4TIH9z7lcdbt+Id8KIfDLiBo4E6XuuhgkWacGlS57NTaev/5LMXedrLEnrk02J
3s2e2I1lbTAa07W10VBtTzs9A8YcrQ==
=2t+a
-----END PGP SIGNATURE-----

--Sig_/OeT7pLIRbK251tuXYXQtWtz--
