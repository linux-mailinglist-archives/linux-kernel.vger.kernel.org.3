Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3814810E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhL2ITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhL2ITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:19:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F5C061574;
        Wed, 29 Dec 2021 00:19:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mj19so17947558pjb.3;
        Wed, 29 Dec 2021 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zPn0YNREPKaJClRU8OUBuv5V6sERBqg4ufLucMLumk0=;
        b=mgzk9DsAP0eR2g9ltO0Q8KG/EEd3W+u0rVeQ7HKBKvJW3pljnb8rh2yJ3/ojrUD1BT
         SQyfMGWGPDaoNMgp6jDTxPloykAPJX18xYaMeLoB3u1OwUOPVacreMs6GqBFrSJBk+3Z
         S51bnQpHj3MkOMUgvTMQhtKz/xzVQNzicpvms+Pz8QLGsR2Oy4fjUG47pelSmUoi2El0
         3nHvf/b7nZcOsbCstq1DppY9ihBtCtzUQJErA0IiHyxrI0ph0HSAMWiArD8vrT2FMHIX
         g6GCDfZOo2AvbLjt+Yd7Zk0bNwcEvG6QO2mdangBLDu7g1CgNvRx1GKo+tjFq3UcUMIe
         /B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPn0YNREPKaJClRU8OUBuv5V6sERBqg4ufLucMLumk0=;
        b=zC+Ja5Q4EQIVICx+xdx/TEyDVlosJMTYpiRbiMH1IyB0U9DlJewRSrG7N+Wk/LSzmO
         SVYG7VuE/26vyOlWbN3h3seUGxHSvUF7hdryyU9ilOTz8tgYT7VSztink7K45ttwmsf5
         sX9ai50zZSKHy4es6yuNRqEHg8IkiDhennMTriofPxQJbYltxAvWgbd+YOm3lhd7enLe
         YthgU1XyO6yZWx6DVZcaZnwlWQZ+FvCOzrxMabWG4ux50gyrURtjCDhb4153+7IiSey/
         plEmeCYR1oB7OXDOGJjvnsxQz2plCpydL7W9X8uJYKQFeYU8FIotMW3+jgXI7mV/663u
         hg7A==
X-Gm-Message-State: AOAM5321NbGYsfzzgjEAJd4PsK01oZ9aNg+9uJloPo+jkQ6+qWe4xz4+
        A4ICBfDTpjXZgWJvtJKn+xg=
X-Google-Smtp-Source: ABdhPJzl70tcYj6SxenoavRIdG+UzS83FufJNpSHgFmxCilmYnGvctYhJblG/SxSlYdUMNP5HZMMAg==
X-Received: by 2002:a17:90a:28c4:: with SMTP id f62mr30673551pjd.207.1640765963703;
        Wed, 29 Dec 2021 00:19:23 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id o11sm20885308pjs.9.2021.12.29.00.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:19:23 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:19:16 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 14/23] counter: Update documentation for new counter
 registration functions
Message-ID: <YcwaBLxR5Q0u7Pbh@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-15-u.kleine-koenig@pengutronix.de>
 <20211228181222.72ab998c@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="geXJ3MLhspaaBqeG"
Content-Disposition: inline
In-Reply-To: <20211228181222.72ab998c@jic23-huawei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--geXJ3MLhspaaBqeG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 28, 2021 at 06:12:22PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Dec 2021 10:45:17 +0100
> Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > In order to replace the counter registration API also update the
> > documentation to the new way.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Fine either way, but a suggestion below.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > ---
> >  Documentation/driver-api/generic-counter.rst | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/generic-counter.rst b/Documentati=
on/driver-api/generic-counter.rst
> > index 1b487a331467..991b180c7b47 100644
> > --- a/Documentation/driver-api/generic-counter.rst
> > +++ b/Documentation/driver-api/generic-counter.rst
> > @@ -262,11 +262,11 @@ order to communicate with the device: to read and=
 write various Signals
> >  and Counts, and to set and get the "action mode" and "function mode" f=
or
> >  various Synapses and Counts respectively.
> > =20
> > -A defined counter_device structure may be registered to the system by
> > -passing it to the counter_register function, and unregistered by passi=
ng
> > -it to the counter_unregister function. Similarly, the
> > -devm_counter_register function may be used if device memory-managed
> > -registration is desired.
> > +A counter_device structure is supposed to be allocated using counter_a=
lloc()
> > +and may be registered to the system by passing it to the counter_add()
> > +function, and unregistered by passing it to the counter_unregister fun=
ction.
>=20
> I'd avoid the supposed to and the odd vague use of structure in the origin
> text and just go with
>=20
> A struct counter_device is allocated using counter_alloc()...

I like this simpler wording as well.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

>=20
>=20
> > +There are device managed variants of these functions: devm_counter_all=
oc() and
> > +devm_counter_add().
> > =20
> >  The struct counter_comp structure is used to define counter extensions
> >  for Signals, Synapses, and Counts.
>=20

--geXJ3MLhspaaBqeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMGgMACgkQhvpINdm7
VJKEHxAAiM4FpOf1LHAPzY0VW7ZrYmEIyT1WH9atJ4dbXN8JeDRS6OklfZfHcH07
ZYjulTVrOKg3dEWSil6xQqESAj8tSVtrfotEM8VOD+4x+v0pXGU7u2tgBnlEPcP1
cB1ze+RvUqGO584fStC81q4huvosT9Jnd/iSd/XzGBVeOj2AY2r0dQjGQygLNuk2
M2gGv+jvF7ZbZNoqXBl/GlHLuLTeiEcoOXL5YG2d2p7grHUpIPWhPZIsqTS+LjcI
4oiSKx3MXlYfDYCKmQrIuocOLowkB3rLUAmsBLjOR9SCOqQq/spQeRhzWGQYjEwZ
E2IB+6F6xQBAzq6wzMjtkRqjUdtJtg/4hFVouaf3PkTB/QVBrSOIeFd7jVPbZaIy
+4kedob1brY0mxLiOE7Z0cGzNS/Hn0UnwZhduvEaGZLh1rVlIWDQnLLf7NdGpraz
oVnhEkZGsGzp9TUZdT84E5LDoAHnrTWHr41VmtneIPH1yMiQIi6XrAmGABnolbJR
8rq5Ob915k9U6A6bfQf6XwLGhZPKNBm0BnxBYr5JcfaXEVdX99TmkQPlA4N4+zpC
pJ5NeZlHEsnj8JtjKFDPX5Us0zPOTd3lBuirkVLnLf423d5QzPyDgj57ripIT+ZN
gw2m4kENozFwiRX0cwPzxbbSqTZh1ZBqWsNBZ/IfSMnK7rnewVo=
=2iIA
-----END PGP SIGNATURE-----

--geXJ3MLhspaaBqeG--
