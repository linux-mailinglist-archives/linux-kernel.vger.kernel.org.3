Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843704C6C37
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiB1MYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbiB1MXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D722674DC4;
        Mon, 28 Feb 2022 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646050990; x=1677586990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJ+kxqk3NvTMW/N1ZtFT2ldtSi/XXVQ6ffDJR2a6h7A=;
  b=C4Q984FBwqZL0YtHPASvQFrR22y68kKcnkSk8LJU4dkvBzuVbgGq4XI6
   IztP2OHx2OI7TXmUtBQiByf9k72sw19KdiYJ2Ws9QA0iMGRet4t1hX5VG
   Ys34PZmhQJRQbJvSUd19BE9hTbc5SGLkhLl6U0cQVKZSljrvdJ3B80XZC
   6CQSniTmb3XXhlwSkCL/6zayU0A36JLRl5QZIBsPKywO04MJ4CJ2d7XM+
   LBPbqRur1u+lVibh/jvR4Q7jeMdOiokIRKEcwNEiPlLvvEBeb/8m0dm3T
   nhbXMT3xNHsx0gYArt617yccBjPXdihTm2A/8FhfT5JwkW+ku7qdfmKqB
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155104988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 05:23:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 05:23:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 05:23:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] ARM: configs: at91: add eic
Date:   Mon, 28 Feb 2022 14:23:26 +0200
Message-ID: <20220228122326.1400954-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220228122326.1400954-1-claudiu.beznea@microchip.com>
References: <20220228122326.1400954-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eic.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index aad10ae85a7d..ecb5c4b750e1 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -190,6 +190,7 @@ CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_SAMA5D2_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
+CONFIG_MCHP_EIC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_FANOTIFY=y
-- 
2.32.0

