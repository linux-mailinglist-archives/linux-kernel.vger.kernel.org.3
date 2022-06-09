Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B98545659
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiFIVM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbiFIVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:12:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F96277F9C;
        Thu,  9 Jun 2022 14:12:29 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 734C16601691;
        Thu,  9 Jun 2022 22:12:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654809148;
        bh=Biq9wNptBm5X7lWGL+Xp0mwNq7LSzKKjxG1xeEdGruw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wuxz1IsIrKDPBn06aCwiIu1LhVeCfCIswf4AG6Aze8ynq1xOCDTrVTGFro+qpn/6s
         wTw7M78crEk/vECjHUePG6IMk93pbcjxpgLD5Z5A+qHvvs+V4rMhWd3/7t7AkYyDxi
         owWXBwuU08dnyGd0oOEBsbzwLtIf5emi5SHvRKE9AbDonuLCPEkEJXUQsyfr8XC/SN
         7ap/IqpEl/LH4ovPfVpdS9oCy3IlZwxaDtX7HpdizFBQ7AobtH8ZZeBlz2tELi/AD2
         0QMnFXZ2BwaqCQhGWvZxBrNu8kkWPiewHzJZPNek8yCQxnRwGpy/GDe7YLK0ad8/dd
         m3ma5upUOTnkg==
Received: by mercury (Postfix, from userid 1000)
        id 44E8710605B9; Thu,  9 Jun 2022 23:12:26 +0200 (CEST)
Date:   Thu, 9 Jun 2022 23:12:26 +0200
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
Subject: Re: [PATCH v2 17/17] power: axp20x_battery: Add support for AXP192
Message-ID: <20220609211226.5y7scqlfsxvfd3ag@mercury.elektranox.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-18-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvqy65drvyycmane"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-18-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvqy65drvyycmane
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 04:53:24PM +0100, Aidan MacDonald wrote:
> The AXP192 has a battery charger similar to other X-Powers PMICs,
> but unlike the other supported devices, it does not have a fuel
> gauge and can't report battery capacity directly.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

>  drivers/power/supply/axp20x_battery.c | 49 +++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index e9547e2d7c48..3fa2faa6f0f8 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -538,6 +538,19 @@ static int axp20x_battery_set_prop(struct power_supp=
ly *psy,
>  	}
>  }
> =20
> +static enum power_supply_property axp192_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +};
> +
>  static enum power_supply_property axp20x_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -562,6 +575,16 @@ static int axp20x_battery_prop_writeable(struct powe=
r_supply *psy,
>  	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>  }
> =20
> +static const struct power_supply_desc axp192_batt_ps_desc =3D {
> +	.name =3D "axp192-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D axp192_battery_props,
> +	.num_properties =3D ARRAY_SIZE(axp192_battery_props),
> +	.property_is_writeable =3D axp20x_battery_prop_writeable,
> +	.get_property =3D axp20x_battery_get_prop,
> +	.set_property =3D axp20x_battery_set_prop,
> +};
> +
>  static const struct power_supply_desc axp20x_batt_ps_desc =3D {
>  	.name =3D "axp20x-battery",
>  	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> @@ -572,6 +595,19 @@ static const struct power_supply_desc axp20x_batt_ps=
_desc =3D {
>  	.set_property =3D axp20x_battery_set_prop,
>  };
> =20
> +static const int axp192_ccc_table[AXP20X_CHRG_CTRL1_TGT_CURR+1] =3D {
> +	100000,  190000,  280000,  360000,
> +	450000,  550000,  630000,  700000,
> +	780000,  880000,  960000,  1000000,
> +	1080000, 1160000, 1240000, 1320000,
> +};
> +
> +static const struct axp_data axp192_data =3D {
> +	.ccc_table =3D axp192_ccc_table,
> +	.get_max_voltage =3D axp20x_battery_get_max_voltage,
> +	.set_max_voltage =3D axp20x_battery_set_max_voltage,
> +};
> +
>  static const struct axp_data axp209_data =3D {
>  	.ccc_scale =3D 100000,
>  	.ccc_offset =3D 300000,
> @@ -600,6 +636,9 @@ static const struct axp_data axp813_data =3D {
> =20
>  static const struct of_device_id axp20x_battery_ps_id[] =3D {
>  	{
> +		.compatible =3D "x-powers,axp192-battery-power-supply",
> +		.data =3D (void *)&axp192_data,
> +	}, {
>  		.compatible =3D "x-powers,axp209-battery-power-supply",
>  		.data =3D (void *)&axp209_data,
>  	}, {
> @@ -617,6 +656,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  	struct axp20x_batt_ps *axp20x_batt;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct power_supply_battery_info *info;
> +	const struct power_supply_desc *ps_desc;
>  	struct device *dev =3D &pdev->dev;
> =20
>  	if (!of_device_is_available(pdev->dev.of_node))
> @@ -660,9 +700,12 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
> =20
>  	axp20x_batt->data =3D (struct axp_data *)of_device_get_match_data(dev);
> =20
> -	axp20x_batt->batt =3D devm_power_supply_register(&pdev->dev,
> -						       &axp20x_batt_ps_desc,
> -						       &psy_cfg);
> +	if (!axp20x_batt->data->has_fg)
> +		ps_desc =3D &axp192_batt_ps_desc;
> +	else
> +		ps_desc =3D &axp20x_batt_ps_desc;
> +
> +	axp20x_batt->batt =3D devm_power_supply_register(&pdev->dev, ps_desc, &=
psy_cfg);
>  	if (IS_ERR(axp20x_batt->batt)) {
>  		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
>  			PTR_ERR(axp20x_batt->batt));
> --=20
> 2.35.1
>=20

--cvqy65drvyycmane
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiYjkACgkQ2O7X88g7
+pqAYQ//TZl+Sj1/BciUuF9R1JmWTqHC+Ge+p8yyae0lpXJxi8fM6jEMarZsjYq6
LHByD6fE5Yy2ldr2wgImlMSf4ZFIVF7lne8lrNz9TPJ88c8ML6jtmNHwO/eG+xom
m1B3pg/R2eb8ttcvx9/G40vBVNCflRzLsuIxpfh+Ye0WnIL3r+14XRDKdUL2o1Ic
JiTEEknVkQ/CqiuFlQURWOJ9rGOv5hYrZsasYwg5DKeQCIy43MIU616FlO+WfCkj
SAeoksrqargiCkNZlu7P6c7juqzrhoi8rBXXkxMtx5GOtiNTayztkER2fL9Sudl3
iyEvTqa/e91pVsCjf7N0V423zSqxuKxkOacKEOdL1Or1nSyoa72POFgbHK9jCdcu
yk2XzUChk92vHr0s/jfrM4iMa+SWh39fIoXGTHeqyKAaWR52X1SalSpO2eFFfeIj
h77lNxEX1zdyHrSMNoV6DsYntyyJQM+V+DeqenfRqmCGiAub61gt3yfmvl6qsHjb
pe2QRf+jysNHhUoa2slF/hv7X5CvBo3wwX3/AyMthm9BOFOkatUQnlcGLBVYr39l
AXltnffuW1imvlKwwhxFgOrLE5Pe4Qj9PL//8Y1pDqZlQZA6ZK2K+I6afRPM6XuM
HjoRUjxWPOnfZNRt3PkwggIw4B8U9o4TXKHZ8mBwekvEAFAIX+I=
=S4/4
-----END PGP SIGNATURE-----

--cvqy65drvyycmane--
