Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0444C1490
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbiBWNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiBWNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9BAD11C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:19 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1E3AB2244F;
        Wed, 23 Feb 2022 14:44:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUHjRq3B/3JjsHlcHc+UiOV+3YaaqpA1vvTF3QO9238=;
        b=bXuicVX0rflHWdGKwarIkjI7YKGuzPnD7dB6J08XHkeAXhjmkejR/EMsHRv2PfYOpFgVOv
        QKjD7eC+ZgjKthxFJSPJffNH3w2987D47kO9HQBHC3skrTUbh70b9U5rGSaM/AGNIdxz6b
        XhdkQTqJnir0q3XeGYCgB1IgZEf/+uU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 32/32] mtd: spi-nor: renumber flags
Date:   Wed, 23 Feb 2022 14:43:58 +0100
Message-Id: <20220223134358.1914798-33-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have deleted some flag, lets renumber them so there are no holes.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2130a96e2044..b7fd760e3b47 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -12,20 +12,20 @@
 #define SPI_NOR_MAX_ID_LEN	6
 
 enum spi_nor_option_flags {
-	SNOR_F_HAS_SR_TB	= BIT(1),
-	SNOR_F_NO_OP_CHIP_ERASE	= BIT(2),
-	SNOR_F_BROKEN_RESET	= BIT(5),
-	SNOR_F_4B_OPCODES	= BIT(6),
-	SNOR_F_HAS_4BAIT	= BIT(7),
-	SNOR_F_HAS_LOCK		= BIT(8),
-	SNOR_F_HAS_16BIT_SR	= BIT(9),
-	SNOR_F_NO_READ_CR	= BIT(10),
-	SNOR_F_HAS_SR_TB_BIT6	= BIT(11),
-	SNOR_F_HAS_4BIT_BP      = BIT(12),
-	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
-	SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
-	SNOR_F_SOFT_RESET	= BIT(15),
-	SNOR_F_SWP_IS_VOLATILE	= BIT(16),
+	SNOR_F_HAS_SR_TB	= BIT(0),
+	SNOR_F_NO_OP_CHIP_ERASE	= BIT(1),
+	SNOR_F_BROKEN_RESET	= BIT(2),
+	SNOR_F_4B_OPCODES	= BIT(3),
+	SNOR_F_HAS_4BAIT	= BIT(4),
+	SNOR_F_HAS_LOCK		= BIT(5),
+	SNOR_F_HAS_16BIT_SR	= BIT(6),
+	SNOR_F_NO_READ_CR	= BIT(7),
+	SNOR_F_HAS_SR_TB_BIT6	= BIT(8),
+	SNOR_F_HAS_4BIT_BP      = BIT(9),
+	SNOR_F_HAS_SR_BP3_BIT6  = BIT(10),
+	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
+	SNOR_F_SOFT_RESET	= BIT(12),
+	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 };
 
 struct spi_nor_read_command {
-- 
2.30.2

