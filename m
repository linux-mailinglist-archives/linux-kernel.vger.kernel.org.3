Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDD4D6B70
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiCLA0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCLA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:26:06 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF48930A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:25:01 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so6226111pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pyncn/uVxB66BCY7x3SIh/kgQlmj4ZSWJds3wQzq3I4=;
        b=mJ+3x6VVmBDGt9svMNU3c2pcW9D5V3ir9bCVeO30pI0nvR7IrUFZ9jsGJAHJ289UZR
         W49rMzoQSA/SvCW8bbJqD2V3NugBbe+JI5UqNMErJDbpOsZl9Gwn8LNTMVk7yYwYH0V/
         TxUgXfjKWR7w8YrH7mVvf1AsTSL8wM7aUZ8865ZrxcH55E5TBNMMCIwhO+tTz1H8v3QA
         MfEZQ1wkMSArrDugBkQIABPFSG7ApJFki8iOwgJ2lYyNe/jRGov7/9vKNghXoZFEIgRs
         YQl7s2JU/g1Pe9D/XgEp88rZI5NBJ5qirSY7/vPPeXMope0H5vSuyJXYTbRqOMMJaCTP
         BiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pyncn/uVxB66BCY7x3SIh/kgQlmj4ZSWJds3wQzq3I4=;
        b=NSvZAGNVEkAAbEMJEvb5vjCiY5Mb2eN/AdVfYYe+H9o+xEMpDuvZLbuNjoLa/WlBCn
         juj1bBmKNcIfxaAvBOWKEYJdPHLwd4U+Kywd867vzncRDG8v5vBNiXKtil8TH4Mu+YNe
         YJFE1n1IdiidrKRntlCxKA5VVsUKfPhlbcymYnW8GCX4yn8JpAw9l/JzygmGUfYgaeQ/
         atUzbDf1uh+3VDSd1YuvO573zljBit8CSMer9GRCOY003cGAZw0CdvsLqADk8tHaiK8R
         7UoyBP/zEx/jBXg3RgLhYXDnD2NAY4XNwhb2kf/WqWLFTTVPPDlp+ipYtz4X+182PwrC
         0o+A==
X-Gm-Message-State: AOAM532sNffKjHRRlbJesE58DDcoBWW2VAPFkzw/F85jQwZBFV2G0EfX
        bPJzq40MkisSMqYJ/UtyPOg=
X-Google-Smtp-Source: ABdhPJy7jWE6Md6pE8pvBgnIfPc7YYjI1QJZMcnZ13NcS6fw/v7htifKwzVzPLu/bkle6WXYqdZZug==
X-Received: by 2002:a17:90b:4f8c:b0:1bf:3ef:d668 with SMTP id qe12-20020a17090b4f8c00b001bf03efd668mr13122156pjb.219.1647044700923;
        Fri, 11 Mar 2022 16:25:00 -0800 (PST)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f2a4316a0asm11325696pfv.60.2022.03.11.16.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:25:00 -0800 (PST)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, jack.yu@realtek.com, nuno.sa@analog.com,
        ryans.lee@maximintegrated.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Steve Lee <steve.lee.analog@gmail.com>
Subject: [RESEND V2] ASoC: max98390: Add reset gpio control
Date:   Sat, 12 Mar 2022 09:24:29 +0900
Message-Id: <20220312002429.16175-1-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Add reset gpio control to support RESET PIN connected to gpio.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
 sound/soc/codecs/max98390.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 40fd6f363f35..9a9299e5cc5a 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 
 	struct max98390_priv *max98390 = NULL;
 	struct i2c_adapter *adapter = i2c->adapter;
+	struct gpio_desc *reset_gpio;
 
 	ret = i2c_check_functionality(adapter,
 		I2C_FUNC_SMBUS_BYTE
@@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
+					     "maxim,reset-gpios", GPIOD_OUT_LOW);
+
+	/* Power on device */
+	if (reset_gpio) {
+		usleep_range(1000, 2000);
+		/* bring out of reset */
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98390->regmap,
 		MAX98390_R24FF_REV_ID, &reg);
-- 
2.17.1

