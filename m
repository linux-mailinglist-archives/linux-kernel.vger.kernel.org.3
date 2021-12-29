Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96554810F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhL2Idt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhL2Ids (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:33:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43353C061574;
        Wed, 29 Dec 2021 00:33:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m1so18219710pfk.8;
        Wed, 29 Dec 2021 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ohlU18tQ4aYtdGXykVF7unco2JG80qfPs3s3d9sr1ak=;
        b=ZHPfRpiXh0MN7fO6G4sh/qoudSdmTJc4UNi8wR12vzws2lDYcwvvZMTqxGB5UW/LM+
         /6DeH4I8t8+OMayBzb1htIB7nxTvJf9ODr7lQWcfthZ8hMbfCEvKRQa2FHZj0KZKiQQ9
         95hhBwv9f81o33Rd56F4GFT8f6/8UZK4zmkP4i7DnIKxqI2w+u7gNdrADdkOwG2yeVJV
         ZBwL3z1J7nZFuO3kLvwGFHUk4Km8bKCTe3rH+ntUU2ZjfGidtb9hQo2eUTkyXXdT2OIt
         Hr18+lvHqfuZSfj1f9NApCTDMZxSqINHUZQHfuJEDfurmJjyxBLS1plMnuU9/mpWDp/K
         a7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohlU18tQ4aYtdGXykVF7unco2JG80qfPs3s3d9sr1ak=;
        b=HMye9XRnwJ0uv9w7d9VwZzs1XR2D7uicNcr4idlsuth2xG+XFOL3OQ/mP479SpI2vm
         MSKj/p2BxFnbqDBsN4Iiuu1h+fVUUV4WvMkyC6azSjaL+KqRzODr3mE+SLj+ElHelxdX
         K2ahsPlzfuNVZMdUPlMf4KK3dEU45aanDgTnp1VkYAmVoXvXq9SmyhYntz1Sc1A3Fv6r
         CsA6PepYMEcMREJm4btswwmkFZKRawzbug7HS/l3MNrgutMkA+HzEqaieStYnGXN88ei
         C2bjwI9ScvFma+js5t9xug0U8HLz7H5CHojw4/qnLYutedxMNIJlajdjEtQ+ks2lacZD
         zBpQ==
X-Gm-Message-State: AOAM53187M3ooIJK21GqM9TQ5DCTgyCMFEfvTWz6FkCOv+kabDfVnpvp
        KSyo5bVPbn+5q9Ltitb1nfU=
X-Google-Smtp-Source: ABdhPJzE3J4LKNPh/QARLkKG1hZ97ETW00f6FWFTQG1la0cB35YHEQSNEU+MSdFLrn1cYsDcRI0C6Q==
X-Received: by 2002:a63:9d8a:: with SMTP id i132mr7926597pgd.329.1640766827768;
        Wed, 29 Dec 2021 00:33:47 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id o11sm16036184pgk.36.2021.12.29.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:33:47 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:33:40 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 18/23] counter: ftm-quaddec: Convert to new counter
 registration
Message-ID: <YcwdZLPW1zdbKbhs@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-19-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwT6tQCfgFsgh+Gi"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-19-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwT6tQCfgFsgh+Gi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:21AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder co=
unter driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/104-quad-8.c  |  7 ++++---
>  drivers/counter/ftm-quaddec.c | 27 +++++++++++++--------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 4315b14f239e..680c7ba943a4 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1084,7 +1084,8 @@ static struct counter_count quad8_counts[] =3D {
> =20
>  static irqreturn_t quad8_irq_handler(int irq, void *private)
>  {
> -	struct quad8 *const priv =3D private;
> +	struct counter_device *counter =3D private;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const unsigned long base =3D priv->base;
>  	unsigned long irq_status;
>  	unsigned long channel;
> @@ -1115,7 +1116,7 @@ static irqreturn_t quad8_irq_handler(int irq, void =
*private)
>  			continue;
>  		}
> =20
> -		counter_push_event(&priv->counter, event, channel);
> +		counter_push_event(counter, event, channel);
>  	}
> =20
>  	/* Clear pending interrupts on device */
> @@ -1192,7 +1193,7 @@ static int quad8_probe(struct device *dev, unsigned=
 int id)
