Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639C554C30E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiFOIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiFOIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:04:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47DB4161F;
        Wed, 15 Jun 2022 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655280253; x=1686816253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDBFYR34Tbx5aR/oPc9I4Wo8u3JWGOmP0EmL2csHh7Y=;
  b=k3GcI3nw8G92TiUB8jfU/9KoMpttrQh4EDRUeWZrMamjk2C1MdgE4KlC
   5XNOC91TQZILi3fyp6Fe/AzEx6WarNLYP+W+36CtpGwWM+scds+q40PhS
   98qVwomaSnkcFBbZqQc/NmB8vfgpbnsTXsSH7CVQxhKP5P6QMJ/cyljr2
   avxd4+e05uUknqjVNDNzNOAdUuzNQpNorPAgRTtnTEwEer+Z6oaIjLxSb
   UyTu/Mji9MewO35LdX6bWpGcaxrMZjdRPTaPEKu1Xk/f7H5o2Zf20h2fe
   wtxow2LaYV/1jUKDIktCcS0t0JUqHgFBulAuGzK8vH2+yFtq+AQmCze8j
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="160393773"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:04:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:04:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 01:04:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: fix compilation warning
Date:   Wed, 15 Jun 2022 11:06:33 +0300
Message-ID: <20220615080633.1881196-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220615080633.1881196-1-claudiu.beznea@microchip.com>
References: <20220615080633.1881196-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compilation warning:
arch/arm/boot/dts/sama5d2.dtsi:371.29-382.6: Warning
(avoid_unnecessary_addr_size): /ahb/apb/ethernet@f8008000:
unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
also defined at arch/arm/boot/dts/at91-sama5d2_icp.dts:353.8-363.3

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 2 ++
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 2 ++
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 2 ++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
 arch/arm/boot/dts/sama5d2.dtsi              | 2 --
 5 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index a4623cc67cc1..c365731b2cce 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -83,6 +83,8 @@ kernel@200000 {
 			macb0: ethernet@f8008000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_default>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				phy-mode = "rmii";
 
 				ethernet-phy@7 {
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index ba621783acdb..76b2025c67b4 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -194,6 +194,8 @@ regulator-state-mem {
 &macb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_macb0_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	phy-mode = "rmii";
 
 	ethernet-phy@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 8ed58af01391..88cf125a55ed 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -139,6 +139,8 @@ spi0: spi@f8000000 {
 			macb0: ethernet@f8008000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				phy-mode = "rmii";
 				status = "okay";
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index cdfe891f9a9e..bcc3c1bacb25 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -147,6 +147,8 @@ flash@0 {
 			macb0: ethernet@f8008000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				phy-mode = "rmii";
 				status = "okay";
 
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index b147db8b973f..5b2f2e922d40 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -384,8 +384,6 @@ macb0: ethernet@f8008000 {
 				interrupts = <5  IRQ_TYPE_LEVEL_HIGH 3		/* Queue 0 */
 					      66 IRQ_TYPE_LEVEL_HIGH 3          /* Queue 1 */
 					      67 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 2 */
-				#address-cells = <1>;
-				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>, <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
-- 
2.34.1

