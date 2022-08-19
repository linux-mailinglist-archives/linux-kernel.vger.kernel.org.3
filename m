Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C159A645
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbiHSTUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351371AbiHSTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:19:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BFF4F;
        Fri, 19 Aug 2022 12:19:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l1so6776390lfk.8;
        Fri, 19 Aug 2022 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AANLxeJ0LpA7gGpSl1Si3QPJ6JAdv159yU2e2glG7p8=;
        b=DsvV8zNJOqwTBy5DNUpgWBkMYnMY5LZZwKR79UqkxspV1lqtqz3+WHbLFY9l/tQIGn
         2C0XuxGAZ9AtM08pWBu2/uMDCtkNlICuR2SSN2gzsh5vAljxtJBI/m79Qi757gsTj6dA
         82E9gFLnqgPB0pLzcLYCb+D6SFDYQSjeJGWyZYij3dMxtO1m0YFp4z82uIrFLCYgSMOj
         sJb/I6jjHGvWq1qKKDOx4+ckdtDQZUW38H4kO+UYdOQmEyqii8i1IqnleyP11OKveFww
         LB8rNoJnCMq3VfZbF3SpN9399ul+MVM+xMUmsNXQDCShjl4YGB4iIHwnCE0bXxEECfLR
         VZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AANLxeJ0LpA7gGpSl1Si3QPJ6JAdv159yU2e2glG7p8=;
        b=o9sQBA12lb0EpYS2u1h8WpDLebWcmZmaDollXpsyoXKOLoE9vOraYDfPqFi8BKyLer
         qopRvqqaKPKYecbZpxCPAHAW17NBA5eZ7BTSclXH1SdMcAnAtqDhZqly9MVrSEb5jAm3
         PsITmTYMJusnj+mnJYX7z8bSWwnEv2IjH6qH4Gt+NbklySvZxbtB/Tad9Jh8iG625Kkq
         qfIIQVRJU55vjKlyQkeeEMA0hjSH32ZP+VmhDTt2cQbQQ7uytzS2dA+S8niaAkDmMwET
         qrYmw+Od523X8roS9KPydDaQgkWraAYFj2+p1CaPWDwPuISDmDQ+wuWTPSGhahEdqDQN
         Mntw==
X-Gm-Message-State: ACgBeo2MIQQUIWyu2J1010bOCdTBahsNdEdRD86l/OvL50ujYd9IypJ7
        enOxPR0qsgESdROG4rzhlHw=
X-Google-Smtp-Source: AA6agR51+Y9+XrHdyIIEGtNp4Q/w/K7E3YqgGy2J+KZPVECydq1v4p4Cw5CW4w4QIEU3eTwkM5wpDA==
X-Received: by 2002:ac2:4da2:0:b0:492:c6a9:f430 with SMTP id h2-20020ac24da2000000b00492c6a9f430mr1683375lfe.96.1660936747173;
        Fri, 19 Aug 2022 12:19:07 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a16-20020a056512391000b0048aa9d67483sm736249lfu.160.2022.08.19.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:19:06 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:19:01 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] iio: ad7192: Simplify using
 devm_regulator_get_enable()
Message-ID: <9719c445c095d3d308e2fc9f4f93294f5806c41c.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KxTzg4jangapt1lT"
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


--KxTzg4jangapt1lT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use devm_regulator_get_enable() instead of open coded get, enable,
add-action-to-disable-at-detach - pattern. Also drop the seemingly unused
struct member 'dvdd'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3
Split to own patch.
---
 drivers/iio/adc/ad7192.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977be7d22..8a52c0dec3f9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,7 +177,6 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
-	struct regulator		*dvdd;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1015,19 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	st->dvdd =3D devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
-
-	ret =3D regulator_enable(st->dvdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
-		return ret;
-	}
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
+	ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd su=
pply\n");
=20
 	ret =3D regulator_get_voltage(st->avdd);
 	if (ret < 0) {
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

--KxTzg4jangapt1lT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4iUACgkQeFA3/03a
ocUZLwf+JbL6zuVBJlnV46AIvw+ntaCXEUN/wFR0BZ8xSsci6CkfCOiJfQPfpKpj
3JzYAZPNf8mAyGaSorL0C14Xcr5tMlRwFDST7dxK9VS0KeOzBCzCENuRoUjF2XAN
UfzOzR+kL/dzBgYNamxYktwWxRcAdwjfSnaVYq8+Sg11aDr0SUg1E9fiG6Wk2mGk
KTVKIasov6CEMM9zqOS/DJoZxqxd4alkC6x4F6t/vivhbNsCazkDXj+3qjZ5/9CC
Ukua7P5azJA0+p+TuYCdpgGuZBq7DRI36kl5ARMpsSOCTLtj/5wcS+0JK1KDSRC8
lJ3dgQDt5MCtzMmHTexoRv21Q2SWUA==
=oIFB
-----END PGP SIGNATURE-----

--KxTzg4jangapt1lT--
