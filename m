Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A84FE4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357039AbiDLPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357011AbiDLPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:30:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6E42ED7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649777304; x=1681313304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rd9ILy3F+kY0VTtPVuICodHaMg/lo8gQumFUm2poWyg=;
  b=de4Anf8hCaHt4qWciyMk/K6J5QNot2HUFJukXmjl5TodM2CCyBku22B1
   6Gi9Q7y4Z15ZKWLbwJZimy+KTohbHk+s9yx/zN4/65C6tJpTtIM+/c59j
   VWl27sw3OH0T+WA9M3Z34Y7iOXPnX4p6UlSs3xv9whJSRAoACLZSP8aoE
   Kaei2Vcp0UHAPqxJRQLXZHQ68NT0tzkyHqDf+t1/l9zxQPMOP559ISC5Y
   KdeLZ38oIrNsSjReFSGtjffGN4p0GElhfzYiYns/lao/D52n0P5LDYb0b
   ZuONCPG5v0eIAA0B7xyX5iM+BohSTxj17VnauSPQVrKgcF8k9nGarb30/
   w==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643698800"; 
   d="scan'208";a="169367318"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2022 08:28:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Apr 2022 08:28:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 12 Apr 2022 08:28:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/4] ARM: at91: pm: use kernel documentation style
Date:   Tue, 12 Apr 2022 18:30:46 +0300
Message-ID: <20220412153046.50014-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220412153046.50014-1-claudiu.beznea@microchip.com>
References: <20220412153046.50014-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel documentation style. Along with it fix the naming of
struct at91_pm_sfrbu_regs in documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 239339bf6f79..3ae0dca5135b 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -48,8 +48,8 @@ struct at91_pm_bu {
 	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
 };
 
-/*
- * struct at91_pm_sfrbu_offsets: registers mapping for SFRBU
+/**
+ * struct at91_pm_sfrbu_regs - registers mapping for SFRBU
  * @pswbu: power switch BU control registers
  */
 struct at91_pm_sfrbu_regs {
@@ -132,7 +132,7 @@ struct at91_soc_pm {
 };
 
 /**
- * enum at91_pm_iomaps:	IOs that needs to be mapped for different PM modes
+ * enum at91_pm_iomaps - IOs that needs to be mapped for different PM modes
  * @AT91_PM_IOMAP_SHDWC:	SHDWC controller
  * @AT91_PM_IOMAP_SFRBU:	SFRBU controller
  * @AT91_PM_IOMAP_ETHC:		Ethernet controller
-- 
2.32.0

