Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96213586BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiHANQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiHANQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:11 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395062B26E;
        Mon,  1 Aug 2022 06:16:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A38D4C01B5;
        Mon,  1 Aug 2022 15:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359767; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ibTdyKFj8P0BuRvMeMNwN6K/pbZ2SGY2V9Kqxo+bbC0=;
        b=uX2pZnU3cjvu8YT6x3oPKmDewPet1ZJ2cDt7lizZ7Sw+HNPP3WzVoFUJ42Ndml/m2PCE//
        hrgR9tCz8rtjh/OFDIdYr1jMZ4I9xVMP3ckjhy+5UutgsjxpTNyt1pn6SnmBlMQhht7RUN
        YU2GysQ/jzE4PWQT3Sp0jUZ6l8uKeifjOpojPB68QW+QtIrVD12sHoR7ss/OsY5KK6gjk6
        quA5qWe1A5H9QlKHpR7IKC+wIzdmHY016al8tbJN0Ps2f9Ft0ukD6nwD38x3eqCqHPPKk1
        ZNjt7uY0U22fS4F9pqoTO8B41m0MuT7Wz+FHR97Y9KUPaXZ4/kb7aBgbCA+lOg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 3/8] arm64: dts: imx8mm-kontron: Adjust board and SoM model strings
Date:   Mon,  1 Aug 2022 15:15:47 +0200
Message-Id: <20220801131554.116795-4-frieder@fris.de>
In-Reply-To: <20220801131554.116795-1-frieder@fris.de>
References: <20220801131554.116795-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 23be1ec538ba..cb8102bb8db5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -8,7 +8,7 @@
 #include "imx8mm-kontron-n801x-som.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X S";
+	model = "Kontron BL i.MX8MM (N801X)";
 	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 8f90eb02550d..b6d90d646a5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -6,7 +6,7 @@
 #include "imx8mm.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X SoM";
+	model = "Kontron SL i.MX8MM (N801X)";
 	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
 
 	memory@40000000 {
-- 
2.37.1

