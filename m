Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805D046EBE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbhLIPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:42:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26565 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhLIPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639064268; x=1670600268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UpT28YC0KrF9kWVQLXAsbKKLKjYyf/we8UP/MINHjgA=;
  b=dtIsZz2NRNgijeN22J00gImLEnRCEYwj32AEW84MCqD8ql0IU1iT+RqP
   7IibIh1aSErjTZtMwKHxpOSY2CCWUD9Lr1U3Zj2/2SrbP01E/zeyLwfyG
   rnRrxzcKtSTpdIQXvqZ1uGyeDvzqWRREJ1fdXD1Q+IwpsPx3Wg12cwU6e
   SYTSxHfxJU+aI3pvs0VMJ8Z7YFbGrCdYYQhWsiNLrK9xSrn1tGeL2+VWC
   twBtvX80PLXOgeqa6SHiu1RBUmezDI8kYHGLgBEE3c3ncVTI6Yjz9Tsqx
   TB+5G2jknibrDinoY4PkhMzA82ER30hwqrwLf5yuHOHcZiYS/y/67VoRr
   A==;
IronPort-SDR: 6lnTbjpIXVQXb8V/zrp1D7usz7Csa0bWPfE9HbIa2LmaQBpbSrEYOMuDkSN+Th2aNdnnFDFrvs
 eJEu/9GPyZYpJkBkpk7U0/TI8ZAnqVw++yt+RCRZhP12GPpNzmwttJPrzoL3JNJKbq1MLNArZL
 V0SDeUWqjeZIMzlQQqhPuR2Uv5KEAt/P/g9chyAOiZK5AXiOd87UOi/2byqWUkwU6GHpeuSddy
 aMZoq8vdcw7RwB1pM227RpY/qThXWGE2KepJIzQxhBX0u5AY5gfl+Sg7HLXp+erLKfS3728ZGM
 gJKgTNfLpwlzlxx2VD7h9W7D
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154886806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 08:37:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 08:37:47 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 08:37:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <linux@armlinux.org.uk>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama7: Enable SPI NOR and QSPI controller
Date:   Thu, 9 Dec 2021 17:37:43 +0200
Message-ID: <20211209153744.357465-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
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

