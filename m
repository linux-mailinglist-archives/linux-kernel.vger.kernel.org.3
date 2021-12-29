Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61D4810EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhL2IY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbhL2IY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:24:58 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17397C061574;
        Wed, 29 Dec 2021 00:24:58 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 8so17926631pgc.10;
        Wed, 29 Dec 2021 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QpP/fOriBZU5ALSsMR2nG6nas4HRpsPyxC6YF62Vx2c=;
        b=j9uk9JUnpjUOt7dfQ0yEMwROmUlxswBEgQCdu4WYyUITfpiyc7auX0Pgn5fOV2R7ei
         9JITfROw17uDqW5qsQ531P6n5elQei7UkzyhNUO84HQy9t7jkiXcjgWFk0d6v7WEk5Vx
         ZNwRsg2aXzqeqVb9zv8pt66zlbdTHoR0FhYTRHqDXoWtFFnh9LhtDDLNcn+DuipaFqNo
         2QSMe9G2Lq5e9QWLE4agY1yWk3dRaKZlF46nqOinBn9XwhRs9oFvBNmNxpeUUxUNFMnW
         jaT70CyirQYjE8TY6a1rAsLhOF07OqKa7HD95qyPAzboke6/2MFzz3xk+mByESK0NHw5
         DjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpP/fOriBZU5ALSsMR2nG6nas4HRpsPyxC6YF62Vx2c=;
        b=gUhgdyPDt7LpTVs+1UuOzrLZYT7vCrbUiLtXQd+S1xAg7e7LUEB8cWs56fE8EYVMMx
         GTsUfvq/i3NSHwSMlkV0iRkX2OrEBB3kaR1G/tEL83pu1Co5D1EP1QzKO1s3gahV0XOT
         QwtXCpQ0x/6PovPhL+/OJBDKwtN7ukfB9WXdlSDOEg5eipAzdaus9D+iEdBNQfUOXs4l
         Em4IYnhFNP86XSadQiw/hV+1DeYoLAiwRINflzLv0SWBiy+b6ElK5rJ3shFrz18vhGCT
         TNQ84XI2yQIBIcAA+SUaEPuZG8KvHzJoRHeD/wRBDV+JNSorIqSlE0oiCujzyKsJKPBq
         Lhlg==
X-Gm-Message-State: AOAM532sDquvuRo4BW+NLj2qyad8gRVYGA9OE8wgZICWvCNuDmXTTawn
        xNb9vsZEk+BWLm2jMu9/kQA=
X-Google-Smtp-Source: ABdhPJwp4Mbfnq7k5Ae139Iz9pgVH9KiPzPlPjR/lvARyi1hXbsvcxB9aoQadOGHCvqwkKAgd57Dhg==
X-Received: by 2002:a63:4b42:: with SMTP id k2mr22285997pgl.591.1640766297574;
        Wed, 29 Dec 2021 00:24:57 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id h17sm18905710pfv.217.2021.12.29.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:24:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:24:50 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 15/23] counter: 104-quad-8: Convert to new counter
 registration
Message-ID: <YcwbUmZSeyH7rCu8@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b0Pn/YUYWlXUcX5U"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b0Pn/YUYWlXUcX5U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:18AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface =
support")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/104-quad-8.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 6e5286cd1d4e..4315b14f239e 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -52,7 +52,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line =
numbers");
>   */
>  struct quad8 {
>  	spinlock_t lock;
> -	struct counter_device counter;
>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
> @@ -1127,6 +1126,7 @@ static irqreturn_t quad8_irq_handler(int irq, void =
*private)
> =20
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
> +	struct counter_device *counter;
>  	struct quad8 *priv;
>  	int i, j;
>  	unsigned int base_offset;
> @@ -1138,19 +1138,19 @@ static int quad8_probe(struct device *dev, unsign=
ed int id)
>  		return -EBUSY;
>  	}
> =20
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv =3D counter_priv(counter);
> =20
>  	/* Initialize Counter device and driver data */
> -	priv->counter.name =3D dev_name(dev);
> -	priv->counter.parent =3D dev;
> -	priv->counter.ops =3D &quad8_ops;
> -	priv->counter.counts =3D quad8_counts;
> -	priv->counter.num_counts =3D ARRAY_SIZE(quad8_counts);
> -	priv->counter.signals =3D quad8_signals;
> -	priv->counter.num_signals =3D ARRAY_SIZE(quad8_signals);
> -	priv->counter.priv =3D priv;
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &quad8_ops;
> +	counter->counts =3D quad8_counts;
> +	counter->num_counts =3D ARRAY_SIZE(quad8_counts);
> +	counter->signals =3D quad8_signals;
> +	counter->num_signals =3D ARRAY_SIZE(quad8_signals);
>  	priv->base =3D base[id];
> =20
>  	spin_lock_init(&priv->lock);
> @@ -1192,11 +1192,15 @@ static int quad8_probe(struct device *dev, unsign=
ed int id)
>  	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
> =20
>  	err =3D devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> -			       priv->counter.name, priv);
> +			       counter->name, priv);
>  	if (err)
>  		return err;
> =20
> -	return devm_counter_register(dev, &priv->counter);
> +	err =3D devm_counter_add(dev, counter);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to add counter\n");
> +
> +	return 0;
>  }
> =20
>  static struct isa_driver quad8_driver =3D {
> --=20
> 2.33.0
>=20

--b0Pn/YUYWlXUcX5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMG1IACgkQhvpINdm7
VJKviA//TFuL86vhMGP/85sfUOR24yFk8nS6XilVQIUQ2914ptmh7slh9ozIkcQd
xdt2Ji35skjmPDhvoHSb6fj3q69E8gqrD3F9vEpcuKToj61xD1ZxbpIzDV5Hw8xP
dL3bCH4ol/UMH2Bnz+9iIWpG2o3sTKTnyhDElsNwEHjzsAXoftXlZVqCs8ZudQxc
zjnVxc3Lnh+OtqRKctedUM3veucgA4Vm11bDypUvLyi/5eT2Hc2IFUbQ0i8mW16H
21T2GyTb1NVQahMMk3Pl8HB0AZAn/C/Iw1MPZBoUULj0E7fh0eZm514XCKXGLkSj
+Cw15z+Yj32dXXiOnzY0fyNJjGdFxyi/mtC0dJOky3OWfsUGQZe+Y7LxgZcGP8gg
ikGIaMMtQHJZt5UY4LHwOy88DIi4pMbPv72CR5XdbrVSxKCJzjzJJ4qNQ+zhk0pj
CHIoswJ7cdVb++7Hx4BLpjr8YxlKwPt72XVwqIGhdZOTNaUs4/9JrIDLI1y1tyW8
iW/fCdcgMD9p+ylnnWE3HTLUkttZKLs+bx0VdcZTOE4seDr6HKTBh595r9b4BFNY
PrOL25inHSplnYqqmcePK5NA0HGGoD+zpAlKKeYDmhY7azEF/sVl0ygqb/yGBN+j
RIR3mduv+H085Qld5iB6Bz136CG5Tuz6ysAdK8M8iRZkLipTAc4=
=02za
-----END PGP SIGNATURE-----

--b0Pn/YUYWlXUcX5U--
