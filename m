Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654B853FB44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiFGKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiFGKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:32:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B03CE27
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:32:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyWVk-0001z3-EL; Tue, 07 Jun 2022 12:32:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyWVk-006yOl-63; Tue, 07 Jun 2022 12:32:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyWVh-00EkU5-OY; Tue, 07 Jun 2022 12:32:29 +0200
Date:   Tue, 7 Jun 2022 12:32:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr
 read
Message-ID: <20220607103229.f4hniwkcyfwlgem2@pengutronix.de>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com>
 <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
 <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
 <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de>
 <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
 <20220607055810.szkjoitpr3vboymr@pengutronix.de>
 <CAHp75VcUBOcz_UAx9tVER8cBb8h8NF+NivUH00-B39wwH6ObUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6zewhn3wuwtvi3o"
Content-Disposition: inline
In-Reply-To: <CAHp75VcUBOcz_UAx9tVER8cBb8h8NF+NivUH00-B39wwH6ObUQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6zewhn3wuwtvi3o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 07, 2022 at 12:09:39PM +0200, Andy Shevchenko wrote:
> > > > > I believe you haven't preserved the authorship that way (since Fr=
om
> > > > > line is different), but since you have done non-trivial changes a=
nd
> > > > > Uwe is okay with them, the straightforward tag chain would be (wi=
th
> > > > > your authorship implied):
> > > > > Co-developed-by: Uwe
> > > > > SoB: Uwe
> > > > > SoB: yours
> > > >
> > > > I don't care much, but IMHO the initial set of tags made sense to m=
e.
> > >
> > > > It
> > > > has my S-o-b because the change is (somewhat) taken from me and it =
has
> > > > my ack because the modification looked good to me.
> > >
> > > According to
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#when-to-use-acked-by-cc-and-co-developed-by
> > > the SoB already implies that you developed that, but Ack if not. It
> > > also clarifies Co-developed-by for cases like this.

Reading that by the letter, it doesn't say you must not use Ack if there
is a S-o-b.

	If a person was not directly involved in the preparation or
	handling of a patch but wishes to signify and record their
	approval of it then they can ask to have an Acked-by: line added
	to the patch=E2=80=99s changelog.

It's "If" and not "Iff". Not sure if that is intended?!

> > That's unintuitive (and wrong) in my opinion.
>=20
> I have the opposite opinion.
>=20
> > For me, Acked-by is a
> > confirmation of the respective person, that the patch in question is ok.
> > If I take a hunk of a random reverted patch and add the S-o-b of the big
> > patch's author, can I really assume the original author "acks" the
> > result? I would expect that in most cases they don't. (And if they do,
> > there is no way to record it, because the usual way of adding an Ack is
> > blocked as there is already a S-o-b?)
>=20
> It's very logical to me. If you allowed (by not NAKing) the other
> developer to use your SoB you imply Ack for every change they made.

So you assume that you notice each patch with your S-o-b in time to send
a NAK. I don't claim that for me and I would be surprised if a major
part of the kernel contributors did.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y6zewhn3wuwtvi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKfKToACgkQwfwUeK3K
7AmWpAf+PFbmFeyedxtz9REfyynhfuR58QtPYsiSzWuf4M3cnolsHEOAANNpVHc9
jANNDJuZ7hueulaLM6QIQlVkNwU2oTC5gYw5fBrORTIPsaUVdhzFbh+l1d5Uw2DX
tROw9p1Junv+4RYM8ny4YaE6ASXPuXU53aLam4nNkN159dHzZ8FbHFZshYTsVj6o
/YSaTgOf83/2AaKd+8w6QLXDsDj1TyMovGahLj8cU492FWtwJoTzo1qiOoArqRJk
qwIFfqyfbhle+haza9cdJPLfxoSf6difwXg1/s5wy2M3MOR4eHAPUR3r7hoNANU9
Bcf0I7MGrSqPSxSovZv16XABceAg0A==
=0Mcm
-----END PGP SIGNATURE-----

--y6zewhn3wuwtvi3o--
