Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDC569406
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGFVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiGFVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A05FD3;
        Wed,  6 Jul 2022 14:12:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so7435411edc.4;
        Wed, 06 Jul 2022 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHRKwDMoPqGsmLDhEylrCYQasRxJDmsT4CqEKEyjAlE=;
        b=O7h259vepu/QVKHCbTGHl8v7N2k851FtJ1GRdrD4ta7iplL6yxvNebNDjGUPGZ7J85
         FDHdxt2gSrq2cOJ/+olkLxWUQ/nxck/pYQkQZnirpMSFJmCzxmFBXYdnDaNnhxb9JBKu
         ucB8y2H1QSFkHVlgNKrZ+xQg5y38LGPlqHDQHk388wIW6tyQKg6iRslrH19G9o+6UU63
         4zW8BFf6yWJ99yC4XpFHxXeA4KgnWW2u1IBf5kb1OnEgbeA+EIWLW5rKYvjaH1PV/PLQ
         HpivP5tivPUt615obpxrdlMvkMak9Qiop89Xah1ZW1Ar7gArAPanIJqRzBu4kJ4yvGJW
         oczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHRKwDMoPqGsmLDhEylrCYQasRxJDmsT4CqEKEyjAlE=;
        b=Yo4FSpWu2aAu0qKTsVyoOtfuvH8U3BZndgmZEZbuaZoi2ipN+1FDA1qNSa4pESil4H
         tBfcGhG71kVY0m1bZvD8n0VLWhhj07FIhhBensYKwZa3KsCJgFTgFbXbrrT3qiVDRQk9
         vjp1yHJnhThKV0cHizL0ar8nWiIS8B6SPPBm7iciJKkAeYB3lae0cnIiYwQIgFohOYaH
         T3XYiEkUCb4DTR2rvoJxSO6FnFEbRKv7QlDcz8B+J2z6PC6tXgb2wBNj9Qa4ioJKi/e+
         UpQuoybZ7QkSwt2tRF30alOIIGwTKB1zPpCSownnnFEcBm15Rakt3lJVh0oB/NK1ZUO8
         jyMQ==
X-Gm-Message-State: AJIora9ZDi9Ro4HJHZUky6Nta3C0MxyCGNgDFL0a46gA7kibM6hKW705
        4r5paoehNAEgLeQR+NRXxzY=
X-Google-Smtp-Source: AGRyM1s2f1EL28m5rxI1eGs6Sm3yWkuXRIXnOVcUfsNcnMg/sRoZmWN0UAqqKHxooyUmcQafNusmxg==
X-Received: by 2002:aa7:d5d7:0:b0:43a:6eda:464a with SMTP id d23-20020aa7d5d7000000b0043a6eda464amr20410276eds.193.1657141965487;
        Wed, 06 Jul 2022 14:12:45 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402020d00b0043a71775903sm6131364edv.39.2022.07.06.14.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:44 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ASoC: jz4740-i2s: Remove unused SoC version IDs
Date:   Wed,  6 Jul 2022 22:13:24 +0100
Message-Id: <20220706211330.120198-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using version IDs makes the code hard to follow -- it's better to
describe the functional differences between SoCs instead. Remove
the IDs since they're no longer used.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index cbb89f724f64..8bb9449d13d3 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -81,15 +81,7 @@
 #define I2SDIV_IDV_SHIFT 8
 #define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
 
-enum jz47xx_i2s_version {
-	JZ_I2S_JZ4740,
-	JZ_I2S_JZ4760,
-	JZ_I2S_JZ4770,
-	JZ_I2S_JZ4780,
-};
-
 struct i2s_soc_info {
-	enum jz47xx_i2s_version version;
 	struct snd_soc_dai_driver *dai;
 
 	struct reg_field field_rx_fifo_thresh;
@@ -406,7 +398,6 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4740_i2s_soc_info = {
-	.version = JZ_I2S_JZ4740,
 	.dai = &jz4740_i2s_dai,
 	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
@@ -415,7 +406,6 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-	.version = JZ_I2S_JZ4760,
 	.dai = &jz4740_i2s_dai,
 	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
@@ -442,7 +432,6 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4770_i2s_soc_info = {
-	.version = JZ_I2S_JZ4770,
 	.dai = &jz4770_i2s_dai,
 	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
@@ -451,7 +440,6 @@ static const struct i2s_soc_info jz4770_i2s_soc_info = {
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
-	.version = JZ_I2S_JZ4780,
 	.dai = &jz4770_i2s_dai,
 	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
-- 
2.35.1

