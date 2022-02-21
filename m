Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565014BE786
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357482AbiBUMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:11:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357334AbiBUMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:55 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE265A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:31 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DEB68223F7;
        Mon, 21 Feb 2022 13:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvCsGo+Zzlp+j51uBwOYnmVN4vdWTxdhsRo6HA993sA=;
        b=LpOB1ReoUrCk0mmGAX0blueyLKXzK8kSAlCwq3PJVZAmi6IEaTHLNRrZUlswB/Hd/94Jq0
        vs1+HtarerpGmO0lE8983CL9/CdJDcj8gZ+TxB+EYRkzB9HSCLr6L1c0Ay8k7pySAemycI
        jos+vtyfwZuJoYkSeKdDLnu8EkL6JC0=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 26/32] mtd: spi-nor: micron-st: rename vendor specific functions and defines
Date:   Mon, 21 Feb 2022 13:08:03 +0100
Message-Id: <20220221120809.1531502-27-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the generic spi_nor prefix for all the micron-st functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/micron-st.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f693f8720541..de450495e1ab 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -309,7 +309,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * spi_nor_read_fsr() - Read the Flag Status Register.
+ * micron_st_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
  *              Flag Status Register will be written. Should be at least 2
@@ -317,7 +317,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
+static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
 
@@ -353,10 +353,10 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 }
 
 /**
- * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * micron_st_nor_clear_fsr() - Clear the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  */
-static void spi_nor_clear_fsr(struct spi_nor *nor)
+static void micron_st_nor_clear_fsr(struct spi_nor *nor)
 {
 	int ret;
 
@@ -380,13 +380,13 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
- * ready for new commands.
+ * micron_st_nor_fsr_ready() - Query the Flag Status Register to see if the
+ * flash is ready for new commands.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_fsr_ready(struct spi_nor *nor)
+static int micron_st_nor_fsr_ready(struct spi_nor *nor)
 {
 	int sr_ready, ret;
 
@@ -394,7 +394,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 	if (sr_ready < 0)
 		return sr_ready;
 
-	ret = spi_nor_read_fsr(nor, nor->bouncebuf);
+	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
@@ -408,7 +408,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 			dev_err(nor->dev,
 				"Attempted to modify a protected sector.\n");
 
-		spi_nor_clear_fsr(nor);
+		micron_st_nor_clear_fsr(nor);
 
 		/*
 		 * WEL bit remains set to one when an erase or page program
@@ -437,7 +437,7 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = spi_nor_fsr_ready;
+		nor->params->ready = micron_st_nor_fsr_ready;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
-- 
2.30.2

