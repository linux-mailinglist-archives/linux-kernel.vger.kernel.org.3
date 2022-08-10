Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE958EB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiHJLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiHJLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:32:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3FC73934
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:32:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so20840454lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0n1Y/OzhfJeE+j8g4UzOYZL6N5O4tDg71xSPH024khI=;
        b=kA7ZPWE9auNagXtgXGfNtwEbiMHmU8S7bBqOGTC5NBs+JJVZUXFFFEKRBKXN0LiZTT
         8P2baQgcumnHOmqX6NsVEjubxnpriOq+frTO+MO9OeJaYrKLoifhAi7spYfhjOGPpc3y
         /ymTjg8OFT7ro70OslfoDXPppb7eNMwKTJTDA30Gddtjtl4aCrS5bq2+0lwscyTjwPgZ
         9XqVPHRM7dh7/p8X7XwoaajDzVBGXk1VM6g2+HW02gSiMnKvuyadkG18Jhgnln7nzXph
         qujTz7lr0LXTEintAq/wjENu1LQF89E4HU2Wm7mJglCYq5s9eQaZghukzoNwdYwEdEpF
         TaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0n1Y/OzhfJeE+j8g4UzOYZL6N5O4tDg71xSPH024khI=;
        b=iP6ctlIWRl8jpt0vAznvWp8UZZQyn3/OCqR6dYb+KkF14K/3gquCCoX8lll++kXiEa
         HaJt4FVDlyjoAgFTbdUcGfZvYazWK2CoDp0RJ1nk1z9P78INKP543zqpwe4ZPhqLzUa/
         fVIjvshC/NOYdT84o1XtA6BM5O7AtW8IurB9esOtomdg+33rrIzXrS/8qK+/3L9sMJf/
         4hfCOiaPIXIOZvCkzyRpxDdO28iae+Ns7DN0QGwSL8hcHE+Sr4YtgmnT5UQpjuQK5bqK
         jH+z5U95gTiKil0P97/4/GoKThj4Mfvag6eSQz9m6ew2ierC1XkeXjEyEUsrb69dwPYq
         Uo+Q==
X-Gm-Message-State: ACgBeo38sS5m3pd8NwdwtTFocUYa+pKWNxLe/9NhmBo2ZF9kMYtEhhOW
        ohWcGUfJbDv7RRvMOzroIV8=
X-Google-Smtp-Source: AA6agR4HJ7z9C6Qx/mQgUXeus0gaIaf5bRpOkkYd5YSpgaeaMscj9In5G4yyt6jyUcuHoI4k+C+cpw==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr8901373lfa.689.1660131121036;
        Wed, 10 Aug 2022 04:32:01 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v10-20020a2ea60a000000b0026008acb55asm134927ljp.113.2022.08.10.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:32:00 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:31:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] gpu: drm: meson: simplify using
 devm_regulator_get_enable_optional()
Message-ID: <cc21cea63a24bf5d372e4a5903de303516c3db98.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ON+BJfnFjobaZBs+"
Content-Disposition: inline
In-Reply-To: <cover.1660127865.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ON+BJfnFjobaZBs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable_optional(). Also drop the seemingly unused
struct member 'hdmi_supply'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/=
meson_dw_hdmi.c
index 5cd2b2ebbbd3..7642f740272b 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -140,7 +140,6 @@ struct meson_dw_hdmi {
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
-	struct regulator *hdmi_supply;
 	u32 irq_stat;
 	struct dw_hdmi *hdmi;
 	struct drm_bridge *bridge;
@@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *m=
eson_dw_hdmi)
=20
 }
=20
-static void meson_disable_regulator(void *data)
-{
-	regulator_disable(data);
-}
-
 static void meson_disable_clk(void *data)
 {
 	clk_disable_unprepare(data);
@@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, stru=
ct device *master,
 	meson_dw_hdmi->data =3D match;
 	dw_plat_data =3D &meson_dw_hdmi->dw_plat_data;
=20
-	meson_dw_hdmi->hdmi_supply =3D devm_regulator_get_optional(dev, "hdmi");
-	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
-		if (PTR_ERR(meson_dw_hdmi->hdmi_supply) =3D=3D -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		meson_dw_hdmi->hdmi_supply =3D NULL;
-	} else {
-		ret =3D regulator_enable(meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-		ret =3D devm_add_action_or_reset(dev, meson_disable_regulator,
-					       meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-	}
+	ret =3D devm_regulator_get_enable_optional(dev, "hdmi");
+	if (ret !=3D -ENODEV)
+		return ret;
=20
 	meson_dw_hdmi->hdmitx_apb =3D devm_reset_control_get_exclusive(dev,
 						"hdmitx_apb");
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

--ON+BJfnFjobaZBs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzlyIACgkQeFA3/03a
ocVZnwf+Lv1xHGjupIg4noibrWXhjS6WmrvGpZqs49VnTsvbxRbVPjEzn6JfF+8i
SbHdoe+KSl5d/OfYx7CtXlQnJwJ5qLZHIaYcMewnJHMzQwSWQdeu+/W6DbAmuPPi
rOZtSzW/jDUANoxUtDX5sfgimagrnUWh1VPSxOz4CYjq6r77TquMfF1hclrECSVD
DrElf2B0R3Yw2OHJmoWsg80uk96ZURuXJB1/H5entU0CMKZZbpEeX2hhYDu7c6rl
EXbfot5+kVmIc7PwYI0D8ysIXmylHqKzJUqy8kMiL9zHXNm+eXeBvpxry7ryt2S5
7wITQS0z6ReN4U0nhXrniyBKGJ8MIw==
=4h4p
-----END PGP SIGNATURE-----

--ON+BJfnFjobaZBs+--
