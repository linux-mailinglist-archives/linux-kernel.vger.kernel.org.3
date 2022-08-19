Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82C59A64F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbiHSTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351497AbiHSTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:20:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36811521A;
        Fri, 19 Aug 2022 12:20:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s1so4511584lfp.6;
        Fri, 19 Aug 2022 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xN5m22WfaWqHbczZVUXbDhaaAcllqpHvQCGoo7vtQ3Q=;
        b=oGku/UZ6JGk6V0C5bLYbPWu66MUuJjgYpY3NGBPivcZhtS7WFLDvjIC8N3BUUM+ojm
         XrqzbPZ7BrMhKgw6iqLfOiywA2/e+V1CI1Bv+ibOwljypZIiJAJvqWYl5GdTGvHtfSGD
         AjC8c/AA3lgjgppMd1cIaGUH2dRgdYoZWaD8x6OXrTYVzs/Sv572IV2k0tCdTTzuCx3t
         2ikwrDFd4TfQyxs2LX1weme559lC2wREdRcP6Dc7/B3NufUGyFdifmPs2+vqf1zmp4X2
         gc4AimqIJ4eobRPhboGYfD+oUL8eSDviG7Sv1YPnqbnnXUpkKhIJwyz8+6Ut4CAQV+ES
         OCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xN5m22WfaWqHbczZVUXbDhaaAcllqpHvQCGoo7vtQ3Q=;
        b=rb86DLwfnmcmt8EIlrK28WfImb5QpWQKawf0p0FzjDUmbuaaxrfvo4P7Uti9Uo9yZY
         VHl4Y2pNeV9GlOtcA1/2Jbb2SRUdHv+/ArKL2MNww2p9SqZ8lwNNpEDl0RmIGH7d6JV7
         HKsA1u18rl0USXGpWTNTiYs38kWNEN3Lh1aPhIOu8h1w3V4xCqJjtLM9FKibeqM414Ua
         +Y09JcDEMuq1SzgAPAOFmwJcqD2Tu4DJg1iBSZ11WbzDxndX/LOrOjgEhucFVtXHtXWt
         zGIEyhc5KzKlpxRJE6abGL0fuOmdvgrO4xOa1uHtct88eV6IU+wn1hw9xEEeX6ZzwdMM
         94XA==
X-Gm-Message-State: ACgBeo2PvdqTdf+00OVr9Bzun5vsRHJshWivUKjMduLFxUR+F5J0nBlL
        sWvygERrGQfmD3bvUCB9TQ4=
X-Google-Smtp-Source: AA6agR6BPAMdFFb/vkSsLm2HrUQWrAH7AmJz5zOLk+hoeikQiaWUiHe1ZL4CVAhLy51sQSCSL2zS7Q==
X-Received: by 2002:a05:6512:3686:b0:492:bd6f:ad4 with SMTP id d6-20020a056512368600b00492bd6f0ad4mr2926283lfs.151.1660936837811;
        Fri, 19 Aug 2022 12:20:37 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p4-20020a19f004000000b0048aeef1b2bcsm725453lfc.294.2022.08.19.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:20:37 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:20:32 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] iio: max1241: simplify using
 devm_regulator_get_enable()
Message-ID: <7c759bf6c06e72ae70bffeebc1939d9903427278.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9JDXN8VFq+K/+z7s"
Content-Disposition: inline
In-Reply-To: <cover.1660934107.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9JDXN8VFq+K/+z7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable() and drop the pointer to the regulator.
This simplifies code and makes it less tempting to add manual control
for the regulator which is also controlled by devm.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3:
New patch
---
 drivers/iio/adc/max1241.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index a815ad1f6913..500bb09ab19b 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -22,7 +22,6 @@ enum max1241_id {
 struct max1241 {
 	struct spi_device *spi;
 	struct mutex lock;
-	struct regulator *vdd;
 	struct regulator *vref;
 	struct gpio_desc *shutdown;
=20
@@ -110,17 +109,6 @@ static const struct iio_info max1241_info =3D {
 	.read_raw =3D max1241_read_raw,
 };
=20
-static void max1241_disable_vdd_action(void *data)
-{
-	struct max1241 *adc =3D data;
-	struct device *dev =3D &adc->spi->dev;
-	int err;
-
-	err =3D regulator_disable(adc->vdd);
-	if (err)
-		dev_err(dev, "could not disable vdd regulator.\n");
-}
-
 static void max1241_disable_vref_action(void *data)
 {
 	struct max1241 *adc =3D data;
@@ -147,20 +135,10 @@ static int max1241_probe(struct spi_device *spi)
 	adc->spi =3D spi;
 	mutex_init(&adc->lock);
=20
-	adc->vdd =3D devm_regulator_get(dev, "vdd");
-	if (IS_ERR(adc->vdd))
-		return dev_err_probe(dev, PTR_ERR(adc->vdd),
-				     "failed to get vdd regulator\n");
-
-	ret =3D regulator_enable(adc->vdd);
+	ret =3D devm_regulator_get_enable(dev, "vdd");
 	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(dev, max1241_disable_vdd_action, adc);
-	if (ret) {
-		dev_err(dev, "could not set up vdd regulator cleanup action\n");
-		return ret;
-	}
+		return dev_err_probe(dev, ret,
+				     "failed to get/enable vdd regulator\n");
=20
 	adc->vref =3D devm_regulator_get(dev, "vref");
 	if (IS_ERR(adc->vref))
--=20
2.37.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--9JDXN8VFq+K/+z7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4oAACgkQeFA3/03a
ocVahQf/bf5z/JOjpwhdbVqyTOIhVJiXKcr2FtWmeaAb4/xAmNwBJYo6vMV4J6Dn
qtkbc5ry14odNgSxCiwh9qRbk0oOwlJ7/xqTJzuqKjrKhfsgN13NZPT7IWz40AlG
2N992o+zmmUjrNN1JC0PEsDz9PC5jOhq6KU09rbvgkKAbp4iNq+2lSb3XgDUVn/b
5m5oJERV1lhUeRVFb8I8Qeh51lTQMeQRptyuuOnQVko8XcKx192ruBhjD+Li84iH
juueuRb73kCaLjau7eVyt/v3gtsH/0kBb8K0TUyizesoTTijWSJ6FKZ7VPXPThPB
02tdAJSx3U120ITPw1Qjx0j7KUGk2Q==
=VAIW
-----END PGP SIGNATURE-----

--9JDXN8VFq+K/+z7s--
