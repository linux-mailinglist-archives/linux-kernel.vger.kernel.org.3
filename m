Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956135A2326
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbiHZIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiHZIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E2D3451;
        Fri, 26 Aug 2022 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503032; x=1693039032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vdr3+Nsguq4PGVOxtmLngGRI+Gao0SjewAh2bRon6EQ=;
  b=qm9qQVeYqEvKmMeupsFBz+VgYIcc/qosdLzZaBMabuylPKqxAmq/LTPu
   BrIAe14dDLJ6/Jcr8lsoITldCrAVjfWpxoZCl7rdAvIkkdvG/1CmDGUGA
   zY6xdPu5/+Ca14qEoorpY3+5rTBSat5GhFnoBUoeHy2M/x1ypR9GSqxLp
   44OSkgPUdb44kfrerDebl2vi1iHrzE3fm2LYR7wxwzWTfJWn+sGTxP6HM
   4fJomyEPZ8MFsofNHF51/DDPxLQPUm3zK4UPd+k/whEvFytTrhi9CWYQD
   ySmB10pTa9JgFElC7UcLCA4q5iKXFTdtkmpS2O2dAUOlWkyHtDmU9MaEM
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="174284213"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] ARM: configs: at91: remove CONFIG_MICROCHIP_PIT64B
Date:   Fri, 26 Aug 2022 11:39:19 +0300
Message-ID: <20220826083927.3107272-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
References: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f611af4c3bfa ("ARM: at91: Kconfig: implement PIT64B selection")
there is no need to explicitly select PIT64B.

Fixes: f611af4c3bfa ("ARM: at91: Kconfig: implement PIT64B selection")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

This is based on patch at [1].

[1] https://lore.kernel.org/all/20220818135522.3143514-2-arnd@kernel.org/

 arch/arm/configs/at91_dt_defconfig | 1 -
 arch/arm/configs/sama7_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 5cc72266eaff..9ea08337b174 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -196,7 +196,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
-CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 8803536854c6..72af50d9e48a 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -188,7 +188,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_XDMAC=y
 CONFIG_STAGING=y
-CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
-- 
2.34.1

