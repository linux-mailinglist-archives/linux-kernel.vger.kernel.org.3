Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64C4CBFA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiCCONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiCCON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:13:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AD3CFDE;
        Thu,  3 Mar 2022 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646316760; x=1677852760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIKT5jfoAPP6qi8Q03VSCyqWe/v8lRvCpzkdyDNOaB0=;
  b=0UWAgAGSOb3I5+gKl7SHNyWU1AgtV6Fhsm4Ya23NDzjjLHayOHJDozQV
   DEbIjkC2nlxha9wDWq7cizy888C5LLc9gZQkoZkbqAiIbkjgNTKF7WsF+
   RAvr4DWw8b205vpuP0Dg1HVPziXG8E8gTOG2tBSibKlA/j5+NpJ2g5ZjX
   kr6ZWUaTMguQZCnXD2FufbsztyMaTHMaS6AKlCH+k5Y6TpaG2KPF7CWkE
   HJud4qJZzSAFHKrqIzQH599kyID5olyaXmdcX1sQ9zCc0NyhPRp8Kl99z
   k3STvoGyoPoMWQe1NGxac2idzzawfIOEA+qO4q2+GNMnbkcTvPc8xI/mb
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="155582398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 07:12:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 07:12:38 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 07:12:33 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2 2/5] ARM: dts: at91: Add the required `atmel,rtt-rtc-time-reg` property
Date:   Thu, 3 Mar 2022 16:06:23 +0200
Message-ID: <20220303140626.38129-3-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303140626.38129-1-sergiu.moga@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required `atmel,rtt-rtc-time-reg` property to the `rtt` nodes
of the RTT IPs.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 1 +
 arch/arm/boot/dts/at91sam9263.dtsi | 2 ++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7adc36ca8a46..ac50b164138a 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -627,6 +627,7 @@ rtc@fffffd20 {
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&slow_xtal>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index fe45d96239c9..6be91df2a8b1 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -734,6 +734,7 @@ rtc@fffffd20 {
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&slow_xtal>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "disabled";
 			};
 
@@ -742,6 +743,7 @@ rtc@fffffd50 {
 				reg = <0xfffffd50 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&slow_xtal>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x4>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 730d1182c73e..80e41f115216 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -805,6 +805,7 @@ rtc@fffffd20 {
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&clk32k>;
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
 				status = "disabled";
 			};
 
-- 
2.25.1

