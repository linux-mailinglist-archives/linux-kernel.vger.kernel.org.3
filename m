Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587795AE336
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiIFIke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbiIFIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:39:19 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5777561;
        Tue,  6 Sep 2022 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453450; x=1693989450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7046ePXxVTAnqr0mWyv8v1NYuKAEnOXw9RXG6LdSpxY=;
  b=nYOwho2gUNeAbz9OLzwbghps0f8MrK+EqiqcTabs2ZcsFvWLXu2kt7Ae
   TWh/f2PDu5HHy/kI1Ef2f6AD90JvV+dkuqxpYQKXqZGYxJQViLN300H5z
   O+zLYcfeAKDe77nRN78/oQN2p9fFcQfEEmaezsXKUKg3F52pjil+X+G0B
   g=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="127050133"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id 3386BC08D2;
        Tue,  6 Sep 2022 08:34:37 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:59 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id CC5E94D84; Tue,  6 Sep 2022 08:33:56 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 01/21] hwmon: (mr75203) fix coding style space errors
Date:   Tue, 6 Sep 2022 08:33:36 +0000
Message-ID: <20220906083356.21067-2-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
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

Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/hwmon/mr75203.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 046523d47c29..8adfbb15453f 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -155,7 +155,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		nbs &= SAMPLE_DATA_MSK;
@@ -197,7 +197,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return ret;
 
 		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		n &= SAMPLE_DATA_MSK;
@@ -291,19 +291,19 @@ static int pvt_init(struct pvt_device *pvt)
 
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
@@ -316,7 +316,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
 		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -329,7 +329,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
 			      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(t_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
@@ -343,39 +343,39 @@ static int pvt_init(struct pvt_device *pvt)
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
@@ -389,7 +389,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -402,7 +402,7 @@ static int pvt_init(struct pvt_device *pvt)
 		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 
 		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
@@ -416,7 +416,7 @@ static int pvt_init(struct pvt_device *pvt)
 		      IP_CTRL << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
 		ret = regmap_write(v_map, SDIF_W, val);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -535,7 +535,7 @@ static int mr75203_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
 
 	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
-	if(ret < 0)
+	if (ret < 0)
 		return ret;
 
 	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
-- 
2.37.1

