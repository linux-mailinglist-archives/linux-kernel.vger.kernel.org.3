Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7202E588E66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiHCORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbiHCORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:17:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95DB863;
        Wed,  3 Aug 2022 07:17:31 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27398q1a000827;
        Wed, 3 Aug 2022 16:17:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=gzklWwUpe4hcnf+G9HdQnLHm5xwgT1JwzAwRZjqCTuY=;
 b=7NzmMvP7Fqmifd1D3Vo8qH+6NHGb0Z5MHbFnO0ubBQ8ipiyLG2KUtLQDUNzMaE118cy7
 OaGWcGiio6B83+w50rd4l3ysauOM4PrUU2Nn4P/JkNDvE7+NYncJFdPwlxjQD7Gns248
 mIOK1W8FHhaMOAia2yTFr6pxiN6sJYx/imhjsxkpaNv4qjeEZ7Z2TIzYT0+IRu/m0CWF
 dCZBN+B3P9uhfzD/gG3lM7gpWSk+0Rb/GQLkBji/aRHov7OethlsCn5Qj9J2at78k1W+
 oMYckbMWPhEsaHtT8VuUtlXdpMiS1ZtDmbiJL5/qChdQzpUQ7dhJBeU7IGUMW73+SIeA Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hq2b01bq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 16:17:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 159B110002A;
        Wed,  3 Aug 2022 16:17:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EDDB2248CC;
        Wed,  3 Aug 2022 16:17:02 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 3 Aug
 2022 16:17:01 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 2/3] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
Date:   Wed, 3 Aug 2022 16:16:56 +0200
Message-ID: <20220803141657.301793-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803141657.301793-1-patrice.chotard@foss.st.com>
References: <20220803141657.301793-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Remove "struct stm32_qspi *qspi" from parameter list of
stm32_qspi_get_mode() as this parameter is unused.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 94356781e75b..622d1442a9b7 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -348,7 +348,7 @@ static int stm32_qspi_wait_poll_status(struct stm32_qspi *qspi)
 	return 0;
 }
 
-static int stm32_qspi_get_mode(struct stm32_qspi *qspi, u8 buswidth)
+static int stm32_qspi_get_mode(u8 buswidth)
 {
 	if (buswidth == 4)
 		return CCR_BUSWIDTH_4;
@@ -381,11 +381,11 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	ccr = qspi->fmode;
 	ccr |= FIELD_PREP(CCR_INST_MASK, op->cmd.opcode);
 	ccr |= FIELD_PREP(CCR_IMODE_MASK,
-			  stm32_qspi_get_mode(qspi, op->cmd.buswidth));
+			  stm32_qspi_get_mode(op->cmd.buswidth));
 
 	if (op->addr.nbytes) {
 		ccr |= FIELD_PREP(CCR_ADMODE_MASK,
-				  stm32_qspi_get_mode(qspi, op->addr.buswidth));
+				  stm32_qspi_get_mode(op->addr.buswidth));
 		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
 	}
 
@@ -395,7 +395,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	if (op->data.nbytes) {
 		ccr |= FIELD_PREP(CCR_DMODE_MASK,
-				  stm32_qspi_get_mode(qspi, op->data.buswidth));
+				  stm32_qspi_get_mode(op->data.buswidth));
 	}
 
 	writel_relaxed(ccr, qspi->io_base + QSPI_CCR);
-- 
2.25.1

