Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9959A656
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiHSTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350123AbiHSTTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D658B64;
        Fri, 19 Aug 2022 12:19:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l21so5379417ljj.2;
        Fri, 19 Aug 2022 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xA/ke3CMJXrkb/C6eCqgufQvUpSsHijYG7v6oeOUAc4=;
        b=dWowpJ0LCyqZDwtRe1d88trfFBCVsxCTFNduJjcPppJ5Lh+G+WKTyvzSxRXeTpwM7q
         +PJiEU3s1GzyiFmg2vGqEhFRXnF34ifXy16Im4iS+DY8cdip1vr8mC0upO1brBs8P5Ox
         iyijFpyU3MGy7y9uNXN+HFzQybNM2maTS+QzHkS+ARwPiUhZYtQV5Mpose1WbEpBWh7m
         jEuETxgdF9ZJsyBmA1Sx6cr892ESmFR0Zm92yVmuaHZkkPjXOzjX5yxpa9ZhtgNH3r1P
         BDFeJy+2uP4Q1dKDz9U08nyPbA6OtjsHI40+/SX94BucHZmOSFXSmXBILfY7Z2yDbA/l
         X4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xA/ke3CMJXrkb/C6eCqgufQvUpSsHijYG7v6oeOUAc4=;
        b=i3jFypHUpgjGPCXuF88ouCjthJEYQksIN54iDCvqNIkL7z5YKlM+Ka15lwf29mpBVz
         hBNFVLolNJdPHpsaH+RDlF7etJv6ut7e86IC1qNWhRXgOmXlg+WqqhsU2Cp/rSP4Pabw
         4uUaXxOvGgQm3SgzWufCOAJgacPlma3aTJJ3idiuM81DdnVITOhtlELrkn2x2uUJk/oL
         m7PT+m+YKXOzrXD5SRuSqKedobCg7aO93xy0glDcphXU/c7m69eGHsmc9bgDzn+yPrfI
         HDuBq/v/E+i1rncE3IooaoMWKFUko3x62N2J6UNsu8apANYyaWM6HItr8+wAG0Ay+r5+
         fYzg==
X-Gm-Message-State: ACgBeo3HWqdAnMlPcmMNWWmJ6HuiRUg0KNQC8UfeTGzXISHPVwX79WPy
        WUmWd0Rj4UsvSiLAb/ohVmI=
X-Google-Smtp-Source: AA6agR6u2y6WF2xMTdFM70O9C5CrrEg40+35FhcdAC5vhKEcF3Ob0kFN+2ZM+IuaiEYci3u39ZC0Bw==
X-Received: by 2002:a2e:a987:0:b0:25f:d70a:c63c with SMTP id x7-20020a2ea987000000b0025fd70ac63cmr2654996ljq.34.1660936792127;
        Fri, 19 Aug 2022 12:19:52 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512314e00b0048c55ff738asm735230lfi.246.2022.08.19.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:19:51 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:19:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] iio: st_lsm6dsx: Simplify using
 devm_regulator_*get_enable()
Message-ID: <876e58428cec056d51070e49eff559e2d7c23b12.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T0x+DgDWieL8u5Ui"
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


--T0x+DgDWieL8u5Ui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
bulk-enable, add-action-to-disable-at-detach - pattern.

A functional change (which seems like a bugfix) is that if
regulator_bulk_get fails, the enable is not attempted.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3
Split to own patch.
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 --
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++----------------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index a86dd29a4738..03238c64c777 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -372,7 +372,6 @@ struct st_lsm6dsx_sensor {
  * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
  * @dev: Pointer to instance of struct device (I2C or SPI).
  * @regmap: Register map of the device.
- * @regulators: VDD/VDDIO voltage regulators.
  * @irq: Device interrupt line (I2C or SPI).
  * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
  * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
@@ -395,7 +394,6 @@ struct st_lsm6dsx_sensor {
 struct st_lsm6dsx_hw {
 	struct device *dev;
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
 	int irq;
=20
 	struct mutex fifo_lock;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index b5e4a4113652..c328d1a36d34 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2172,36 +2172,20 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_h=
w *hw)
=20
 static int st_lsm6dsx_init_regulators(struct device *dev)
 {
-	struct st_lsm6dsx_hw *hw =3D dev_get_drvdata(dev);
 	int err;
-
 	/* vdd-vddio power regulators */
-	hw->regulators[0].supply =3D "vdd";
-	hw->regulators[1].supply =3D "vddio";
-	err =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
-				      hw->regulators);
-	if (err)
-		return dev_err_probe(dev, err, "failed to get regulators\n");
+	static const char * const regulators[] =3D {"vdd", "vddio"};
=20
-	err =3D regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
-				    hw->regulators);
-	if (err) {
-		dev_err(dev, "failed to enable regulators: %d\n", err);
-		return err;
-	}
+	err =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (err)
+		return dev_err_probe(dev, err, "failed to enable regulators\n");
=20
 	msleep(50);
=20
 	return 0;
 }
=20
-static void st_lsm6dsx_chip_uninit(void *data)
-{
-	struct st_lsm6dsx_hw *hw =3D data;
-
-	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators);
-}
-
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -2225,10 +2209,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, in=
t hw_id,
 	if (err)
 		return err;
=20
-	err =3D devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
-	if (err)
-		return err;
-
 	hw->buff =3D devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
 	if (!hw->buff)
 		return -ENOMEM;
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

--T0x+DgDWieL8u5Ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4lIACgkQeFA3/03a
ocVpWQf/Sc350NbWcAsugxB6MA/Cq1pCWMME+eKXjr8+mAR0k4pelsFT/7kwJrV0
pPmRKqUGkJWnALVBS8djDSSED21opoEWywP2wTudS8JKgXC6qo7W3v8tXfzRH0qd
ahHjLNuutZ+EbH8no1gsH3S3ADuVUsHys93/ZeMrviwzSk6ra4BbWfRGBCMSYKPh
8YI+zISZDTw1/ot4VO1gPOqeMGGrawq+1jWwt6ssgiF2VNFQTDkENSNxV5H5Xkzl
uQFnXpj2iSQEpdOZiqCTzVIuAthK5MPYcT2e0NI5Jnbssq6beslNAD4fIB13EMOr
7AqJwVB6LwZZLQeh8VXzeSKt2e86ig==
=mrLA
-----END PGP SIGNATURE-----

--T0x+DgDWieL8u5Ui--
