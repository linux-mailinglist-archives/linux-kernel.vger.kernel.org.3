Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A864F90DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiDHIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiDHIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:34:14 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73092FF59A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:32:10 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id g24so10513374lja.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NJTP8ILcdoavcQDr1pXR3v1eMwMnW1mtAKGyvmD59LA=;
        b=63U2bEreWtb+HbMKXTnDFfouNSfhq0XvFIhBXgVfcxHQ4FOWn2Qgg4QR/5egOHUZE+
         /dQkNQ7UiAMEmvb5KUZoKT57MwOaaGk9F0SGBa7NdAnEUxaoafra2YvEzwmC+3nm7qk+
         aKDolcLVm2YSC6RpM6s8ktOKjRye245gCHfRCouH8qBroKKiBsGqDrN0GNh1YNzjoZon
         IetG3fLIhPdap77ChrEubRTrP3QY8cXStLP0gT8r55BCkgvRBRqQfbGRgR5d8rTNt+yA
         3xlnJKTBCHClcU5HXMj9Gi/BcwpaVw5tYol+AnanWL5sLLcIjZTfT2JCRM6cQ3n/aLdY
         dSoA==
X-Gm-Message-State: AOAM530YymfzvR53MF/KbC6AZD4IOC78wAkIj5UBBhndWQ6yPe6B5PAs
        S82GCkna6Ht3cyawu0eZB6S93w/HVBE=
X-Google-Smtp-Source: ABdhPJzatC5bxPezMOpwdXShfnpGfwvJrK5EZsRE2FPTeLu8BDdvIv3OY5QkmpbXrdGpyT1PJ0TDTA==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr11302942ljp.442.1649406729089;
        Fri, 08 Apr 2022 01:32:09 -0700 (PDT)
Received: from dc73szyh141qn5ck3nwqy-3.rev.dnainternet.fi (dc73szyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::5])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e86cc000000b0024b121fbb2csm1792055ljj.46.2022.04.08.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:32:07 -0700 (PDT)
Date:   Fri, 8 Apr 2022 11:32:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Fix reviewer info for a few ROHM ICs
Message-ID: <Yk/zAHusOdf4+h06@dc73szyh141qn5ck3nwqy-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BFMSbMrT2yZ3Cnyt"
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BFMSbMrT2yZ3Cnyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The email backend used by ROHM keeps labeling patches as spam.
Additionally, there have been reports of some emails been completely
dropped. Finally also the email list (or shared inbox)
linux-power@fi.rohmeurope.com inadvertly stopped working and has not
been reviwed during the past few weeks.

Remove no longer working list 'linux-power' list-entry and switch my
email to use the personal gmail account instead of the company account.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Mark, I've been mostly meddling in your affairs so perhaps you could
pick this up? Or should I CC someone else?

 MAINTAINERS | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..3af36d852c38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5715,7 +5715,7 @@ W:	http://lanana.org/docs/device-list/index.html
=20
 DEVICE RESOURCE MANAGEMENT HELPERS
 M:	Hans de Goede <hdegoede@redhat.com>
-R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Maintained
 F:	include/linux/devm-helpers.h
=20
@@ -11208,7 +11208,7 @@ F:	scripts/spdxcheck.py
=20
 LINEAR RANGES HELPERS
 M:	Mark Brown <broonie@kernel.org>
-R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	lib/linear_ranges.c
 F:	lib/test_linear_ranges.c
 F:	include/linux/linear_range.h
@@ -17011,8 +17011,7 @@ S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
=20
 ROHM BD99954 CHARGER IC
-R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
-L:	linux-power@fi.rohmeurope.com
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
@@ -17035,8 +17034,7 @@ F:	drivers/regulator/bd9571mwv-regulator.c
 F:	include/linux/mfd/bd9571mwv.h
=20
 ROHM POWER MANAGEMENT IC DEVICE DRIVERS
-R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
-L:	linux-power@fi.rohmeurope.com
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
 F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c
@@ -21118,7 +21116,7 @@ F:	include/linux/regulator/
 K:	regulator_get_optional
=20
 VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
-R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	drivers/regulator/irq_helpers.c
=20
 VRF
--=20
2.35.1


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

--BFMSbMrT2yZ3Cnyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmJP8wAACgkQeFA3/03a
ocW/3Qf/ajq4J0OLZy0tQSUUfmd6V4PGNttXBAAmIvBuWajpc7N8k4kOVbsChH1V
bONrKum7v6ZVe3iQ3bVkbFml89HA/sJ0fQ7mMHKlAzFiXZDgQ35jZ1SQYB+B9GLK
cMCjCu8vh8IbhFwCSqjFs+zzpMaAc8r8cW0wFwKdz5gf/0FygT+ckJ2R+I4ohiUf
d1KhvgU+ugexUmYsj6fs1nGjicgM7a4iRtFFX+4ehXIUvtnkH83KElcmuC1b/1Qy
qa61jbnc3G3u34ocjZKWtNkGeU+Tb0dQ0udq+UhPeV54vHtWwx/gREJQoHp6Uf1d
ICJZG09jmMH7kIP1jEBk+1xKEHDdLg==
=XJWg
-----END PGP SIGNATURE-----

--BFMSbMrT2yZ3Cnyt--
