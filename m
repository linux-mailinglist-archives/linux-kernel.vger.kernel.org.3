Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F144477411
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhLPOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4047 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbhLPOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663904; x=1671199904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b86IW3HhpJSwbuz3dLx8QLN49UnEtkntajIQOuJgw18=;
  b=KNKRgoNYiMEbvJrErdDXRUc+Chg3NQG2c/HgKWPzHtyCQHto8Fimyeu+
   0Dml4ckGeUz4/QtoKzxNc7Hf/UFKgouM9Zt/lRTxaa44nI2rt+hBwZKqT
   P/TDbdi26G1GYD3HoX2Nd9L9U4x8BaePhNpNcZhGgfXhDROLHXJqqloKQ
   X0xPZSAbzbxi3/ezjXQw8a/Tiw25n5L1PTAV3CbRscdZRbUfrqZfpHLQB
   2/bpFxIFTZn7LP/csUc2glJUJZrv35/VqLLHqK9rGQnJwdY/edU5B/vwG
   VtmLg/PSL/WiEkA/JSOwFwUlOo+FkcvlySDd/zWy2FGMKn20P6Of5MkIO
   w==;
IronPort-SDR: 9ctn6o75rxKVBswj4J1ADDaZ7J4ktratHfBAsa3OzQUYv6sB3FD4P3BfMC0mWiv7HxoDTTQC/b
 Vg+QavkO9KgrlGbnO1QcXVs98Hr1l++1W19dHcV6OtSvKIdMr15x4307fenf5gHObVrOV2eeTU
 2LUVJoJ4+VPN1aI48IKDsi16UCGrNNkLKUDktIJ6Xjya4YyifPlEa2F/NEgPwb/NOh8Y0zOrFC
 JBO3Kk7ae8olR803aeHfZc4o8R0dn2Gt82FOn39sifG+EYfvjhshbah4ini7Mka9bBfuEq1TmN
 5Sf3d7L4Jtxg0fxY6gdiM7Zf
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="142638405"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:42 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] ARM: dts: at91: sama7g5: add opps
Date:   Thu, 16 Dec 2021 16:13:36 +0200
Message-ID: <20211216141338.35144-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OPPs for SAMA7G5 along with clock for CPU.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7039311bf678..22352ef5bc72 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -30,6 +30,43 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-90000000 {
+			opp-hz = /bits/ 64 <90000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1150000 1125000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-1000000002 {
+			opp-hz = /bits/ 64 <1000000002>;
+			opp-microvolt = <1250000 1225000 1300000>;
+			clock-latency-ns = <320000>;
 		};
 	};
 
-- 
2.32.0

