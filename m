Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225694881EB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiAHGwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 01:52:06 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57299 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiAHGwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 01:52:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JW9kD0pZmz4xZ1;
        Sat,  8 Jan 2022 17:52:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641624724;
        bh=Pnm6t1NzZXyTTkRT5GqaQ++WxzJT42jttwY+X2SPjjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UKZSgOeaBU8LpM3I8I7L00kB96ywufwpA2KxIbaTPkt/z4d2ydEU2+PTh65pWdXxY
         hP4NRzmfpAkEeFKlBB8byIfKQ2iqKIwEDjeWquKkUg6a+DLJ7uOR5ZINIBGctppMZQ
         UAvWNELFgcaycchqihi68dwmCcRkYslVJIhA0kdqJAPpQXbu7OPBln/rq5eNBgrVg4
         3P98cl3thm8DD8S6U2psUBAwCujGJtPLDrGpx9OFb8vEH1e/LvprV2YCchS9RdgXd2
         DRDE2GfwU4C/yX+5RxSIhEhcQUHBvcqlrjG5SpiMWPOHF8GpfjoWMQaEDJPpWEgvXw
         8fohyAxT27abw==
Date:   Sat, 8 Jan 2022 17:52:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: state of the nfsd tree
Message-ID: <20220108175203.705695f8@canb.auug.org.au>
In-Reply-To: <8F605496-7EB6-42A5-8C44-0A541EB2E402@oracle.com>
References: <20220107134621.7814487b@canb.auug.org.au>
        <20220107025506.GA16601@fieldses.org>
        <8F605496-7EB6-42A5-8C44-0A541EB2E402@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VEtbp4VdIj8EE=H5/70Zm8X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VEtbp4VdIj8EE=H5/70Zm8X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Jan 2022 03:13:58 +0000 Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>
> > On Jan 6, 2022, at 9:55 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
> >=20
> > =EF=BB=BFOn Fri, Jan 07, 2022 at 01:46:21PM +1100, Stephen Rothwell wro=
te: =20
> >>=20
> >> I noticed commit
> >>=20
> >>  a71baee992c6 ("MAINTAINERS: remove bfields")
> >>=20
> >> in the cel tree and was sondering if I shuld remove the nfsd tree
> >> (git://git.linux-nfs.org/~bfields/linux.git#nfsd-next) from linux-next=
. =20
> >=20
> > Sounds like a good idea to me.
> >  =20
> >> Maybe I sould rename the cel tree
> >> (git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux#for-next)
> >> to be the nfsd treeas well? =20
> >=20
> > Probably so. =20
>=20
> Both sound OK to me too.

OK, both changes will happen from Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/VEtbp4VdIj8EE=H5/70Zm8X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHZNJMACgkQAVBC80lX
0GyIdAf/QFszsebPjvjvBymyJRFnUmLVTbEDelYAjHW0/Q5nxWy5P22toMrhAM9E
L7ebLG4yhIAr9nxeRkXy2m/E+WLgRC9YYF7UBmhhxg4bJukNm4IbZyAqen0xIJBd
SVPPI558D1LILZBDKpHkcVesJ2Jr3txnVkcD0TF/sX1b2xH5eIERz1Kl5//X8d9c
pXymSVnL1FPxpTeQBdFNyNYNAdgk1MxbAT7wnfihXL/xFQ2npgnvF0vhkz4dyCM/
COGBvu9jzQiT0PLk6g9VeRvK53OnwNyBAx1b55giBv8O704pD/O7iTrhk+Fd2ozs
awrFY3yK0guU48YDIeTbfPTXy5yGjg==
=9rM8
-----END PGP SIGNATURE-----

--Sig_/VEtbp4VdIj8EE=H5/70Zm8X--
