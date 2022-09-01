Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B45A9938
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiIANlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiIANlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:41:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B54FF1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:40:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so9747324wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=stpnIznClyFbSSAZ9XIBAQVJVqGJPgWnuEIsfvw/Kgw=;
        b=SgocxATs9nG+dO5eC5Ry/p9RAchwAh7Dpb52+4CBAMfh5whV5zASWzF3gBuq1hnzwp
         M+7JtEjt88ret/I+CXbQ/8eC7JhJZZYpUMr9LIXHTG//b8nmupFzHkcA4LJTWam7pZbN
         QBEVv+DsJY1rMjqi9UwKNxes6DzYt2FsHkrUVjyhamtSGhaNqs25BKDjTXNKk09vaU3e
         5Yey/AIv9z1PeDrbwbxvkjhbGh/JUK1k7rdBskyuIVcMMC9wZb8GxUwSHKfubs+QiSld
         cv+od58WOfHDtJuJll+69LK2+7eNURITPegLYKastnotHmlVwhKrU1nx5L/e+r0bg/SB
         S5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=stpnIznClyFbSSAZ9XIBAQVJVqGJPgWnuEIsfvw/Kgw=;
        b=YmWqmK6L9zZOwwO/nK/nibfd02T6UtDP5Llv2v+v/xx83ZiJXgvlZD+PH8665y7Fy7
         caRrmES+J9ybWCquplERsH6duhX6pQye6FsnuDb3oYHvGIO58TLP9Bf2/6jeO6+0u06m
         jS9uyTU79djmd9Nj5g/3k42I1LDjR8SJevjMlO4ZBoOKlcj/PTH5pHCFqqT6AwM62z55
         lH1Npc4PNEhghmt3/CzX50wpO1RXY4n7R93DNqAL+ztqn0nUEelTqEdmMc8l7ZHnb7O8
         ta2efOyTm0lmwDuw+Yfxlq9xofX20xviMCjQ5QrL9Zc/iX9o+q2itXZhz9CMvlDKdx26
         +VHg==
X-Gm-Message-State: ACgBeo3gDX88s2cNzUFlJJIAq8QbpGviKLJmw4yUbG/I7fmXxXZ1zSQq
        Z+XIg4vSGf5sc9vnEW0Sn2uWGg==
X-Google-Smtp-Source: AA6agR63Bzb51JkQHDsQML106QA1SRbThkvFgEfcZxG1oTuPekWXu06XLjwe2W8lGlgpYHROZLAeqg==
X-Received: by 2002:adf:a702:0:b0:226:e205:fa56 with SMTP id c2-20020adfa702000000b00226e205fa56mr7815687wrd.637.1662039604363;
        Thu, 01 Sep 2022 06:40:04 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id e3-20020adfe383000000b0021ef34124ebsm15399016wrm.11.2022.09.01.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:40:03 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v3 2/4] thermal: mediatek: control buffer enablement tweaks
Date:   Thu,  1 Sep 2022 15:39:48 +0200
Message-Id: <20220901133950.115122-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901133950.115122-1-aouledameur@baylibre.com>
References: <20220901133950.115122-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Changes in V3:
- Use GENMASK() and BIT() instead of hardcoded data.
- Use u32 instead of int for "tmp" var in mtk_thermal_turn_on_buffer() 

 drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..b5b4401249e8 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 /*
@@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
-	int tmp;
+	u32 tmp;
+
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.37.3

