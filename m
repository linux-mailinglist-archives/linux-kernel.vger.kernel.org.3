Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BF562C89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiGAHZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiGAHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:25:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B040A2F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:25:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7B1S-0004u3-9I; Fri, 01 Jul 2022 09:25:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7B1N-003k2e-R9; Fri, 01 Jul 2022 09:25:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7B1Q-002H6l-Cf; Fri, 01 Jul 2022 09:25:00 +0200
Date:   Fri, 1 Jul 2022 09:25:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8195: add pwm node
Message-ID: <20220701072500.3rgvscnulhjmjhb6@pengutronix.de>
References: <20220531114544.144785-1-fparent@baylibre.com>
 <20220531114544.144785-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jpbomglvpzfusz7"
Content-Disposition: inline
In-Reply-To: <20220531114544.144785-2-fparent@baylibre.com>
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


--7jpbomglvpzfusz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 31, 2022 at 01:45:44PM +0200, Fabien Parent wrote:
> MT8195's PWM IP has 4 PWM blocks.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index d076a376bdcc..366543f27a99 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -367,6 +367,21 @@ pwrap: pwrap@10024000 {
>  			assigned-clock-parents =3D <&topckgen CLK_TOP_ULPOSC1_D10>;
>  		};
> =20
> +		pwm0: pwm@10048000 {
> +			compatible =3D "mediatek,mt8195-pwm",
> +				     "mediatek,mt8183-pwm";
> +			reg =3D <0 0x10048000 0 0x1000>;
> +			#pwm-cells =3D <2>;
> +			clocks =3D <&infracfg_ao CLK_INFRA_AO_PWM_H>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM1>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM2>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM3>,
> +				 <&infracfg_ao CLK_INFRA_AO_PWM4>;
> +			clock-names =3D "top", "main", "pwm1", "pwm2", "pwm3",
> +				      "pwm4";
> +		};
> +

I wonder why will pick up this patch? Will patch 1 then go the same
path, or is that one supposed to go via the pwm tree?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7jpbomglvpzfusz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+oUkACgkQwfwUeK3K
7Ang2gf+Kl9JecJpvkoirnmDAmLOLjFtUVPIXpmZTrlJ1C07oaQ3+h6VzBQ84sJT
BbROJc039OnAHAKkscpVcssNm2nFpm+t05wBMuDO4wipvehakAzbHL4m4o4xEOTT
wkRjbHcNEmPLB/yhJBx9U32vPNctKWygGYEG+eIYc2rNnaseHdlK73k2Ks9VH1Vg
0gt7tSg6IA6um6QTDMwB7anVI0wWX3S6kk5Shozd65S/egyIsDFZsKwoTzgPX+qa
W6gEhUfx9NkbHxBH3nN3rBN1TPLHNHB5QYLEm9jHWmeaupZtl2Gf14AQET+haWjT
4YX6PFmjZMynfmh/2KKAQv1N+EhLJg==
=hTm4
-----END PGP SIGNATURE-----

--7jpbomglvpzfusz7--
