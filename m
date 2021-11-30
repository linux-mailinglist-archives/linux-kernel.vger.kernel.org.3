Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61D462C65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhK3F7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:59:41 -0500
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com ([40.107.102.84]:56384
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238403AbhK3F7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:59:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeDowvvwOdd/Pqw7JyMsH8JEqdX+cC+vtyYvXcYpGErPahhrBpBxrHgdvpPJlQ8scZmcBtXsPlRF+d1DW6nXuaEWKxf88F/MPg/B3TrFLy/KWZDxKyAE05wNQLdoQZXSWdkdaKJYZzBhy5YyRy2xy0tE+XMazPDXqyOBV6/iXHs+aBIQX47Ltt9rB/sHqljub3sQBHPUhUBfkZ8geoH2ALZsJ4VUP4TXWh+6SNBiV9A9C+QO9zL2OqdqDurIpQskdqXg6ljsufYvA+aXrkP4zwvnEVZiLsS3iS49czqGWi+B/zqQcAFsC5J6uOgA5AA5Def6wFfxz2HGUsoD8OZdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=925sDxT8AMlGoWlpBeRoH1c8uMdyH5Ium4w9RSGFDvs=;
 b=hMulSAyFmrsWT+obeokkhhySoFm3aBhP5aVJz6b9hJqWx4CltUBbk6Zcyg6NgvNGVzNO7s5rCBQp5QexqFryNjChG/py7uiwpXZbd5wWtAESbQEsjY6xSLT6jbpTCM/SncfxRakcvWsXL3NEmtJCuKQUiANqlGzC2UtrcYwmarehafuKByd/F9q1HySgHQHBdJ+sP2NxsGPQi0MDoX4BffQgCbZI3Y4di71448QvK/1j9/2OAQP7m11txj5f/K9qMPE0mA2m8KPGIOYMo9Il+RvsOPucrFaFpvN9LtyzIjAblrJpAD9XO39Nnv/M0yaJJzyy7ObrH2Pa5YjOoNPihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=925sDxT8AMlGoWlpBeRoH1c8uMdyH5Ium4w9RSGFDvs=;
 b=HWBD50jhNKPo4QHURVdePqTAbJKsGOR/QV37XyOM81clDt+hKlb5MbtB4x+d90qQyhvP+nQYKRRMbms9f2+czchRt2UecT7RNEONdfYUMj45iSBG/nMTOre9WEkDdfhkIBzgemixXf49nCjaHu3ULdMCErZRWR9BmfPt83WDSz0=
Received: from SN7PR04CA0050.namprd04.prod.outlook.com (2603:10b6:806:120::25)
 by SJ0PR02MB8675.namprd02.prod.outlook.com (2603:10b6:a03:3ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 05:56:19 +0000
Received: from SN1NAM02FT0062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::4f) by SN7PR04CA0050.outlook.office365.com
 (2603:10b6:806:120::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 05:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0062.mail.protection.outlook.com (10.97.4.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 05:56:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 29 Nov 2021 21:56:10 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 29 Nov 2021 21:56:10 -0800
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57772 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1mrw7d-0005MM-Pc; Mon, 29 Nov 2021 21:56:10 -0800
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <radheys@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V3 2/2] rtc: zynqmp: Add calibration set and get support
Date:   Tue, 30 Nov 2021 11:25:41 +0530
Message-ID: <20211130055541.2789-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
References: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1355d9e7-6186-40e1-e231-08d9b3c62122
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8675:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8675921CE03E1B8FE4E54BB9AF679@SJ0PR02MB8675.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08os37MHqIketBrr8vZeOt7D06SbtfmkaPIKoInLiPQODJ1ES6BGiySgvKSvcSJ96UYLcWwOIuqy6FMTP0UjvD2U/ABuMIDsOb6I6MnV7Kve2g9Ml9ugjzUyYg2LPqmzqkzf43WMC08G3AA2Ndfc3fKtwIy+JlFb0M3nG+bNln9NCNc50/1RF5yKEDGkeuvpLmUtagllzlPXAToRN411YaJ/HIiME9r1qSLKVXTzJvHiqufIV3aEXWxBmRqScEPulWVL1H/3Uwcua50uiA/7uAUgl/5QJaPYJ+ZCAWiOv5RpsYUx1lRSYdpI9vnm28vVheVNF19/X5K7rPC/Wqa6OuwFx20pEAMX3lESlkNKnwDj+ec3enGE0ex8geV/vvDc8aZmj06qQsQva6dKcNV+5hirR0umxhHAcVcLBQck8yr9V8TAtmZY24Spk6Np/a/s+AsiggjqYaiJsrdH+FWVzv4uCc/PjvJqAdxnB5yX6wZ8GldNUd6ih5smgL5gaHzbO3Be72Q98PXT0Gl54R9ndSxkjbKNfYNUGL16lT746nmnRKALQAt/gdfjzrmaJKbY30PliLc5W81/eUkrOTvL2KzFOlTruCG3+Y3fMpllpWwygUpSoR4UhG5244m7IiLoh5mvz9fLN1VsyCuuwkMySaueZ+UqK/kscJbw2a1FOeq/lXPhrZiUPHJ5eiU5ww5qnKfBe9xaXmr6j35YBuAM8Z80CpWWs0RNQCXRNEBRBLFBB7QDyg193fCl1c4QAUqH
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(47076005)(7636003)(426003)(83380400001)(107886003)(36756003)(8936002)(7696005)(44832011)(8676002)(356005)(9786002)(70586007)(5660300002)(4326008)(26005)(2906002)(508600001)(6636002)(316002)(186003)(82310400004)(1076003)(6666004)(110136005)(336012)(36860700001)(2616005)(54906003)(70206006)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 05:56:18.9666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1355d9e7-6186-40e1-e231-08d9b3c62122
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8675
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zynqmp RTC controller has a calibration feature to compensate
time deviation due to input clock inaccuracy.
Set and get calibration API's are used for setting and getting
calibration value from the controller calibration register.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
Changes in V3:
 -Calculated tick_mult using crystal frequency.
 -Calibration register updating based on crystal frequency in probe.
 -Supressed MIN an MAX calibration values,Will send separate patch in future.
Changes in V2:
 -Removed unused macro.
 -Updated code with review comments.
---
 drivers/rtc/rtc-zynqmp.c | 104 +++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index f440bb52be92..eb6ee55ca725 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -36,17 +37,21 @@
 #define RTC_OSC_EN		BIT(24)
 #define RTC_BATT_EN		BIT(31)
 
-#define RTC_CALIB_DEF		0x198233
+#define RTC_CALIB_DEF		0x8000
 #define RTC_CALIB_MASK		0x1FFFFF
 #define RTC_ALRM_MASK          BIT(1)
 #define RTC_MSEC               1000
+#define RTC_FR_MASK		0xF0000
+#define RTC_FR_MAX_TICKS	16
+#define RTC_PPB			1000000000LL
 
 struct xlnx_rtc_dev {
 	struct rtc_device	*rtc;
 	void __iomem		*reg_base;
 	int			alarm_irq;
 	int			sec_irq;
-	unsigned int		calibval;
+	struct clk		*rtc_clk;
+	unsigned int		freq;
 };
 
 static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -61,13 +66,6 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 */
 	new_time = rtc_tm_to_time64(tm) + 1;
 
-	/*
-	 * Writing into calibration register will clear the Tick Counter and
-	 * force the next second to be signaled exactly in 1 second period
-	 */
-	xrtcdev->calibval &= RTC_CALIB_MASK;
-	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
-
 	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
 
 	/*
@@ -173,15 +171,71 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
 	rtc_ctrl |= RTC_BATT_EN;
 	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
+}
 
-	/*
-	 * Based on crystal freq of 33.330 KHz
-	 * set the seconds counter and enable, set fractions counter
-	 * to default value suggested as per design spec
-	 * to correct RTC delay in frequency over period of time.
+static int xlnx_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
+	long offset_val = 0;
+	unsigned int tick_mult = RTC_PPB / xrtcdev->freq;
+	unsigned int calibval;
+
+	calibval = readl(xrtcdev->reg_base + RTC_CALIB_RD);
+	/* Offset with seconds ticks */
+	offset_val = calibval & RTC_TICK_MASK;
+	offset_val = offset_val - RTC_CALIB_DEF;
+	offset_val = offset_val * tick_mult;
+
+	/* Offset with fractional ticks */
+	if (calibval & RTC_FR_EN)
+		offset_val += ((calibval & RTC_FR_MASK) >> RTC_FR_DATSHIFT)
+			* (tick_mult / RTC_FR_MAX_TICKS);
+	*offset = offset_val;
+
+	return 0;
+}
+
+static int xlnx_rtc_set_offset(struct device *dev, long offset)
+{
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
+	short int  max_tick;
+	unsigned char fract_tick = 0;
+	unsigned int calibval;
+	int fract_offset;
+	unsigned int tick_mult = RTC_PPB / xrtcdev->freq;
+
+	/* Number ticks for given offset */
+	max_tick = div_s64_rem(offset, tick_mult, &fract_offset);
+
+	/* Number fractional ticks for given offset */
+	if (fract_offset) {
+		if (fract_offset < 0) {
+			fract_offset = fract_offset + tick_mult;
+			max_tick--;
+		}
+		if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
+			for (fract_tick = 1; fract_tick < 16; fract_tick++) {
+				if (fract_offset <=
+				    (fract_tick *
+				     (tick_mult / RTC_FR_MAX_TICKS)))
+					break;
+			}
+		}
+	}
+
+	/* Zynqmp RTC uses second and fractional tick
+	 * counters for compensation
 	 */
-	xrtcdev->calibval &= RTC_CALIB_MASK;
-	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+	calibval = max_tick + RTC_CALIB_DEF;
+
+	if (fract_tick)
+		calibval |= RTC_FR_EN;
+
+	calibval |= (fract_tick << RTC_FR_DATSHIFT);
+
+	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+
+	return 0;
 }
 
 static const struct rtc_class_ops xlnx_rtc_ops = {
@@ -190,6 +244,8 @@ static const struct rtc_class_ops xlnx_rtc_ops = {
 	.read_alarm	  = xlnx_rtc_read_alarm,
 	.set_alarm	  = xlnx_rtc_set_alarm,
 	.alarm_irq_enable = xlnx_rtc_alarm_irq_enable,
+	.read_offset	  = xlnx_rtc_read_offset,
+	.set_offset	  = xlnx_rtc_set_offset,
 };
 
 static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
@@ -255,10 +311,18 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "calibration",
-				   &xrtcdev->calibval);
-	if (ret)
-		xrtcdev->calibval = RTC_CALIB_DEF;
+	/* Getting the rtc_clk info */
+	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc_clk");
+	if (IS_ERR(xrtcdev->rtc_clk)) {
+		if (PTR_ERR(xrtcdev->rtc_clk) != -EPROBE_DEFER)
+			dev_warn(&pdev->dev, "Device clock not found.\n");
+	}
+	xrtcdev->freq = clk_get_rate(xrtcdev->rtc_clk);
+	if (!xrtcdev->freq)
+		xrtcdev->freq = RTC_CALIB_DEF;
+	ret = readl(xrtcdev->reg_base + RTC_CALIB_RD);
+	if (!ret)
+		writel(xrtcdev->freq, (xrtcdev->reg_base + RTC_CALIB_WR));
 
 	xlnx_init_rtc(xrtcdev);
 
-- 
2.17.1

