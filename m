Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6264CFF0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiCGMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiCGMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:46:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215C5E14B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:45:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 27so13442719pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TlcCWdEmJAkGERXKgqWQ74vqcWFDfJqoMfNr678xADM=;
        b=cD+B9+HipufW4e6RKtDe7ZfrvlpAfbZv+pAr7A9bMzN8MCLzhK7ZEQl7a0NeLPOu5v
         sCYD99HPTLEJpnZvMMnl/YnDK92oPTXa3+fZAEFP7lM4c6+YsAziiePstIKroJ+qu89m
         DdgbkK8wwUvZ9LpQIUO7X/s/GR39hJk6yVIr8Nf5merry6RZD31q9qYYNScncF3ysBi6
         3Ul0cWJD4QaxtEm9pe3lTDSR48dVW44mwUq/o/J5sqKj26lHcJlsoMcfkwyT5PckRn4J
         0MPeF+2EBAOzCAc4jL6QLGXMc/3lbEUp9XFs3nh2it1tBskNG1pkP9hOPojgDOYxpE7A
         xXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlcCWdEmJAkGERXKgqWQ74vqcWFDfJqoMfNr678xADM=;
        b=Pf4P4QXpnABuCMrKfji3SAxeUZFiryl6X1SIOM+JuY3YZy2R8+E02ABfvYFJfaNjXg
         36E8lHm66rJMlUFnx4/ixEMMzkcQJbLKnD6vpl2vW5CptFQ2+tsQo/0WtvAtzZ66u+gv
         88BfH7cVeV/ijnufjowaxGrPucVfi7kTVCtoGBUuMOMEgirgpnzCY2AkucT79D/RHOVZ
         S9Ri/KjDoqh1hJg/r4vFFY2Fh4Zr2+AD1pV5buMyxIhe5euS95wBeVf7RqMz2D17zHyK
         Q9ryqwC5tKCuvlzX97NVCItMNRP9iMfwW+B5xMsim4Vz249otma8qxq7iCJtv2uhfExy
         jcBQ==
X-Gm-Message-State: AOAM532GU0V0/k8sDCq4ofYsw3zpRXqENSbrC5/iuT5ICgh1SI0YSt/f
        sG5EKESxmyUUQ2Wp0g75K9Q=
X-Google-Smtp-Source: ABdhPJzy1JniVTE0Xq7VuNwfKPIfVaxET2IZ7oF7c7FCET0xpvuAlZk491+K1c89c1SqMJ25A6Nnkg==
X-Received: by 2002:a63:7:0:b0:37f:fa5b:95f9 with SMTP id 7-20020a630007000000b0037ffa5b95f9mr8901563pga.57.1646657145757;
        Mon, 07 Mar 2022 04:45:45 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id b5-20020a056a0002c500b004f6dbd217c9sm8246431pft.108.2022.03.07.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:45:45 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Bo Shen <voice.shen@atmel.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
Date:   Mon,  7 Mar 2022 12:45:39 +0000
Message-Id: <20220307124539.1743-1-linmq006@gmail.com>
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

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function.
Calling of_node_put() to avoid the refcount leak.

Fixes: 531f67e41dcd ("ASoC: at91sam9g20ek-wm8731: convert to dt support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/atmel/sam9g20_wm8731.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 915da92e1ec8..33e43013ff77 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -214,6 +214,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
+		of_node_put(codec_np);
 		return -EINVAL;
 	}
 	at91sam9g20ek_dai.cpus->of_node = cpu_np;
-- 
2.17.1

