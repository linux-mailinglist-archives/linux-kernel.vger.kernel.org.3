Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438F4545651
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiFIVMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbiFIVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:12:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848826EE99;
        Thu,  9 Jun 2022 14:12:00 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8306D6601691;
        Thu,  9 Jun 2022 22:11:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654809119;
        bh=QCMlxyINqz2tE9vE0/TI/Os3nZFbV+rEbRfPU7Nqyxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK4FIYML5RoY3LSjOj0YFpZpZAWph+J1j+dhponb3U6DsGiIcLmahRxPzJfiaKsu0
         wLYGnNsvUI/WJeNlxLHSHuornLGqo8FwDafGs7fR3dcpkL11GrA5PtM1//POaeZT2D
         24F0efzPZxna34epFv3nfIuPDPzPQWsqGixWpHgsBJS6poIQCi+RbIsnrn0EJYGxkl
         zylWrdtyQjbocr8YNw2FM71TcLgldsACBcgLH7+XUfQxOozzKFFMQgmQJX1ygcI6vB
         jTdUxA5AGinI6R8wnmh3uc0TF17uR3Px+1hMZYdgVlfBkTkiAytQ2EQZq1K/kNPDTh
         Q0INKv5qpsTuw==
Received: by mercury (Postfix, from userid 1000)
        id 061F210605B9; Thu,  9 Jun 2022 23:11:56 +0200 (CEST)
Date:   Thu, 9 Jun 2022 23:11:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 16/17] power: axp20x_battery: Support battery status
 without fuel gauge
Message-ID: <20220609211156.fvrb6jvwnnhvu3mq@mercury.elektranox.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-17-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u37hex4eaojbtqbu"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-17-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u37hex4eaojbtqbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 04:53:23PM +0100, Aidan MacDonald wrote:
> Add a "has_fg" flag to indicate that the chip has a fuel gauge.
> Report battery full status on chips with no fuel gauge using the
> battery voltage.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 87fb958f2224..e9547e2d7c48 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -62,6 +62,7 @@ struct axp_data {
>  	int	ccc_scale;
>  	int	ccc_offset;
>  	const int *ccc_table;
> +	bool	has_fg;
>  	bool	has_fg_valid;
>  	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>  	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> @@ -190,7 +191,7 @@ static int axp20x_battery_get_prop(struct power_suppl=
y *psy,
>  				   union power_supply_propval *val)
>  {
>  	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> -	int ret =3D 0, reg, val1;
> +	int ret =3D 0, reg, val1, val2;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_PRESENT:
> @@ -224,6 +225,34 @@ static int axp20x_battery_get_prop(struct power_supp=
ly *psy,
>  			return 0;
>  		}
> =20
> +		/*
> +		 * If the chip does not have a fuel gauge, we check battery full status
> +		 * using voltage instead.
> +		 */
> +		if (!axp20x_batt->data->has_fg) {
> +			ret =3D axp20x_batt->data->get_max_voltage(axp20x_batt, &val1);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D iio_read_channel_processed(axp20x_batt->batt_v, &val2);
> +			if (ret)
> +				return ret;
> +
> +			/* IIO subsystem reports voltage in mV but we need uV */
> +			val2 *=3D 1000;
> +
> +			/*
> +			 * According to the AXP192 datasheet, charging will restart if
> +			 * the battery voltage drops below V_rch =3D V_tgt - 0.1 V, so we
> +			 * report the battery is full if its voltage is at least V_rch.
> +			 */
> +			if (val2 >=3D val1 - 100000)
> +				val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			else
> +				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +		}
> +
>  		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
>  		if (ret)
>  			return ret;
> @@ -546,6 +575,7 @@ static const struct power_supply_desc axp20x_batt_ps_=
desc =3D {
>  static const struct axp_data axp209_data =3D {
>  	.ccc_scale =3D 100000,
>  	.ccc_offset =3D 300000,
> +	.has_fg =3D true,
>  	.get_max_voltage =3D axp20x_battery_get_max_voltage,
>  	.set_max_voltage =3D axp20x_battery_set_max_voltage,
>  };
> @@ -553,6 +583,7 @@ static const struct axp_data axp209_data =3D {
>  static const struct axp_data axp221_data =3D {
>  	.ccc_scale =3D 150000,
>  	.ccc_offset =3D 300000,
> +	.has_fg =3D true,
>  	.has_fg_valid =3D true,
>  	.get_max_voltage =3D axp22x_battery_get_max_voltage,
>  	.set_max_voltage =3D axp22x_battery_set_max_voltage,
> @@ -561,6 +592,7 @@ static const struct axp_data axp221_data =3D {
>  static const struct axp_data axp813_data =3D {
>  	.ccc_scale =3D 200000,
>  	.ccc_offset =3D 200000,
> +	.has_fg =3D true,
>  	.has_fg_valid =3D true,
>  	.get_max_voltage =3D axp813_battery_get_max_voltage,
>  	.set_max_voltage =3D axp20x_battery_set_max_voltage,
> --=20
> 2.35.1
>=20

--u37hex4eaojbtqbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiYhwACgkQ2O7X88g7
+po0HQ//ThbRxmuGA+jBV2bzKZjf8Dwdy2sE1xWzn7bMDqFGnhwfxDt+4+WbsXE+
TWdwxsbFrcYS9mXCtWOicO/0RX/AN+cN6AAvflRVibxOi79K4y9l5XGwja7cyy91
OGyDsg8oBZNDYWJ4gfYki4J8771EDvXPW+dFJRDKzQ8smCtlKNmVXAC5qBB+PSnh
5OpvfX++qK8G2CL1cp66SNXZ+aBom93/mSNdpWZorXOx9LeoVlbZBCnqmAoDoC37
NIjdFPOLcUsiIFxwpRKMaWQsk4P/PP6JDyTp/cPQNET8hHo4pJ+b4FhsVSlDoxAl
EADgkFCUAOICa/N1wIDHrg6+ip8RRYjPNPXlrKigBNiwEf5DdeNqX+y6RepSKua6
OU9qOlfRZmcQ17VgxgbYDjHv3uA3qXrmCEstadN+Erak03W1L/xrjoajm5Gu7g28
ZwS7oWfs9/4okDLAKAxI2n7JlxN7dJ6mlN5AGcVsFcWrEetaGam6pjIcNo/AmDnL
mneYuTFJEpp9aflw9LX0gXuXekXToxJOA8wWmRg7wEuIGlLn0pZVitujbN6HYPbf
GV5Alg6n6Gnog3aJYKrbxlwgVLUsD5wVdFLUPMOjkyul5siAqRka0ms99Q7t35uK
6DoOr3DbPjo6+45kK3EwZo/71HXMks8HBx5JneIq128gVVjnFvY=
=z3SV
-----END PGP SIGNATURE-----

--u37hex4eaojbtqbu--
