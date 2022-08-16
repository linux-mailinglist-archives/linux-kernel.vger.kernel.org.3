Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9E59576F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiHPKDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiHPKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:02:59 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A3108F1B;
        Tue, 16 Aug 2022 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660638503; x=1692174503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fji3MgPbCRHWZISMn5U/UtrDN4wjGdOvke3tjy+CBlE=;
  b=PwuE044Sazuzsg/LHQ4crVQos+eVopzx8NUH4WF3lUFxUYtsJrIM2Hhs
   h6+3MHoOp5OS6LmCsFU2Pee+QaoIrKkb5KHy8wQQch8yGYrUBQL2auk5F
   mnYoPDsS8usoKQO7lobQATsFtiSIwitHsGx+aOCKrRN1+92mp/+QQDn0b
   g=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654560000"; 
   d="scan'208";a="230105363"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-26daedd8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 08:28:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-26daedd8.us-east-1.amazon.com (Postfix) with ESMTPS id 9953D82C1A;
        Tue, 16 Aug 2022 08:28:18 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 16 Aug 2022 08:27:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 16 Aug 2022 08:27:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 16 Aug 2022 08:27:58
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 57A304ADB; Tue, 16 Aug 2022 08:27:57 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH 15/16] hwmon: (mr75203) fix coding style space errors
Date:   Tue, 16 Aug 2022 08:27:56 +0000
Message-ID: <20220816082757.11990-16-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816082757.11990-1-farbere@amazon.com>
References: <20220816082757.11990-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: "ERROR: space required before the open parenthesis '('"

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 79831a0d5dca..2777feca1c11 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -172,7 +172,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		nbs &= SAMPLE_DATA_MSK;
@@ -217,7 +217,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		n &= SAMPLE_DATA_MSK;
@@ -320,19 +320,19 @@ static int pvt_init(struct pvt_device *pvt)
 
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
@@ -345,7 +345,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
 		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -358,7 +358,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
 			      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -372,39 +372,39 @@ static int pvt_init(struct pvt_device *pvt)
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
@@ -432,7 +432,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -445,7 +445,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -459,7 +459,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      IP_CTRL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -584,7 +584,7 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
-	if(ret < 0)
+	if (ret < 0)
 		return ret;
 
 	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
-- 
2.37.1

