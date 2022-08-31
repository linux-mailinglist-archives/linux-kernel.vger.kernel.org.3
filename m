Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CDD5A86E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiHaTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiHaTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:40:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D596CF79;
        Wed, 31 Aug 2022 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661974833; x=1693510833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4bmvLCTTLBxZRcx6fVrs5EHtRWvo5Do0uZmvfOsTOHQ=;
  b=Zxx3Hlw7nuJU91ynHPnR5ZchoTpbkdaqMzmbWWVcMILzTK1Phjnd+Lw8
   1Sn4fa3vDg4Cr7n+WdwmEsnmJI8XsZj/zFoueS3J+fPiZXgNQcgw5GrS0
   oxR4WpAyLwFu/nGl+HcGIPLMKiurLdNyqXFF2xM7HYoRNwz2YOTNu9Eye
   p04nNsAXBhjnC1tyJ3i4KdQXVH2l6zhafEVhuL2pTWBdgz5OJ71IBDZ+6
   mt5B6J2678UwGyqi3hTuAKNfrWnMteDBkJYT7jk0byBDKfO8V2Tbmzca7
   y6x0iAt5dVbLXVLStlaoVinoX8TwVQ6iTLS0rlMHFLxLodVNCVfQvlvJd
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="171842658"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 12:40:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 12:40:27 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 12:40:26 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: add led configuration
Date:   Wed, 31 Aug 2022 21:44:30 +0200
Message-ID: <20220831194430.53108-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add led configuration for pcb8291 and pcb8309. Both pcbs have 4 leds which
are connected to the sgpio controller.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 29 +++++++++++++++++++++++++++
 arch/arm/boot/dts/lan966x-pcb8309.dts | 29 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 24d9055c4a08..649cfe69d98d 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -23,6 +23,35 @@ gpio-restart {
 		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 		priority = <200>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		led-s0-blue {
+			label = "s0:blue";
+			gpios = <&sgpio_out 2 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s0-green {
+			label = "s0:green";
+			gpios = <&sgpio_out 2 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-blue {
+			label = "s1:blue";
+			gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-green {
+			label = "s1:green";
+			gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
 };
 
 &gpio {
diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts b/arch/arm/boot/dts/lan966x-pcb8309.dts
index 05ce27ed5648..4f30975b4a13 100644
--- a/arch/arm/boot/dts/lan966x-pcb8309.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
@@ -42,6 +42,35 @@ i2c103: i2c-sfp@2 {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		led-s0-green {
+			label = "s0:green";
+			gpios = <&sgpio_out 2 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s0-red {
+			label = "s0:red";
+			gpios = <&sgpio_out 2 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-green {
+			label = "s1:green";
+			gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-red {
+			label = "s1:red";
+			gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
 	mux: mux-controller {
 		compatible = "gpio-mux";
 		#mux-control-cells = <0>;
-- 
2.33.0

