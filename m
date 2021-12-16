Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14235477417
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhLPOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4047 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbhLPOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663906; x=1671199906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bDlilDU1skIyaD7A5u8m29rcVwAwQx5M9HD/l01CDFo=;
  b=2h8IEagDuIP+YAmQBVuVuhoRVsPViN3wKoww4x24HkUpcV9ZlDJ7zqVE
   f5EgddEQZWgF//yOURevxVaDp17ahE7KxDzuTftA4iiHgheexIwPMHybR
   OcuD0/0vgHsdTGksV9QzTi+gd2ZQWFfgHJBjCjSN4oL/QZA3WHfGnCqIz
   k5l/iXA5II8gqdV+scTza5tZT7D3JniQZYDsJOAj6FLE7PGg0mLn/VaFY
   n7QYO+AdRyBher/HvA1W28e65ripyEpYsBfmePtEQd2eB8NNdGGe5tnOx
   yeiYWEgdI9eM6nLUd9Vlj+8B4NEHvHlPVxIaCoRF3osc74q81EgurACOw
   Q==;
IronPort-SDR: eM/06ULGCldEpyhKxPqQqdAsZix0AjjC2Y3P5O+I+Y+qxDYacdBwZs3LutVsq1cGs/t4zKfcL/
 UMvlAfe4qycGtFXYIGQu5usTBOtWlrh+plQtKfyL/1CV1E6RaE9pyp5nTWF7FpwycvpxWKHSYJ
 nkyXOteL/RBw7cKpdtgf9+4bIZnNBxaBqttbAhjuTc441zTRvbfAeD1kQJHttJV/3fWVse2FLO
 EpBcPk4mfXoxzYYLPmFFA4N4jMrxdRxwEDVApp6RmcUPStgmSYg2ValieLrnxc0kf8QHcdg83R
 HSkBvvqyJMbAsZpEEk0LU4Bz
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="142638419"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:45 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] ARM: configs: at91: sama7: enable cpu idle
Date:   Thu, 16 Dec 2021 16:13:37 +0200
Message-ID: <20211216141338.35144-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
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

