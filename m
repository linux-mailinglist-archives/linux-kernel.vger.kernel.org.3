Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABEC59A64E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiHSTTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350533AbiHSTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7595D0E7;
        Fri, 19 Aug 2022 12:18:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so469794ljj.1;
        Fri, 19 Aug 2022 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jprm91vcKRJS/hTanVO5ROf+R1e6XJUOtpxFg5YEv3Q=;
        b=k1sPKigibldx7grJUyJGFstnb7Ggxn/iLAJ1ZHTnQb8djXRlbfs9QIFtn1Q3T5z/kR
         RC9hbp1CLpv2zMIXnLiAsztOoCC06uSpR93d0jUkGApWFC7wZcOF4T+18Reqm78hPwe1
         rAVi908ZbARPe+9Pp+j+duDqQT6K29TPnvd/ekNjvkayO4H8Hmjxb/aM08JNsBZIPONz
         vxvZcec8gaTU22IZI/bvP/pNhp/JNhRa04cHqXcLfJ1Mw3kD4bsNzMMgNE8MsK+Xr4W7
         1z/P2DkFvMufWOXoejoMXu2WfXYXNCKNTChHeUdVTUdjkeTlk7PbKnDovjd2OpPeX8TS
         hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jprm91vcKRJS/hTanVO5ROf+R1e6XJUOtpxFg5YEv3Q=;
        b=qaRuuGo+pqk/juOCpaOVDXQcLRxqvG7Tq+TMmsUhBNLZQRCCdr7ivY2zVmrCj1AE+x
         y1iAxRV+L9jSRl4QA3dqNylceLwigqXRP6dkY6IIv+i2vkbMGjnbjqUSCcl0sIw8V/XG
         fNJ2osY+JqVd2XhpwCPzO18pyzp1FQSVNo0gf8ULSgg4vDehNRLYSI3Z0M3KfLwNbk/l
         +E+D2Dr9fp9uYb7QO+Jb6PGUbr+XDwSQwoivMOSRhOf4z7Sn8MwrD2vy0UOtuBN/525d
         Tl9D1F6i7GefnViim4hqyRTFbtbmjD+kBHe0bBkn2N11+TzZfFLBsdmYGQSwIuWDgUyR
         zLbA==
X-Gm-Message-State: ACgBeo3NdfLAA/JF/D6o5C6tHvXK9vus91ZbvcwAAhai/SOINchsSQBr
        VBQ25AjJN7aB0dXYyjGeR7s=
X-Google-Smtp-Source: AA6agR6SLF9Swby4h1bQ0oIDt7dX1fKvB10z8PCkXUiAR91Yht1nuWx8IfWzYUYerYygMl5dUqd16Q==
X-Received: by 2002:a2e:a4aa:0:b0:261:a5d5:6699 with SMTP id g10-20020a2ea4aa000000b00261a5d56699mr2410541ljm.104.1660936713909;
        Fri, 19 Aug 2022 12:18:33 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o19-20020ac25e33000000b00492c463526dsm582723lfg.186.2022.08.19.12.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:18:33 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:18:27 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] hwmon: lm90: simplify using
 devm_regulator_get_enable()
Message-ID: <a75e100bc856f650e2a836b20d65e637b428fff7.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kr7Dy4Xq/Tv4XywG"
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


--Kr7Dy4Xq/Tv4XywG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---
RFCv1 =3D> onwards:
- No changes
---
 drivers/hwmon/lm90.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 221de01a327a..6356d92547e0 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2749,24 +2749,13 @@ static int lm90_probe(struct i2c_client *client)
 	struct device *dev =3D &client->dev;
 	struct i2c_adapter *adapter =3D client->adapter;
 	struct hwmon_channel_info *info;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct lm90_data *data;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, "vcc");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err < 0) {
-		dev_err(dev, "Failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm90_regulator_disable, regulator);
+	err =3D devm_regulator_get_enable(dev, "vcc");
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
=20
 	data =3D devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
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

--Kr7Dy4Xq/Tv4XywG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4gMACgkQeFA3/03a
ocXn5QgAye6CEWo+fVIqvpitzJYV7WY2ka4g7odch1qUbFpAW3N1LaqrJUJJ2VPx
tzpdOXBlAPbS5nYq4U9FYW5TUnnHWZn9UDyyMB9WrggEvHbuUxRhpq3SwVA8uPf/
H1Uu5b8C8jPiqici/X0SkoWqacY3eGKLzARaVZk07d3XOpo0N9kicxUxwSkflARg
ArbRC6rqK0fMFGqaOokgQ/m8kpnjYBOaAO6meiWYz7TknRnS0O4cWTUIrEapExtF
V3jBqZcVAWMD6cvFEXQv1xlzJSesFwmJ7fFcosF/r/BOkn/bGGc+ov+Hg5FCg0jx
THqv8zUQNXeoX4BMaUBfWkvYfe7b8Q==
=p1Mf
-----END PGP SIGNATURE-----

--Kr7Dy4Xq/Tv4XywG--
