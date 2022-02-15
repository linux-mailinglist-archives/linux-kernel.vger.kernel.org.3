Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8A4B648F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiBOHlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:41:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiBOHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:41:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85121119860
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:41:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJsS0-0006FP-9s; Tue, 15 Feb 2022 08:40:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJsRu-00GhwB-EV; Tue, 15 Feb 2022 08:40:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJsRt-003I1A-4j; Tue, 15 Feb 2022 08:40:33 +0100
Date:   Tue, 15 Feb 2022 08:40:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Message-ID: <20220215074030.3nugwproxjh3lwhl@pengutronix.de>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75mhjvzsa3tznmbu"
Content-Disposition: inline
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
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


--75mhjvzsa3tznmbu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Anson Huang and Yash Shah from Cc: which were not reachable for
my last mail]

On Mon, Feb 14, 2022 at 10:21:39PM +0100, Krzysztof Kozlowski wrote:
> Hi,
>=20
> Changes since v1:
> 1. Add tags.
> 2. Adjust subject (Uwe).

However you only took a part of my suggestion ...

> Krzysztof Kozlowski (15):
>   dt-bindings: pwm: allwinner,sun4i-a10: Include generic pwm schema
>   dt-bindings: pwm: imx: Include generic pwm schema
>   dt-bindings: pwm: intel,lgm: Include generic pwm schema
>   dt-bindings: pwm: iqs620a: Include generic pwm schema
>   dt-bindings: pwm: mxs: Include generic pwm schema
>   dt-bindings: pwm: rockchip: Include generic pwm schema
>   dt-bindings: pwm: sifive: Include generic pwm schema
>   dt-bindings: pwm: renesas,pwm: Include generic pwm schema
>   dt-bindings: pwm: toshiba,visconti: Include generic pwm schema
>   dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
>   dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice

=2E.. The actual patch has a space after the comma, I like this variant
without comma better as this is a compatible string. Also a # before
pwm-cells would be nice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--75mhjvzsa3tznmbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmILWOsACgkQwfwUeK3K
7An9UAf/fphlT382o9/FKqwTAw/JDCNvTPyXDeOLfHI7s5jElS2X/z6Ev+qvlRbO
c69X0dIeX0m3ZG2Aqq9zXkzrEjLiv5BUPTnaA/EsPCkU8TWyTQa/cd+y7kAnqVxx
63Vj1JFt9TxNaAR/+EebmDui9nLX3D/hUYNaJn+JbAZlLGGdzcmbovc5YmB1lw/M
qByp61tL/ib3x+KV8tA4Rccvu1uxZTmU7VUf15xsHOdY1LXDeu/ZCbWIWOy0AeNa
dlLq2yiogwbckiquxxHnHm3yVPt1ncclAYeUT3VY9VeHvU6OQkNvJgtdmsGkEFfn
ZVt42/xmkq2p4d6tMsSkQzJGnR6DRA==
=6jay
-----END PGP SIGNATURE-----

--75mhjvzsa3tznmbu--
