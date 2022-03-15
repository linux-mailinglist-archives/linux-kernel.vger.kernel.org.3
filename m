Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D182D4DA5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352530AbiCOXJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352524AbiCOXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:09:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC510FC7;
        Tue, 15 Mar 2022 16:08:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so582147wrh.11;
        Tue, 15 Mar 2022 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtiiQiHIQhMd0RX5LgSCyiXCNdoSA3NRLMvs3SxeOlk=;
        b=bRH/YUTYKsj+spCdxxuad96aeBIsG8spLEf/MkQeInQYkYHSr+hzJUl7Zbt+zxn4Jg
         PioY0FGaD3vrODJrsJSeDMRnaUdXW0TPVhAtBBMZ7vuKj26uTkxi3ZEkLa6q1euuEvIy
         4DtTKOEJQqOpME+2lg0oCIjsmcjV6YkjLS+4AVZ//KXyqKr4HJpUWvO2AKqT2HaCQAnS
         A+oTlqzp7dsQIvmDQQvgOD/khTIQ6X8F7GEW9PN/9wp31UIrpX1S+tlxs+IedLgOppNe
         S+crJLickDvVNsMJouBBSaI04tc/mZ2sGRXULam+PwR+j04s+OVOgIYabvBaGddsOi+K
         1msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtiiQiHIQhMd0RX5LgSCyiXCNdoSA3NRLMvs3SxeOlk=;
        b=XhXkf2RWjSWloyvqpjmLtGjb7IeswWNgjMxt8Evd1LCLRmKXVUpUJp68M8tT4bF4EG
         XqQZpiuM06vYxbdvq43PA0CpghUyTPIzfxOQ7hP2sb/CzafjSzrA0tD9VbmOLY5oifvR
         ZkbUiVLs7iRPFMF+iWY2i3pJKA1mIF2WBLTHB5a3zjtBvmO0CPw1cwDtPAkfEpkc15y1
         bjGlaZ6qn7Khi2S5CWi/r4j1reZsZXAodie8cakqKYLihTPMK8qYXBq3WNdoWmBlwMos
         Tu03tb8gV50BBrE9c8RVTUX4g1VmNapPJHm5v5WIX6ybQl6YpwUyqlDoR446fG4LfFx7
         875Q==
X-Gm-Message-State: AOAM531q9kOZN1nnUzKxGzQF74hhn3OOe7WpHJ5KAIoxhGzNy6iCjWms
        4qFwfrX3SG4j0Aa/48FZypKY84Lj+DYWgw==
X-Google-Smtp-Source: ABdhPJxAS0Dpw20sHS3bnj03ua9LMF6Pwm3AdOStfhwGjbYJsj0FDhC5+tHEvjtv63EkMGk7XL27CA==
X-Received: by 2002:adf:f943:0:b0:203:b456:c71d with SMTP id q3-20020adff943000000b00203b456c71dmr9864142wrr.568.1647385697822;
        Tue, 15 Mar 2022 16:08:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d25-20020adfa419000000b001f04b3a4b46sm196649wra.94.2022.03.15.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 16:08:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ti: Fix spelling mistake "cant" -> "can't"
Date:   Tue, 15 Mar 2022 23:08:16 +0000
Message-Id: <20220315230816.2964577-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/ti/omap-dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
index a26588e9c3bc..f3eed20611a3 100644
--- a/sound/soc/ti/omap-dmic.c
+++ b/sound/soc/ti/omap-dmic.c
@@ -474,7 +474,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 
 	dmic->fclk = devm_clk_get(dmic->dev, "fck");
 	if (IS_ERR(dmic->fclk)) {
-		dev_err(dmic->dev, "cant get fck\n");
+		dev_err(dmic->dev, "can't get fck\n");
 		return -ENODEV;
 	}
 
-- 
2.35.1

