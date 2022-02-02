Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFE4A6C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiBBHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:02:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44961 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiBBHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643785369; x=1675321369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qM2szEr4iwIMDuYBKDIcOf6vZ5wmYPS1pXc5cwARPHk=;
  b=qODIniYKIN2wc8Nw34ig2ZIStbuV/xhfsWMk5fDScbSkvr4UxHjpEERG
   0ReThgtCtTPp6KZndsseUV3JiQmCqcEGQ/atHNZbAOfjckt8FlL/fjjqj
   04O7ftcPWRPfI8uHy7dBNVUKmzjerlGigPzFbTnQ3QHo87OMafjDTvAt1
   WLWF7rd03JD0bsOkWdfpJ+az3y4EyFOzqJDiNFo7pI+hbdlQjKzIXQ9hQ
   odStr2QnmTK7Btq9OMOAyW994d/505hKMjl9dZYN0Ts3XHA4BBX4mY4E2
   RNoZY+ejyJaiAFJ+ZqRul1DiM+hshJM2ukBZeZi//GFtk0fjHYdEVFWZl
   A==;
IronPort-SDR: GuV5vXbw28Sc92CaDw1xxo/7kp2sMx6JQM68Y3wrxZHeTausrt0SbC9lmZZgH5C/iMPQzcgFu0
 oCDVs52mZrae09njlWaIKyycszWX8nmmN2T6AXSzOWq0tZc0frOr0+h4UrDJdzX5eROiw05E2v
 jKJTV20sL3UvE/7vFYmMSPcBTaCNOOtCQfmD+u7oqs7ODooG7nhy1n3/k5FPkKdVosODoOL3fg
 KvZenwfn6aF2ORJssCM6GTMlwXWsB7q/IN2q53YAt4F42q/x54rSuU8bSRfjfKbixwqRWJ2hI4
 vCudAbC+XC8PBI3hrtOhNS2G
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="144624961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2022 00:02:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 2 Feb 2022 00:02:48 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 2 Feb 2022 00:02:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama7: Enable UBIFS_FS
Date:   Wed, 2 Feb 2022 09:02:44 +0200
Message-ID: <20220202070244.150022-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama7g5 contains a Static Memory Controller that can communicate with
NAND flashes. Enable UBIFS_FS in case one wants to put an ubifs rootfs
on a NAND flash. CONFIG_CRYPTO_LZO and CONFIG_CRYPTO_DEFLATE appear as
removed because they are selected by CONFIG_UBIFS_FS.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 342d9f30d9d2..c12278174579 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -86,6 +86,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
 CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
@@ -187,6 +188,7 @@ CONFIG_EXT3_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
@@ -194,8 +196,6 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_LSM="N"
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_ITU_T=y
-- 
2.25.1

