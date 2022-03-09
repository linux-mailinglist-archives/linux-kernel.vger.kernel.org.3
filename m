Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19434D30E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiCIOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiCIOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:18:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB09D5DEE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835434; x=1678371434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVJ7AHr7Hy8X1n0xm5+ndnJwyGTqp6qNp+EnQciPRFI=;
  b=Ln759XVnowCQh4PIbl20m1jLuYIUaJRbKNb7kWpENVD4IdPgYiSyexQc
   kM86E9lBX8rWHOZkIMmAAuxZRHrNk7943wVzRUL/RNTGe40P4wPQk/TTr
   XX0H2YKncsBugsM47EAJvgTwog/GDfxQVbdeM+MVMBXpZ9mJXHFKkAf+u
   6R4wq0B8k3MjC7nxsbnIcp07SnUsJeSxKCvbxFTfwhoVUvtC7OX0lHgq+
   Cqnkp2fd9OkGqNaJgIKVp5C6d0f2QP/a0IdhKa/4xwo3oOKSCfsy/lWp4
   470v0Ezc4g0MMwBQ0wujO0Ad3tytqxaNvg5HVE4bcvM6DPEzD10KMOWue
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148620116"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:17:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:17:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:17:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/5] mtd: spi-nor: Update name and description of the set_4byte_addr_mode BFPT methods
Date:   Wed, 9 Mar 2022 16:16:59 +0200
Message-ID: <20220309141702.173879-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309141702.173879-1-tudor.ambarus@microchip.com>
References: <20220309141702.173879-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFPT defines some standard methods to enter and exit the 4-Byte Address
Mode. Use generic names for these methods and update their description.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c      |  2 +-
 drivers/mtd/spi-nor/macronix.c  |  3 ++-
 drivers/mtd/spi-nor/micron-st.c |  3 ++-
 drivers/mtd/spi-nor/sfdp.c      | 32 ++++++++++++++++++++------------
 drivers/mtd/spi-nor/sfdp.h      |  7 ++++---
 drivers/mtd/spi-nor/winbond.c   |  2 +-
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 452d0f91a8df..91d3754baa59 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2492,7 +2492,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
+	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..85e8655d362c 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -105,7 +105,8 @@ static const struct flash_info macronix_nor_parts[] = {
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode =
+		spi_nor_set_4byte_addr_mode_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c348419d24a0..4baa9dce04f9 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -410,7 +410,8 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode =
+		spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 108a74ce38e0..01e35354db3e 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -402,15 +402,20 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
 }
 
 /**
- * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
- * flashes.
+ * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
+ * SPINOR_OP_BRWR.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
+ * 8-bit volatile bank register used to define A[30:A24] bits. MSB (bit[7]) is
+ * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 4-byte
+ * address mode is active and A[30:24] bits are don’t care. Write instruction is
+ * SPINOR_OP_BRWR(17h) with 1 byte of data.
+ *
  * Return: 0 on success, -errno otherwise.
  */
-int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -434,14 +439,15 @@ int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * spi_nor_set_4byte_addr_mode() - Enter/Exit 4-byte address mode.
+ * spi_nor_set_4byte_addr_mode_en4b_ex4b() - Enter/Exit 4-byte address mode
+ * using SPINOR_OP_EN4B/SPINOR_OP_EX4B.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -465,15 +471,15 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
- * Micron flashes.
+ * spi_nor_set_4byte_addr_mode_wren_en4b_ex4b() - Set 4-byte address mode usingf
+ * SPINOR_OP_WREN followed by SPINOR_OP_EN4B or SPINOR_OP_EX4B.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -481,7 +487,7 @@ int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
 	if (ret)
 		return ret;
 
@@ -729,15 +735,17 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 
 	switch (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK) {
 	case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
-		params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 		break;
 
 	case BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B:
-		params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
+		params->set_4byte_addr_mode =
+			spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 		break;
 
 	case BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B:
-		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
+		params->set_4byte_addr_mode =
+			spi_nor_set_4byte_addr_mode_en4b_ex4b;
 		break;
 
 	default:
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index b56849079aea..da2d7ec2e0aa 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -107,9 +107,10 @@ struct sfdp_parameter_header {
 	u8		id_msb;
 };
 
-int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
+					       bool enable);
 int spi_nor_parse_sfdp(struct spi_nor *nor);
 
 #endif /* __LINUX_MTD_SFDP_H */
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 374ba82bff49..590e4d2c99d7 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -142,7 +142,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
 	if (ret || enable)
 		return ret;
 
-- 
2.25.1

