Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292B553ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354094AbiFUTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354091AbiFUTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:51:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930624F01
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:51:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o3jtg-0004jI-BC; Tue, 21 Jun 2022 21:50:48 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-f72d-4f6f-99c1-0b72.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:f72d:4f6f:99c1:b72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E4FDB9BBB0;
        Tue, 21 Jun 2022 19:50:46 +0000 (UTC)
Date:   Tue, 21 Jun 2022 21:50:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Message-ID: <20220621195046.rnv66d2333wjmtow@pengutronix.de>
References: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
 <20220621180749.GA22098@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cymwswx3km3vprca"
Content-Disposition: inline
In-Reply-To: <20220621180749.GA22098@francesco-nb.int.toradex.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--cymwswx3km3vprca
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2022 20:07:49, Francesco Dolcini wrote:
> Hello Shawn, just a ping on this.
>=20
> Francesco
>=20
> On Thu, May 12, 2022 at 12:40:19PM +0200, Andrejs Cainikovs wrote:
> > Update SPI CAN controller clock to match current hardware design.
> >=20
> > Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/ar=
m64/boot/dts/freescale/imx8mm-verdin.dtsi
> > index 0d84d29e70f1..d309bc0ab8f6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -32,10 +32,10 @@ backlight: backlight {
> >  	};
> > =20
> >  	/* Fixed clock dedicated to SPI CAN controller */
> > -	clk20m: oscillator {
> > +	clk40m: oscillator {
> >  		compatible =3D "fixed-clock";
> >  		#clock-cells =3D <0>;
> > -		clock-frequency =3D <20000000>;
> > +		clock-frequency =3D <40000000>;
> >  	};
> > =20
> >  	gpio-keys {
> > @@ -194,7 +194,7 @@ &ecspi3 {
> > =20
> >  	can1: can@0 {
> >  		compatible =3D "microchip,mcp251xfd";
> > -		clocks =3D <&clk20m>;
> > +		clocks =3D <&clk40m>;
> >  		interrupts-extended =3D <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;

You don't want to use an edge triggered interrupt with the mcp251xfd
chip. You will be losing interrupts, better use IRQ_TYPE_LEVEL_LOW.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cymwswx3km3vprca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKyIRMACgkQrX5LkNig
013PCAf9HxzrgOryxn9dqLo2SGEyP6jPeoxhZTOyjTQ00GRTYV2EaKa9f23ylcxz
SeiRPsfCf8mj2DcONhgkHTxDGGCL3mp7CJLnGa5hVEVqCMqSq8D7ThFx6RflDNg+
96Qf8F9LoQOlA+jBmR2KhSNFDzYWTKiwlGur/FrRRpvQephmk/9onhw/fzgZZkCx
2xwSEcE7hZyMy6KBOxcFEg4yVeN7t6TQuXfmzyuV/KqEEGacTwWXovoagVQFDElo
poDx/GH++myJCfZgOKNh1Wrm39A6Q+YI3XLscKWgj+dMf5EdOxdl7Vw7lKpAmLI2
ElEYlv+GQ2vDD8mLXwEMuVArHhzKPA==
=E6rx
-----END PGP SIGNATURE-----

--cymwswx3km3vprca--
