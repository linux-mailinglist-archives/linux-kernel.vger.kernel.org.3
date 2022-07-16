Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600935771F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiGPWjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPWju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:39:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F49192A8;
        Sat, 16 Jul 2022 15:39:49 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA7546601656;
        Sat, 16 Jul 2022 23:39:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658011188;
        bh=COEr5uOxMkI3kPNEax0jj1+fGc37yVW4MCquaThpdzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JB5nMFWMpC6G9dcujK7dvS0SOFU99Z8xDvdj6318RD7PoIOMdQoqqXVqT9tAnM669
         eQy9KLM0jmoYp33WaoUS2KTrsn3YkfKSpGKffufXC/1IUJFutZrABbnIBM0zLmO1zY
         BHAbtHczFv0dmW+hcv53T+L7xXt38grZVEmY0Z5jTO1Ywg7QmzuaNZHqiEGGWU4bQU
         IXDnA2RoECqO1Mlnu0ka1rXBlNF2mRHTe8NOIgPlrEzXgAw4rgUkMAyztEtvxuKIna
         U3H6jlANxPR9c8iPxyZkoZMyePlfLtgpQxg+/eyJvsEJ2xb9cCFm8XjiMwKccjYzas
         DR8FbiCBITAiw==
Received: by mercury (Postfix, from userid 1000)
        id 790E91060428; Sun, 17 Jul 2022 00:39:45 +0200 (CEST)
Date:   Sun, 17 Jul 2022 00:39:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 11/13] power: axp20x_battery: Add constant charge
 current table
Message-ID: <20220716223945.o6ilrbrlvdszcwfa@mercury.elektranox.org>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
 <20220706101902.4984-12-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aaa3fkkzmlof3mir"
