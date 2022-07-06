Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A304F569407
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiGFVNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiGFVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3E2717A;
        Wed,  6 Jul 2022 14:12:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so29188262ejb.6;
        Wed, 06 Jul 2022 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=we08VGkVJJS9erZ+xZEURv2knz+tCGYmdx4Fvbq08aw=;
        b=Bie/rkw0fZJCM4o17/trs/tRZNbAbnduk8j+HDM6c0Qw+dP+OKpnuZ5Tyd7+6aEyq8
         0/XE+WCynGervG526QuZBQk4yWg614mWBN24qSedFh8uj8OgHc+MZv8qBXXeStErrUXf
         5E2zG8d/sF/Su+y3ryO6B5wVLu8P/Q7WUKnDZ/wb9k+X3UhbjtN8q/G+kPTIiDyTJSjc
         CFcf7efQotPQ00EMa8lczD4xwtkIxD3iaQVWLWfM+GYc+M/bGJy6QAguxUnlB983R91M
         0FdVcsCk2mIFrfSJ6wOVJsKaauQDnSr2thEUXaWbCC+mH7ZcO7g+yFHMxoCypRPfoZL5
         qsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=we08VGkVJJS9erZ+xZEURv2knz+tCGYmdx4Fvbq08aw=;
        b=Ui485FJxRSbp0rE4rGU+1LuodVN4t6rmNXYzsUslBJWUcUDDkCtQnQjOweISgQ+Z55
         teH9KU5d6oD961smUK7KhzT39ZeplC2W7EzkpbUe0IL9QzE80OFSNH5i270Op0Nmycq0
         NJ+hm0LAe6wwdwh3GkfaTRxT8+UQWhkUqAUJxrHpBaN/BhOiVsGS97wx8H/slqsczCGj
         ZZ01JhZW2xVRwvtu8v8D/S2xFrQ77jvh4mJ6vxY+hy2kB5K+rpDUO/A1DEw1WD3lf20F
         Uh1SF+4+QIvLLsH5+YHGcz3M9vV8Njqi6h3JND89ekG/Kn0aZlON+aElufrFpO5KcqqH
         rzAg==
X-Gm-Message-State: AJIora8ZnfYc3XN7lvb0dGQoXDXCVwFjSPXQDD9aA8SM86CLSYbcq5P6
        ADtS+fmvISJgCy1tWykklas=
X-Google-Smtp-Source: AGRyM1uHBO2y9EEWc2OBKCoKBWs/OWH1CuCPvILePBbd1nLqVoWD4UCdzMYiiv872nfgNeZ9S3U0og==
X-Received: by 2002:a17:906:9756:b0:722:ec43:9252 with SMTP id o22-20020a170906975600b00722ec439252mr42473586ejy.299.1657141968933;
        Wed, 06 Jul 2022 14:12:48 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7dbd1000000b0043586bee560sm26103857edt.68.2022.07.06.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:48 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ASoC: jz4740-i2s: Remove some unused macros
Date:   Wed,  6 Jul 2022 22:13:26 +0100
Message-Id: <20220706211330.120198-8-aidanmacdonald.0x0@gmail.com>
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

These macros are unused and can be dropped; the information is now
encoded in regmap fields.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 3c3cf78bf848..b8d2723c5f90 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -35,8 +35,6 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_MASK (0xf << 12)
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_MASK (0xf <<  8)
 #define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
 #define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
 #define JZ_AIC_CONF_I2S BIT(4)
@@ -45,11 +43,6 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
-#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
-#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
-
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
@@ -73,12 +66,6 @@
 
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
-#define JZ_AIC_CLK_DIV_MASK 0xf
-#define I2SDIV_DV_SHIFT 0
-#define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
-#define I2SDIV_IDV_SHIFT 8
-#define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
-
 struct i2s_soc_info {
 	struct snd_soc_dai_driver *dai;
 
-- 
2.35.1

