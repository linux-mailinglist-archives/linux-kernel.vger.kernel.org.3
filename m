Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193EC554353
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbiFVGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbiFVGwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:52:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E7369C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:52:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o3uDV-0002vo-Q5; Wed, 22 Jun 2022 08:51:57 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-0ddb-1bbb-e3fd-3cee.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:ddb:1bbb:e3fd:3cee])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3C3799C01B;
        Wed, 22 Jun 2022 06:51:56 +0000 (UTC)
Date:   Wed, 22 Jun 2022 08:51:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Message-ID: <20220622065155.uoo2matz36a45nfa@pengutronix.de>
References: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
 <20220621180749.GA22098@francesco-nb.int.toradex.com>
 <20220621195046.rnv66d2333wjmtow@pengutronix.de>
 <7d04c05771ded0f8302d716fa5289d94df27c8eb.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76kamf7d6dnpz6x3"
Content-Disposition: inline
In-Reply-To: <7d04c05771ded0f8302d716fa5289d94df27c8eb.camel@toradex.com>
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


--76kamf7d6dnpz6x3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.06.2022 08:38:04, Andrejs Cainikovs wrote:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can1: can@0 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "microchip,mcp251xfd";
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&clk20m>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&clk40m>;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts-extended =3D <&gpio1 6
> > > > IRQ_TYPE_EDGE_FALLING>;
> >=20
> > You don't want to use an edge triggered interrupt with the mcp251xfd
> > chip. You will be losing interrupts, better use IRQ_TYPE_LEVEL_LOW.
>=20
> This particular change is not about interrupts.

Sure, I just noticed it.

> But thanks for a hint, I'll make sure this is addressed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--76kamf7d6dnpz6x3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKyvAkACgkQrX5LkNig
010wLwgAilTVnq+l3oHfKypqDgkOYJt5Clt1qpWaDjQR3y7xem66KBUD262Cvjhh
LJScmqZNUUUIXS65kl2JDPuOLvm6RmR83+oGF0j9AyWWEk50g2FU3sJX5TZCpm+G
2chxh01cuppbO8Lf8TZLKJtzfimWxtZZpJ25AJJP7Mwl1Nqo+CjXJuRuL0IRVr/v
/BTzry3IjLirEFjy+0coO5LnSj6tX9fb0+WnREqkvN9nLI6X1ZPD4YIeidaN8kig
Y5sAgvN/4iWno0uUl4YK/H/hH9OFddkK0ctgIgqnXi/8h8qpZqJlfjZQGbaXq/iv
OXBkBjZoDkVCfuwPI6tNz/FwxIgJkA==
=kWUK
-----END PGP SIGNATURE-----

--76kamf7d6dnpz6x3--
