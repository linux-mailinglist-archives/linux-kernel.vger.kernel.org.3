Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2448DA00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiAMOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31589 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiAMOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085282; x=1673621282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DSaF+rce8x7D+Hdysx6zQcXry3snwSGAnsCyiWnFVNw=;
  b=HqFKY67xUV+laPC/39dsTeoSlOp/t/WIJDHkmaV27sfqEa7eWHoh+9+2
   HXhcCeihomJaT7DToSKhzfGEFhiKqscxhLrRJ2aDQZhIvaHmiDtMoGkfR
   KJIeXGkP188sNzLwABlGkq1hkUSDF3y0Zem1LA4FMMtWpkWLOf6kR797Z
   0iAmDrtkwn1Gdpj+nBfZqYbaSITZS+p55QFIQSlr4iZxZE77driD4EzJm
   C08vlsKBx4j0vOwaEfdFU/cjkNEUHwzMdmtJrGTZL2t//67CrXgVcwvpq
   kf/2Eq7ZCHpiy1jJ2oKWv+FZXgo3GRlUtFP8fBpF6GDMwa0uLebp66py3
   w==;
IronPort-SDR: /kdMeHcO7FdvdUxY8sX5s/Ek+BSN30m/Tvr3/0D4DnmjldLEVxpVbU9uI8XTqYvDfxZ83mpnF/
 cSrHIoJfzsgWAh+bY2yecOfDJ4LrOzIMp59zNRIpU3sPSElrlKOsr+EhKtfUb5bjFj6WR2fCto
 +4oZJ8dBqmG5KuChvh+6BeVTpBPgCNngnzrqxVQZtcP243rQa43MDDyNRCr42z65YSB+Z03oR/
 cCS7sD/Z77SDQxeEatAqLiw8fr6mHd1t7pCiCqSpIC4k7/Rvt2B4vZ+vV/h5QTB3BxEWIlqzEW
 UwscTB8lGikMIJvdo4GN/gVL
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="158557502"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:01 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:47:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 02/10] ARM: at91: ddr: align macro definitions
Date:   Thu, 13 Jan 2022 16:48:52 +0200
Message-ID: <20220113144900.906370-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align all macro definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/soc/at91/sama7-ddr.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 13b47e26cdbe..817b360efbb8 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -13,11 +13,11 @@
 
 /* DDR3PHY */
 #define DDR3PHY_PIR				(0x04)		/* DDR3PHY PHY Initialization Register	*/
-#define	DDR3PHY_PIR_DLLBYP		(1 << 17)	/* DLL Bypass */
+#define	DDR3PHY_PIR_DLLBYP			(1 << 17)	/* DLL Bypass */
 #define		DDR3PHY_PIR_ITMSRST		(1 << 4)	/* Interface Timing Module Soft Reset */
-#define	DDR3PHY_PIR_DLLLOCK		(1 << 2)	/* DLL Lock */
+#define	DDR3PHY_PIR_DLLLOCK			(1 << 2)	/* DLL Lock */
 #define		DDR3PHY_PIR_DLLSRST		(1 << 1)	/* DLL Soft Rest */
-#define	DDR3PHY_PIR_INIT		(1 << 0)	/* Initialization Trigger */
+#define	DDR3PHY_PIR_INIT			(1 << 0)	/* Initialization Trigger */
 
 #define DDR3PHY_PGCR				(0x08)		/* DDR3PHY PHY General Configuration Register */
 #define		DDR3PHY_PGCR_CKDV1		(1 << 13)	/* CK# Disable Value */
@@ -65,7 +65,7 @@
 #define		UDDRC_SWSTAT_SW_DONE_ACK	(1 << 0)	/* Register programming done */
 
 #define UDDRC_PSTAT				(0x3FC)		/* UDDRC Port Status Register */
-#define	UDDRC_PSTAT_ALL_PORTS		(0x1F001F)	/* Read + writes outstanding transactions on all ports */
+#define	UDDRC_PSTAT_ALL_PORTS			(0x1F001F)	/* Read + writes outstanding transactions on all ports */
 
 #define UDDRC_PCTRL_0				(0x490)		/* UDDRC Port 0 Control Register */
 #define UDDRC_PCTRL_1				(0x540)		/* UDDRC Port 1 Control Register */
-- 
2.32.0

