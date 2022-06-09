Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E904854560A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbiFIUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345356AbiFIUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:53:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D32E13CA;
        Thu,  9 Jun 2022 13:53:23 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 929BB6601649;
        Thu,  9 Jun 2022 21:53:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654808001;
        bh=GLewdZGGHjUSe1VII7HyLaIQ1QG/YNTmpuKFRFF1oQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+/XxMvhY6SD+QdWkuQ+5WlCbhpFwW2Cs+PXidRlqVtJc+aD1vzXwShA+EBfb2X8Y
         NF6TXADsHhou+uuot4BE8D2Yv7RoV2BIfJ3loploojFhCtJ0WeGMA0voJQqWXBdYIM
         j4tufuvKC48U6giNusNys58sQKfGN+NWVQ7IEZDid6a3+7M3ROzYoQIB3xKr9TgKWO
         du28CaAFMwcKo4WscIREs+jE4z0cao5fM1XS+KYQZI2N12ZIaUWHU3xUfoc03BxSRM
         uRudyJQh8NDI3QQuoxNV6ye9CKzbVQLTRUM9gXqQ82CEnsZZAmnRYYOTBoyR5w//tS
         PMLRvjLpSEbCQ==
Received: by mercury (Postfix, from userid 1000)
        id 79F9310605B9; Thu,  9 Jun 2022 22:53:19 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:53:19 +0200
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
Subject: Re: [PATCH v2 13/17] power: supply: axp20x_usb_power: Add support
 for AXP192
