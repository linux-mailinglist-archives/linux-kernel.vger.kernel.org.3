Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A114CF3C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiCGIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiCGIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:36:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF0205E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:35:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so15937712pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=mNiCQomHe3AZpULgmNuzd/nevg4o0tLCGfPqsWacIDg=;
        b=kSq5RBX4GqueV2igKVHKCILxMbbWs7+3aAu+Vpq8k2nZErehVPHkMl7W3dmW4MpcGR
         kuA1JEdVxm1mqyxpKKZ/Z0PNvZ+h/nW5QLJUpuF9sepwi6TYVFwhMLi4cci1AmUk5NB8
         Ccu7E/UsHX7FYUx3/dr6/1w+f23vtFBZgC7u6PjZp40j2Lq6QD/r5C/gRndmIDtTrC0g
         Ds+LAeufJHywwhIgNDp2br/5ML3rm7unqaqsGu4hAWXe6c9ONh34KMKvrwyTTnx0Qr9b
         b3+7ekRl3eLkdnKqx/qU4XM8WlYTM0ju1/wX6FJHm7lgt/1tHSnskXKyQSfXUgmL2lol
         rPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mNiCQomHe3AZpULgmNuzd/nevg4o0tLCGfPqsWacIDg=;
        b=uKg3gpIg8EdP81Gdq1SRPI5GLhbUBPkNb5i3WYkTFIXXTLVYhHqZPY2rPMl8dGcK7E
         iPWqMA3bRuJgtEE7aBSQKjsqibpNGVojYR9TzyPVTzN+bx6nSR4mRtP5rl60Fi7CWUyx
         gOjbivlLl+Kf9AOWS+W+5KX4KVg8MzabrtkK9inVeSg4YyIZqbyyCwmuw/2WFFe2lnim
         G7sS/B6C8KwvUpg1bYNSw7co0JuQ86XpVTrwijvnJV+wVsqOifyp9BA8JjGtd6PlTREB
         JFjFWssU7/4uPjVOuSJEMiRq2ariSMf9Nr58OfMYdXS+M5bOGAAi7qSKJ+Cc2HO9WKYx
         Hj0A==
X-Gm-Message-State: AOAM53353xghX1hdL86Zqng6wrru8EAEhLWtLp/HgLJgl9e1f2pqHb8L
        0IbYQamhWAzsSJkg15c50vfaP9yINoQFGfBzfEjjGg==
X-Google-Smtp-Source: ABdhPJxOvB200XwC3KbSEeD9yNj4/yZaDfwprj85CYxXE7HWOzQrXXTiuZQc9KJCbRN0m7Ef8wgh/A==
X-Received: by 2002:a17:902:bb8f:b0:151:c488:cd24 with SMTP id m15-20020a170902bb8f00b00151c488cd24mr10673839pls.118.1646642158364;
        Mon, 07 Mar 2022 00:35:58 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm14562495pjo.0.2022.03.07.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:35:58 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun <jay.xu@rock-chips.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: rockchip: i2s: Fix missing clk_disable_unprepare() in rockchip_i2s_probe
Date:   Mon,  7 Mar 2022 08:35:52 +0000
Message-Id: <20220307083553.26009-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from rockchip_i2s_probe() in the error handling case.

Fixes: 01605ad12875 ("ASoC: rockchip-i2s: enable "hclk" for rockchip I2S controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index a6d7656c206e..4ce5d2579387 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -716,19 +716,23 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	i2s->mclk = devm_clk_get(&pdev->dev, "i2s_clk");
 	if (IS_ERR(i2s->mclk)) {
 		dev_err(&pdev->dev, "Can't retrieve i2s master clock\n");
-		return PTR_ERR(i2s->mclk);
+		ret = PTR_ERR(i2s->mclk);
+		goto err_clk;
 	}
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_clk;
+	}
 
 	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
 					    &rockchip_i2s_regmap_config);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev,
 			"Failed to initialise managed register map\n");
-		return PTR_ERR(i2s->regmap);
+		ret = PTR_ERR(i2s->regmap);
+		goto err_clk;
 	}
 
 	i2s->bclk_ratio = 64;
@@ -768,7 +772,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-
+err_clk:
+	clk_disable_unprepare(i2s->hclk);
 	return ret;
 }
 
-- 
2.17.1

