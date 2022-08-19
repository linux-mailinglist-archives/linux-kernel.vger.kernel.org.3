Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9359A641
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiHSTT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbiHSTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB205E55F;
        Fri, 19 Aug 2022 12:18:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s1so4506404lfp.6;
        Fri, 19 Aug 2022 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=aMEbqvytZlUJMMl28d1AuV3CNp9y2QjtQtIdhhovVv4=;
        b=gIadf8mB2Kx9WMiePQZi9Jv0EZMezRfVqlRlhLK/Rd3UirsYohPD4aAmR8ITfT8hmc
         qz7U91IXU+LY+ml/J1Lo3Ic5yozUw4GqaXyS7/8oCNhVJvHhXfQnYKpw8tJnEKw2pIj+
         G1i0TC/dNk8cAJQWbPenl+QrqukEuD+qe/E4gblZA6GTmt3jnzxf7o9SbS8vENceGhy/
         pqBv1HL0QtPiy4or77DQW1blIulx9JYRTPpPEoMvR8ByRt1+Tjc0isPhe50g+UJ/wjwv
         pVOB9gvKHcHEO7YhRHp3sjd67dMvBor7Q8I4vbSNd2z26ith+qSQeb8R5xQWLQLAm0zO
         Q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aMEbqvytZlUJMMl28d1AuV3CNp9y2QjtQtIdhhovVv4=;
        b=tVJGSIvUQWVVOptlQfLLgoekWh/GS1Vx7qe2B+p/47HWFTNqTtK8MuqGYwm1mB0bkC
         H06uN/rqg8KCHo5eLqPb6iQzlGIvwSmCeyawrRZbUsxTY/WQ8XqDhQHuHM6pqWIf1TJE
         W8nMXDHQjHqFj4mIFZgtpgeXaivbrOZ7aOBnOSO+P/uWRitNe5uEsAoyVsAJdhph1GUW
         9WxBnGlwGiuzmF974RFA3CvOoF7GIeuX/azO4qEqzrxF2dW6H3AfC6BYWvUH5Dxw4B6L
         Z74GSoR5MnvnZkmUiy91RRQGiiI7abMYeSpELOQIACsSMlNOBpVhvN0/m36f6QBoJeF/
         FmPg==
X-Gm-Message-State: ACgBeo0iGN7jqFmkMLGmZ96LofZVBu85CCeVRw27cEsJfC0zoouH29YL
        Xvci1siFWw3QbuyWMwfvCVxXdls4yo8=
X-Google-Smtp-Source: AA6agR5nbDb+I2QpqHZOuRkjziXPveSnUcr5lKPFvl+QCrNtXuMvJZXULwp+DLeJ2qJBabFR5ptRcA==
X-Received: by 2002:a05:6512:1c5:b0:48b:192:a29e with SMTP id f5-20020a05651201c500b0048b0192a29emr2697709lfp.250.1660936731449;
        Fri, 19 Aug 2022 12:18:51 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id bf12-20020a056512258c00b0048a88c07bcdsm738818lfb.20.2022.08.19.12.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:18:50 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:18:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] hwmon: adm1177: simplify using
 devm_regulator_get_enable()
Message-ID: <718e4ea3a54c036dcb59ff55c338e253735e516b.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u4933oyvJYU7rlVS"
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


--u4933oyvJYU7rlVS
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
 drivers/hwmon/adm1177.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
index 0c5dbc5e33b4..be17a26a84f1 100644
--- a/drivers/hwmon/adm1177.c
+++ b/drivers/hwmon/adm1177.c
@@ -26,14 +26,12 @@
 /**
  * struct adm1177_state - driver instance specific data
  * @client:		pointer to i2c client
- * @reg:		regulator info for the power supply of the device
  * @r_sense_uohm:	current sense resistor value
  * @alert_threshold_ua:	current limit for shutdown
  * @vrange_high:	internal voltage divider
  */
 struct adm1177_state {
 	struct i2c_client	*client;
-	struct regulator	*reg;
 	u32			r_sense_uohm;
 	u32			alert_threshold_ua;
 	bool			vrange_high;
@@ -189,13 +187,6 @@ static const struct hwmon_chip_info adm1177_chip_info =
=3D {
 	.info =3D adm1177_info,
 };
=20
-static void adm1177_remove(void *data)
-{
-	struct adm1177_state *st =3D data;
-
-	regulator_disable(st->reg);
-}
-
 static int adm1177_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
@@ -210,21 +201,9 @@ static int adm1177_probe(struct i2c_client *client)
=20
 	st->client =3D client;
=20
-	st->reg =3D devm_regulator_get_optional(&client->dev, "vref");
-	if (IS_ERR(st->reg)) {
-		if (PTR_ERR(st->reg) =3D=3D -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		st->reg =3D NULL;
-	} else {
-		ret =3D regulator_enable(st->reg);
-		if (ret)
-			return ret;
-		ret =3D devm_add_action_or_reset(&client->dev, adm1177_remove,
-					       st);
-		if (ret)
-			return ret;
-	}
+	ret =3D devm_regulator_get_enable_optional(&client->dev, "vref");
+	if (ret =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
=20
 	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
 				     &st->r_sense_uohm))
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

--u4933oyvJYU7rlVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4hUACgkQeFA3/03a
ocUNjwgAyCPy737spbVpgQaN6ZKyydBYYE2OFVzkMXRTIRlB7/POi3ZdPDiZTgcP
RUMt/nprmh1Gq6OgTbcXoI3hLcqdMAIYZy+JOV02zhqfDvFHPpex2TnTvi39546n
fDzS83O9DJqMs9RutKxZnpU1ZJqFa1BYQN9jy3dJmAdjKK8un47/QILBWnTJoH0Z
NE0cMUFjulUyV6HwG+OJ62z6mjiMaYHHiY3K5jo48Jo3UGmXWI3eLUbUXdIugnZb
RLtmax91JSbEFCTYQIB6qVnyBD1Foe2Sr14ZB4919p7hEZUWXrLeOSrQIJA7FpFJ
oTzFozHrx1gQKXg3dwMYAS9clqWfAA==
=jkTb
-----END PGP SIGNATURE-----

--u4933oyvJYU7rlVS--
