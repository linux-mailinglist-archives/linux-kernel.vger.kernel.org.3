Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B7578CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiGRV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiGRV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:26:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47442F011;
        Mon, 18 Jul 2022 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658179578; x=1689715578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RlVufiXTHzC4WPLNtwom5sZQqrDoICj4LD/vo1jP8Y=;
  b=UVQ62QVowMISA1vuuJe3dy8L+yymAzL65HSpvrSoX6LpPcOCo6Lcn3gw
   2Lg4KlV/7gJKIhPP8BCHjguTzsFOcNKyfAE3NB1QxpSJq/qUPAm6Kpish
   NNR+E1W81FSRX6jhYrpacsF/AsdU3d5qNetQcayenNa3a4eAyLxZGdS7M
   zJ00khBmHAgC+pQUsCfAVRvv1+TAfBFpb5rRUE0Dzdlp9oQDp0h2mo1EP
   k3blxkRyUn2V9gEMX7nPuoIP6umTLRMDIuiH+1laHLxplScY/0rYm1+kJ
   s8Io1ZGnWRAXkP5MnAp1OHleYldsCRBdbE1hv/l2RGILqlKXUYaXaYftc
   w==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="105020709"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 14:26:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 14:26:13 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 14:26:11 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 3/3] ARM: dts: lan966x: Enable network driver on pcb8291
Date:   Mon, 18 Jul 2022 23:29:21 +0200
Message-ID: <20220718212921.1506984-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcb8291 has 2 ports that are connected to the internal ports of the
switch. Enable them in DT.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 2cb532aa33f0..d890e6fcdbae 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 #include "lan966x.dtsi"
+#include "dt-bindings/phy/phy-lan966x-serdes.h"
 
 / {
 	model = "Microchip EVB - LAN9662";
@@ -32,6 +33,40 @@ fc3_b_pins: fc3-b-pins {
 	};
 };
 
+&mdio1 {
+	status = "okay";
+};
+
+&phy0 {
+	status = "okay";
+};
+
+&phy1 {
+	status = "okay";
+};
+
+&switch {
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
+&port0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "gmii";
+	phys = <&serdes 0 CU(0)>;
+};
+
+&port1 {
+	status = "okay";
+	phy-handle = <&phy1>;
+	phy-mode = "gmii";
+	phys = <&serdes 1 CU(1)>;
+};
+
 &flx3 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
 	status = "okay";
-- 
2.33.0

