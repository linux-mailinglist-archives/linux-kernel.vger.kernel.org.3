Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6762E4A9416
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbiBDGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiBDGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:41:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22455C061714;
        Thu,  3 Feb 2022 22:41:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 200so4072815qki.2;
        Thu, 03 Feb 2022 22:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y3VBysFzp1kRvgau2cMx1aSqaX9MmIj4iq8W0jdx/e4=;
        b=OIuZqO1OIXVeWVnaiyLGJVRL3I6W/hyCBabm1Zy0YuNodpqx9vGtIcZxcIGJYCTmYo
         E/y3ElBCa23/0THZUUZ9MWb7cYEsSjdaNgBDzkXbOpZkHaHmTHeG0wmt6abTgjATn/SW
         gH9vn304BW5NQnfJoe6Jq+x27hOBGjfWtjLdW9iPTa5//CwBL6b0oIAkXs8m2x2++uxR
         oz/rdx62ONw8ymolVqSu+nPPUKDKRmgH5xE8oqpDEmIgWOLnVSAgtp0VetN+Qa34OcH7
         juWPSC+b3G2RYGWfSyuPa0BdBG9IgLBzDBzMzTPVZFKEfaRTN9JkuGRstB2+OWab8/R7
         p4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y3VBysFzp1kRvgau2cMx1aSqaX9MmIj4iq8W0jdx/e4=;
        b=0/mfE9LOKsDmm3D+HkX8zdP7sAoDjxqwCJZ0WBJLQMHTLjRsKIZ0z+mm5lB6KX1fx4
         J2yj5anJ1PFyZNv1AW1TqskNuz11y85dpu1lXac+oZcsaN9fmWEUU/WbROFpAW1efLSm
         BIh4+okok+3U9rXswdfR8JZGzqHx9AMAM2H8/zThjDooaS4mgfxgAKBhIJHvhWu4domJ
         RlqlFhfnSU7q0i5cMV8C2lED8v7NT5gN0u3LyS4jZEMgTwcMaC701tGm7US4mVM/1a1J
         e/Z7bS2Y5SHxZhSehZpoSk2tPBiwQ3OX5zNk6xRX5MAW6i4GUmiX48a6LH6BAZalhje6
         ZZdg==
X-Gm-Message-State: AOAM531ekbRVDDWcBhsYuO1ySui3BAB88V5aSIQxu84OaMyTLOQvnZj9
        YFVwHhYh0FXJM6qRFJdtBoVA7AVgGZEyAA==
X-Google-Smtp-Source: ABdhPJwy0IQfuUSq9u5lwkcYWdm2c3eASYnBBQ4Y+lCyz9oYJ8XM0ry3tukzDPa2M4UR599HYv2rkA==
X-Received: by 2002:a37:68d4:: with SMTP id d203mr777487qkc.79.1643956898081;
        Thu, 03 Feb 2022 22:41:38 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id 195sm615793qkf.30.2022.02.03.22.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 22:41:37 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:41:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: Set counter device name
Message-ID: <YfzKnWJTwiWgOofi@shinobu>
References: <20220203073459.90093-1-vilhelm.gray@gmail.com>
 <20220203090053.oki5ts4c2gdpi2c6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SGhrym32gYZ7uNn8"
Content-Disposition: inline
In-Reply-To: <20220203090053.oki5ts4c2gdpi2c6@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SGhrym32gYZ7uNn8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 10:00:53AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Feb 03, 2022 at 04:34:59PM +0900, William Breathitt Gray wrote:
> > Naming the counter device provides a convenient way to identify it in
> > devres_log events and similar situations. This patch names the counter
> > device by combining the prefix "counter" with the counter device's
> > unique ID.
> >=20
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/counter/counter-core.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 7e0957eea094..2ebd9adf0bd2 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -22,6 +22,8 @@
> >  #include "counter-chrdev.h"
> >  #include "counter-sysfs.h"
> > =20
> > +#define COUNTER_NAME	"counter"
> > +
> >  /* Provides a unique ID for each counter device */
> >  static DEFINE_IDA(counter_ida);
> > =20
> > @@ -104,6 +106,10 @@ struct counter_device *counter_alloc(size_t sizeof=
_priv)
> >  		goto err_ida_alloc;
> >  	dev->id =3D err;
> > =20
> > +	err =3D dev_set_name(dev, COUNTER_NAME "%d", dev->id);
> > +	if (err)
> > +		goto err_dev_set_name;
> > +
> >  	mutex_init(&counter->ops_exist_lock);
> >  	dev->type =3D &counter_device_type;
> >  	dev->bus =3D &counter_bus_type;
> > @@ -119,6 +125,9 @@ struct counter_device *counter_alloc(size_t sizeof_=
priv)
> > =20
> >  err_chrdev_add:
> > =20
> > +	kfree(dev_name(dev));
> > +err_dev_set_name:
> > +
>=20
> I think this is wrong as kobject_cleanup frees the name.
>=20
> Best regards
> Uwe

This is true once the device is initialized by device_initialize() but
that won't happen until after counter_chrdev_add() is called; if
counter_chrdev_add() fails, we need to free this memory lest it leak
when we return the error code.

I did notice kobject_cleanup() calls kfree_const() on the name rather
than kfree(). Would it make sense to change this patch to call
kfree_const() instead?

William Breathitt Gray

--SGhrym32gYZ7uNn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmH8yoYACgkQhvpINdm7
VJJBBQ//a+ffB0x18Li9NKcR4HsguAJsIwcQwPjK+c8ukpJt5TdehDpEPwiWAyH4
M96rUrFA+yF1YHVnxyzC3Lt2+MdLm8D8gcQQdCnCCc+SJBJoW/pC1fid9YBGT8z2
TeXbDlOLwGgxj9CQv4sABfrO79anUegPmLnaN/6dtlbROlV7m9FL7C51RmnCIZXF
Tf3dTBdv3LbhdlSwI3y7oEmLKjuIg75iU7ucFLm3ygLylr9jEGUSHRkED2nJafRO
j38xgBNlSEBqwj8KD9yBChzk5DybNLguyWzkEQeMrprDxR+st+2mARK1ANHYgzX1
P0c/r1qKaW0g9JmKrp7/ADuf2h5u3ZHnaF8SR8mZOINL3IN2MlEWuRD9StY8YcR7
k7gFwYyN9cfq41W9HEgG4VYYUyqnwTKdSNrUy7AizaFTReodMQuokOhLKhSWjzY2
GP1Tjtj8D+uirxcmnKNhPk21hUPrauakmcDcnDkdcSR+HnoplvO8P+8DWFvcJ8vi
QI3BiMJ500FccYJgdvykUQuwsD+ex0XqSTqnlHpkqTQjPl3A4PBy4Q3twDM/Ro72
sQmzWg0w8dNWlt0+VbD3UYBIzVcNzNQ5xoxljaWtrEKG1zDsG3uJFnx06+Pu4TQc
qBx6q8u83SpUVzbWPMQwobTNTha98h860gK2tGPd/JrHv7HQ/jc=
=FRuA
-----END PGP SIGNATURE-----

--SGhrym32gYZ7uNn8--
