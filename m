Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABEB5285D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiEPNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiEPNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A139173;
        Mon, 16 May 2022 06:48:26 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mbf87-1o9V0a1f6r-00Izx8;
 Mon, 16 May 2022 15:48:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/24] ARM: dts: imx7-colibri: improve licensing and compatible strings
Date:   Mon, 16 May 2022 15:47:15 +0200
Message-Id: <20220516134734.493065-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ct7eM4t/Jxh52Ag4M0WxhgjclR/6NFZv0CDfoV0FoPJcJTmRyzJ
 5RJWVFLzbq10OxQmyzbhYQtolCZazCqhSGwGbVWZ/sP7vB9GXrr3+BHSgLnzqru036ELQVa
 dpd4oOJ2wnXsHLUa7YK5VYRh2JbiJZ3se1mjw8YqPqycxtOidYu7m4WG4buO5vRUJa1ffSB
 5fYeQ1ml5OrBmhFOiT+0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fNap7InjpoE=:KEtOkc700+bKrsbA1OGgR1
 PTyo5EsMQ+KLRjkDR+LFA8r+ALg1E/FOINbFC6YhJIsaHGvQZZ8ujyuB7zulDRaERNPlpj893
 EzwEmlcnrgDH/NF2W8ywThNH7yAHEUgkQYkZOKyWfuPkgUb+Jn9Ywu8FBymjeP0XxJ1IpFkK2
 jP3lSWm4dvkUwYAQy4ATBrlqhwmvV9HBaqtgzFGBhHVSms3FnlfM+Ce3Jxis80ZREou09ScJ/
 kePYZnFYTlfI7q9bLop30iRsoLQAYDmIhS6ZThoPvspN5n1Q0lt82LtljEIFlUtZdzzBdPIBM
 woD5bJMR9zWYqJAiXkhG2WaxioYh37iaNWw/nCLsafjofBR2Lky8cxVnMkFdLt4U7UjOOcczy
 AXQa6+TgJUq0hh72V255kKG2Qy2T0i88ns7AvaS2It4Lhns8LCc0FN0NLAeqb7V4irP2at7rt
 O6/FigDiz+EflUPPGe81gLCdHrBl6Um/xxqVedxPULJS5M4F4+Y7PAVsPlNsWtvE0Txhiz7d/
 YhafRKJNANpbqgI3NaPe0IqQpfZXeqN2692YLVLD0Ng1TyxK0gDvEH8HSM8PYAF3XtMMTF2EH
 Fuq+j3OhzSknV3BfCmIcL67nWjTb+vNduwsUV6QjFMksPy+3Ve8ZsQkX+4AQ/mvrAzlh1bWXE
 5fkNxS16uC6MJcFUM0xQ7yJpIxb1ATnOW5EVm/9v3PtZQ34dlPLimZvVWDUQpEUOIKfo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Migrate to the latest SPDX license identifier, update copyright period
and improve compatible strings.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-aster.dtsi        | 5 ++---
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi      | 4 ++--
 arch/arm/boot/dts/imx7-colibri.dtsi              | 4 ++--
 arch/arm/boot/dts/imx7d-colibri-aster.dts        | 7 ++++---
 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts   | 8 +++++---
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts | 8 +++++---
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi        | 4 ++--
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts      | 7 ++++---
 arch/arm/boot/dts/imx7d-colibri.dtsi             | 4 ++--
 arch/arm/boot/dts/imx7s-colibri-aster.dts        | 7 ++++---
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts      | 7 ++++---
 arch/arm/boot/dts/imx7s-colibri.dtsi             | 4 ++--
 12 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index 950b4e5f6cf4..bfadb3a3124a 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -1,7 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017-2020 Toradex AG
- *
+ * Copyright 2017-2022 Toradex
  */
 
 / {
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 17ad9065646d..074c96f09191 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 / {
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 6df82a67953a..fa615379a117 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 #include <dt-bindings/pwm/pwm.h>
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
index ce0e6bb7db37..2ed1823c4805 100644
--- a/arch/arm/boot/dts/imx7d-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017-2020 Toradex AG
+ * Copyright 2017-2022 Toradex
  *
  */
 
@@ -10,7 +10,8 @@
 
 / {
 	model = "Toradex Colibri iMX7D on Aster Carrier Board";
-	compatible = "toradex,colibri-imx7d-aster", "toradex,colibri-imx7d",
+	compatible = "toradex,colibri-imx7d-aster",
+		     "toradex,colibri-imx7d",
 		     "fsl,imx7d";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
index 20480276cb0e..33e1034b75a4 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017-2020 Toradex AG
+ * Copyright 2017-2022 Toradex
  *
  */
 
@@ -11,7 +11,9 @@
 / {
 	model = "Toradex Colibri iMX7D 1GB (eMMC) on Aster Carrier Board";
 	compatible = "toradex,colibri-imx7d-emmc-aster",
-		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
+		     "toradex,colibri-imx7d-emmc",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
 };
 
 &usbotg2 {
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
index 8ee73c870b12..25d8d4583289 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017 Toradex AG
+ * Copyright 2017-2022 Toradex
  */
 
 /dts-v1/;
@@ -10,7 +10,9 @@
 / {
 	model = "Toradex Colibri iMX7D 1GB (eMMC) on Colibri Evaluation Board V3";
 	compatible = "toradex,colibri-imx7d-emmc-eval-v3",
-		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
+		     "toradex,colibri-imx7d-emmc",
+		     "toradex,colibri-imx7d",
+		     "fsl,imx7d";
 };
 
 &usbotg2 {
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index af39e5370fa1..198e08409d59 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017 Toradex AG
+ * Copyright 2017-2022 Toradex
  */
 
 #include "imx7d.dtsi"
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index c610c50c003a..51561388fac5 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 /dts-v1/;
@@ -9,7 +9,8 @@
 
 / {
 	model = "Toradex Colibri iMX7D on Colibri Evaluation Board V3";
-	compatible = "toradex,colibri-imx7d-eval-v3", "toradex,colibri-imx7d",
+	compatible = "toradex,colibri-imx7d-eval-v3",
+		     "toradex,colibri-imx7d",
 		     "fsl,imx7d";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 219a0404a058..90d25c604de2 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 #include "imx7d.dtsi"
diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/imx7s-colibri-aster.dts
index 87f9e0e079a8..58ebb02d948a 100644
--- a/arch/arm/boot/dts/imx7s-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2017-2020 Toradex AG
+ * Copyright 2017-2022 Toradex
  *
  */
 
@@ -10,7 +10,8 @@
 
 / {
 	model = "Toradex Colibri iMX7S on Aster Carrier Board";
-	compatible = "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
+	compatible = "toradex,colibri-imx7s-aster",
+		     "toradex,colibri-imx7s",
 		     "fsl,imx7s";
 };
 
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
index 81956c16b95b..6589c4179177 100644
--- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 /dts-v1/;
@@ -9,7 +9,8 @@
 
 / {
 	model = "Toradex Colibri iMX7S on Colibri Evaluation Board V3";
-	compatible = "toradex,colibri-imx7s-eval-v3", "toradex,colibri-imx7s",
+	compatible = "toradex,colibri-imx7s-eval-v3",
+		     "toradex,colibri-imx7s",
 		     "fsl,imx7s";
 };
 
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index 94de220a5965..2ce102b7f5d4 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2016-2020 Toradex
+ * Copyright 2016-2022 Toradex
  */
 
 #include "imx7s.dtsi"
-- 
2.35.1

