Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3245448DA16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiAMOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:29 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19904 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiAMOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085304; x=1673621304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDlilDU1skIyaD7A5u8m29rcVwAwQx5M9HD/l01CDFo=;
  b=2h3Xvd3rWyUy7KoezCN/kRBWE9Y624W7UwktKK6xRPoTCEHc+xJ4jjdJ
   Jf7bXDwcEkCP4X4xzf38XaxLXDNFtqd+drUpt0nKmRKu87PBaOMuApomJ
   su5dBTciHS0fTxjA3ZuB2rynQTksMpxrcYRyibd6/9JlDSoimFtaWJGiK
   AuTHSFTvBPhS9U9hKRfbO9A7gLQ1UZKmg2lF71exUEdEEYmzcAzi5VCyz
   dqiPYy+15IVvKbtsaS/NrYEU+1KTy8uZ0p480dWl/lL5aRw4d03h2mEcN
   ClQ90i5dihvgFOAWyh4/1ywJierodsEOQ26nGXZnAwzGdSsnx7jKdvBmz
   A==;
IronPort-SDR: fn1VzKeICIFExi/unB8UW687rfNdm9rrvris/JE4fKrGQ2h79X/rMTiQhD5mb8FBs48oEBs98T
 M9SAuHTha5uErxTLyMeASAoIeGbsaVL3KbUtVsxtpvNGqNpivXcVn4X5+EcYidSBeC6IlMOh5W
 SkJKNeVnQlw0ACTJygmVYKBlV8Nh/yD86pcI/xfq0sNflKfUcIqYo71sZIDFnikdOsbkFVKy7m
 cm80LfhbUEVldqTzHCPBjkMuTK4A5+RsR/1BNUFnIq6ndl/sMNt4wb/egR6R2VUpMqskxMAxM0
 Wv4Xc5VUf3qgsSff9P7fp8J5
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="150108244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 09/10] ARM: configs: at91: sama7: enable cpu idle
Date:   Thu, 13 Jan 2022 16:48:59 +0200
Message-ID: <20220113144900.906370-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU idle support for SAMA7 config.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 938aae4bd80b..95c2a7ed4816 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -26,6 +26,7 @@ CONFIG_FORCE_MAX_ZONEORDER=15
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
+CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
@@ -33,7 +34,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_COREDUMP is not set
@@ -90,6 +90,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_MACB=y
 CONFIG_MICREL_PHY=y
-- 
2.32.0

