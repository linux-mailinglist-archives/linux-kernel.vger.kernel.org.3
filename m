Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E844B9955
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBQGib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBQGi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:38:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333F2A4A2D;
        Wed, 16 Feb 2022 22:38:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzlWk73vNz4xZ2;
        Thu, 17 Feb 2022 17:38:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645079891;
        bh=NfiT6Z/FphCnGdtRQ5In2XFUm4cObElfqMJYEzwKqtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zjbh2Q90gdjwWb9fodE4ptMHoU2IDCv6UdHbEQps/MCIX0YbMC9IEL7iNARLevA1e
         5uNg6qvf2mQ3B2k/UwTEwNajmsKHjV5uAcj5IhggpXR1uKMMs6yzeY5jDNJ2eFHkrb
         1dV6I0KNZhcICATjEJvbmwrmKQW4XJHtdmc3qGApMV9auuimLKQU+JPqus9dHYHyrI
         fIrc8Bq01TBAzBOzylyWdVXiufmMHIM6FHIYyIAZ3tL766XXbxIUMKYCDAIQWMjB49
         gvZuAcSmHYjKRJRWerUYdrDmNc8WwP7Mgren7ZFF4V8LueCx2PH0K4g/UGqfRDsdsX
         Y7L7ppArAdhvg==
Date:   Thu, 17 Feb 2022 17:38:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220217173810.0addd3ed@canb.auug.org.au>
In-Reply-To: <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
        <20220216172109.72fd0a38@canb.auug.org.au>
        <Yg1hf0iHdKcjnq6l@casper.infradead.org>
        <20220217163026.5e48ccb1@canb.auug.org.au>
        <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ftj20MpvReDRDUvFxi5d.bN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ftj20MpvReDRDUvFxi5d.bN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 16 Feb 2022 21:51:24 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Thu, 17 Feb 2022 16:30:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > On Wed, 16 Feb 2022 20:41:35 +0000 Matthew Wilcox <willy@infradead.org>=
 wrote: =20
> > >
> > > So where do we go from here?  I can see ways of resolving this if
> > > Andrew switches to git, but he won't, so that's out.  Perhaps I can
> > > publish a git tree of Hugh's mlock patches and Christoph's series,
> > > and you can pull that before Andrew's tree so git resolves the confli=
cts
> > > early before trying to resolve conflicts against my tree? =20
> >=20
> > My response for any other subsystem would be that you need to go
> > through the maintainer's tree.  In this case that means feeding a patch
> > series to Andrew and updating that patch series.
> >=20
> > Alternatively, you need to find someone (with Andrew's agreement) who
> > can maintain a git tree that includes all Andrew's MM patches and any
> > other topic branches and deals with all the conflicts and can feed it
> > all to Linus.  Linux-next would also include that tree/branch.
> >=20
> > Andrew, do you have any comments? =20
>=20
> Let's try Matthew's idea - I'll get Hugh's and Christoph's series via
> linux-next and shall figure out the rest.

OK, but I am on vacation from tomorrow until Feb 28th, so I will assume
you will have it all ready for me by then.

> I assume mapletree will throw another spanner in the works?

We will see shortly (I just merged it and will merge the folio tree on
top to give you an indication of the conflicts there).

--=20
Cheers,
Stephen Rothwell

--Sig_/Ftj20MpvReDRDUvFxi5d.bN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN7VIACgkQAVBC80lX
0Gzd7wgAmUHMPGOsq8XAudsVLb7yLaEPG0toc1opecMUkGQHUt5dvButrx3rTGCQ
nI1ZZUpGtE0H6Lma6L1rgQjYXnR431nigtqLpDpP7aOBr/7nYGD9znrJz56WN1ze
4PQfG/VuPNfEKKNpfS79Qcj7QkiCbxbJVTZXJyXSNTBMHZc/RVfebx8yZ7DmwLrD
Mq8pmx6J7FT0ZtjLGKwoClxWDaXKdtg/n+NPS7fLy4XYX7W528y4oI4WXgxtp6sh
o+mD0BxJmUHR0tBGerZUfRiEVJ5IbdVoYLNAWn4LWRWWSeN0NuP1RG1SDXCoz+jJ
qBbY8mAJayeEtYPOTeARNKArVCtA+w==
=rAel
-----END PGP SIGNATURE-----

--Sig_/Ftj20MpvReDRDUvFxi5d.bN--
