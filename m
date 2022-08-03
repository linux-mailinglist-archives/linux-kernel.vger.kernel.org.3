Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2B58898A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiHCJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:40:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F24D95A0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:40:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJArv-0002el-Br; Wed, 03 Aug 2022 11:40:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJArr-001SQ3-Ra; Wed, 03 Aug 2022 11:40:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJArt-009GoG-6h; Wed, 03 Aug 2022 11:40:45 +0200
Date:   Wed, 3 Aug 2022 11:40:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: imx: initialize
 peripheral_config/peripheral_size for sdma config
Message-ID: <20220803094041.cmjublrg3nu4odlt@pengutronix.de>
References: <20220803065737.14752-1-sherry.sun@nxp.com>
 <d4838245-030c-39b4-df4b-17b3b4c73a5b@pengutronix.de>
 <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pczzzgzfmnqb6ml6"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404990740869737F326D302929C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pczzzgzfmnqb6ml6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2022 at 09:15:58AM +0000, Sherry Sun wrote:
> > On 03.08.22 08:57, Sherry Sun wrote:
> > > Since commit 824a0a02cd74 ("dmaengine: imx-sdma: Add multi fifo
> > > support") adds the use of
> > > dma_slave_config->peripheral_config/peripheral_size to sdma driver,
> > > the client drivers like uart need to initialize the
> > > peripheral_config/peripheral_size for sdma, otherwise, the random
> > > value of local variable slave_config may cause unexpected
> > peripheral_config and make sdma mess up.
> > >
> >=20
> > If this a fix, please add a Fixes: tag. I am not sure it is though, see=
 below.
>=20
> Hi Ahmad, thanks for the comments.
> I don't think this patch is a fix for a specific commit, so we don't need=
 the Fixes tag.
>=20
> >=20
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/imx.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > > 522445a8f666..bb8c2a712e94 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1320,6 +1320,8 @@ static int imx_uart_dma_init(struct imx_port
> > > *sport)
> >=20
> > This function starts with
> >=20
> > struct dma_slave_config slave_config =3D {};
> >=20
> > >  	slave_config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> > >  	/* one byte less than the watermark level to enable the aging timer
> > */
> > >  	slave_config.src_maxburst =3D RXTL_DMA - 1;
> > > +	slave_config.peripheral_config =3D NULL;
> > > +	slave_config.peripheral_size =3D 0;
> >=20
> > So these are already zero-initialized.
>=20
> I am not sure actually, I think initialize a struct with {} cannot
> guarantee that all members are initialized to 0, it may depend on the
> compiler.

I'm sure and even reverified in my C book[1].

	struct mystruct variable =3D {};

results in all components being initialized to their default initial
value (which is 0 for numbers and NULL for pointers). This works for
automatic variables since "Standard C" which should cover everthing that
is capable to compile today's kernel.

Best regards
Uwe

[1] C - A Reference Manual, 978-0130895929

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pczzzgzfmnqb6ml6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLqQpcACgkQwfwUeK3K
7An8pgf/VzQqhI58KMP5SdQ95NCfJx3qJCjreDoSPsWih4UQPZsZG9nbmtcXLCFI
C3+U1kqWTFNDPtpiRIQS9/0pNPSu/WoUqGCEoyoKb5x4ohcVHjzNAoxKDuDviD7u
A5dx8whr78xqGiZfUDtWnf32AQ64eeFy293jFirq1SXAIyCM9CA6g7hBEBkZLalg
89ri6dtY9LiQEEBQ7dKETJff3IisRkp21ntRtpIG1i9l8YhykOEmuTzL+Fb1K0Uc
/Nxe3nm9Baq4qmSL49gI+32rAD4xU/ihDgy/d74wFitF5i25ofSp44L6nfNvGSHN
eTu/qYF/Im3KcJvGdO40Pr8qMJ6lJg==
=uK5I
-----END PGP SIGNATURE-----

--pczzzgzfmnqb6ml6--
