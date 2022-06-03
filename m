Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32C53C9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiFCMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:22:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC1632B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:22:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c196so7091092pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VC0YJVZn7Kv6rn/9H6pSETWMjRj00JSP4l9cAHh5eU=;
        b=hROkOAQnkmQctmhtlL1X5NiOE3QXbtEkfIJvBno2MFCdveIkW1Kx36uOmAKO4ebT0Z
         QFcLvV1FAiydy4xwFUEtjTgcTg7kDI7nAD7s7AusEVTao1eFqEJtHnMINWF8Ki5oe5nU
         6M+t9EyIWLPH060tBgvGubZ/UtPZzcg8iTOjyIteG1qOQ2rJdBuUZ9VjymAASIPMsk95
         FZZihZ3m/6Q/GfUE3fn2Vynix8OvJ9N2t35TnUiWRflNGc6TogspMjzsXRkSaiVSm/cA
         2Gd4PdL359hpW+FgdiSNaZIa0iIo5p6Yn+Uf3HupeYEQIdFEafpNpt/91kuianpwz6JB
         HAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VC0YJVZn7Kv6rn/9H6pSETWMjRj00JSP4l9cAHh5eU=;
        b=1mhEE0Tp7SEjfbc33SefQmN5fMyocUsarynnAr3P7uPB5G/rkQL/nZwckc1zgfLRML
         jmmhcQJ8BsAOHbHEIOu6rewsm2TO38AAYynqgVDUm6k6z7Qbh/luQOKYT2RHNg2qyI1q
         im+Io1UFXLz2J/F4WrzsL0+xoeAyK112uk8NnkrTDe5ynEKUUkjMzgFQ6YRk7m++aj1E
         WuW5qAySx49kDC1rEZjJTxEwtmS/+0XCURSbCuMYetDd+5NAeqwsNFREe8wNt7asaZ4A
         4tw5jIVeTDrFQbF0p+0rY/xy8YgDii3f7gFd8EGYcT5dGBHpFnP1rUQm2oQP3YDUot81
         j6cQ==
X-Gm-Message-State: AOAM532zbUn8UcirqpMg3lA/swPq30oTTn482nhEM482HzlNtj2DQZYk
        K2Sv2Hc75HCDiiEyksg/CLU=
X-Google-Smtp-Source: ABdhPJxCUQk6p5MU7RZHc5xtq+78cZYza7i9U7uf70adLQBe3kOuHC+oOulaqSKHxDVn+zUwwg3Q2Q==
X-Received: by 2002:a65:6cc9:0:b0:399:26da:29af with SMTP id g9-20020a656cc9000000b0039926da29afmr8711774pgw.489.1654258919680;
        Fri, 03 Jun 2022 05:21:59 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id h15-20020a17090a470f00b001df51dd0c93sm8330001pjg.1.2022.06.03.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:21:58 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Kai Chieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
Date:   Fri,  3 Jun 2022 16:21:47 +0400
Message-Id: <20220603122149.25117-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: f0ab0bf250da ("ASoC: add mt6797-mt6351 driver and config option")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag
v1 link: https://lore.kernel.org/r/20220603083417.9011-1-linmq006@gmail.com/
---
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index 496f32bcfb5e..d2f6213a6bfc 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -217,7 +217,8 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 	if (!codec_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->codecs->name)
@@ -230,6 +231,9 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 
+	of_node_put(codec_node);
+put_platform_node:
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.25.1

