Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF45B229A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiIHPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:40:46 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99F5E55AF;
        Thu,  8 Sep 2022 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662651646; x=1694187646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NTmqcmI3f0K4euiAJHs5XDqksDJcpuWM3XsZ9qd3SIU=;
  b=Yabcvmuzg4bYDi4dM7BZphBea7nYOaCD/SYG5K4tu2h1m5o8gvFIpon1
   2kCzAujKt2nLBSYWdmYT3CLaffTDdUQ9Lof3wNBap1T2CMws+crodUQaB
   SBXWqESwAJW4uXgXLWq92Hpu+iLixzZQWE2+KhNJmHgGA6WtNegINgxMb
   g=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="128019423"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com (Postfix) with ESMTPS id C2B55C090B;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:51 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 7BF0A4D84; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 21/21] hwmon: (mr75203) fix coding style space errors
Date:   Thu, 8 Sep 2022 15:24:49 +0000
Message-ID: <20220908152449.35457-22-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: "ERROR: space required before the open parenthesis '('"

All of the errors were introduced before this series of patches.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
V5 -> V4:
- 0021: Move this patch to be last in the series (it does not fix the code),
  and remove the "Fixes:" tag.

 drivers/hwmon/mr75203.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index e6b49f810307..0fea443dc3e1 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -290,7 +290,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		nbs &= SAMPLE_DATA_MSK;
@@ -331,7 +331,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		n &= SAMPLE_DATA_MSK;
@@ -437,19 +437,19 @@ static int pvt_init(struct pvt_device *pvt)
 
 	if (t_num) {
 		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(t_map, SDIF_HALT, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(t_map, CLK_SYNTH, clk_synth);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(t_map, SDIF_DISABLE, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -462,7 +462,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
 		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -475,7 +475,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
 			      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -489,39 +489,39 @@ static int pvt_init(struct pvt_device *pvt)
 		      IP_CTRL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
 	if (p_num) {
 		ret = regmap_write(p_map, SDIF_HALT, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(p_map, SDIF_DISABLE, BIT(p_num) - 1);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(p_map, CLK_SYNTH, clk_synth);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
 	if (v_num) {
 		ret = regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(v_map, SDIF_HALT, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(v_map, CLK_SYNTH, clk_synth);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_write(v_map, SDIF_DISABLE, 0x0);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -548,7 +548,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -561,7 +561,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -575,7 +575,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      IP_CTRL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -832,7 +832,7 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
-	if(ret < 0)
+	if (ret < 0)
 		return ret;
 
 	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
-- 
2.37.1

