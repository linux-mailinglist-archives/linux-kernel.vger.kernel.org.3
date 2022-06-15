Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1525354C30C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiFOIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiFOIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:04:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E324161F;
        Wed, 15 Jun 2022 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655280248; x=1686816248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ekMFSDApn8f/L2DLduY6YJpgD+dLG401qisoT15FBo4=;
  b=MvaM0xjxGFLxcC0i0Go9siqmNArf+EqMFQumEh0bYxBIVK8DceYZoxO2
   bvoEZj3aebJDgBtedblAzWRJ4DlKuMaMbObvhrns1HMaWbLTpYF0b8Z4p
   j7MYGjS15vxDHtMv2yaAwodfa92uVE2VKGaaaBhO9s2Vt0ffuuSjDX6dg
   kQiY1yBKKEpqgAmVy4ln7gTSbKTLdBaya5fLVYmBHR4k0RdXubV6x6E0W
   HjMA6EUTlwYcv9kA/74bMosnT028koHFpictXtjdrK1ugJ1GpP0jnhyQc
   BEO88D1QrR4530VvwU0P5soKeBb+S/4jXc/KN0yOCqJwAvyTPSyhrLtpX
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="168484480"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:04:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:04:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 01:04:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sama5d2: fix compilation warning
Date:   Wed, 15 Jun 2022 11:06:32 +0300
Message-ID: <20220615080633.1881196-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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
Warning (simple_bus_reg): /ahb/apb/resistive-touch: missing or empty reg/ranges property

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 89c71d419f82..b147db8b973f 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -99,6 +99,16 @@ ns_sram: sram@200000 {
 		ranges = <0 0x00200000 0x20000>;
 	};
 
+	resistive_touch: resistive-touch {
+		compatible = "resistive-adc-touch";
+		io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
+			      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
+			      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
+		io-channel-names = "x", "y", "pressure";
+		touchscreen-min-pressure = <50000>;
+		status = "disabled";
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1050,16 +1060,6 @@ adc: adc@fc030000 {
 				status = "disabled";
 			};
 
-			resistive_touch: resistive-touch {
-				compatible = "resistive-adc-touch";
-				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
-					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
-					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
-				io-channel-names = "x", "y", "pressure";
-				touchscreen-min-pressure = <50000>;
-				status = "disabled";
-			};
-
 			pioA: pinctrl@fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.34.1

