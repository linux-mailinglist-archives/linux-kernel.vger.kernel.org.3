Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1C4A8558
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350882AbiBCNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:38:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:37307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236544AbiBCNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643895469;
        bh=dVQvtiYNG/u8hhm5TCAZWN7w6mEpUbXMDEqDpp+cwqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UKllb42HDWqSNakMfLbztS19v9oklsxRbys12ZXdRMgpeOdZMdp6iCu8aHv7FmW9R
         USQDzGL8S3/qArAzTWOOVcVdLtWgQDehAp7KMkz8eBYLq7ZLvKpOiedSUGSqi6bzkK
         krsRX7KTUGDj3EhYdrwetMGuKF7BSxhdfzZrfauM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1nFLK81h1V-000JKe; Thu, 03
 Feb 2022 14:37:49 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v2 1/2] pinctrl: nuvoton: npcm7xx: Use %zd printk format for ARRAY_SIZE()
Date:   Thu,  3 Feb 2022 14:37:35 +0100
Message-Id: <20220203133736.246397-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203133736.246397-1-j.neuschaefer@gmx.net>
References: <20220203133736.246397-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ev8C5HPXf5F6AdznlPPqrkzVikHuPo/BTwFbnffVoGyTgqugcla
 BVyWbg/Bqt5AKR++odH9Mp5MLch1YaVsslHO5M6BEf8GwxLUdGd8HNdgYgYR8YGbH2U0Cg4
 8E6Nav45wP44QMoZx/FNGz5vai+CSBnWKVCEtO7uFh9vivQPGs4wYYv3YrP6U2egXcKhdX/
 rgc8/oF9MZe6DbdkSFj9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBWBzNVTT+A=:qrCus2zoEg9UlY3OiMdBCa
 gqMI9/NiDzH3zlGzHlcVVSSdjq8TvnjUQ3WPvWDquT2kwK0LH+HFNnrWinEeHidCIdNnbmT9/
 qStSrsudPj0waJxIb29QniXs8dPt0CVnbI8fpCVTY5iL3CmOODNbZbSSDA23Lm1EHzKoAbVai
 hyPZdsAM+AjgBq9ig2SGKGE2A4iV3kp6tvV2dcJ+GrD4dPTG+c8r9wArb9K1YTaOznBdHcupl
 3n3oGkc+1cQHzZobuIJP0EItI1QmJxfHAUTreh/LNuNcTUuk09QQC5CYD+aaFoE+lDbQmjzOm
 dF3cxWcIsJM2t/VIg/Gwob8iVmpB04+/apzYhHP/Y69/2YUmJsoAcfzYV/zt3PjsH80vk3ag7
 3NVuu9NXMUGUvOHzHlbj07SoTHByhkKuBG87//HFL9gTTwN3P9sAiv4eWngZCzIo54x+lHghv
 0v+o5EqxBet5Hx15JKRA7aCN7UQkK+MOWVfNzSb/gdUyCKFBt8Lsv3RZNTHAGjZkL1lQCkz8i
 BHckbCItyP1LLdcVKuGcRzFkzmFPxFFAVAVA0+9XOFnrl+vZyOX5/1ZYio6aQLtD48p74/Nl+
 IyuoYYrFNJFeIIfaK3d5m1nbcRyq6NrCOLEnnD0y4vZ0XuzUZZszZ5vbNIkuViPG1LYtcpCeP
 AhC4Bxoy2xliC0Mz2lnBqBDYLOkyTz24AvXaRCoAMYmFUoicK0yuDRQEyELt3Kzy3ZSGSQ3bI
 jqzJ1ObYU2Y9S/43D5sUxG6m+EdkA62QC2mSxL1/0DgHcp/F9djE4qhmS808YktwkCUL+nUQp
 2HSOQCalfQKSDstkToN/J2RCfhSF2hkSzyJSlBet3MTt9zfWbbUbqJX3r3PO1uRWYIZC8IbRH
 dNomKD4whHetZ7aOIF0fCGTmfceM69L9VT/bzrvil++hlptByXiaEV7DaxMqtE+r8pg0uaZj7
 9XYCHZ1h86VaNgLZk7g6lZE4EyR4cLqSWAf8xGbBYfGrfqrXK52aHiZ/36gSVaGnM4qEoXBVe
 nQncrTgZeeJgW+Zy0jE+VfQSQR6dzdE2eQgDGxBU4It6nOYE8eZBMy87ICLvdus9yeYehDebX
 AB/r5sEvT4u+k8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile-testing on 64-bit architectures, GCC complains about the
mismatch of types between the %d format specifier and value returned by
ARRAY_LENGTH(). Use %zd, which is correct everywhere.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 3b588e43ee5c7 ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driv=
er")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
=2D--

v2:
- Add Fixes and R-b tags
=2D--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/n=
uvoton/pinctrl-npcm7xx.c
index 4d81908d6725d..705576e03e334 100644
=2D-- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1561,7 +1561,7 @@ static int npcm7xx_get_groups_count(struct pinctrl_d=
ev *pctldev)
 {
 	struct npcm7xx_pinctrl *npcm =3D pinctrl_dev_get_drvdata(pctldev);

-	dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
+	dev_dbg(npcm->dev, "group size: %zd\n", ARRAY_SIZE(npcm7xx_groups));
 	return ARRAY_SIZE(npcm7xx_groups);
 }

=2D-
2.34.1

