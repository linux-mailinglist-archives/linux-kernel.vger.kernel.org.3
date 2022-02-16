Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9D4B89C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiBPNZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:25:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiBPNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:25:41 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DC12779;
        Wed, 16 Feb 2022 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645017929; x=1676553929;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Nxttcr31p2W61Gm3SX8vHvFy59FlP2h71nyWJI7l0ak=;
  b=Q3jmITkcMWC+vMnkK+I+xceHDqHx3vgGi6HM0jTCU7G3cRwS2r7h5ku2
   9cS3RHVsKoEHWVfKdGeUrqGpZeZrrYBhlW8+0+BQCQDFlHI6AwaHLVPjR
   XUF6Z0kNbd0sxr3VJoZRqdsYkeGzKf8uo5vhx1vUXbx4gU7sF582LAbZy
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 05:25:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 05:25:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 05:25:26 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 05:25:20 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH] ASoC: codec: wcd938x: Update CTIA/OMTP switch control
Date:   Wed, 16 Feb 2022 18:54:52 +0530
Message-ID: <1645017892-12522-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert gpio api's to gpio descriptor api's in CTIA/OMTP switch control.
Remove redundant NULL checks in swap_gnd_mic function.

Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 sound/soc/codecs/wcd938x.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 08d16a9..88a39e1 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -6,6 +6,7 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
@@ -194,7 +195,7 @@ struct wcd938x_priv {
 	int ear_rx_path;
 	int variant;
 	int reset_gpio;
-	int us_euro_gpio;
+	struct gpio_desc *us_euro_gpio;
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
@@ -4203,22 +4204,11 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
 
 	struct wcd938x_priv *wcd938x;
 
-	if (!component) {
-		dev_err(component->dev, "%s component is NULL\n", __func__);
-		return false;
-	}
-
 	wcd938x = snd_soc_component_get_drvdata(component);
-	if (!wcd938x) {
-		dev_err(component->dev, "%s private data is NULL\n", __func__);
-		return false;
-	}
 
-	value = gpio_get_value(wcd938x->us_euro_gpio);
+	value = gpiod_get_value(wcd938x->us_euro_gpio);
 
-	gpio_set_value(wcd938x->us_euro_gpio, !value);
-	/* 20us sleep required after changing the gpio state*/
-	usleep_range(20, 30);
+	gpiod_set_value(wcd938x->us_euro_gpio, !value);
 
 	return true;
 }
@@ -4236,16 +4226,15 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return wcd938x->reset_gpio;
 	}
 
-	wcd938x->us_euro_gpio = of_get_named_gpio(dev->of_node, "us-euro-gpios", 0);
-	if (wcd938x->us_euro_gpio < 0) {
-		dev_err(dev, "Failed to get us-euro-gpios gpio: err = %d\n", wcd938x->us_euro_gpio);
-	} else {
-		cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
-		gpio_direction_output(wcd938x->us_euro_gpio, 0);
-		/* 20us sleep required after pulling the reset gpio to LOW */
-		usleep_range(20, 30);
+	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(wcd938x->us_euro_gpio)) {
+		dev_err(dev, "us-euro swap Control GPIO not found\n");
+		return PTR_ERR(wcd938x->us_euro_gpio);
 	}
 
+	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
+
 	wcd938x->supplies[0].supply = "vdd-rxtx";
 	wcd938x->supplies[1].supply = "vdd-io";
 	wcd938x->supplies[2].supply = "vdd-buck";
-- 
2.7.4

