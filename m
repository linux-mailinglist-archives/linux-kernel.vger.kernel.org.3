Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78DE46CDD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhLHGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:39:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19942 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhLHGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638945360; x=1670481360;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JZyauMf/QTl4EwtWKYII/twRG1Vb/ZVYO/ePRC29A4o=;
  b=r1ErZCkRh5QL55k7gei0ZjvodzQ+Bkk9+iQOnBpNRswBfg94TC4hsRp9
   fSrAMLsDK3uf3Cb6TIKZ31u1/qvcdF9pjlQLmJYUH/rTYrHmIid24Wj8+
   6ugYv92NM85bLzp6m+PxbAQpwGBpAd9oaVpGBDZnGHwVogxYhcmxQtz2i
   Pb6D7IXOkNU3f3RCyrU8ORbx4JohvHKJ5AvyrY87glkMi9XXfZI0GF8K1
   WKZ1xftXnXQcGCETIO75J91eIFmJCxrRBcoGcA+dV/p27xql2fg+x3j0b
   jkxW+D5S9h/19niW1kNEJcAytrECXxojay1UEVX9fgExSqTi6fx7LiTxV
   A==;
IronPort-SDR: eybXD5A/FR6sVb6LdalXPObrfFd0gWEcbWBxcwuuQuHm1YznQJVNVQ4b6PVL1yw5txrjur+VIG
 mhV3v7oYFRWTnhL/q33xywIc7KJWutiD+s9t+BlONJSz194O4TiR5eRc2GXsx/500/ljG5w0zj
 vj2OepAI8BtEMTXD4jQkc59yRf3dGp8B8M5yXcxOl1i7hkckbIYsvH1eDG7MFokIGUHoHwJPB8
 ybwfjVjegjcU6dwL7nw6kQ1+9bv5JYO/pFXfeXkYEAV4/4eSIGnjnP6Pr/BaotUQvzZDW9dQiR
 Aeb9rDkvO7iCXYn8u6ZDi9ws
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="78856782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 23:36:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 23:35:59 -0700
Received: from che-lt-i63539u.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 23:35:56 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH] ARM: dts: at91: update alternate function of signal PD20
Date:   Wed, 8 Dec 2021 12:05:53 +0530
Message-ID: <20211208063553.19807-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternate function of PD20 is 4 as per the datasheet of
sama7g5 and not 5 as defined earlier.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/sama7g5-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/sama7g5-pinfunc.h
index 22fe9e522a97..4eb30445d205 100644
--- a/arch/arm/boot/dts/sama7g5-pinfunc.h
+++ b/arch/arm/boot/dts/sama7g5-pinfunc.h
@@ -765,7 +765,7 @@
 #define PIN_PD20__PCK0			PINMUX_PIN(PIN_PD20, 1, 3)
 #define PIN_PD20__FLEXCOM2_IO3		PINMUX_PIN(PIN_PD20, 2, 2)
 #define PIN_PD20__PWMH3			PINMUX_PIN(PIN_PD20, 3, 4)
-#define PIN_PD20__CANTX4		PINMUX_PIN(PIN_PD20, 5, 2)
+#define PIN_PD20__CANTX4		PINMUX_PIN(PIN_PD20, 4, 2)
 #define PIN_PD20__FLEXCOM5_IO0		PINMUX_PIN(PIN_PD20, 6, 5)
 #define PIN_PD21			117
 #define PIN_PD21__GPIO			PINMUX_PIN(PIN_PD21, 0, 0)
-- 
2.17.1

