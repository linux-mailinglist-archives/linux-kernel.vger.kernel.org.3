Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A574CFE35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbiCGMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiCGMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:24:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420E4A3E0;
        Mon,  7 Mar 2022 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646655778; x=1678191778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8P0ugmaMhZ3HPKAOr2o7rau3EF16Zlfj7QAhGV8bFJg=;
  b=dI5Qzn7Usc8YQR0BUp7hP3rfqeMh2ZU23E+TVQ1EgECGj8oQkrijkj/c
   gDRbAOIcY2It+vlaLf2p16EfnUwwQ5jIT9YBklP/caUgElT7MR3Vb4W5+
   WHXClOIWF3ijwxIx3Rzl+Ss4DJ0Rfu6/RAgc+nvEx758X9SxqyI4O9ymO
   mMawkkujtIsZ6Lzox3QoRWUYBojIZFX3I5YQOLUO6s6IddUX4VHpCIiMY
   LH8Zwm4rMIp35aq8WmM/elnUksP3PdGKjcsTlDk1mAyKiUDtlUxYMrEH1
   SaZDLIjuFQ1pH6Dwu6zr6cpUeDt4hcG/IY+4Hstbj6buovqLfkapM5cMV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155942245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 05:22:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 05:22:57 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 05:22:54 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 5/6] ARM: dts: at91: sama7g5ek: add node for PDMC0
Date:   Mon, 7 Mar 2022 14:22:01 +0200
Message-ID: <20220307122202.2251639-6-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5-EK has 4 PDM microphones connected to PDMC0. PDMC0 pinmux is in
conflict with gmac1, gmac1 being enabled by default.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v3:
 - none

Changes in v2:
 - replaced included file dt-bindings/sound/mchp,pdmc.h wih
   dt-bindings/sound/microchip,pdmc.h

 arch/arm/boot/dts/at91-sama7g5ek.dts | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index ccf9e224da78..a1fb980d3fc1 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/sound/microchip,pdmc.h>
 
 / {
 	model = "Microchip SAMA7G5-EK";
@@ -439,7 +440,7 @@ &gmac1 {
 		     &pinctrl_gmac1_mdio_default
 		     &pinctrl_gmac1_phy_irq>;
 	phy-mode = "rmii";
-	status = "okay";
+	status = "okay"; /* Conflict with pdmc0. */
 
 	ethernet-phy@0 {
 		reg = <0x0>;
@@ -453,6 +454,17 @@ &i2s0 {
 	pinctrl-0 = <&pinctrl_i2s0_default>;
 };
 
+&pdmc0 {
+	#sound-dai-cells = <0>;
+	microchip,mic-pos = <MCHP_PDMC_DS0 MCHP_PDMC_CLK_NEGATIVE>, /* MIC 1 */
+			    <MCHP_PDMC_DS1 MCHP_PDMC_CLK_NEGATIVE>, /* MIC 2 */
+			    <MCHP_PDMC_DS0 MCHP_PDMC_CLK_POSITIVE>, /* MIC 3 */
+			    <MCHP_PDMC_DS1 MCHP_PDMC_CLK_POSITIVE>; /* MIC 4 */
+	status = "disabled"; /* Conflict with gmac1. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdmc0_default>;
+};
+
 &pioA {
 	pinctrl_flx0_default: flx0_default {
 		pinmux = <PIN_PE3__FLEXCOM0_IO0>,
@@ -609,6 +621,13 @@ pinctrl_mikrobus1_spi: mikrobus1_spi {
 		bias-disable;
 	};
 
+	pinctrl_pdmc0_default: pdmc0_default {
+		pinmux = <PIN_PD23__PDMC0_DS0>,
+			 <PIN_PD24__PDMC0_DS1>,
+			 <PIN_PD22__PDMC0_CLK>;
+		bias_disable;
+	};
+
 	pinctrl_qspi: qspi {
 		pinmux = <PIN_PB12__QSPI0_IO0>,
 			 <PIN_PB11__QSPI0_IO1>,
-- 
2.32.0

