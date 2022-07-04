Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF065657FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiGDN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGDN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:58:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4F10B3;
        Mon,  4 Jul 2022 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656943129; x=1688479129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Rd2VhqWRy5Lh37VwtNPex5l+zsOkNuQYWDNY6kfDxM=;
  b=zAlBH9GUnLBGAIgIwEWUACYbsgfWBHY/9eC+YFh//NUuHErKBVibRhEA
   ymoV4lh3Y02wJee9n2ueFf/sYBiLIUzxO4afrnra10TIgE4BHTRDEtID0
   ko443PnihKhjw9qamkwGwbK0RX9VGuVEB48lhMLVvIdzSBOPJADNWvKd2
   zV9OtAnWFqQ+k//MUUB8fAeB7aqxodynpk6f6TknRIOEEVhFOoqdVwVLX
   1hEu28kQ3IhAeY+ODM9ecEQAbHn+KeEyrqgk2qco6kJquodPSMZcPwEZ9
   Fj6t3NkN21oOtITl4ZVxMCqpIX/qjGwXqtzwOI+20fVCGYdHQAA2tn61p
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="102929581"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 06:58:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 06:58:48 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 06:58:44 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <claudiu.beznea@microchip.com>
CC:     <soc@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2] ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl settings.
Date:   Mon, 4 Jul 2022 11:58:09 -0200
Message-ID: <20220704135809.6952-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pcb8291, Flexcom3 usart has only tx and rx pins.
Cleaningup usart3 pinctrl settings.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
- Keep both tx and rx pins into one node.

 arch/arm/boot/dts/lan966x-pcb8291.dts | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 3c7e3a7d6f14..d56d2054c38d 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -19,19 +19,9 @@ aliases {
 };
 
 &gpio {
-	fc_shrd7_pins: fc_shrd7-pins {
-		pins = "GPIO_49";
-		function = "fc_shrd7";
-	};
-
-	fc_shrd8_pins: fc_shrd8-pins {
-		pins = "GPIO_54";
-		function = "fc_shrd8";
-	};
-
-	fc3_b_pins: fcb3-spi-pins {
-		/* SCK, RXD, TXD */
-		pins = "GPIO_51", "GPIO_52", "GPIO_53";
+	fc3_b_pins: fc3-b-pins {
+		/* RX, TX */
+		pins = "GPIO_52", "GPIO_53";
 		function = "fc3_b";
 	};
 
@@ -53,7 +43,7 @@ &flx3 {
 	status = "okay";
 
 	usart3: serial@200 {
-		pinctrl-0 = <&fc3_b_pins>, <&fc_shrd7_pins>, <&fc_shrd8_pins>;
+		pinctrl-0 = <&fc3_b_pins>;
 		pinctrl-names = "default";
 		status = "okay";
 	};
-- 
2.25.1

