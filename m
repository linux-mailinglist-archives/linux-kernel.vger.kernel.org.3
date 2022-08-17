Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710185968D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiHQFoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiHQFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:43:53 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3427968D;
        Tue, 16 Aug 2022 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660715024; x=1692251024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBhc/EYjMes9Bbjmd/5giazoEua+gxSqcbH/4UOdMxs=;
  b=uiiuDA2h/I/QMSQ1hGccan0kup/Ojlkb5XFk4qo2ArxMpiATRziqh7yM
   cN4qVnBBkgPJNiZolm9+z4e6wyZ8GKaweynzeXJVfvJyOpjptbz6T/Szp
   77HyFkybs0llj1M/lpxvTkepo26je7HjeJ6omwRmqVwYurNzam4pR0zsY
   M=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654560000"; 
   d="scan'208";a="120059347"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-41c1ef8b.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:43:27 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-41c1ef8b.us-east-1.amazon.com (Postfix) with ESMTPS id 71914162679;
        Wed, 17 Aug 2022 05:43:25 +0000 (UTC)
Received: from EX13D08UEB001.ant.amazon.com (10.43.60.245) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB001.ant.amazon.com (10.43.60.245) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 17 Aug 2022 05:43:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 17 Aug 2022 05:43:22
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 9B3DC4CA7; Wed, 17 Aug 2022 05:43:21 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dwmw@amazon.co.uk>,
        <rtanwar@maxlinear.com>
Subject: [PATCH v2 15/16] hwmon: (mr75203) fix coding style space errors
Date:   Wed, 17 Aug 2022 05:43:20 +0000
Message-ID: <20220817054321.6519-16-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817054321.6519-1-farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
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

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index e54a4d1803e4..2898565afaab 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -174,7 +174,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		nbs &= SAMPLE_DATA_MSK;
@@ -219,7 +219,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		n &= SAMPLE_DATA_MSK;
@@ -322,19 +322,19 @@ static int pvt_init(struct pvt_device *pvt)
 
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
@@ -347,7 +347,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
 		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -360,7 +360,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
 			      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -374,39 +374,39 @@ static int pvt_init(struct pvt_device *pvt)
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
@@ -434,7 +434,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -447,7 +447,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -461,7 +461,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      IP_CTRL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -586,7 +586,7 @@ static int mr75203_probe(struct platform_device *pdev)
 	}
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
-	if(ret < 0)
+	if (ret < 0)
 		return ret;
 
 	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
-- 
2.37.1

