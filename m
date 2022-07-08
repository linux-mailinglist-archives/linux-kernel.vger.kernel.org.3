Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5156B79A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiGHKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbiGHKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8014804BD;
        Fri,  8 Jul 2022 03:42:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk26so14902311wrb.11;
        Fri, 08 Jul 2022 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97AxfpAWfhGkMoo8Yg3C7zAZZuUe0uLsnJoPG2mxaas=;
        b=D3ZqkStiVqS1hpFUXN+Wn7xde+SrRbgMqFYHp9m84rBcCoFpVRErZ7FTSWo6QmhEfs
         iUIw4mNtWhbZq3oR6B7DLLtoV4dE8C9OY7loi4b6l0v7DS0ADogsaiDw5e8U65uyohuX
         GuS722qAgbrLriIsfBFN9zY1IRv3x4TyJd2e0BfjfANuGLEmBc2rgBmH3qhmdq6jZczF
         roKN/fWIhQChEH9F+em6ntDLh3sDBrD1mTEliIPUFVX5uiLK8DF2Cg8GwFEqw0+n5GIr
         PrDCyPhdohe+kWU7JrTLRm/p8boM6a3Yxzg9XAiZnhDZvz23vK8P5XAQDkgBnKoa/3pw
         nsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97AxfpAWfhGkMoo8Yg3C7zAZZuUe0uLsnJoPG2mxaas=;
        b=EDgXmR8F1sBFR9IStzoVDtRHmV8L/ZYynmfxCvjF+cgLuQZYhxg5p1jJ/F9H5lYCo1
         H0aYAvvN/AR8flkHrDGfSDSb1FlD6BSeaJ9LtCaTzssABg62/bzAf21JqtvhBdY+8LsR
         Lc8xiQl/pIxKs6NqFxe7iGF/11598X6WMWfrMlTr1Lu2cls1CFxL3tJw8YW5d8MSqw/x
         gzBqsY00ofOQrTubZKRxSxGI2xImhOPu5r25Nhfy0srsdDeUYj8W2DJS5cyYCjUdkByJ
         sbkSMv79qHeDXcqTF1Q7vnB1RHb4iGAYWDYwb2w/V54XLILCyc/oPlOdLALtRXWlZJSf
         tv7A==
X-Gm-Message-State: AJIora9Ap0FYVY1bL4FeJ7e85eHStd4u0A9xFYwBymmUBRMHd0UpS1Vx
        x/BxR8CW7Zrx1ur1at8RYls=
X-Google-Smtp-Source: AGRyM1sfrmeT0XJgKKmzik5j2KlsclcdcdrBzjOdT40yzmtjkPg1p4xMWlPQjqIPDk7NPHDPfgS5eQ==
X-Received: by 2002:adf:fe81:0:b0:21a:3574:ec8e with SMTP id l1-20020adffe81000000b0021a3574ec8emr2659325wrr.410.1657276949273;
        Fri, 08 Jul 2022 03:42:29 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b00210352bf36fsm39253005wrx.33.2022.07.08.03.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] ASoC: jz4740-i2s: Align macro values and sort includes
Date:   Fri,  8 Jul 2022 11:42:59 +0100
Message-Id: <20220708104304.51415-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some purely cosmetic changes: line up all the macro values to
make things easier to read and sort the includes alphabetically.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 72 +++++++++++++++++------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index d0791dfa9c7b..0dcc658b3784 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -13,11 +16,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/clk.h>
-#include <linux/delay.h>
-
-#include <linux/dma-mapping.h>
-
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -35,39 +33,39 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
-#define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
-#define JZ_AIC_CONF_I2S BIT(4)
-#define JZ_AIC_CONF_RESET BIT(3)
-#define JZ_AIC_CONF_BIT_CLK_MASTER BIT(2)
-#define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
-#define JZ_AIC_CONF_ENABLE BIT(0)
-
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
-#define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
-#define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
-#define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
-#define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
-#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
+#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST	BIT(6)
+#define JZ_AIC_CONF_INTERNAL_CODEC	BIT(5)
+#define JZ_AIC_CONF_I2S			BIT(4)
+#define JZ_AIC_CONF_RESET		BIT(3)
+#define JZ_AIC_CONF_BIT_CLK_MASTER	BIT(2)
+#define JZ_AIC_CONF_SYNC_CLK_MASTER	BIT(1)
+#define JZ_AIC_CONF_ENABLE		BIT(0)
+
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE	GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE	GENMASK(18, 16)
+#define JZ_AIC_CTRL_ENABLE_RX_DMA	BIT(15)
+#define JZ_AIC_CTRL_ENABLE_TX_DMA	BIT(14)
+#define JZ_AIC_CTRL_MONO_TO_STEREO	BIT(11)
+#define JZ_AIC_CTRL_SWITCH_ENDIANNESS	BIT(10)
+#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED	BIT(9)
 #define JZ_AIC_CTRL_FLUSH		BIT(8)
-#define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
-#define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
-#define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
-#define JZ_AIC_CTRL_ENABLE_TFS_INT BIT(3)
-#define JZ_AIC_CTRL_ENABLE_LOOPBACK BIT(2)
-#define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
-#define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
-
-#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
-#define JZ4760_AIC_CTRL_RFLUSH BIT(7)
-
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
-#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
-#define JZ_AIC_I2S_FMT_MSB BIT(0)
-
-#define JZ_AIC_I2S_STATUS_BUSY BIT(2)
+#define JZ_AIC_CTRL_ENABLE_ROR_INT	BIT(6)
+#define JZ_AIC_CTRL_ENABLE_TUR_INT	BIT(5)
+#define JZ_AIC_CTRL_ENABLE_RFS_INT	BIT(4)
+#define JZ_AIC_CTRL_ENABLE_TFS_INT	BIT(3)
+#define JZ_AIC_CTRL_ENABLE_LOOPBACK	BIT(2)
+#define JZ_AIC_CTRL_ENABLE_PLAYBACK	BIT(1)
+#define JZ_AIC_CTRL_ENABLE_CAPTURE	BIT(0)
+
+#define JZ4760_AIC_CTRL_TFLUSH		BIT(8)
+#define JZ4760_AIC_CTRL_RFLUSH		BIT(7)
+
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK	BIT(12)
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK	BIT(13)
+#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK	BIT(4)
+#define JZ_AIC_I2S_FMT_MSB		BIT(0)
+
+#define JZ_AIC_I2S_STATUS_BUSY		BIT(2)
 
 struct i2s_soc_info {
 	struct snd_soc_dai_driver *dai;
-- 
2.35.1

