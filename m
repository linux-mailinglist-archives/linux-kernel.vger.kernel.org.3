Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613E48E47B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiANGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiANGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:53:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73DC06161C;
        Thu, 13 Jan 2022 22:53:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZsSb6jFMz4y41;
        Fri, 14 Jan 2022 17:53:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642143184;
        bh=FC/gcaUj4Bla6XhT/Z9qZVENyMyJnOINAeghnQpDQqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U9VTikiP6yiDQm5gfZSROuXTIdIklPW8OgX1+4NVftnznfVJCsGvwdzL2uQylcqzu
         yHf3nDtiv2rapUNkkkLFWwSFUg/d2gXHCa9vRNj1NL0o98k0ka9O31FOkRlPIl0O2J
         ZE1oLYJwZmRi6QswRkgSc6diMJ3fAF1zKcD0YiDXLbAhWhqTu+pg6VRKHjsGvrys0g
         NFZX61OhIFkJZdwbF4ySogNm0BXBlj/qK9f52xI6RU88a2O2hk/JW7vuNcfZu0wIYr
         k7zkZozaTkIGcOXWvup/+BJY9EL39gzZwhhUkzDsMUunBBdXp1dHZU37+Fk74ANiL5
         gClesyKxAD5+Q==
Date:   Fri, 14 Jan 2022 17:53:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20220114175303.07569259@canb.auug.org.au>
In-Reply-To: <CAMhs-H_u42MSPpkwFEQCVghHWVjMqdJ1aKXXhbhxKWrejZLqRA@mail.gmail.com>
References: <20220114104547.55e2f188@canb.auug.org.au>
        <CAMhs-H_u42MSPpkwFEQCVghHWVjMqdJ1aKXXhbhxKWrejZLqRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G0PV1MF+i06VhPb1ocACOND";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G0PV1MF+i06VhPb1ocACOND
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sergio,

On Fri, 14 Jan 2022 06:48:08 +0100 Sergio Paracuellos <sergio.paracuellos@g=
mail.com> wrote:
>
> On Fri, Jan 14, 2022 at 12:45 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > diff --cc drivers/pci/controller/Kconfig
> > index aec8c9a3488b,f7e44d9c6965..000000000000
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@@ -332,8 -332,8 +332,8 @@@ config PCIE_APPL
> >           If unsure, say Y if you have an Apple Silicon system.
> >
> >   config PCIE_MT7621
> >  -      tristate "MediaTek MT7621 PCIe Controller"
> >  +      bool "MediaTek MT7621 PCIe Controller" =20
>=20
> This should be tristate.
>=20
> > -       depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> > +       depends on SOC_MT7621 || COMPILE_TEST =20
>=20
> This is correct,
>=20
> >         select PHY_MT7621_PCI
> >         default SOC_MT7621
> >         help =20

Thanks, I have fixed up my merge resolution for Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/G0PV1MF+i06VhPb1ocACOND
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHhHc8ACgkQAVBC80lX
0Gzkpgf/XlnD7bw2gF3AejWkjbuhP3vCnwUrBasadvFxWKrPWGgxMsVB9uBl3hrV
6zKl7scSY5xnExLv1PCxvpd1KQxWTb2d6FvSFAe/JpWeCQlAnKUxS5La+KhgYjNE
IBqdvabhzPVOw/+OCR5Xa4oXdBlZt7yRsYX1V4yBEp9blWBC5TX0EAMOYZrGUr0G
pZAaZHLn5IVH+xvv2MzPuGMgxd7ION7e3LcPRqc26+EuSuPj0WjRHLg9kygd0w6Y
KceJNsCLGp2oDy+bMpIihMmzJ/g4yKURGNGD46+4Jgq44Qzwv2HMcLs8XD5R/Xnl
BOOrCDxIN/cj+YJViIiwnFqn5nIC7Q==
=SWcT
-----END PGP SIGNATURE-----

--Sig_/G0PV1MF+i06VhPb1ocACOND--
