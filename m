Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32553EEC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiFFTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiFFTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:41:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D2ED3EB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:41:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyIar-0000Vw-Vx; Mon, 06 Jun 2022 21:40:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyIar-006r9b-5D; Mon, 06 Jun 2022 21:40:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyIao-00Ecds-Va; Mon, 06 Jun 2022 21:40:50 +0200
Date:   Mon, 6 Jun 2022 21:40:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr
 read
Message-ID: <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com>
 <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
 <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="boqcs7jrkk3rfnqe"
Content-Disposition: inline
In-Reply-To: <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
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


--boqcs7jrkk3rfnqe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 07:01:15PM +0200, Andy Shevchenko wrote:
> On Mon, Jun 6, 2022 at 6:54 PM Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 6 Jun 2022, Andy Shevchenko wrote:
> > > On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=E4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> ...
>=20
> > > But more importantly I do not see the reason for the Acked-by tag when
> > > SoB of the same person is present.
> >
> > I just repeated what Uwe gave me. Maybe he didn't notice he was already
> > there as SoB.
> >
> > This situation is anyway a bit more complex than usual. The line I took
> > was part of Uwe's much larger patch initially (which was fully reverted)
> > so his SoB was carried over to preserve the authorship. As I made a
> > non-trivial modification to his original patch by removing almost all of
> > it, I added my SoB too. Given this situation, I kind of thought he Acked
> > (approved) the post-modification version of it.
>=20
> I believe you haven't preserved the authorship that way (since From
> line is different), but since you have done non-trivial changes and
> Uwe is okay with them, the straightforward tag chain would be (with
> your authorship implied):
> Co-developed-by: Uwe
> SoB: Uwe
> SoB: yours

I don't care much, but IMHO the initial set of tags made sense to me. It
has my S-o-b because the change is (somewhat) taken from me and it has
my ack because the modification looked good to me.

But indeed, fixing the email address would be appreciated. Do with the
tags whatever you consider sensible.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--boqcs7jrkk3rfnqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKeWDsACgkQwfwUeK3K
7AmPzwf/UunASJnTiJ/16Znc5eL73N0/lllPWSFZb3IosqdtED2Mor24XTBEiSfh
9M51DzIbS0eQwaZ9erpoy3m6y1eI3Kq+pfVf9qyZPne/3mKgrV8xU2/GcVHH6T6e
LfdvfCzG/RjbOfQO6RyvtGtXK5SIHpvaml+Ka0hLiCjVXlunLyqjcAXw/D5h+v08
zs83AyGp6NVmlUHdFyKG3imtS6MAgWywU2HhZn+EonKWwDvhCp/8Oo98x7PyVsux
Qcfo7JXHYV8CCUWJ0hTyvOXns7Uwhz0R8qYtEcA0WVJFhWbAL9nnjROo35ij9IUG
bwh9V1S1n/FbRkSdT9UMkwqz9TyOpQ==
=XeMl
-----END PGP SIGNATURE-----

--boqcs7jrkk3rfnqe--
