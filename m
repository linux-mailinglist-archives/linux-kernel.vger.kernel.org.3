Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA804A711D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbiBBMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:55:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:33723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233480AbiBBMzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643806495;
        bh=qrJUuvQc6jPR2ZNSIzsZu+O8vNlEvzG2uDxO2T+grCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fglQB5Rj4leqigekS6pWeKiLYrrwZJLEuevJ4BtsQ48yY8WZ6vn8VEiJB6gJSP3+j
         hEZFwXwehXTPMlzeatOWl6NAatkVvmcxjQjN5bx+mN1p8L7HAWZMAhgollPdS0LM+w
         Vh52Ojlou0Vi49gsjIuIe/Y1qHwYvKlDevEKTnQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1mhZ5R0Ony-00Xdrx; Wed, 02
 Feb 2022 13:54:55 +0100
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
Subject: [PATCH 1/2] pinctrl: nuvoton: npcm7xx: Use %zd printk format for ARRAY_SIZE()
Date:   Wed,  2 Feb 2022 13:54:37 +0100
Message-Id: <20220202125438.19345-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202125438.19345-1-j.neuschaefer@gmx.net>
References: <20220202125438.19345-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZWqmhLCAcRSmjyC8K9WB6W9M8GnP36nKKAXE/+YrMCXd+rRfjEB
 8Htv50uVfo0xE40KSJA2Sy/0CjEI9EbORbOw+Zxn1IEO7A1PpmQ3eAjHKeDGYqSQpa9gpNp
 /chtHrvuIo85/o33eUkV4XhoLk/TLLgcmyIYKMbycKOY9VfKC+NvuU1kVVxWASm6pC2JH0S
 25cgLmEdWMCDhjHeAsMbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9N/5/PQ3RQ=:ftb7iTO7pPj2qxqyb/208V
 YslLqXEgl5VcTRRi4tTzM/MRmYwC5gexTKNE3Br2bglsXilNHzXlmfs3C7wSO8/nTYdCY3qYD
 RBtiNSn+Pnxcl7O1HcsJfbgX3Rf/sqNj3mNGGHcSmW1pTwproqb0ygfvK3EYvTxQ+WRFSypfU
 k43SBxqH/d/hzx09Jydtnr+ALELkNU+UOrfU9ycM59HveGfMpbVpJCioArLFn/dT1sxW764Pz
 lJvdH40otQIR9cjp8ZUXwemm6BZSfzG7iGrAThwPTuuBkzC0hSCClKl7zurDnLVFZ3DeanxAk
 UarUEo0sZJmAQXRp6NXtdfKb5ciup5Fu67Pp/A/fZZKHPBpiGFJymnAdnRVgIF25Jrcacai0A
 HXlDZpCXEwBvePJdRa4HALP3nkVAt1/BAAY9FrWgsiCSZuCp5KXE5xyn9npBzKI14ESzB0Pyf
 /1Nq/mvtPmMwgXf/GxubeYZT2QNW5eme+qVSHZO9xKJf6PRztqEiLI558MnwgVolXa+pCdNjA
 Ep8GHaU8MKpMujI5tYOaIpyOSDpjI4ISuesiMbrhqSljEH2UhQ+J7ZWp5FYJO26DLG35dhhrD
 WdmFs6U5DK4S+zKzGdHOfk66umoEsOgbf0gPi74tHWP81PqpqBmMXAxkeQXwwXADB6mYrj2L7
 BTKIRz6vJ68y6xg7630eQZw1T5wdgiLORtMYm8lymcXBS06MiUY+WrcogunWPBEzJ60Pnjd9M
 QLVQ18V2vWLD3ysylkaAjRmMVu9FEpFLcqZlbxAMinWCmmwK2J3gh/+0Q9J0Wg8E8n81Ktzf/
 sFSO74pQAFDer5Qc/LiOuxFKJ16x/GQIrsR0XrqxQRfGpubvG6aJnF/wzNxWZ1su88lnXNZd2
 HcfXxLD8jl8EYLDt/I3JfzGkhQeHbHFlE4EwdQ13hvedC/cdRhAf6qXWN1nhkOvq2OULO3nGY
 QbhPKtvCYoxMovJM9zS7Rtlx8AoM6imK27n8TbVymZRu9hExAnmNN6qAzesvCAV2XSVq6DWaU
 GwKRQTimJnzKsph+CMGV4DPniG1SQbDVl8JppznzH7kBNXtH95m7PLFtk7YYekAbLCIqli8i/
 oXOIe5aSEa5tmQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile-testing on 64-bit architectures, GCC complains about the
mismatch of types between the %d format specifier and value returned by
ARRAY_LENGTH(). Use %zd, which is correct everywhere.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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

