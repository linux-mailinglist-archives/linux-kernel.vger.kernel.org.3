Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A8A493764
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351851AbiASJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:33:42 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351218AbiASJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:33:37 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J3l3Vr008035;
        Wed, 19 Jan 2022 10:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TLpzstAMcWP5PV344Qh1JhgIkc8FofNAZU5SwUGE5QY=;
 b=4eV0x0OePdeTvlQLkxwGqU+Qt19W1Fs2867BWat/Bp+PsZtwC8GFguD92VaT9i/v2xCe
 aHAcm6NhmoRvLsaOXIpUQ5Nj7/mrWZ9c+lHVAwdkPT/Y1hVcgF0dWMFdY1WbXV0oqWLU
 m908jnwIeSfM59/VUKGPyzGS/C/Y1/siHzvd+OxwjJ7YgQkbbc+N6oNrRsLwUfgGZCjV
 kAOo+AP7W6bKsjyDIwmBcIAV08eefAdpxzd4M7x6h1ifc1o5IryHpAAwVXFPCGzUvGb/
 O9rPP4UTN6Xj/UegCw1Ar+ME3sfLELeIJTHjQkkBxKAPOB6+bjTFXo97zW8X5u3jh7Xa uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnsd0e3j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:33:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6EE4100034;
        Wed, 19 Jan 2022 10:33:14 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node5.st.com [10.75.127.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE28320ED10;
        Wed, 19 Jan 2022 10:33:14 +0100 (CET)
Received: from localhost (10.75.127.51) by GPXDAG2NODE5.st.com (10.75.127.69)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 19 Jan 2022 10:33:14
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 1/2] spi: stm32: remove inexistant variables in struct stm32_spi_cfg comment
Date:   Wed, 19 Jan 2022 10:32:44 +0100
Message-ID: <20220119093245.624878-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119093245.624878-1-alain.volmat@foss.st.com>
References: <20220119093245.624878-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To GPXDAG2NODE5.st.com
 (10.75.127.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'can_dma' and 'has_startbit' are described within the
struct stm32_spi_cfg comment but have never existed in this structure
so remove them.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9bd3fd1652f7..b5ef2470cefe 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -221,7 +221,6 @@ struct stm32_spi;
  * time between frames (if driver has this functionality)
  * @set_number_of_data: optional routine to configure registers to desired
  * number of data (if driver has this functionality)
- * @can_dma: routine to determine if the transfer is eligible for DMA use
  * @transfer_one_dma_start: routine to start transfer a single spi_transfer
  * using DMA
  * @dma_rx_cb: routine to call after DMA RX channel operation is complete
@@ -232,7 +231,6 @@ struct stm32_spi;
  * @baud_rate_div_min: minimum baud rate divisor
  * @baud_rate_div_max: maximum baud rate divisor
  * @has_fifo: boolean to know if fifo is used for driver
- * @has_startbit: boolean to know if start bit is used to start transfer
  */
 struct stm32_spi_cfg {
 	const struct stm32_spi_regspec *regs;
-- 
2.25.1

