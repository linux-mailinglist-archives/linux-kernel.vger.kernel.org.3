Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAC59A651
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbiHSTV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351480AbiHSTV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:21:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7A1155B0;
        Fri, 19 Aug 2022 12:21:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bx38so5352767ljb.10;
        Fri, 19 Aug 2022 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=a+PnZAwbnyxlFPa4YTGTR9Nn3kx7SIjA9eZbEWP7QKo=;
        b=i6hF2TK47IL6OucnkuO0ZZDBdrZCY0I+aqauSm7cwbQFP/lMdEasMpn5cTmwY6/oHY
         3p4h/c4nLLavxgmnBPIXrPWybBgsUw2WWlLeSVGcg2a3NMPpWDwH+74wWJ+PGUVBECJS
         tP2n22FsXCwrrf2B+qrOw0w8gTfTLXO3+BFbm+S7cfIIP8wEzpxOBcWsd9rXTZPN4slb
         qcxxhFnNbcsNMulPd2PcNwGw7VgtHHKI+jRrADrfoYwGvjr+bYrJxXthZO4A4X6zgsQi
         sGptDDE+M1btRF2FMVxoeIBy0IkYU1P4GmFEwAFwmwM9SOVb/8VFbu0hZNoQqO5x09uF
         UwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a+PnZAwbnyxlFPa4YTGTR9Nn3kx7SIjA9eZbEWP7QKo=;
        b=ZNbc344OVhkNnEhoBKDkSUj49clwmsRoDVm4tUlYpjUD0q2gPconEPqqBSoRkgLEVf
         GuNa6XFmoAIpcrIh59D0h+OSB1cxMh+2PAaK1sAdUFj51hifpTh+jaXFFnLtZtQqR7E0
         cKhpw6AUjoYF9crqn7AES+4EBEDJuWRoDy5s91r8QLMyfALskqxUZi2hKJ6kphp3CkNC
         3gbR5UgCpvMOCgI1txoUddJrpwiVAP5SDsImt4r9ArfeKdWfOM7igpCiDFimaTZ1CwJ8
         Y7LHef/735MguwKcizKiys6bRrWE4ldT63NuIk57u93yD1WdKyGiduf0u68/nzduBnX+
         oYZg==
X-Gm-Message-State: ACgBeo1dxyqup1kCTsSTmXQjkHtJ1zz9Xo7u77O7B864/xjgmyyHjB8B
        WmSnSkjg6XzLmozYNHRA3EM=
X-Google-Smtp-Source: AA6agR46yG7niNqKEUERouB3aXkhxNgAps0NbeAnMPogiKGrAyKrNvIAecpExpxeJb0itxekUn1sXA==
X-Received: by 2002:a05:651c:1026:b0:25e:77f3:e0bd with SMTP id w6-20020a05651c102600b0025e77f3e0bdmr2449571ljm.383.1660936868038;
        Fri, 19 Aug 2022 12:21:08 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id i17-20020a2ea231000000b002618a31be1csm699147ljm.62.2022.08.19.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:21:07 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:21:02 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Message-ID: <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n0FtiIFG1DkzGVCH"
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


--n0FtiIFG1DkzGVCH
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
 drivers/iio/amplifiers/hmc425a.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc4=
25a.c
index ce80e0c916f4..108f0f1685ef 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -34,7 +34,6 @@ struct hmc425a_chip_info {
 };
=20
 struct hmc425a_state {
-	struct	regulator *reg;
 	struct	mutex lock; /* protect sensor state */
 	struct	hmc425a_chip_info *chip_info;
 	struct	gpio_descs *gpios;
@@ -162,13 +161,6 @@ static const struct of_device_id hmc425a_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
=20
-static void hmc425a_reg_disable(void *data)
-{
-	struct hmc425a_state *st =3D data;
-
-	regulator_disable(st->reg);
-}
-
 static struct hmc425a_chip_info hmc425a_chip_info_tbl[] =3D {
 	[ID_HMC425A] =3D {
 		.name =3D "hmc425a",
@@ -211,14 +203,7 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
=20
-	st->reg =3D devm_regulator_get(&pdev->dev, "vcc-supply");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret =3D regulator_enable(st->reg);
-	if (ret)
-		return ret;
-	ret =3D devm_add_action_or_reset(&pdev->dev, hmc425a_reg_disable, st);
+	ret =3D devm_regulator_get_enable(&pdev->dev, "vcc-supply");
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

--n0FtiIFG1DkzGVCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4p4ACgkQeFA3/03a
ocWC5wf/dLaY0o4KfYk2D/JFl0YNKp7J4iOndU/+1ot/7R+IZwIFzuTHW3wsoEJz
VMtS7tLRUYPPQoRyjbT1WOO6qTGwD+rNDeIOUqDaoBylUukdFoCTdQFPdxDRjdp7
NYoXLJ9ww6heT18dLLk3Z5ClPeKOdKe+Yb9WpoRO68l9R1fpb23vyRFEwYVRjCoI
8/R/3YP5qDob4TdO3ATZnZPjzJusU+zbxP4Kk9AtZrt3y8+GDIsEwz5iWPMMUXDO
qde4UJJMJjDTN23AhU/BYdi2VVsAgg9sJfHSSv11vXgUlR7fD/0RVi7x9cHxBTmP
faqUSXrx6OtvA76u5MyIj/itBxh0DQ==
=Wxo4
-----END PGP SIGNATURE-----

--n0FtiIFG1DkzGVCH--
