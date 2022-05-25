Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94F533830
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiEYISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiEYISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:18:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781AF67
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:18:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntmDN-0003yz-PR; Wed, 25 May 2022 10:17:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntmDN-004QdI-JR; Wed, 25 May 2022 10:17:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntmDL-00BzPy-Kv; Wed, 25 May 2022 10:17:55 +0200
Date:   Wed, 25 May 2022 10:17:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20220525081754.5uj5fpwloq4gdi6o@pengutronix.de>
References: <20210819121403.337833-1-u.kleine-koenig@pengutronix.de>
 <20210922081549.kit3lsek7lh6w6ji@pengutronix.de>
 <20211014154307.eb3y3sh5lca4426t@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6ctod4vy3mwlh6p"
Content-Disposition: inline
In-Reply-To: <20211014154307.eb3y3sh5lca4426t@pengutronix.de>
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


--n6ctod4vy3mwlh6p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2021 at 05:43:07PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, Sep 22, 2021 at 10:15:49AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Aug 19, 2021 at 02:14:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > > Allow to pass an integer n that results in only keeping n unused cloc=
ks
> > > enabled.
> > >=20
> > > This helps to debug the problem if you only know that clk_ignore_unus=
ed
> > > helps but you have no clue yet which clock is the culprit.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I consider this patch really helpful, it helped me to debug a clk issue
> > without having to recompile the kernel for each bisection step.
> >=20
> > On #kernelnewbies I got some positive feedback for it (1629304050 < j_e=
y>
> > ukleinek: nice clk_ignore_unused patch, I added a pr_err there recently
> > to print the clocks that were being disabled).
>=20
> Any thoughts on this patch? Would be great if it makes it into the next
> merge window.

Back then I thought this patch could make it into 5.16, now 5.18 is
released and i didn't get any feedback on this patch :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n6ctod4vy3mwlh6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKN5i8ACgkQwfwUeK3K
7AljkQgAkPxmkCdzTrx38aQWmo1FA+3qUcUz8DlV8cCwaFxuSht+xuJfE0b7PSVQ
7su58e+3KOCnsieaz49PnIK4+fa4PyW/If478cipJ043z7/u/GWz/ec1R1eDNl6u
HWXlQlfRZX2v5QfDjwGkrSUsCLIVUw+m3vGBh1plrbzdMwselcj75J1xYx9fEUvU
bpNEU3oAygvw6EzZFcNaCQugPrENtXtFCNgeezs86PCqwiIH7PbjGa/y/HXn4ZLe
8X+Xm0QYTDG+JfVXjSf4Rssz9r5Xfo9pz3/f/dT1HSG33c9vG4sk9XgxfrK8yfE8
uT8U678+a/zjYYMt6v++Lj3FwT10bg==
=NN6A
-----END PGP SIGNATURE-----

--n6ctod4vy3mwlh6p--
