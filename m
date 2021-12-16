Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87793477405
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhLPOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4013 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhLPOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663892; x=1671199892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DSaF+rce8x7D+Hdysx6zQcXry3snwSGAnsCyiWnFVNw=;
  b=a6vGTp6pPnMnaanHuprrsdi6mkZRKe6aAI0yGossFQ2IgLmAwxJ4vtbw
   5pZ0Qa2Bz27UI1Kqv0MveKvvmQVByrZkKWGz/z4GCWTJ3PuA8G3Eklv/K
   1ayxn2Fzf/eem5olaw2vEF8ntY08wpucx0axZaX+p6wtXXpZGsvMK0PT0
   ZbJXJgp2Cl2oCYH2+4tJYDTZeFfPeRknzcoXcSiT6sq7x+VVz2eTocC9Z
   AyWWiXxtIFnbPCE72oyMN0fhSPPxXVG70s1IB7ICzpxC47ZWne2laWVHG
   hEOQ7FsS0MV4bPfLO8+pqiVTi4RCJZmEtItX/edNbdc1X2ltsl0gOWhrE
   g==;
IronPort-SDR: 26KbRLjsFVEu7kzGesrBsmYP0+8JS1futd22WR8gy3aIoDjfTvn514C7cV398ehOzpCMwWI7Qm
 bu/46vEf5o/fxA2u0ncAi/2sgEA1uzEnSTKHHEzKdEWcwzS5Sr1s58b4U/FdflILpztc11apig
 /yIvXU2kcHMJtOicHwvzM6pD7/WTadoz2vYMoESl1e99e5+IMB3CUmgtPb40ED7y53iVKqHfHD
 d2Ez/S+LeCJ1j++O99msdShzqB9mqiHIX0AqLZcjPC9KfRMwU3y6AFX0m+MSO2vl+E91CplNlX
 P4MfJ70NiA9k7f3dEtwEg7wa
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="142638372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:30 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] ARM: at91: ddr: align macro definitions
Date:   Thu, 16 Dec 2021 16:13:32 +0200
Message-ID: <20211216141338.35144-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
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

