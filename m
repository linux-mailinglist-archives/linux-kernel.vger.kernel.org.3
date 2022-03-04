Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50BB4CD663
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiCDO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiCDO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:29:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C61B60AA;
        Fri,  4 Mar 2022 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646404143; x=1677940143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8g3gZftiBYWV0bZd37SeIk4FX3+PNGzE1na0rqb1vFM=;
  b=rPJmygVjtvkY9d1w2FgX7mWnduwroe1ioqKGVi0G/R1a82diK95z/6fP
   mThyg4DTf1NWNQX0GpZhWQcjZ3H3h3P6tvafogBFiW3wbPSzYN0f2megC
   H+iT4byoOSccyrAwaXcEpQXd86u/kxHdNXefh2Tve78tJoJfOJPFuIKrq
   JsowQMliyLOqj0vGYaFdTquryQKglv3haHqJilXu7VF7LH4bopZnNLLqs
   5cewgszGI6cOoQyGMbDhtBfblqojbpxkDKtu/d1VHYwtMa1FmKsuXqOjV
   1ZI9njZnj5BIzQifew3clG1vETTZfKKus5+i06zku0C7KdVXl/HlZzuSu
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87839011"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:29:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:29:02 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:29:00 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 1/5] ARM: dts: at91: Add the required `atmel,rtt-rtc-time-reg` property
Date:   Fri, 4 Mar 2022 16:27:42 +0200
Message-ID: <20220304142746.121947-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304142746.121947-1-sergiu.moga@microchip.com>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
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
of the board files that were missing it.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
 arch/arm/boot/dts/at91sam9263ek.dts | 8 ++++++++
 arch/arm/boot/dts/at91sam9rlek.dts  | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index beed819609e8..3c1f40b4a13e 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -178,6 +178,10 @@ dbgu: serial@fffff200 {
 				status = "okay";
 			};
 
+			rtc@fffffd20 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+			};
+
 			watchdog@fffffd40 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 71f60576761a..1208bb580d14 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -102,6 +102,14 @@ mtd_dataflash@0 {
 				};
 			};
 
+			rtc@fffffd20 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+			};
+
+			rtc@fffffd50 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x4>;
+			};
+
 			watchdog@fffffd40 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 62981b39c815..a26f9f70b6b2 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -212,6 +212,10 @@ watchdog@fffffd40 {
 				status = "okay";
 			};
 
+			rtc@fffffd20 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+			};
+
 			rtc@fffffe00 {
 				status = "okay";
 			};
-- 
2.25.1