Content-Disposition: inline
In-Reply-To: <20220706101902.4984-12-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aaa3fkkzmlof3mir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 06, 2022 at 11:19:00AM +0100, Aidan MacDonald wrote:
> Add a table-based lookup method for constant charge current,
> which is necessary when the setting cannot be represented as
> a linear range.
>=20
> This also replaces the hard-coded 300 mA default ccc setting
> if the DT-specified value is unsupported; the minimum value
> for the device is now set exactly instead of relying on the
> value being rounded down to a supported value.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 59 +++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 9106077c0dbb..401779d84d2b 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -61,6 +61,14 @@ struct axp20x_batt_ps;
>  struct axp_data {
>  	int	ccc_scale;
>  	int	ccc_offset;
> +	/*
> +	 * Lookup table for constant charge current, if provided this is used
> +	 * instead of ccc_scale/ccc_offset.
> +	 *
> +	 * The table is indexed by the field AXP20X_CHRG_CTRL1_TGT_CURR so it
> +	 * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
> +	 */
> +	const int *ccc_table;
>  	bool	has_fg_valid;
>  	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>  	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> @@ -176,7 +184,10 @@ static int axp20x_get_constant_charge_current(struct=
 axp20x_batt_ps *axp,
> =20
>  	*val &=3D AXP20X_CHRG_CTRL1_TGT_CURR;
> =20
> -	*val =3D *val * axp->data->ccc_scale + axp->data->ccc_offset;
> +	if (axp->data->ccc_table)
> +		*val =3D axp->data->ccc_table[*val];
> +	else
> +		*val =3D *val * axp->data->ccc_scale + axp->data->ccc_offset;
> =20
>  	return 0;
>  }
> @@ -389,16 +400,35 @@ static int axp20x_battery_set_max_voltage(struct ax=
p20x_batt_ps *axp20x_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>  }
> =20
> +static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps =
*axp_batt,
> +						  int charge_current)
> +{
> +	int i;
> +
> +	if (axp_batt->data->ccc_table) {
> +		for (i =3D AXP20X_CHRG_CTRL1_TGT_CURR; i >=3D 0; i--) {
> +			if (axp_batt->data->ccc_table[i] <=3D charge_current)
> +				return i;
> +		}
> +
> +		return -EINVAL;
> +	}
> +
> +	i =3D (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->c=
cc_scale;
> +	if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
> +		return -EINVAL;
> +
> +	return i;
> +}
> +
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp=
_batt,
>  					      int charge_current)
>  {
>  	if (charge_current > axp_batt->max_ccc)
>  		return -EINVAL;
> =20
> -	charge_current =3D (charge_current - axp_batt->data->ccc_offset) /
> -		axp_batt->data->ccc_scale;
> -
> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +	charge_current =3D axp20x_get_constant_charge_current_sel(axp_batt, cha=
rge_current);
> +	if (charge_current < 0)
>  		return -EINVAL;
> =20
>  	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
> @@ -410,14 +440,14 @@ static int axp20x_set_max_constant_charge_current(s=
truct axp20x_batt_ps *axp,
>  {
>  	bool lower_max =3D false;
> =20
> -	charge_current =3D (charge_current - axp->data->ccc_offset) /
> -		axp->data->ccc_scale;
> -
> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +	charge_current =3D axp20x_get_constant_charge_current_sel(axp, charge_c=
urrent);
> +	if (charge_current < 0)
>  		return -EINVAL;
> =20
> -	charge_current =3D charge_current * axp->data->ccc_scale +
> -		axp->data->ccc_offset;
> +	if (axp->data->ccc_table)
> +		charge_current =3D axp->data->ccc_table[charge_current];
> +	else
> +		charge_current =3D charge_current * axp->data->ccc_scale + axp->data->=
ccc_offset;
> =20
>  	if (charge_current > axp->max_ccc)
>  		dev_warn(axp->dev,
> @@ -629,7 +659,12 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
>  								   ccc)) {
>  			dev_err(&pdev->dev,
>  				"couldn't set constant charge current from DT: fallback to minimum v=
alue\n");
> -			ccc =3D 300000;
> +
> +			if (axp20x_batt->data->ccc_table)
> +				ccc =3D axp20x_batt->data->ccc_table[0];
> +			else
> +				ccc =3D axp20x_batt->data->ccc_offset;
> +
>  			axp20x_batt->max_ccc =3D ccc;
>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>  		}
> --=20
> 2.35.1
>=20

--aaa3fkkzmlof3mir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTPiUACgkQ2O7X88g7
+pqb5w//Rj1zJNtTfSRun6rF3+mFEo/1sWS/1ofixrlrahfM2EIqy6heMUeRHLSA
rr1orplBrlIP0hbbebdgtM27KKAJbjvY2I6yMlJTN8iQa2fNp/vJjOIFDjIbMWgc
W2RwBbwcF3lU65jsB4iUtFWxfxPipsEbfB2BBbZV+KaRDoFNu6WIUH37N31FWGJu
tvpPjtXcVinNTfZJiSenQ+HtuhtneTTDA7RinllMa1y7LU7LAIa48kuvl/e20v4l
H8KzpkkYuPVC+vF4sCKJ33zprLUNRoV4GwOnSRpkODV1HEMjAQZMF/dZJ3NQ8W14
Xxb2ip+SaRTAD0TLDZl1B/5uLuFEZF2XSAB54wvGIrs6FOH+adjRKlc9SrqVClig
ZEv0qlpVzRTQ+3Z0D6cfV94yJ0yPSE7ivZj1wvtjUWEaTdKAQYc43ZQyvHDg7pjy
hD87zEEAsNKlxP27Y2lFbnaB00nbYNdtNKhMoDmhBH2SxllE3rjeOA2y2BHJrLeZ
ThltuMfKPpGDTKxxt7/Qxh94tbCxRXQGZM1DD9U9XMxwe922Hy7Ws523gH2FrdTG
gPKtZ4TSlFYu5LVWrMyiJ5YhBTxu8MUs1dz/qakuUC/1KFD+OiBLaLBY4a/Pg/To
yq1ZpXkVH3LCISl/3305reZf6hy4f7heSRJt+k99NKypRPDlGUM=
=u+Wk
-----END PGP SIGNATURE-----

--aaa3fkkzmlof3mir--
