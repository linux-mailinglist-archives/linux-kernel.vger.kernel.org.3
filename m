Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A14F121E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354392AbiDDJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiDDJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4DF2AE37
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso1324659pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=NFJoHT6EmGTYBUPOupG38cbbiA5NqTvKVPy1Pb3g8l0=;
        b=hqie0VxbYc6jPuFUDUUWm1ttjYV4p5WiT7ENtpsiDJIZxfyFn8KEFNdFEfMWRv7WlT
         s4gwzU9BbT8f7aP01MHVF85zFMbgqlHDUL3hg3KSpHA88D7qEyQN8o9S1mZRK2HTupsz
         pjLzKJCvhIICpDKDOqz4Au81BgUEMVRv/nxup5iZJBKY6fktTyWz2ww03AWmpaPE8TVy
         SyzKdH5qTb00ZfGBjVS5/XU1AQBJ1SPMpZ2Od2UUpqxrDw4MvEGj1R8nbyqfxHiJ3FiZ
         Hw8k2PMX0hgXLjfsdoKXvPWmHxc/U07vws0xXytgr0GA+Y6fL1626W5leKk1qWV1VFfo
         87Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=NFJoHT6EmGTYBUPOupG38cbbiA5NqTvKVPy1Pb3g8l0=;
        b=r0eJSFyN29QzkGM1t8f+ofwX5hpiRj3IEIMe1YkFUXzxuUR5QMZ3G6dtkL/KBkEB8Y
         XGkD8cp/6Zgqn5x9ZCP+f4BTU5+kiRmbub2L6OMNCqxN71WwovoW0xFr1sMAaPr7gMU+
         JXPheB7D7bG/5mrlFJnbumnb0L9XZ9DK6KABOVaGdMkDTbBsJ20YzuiqovkfULyviCkR
         tPXy/qFAJvkVkMnF3XYV97yu4rzv1gvSsp7DD6LQ/UWwdNVjdOIkFwsyYNKWWAa7E/DL
         vshOSDjhjnAH+jJkBbhWpgTeW3NXxuu15Fd7XNerJSvE/65oQ3rqXFkp37aq5YurotVJ
         Vqeg==
X-Gm-Message-State: AOAM533jz/miKj0bX+QpwzSJOQ3XLd7/qHkodDx6HRFCL7/0noIKyZpX
        fXmeEXLkZUlRKRKJ56FzGvhUaE62iMSOxTfj
X-Google-Smtp-Source: ABdhPJw99iosJV9nPCTMTX9k/SsOa92D4Q8eA8BMrDxaMJ3zDelyoQIOKd0hFHAqFwuNdvPttgVplA==
X-Received: by 2002:a17:90b:164f:b0:1c7:8d20:ff6d with SMTP id il15-20020a17090b164f00b001c78d20ff6dmr25522757pjb.64.1649064938871;
        Mon, 04 Apr 2022 02:35:38 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j20-20020a62e914000000b004fa3bd9bef0sm11032863pfh.110.2022.04.04.02.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:35:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: Fix missing of_node_put in mt2701_wm8960_machine_probe
Date:   Mon,  4 Apr 2022 09:35:25 +0000
Message-Id: <20220404093526.30004-1-linmq006@gmail.com>
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

This node pointer is returned by of_parse_phandle() with
refcount incremented in this function.
Calling of_node_put() to avoid the refcount leak.

Fixes: 8625c1dbd876 ("ASoC: mediatek: Add mt2701-wm8960 machine driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-wm8960.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index f56de1b918bf..0cdf2ae36243 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -129,7 +129,8 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 	if (!codec_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->codecs->name)
@@ -140,7 +141,7 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
-		return ret;
+		goto put_codec_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
@@ -148,6 +149,10 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 
+put_codec_node:
+	of_node_put(codec_node);
+put_platform_node:
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.17.1

