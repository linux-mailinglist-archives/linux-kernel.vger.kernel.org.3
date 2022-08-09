Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7215258DB15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiHIP0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiHIP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:26:10 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A2D122;
        Tue,  9 Aug 2022 08:26:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BD8FBFADC;
        Tue,  9 Aug 2022 17:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660058766; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Up/vt3EYDPnmgs/YbP0KJU4jU8/61VSN/1ifLZ6Uhtw=;
        b=ihFou1wCCQzNh8Qv9AktICqqVwgbzZxyNDhlPlMbW/OeVJWvi2otvUcCe21FK0Np1BiC2H
        ERt8IDX01OBCnpb9N7rLPrKwlY58SSuXU8RSV6ZpbcVDVP7hk+x538R0VwZ199RqUeAkIE
        OacJyAsWF+tD7WX2TxwBxNjmoBN3wjo20mGIDS6L11OjRPmnaJ5ZfSXiuzqWsY69LmiBe7
        f/JE2uh+pVzBh+xzV/PPenVQoqzhtiFM65fm2z3deMMlA/UuQCWc38rBFM+VddCx9SEMbf
        /WpTkFZ6/yWUXsrY7YfQb4fBqNx/WZRYVHA1ulIR9C2vHjaZrcyxCXpDagRTUg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/4] ARM: dts: imx6ul-kontron: Simplify devicetree structure
Date:   Tue,  9 Aug 2022 17:25:29 +0200
Message-Id: <20220809152534.292034-3-frieder@fris.de>
In-Reply-To: <20220809152534.292034-1-frieder@fris.de>
References: <20220809152534.292034-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There is no need in differentiating between the different SoM versions
that only differ in memory size, etc. It's much cleaner to simplify
the devicetrees and let them be more generic.

If necessary the bootloader will update the devicetree dynamically
to contain the correct size of the memory.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../boot/dts/imx6ul-kontron-n6310-som.dtsi    | 41 -------------------
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  | 16 --------
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 ------------------
 ...s-43.dts => imx6ul-kontron-n631x-s-43.dts} |  8 ++--
 ...n6310-s.dts => imx6ul-kontron-n631x-s.dts} |  6 +--
 .../boot/dts/imx6ul-kontron-n631x-som.dtsi    | 14 +++++++
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 15 +++++++
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 ------------------
 ...6411-s.dts => imx6ull-kontron-n641x-s.dts} |  6 +--
 .../boot/dts/imx6ull-kontron-n641x-som.dtsi   | 13 ++++++
 10 files changed, 52 insertions(+), 147 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s-43.dts => imx6ul-kontron-n631x-s-43.dts} (93%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s.dts => imx6ul-kontron-n631x-s.dts} (67%)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 rename arch/arm/boot/dts/{imx6ull-kontron-n6411-s.dts => imx6ull-kontron-n641x-s.dts} (62%)
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
deleted file mode 100644
index acd936540d89..000000000000
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include "imx6ul.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
-
-/ {
-	model = "Kontron N6310 SOM";
-	compatible = "kontron,imx6ul-n6310-som", "fsl,imx6ul";
-
-	memory@80000000 {
-		reg = <0x80000000 0x10000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <108000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x08000000>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
deleted file mode 100644
index 239a1af3aeaa..000000000000
--- a/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-/dts-v1/;
-
-#include "imx6ul-kontron-n6311-som.dtsi"
-#include "imx6ul-kontron-n6x1x-s.dtsi"
-
-/ {
-	model = "Kontron N6311 S";
-	compatible = "kontron,imx6ul-n6311-s", "kontron,imx6ul-n6311-som",
-		     "fsl,imx6ul";
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
deleted file mode 100644
index 29ed38dce580..000000000000
--- a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-#include "imx6ul.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
-
-/ {
-	model = "Kontron N6311 SOM";
-	compatible = "kontron,imx6ul-n6311-som", "fsl,imx6ul";
-
-	memory@80000000 {
-		reg = <0x80000000 0x20000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <104000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x18000000>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
similarity index 93%
rename from arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
rename to arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
index 5bfad4655b22..20556b2df966 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
@@ -5,12 +5,12 @@
  * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
  */
 
-#include "imx6ul-kontron-n6310-s.dts"
+#include "imx6ul-kontron-n631x-s.dts"
 
 / {
-	model = "Kontron N6310 S 43";
-	compatible = "kontron,imx6ul-n6310-s-43", "kontron,imx6ul-n6310-s",
-		     "kontron,imx6ul-n6310-som", "fsl,imx6ul";
+	model = "Kontron N631X S 43";
+	compatible = "kontron,imx6ul-n631x-s-43", "kontron,imx6ul-n631x-s",
+		     "kontron,imx6ul-n631x-som", "fsl,imx6ul";
 
 	backlight {
 		compatible = "pwm-backlight";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
similarity index 67%
rename from arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
rename to arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
index 5a3e06d6219b..407d2b1dab98 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
@@ -7,11 +7,11 @@
 
 /dts-v1/;
 
-#include "imx6ul-kontron-n6310-som.dtsi"
+#include "imx6ul-kontron-n631x-som.dtsi"
 #include "imx6ul-kontron-n6x1x-s.dtsi"
 
 / {
-	model = "Kontron N6310 S";
-	compatible = "kontron,imx6ul-n6310-s", "kontron,imx6ul-n6310-som",
+	model = "Kontron N631X S";
+	compatible = "kontron,imx6ul-n631x-s", "kontron,imx6ul-n631x-som",
 		     "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
new file mode 100644
index 000000000000..9a1179814b7d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#include "imx6ul.dtsi"
+#include "imx6ul-kontron-n6x1x-som-common.dtsi"
+
+/ {
+	model = "Kontron N631X SOM";
+	compatible = "kontron,imx6ul-n631x-som", "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
index 09a83dbdf651..dcf88f610346 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
@@ -11,6 +11,11 @@ / {
 	chosen {
 		stdout-path = &uart4;
 	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x10000000>;
+		device_type = "memory";
+	};
 };
 
 &ecspi2 {
@@ -55,6 +60,16 @@ &qspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_qspi>;
 	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		spi-max-frequency = <104000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
deleted file mode 100644
index d000606c0704..000000000000
--- a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-#include "imx6ull.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
-
-/ {
-	model = "Kontron N6411 SOM";
-	compatible = "kontron,imx6ull-n6311-som", "fsl,imx6ull";
-
-	memory@80000000 {
-		reg = <0x80000000 0x20000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <104000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x18000000>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts b/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
similarity index 62%
rename from arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
rename to arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
index 57588a5e1e34..01aeea408531 100644
--- a/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
+++ b/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
@@ -6,11 +6,11 @@
 
 /dts-v1/;
 
-#include "imx6ull-kontron-n6411-som.dtsi"
+#include "imx6ull-kontron-n641x-som.dtsi"
 #include "imx6ul-kontron-n6x1x-s.dtsi"
 
 / {
-	model = "Kontron N6411 S";
-	compatible = "kontron,imx6ull-n6411-s", "kontron,imx6ull-n6411-som",
+	model = "Kontron N641X S";
+	compatible = "kontron,imx6ull-n641x-s", "kontron,imx6ull-n641x-som",
 		     "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi
new file mode 100644
index 000000000000..8a64aa9a2751
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ */
+
+#include "imx6ull.dtsi"
+#include "imx6ul-kontron-n6x1x-som-common.dtsi"
+
+/ {
+	model = "Kontron N641X SOM";
+	compatible = "kontron,imx6ull-n641x-som", "fsl,imx6ull";
+};
-- 
2.37.1