>  	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
> =20
>  	err =3D devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> -			       counter->name, priv);
> +			       counter->name, counter);
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index f5d92df6a611..c636183b1337 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -26,7 +26,6 @@
>  	})
> =20
>  struct ftm_quaddec {
> -	struct counter_device counter;
>  	struct platform_device *pdev;
>  	void __iomem *ftm_base;
>  	bool big_endian;
> @@ -259,15 +258,16 @@ static struct counter_count ftm_quaddec_counts =3D {
> =20
>  static int ftm_quaddec_probe(struct platform_device *pdev)
>  {
> +	struct counter_device *counter;
>  	struct ftm_quaddec *ftm;
> -
>  	struct device_node *node =3D pdev->dev.of_node;
>  	struct resource *io;
>  	int ret;
> =20
> -	ftm =3D devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
> -	if (!ftm)
> +	counter =3D devm_counter_alloc(&pdev->dev, sizeof(*ftm));
> +	if (!counter)
>  		return -ENOMEM;
> +	ftm =3D counter_priv(counter);
> =20
>  	io =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
> @@ -283,14 +283,13 @@ static int ftm_quaddec_probe(struct platform_device=
 *pdev)
>  		dev_err(&pdev->dev, "Failed to map memory region\n");
>  		return -EINVAL;
>  	}
> -	ftm->counter.name =3D dev_name(&pdev->dev);
> -	ftm->counter.parent =3D &pdev->dev;
> -	ftm->counter.ops =3D &ftm_quaddec_cnt_ops;
> -	ftm->counter.counts =3D &ftm_quaddec_counts;
> -	ftm->counter.num_counts =3D 1;
> -	ftm->counter.signals =3D ftm_quaddec_signals;
> -	ftm->counter.num_signals =3D ARRAY_SIZE(ftm_quaddec_signals);
> -	ftm->counter.priv =3D ftm;
> +	counter->name =3D dev_name(&pdev->dev);
> +	counter->parent =3D &pdev->dev;
> +	counter->ops =3D &ftm_quaddec_cnt_ops;
> +	counter->counts =3D &ftm_quaddec_counts;
> +	counter->num_counts =3D 1;
> +	counter->signals =3D ftm_quaddec_signals;
> +	counter->num_signals =3D ARRAY_SIZE(ftm_quaddec_signals);
> =20
>  	mutex_init(&ftm->ftm_quaddec_mutex);
> =20
> @@ -300,9 +299,9 @@ static int ftm_quaddec_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D devm_counter_register(&pdev->dev, &ftm->counter);
> +	ret =3D devm_counter_add(&pdev->dev, counter);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
> =20
>  	return 0;
>  }
> --=20
> 2.33.0
>=20

--qwT6tQCfgFsgh+Gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHWQACgkQhvpINdm7
VJJJ4Q/+Kf9p1b6sKhoSyklga86jck59mHXE/U7L348afABV82z4PLGJEYWOVfyr
oreK+DT1mF+JdvUebneVrqPxOuvdiCaG2eSML/hzhIz2qbcY9m8Wi/e7qiSTNSHg
c0F6iEgrZCiQcTQ+KmCbjSdO/UydY+RyIeL4iy43b9zvIPKn3jqNhlPG+T1rihWY
Nkf+tqCXSsEfjv/IaovYERK8tXCTg03pwJcApnSN4nPs8lByNU33EpsDVnt8SPF5
KGZiVL7iDH7Dt1DdyAT9L9U2R7589yXCl0UhFqIMP6SsgQ4Eo2I7qBoTdDO1/fDH
AkwZY94z5WGXjhSAzITQat5LYANio0aqs3ADe432qpZ42zA+gJwMMWmqrcVaCM5o
fEbM+27hZLYJZWOE18cZBMfbgppw9Jm9DFCdTNN5zqwI+yj+JjnLOJmiJxt9XQD4
dndKeu2Y9mFuREiDTuEfUwyb2GeMTIq4c1cwICERK+QRXhwBs8oj37hpn5Tw+PPT
s/5TvTpGBZz1ePCUBwX8QjidSDYtYq04DdRUl+p8VBNm/SsvtI7sdEbSxZfh1qFz
6gQjxbymXfpcvgq1yKH8rRlzto8ve8gCaEAPrKj11z0+pR25yaBeJxHoUWVsT1rg
hPqrog5TiOhU9Syx1ZKzVmGrDikfAI4SNKduOvT3laMo0gCGUO0=
=r2gC
-----END PGP SIGNATURE-----

--qwT6tQCfgFsgh+Gi--
