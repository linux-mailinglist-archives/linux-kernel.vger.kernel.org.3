Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2E59A65D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbiHSTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351331AbiHSTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:20:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067896D9E6;
        Fri, 19 Aug 2022 12:20:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z6so7286193lfu.9;
        Fri, 19 Aug 2022 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Pb/vY0IBh75ZxywBj3v0sp843PBbdLtQyqNhmT3+yDY=;
        b=Lc6bZjFhO4FgG/ECahM5tfFzfVv7QznDYxYW+vyWZl5wUwNh+9D5my2vtz1wPmRHDi
         RdZEUfILboDCP2srh+Kr3JiH5wfUBTbQqETUemABjxBJWHaHZhDhQ6Jo0gI0cxkyx3Xd
         CrY/AyciFVtr+dUP67Iqu56O0hQTxAb0m9NlrrCNpdx0YbgdIL2yKOVaum3/tG3KPixR
         fnJarH/DYbmMnpaJxA6jDzjb4PT+0lXIWjTNDCOWD7xoxRagwXikcTQV7mBP8lowElRH
         ourck/o6z8bQJ589jOeT1O4gpJjC0992rXG19RsJB6Hqt99xzoSSLgYK18SrMnOWr1YA
         y47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Pb/vY0IBh75ZxywBj3v0sp843PBbdLtQyqNhmT3+yDY=;
        b=v+6BEClQVoTntpU9d56dWOjZB73JErVUkq1HRWefKKwLEDiiGpbtvFev6EkcoD1aU0
         dBi7OljGqsTjsEt98+SWeem/LrLSZrTDKu7FgyDLvtaMvmg+Qleu8prs9y3I0ibAfxW5
         ELeP9MDbFVSQoLTCG9wnRBp8xpcpL0bapLWvkt7Nz6H3MuG9/g+aenYn+uXh8gHekqVS
         X2uwAsdq5W4dWErIquW/fRadPbo0IaxchBQeo+/eXI6ETJGreOxckYdjdkMS3fZDLirT
         qnNzFFIku9WDjFuUgj/Aov4z5yUbJFoBRcISqW2Vwe6XqQ+J0dgJkfpmGeDL/TVNyJ9n
         KCpQ==
X-Gm-Message-State: ACgBeo1bo0FfRQDlMH3B0JC7aZkkbv5XxBD0UqTRljI3MapxV1rDLqMB
        0ObbwU7jGnyxcAGvhCkxjZA=
X-Google-Smtp-Source: AA6agR6sSl5AeA+spE/uhfMLz4mNqOIZlUn5Ia6HGVZ+eGY6fNoTHtAREYsO/rTgc07wCXPidRCxzQ==
X-Received: by 2002:a05:6512:3d20:b0:48b:9e72:fb42 with SMTP id d32-20020a0565123d2000b0048b9e72fb42mr3149772lfv.299.1660936809121;
        Fri, 19 Aug 2022 12:20:09 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t22-20020ac25496000000b0048b0c8fb31asm734602lfk.159.2022.08.19.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:20:08 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:20:03 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/14] iio: ad7476: simplify using
 devm_regulator_get_enable()
Message-ID: <33070d66b9b976acac1cee5570facef9278b6b61.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm9CdEeZsbDL3Vq4"
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


--sm9CdEeZsbDL3Vq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3:
New patch
---
 drivers/iio/adc/ad7476.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 94776f696290..80aebed47d1f 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -368,16 +368,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (st->chip_info->has_vdrive) {
-		reg =3D devm_regulator_get(&spi->dev, "vdrive");
-		if (IS_ERR(reg))
-			return PTR_ERR(reg);
-
-		ret =3D regulator_enable(reg);
-		if (ret)
-			return ret;
-
-		ret =3D devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
-					       reg);
+		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
 		if (ret)
 			return ret;
 	}
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

--sm9CdEeZsbDL3Vq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4mMACgkQeFA3/03a
ocVzEgf/TG+jFl9iACX6tPNOdWMzAvnPdfaVWuCd1x/EcQNiHMoyd48YbCdWbJcj
tYtpRzl0GryW/FvqxGuQOJC/3338R+IMutP/R88DL8t/isTXGfXx8Jq6tLy2/FNG
l8Sxf7tRKNYg0gyRCYcoVYrWzw/4U2YoWuIuC7z7Hpu86Fb6UuYnwuEjznfTPDDX
jhs9Ft+ldVOGlmOoJxXALhFUL5mO99nUs9mbcEiIVUCL7Ru9J5DHSLHkW0ni1NF1
crFl0MtLuuGvZ1ONKExBVOHIfWCm8AWLm9aEfd6bp72rdV1LHtz2NG6M7mV/xkTi
aXx8EJi51KR2pIc5JJWuQJFyYjSWKg==
=rFR8
-----END PGP SIGNATURE-----

--sm9CdEeZsbDL3Vq4--
