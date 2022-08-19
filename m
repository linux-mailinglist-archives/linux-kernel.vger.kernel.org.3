Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E559A659
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbiHSTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350791AbiHSTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:21:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B69A115596;
        Fri, 19 Aug 2022 12:21:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e2so474874ljj.1;
        Fri, 19 Aug 2022 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3f/bG1xCcH9GlVDTu4IzFUvz5kFlob5DxhGhmkJbqE8=;
        b=UCyMDvX/1FVk1yWhyHofjNsW9oECG44IwYhTOrlo2KlNMkFv95nrgnmiQPvF+TveQF
         l2MxXibmbK9uqtYV+IX807QQ2BanWvX3s754doGrYt5CaQ7SBz7J5RPkteMftGnTef50
         4GsSk0CCeaDtXsRpnP9lWBHX4h4igKZqUAnePldKa7gl+vQr/8cT8cFFhBmpqz/V4avx
         CyeLa6HCUV2oa6ZJvL2LfsK+y8axCMWiy7qzdznZ0eXLyBGUeAb9evfkWqC0QjQ2hfpZ
         SY76pRX27eGh/P9I2HisCbOMmg/POwjECFzZgKGNdCbsMzQF63NuPGAI5BKomOeZ1/qK
         eL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3f/bG1xCcH9GlVDTu4IzFUvz5kFlob5DxhGhmkJbqE8=;
        b=keGPt8X5ep5QXM8jJnD2sWdL721aL9VfDrbtBLtK4ZXx9zX0L+CO3Cbr0mW4aq23SH
         G9dbyyc3eu4W1MKii2pdgENNz8QAzKMFL6VjdUHcZs1g7ESWqE0GEUqTQIrRqTSnCoMK
         76jlRQo40eMbqYDF+P3AFFj5OxaYhEuOUmkYaboBeZlKTqsRzZcnhVjLQaLtdREkUn8S
         vYeCX8SYB2h++Ny9/AJw/EzXjXmS3a0q1Ks2SDhdjErsrwzdLOnES41I9PjXBTlhiTkf
         1qFUsaD8jRwa8LSRaJsfSXq51AyT4JGLfArwgWzx6ANvBgN1ItK/Rxb+8BOQEZn8sX2d
         Q5Iw==
X-Gm-Message-State: ACgBeo11KIocwz5ZdxRb2XExWMGUDMyBicMfzRG6DlpttYFus9yTqNgS
        N3kmFBR776CLUiCUPNoDqHk=
X-Google-Smtp-Source: AA6agR6uM1ayQwnZqYrF0fmvp6E2av0FzUwAAh/AwkDnw0AXgdhgSv039E65NyLc4bXqZ9P1zcVs5g==
X-Received: by 2002:a05:651c:179c:b0:261:8fbe:b729 with SMTP id bn28-20020a05651c179c00b002618fbeb729mr2606226ljb.114.1660936852242;
        Fri, 19 Aug 2022 12:20:52 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id d11-20020ac25ecb000000b00492b494c4dbsm738480lfq.89.2022.08.19.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:20:51 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:20:47 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] iio: max1363: simplify using
 devm_regulator_get_enable()
Message-ID: <1286ea127d190e5708a0aaff271819b2d3f8802d.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cC7KBBHJIm82dlyL"
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


--cC7KBBHJIm82dlyL
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
 drivers/iio/adc/max1363.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index eef55ed4814a..d900e29d6cb7 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -169,7 +169,6 @@ struct max1363_state {
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
-	struct regulator		*reg;
 	struct mutex			lock;
=20
 	/* Using monitor modes and buffer at the same time is
@@ -1603,15 +1602,7 @@ static int max1363_probe(struct i2c_client *client,
 	st =3D iio_priv(indio_dev);
=20
 	mutex_init(&st->lock);
-	st->reg =3D devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret =3D regulator_enable(st->reg);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(&client->dev, max1363_reg_disable, st->r=
eg);
+	ret =3D devm_regulator_get_enable(&client->dev, "vcc");
 	if (ret)
 		return ret;
=20
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

--cC7KBBHJIm82dlyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4o8ACgkQeFA3/03a
ocU5yAgAgK2Nt6SPIs45tZgSmQ3sttM72aM1RgJ8PaRyzr0iVPEv9Rr1MK6/9Z9u
opF00Mt5nmUMlc2sRo2eLti1N7MFVEn8cYOpW2Cc+DSC6rwHSnguJwQASfmj7P1N
DR0nF55ZLuMkN5OFWP52YKFfvSOyIlHFY8PYD3btMTJvUopqxZOhQdJnxBjcSK+j
pQGUFwv6x88XJYhMKTCQAftUNFeEDfBGJ7pNE3x7XoqCP9K/ReNd+vzcseCloVa2
l6Rt7oc52ADt2WiGtVu1sUQq7QNBOmEHwqlT9u6WbIYRdgeGhAg8WZTc6QkmHkMb
+tr9/0CmKkypKujU9qGLmXK+/y9Jaw==
=1ejk
-----END PGP SIGNATURE-----

--cC7KBBHJIm82dlyL--
