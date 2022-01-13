Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC748DA13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiAMOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49494 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiAMOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085301; x=1673621301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmrtV7L4VuwJz3LYKvfoOqzB/oLK+AvKPspo/IXOTRg=;
  b=tVAZxe1RJCudlrkQPTNp98/rpiFJDp2/0/IOdCm6eoxMKjsab95pQ3dc
   smKk66+56XpaMiVBCkebcZ254iwzuCigjlUcUMsWrBcr5TBpbkcrlF5x0
   MO/hz0r4GcZBYyysYJ/ntLgiVCP5m0TnTBHGkVSDKi+cmz1YJqQ2R2UFw
   f2/DJ3ZE47lXmQ8Bqb5f/zMyqToYFT7qOH2VYoTvfo174PKsvqPW7co12
   mvnt7s11dVBLVftxBjYm6wiIgBsMD+cjBjV4w9rg8DTXDRgtlRPR4e9TH
   exMiqt+NEedCD41BLvUb4x3vEH1iILsCbXbqyP9MTWf1yEg+fRFLecaBo
   g==;
IronPort-SDR: Y01vov0CloqVmI6zO3T7KbNSL5Hl3HF4+oSWEEjMWgG0z6GDUTn+CBefmhWH5dyYToI4g12tfT
 HsJvZcicu4/8cwgzf25hCd3gyXJYUgfnQHj9RLb5i5iwHI62Xd2e3ucLGYJCnutqOmt3AMCmcX
 8qXr0bMVsElenA70OpY6I0pbBaT8Hj3XvgfGVv+y6xJrdRNZPxi4gP7hYOkCP9Jm67Xk/vzVgC
 HLrBptyFgn+sNLafXl61SLpKl8XXsjciHqgTJotXLAGUy5rIz6YJOAgbwh2R+jNLVupXhPWrVB
 HSDW+pV7/b/pe8n69MYavpOC
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="149554008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:20 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/10] ARM: dts: at91: sama7g5: add opps
Date:   Thu, 13 Jan 2022 16:48:58 +0200
Message-ID: <20220113144900.906370-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OPPs for SAMA7G5 along with clock for CPU.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7039311bf678..21694519155e 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -30,6 +30,44 @@ cpu0: cpu@0 {
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
+			opp-suspend;
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

