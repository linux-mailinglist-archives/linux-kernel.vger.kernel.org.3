Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21356D10D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:26:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717CA463
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:26:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oAcYp-0004Aj-Hj; Sun, 10 Jul 2022 21:25:43 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-14f9-9001-5433-5e4f.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:14f9:9001:5433:5e4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4A9BCACF60;
        Sun, 10 Jul 2022 19:25:18 +0000 (UTC)
Date:   Sun, 10 Jul 2022 21:25:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: imx8mm-verdin: use level interrupt
 for mcp251xfd
Message-ID: <20220710192517.cbky3cl7j325j3xq@pengutronix.de>
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
 <20220708124205.59564-3-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rkuzb2y3zhcm35uy"
Content-Disposition: inline
In-Reply-To: <20220708124205.59564-3-andrejs.cainikovs@toradex.com>
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


--rkuzb2y3zhcm35uy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.07.2022 14:42:05, Andrejs Cainikovs wrote:
> Switch to level interrupt for mcp251xfd. This will make sure no
> interrupts are lost.
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>

as per https://lore.kernel.org/linux-arm-kernel/20220621195046.rnv66d2333wj=
mtow@pengutronix.de

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rkuzb2y3zhcm35uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLLJ5sACgkQrX5LkNig
010vEgf9He+HpOSbzMgfnzg5Zeg9AyQEquAJ6PcdNByV35te24a1nBeBcVLk5anP
TzPBkeh14mkwkabUyUNk2u6/Qj1+XWvgZcDbZvggryvVlVJmJRkcvnAg3SB8OGUE
0/bY1yI2dKC6kNHwxPfXyXiVkHK7DFvM4rQ00uYH5bp3j2od+Irq6xaV/8Ee7B4l
2W1vm1+FF6pvI+7uWynyHI8MJs7p+NaQrPv+L9l9Dh3BsAj0tWcMUKxus4kuF6Er
H5+hcheuh6XU3Z2byiFYz9QbQCEEm9/RiSmJEly+J9670UI1L/Xf6QcmikJFvB8V
8p/UjpeIj+8Rz60xvFt9zvxVTDf4PA==
=hEQH
-----END PGP SIGNATURE-----

--rkuzb2y3zhcm35uy--
