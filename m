Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58E4D0DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbiCHBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbiCHBx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:53:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA72AFF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:52:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso887959pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=58lwskYug/llHkpIrMRW+dy3O3RN+GbIpdAcgfBEttk=;
        b=HSCYAeLoHcpnnM2uKaIA5lifN/t97U2w1M5ioRJjGdZ++5Thz9qLLXuH5q/V+ioCpJ
         B7idQN5/gHfstOY+ov8+wbbGw2JRhsWSbIXivdKSDdTjBQMdQSKSpbhMs47dVwah6oPX
         Cdw95MMMXeJfH+NbYVToxnzsV4ATd/bMKUbC+mBicPFKU5UwSVTZB6u2IkCPHWFW4ezg
         EiUVoRYJ3oIqF1DqnUZ4HSXwSPgLTtVK+2I/P9IWNrr5wEok0ATlQItCDJ/rHikjkIi/
         3sITJfYrTlT+L13h6lvijlT1xW0UsPl4LoL+AEbFNMRYi8Llyj74Jat8B395qAzctYcr
         Fstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=58lwskYug/llHkpIrMRW+dy3O3RN+GbIpdAcgfBEttk=;
        b=0hsyDYpSnu+bGhG0tPAcydAHIFe9PjaeTMRED08Apxq27AMaZ5XlbWHyCoJpKTWhRl
         XpdZKi14JELBf4wM6Cy9ISCtJAqZkmRO5mCNtfdNRYCmjjzjuW47LkuQVwIf6eeN5qJH
         3zV2kPjfF67rxB2cCY2dvPZc8gjBaNRnJqWVKDOz2ENeKfRpAw8R1M3N03qltlxezTIt
         Lqj8gS9ZzZUvBDoji5Aea6DWVmTXUODUSykbG/ajjnKerSu5Qtx/Fu/KRGkeIE/MSdkK
         vvo6YFj3Bgqs6x97o1GdbL+z4WREbBjSHi0HX9WwM5T6riV1+joOh2sfCSzEs0cZROoV
         1elg==
X-Gm-Message-State: AOAM531zM+//GOIGF/kuGCNXKv5nM6+oZS3dWqZWWDjG5hqLWACZmh1O
        C9nYy6VVXeeoqrv7y+qj9O0=
X-Google-Smtp-Source: ABdhPJz6lbpi9VHXqUtR/ZCOi8FTsWcSS1kfqtODKavlvexuo70DQjYtfjWCTLdBrNr2bb1jMtcHAg==
X-Received: by 2002:a17:90b:4b0b:b0:1bf:764c:1bc1 with SMTP id lx11-20020a17090b4b0b00b001bf764c1bc1mr2012864pjb.85.1646704351035;
        Mon, 07 Mar 2022 17:52:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pf15-20020a17090b1d8f00b001bf5d59a8fdsm645663pjb.2.2022.03.07.17.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:52:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8192-mt6359: Fix error handling in mt8192_mt6359_dev_probe
Date:   Tue,  8 Mar 2022 01:52:22 +0000
Message-Id: <20220308015224.23585-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error paths.
Fix this by calling of_node_put() in error handling too.

Fixes: 4e28491a7a19 ("ASoC: mediatek: mt8192-mt6359: fix device_node leak")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c       | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index f7daad1bfe1e..ee91569c0911 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1116,8 +1116,10 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 	}
 
 	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
-	if (!card)
-		return -EINVAL;
+	if (!card) {
+		ret = -EINVAL;
+		goto put_platform_node;
+	}
 	card->dev = &pdev->dev;
 
 	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
@@ -1159,20 +1161,24 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto put_hdmi_codec;
+	}
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = mt8192_afe_gpio_init(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "init gpio error %d\n", ret);
-		return ret;
+		goto put_hdmi_codec;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
-	of_node_put(platform_node);
+put_hdmi_codec:
 	of_node_put(hdmi_codec);
+put_platform_node:
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.17.1

