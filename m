Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0007C493765
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbiASJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:33:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235918AbiASJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:33:37 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J3l3fW008034;
        Wed, 19 Jan 2022 10:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=+ehtLtX70tce80lzBmhHxiTVMfeIYIulAFgG6k5Hb1Y=;
 b=Bd2rZYNTXDa3wfl79ZYAhTWvOwrZNIlvzImgiAU6ZHTZKcLxA4pECjMdBhJjTf+bQieC
 rqJY73L487mZKjnNUXAGHGssDEMR391eSQajKdX+7Wif9DsesnU9OmKdXhRJfZS1++Mb
 dbBrjr2RzdOce095s6sXyE4oMkWBJOPI8RQjFUXTiJUDdPrr4Z6BuSxQooK/7aU7mVAK
 7jWuU5wB55YdCIYLDCpk5NCSsO+61td+dluozbEbEuYy9EhV8nQ5yNo3MUr1uUaO7fpM
 9hYk3wSNWpQa8PTRIo6TGLdFyjsLCw6OcPwXUeIbFjb4Gf+9tz6oBox3z+6zpsiQS7Xm hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnsd0e3j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:33:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78A9310002A;
        Wed, 19 Jan 2022 10:33:14 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node5.st.com [10.75.127.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70E3220ED10;
        Wed, 19 Jan 2022 10:33:14 +0100 (CET)
Received: from localhost (10.75.127.48) by GPXDAG2NODE5.st.com (10.75.127.69)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 19 Jan 2022 10:33:13
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 0/2] spi: stm32: comments & SIMPLEX_RX fixes
Date:   Wed, 19 Jan 2022 10:32:43 +0100
Message-ID: <20220119093245.624878-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To GPXDAG2NODE5.st.com
 (10.75.127.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 2 fixes within the spi-stm32.c driver.  One is
removing comments regarding struct variables that do not exist and the
second one correct a previous STM32F4 related commit for SIMPLEX_RX which
happens to break SIMPLEX_RX for H7 since it enforces MUST_TX flags.

Alain Volmat (2):
  spi: stm32: remove inexistant variables in struct stm32_spi_cfg
    comment
  spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4

 drivers/spi/spi-stm32.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

