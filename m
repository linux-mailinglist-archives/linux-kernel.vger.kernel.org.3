Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27552478620
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhLQIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:24:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54417 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLQIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:24:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFhph45M0z4xd4;
        Fri, 17 Dec 2021 19:24:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639729453;
        bh=Soc6Js56cJBQ+ScAW2BGXXHcvZWzV4TJj3H9B52peOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PFWlLq1dI2UzQBoGHpJriT2df2OY1Ai014vhJhbZ/WDrn1ndXhTibb9tlGB5iU/gn
         ru+zJj7EvVODGZ1JTq+Iyu3FDHRigw9FvKg5Y1RaIAp48lAX9LoIQDwalpHIlqqXSe
         Igj3TVQ9kD7UJlp68ApGbU6Ac7pU5yI7RZzmUA/hawKKRXHIDXWAdHhl4UhMqujeEv
         rEVzKuacxrn/bxUq0UZ377DMCfityzcV3GyaSCgbHCEqN0+GH40+Wrsf5kXRmjK6hJ
         IwGQW4PFPAMSrHIFx7T+fjXscj3JLB02jo0Lq+gwTRNTctO9Jh+kC8EvPVz/9cLO6l
         olSGd0sl36DdA==
Date:   Fri, 17 Dec 2021 19:24:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     broonie@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: manual merge of the nvdimm tree with the ext4 tree
Message-ID: <20211217192410.3fedc457@canb.auug.org.au>
In-Reply-To: <20211216082833.GA24677@lst.de>
References: <20211210174740.2695216-1-broonie@kernel.org>
        <20211216082833.GA24677@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GCGqd/odkevrb4E1C/O0vcx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GCGqd/odkevrb4E1C/O0vcx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Dec 2021 09:28:33 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Dec 10, 2021 at 05:47:40PM +0000, broonie@kernel.org wrote:
> > I'm not comfortable with resolving this in something as critical as ext4
> > at this point on a Friday evening with the code motion that's going on
> > so I've dropped the nvdimm tree for today, I'll look again on Monday. =
=20
>=20
> Given that it is Thursday now I've done the (pretty simple) merge
> myself, it can be found here:
>=20
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/ext4-dax-=
merge

I have used that today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GCGqd/odkevrb4E1C/O0vcx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8SSsACgkQAVBC80lX
0GzABwf9Fusht9zCn9RLMB9k2bDxql4i9K4ITeTsFRmzey00go58OejVck4hH1R0
/MAChqjIWeHzihIsKEOT87BZpJY2hS9azbu8DXYuyXOvU5RfZcjEagJE5TtRhxe+
5/EUbPjRFOimPxFJBIDMSdjYZ/HhE/rf9TTjDNXmkFvGn6DvGd1W5uLInLBm7cf4
T3hMjZ6k7PjLvMHnSxeBQByHkYwFrsHNB9AbaFQmqsIUdpfGc8MQsPsEU4sIfXE6
WQsXuhLz858xA3F37P0aLHBgLYM0mx0FL2M1HctiNQhUsuXmY2IZ1BxN4ZTIjZ+s
fjP5BZTDIo1CDRzOwTaSjxRTRL3qJA==
=LpzG
-----END PGP SIGNATURE-----

--Sig_/GCGqd/odkevrb4E1C/O0vcx--
