Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2975089B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbiDTNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350241AbiDTNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:50:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9F366AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650462470; x=1681998470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwRX/wGhY4CUVp8hOzGX0Hbv04KYjF219i4zxOzY1b8=;
  b=V45vdnCc/yx2H8lOLTN0Ya0zAVtv3RdnpZ6eEOuUBTwzG6lA0c/vj7ux
   8WDukkzavVKGfY5ti+sIVzzsAj4VZCVMWmmCdFoBz7M4usGdNrA2COnBR
   ltYlJceSgBmcV/gF7FJm4PFFh2Fx3+/nkcNpYWE2A33fJL/RTrf7Hy021
   djWhTrCawjJoDpihCCz68bXspvCk+JYOUPAqgC8HrMTjh0W3/NHAWP2jJ
   o/JlSmoq+9+JKeB+26iMYNALmEGtXJbtzJIMJ52ZUCUoEBmlp2kLc6Q1O
   DbYXmd7FwqWj9acMIp0g2jsDtGuik6ao7HeGJTdQM2WYDL4PdZrNXk9xL
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="161113717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 06:47:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 06:47:49 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 06:47:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/3] ARM: configs: at91: sama7: Enable MTD_UBI_FASTMAP
Date:   Wed, 20 Apr 2022 16:47:39 +0300
Message-ID: <20220420134740.193563-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420134740.193563-1-tudor.ambarus@microchip.com>
References: <20220420134740.193563-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fastmap to accelerate the attach procedure.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 07b0494ef743..03652454274f 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -94,6 +94,7 @@ CONFIG_MTD_NAND_ATMEL=y
 # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
@@ -221,9 +222,9 @@ CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_CMA_ALIGNMENT=9
+# CONFIG_DEBUG_MISC is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_DEBUG_FS=y
-# CONFIG_DEBUG_MISC is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-- 
2.25.1

