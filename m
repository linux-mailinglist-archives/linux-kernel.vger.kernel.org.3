Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BB585C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiG3VjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiG3VjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:39:16 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB16140A9;
        Sat, 30 Jul 2022 14:39:15 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 05CA81C0004; Sat, 30 Jul 2022 23:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659217154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0daU3v2fIejze8e0Ia8wFFodJagNwi3O4A6fbhcoNFw=;
        b=nvmXEkIlufuCuADE7W3fo3bh8pPJSwZYnNRkZhKGcWDMxTCfRq984x+KvTN4H6f2vlpyiM
        /cnzn8y6rYglONMozthc08Q7DgYW5MQFWQOMQb0LPadgMByGYwFI0jcahYf/N6YmYq9WG9
        fnDgsc1liVG/XbLM7PlQT0PH9N/UYDc=
Date:   Sat, 30 Jul 2022 23:39:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v6 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Message-ID: <20220730213913.GJ23307@duo.ucw.cz>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-12-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1y6imfT/xHuCvpN0"
Content-Disposition: inline
In-Reply-To: <20220722102407.2205-12-peterwu.pub@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1y6imfT/xHuCvpN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>=20
> In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> support hardware pattern for constant current, PWM, and breath mode.
> Isink4 channel can also be used as a CHG_VIN power good indicator.
>

> +config LEDS_MT6370_RGB
> +	tristate "LED Support for MediaTek MT6370 PMIC"
> +	depends on MFD_MT6370
> +	select LINEAR_RANGE
> +	help
> +	  Say Y here to enable support for MT6370_RGB LED device.
> +	  In MT6370, there are four channel current-sink LED drivers that
> +	  support hardware pattern for constant current, PWM, and breath mode.


> +	  Isink4 channel can also be used as a CHG_VIN power good  indicator.

That does not really belong here.

> +struct mt6370_priv {
> +	/* Per LED access lock */
> +	struct mutex lock;

Do we really need per-led locking?

> +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> +				     struct led_pattern *pattern, u32 len,
> +				     u8 *pattern_val, u32 val_len)
> +{
> +	enum mt6370_led_ranges sel_range;
> +	struct led_pattern *curr;
> +	unsigned int sel;
> +	u8 val[P_MAX_PATTERNS / 2] =3D {};
> +	int i;
> +
> +	if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> +		return -EINVAL;
> +
> +	/*
> +	 * Pattern list
> +	 * tr1:	byte 0, b'[7: 4]
> +	 * tr2:	byte 0, b'[3: 0]
> +	 * tf1:	byte 1, b'[7: 4]
> +	 * tf2:	byte 1, b'[3: 0]
> +	 * ton:	byte 2, b'[7: 4]
> +	 * toff: byte 2, b'[3: 0]
> +	 */
> +	for (i =3D 0; i < P_MAX_PATTERNS; i++) {
> +		curr =3D pattern + i;
> +
> +		sel_range =3D i =3D=3D P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> +
> +		linear_range_get_selector_within(priv->ranges + sel_range,
> +						 curr->delta_t, &sel);
> +
> +		val[i / 2] |=3D sel << (4 * ((i + 1) % 2));
> +	}
> +
> +	memcpy(pattern_val, val, 3);
> +
> +	return 0;
> +}

I wonder how this works... you are not creating private sysfs
interface, are you?

> +static int mt6370_init_led_properties(struct mt6370_led *led,
> +				      struct led_init_data *init_data)
> +{
> +	struct mt6370_priv *priv =3D led->priv;
> +	struct device *dev =3D priv->dev;
> +	struct led_classdev *lcdev;
> +	struct fwnode_handle *child;
> +	enum mt6370_led_ranges sel_range;
> +	u32 max_uA, max_level;
> +	const char * const states[] =3D { "off", "keep", "on" };

We'd really preffer not to add "keep" / "on" support unless you need
it.

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "led %d, no color specified\n",
> +						     led->index);

led->LED.

> +		if (num_color < 2)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Multicolor must include
> 2 or more led channel\n");

"LED channels".

> +static int mt6370_isnk_init_default_state(struct mt6370_led *led)
> +{
> +	struct mt6370_priv *priv =3D led->priv;
> +	unsigned int enable, level;
> +	int ret;
> +
> +	ret =3D mt6370_get_led_brightness(priv, led->index, &level);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_field_read(priv->fields[F_RGB_EN], &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (!(enable & MT6370_CHEN_BIT(led->index)))
> +		level =3D LED_OFF;

Just use 0 instead of LED_OFF.

Best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1y6imfT/xHuCvpN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWlAQAKCRAw5/Bqldv6
8iZJAJ4qzsQ+kDbVr0DLe73XiNVWQLaLHACggNs2AFQVJvHz/l7A5pngOaUPVfo=
=EXCb
-----END PGP SIGNATURE-----

--1y6imfT/xHuCvpN0--
