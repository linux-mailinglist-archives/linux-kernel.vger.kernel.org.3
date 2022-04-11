Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC44FBABC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiDKLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiDKLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:20:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716ED427DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649675920; x=1681211920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ea5nwmZ8Hu0lK2U2vtQf3n2ONvqD/pSJbCmGqETJbxM=;
  b=ShwRv9smSuhtbdrW3gTH88J2aLpdYr93Mo00JhDRiAyEwiY38hnxH15l
   //wJNHk+oqitxFDardYT7XfIJQDohevbXOSJ06VFmyUiwZoWzb+5CO3si
   Z60lxcTX8nwMewTXZ/MW/6nPeZxQX2DG5GIWvGnOnL6qsa9Mb0HMMKPZ7
   /St0M1WrzU2GmsbLabgE2/ZQCAy0P6ETdCKCLHoo0CdP6KSI94vWr5q1K
   Gg00JhO8X/u2e2+XdpUZlA1VsSyusOWxWet3A0odb4qtNMkUSahJXTSzv
   0Ck6/bQ66T+eX0eA/TF/zlmtKXEUcGZI73fSXU7WX0RFD7NuDg46X7svB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159637099"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 04:18:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 04:18:38 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 04:18:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] ARM: at91: pm: use kernel documentation style
Date:   Mon, 11 Apr 2022 14:20:57 +0300
Message-ID: <20220411112057.35369-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220411112057.35369-1-claudiu.beznea@microchip.com>
References: <20220411112057.35369-1-claudiu.beznea@microchip.com>
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

Use kernel documentation style.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 239339bf6f79..6f5ca50e71f4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -48,8 +48,8 @@ struct at91_pm_bu {
 	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
 };
 
-/*
- * struct at91_pm_sfrbu_offsets: registers mapping for SFRBU
+/**
+ * struct at91_pm_sfrbu_offsets - registers mapping for SFRBU
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

