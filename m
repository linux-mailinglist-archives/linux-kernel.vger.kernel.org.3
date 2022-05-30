Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54D53883D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbiE3UbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiE3UbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:31:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA137379A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:31:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvm2b-0001eR-CN; Mon, 30 May 2022 22:31:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvm2a-005W7e-AZ; Mon, 30 May 2022 22:31:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvm2X-00DAOs-V5; Mon, 30 May 2022 22:31:01 +0200
Date:   Mon, 30 May 2022 22:31:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add MT8365 SoC binding
Message-ID: <20220530203101.5wq52q5pq523ewuu@pengutronix.de>
References: <20220530202136.906407-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydudqqbygmakmkzx"
Content-Disposition: inline
In-Reply-To: <20220530202136.906407-1-fparent@baylibre.com>
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


--ydudqqbygmakmkzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2022 at 10:21:34PM +0200, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 25ed214473d7..ac5c58bbb22d 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -8,6 +8,7 @@ Required properties:
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
>     - "mediatek,mt8183-pwm": found on mt8183 SoC.
> +   - "mediatek,mt8365-pwm": found on mt8365 SoC.
>     - "mediatek,mt8516-pwm": found on mt8516 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.yaml in this directory for a descripti=
on of
> @@ -17,6 +18,7 @@ Required properties:
>                  has no clocks
>     - "top": the top clock generator
>     - "main": clock used by the PWM core
> +   - "pwm1-3": the five per PWM clocks for mt8365

I think you either want s/3/5/ or s/five/three/ here?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydudqqbygmakmkzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKVKYMACgkQwfwUeK3K
7AlmTAf+IC1ZakoG/AbDBiw+ISsvysZi3oDGLTm43optth/vSyX8NRewez5UcedF
lhD+yb619mm33nUfifszc601C2x4L47zLAVRSyVoMn2XiaDporeX17CbcCyq1tDO
yb7dTFuQEdfYr+TbvvVp/5UkCq6cCNS0yojfqxcP+WmXVDD1GsRnzH5BR2dT4Ofy
ynvcYyx8d7wroDefw9IMs01DdPDrXdA7qa6NcSBAzwrAKPRAOVSNvn8ULuE8Op8Y
DyG+WasQYyCDO/k3grKxatZ/ht7OJKObTC+VSbhBucC6yTxYPtZp7tTyLfNR4ReJ
q09ZfRsmPbRLgEVf+5phxmbaevk7uw==
=Gzed
-----END PGP SIGNATURE-----

--ydudqqbygmakmkzx--
