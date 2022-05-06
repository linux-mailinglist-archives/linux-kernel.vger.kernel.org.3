Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64F51D344
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiEFIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390096AbiEFIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:25:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8267D30
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651825284; x=1683361284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCZ7tf8swc42sTh2YWD4MFvR2VJQhs2OP1xbpe/qwKk=;
  b=HLv+jXY9jWBaRO8rGNelutLv69mBoH7PuUBnixgP6w/wUQ/k/1NzSA3g
   YSu4xjzja5aMUpZsERgSrus9laG19TfkgSOXSskLw40UtNByMyuJ4g6ZH
   OfvYvEvAcG7QuoCdM6FBRxLJCuYO8CXCR+iP9s3bb81QZmSi1Lt422sJO
   1jvQ0PvpKuvPVjTWoxWygeqedbwWAQzCyQnmjVQQw3QAltm+ivKrYxniu
   emwmicg5PFyM+Na29Uv9Aq7pB9uEnUgJNimv3PZr+qYcIKgVJ4X2Pir69
   aqmgpSGb1uTUM+9ZOQ9sEdz0pn3Y4quDs/pFvZZf8i4yoTl6bE9jJYEKp
   w==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="162959415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2022 01:21:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 6 May 2022 01:21:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 6 May 2022 01:21:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/4] ARM: at91: pm: use kernel documentation style
Date:   Fri, 6 May 2022 11:23:34 +0300
Message-ID: <20220506082335.3817259-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
References: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2a52ddac7692..84ada8e2a7fd 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -47,8 +47,8 @@ struct at91_pm_bu {
 	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
 };
 
-/*
- * struct at91_pm_sfrbu_offsets: registers mapping for SFRBU
+/**
+ * struct at91_pm_sfrbu_regs - registers mapping for SFRBU
  * @pswbu: power switch BU control registers
  */
 struct at91_pm_sfrbu_regs {
@@ -81,7 +81,7 @@ struct at91_soc_pm {
 };
 
 /**
- * enum at91_pm_iomaps:	IOs that needs to be mapped for different PM modes
+ * enum at91_pm_iomaps - IOs that needs to be mapped for different PM modes
  * @AT91_PM_IOMAP_SHDWC:	SHDWC controller
  * @AT91_PM_IOMAP_SFRBU:	SFRBU controller
  */
-- 
2.34.1

