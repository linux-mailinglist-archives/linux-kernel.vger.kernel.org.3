Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779058DB19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbiHIP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244852AbiHIP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:26:29 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B231902D;
        Tue,  9 Aug 2022 08:26:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2764ABFADC;
        Tue,  9 Aug 2022 17:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660058783; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=O84QH3syOxwPsTE0OubIf0vwZyDg4pFnuKeXNvxDAuU=;
        b=fgbwyUJEJArGVnXmQlNeaiAGWuSI/hho057f78AXtnu32xHrKCa7n2Wu2xdyY4gYft45wz
        giObwflCrUjF+91z9psUinthSkOomkaLsDz/Co5Lrpvd+qvTj7mXV/Efwfeul4Xx5s7FM/
        XgTBYzFIQqph+2fFZvFMWkDxcNsGAY8HSTUHLXnw/Jbyqv1AlXzuJzvq4KZrpI7A2R7RKM
        liiuGsH8Ve1wvIWGcQ/gV/OIgSK+SVWq6ZRiDkNHInhWu+w+RwoT0+dAFhDewFs9PwEoVw
        +rNDSG1pd6m/Cc1GMWpRDefxE7AIU4v22CWPQsBuz0dMbWpQ0ekKMu5Typsxgg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 4/4] ARM: dts: imx6ul-kontron: Adjust board and SoM model strings
Date:   Tue,  9 Aug 2022 17:25:31 +0200
Message-Id: <20220809152534.292034-5-frieder@fris.de>
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

The official naming includes "SL" (SoM-Line) or "BL" (Board-Line).
The legacy identifiers are kept in brackets and are still used in
file names and compatible strings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts  | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts     | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts    | 2 +-
 arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
index 20556b2df966..5ef20556ffc0 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-s-43.dts
@@ -8,7 +8,7 @@
 #include "imx6ul-kontron-n631x-s.dts"
 
 / {
-	model = "Kontron N631X S 43";
+	model = "Kontron BL i.MX6UL 43 (N631X S 43)";
 	compatible = "kontron,imx6ul-n631x-s-43", "kontron,imx6ul-n631x-s",
 		     "kontron,imx6ul-n631x-som", "fsl,imx6ul";
 
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
index 407d2b1dab98..7b1abe088224 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-s.dts
@@ -11,7 +11,7 @@
 #include "imx6ul-kontron-n6x1x-s.dtsi"
 
 / {
-	model = "Kontron N631X S";
+	model = "Kontron BL i.MX6UL (N631X S)";
 	compatible = "kontron,imx6ul-n631x-s", "kontron,imx6ul-n631x-som",
 		     "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
index 9a1179814b7d..750f20293bd4 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
@@ -9,6 +9,6 @@
 #include "imx6ul-kontron-n6x1x-som-common.dtsi"
 
 / {
-	model = "Kontron N631X SOM";
+	model = "Kontron SL i.MX6UL (N631X SOM)";
 	compatible = "kontron,imx6ul-n631x-som", "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts b/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
index 01aeea408531..4f9f69a84a72 100644
--- a/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
+++ b/arch/arm/boot/dts/imx6ull-kontron-n641x-s.dts
@@ -10,7 +10,7 @@
 #include "imx6ul-kontron-n6x1x-s.dtsi"
 
 / {
-	model = "Kontron N641X S";
+	model = "Kontron BL i.MX6ULL (N641X S)";
 	compatible = "kontron,imx6ull-n641x-s", "kontron,imx6ull-n641x-som",
 		     "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi
index 8a64aa9a2751..3ea1e9661616 100644
--- a/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi
@@ -8,6 +8,6 @@
 #include "imx6ul-kontron-n6x1x-som-common.dtsi"
 
 / {
-	model = "Kontron N641X SOM";
+	model = "Kontron SL i.MX6ULL (N641X SOM)";
 	compatible = "kontron,imx6ull-n641x-som", "fsl,imx6ull";
 };
-- 
2.37.1

