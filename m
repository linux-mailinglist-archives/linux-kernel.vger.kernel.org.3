Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DAE59A66B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbiHSTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiHSTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008ED114A4E;
        Fri, 19 Aug 2022 12:19:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l19so2216974ljg.8;
        Fri, 19 Aug 2022 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+shOGg3Tz+kG6HTarECyFtwcGQNn5JtMbQQqiFqaNwI=;
        b=bjm9EA/l2/yd4W4EVgILA9jpnKLjihtFbs1lqazlL+jJkmUuZK6UqnGtsrdTUlL2Ei
         wetnUavAiz/04AbwDVtTPcw4sqjeQSwwKuEzjORCdWy7Rd8+z59MhYyaZyoZjZQVk4mj
         XNsQ8d0C/dGrEqCjcHkKLYflnhcJ/YSGgmDASQvlw7qPGq4jPUw4XZzXGrkq+qMArzpC
         Miz7BBxLct/rSOeO00NrYFz+SfNyiCUowJqBaIyxPdlQBrPSiBlJB7DVzbUM8MB/dHwb
         EmVq7414CXDDdYb/KMlShNFI5g/H9NcmI4tagTYwmk83uEKRLcOCA/Ptd9sNHjgoO2q3
         yQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+shOGg3Tz+kG6HTarECyFtwcGQNn5JtMbQQqiFqaNwI=;
        b=jClgFsejBZSx/8BB82JP06TV4Ib5jo00tU5TqDTh3uzi0FGC7pGv7FWyz9ntdnSnbV
         bvfa7HlQBzFdCysZIJXnP8nu9fjAKLy3GKdCw8Wg/rzPMWCFS8fT3vehExvsLZ9Opkkw
         Sj0K/YOx8WaCQRxm0PAwKWt5Xy500Gzh8lO5vWJD9Pc8HRav63WJpY/xuQ13u1NT85un
         vSYR5o88J5ghUh0nrgtMOj2T6oDko+TH7Ux/xTZZSPF/lQ9RlVv8pfL9c5ewg33ueIiH
         NbLsGtRC/umTBVi8jR42Ovwpn7ivWUAhNz03H6neKSQeNdQlkekEtfXA1VJ7f8/Ck8w9
         0Z+Q==
X-Gm-Message-State: ACgBeo3RZtWGV5wkfYNBSeslj7vPIoVotg/6eOYQ5KRzCMpypMH27iPe
        cMoSt1FYiK4rixH1OPEz95dht0Vnfbc=
X-Google-Smtp-Source: AA6agR71sEnW/+gDMUEVRtuiTSKTMimhnGKZQe30ADzWZ4sCFdlHu9NpwU51np65ZeSqUCYIkwNkdw==
X-Received: by 2002:a05:651c:222c:b0:25f:e654:36e3 with SMTP id y44-20020a05651c222c00b0025fe65436e3mr2500674ljq.20.1660936776934;
        Fri, 19 Aug 2022 12:19:36 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a22-20020a2eb556000000b0025e428ba415sm724768ljn.38.2022.08.19.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:19:36 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:19:31 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Message-ID: <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfOkIkP7FI/FFc+j"
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


--cfOkIkP7FI/FFc+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
bulk-enable, add-action-to-disable-at-detach - pattern.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3
Split to own patch.
---
 drivers/iio/gyro/bmg160_core.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index cedd9f02ea21..baa80980c99f 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -93,7 +93,6 @@
=20
 struct bmg160_data {
 	struct regmap *regmap;
-	struct regulator_bulk_data regulators[2];
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
 	struct iio_mount_matrix orientation;
@@ -1067,19 +1066,13 @@ static const char *bmg160_match_acpi_device(struct =
device *dev)
 	return dev_name(dev);
 }
=20
-static void bmg160_disable_regulators(void *d)
-{
-	struct bmg160_data *data =3D d;
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
-}
-
 int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		      const char *name)
 {
 	struct bmg160_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	static const char * const regulators[] =3D {"vdd", "vddio"};
=20
 	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -1090,22 +1083,11 @@ int bmg160_core_probe(struct device *dev, struct re=
gmap *regmap, int irq,
 	data->irq =3D irq;
 	data->regmap =3D regmap;
=20
-	data->regulators[0].supply =3D "vdd";
-	data->regulators[1].supply =3D "vddio";
-	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
-				      data->regulators);
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get regulators\n");
=20
-	ret =3D regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				    data->regulators);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(dev, bmg160_disable_regulators, data);
-	if (ret)
-		return ret;
-
 	ret =3D iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
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

--cfOkIkP7FI/FFc+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4kMACgkQeFA3/03a
ocX4NggAkxPBjRLgqJ4NbOZL2teGFmO4r0iSmiy/rcLPf/kcKaaw0JNIVOLT9AkB
rbntW66Z2u9KFPYFP9H3GvsHocyshRXVjURxF+iUf/3jHsRjdSINgyX9ZhyVASUi
c+vDUr6eLiigG/0aXP7ham1+j29HVlSUeX3O9PIAJBtVht60Y4vd6KINUmjZLAC+
8BHPcm2ZdamO9EuTsfW7g4hTsSDYwQ43xN5fTBoLPOJUsUFr3OEu2yV0BEOzqTS9
n2EdECw/lvBt8vB6vYmMVS+9X/UoDJqJSH7lq6qVln3l/N3yP5CIM0oEBMdB95Y9
7qH5tpvvUU69tGjEfeIE5kpO9xXkSw==
=CsSz
-----END PGP SIGNATURE-----

--cfOkIkP7FI/FFc+j--
