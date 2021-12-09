Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07946EBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbhLIPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:43:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50932 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhLIPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639064272; x=1670600272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UpT28YC0KrF9kWVQLXAsbKKLKjYyf/we8UP/MINHjgA=;
  b=WRpY9y2ZizzUNK+D6no1beKLOcxK2LuvC52QfPhsfVrrgcBTspDCxR30
   9AvvkApxSlwZ5Ik/DCM+rticAB/QzPqjPSjmQ2ExBo93vgzauTHozwrFT
   siit1oU+wjMJ2g7RoRCY99zBGojmR3Q4768PmGQHGAEQVbPaqwmG74hoJ
   9vxL1DDMh8yohiWm4nTgPF0DhYdVz6h/plEB4Zl0JZyrdJI7e4jb2zTdA
   XMrTQesjudqR+UMSUXDhn2PodqeURWF9YPmJI87mkyeQ2MxAQaQ01HAWY
   yG71j3LiMw87toCSZ2wPaOKclKd1wVmlfw5RETUiQ/bqYxfvfo3SV0/02
   Q==;
IronPort-SDR: la1EJyslJEKmOiI12nKpcPdCLYqGttvS3Lh3X9Bx2cSYlJRqaEELeEejK2qU5Usz6pP6xMFWo4
 KP7qBzFNkhm8v3KsJxDgIoxskYNATDteRVOwR2RSGMgEgoT9fMyamyw+yqYkxcJgVBRgWr5zk9
 mRxB6JKXfVfVWSoiqU9/09yg6DeD7cxFctsuq7mcu78KexjsvzU+WVoSi/ITgZWFI8QUWZJUX0
 kDO3/UzEH/cQaN+5FBBOC5RBqlgYV3qOiQge96V2Ex91+ew+E3G+n8QGDoN1/NkoDD1W2Neeow
 lHY0RYTNPumiR8WEhU/PLDLj
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="146102046"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 08:37:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 08:37:50 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 08:37:47 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <linux@armlinux.org.uk>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama7: Enable SPI NOR and QSPI controller
Date:   Thu, 9 Dec 2021 17:37:44 +0200
Message-ID: <20211209153744.357465-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209153744.357465-1-tudor.ambarus@microchip.com>
References: <20211209153744.357465-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama7g5ek comes with a SPI NOR flash connected to the QSPI
controller. Enable the SPI NOR subsystem and the QSPI controller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 938aae4bd80b..0368068e04d9 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -33,7 +33,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_COREDUMP is not set
@@ -83,6 +82,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
@@ -90,6 +90,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
 CONFIG_MACB=y
 CONFIG_MICREL_PHY=y
@@ -104,8 +105,8 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AT91=y
 CONFIG_SPI=y
-CONFIG_SPI_MEM=y
 CONFIG_SPI_ATMEL=y
+CONFIG_SPI_ATMEL_QUADSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_PINCTRL_AT91=y
 CONFIG_PINCTRL_AT91PIO4=y
-- 
2.25.1

