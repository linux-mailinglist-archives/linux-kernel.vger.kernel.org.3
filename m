Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBD562CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiGAHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiGAHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:30:51 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC96B83D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:30:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VI-7jtq_1656660640;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VI-7jtq_1656660640)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 15:30:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: codecs: max98088: Clean up some inconsistent indenting
Date:   Fri,  1 Jul 2022 15:30:39 +0800
Message-Id: <20220701073039.64556-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was found by coccicheck:

sound/soc/codecs/max98088.c:1761 max98088_i2c_probe() warn: inconsistent indenting.

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/max98088.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 08e5c606ff27..5435a49604cf 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1745,18 +1745,18 @@ MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
 
 static int max98088_i2c_probe(struct i2c_client *i2c)
 {
-       struct max98088_priv *max98088;
-       int ret;
-       const struct i2c_device_id *id;
+	struct max98088_priv *max98088;
+	int ret;
+	const struct i2c_device_id *id;
 
-       max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
-			       GFP_KERNEL);
-       if (max98088 == NULL)
-               return -ENOMEM;
+	max98088 = devm_kzalloc(&i2c->dev, sizeof(struct max98088_priv),
+				GFP_KERNEL);
+	if (max98088 == NULL)
+		return -ENOMEM;
 
-       max98088->regmap = devm_regmap_init_i2c(i2c, &max98088_regmap);
-       if (IS_ERR(max98088->regmap))
-	       return PTR_ERR(max98088->regmap);
+	max98088->regmap = devm_regmap_init_i2c(i2c, &max98088_regmap);
+	if (IS_ERR(max98088->regmap))
+		return PTR_ERR(max98088->regmap);
 
 	max98088->mclk = devm_clk_get(&i2c->dev, "mclk");
 	if (IS_ERR(max98088->mclk))
@@ -1764,14 +1764,14 @@ static int max98088_i2c_probe(struct i2c_client *i2c)
 			return PTR_ERR(max98088->mclk);
 
 	id = i2c_match_id(max98088_i2c_id, i2c);
-       max98088->devtype = id->driver_data;
+	max98088->devtype = id->driver_data;
 
-       i2c_set_clientdata(i2c, max98088);
-       max98088->pdata = i2c->dev.platform_data;
+	i2c_set_clientdata(i2c, max98088);
+	max98088->pdata = i2c->dev.platform_data;
 
-       ret = devm_snd_soc_register_component(&i2c->dev,
-                       &soc_component_dev_max98088, &max98088_dai[0], 2);
-       return ret;
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_max98088,
+					      &max98088_dai[0], 2);
+	return ret;
 }
 
 #if defined(CONFIG_OF)
-- 
2.20.1.7.g153144c

