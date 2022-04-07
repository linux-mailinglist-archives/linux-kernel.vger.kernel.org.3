Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F764F771A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiDGHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiDGHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A81578E6;
        Thu,  7 Apr 2022 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315737; x=1680851737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxYyjrK7igJydMiwAHuSHa3rYPohXNdb9pi8bMAAvkw=;
  b=t0ig0kNE6+f1a4DAxyqJm4VQ/+f+ay0OaSaJ156+pmcrvv87D+wf/IUD
   Kg391a5hSj5D4PNtajhyNOwK5JiFvAuQY0BszocByfK1saAmS6QuUm1Bi
   09Hr4NzKSX8maOvmWGK/V5d6Lc5SJ/1JUyKYoS3/LRN4VpS9kH7d37aJz
   kDuBke4rAHA3/e5oIM7Zl+RLiFVHsA3q2v45U/0SA4Wd9Dxsn9DgU6/Ah
   7n8optSCzBYNx9v3I/yPlj3nWYaHFblWbYbl6nwyKKa8ct8zKWvnEoaU7
   P5tGGffcuTSlicQt66602UmVvra6VdE0/uTxNcshvbEIARwhXOvel6ePe
   A==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159247158"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:32 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 10/10] ARM: configs: sama7: enable CONFIG_RESET_CONTROLLER
Date:   Thu, 7 Apr 2022 10:17:08 +0300
Message-ID: <20220407071708.3848812-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_RESET_CONTROLLER. It is necessary for resetting individual
in SoC devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0368068e04d9..ce20bef1246e 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -180,6 +180,7 @@ CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_SAMA5D2_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_FANOTIFY=y
-- 
2.32.0

