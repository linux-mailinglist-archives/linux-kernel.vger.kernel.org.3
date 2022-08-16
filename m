Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FB59609A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHPQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiHPQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:52:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8312F7C315
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:52:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so5801539wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DCMW1NXMabz4d7Mt9akRmoqhQw6B70MamDwewtnPONg=;
        b=V6A6g0GVs5szfnz9eYHa8aWujK31+oD1w5CpP91pD2Dg4rVd8rdW3jyBo4gQ1PLEfx
         D0bwtTNo2Xw8x6Rww+vExhisQwkqq8AU2GVMBZDyJlpyIsvl5oCGmmfXpLzhFPXLARdO
         KYfjbUCnozsb9yXwR6fObT81/f9PECJmvIt81fn/u5Zmx3kC69RhMrxmK/FkWCUqC6vr
         VabNqwaVo05eznTVl67h5kc+xOmzuITZsHXzqJeU7WFp4wNUb08p/PE2ME5BdQwYK3g0
         530enDnxTssbmOr0DIuUqrWy6TcKbFu5SVNNWTjJ8J22nR0poXwqIaHZg17gQ1kIyC8M
         7dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DCMW1NXMabz4d7Mt9akRmoqhQw6B70MamDwewtnPONg=;
        b=H1gOZ6gp3Jhk3i0NNJ6maMYaOXP/eS5g6B9fXP/m+MNnlarpjZmqQZg6Z/Yu5/XpN0
         GiuoJfpWykYYPvcfwGRurAxGjAEx5Kj5kEfoT2izlGY6g4IGfPziL75+gDuA55vnj8Tx
         I67WnoJLFbES+IaytsriTC9gll/K0TQM/X2W6f285ye+Fzpw80YCFD9Su1UtdcIJMPN+
         K0DY2b487to6whI2tEBb4k33860RXDQgPcithcCjHMGqZgV5qNFkRzkpKUbrpnJ68JcA
         Vt6hSTsbozf4qxFdgNdSUr8WkbGsiGGMZksdDWoHwGJU5E3THTP5wp9KK4Jy1kRHTbFY
         xbCQ==
X-Gm-Message-State: ACgBeo3g344CHaABzz/u7S3U3r1Yh3Cj2A/8HkTB+2rp5xpzy1AOMKnM
        8AYZH3nbB/TeOwqwku0RZy38fw==
X-Google-Smtp-Source: AA6agR4nlB/t63qkFK4MGf1n9FcJ+A0CvhVhjfGi1x+17RqPXfU5eUnRpAHO9e5OZS2IYBrt3YUZjQ==
X-Received: by 2002:a05:600c:198e:b0:3a5:d4a2:8896 with SMTP id t14-20020a05600c198e00b003a5d4a28896mr11652760wmq.140.1660668752783;
        Tue, 16 Aug 2022 09:52:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id j1-20020a056000124100b00220592005edsm10536525wrx.85.2022.08.16.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:52:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: sm8250: add missing module owner
Date:   Tue, 16 Aug 2022 17:52:29 +0100
Message-Id: <20220816165229.7971-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing module owner to able to build and load this driver as module.

Fixes: aa2e2785545a ("ASoC: qcom: sm8250: add sound card qrb5165-rb5 support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index ce4a5713386a..98a2fde9e004 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -270,6 +270,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
+	card->owner = THIS_MODULE;
 	/* Allocate the private data */
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
2.21.0

