Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D5521EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbiEJPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbiEJPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:37:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444EC289A6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so2315376pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgBcNoHF+H5YHWhoRdIUmpBDPDoFkHi2u+F0mxHHboU=;
        b=SqlnRkOBavZUfRbJwMbK/YH4lJboO/H6W9MGbF1Yr8P3VdOycLTYi6X8sxipFmctzz
         Sip8xnN1tVt+E+KB3GObsdE4JlFanBX/u27osIqtF0PSPAJ1XR1F6QACv6LQIc4U/dyr
         7jwaKmTINGJsQxtoXTY7xQt+ULsVPni3miKhV6QEWS8GpL0apIdYLDp4iizJ0IwJcrGO
         Z1kAXxv/Gg20ZCFB5DSXa7QGkB1NNF9jcxOpv2NgM7kfpcR3+mRvB6jQKpjcoKhg0ZzR
         AlHth8RnP5dD7DJ7f9MwHjTrZuGMgQcr4lFnA96B7sJJvi+GRlZtDzbImfHt7wyaFTvi
         z+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgBcNoHF+H5YHWhoRdIUmpBDPDoFkHi2u+F0mxHHboU=;
        b=z380iZvzNUW5D4tkT4ceaPATwOHx1wIi1EQcxYd1ZR08SQ85czW+yDx5chBr8+2jHq
         U4Ug7sCctW98Gm0T2aDjUad1VOq2Dtnwn/d1smApBVj4lFaNSJ4V52sePYxJuycWi6S/
         v4EeexGWj/2f6D96jWNsy+iRgQcdY3jl0LBCdTPmITfzOQJ8TQJ5fvSz0RNbl4xcwPf1
         fuvNF909lVSt0Yk/RbShtlh6We3u5e/YSIwTE6dy5lzda6S7rkfITMgGV2jTA5kvVNgN
         nhESsz7v/cui6+RL0xsX3JstFlZ7dazziIpa2fDrOSvhrjzxdvyHgFcYdmZcBLd3EPY2
         pu/w==
X-Gm-Message-State: AOAM532U53md7rtGlk+hfNuC8NqjiXrDIwSW+WmoLUwIR5O7M/5iF6Io
        F2JzRnyrlJ6b7YhVRLh4GA==
X-Google-Smtp-Source: ABdhPJxIg+lFFBXwy/xu/9dN8ld18Dmoa8zxjI0DMkcnvYRYOp5IZmTm31F5Gz51fbFrsofGjLfMyA==
X-Received: by 2002:a17:90b:4a90:b0:1dc:aec3:c04 with SMTP id lp16-20020a17090b4a9000b001dcaec30c04mr546709pjb.118.1652196798797;
        Tue, 10 May 2022 08:33:18 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:18 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 1/6] ASoC: cs42l52: Fix the error handling of cs42l56_i2c_probe()
Date:   Tue, 10 May 2022 23:32:46 +0800
Message-Id: <20220510153251.1741210-2-zheyuma97@gmail.com>
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

The driver should goto label 'err_enable' when failing at regmap_read().

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/cs42l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 2c4e09b43199..dc23007336c5 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1245,7 +1245,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client)
 	ret = regmap_read(cs42l56->regmap, CS42L56_CHIP_ID_1, &reg);
 	if (ret) {
 		dev_err(&i2c_client->dev, "Failed to read chip ID: %d\n", ret);
-		return ret;
+		goto err_enable;
 	}
 
 	devid = reg & CS42L56_CHIP_ID_MASK;
-- 
2.25.1

