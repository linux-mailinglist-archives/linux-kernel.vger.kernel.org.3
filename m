Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A36484644
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiADQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:54:40 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:22284 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235576AbiADQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:54:38 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204ClwJU003136;
        Tue, 4 Jan 2022 10:54:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=wtR/S16kh0dxL/tCa9AfNyWpssNmTbifcATxl0gQQlc=;
 b=GzDe7k4VVF3v/L3HbBKRHcfQpgD3IDaDtmO4eCQuVEaQDdCTqdifKQDJx5BEl2vPPO4H
 Bl6wgntcaUAIO1i+DEW/aVcEkjsmMKZ4Cqin5jmpA+9gOEq60mqYcENSKHujQkPn9qts
 UBXZS+cO1Nr2INLqiC2I/7aLvbjRKqmzZCnz/W+GpVPAO5UB97uPImJi1WyucHKro0r/
 3O1efLkq6UlIK4NTyFsrkyXlrwnypX7qgbQNtJ6nQnEXAQGLlRUEevSddihA/uc2IgbS
 j8AmhrajgCh0iXCO72iNJjJ7Io8hC7IOBH7YLDnJ/SURZ8hkP0WczLvXnkivebElFWQ6 xQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dc1dx1806-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jan 2022 10:54:37 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 16:54:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 4 Jan 2022 16:54:35 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 93F49B10;
        Tue,  4 Jan 2022 16:54:35 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] mfd: arizona: Add missing statics to the of_match_tables
Date:   Tue, 4 Jan 2022 16:54:35 +0000
Message-ID: <20220104165435.26782-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: kdMjfku_IZ4ajNuc1c8moJp-hPQSK4uv
X-Proofpoint-ORIG-GUID: kdMjfku_IZ4ajNuc1c8moJp-hPQSK4uv
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the match tables were split for I2C and SPI a static should have
been added since the tables are no longer exported.

Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/arizona-i2c.c | 2 +-
 drivers/mfd/arizona-spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 3ed810e81f631..6d83e6b9a692d 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -105,7 +105,7 @@ static const struct i2c_device_id arizona_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, arizona_i2c_id);
 
 #ifdef CONFIG_OF
-const struct of_device_id arizona_i2c_of_match[] = {
+static const struct of_device_id arizona_i2c_of_match[] = {
 	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
 	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
 	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 9fe06dda37829..98c87d3bd00fa 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -226,7 +226,7 @@ static const struct spi_device_id arizona_spi_ids[] = {
 MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
 
 #ifdef CONFIG_OF
-const struct of_device_id arizona_spi_of_match[] = {
+static const struct of_device_id arizona_spi_of_match[] = {
 	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
 	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
 	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
-- 
2.11.0