Message-ID: <20220609205319.ws5a74xjyxfrdx6p@mercury.elektranox.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-14-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qrqrngzkurwra5x"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-14-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5qrqrngzkurwra5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 04:53:20PM +0100, Aidan MacDonald wrote:
> The AXP192 is mostly the same as the AXP202 but has a different
> current limit.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c | 80 +++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index a1e6d1d44808..03145374ae72 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -48,6 +48,9 @@
>  #define AXP813_VBUS_CLIMIT_2000mA	2
>  #define AXP813_VBUS_CLIMIT_2500mA	3
> =20
> +#define AXP192_VBUS_CLIMIT_EN		BIT(1)
> +#define AXP192_VBUS_CLIMIT_100mA	BIT(0)
> +
>  #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
>  #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
> =20
> @@ -121,6 +124,24 @@ static void axp20x_usb_power_poll_vbus(struct work_s=
truct *work)
>  		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOU=
NCE_TIME);
>  }
> =20
> +static int axp192_get_current_max(struct axp20x_usb_power *power, int *v=
al)
> +{
> +	unsigned int v;
> +	int ret =3D regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!(v & AXP192_VBUS_CLIMIT_EN))
> +		*val =3D -1;
> +	else if (v & AXP192_VBUS_CLIMIT_100mA)
> +		*val =3D 100000;
> +	else
> +		*val =3D 500000;
> +
> +	return 0;
> +}
> +
>  static int axp20x_get_current_max(struct axp20x_usb_power *power, int *v=
al)
>  {
>  	unsigned int v;
> @@ -179,7 +200,7 @@ static int axp20x_usb_power_get_property(struct power=
_supply *psy,
>  	enum power_supply_property psp, union power_supply_propval *val)
>  {
>  	struct axp20x_usb_power *power =3D power_supply_get_drvdata(psy);
> -	unsigned int input, v;
> +	unsigned int input, v, reg;
>  	int ret;
> =20
>  	switch (psp) {
> @@ -215,6 +236,8 @@ static int axp20x_usb_power_get_property(struct power=
_supply *psy,
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  		if (power->axp20x_id =3D=3D AXP813_ID)
>  			return axp813_get_current_max(power, &val->intval);
> +		else if (power->axp20x_id =3D=3D AXP192_ID)
> +			return axp192_get_current_max(power, &val->intval);
>  		return axp20x_get_current_max(power, &val->intval);
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
> @@ -256,16 +279,20 @@ static int axp20x_usb_power_get_property(struct pow=
er_supply *psy,
> =20
>  		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> =20
> -		if (power->axp20x_id =3D=3D AXP202_ID) {
> -			ret =3D regmap_read(power->regmap,
> -					  AXP20X_USB_OTG_STATUS, &v);
> -			if (ret)
> -				return ret;
> +		if (power->axp20x_id =3D=3D AXP192_ID)
> +			reg =3D AXP192_USB_OTG_STATUS;
> +		else if (power->axp20x_id =3D=3D AXP202_ID)
> +			reg =3D AXP20X_USB_OTG_STATUS;
> +		else
> +			/* Other chips do not have an OTG status register */
> +			break;
> =20
> -			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
> -				val->intval =3D
> -					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> -		}
> +		ret =3D regmap_read(power->regmap, reg, &v);
> +		if (ret)
> +			return ret;
> +
> +		if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>  		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
>  		val->intval =3D !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
> @@ -316,6 +343,24 @@ static int axp20x_usb_power_set_voltage_min(struct a=
xp20x_usb_power *power,
>  	return -EINVAL;
>  }
> =20
> +static int axp192_usb_power_set_current_max(struct axp20x_usb_power *pow=
er,
> +					    int intval)
> +{
> +	int val =3D AXP192_VBUS_CLIMIT_EN;
> +	const int mask =3D AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
> +
> +	switch (intval) {
> +	case 100000:
> +		val |=3D AXP192_VBUS_CLIMIT_100mA;
> +		fallthrough;
> +	case 500000:
> +		return regmap_update_bits(power->regmap,
> +					  AXP20X_VBUS_IPSOUT_MGMT, mask, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp813_usb_power_set_current_max(struct axp20x_usb_power *pow=
er,
>  					    int intval)
>  {
> @@ -383,6 +428,9 @@ static int axp20x_usb_power_set_property(struct power=
_supply *psy,
>  		if (power->axp20x_id =3D=3D AXP813_ID)
>  			return axp813_usb_power_set_current_max(power,
>  								val->intval);
> +		else if (power->axp20x_id =3D=3D AXP192_ID)
> +			return axp192_usb_power_set_current_max(power,
> +								val->intval);
>  		return axp20x_usb_power_set_current_max(power, val->intval);
> =20
>  	default:
> @@ -468,6 +516,13 @@ struct axp_data {
>  	enum axp20x_variants		axp20x_id;
>  };
> =20
> +static const struct axp_data axp192_data =3D {
> +	.power_desc	=3D &axp20x_usb_power_desc,
> +	.irq_names	=3D axp20x_irq_names,
> +	.num_irq_names	=3D ARRAY_SIZE(axp20x_irq_names),
> +	.axp20x_id	=3D AXP192_ID,
> +};
> +
>  static const struct axp_data axp202_data =3D {
>  	.power_desc	=3D &axp20x_usb_power_desc,
>  	.irq_names	=3D axp20x_irq_names,
> @@ -600,7 +655,7 @@ static int axp20x_usb_power_probe(struct platform_dev=
ice *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (power->axp20x_id =3D=3D AXP202_ID) {
> +	if (power->axp20x_id =3D=3D AXP192_ID || power->axp20x_id =3D=3D AXP202=
_ID) {
>  		/* Enable vbus valid checking */
>  		ret =3D regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
>  					 AXP20X_VBUS_MON_VBUS_VALID,
> @@ -659,6 +714,9 @@ static int axp20x_usb_power_probe(struct platform_dev=
ice *pdev)
> =20
>  static const struct of_device_id axp20x_usb_power_match[] =3D {
>  	{
> +		.compatible =3D "x-powers,axp192-usb-power-supply",
> +		.data =3D &axp192_data,
> +	}, {
>  		.compatible =3D "x-powers,axp202-usb-power-supply",
>  		.data =3D &axp202_data,
>  	}, {
> --=20
> 2.35.1
>=20

--5qrqrngzkurwra5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiXb8ACgkQ2O7X88g7
+pqxoQ/8D+GXBnmCcBb/KfGUzljFGpaLbqTNy1CYmFQZqTmVeJz9JPZlWVME/6Fk
+q+SJ3JHWeTQQCZQc2YtDmxWL3qJ0VwOXYrViZWvTm7ZC1YMuTpL8C8JPu3vd0f8
aS4PM7T4ASzy6uAs8cMYXJnDKA+8DmAuljePBYofU/CdyR19OEyQbTxTk0nUDswI
Zb1akk4N5XfokCji3r2h1G5Ka0QjnO9oIkQ085od6Bxnusum+orL36VuFJ8yHD28
sq5GnkhAmIYOt4WPvq09a/oPUneTLoDGxZmV81y0tpNf7D6gEK3XuTJYWPjZ6l7W
iDe4qAzGLwu5R24T0QUEAvdSbrJUY7VNtb8+r5JuNmxZtHf3YZfvqiXPyxV3XXZf
Uy0OYEmfBvkcY1MwiM4sIaV+280t3/bmfJip4qa9WuHM+eqH3ymnb8VpU4UByv4c
Eqs2X2fhjORsayq9IJcJwZVKBslB76igNGIyQP7kCO/uQleUfsOhDAR8rX103uA2
i1uxgDKcIBezw2gh26MjHUmPA/QAHzRub9vu53PSdVCGo95XM+b1uBnwh+uQp56g
H7IqS0Pa8xQ003WK3Wp7au09KyghE201xKps7SJcrpcZyOm9LRhmS+++jZ9UnQX3
7mIbm/2j8D//F+7VuRtpJzOZ4nFD4PNWHMVFmncDUuc+sKEtNmg=
=8R3Z
-----END PGP SIGNATURE-----

--5qrqrngzkurwra5x--
