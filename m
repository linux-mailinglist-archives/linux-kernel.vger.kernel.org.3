Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8D3472E11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhLMNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:53:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23940 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbhLMNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403600; x=1670939600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ir9v+M5DO0zKIELA5L6fGOqP2IexYn1myL5Ikj6pBi4=;
  b=DKmyB9FzJgLeSH+I6Afrlt0K6aSRvH5XHHKuZosIpz1zK9OCSd3xFBef
   DXQgXQzcw/BO8z27rQ4mnHu626vji0b4Yhx22ifQDw2DvMXT2HB1k2hi9
   XtDuS65bEzC5qSBDwYK6pcJ2t8g0Pj1uZUT1tB9GeUxLgqKpOy76+XWrc
   y3+kfuuj8zpWsNUAFlXq32l/msNjT8D4fUXnE3JyNxd36Iwy2sls21Mpx
   hpIID61v9S7Njd1lkhktf6Ree3DVkOYD5jPcWUGldy1s2NjbRqYdCb27C
   fd8AsaKnYNyvLqFyzoJyIO5dRMOiwIp1jVSy//rgWiKOj0bdTJY5g9+JQ
   Q==;
IronPort-SDR: 8XAcazy1l76yCduGnUSxLV8TGY2UGGzvEohSiR7Z3j+RsOnVZ2xibaWzHPE0dzfgWbG06qaSzx
 uwL3ODuDv2Z5XEcI4c82R7TKbKC5MmI8fPwSA0Irhk8+yCspMfW45I6B65ghQT+hIvncIefFaz
 gI/WAybtcEZHmoyyYnIDPzo/0Yr/i1LlxsRjhiws1Jl2PJ8mbbvwC3ux02fSxhR2YpALmqZxXN
 PzJRN5F6tA8yCc1Otj2oXbRXo2CsRKS5K5YoNu7lin5IgR/iPIPYiz7glBDr8mGzkkae4MCHcK
 mKKs5VeTij3zamt0pA2vniGR
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155269974"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:53:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:53:19 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:53:14 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 13/23] ARM: dts: at91: sama7g5: add nodes for video capture
Date:   Mon, 13 Dec 2021 15:49:30 +0200
Message-ID: <20211213134940.324266-14-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the XISC (eXtended Image Sensor Controller) and CSI2DC
(csi2 demux controller).
These nodes represent the top level of the video capture hardware pipeline
and are directly connected in hardware.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
- change bus width for endpoints to the default 14

 arch/arm/boot/dts/sama7g5.dtsi | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7039311bf678..4d0a93541d5f 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -236,6 +236,54 @@ sdmmc2: mmc@e120c000 {
 			status = "disabled";
 		};
 
+		csi2dc: csi2dc@e1404000 {
+			compatible = "microchip,sama7g5-csi2dc";
+			reg = <0xe1404000 0x500>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&xisc>;
+			clock-names = "pclk", "scck";
+			assigned-clocks = <&xisc>;
+			assigned-clock-rates = <266000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					csi2dc_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					csi2dc_out: endpoint {
+						bus-width = <14>;
+						hsync-active = <1>;
+						vsync-active = <1>;
+						remote-endpoint = <&xisc_in>;
+					};
+				};
+			};
+		};
+
+		xisc: xisc@e1408000 {
+			compatible = "microchip,sama7g5-isc";
+			reg = <0xe1408000 0x2000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 56>;
+			clock-names = "hclock";
+			#clock-cells = <0>;
+			clock-output-names = "isc-mck";
+
+			port {
+				xisc_in: endpoint {
+					bus-width = <14>;
+					hsync-active = <1>;
+					vsync-active = <1>;
+					remote-endpoint = <&csi2dc_out>;
+				};
+			};
+		};
+
 		pwm: pwm@e1604000 {
 			compatible = "microchip,sama7g5-pwm", "atmel,sama5d2-pwm";
 			reg = <0xe1604000 0x4000>;
-- 
2.25.1

