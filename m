Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3159BAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiHVIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiHVIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:04:53 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004D2CCB9;
        Mon, 22 Aug 2022 01:04:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A03EBFAFA;
        Mon, 22 Aug 2022 10:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155453; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=A5cN8sVeOmemL/mvNZDaLcTSVhdh8ns7Cj6c2uU/rzg=;
        b=XloQo+Fkvjh/WwPiwyptxP64MJCz3d3DVA5ckt4XT9qlbyJpsMVRR7GKml3fD3LJ8zsaID
        MMsCCxidDfehBPXfBYLboTbFCxdROIs9aqIDRl7RSPNb0D+p5owr6FP+IviTSsiqMlS0Q6
        6UvPn7sMXtqUrCz4kHNWrLQ3TTQ9N2SKWV2eJyej/7RnrDmJZdRwQ5IvgjHV/X3kTCvmmC
        IfmZYdcx5f8xBwXzD9SyrMpAFB5cfXX4A7+lDnsVj7MMN/GUk6CT96Y2tSxuoBIYC47/PK
        HQlqZuoTWUb4tEssZYRg/J5r6ZtENWRj+96hZZCdKtHCRfsPJuZJ8INsc4eQkQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v4 3/8] arm64: dts: imx8mm-kontron: Adjust compatibles, file names and model strings
Date:   Mon, 22 Aug 2022 10:03:49 +0200
Message-Id: <20220822080357.24478-4-frieder@fris.de>
In-Reply-To: <20220822080357.24478-1-frieder@fris.de>
References: <20220822080357.24478-1-frieder@fris.de>
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
By updating we make sure, that we can maintain this more easily in
future and make sure that the proper devicetree can be selected for
the hardware.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v4:
* fix SoM dtsi includes

Changes in v3:
* also rename compatibles and file names
* rebase on v6.0-rc1

Changes in v2:
* none
---
 arch/arm64/boot/dts/freescale/Makefile                      | 2 +-
 .../{imx8mm-kontron-n801x-s.dts => imx8mm-kontron-bl.dts}   | 6 +++---
 ...imx8mm-kontron-n801x-som.dtsi => imx8mm-kontron-sl.dtsi} | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm64/boot/dts/freescale/{imx8mm-kontron-n801x-s.dts => imx8mm-kontron-bl.dts} (97%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-kontron-n801x-som.dtsi => imx8mm-kontron-sl.dtsi} (98%)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8bf7f7ecebaa..d014f7c4c888 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -55,7 +55,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
similarity index 97%
rename from arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index 23be1ec538ba..ca533baedcd2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -5,11 +5,11 @@
 
 /dts-v1/;
 
-#include "imx8mm-kontron-n801x-som.dtsi"
+#include "imx8mm-kontron-sl.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X S";
-	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+	model = "Kontron BL i.MX8MM (N801X S)";
+	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
 
 	aliases {
 		ethernet1 = &usbnet;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
rename to arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 8f90eb02550d..30299c2a98ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -6,8 +6,8 @@
 #include "imx8mm.dtsi"
 
 / {
-	model = "Kontron i.MX8MM N801X SoM";
-	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+	model = "Kontron SL i.MX8MM (N801X SOM)";
+	compatible = "kontron,imx8mm-sl", "fsl,imx8mm";
 
 	memory@40000000 {
 		device_type = "memory";
-- 
2.37.2

