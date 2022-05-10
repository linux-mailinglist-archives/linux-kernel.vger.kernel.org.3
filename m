Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674AB521EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbiEJPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbiEJPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:38:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B41F8C64
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso2360254pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E2oYMHtBAv9GRmZnfohgrg/949ahcguOuaoSrbKbFI=;
        b=RDmrB2J1ZPEIKprdrdCO4avF6oVrb5+pne/vzaqtN87noNp1Bli0oHQ6wyNpTU5vI1
         0SMhWzqr/HweH8BysNB5VTufUNTaKfODRGH5FgOUYQ1X4JaIF/BwdanaQDrV2rglyxPt
         gIewzpg+83SMO+qXQynhd74vUUH+dm9cIht1XWcryYKFAbDvU8Uilwfs2axnl1zXzElJ
         NXAYgg1A06xTdfzeiA3A8G57Mz1A8mJIf/qsKD98jkERgTPWi9bW4xtie1blxVu3ulTS
         9zMUXo4w1IAjkCcy0283xKmVQIlCE5QKfr5XSqXAddvBxly0Fow8UPJhqaWohu3WG3Qs
         30Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E2oYMHtBAv9GRmZnfohgrg/949ahcguOuaoSrbKbFI=;
        b=ZSYfG7EAqzh/cu9K6ud4fziFp8lJM7OxLW1d2vB5F/3ulmM91ieK/6CsWbXdO5zxGI
         R6BEvxGkZBUBT7ySJEGgsPWmNMTQXlcuWIldIrxfjtgVdFrAM6BqRSkETosvDgKVzbWw
         UwPudO0M8otwCSttPysZuu8GAVMOPEvzUoThrAuqhaXQesW5fP74twqg/NlJY/jIxqqz
         BK5XoAUxlMfTrQIqpnuivmhgb0LN6NfCbfn4V+7z2+DN0aiG7xfps1NOtZCCrpWGE+If
         Xv5nFBPUrUMewQAl7+bK63TgA8/SOFLOGu/BJ3u3ZUESQp5Jm0KDcE1CLaA+YadbmbDL
         eTQQ==
X-Gm-Message-State: AOAM531WMq7gcVpLQRDDg98MiXXGrvLO2jfuOh9rPhiveGpXZd9dzJpk
        dJLe8zwk2UML55f1R/cN7g==
X-Google-Smtp-Source: ABdhPJy9vXUe8rOvHkj/a1GsFzkDy1LxLZuiQxGOh9KaM/XcRQNRmQ/qpQDd7DGC190YEyfTcsaVTA==
X-Received: by 2002:a17:90b:4f41:b0:1de:bd14:7721 with SMTP id pj1-20020a17090b4f4100b001debd147721mr149484pjb.9.1652196838221;
        Tue, 10 May 2022 08:33:58 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:57 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 6/6] ASoC: wm8903: Fix the error handling of wm8903_i2c_probe()
Date:   Tue, 10 May 2022 23:32:51 +0800
Message-Id: <20220510153251.1741210-7-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510153251.1741210-1-zheyuma97@gmail.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
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

The driver should goto label 'err' when failing to request the irq.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/wm8903.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ddcef11dce7c..3c95c2aea515 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2131,7 +2131,7 @@ static int wm8903_i2c_probe(struct i2c_client *i2c)
 		if (ret != 0) {
 			dev_err(wm8903->dev, "Failed to request IRQ: %d\n",
 				ret);
-			return ret;
+			goto err;
 		}
 
 		/* Enable write sequencer interrupts */
-- 
2.25.1

