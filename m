Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84F59A655
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351465AbiHSTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351429AbiHSTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:20:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880AA4CA39;
        Fri, 19 Aug 2022 12:20:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d23so2943003lfl.13;
        Fri, 19 Aug 2022 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FdWk3y+T5Xz7F0ok6QUYuKZuWMUSNYttRlt11tcAS4o=;
        b=GZxVL7QRvxWWsB/hSG7pqSJMKuQnlrju1SMvDxiWaoMfVBtuJ3S4dmMCdAJQDsI6D7
         aEo5jmgCPgWLU5qB17qMeZVJCVcvITK8Fi+PX60t1DCkiLaPkkTVj6cRdiValj58BsRn
         1PBAd1QOPVJYxXf5YMO+vc33IAwpBhiNFBeBaiw1DEtgW66QJYzqNpGo9DUOYthYDLa6
         MhdATPVcFV+lpi4KckDcKkdLB0vlntgXdbfKjvC7g87aIuW906+yYWuE2IbSjkV51gIx
         kMYoNcRnoRNKvpa7kvcyDLuhbkLOjzLqrtFgLHxeFDldhceMI0+d6g684fF738oVBJe1
         jnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FdWk3y+T5Xz7F0ok6QUYuKZuWMUSNYttRlt11tcAS4o=;
        b=JZRYiHc5toWRHrr744RR5AxXE/eNHTjzuBObp3VkYeDi+hb2OECbUWm8i+c/aq0AP1
         y+7lge7xow4B9QGarj32wjL60tQJ09l7/5WRrzLUo3CK+HVm60JDeZBDWgKkT6RSVINJ
         mbyqgsoylzmZFDsYoMWipeGmOZzJpW0JNhmxqb23PzgC1m1kuLG67mUJRGQg3e+Eq47g
         uypl0ivOOAQKAJZ9mzFSjPtSwQQg+ed4GstcwNindtXQg2NTW3VrVIlkRyDDAhOQC9Q6
         Laov8fzHr7U1MHOT4KDp+Cp187SWIKKiZ4BC2sqwX10DoL7QsN11Js41wm9MxK+5OsN2
         6wcA==
X-Gm-Message-State: ACgBeo0CqeNd+oc6d6nMyaP8clKb5XaX6boZ67Mjs+xgxLMHT+e6/MkO
        xx+SF55cNzm6qf79YDcgKa4=
X-Google-Smtp-Source: AA6agR6Nm6+xYuT0Cdd/DZvMSYDopH8+KN7zKoa6NqMWE7jDy4ZBgO1w5bvayvM5+eeSUhM4+mjQdg==
X-Received: by 2002:a05:6512:358d:b0:48b:37f:dce2 with SMTP id m13-20020a056512358d00b0048b037fdce2mr2608198lfr.267.1660936823571;
        Fri, 19 Aug 2022 12:20:23 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w16-20020a19c510000000b00491aee1c4a5sm734450lfe.168.2022.08.19.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:20:22 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:20:18 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Message-ID: <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NuFHVMOYP8wka0QR"
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


--NuFHVMOYP8wka0QR
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
 drivers/iio/adc/ad7606.c | 22 +++-------------------
 drivers/iio/adc/ad7606.h |  1 -
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ba24f99523e0..dd6b603f65ea 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -557,13 +557,6 @@ static const struct iio_trigger_ops ad7606_trigger_ops=
 =3D {
 	.validate_device =3D iio_trigger_validate_own_device,
 };
=20
-static void ad7606_regulator_disable(void *data)
-{
-	struct ad7606_state *st =3D data;
-
-	regulator_disable(st->reg);
-}
-
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -589,19 +582,10 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem *base_address,
 	st->scale_avail =3D ad7606_scale_avail;
 	st->num_scales =3D ARRAY_SIZE(ad7606_scale_avail);
=20
-	st->reg =3D devm_regulator_get(dev, "avcc");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret =3D regulator_enable(st->reg);
-	if (ret) {
-		dev_err(dev, "Failed to enable specified AVcc supply\n");
-		return ret;
-	}
-
-	ret =3D devm_add_action_or_reset(dev, ad7606_regulator_disable, st);
+	ret =3D devm_regulator_get_enable(dev, "avcc");
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to enable specified AVcc supply\n");
=20
 	st->chip_info =3D &ad7606_chip_info_tbl[id];
=20
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2dc4f599f9df..924a2d1a6d94 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -92,7 +92,6 @@ struct ad7606_chip_info {
 struct ad7606_state {
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
-	struct regulator		*reg;
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range[16];
 	unsigned int			oversampling;
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

--NuFHVMOYP8wka0QR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4nIACgkQeFA3/03a
ocVRrgf+NPBP7qqu1t1Nw99acj0nZhtS+3U+kkuLTi54o8l5iVobEWRur6Pgwq6a
oKNgMA6LKWCSHqDsSsW/mU22JRWx6ftGxF7L6RaeHsltNHhbsSIlE1uWtXP7nro/
Pg+uw72Fhy+43Ccu4Q8mlvHrqI7jfZtA+7+Oc0fkfgb1WuZpxlE59fC4dcxAHmn3
GB9LnE500lPwahzN17ljNChh9ERcnn2nuNI2O+PBA4zgt8IoViv/TsM6rDcxAAKB
Rnc/NUEeyYfYJ/83a40olHwZ9HbhA22nxgyDtA0SvlIqTkiAeaD9LFshDldAQysc
TqkSCIQH7m4TTC5rRXzeexqE7STtqQ==
=2D9G
-----END PGP SIGNATURE-----

--NuFHVMOYP8wka0QR--
