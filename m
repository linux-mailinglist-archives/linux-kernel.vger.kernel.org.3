Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499F542DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiFHKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiFHK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:29:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56B14FC95
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:18:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n28so26409303edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=1iFwdNwk1v1dXl+OlTTXTF6c13xKzPVa4F0ip2ie7ak=;
        b=R6Uj/kR8aNyvL0If9eAlU2L/SUtOV5vbaXXSJFGtExUlkvqNZfxVvmdTgFsQ2NrLSZ
         21SvpF0O2oQsiB3ERybUBhuX+g5mUi59un0dmQmQcIXLHAjENToLjRBcMdT5c8KnwF/l
         OAcw77biYKlFRWFNGJNZ7g49tOP/menfHXBrYYEOkT9bUxg2ULaWA71hlUqLo6DR5N/C
         gVw6MbDS3N9hd+cmM0kkcGo0j41mjf+SgBTzXJEV9kD9Ym8pCwBJE6j7dN88aep9b1hG
         VG1OUsbuJw+ajdmB9uv7irEt3xbvfXdi4+8xdunJe2Wyz1HJe65nXgiRky1iBon5EOFc
         aJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=1iFwdNwk1v1dXl+OlTTXTF6c13xKzPVa4F0ip2ie7ak=;
        b=kVTzPz/yMolSteDBiYU3RiwnGNf9Anc2kUmFrhw3Lt5DjdcSLFL6hKrl0dW1CS77p3
         OlRope5Ks+mw6TNekVhwvhgC2UFq7OCrlQ0/nZWAEL0Wgiid8gUsS8dw5Gfw7pRwUEeH
         cEJgfIBsievt5JH/pgzv/SLJXK4Hmt6wXSqJiqxp9vAfs7350Lw4ye6NdyMmDxf3LEnA
         hejUepoA3gEk5FVcDoVr2kIfkWD0WqA1OQoc/1ugLkr2Ex++SKu4S0ec6ZHUxLNn8mpu
         v+yYaa/zMTCbN/NuU5RLql3IH+wXGMMLykyeIZyNvZGJFUOGjt+79WrJRIm1YoDRy0UI
         XOgw==
X-Gm-Message-State: AOAM532fB3MK1aja0mVdwp66gpEMpmANTJ1l3FzDieOW3mDyUMZAOxUz
        5CzgcJVZv4xz9h0oGK8yrdSkhQ==
X-Google-Smtp-Source: ABdhPJwhTP+Sm/YUUUagKijKOaUv4aAkFfndIn3NiT0GJBAk3tk/3OR0q9VUBiGxUlwsgKfu44pDNw==
X-Received: by 2002:a05:6402:11c7:b0:42e:c47a:ffdf with SMTP id j7-20020a05640211c700b0042ec47affdfmr29844951edw.113.1654683533557;
        Wed, 08 Jun 2022 03:18:53 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709063b4900b007043b29dfd9sm8894340ejf.89.2022.06.08.03.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:18:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 08 Jun 2022 12:18:52 +0200
Message-Id: <CKKOCWP2NYO5.GH08U776B1KU@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>,
        "Song Qiang" <songqiang1304521@gmail.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 3/5] proximity: vl53l0x: Handle the VDD regulator
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Markuss Broks" <markuss.broks@gmail.com>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>
X-Mailer: aerc 0.9.0
References: <20220523175344.5845-1-markuss.broks@gmail.com>
 <20220523175344.5845-4-markuss.broks@gmail.com>
In-Reply-To: <20220523175344.5845-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

On Mon May 23, 2022 at 7:53 PM CEST, Markuss Broks wrote:
> Handle the regulator supplying the VDD pin of VL53L0X.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/=
vl53l0x-i2c.c
> index 12a3e2eff464..8581a873919f 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -43,6 +43,7 @@
>  struct vl53l0x_data {
>  	struct i2c_client *client;
>  	struct completion completion;
> +	struct regulator *vdd_supply;
>  };
> =20
>  static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> @@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info =3D {
>  	.read_raw =3D vl53l0x_read_raw,
>  };
> =20
> +static void vl53l0x_power_off(void *_data)
> +{
> +	struct vl53l0x_data *data =3D _data;
> +
> +	regulator_disable(data->vdd_supply);
> +}
> +
> +static int vl53l0x_power_on(struct vl53l0x_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(3200, 5000);
> +
> +	return 0;
> +}
> +
>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
> +	int error;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
> =20
> +	data->vdd_supply =3D devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");

It looks like this optional regulator is not actually optional.

[    1.919995] vl53l0x-i2c 1-0029: error -ENODEV: Unable to get VDD regulat=
or

When using devm_regulator_get instead, a dummy regulator gets returned
which I think is what we want here:

[    1.905518] vl53l0x-i2c 1-0029: supply vdd not found, using dummy regula=
tor

Can you fix this up or should I send a patch?

Regards
Luca


> +
> +	error =3D vl53l0x_power_on(data);
> +	if (error)
> +		return dev_err_probe(&client->dev, error,
> +				     "Failed to power on the chip\n");
> +
> +	error =3D devm_add_action_or_reset(&client->dev, vl53l0x_power_off, dat=
a);
> +	if (error)
> +		return dev_err_probe(&client->dev, error,
> +				     "Failed to install poweroff action\n");
> +
>  	indio_dev->name =3D "vl53l0x";
>  	indio_dev->info =3D &vl53l0x_info;
>  	indio_dev->channels =3D vl53l0x_channels;
> --=20
> 2.36.1

