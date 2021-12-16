Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D34477408
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhLPOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4013 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbhLPOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663895; x=1671199895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8B+mjGEHiWRvOo09WcjQMA43OD+N7/Tq2fPJzC7/86M=;
  b=Vqi+N2blEMlHyRuzZ+S741qfwkppwDCOQXCWNF+i41PaKTpJMkVz3Hcg
   KzFO2BT6oAb2wVApv+gXa4stfr6WLFCDT/lfF8oteN1DP03k57IfYgL+t
   Oy+u49xTOwcG5562sgOgIipcYzDbQlbOzv9oqI7gHjanzzz8rR6QnEalJ
   9Ssf9qq/WDqHAJYP4wHgBsK+ZMJ5RqjwMRuaY4silsdZpu4dWfkv84MSQ
   FmaJG8hqqieV0/mhoDEbw0k6D5CIJMfeKGwYxsQs/M7eKdwR3FQlA1Pk9
   Ld4jsV4Wfe8AQZZBJxEMgDqJ3zWzNtUtVsjqXAE4oRa2vtgF1q9fe16f1
   g==;
IronPort-SDR: Qyh4Z3CHOoL6ZV9VjvmkXdDjRb1Qx5zqIIxIcW5y+zEZ0vhT1K98c91Pjpg2hRsxOq4wDLbUpu
 IIsq5w3kM+/x0vp3xrEZN3TyJ53wP+1OIy2ZqFwrI0Jr91183Pg+78Zgytd6aHYARHSZdiTUnb
 AeT0N3RXbcRX1aLJPAG9WtUk544P8/w+X3src1zrbWYuO/gyZXs61uIzvx2cCLxIp2Xxuijt24
 +0sut8B+0ZH7zFLD0FPir+FBC0sfslvmf0yRpK/QJ46PbZDCu6PJzHKQFeY0n2I/jwBizs9/O3
 Ae1VK5vSc1oJ0rDFMpqQawP8
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="142638381"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:33 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] ARM: at91: ddr: fix typo to align with datasheet naming
Date:   Thu, 16 Dec 2021 16:13:33 +0200
Message-ID: <20211216141338.35144-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo on UDDRC_PWRCTL.SELFREF_SW bitmask to align with datasheet
naming.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 4 ++--
 include/soc/at91/sama7-ddr.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index fdb4f63ecde4..abe4ced33eda 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -159,7 +159,7 @@ sr_ena_1:
 
 	/* Switch to self-refresh. */
 	ldr	tmp1, [r2, #UDDRC_PWRCTL]
-	orr	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	orr	tmp1, tmp1, #UDDRC_PWRCTL_SELFREF_SW
 	str	tmp1, [r2, #UDDRC_PWRCTL]
 
 sr_ena_2:
@@ -276,7 +276,7 @@ sr_dis_5:
 
 	/* Trigger self-refresh exit. */
 	ldr	tmp1, [r2, #UDDRC_PWRCTL]
-	bic	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	bic	tmp1, tmp1, #UDDRC_PWRCTL_SELFREF_SW
 	str	tmp1, [r2, #UDDRC_PWRCTL]
 
 sr_dis_6:
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 817b360efbb8..fee1b11bddca 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -53,7 +53,7 @@
 #define		UDDRC_STAT_OPMODE_MSK		(0x7 << 0)	/* Operating mode mask */
 
 #define UDDRC_PWRCTL				(0x30)		/* UDDRC Low Power Control Register */
-#define		UDDRC_PWRCTRL_SELFREF_SW	(1 << 5)	/* Software self-refresh */
+#define		UDDRC_PWRCTL_SELFREF_SW		(1 << 5)	/* Software self-refresh */
 
 #define UDDRC_DFIMISC				(0x1B0)		/* UDDRC DFI Miscellaneous Control Register */
 #define		UDDRC_DFIMISC_DFI_INIT_COMPLETE_EN (1 << 0)	/* PHY initialization complete enable signal */
-- 
2.32.0

