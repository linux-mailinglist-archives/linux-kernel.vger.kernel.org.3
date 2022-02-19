Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166BE4BC4AF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiBSB7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiBSB7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:59:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA9246375;
        Fri, 18 Feb 2022 17:59:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D32EC6202B;
        Sat, 19 Feb 2022 01:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC92EC340E9;
        Sat, 19 Feb 2022 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645235969;
        bh=pkjc6q9pFivBIbOsfj6XnPQnoJb507rtwPgM8nj56+4=;
        h=Date:From:To:Cc:Subject:From;
        b=lDPKLC44XMmiY8e7p9DWgspvHEBXbymO3+XQgg4MNgF/jSRsGXExQfFqEf2rnGzXq
         GNpWaoW/TOxkPIs33Wcj/YJt1sf4DeiAr7af3aq0kJBRfJ8nYiiMd01CckPD3lksdC
         WcOTPkCYDWFWVkSCPbUS5vX0De7inRVS7uiLQPu2qQV3diSy2axR+AsUqwMRAUS3sO
         6P46z9m28zl1nEkD4qyxY1N1X9qqxQKqzWhBf1st60pSkhRidDUuh+KhlBag7aTs4L
         TTITm+rB8lono6jnkkwbHd7uwU32ai505Z+M09qFPl4MdOsRWJAwCCYqrgYEXg3HqL
         /Hf2hmIz1JhFw==
Received: by mercury (Postfix, from userid 1000)
        id 0BF411060735; Sat, 19 Feb 2022 02:59:26 +0100 (CET)
Date:   Sat, 19 Feb 2022 02:59:26 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.17-rc
Message-ID: <20220219015926.nsaz76djtc3d7sfa@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ku4debob5irlkxyc"
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ku4debob5irlkxyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17-rc

for you to fetch changes up to f444578d727a0ca4a72b19cd4a1d7da9f1fb99fe:

  power: supply: bq256xx: Handle OOM correctly (2022-02-11 21:19:51 +0100)

----------------------------------------------------------------
Power Supply Fixes for 5.17 cycle

Three regression fixes for the 5.17 cycle:

1. build warning fix for power-supply documentation
2. pointer size fix in cw2015 battery driver
3. OOM handling in bq256xx charger driver

----------------------------------------------------------------
Linus Walleij (1):
      power: supply: bq256xx: Handle OOM correctly

Randy Dunlap (1):
      power: supply: fix table problem in sysfs-class-power

Yang Li (1):
      power: supply: core: fix application of sizeof to pointer

 Documentation/ABI/testing/sysfs-class-power | 1 +
 drivers/power/supply/bq256xx_charger.c      | 3 +++
 drivers/power/supply/cw2015_battery.c       | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

--ku4debob5irlkxyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIQTvoACgkQ2O7X88g7
+poRyw//Zq0uXHdmxB7A0khpsEJ5cyEZWjDzUULK1P8s4HD4Va8mpME3fIXCNlga
LmadGvl02CvxpDs2FV8v3UcxRvPZgjnc9CGMr6tbgNEb02S2dhJHf+0zJcFQ38Yb
Yci5XzOKOpSg+NemHdAGdzox5sTSrlJPvRAwEnnN6dldb2Gv023rzxBx/84lLbve
FH0AgGGWEhhk+0COPZfVTfaSFKSyChbYB+OxE0mE6y+cR9JONi//AaqFpNyvcgSA
vA87Cf2HDCnuz9n1x65lP/2Ag1oxzYLxEA6jR92Dtn3wFQ7Z4FTJKROtxu7zB1mr
KKSqm/2HQkfJUYHbW9waSf4xumAInJ/1Z0vspBkC7AMlkP/8mHm/1ur2+Xh/bZPI
gv1+uJo1YRhrk1zMTOdHmy7va3I5zF2G2Oue7OqubrWR+qc4wf/jVC75G0sENtJ9
e2sndJmYy42JxE/x3vIJo65z1UokVJJqYAPYAReODb2LmNzghbgjoL3RNnGn4XUf
NdgOVMAXgPjEPof1+mH1uljyBSjROiFXbVKpWj03/4p4VHZlsxAsewG8TJxCoow/
KtJyig9TOWx+DW5e3nMHtRZ06JLfnhiEWr73IP/mZy2Gc8qd1xmfhyIbUfLswk33
9OWFZ7QiJew3rvrcU9HPz1truJFBQcNCNXJzKkGSNc6IIRuKz88=
=dCIP
-----END PGP SIGNATURE-----

--ku4debob5irlkxyc--
