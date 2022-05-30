Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E4537AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiE3MjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiE3MjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:39:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A007DE09
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:39:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r129so995624wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOg84BIL4xQRP3MO/aXO52buPBsvauauBaUk9MIZub8=;
        b=tyRhSVq0ivqjvgv19Le2dDbG9CZp5EUZ/zREh2B9EqSFvQ0bEXEKG1+csR4Tpd7M/H
         AHPyjbUVOaWUemrfWMJ9iOhH7XjqNLtKq1ynVTRMM+nKleZY+jmoMjBHMxH4gAq9fXrb
         J41Tn7SunmiKvWbrDWG9UMD4X/pps9yTdP81ARlOHjFAQKMGWjyqZ1hUImkvqRpcWUXy
         ZYJT5Oa8XawT5PyDKgZ9uoiGeYprUlV21rdPlbppNaVA4sSN0OXr/jpu7vpAfMJe/Y+3
         EIge7ArubAowZVy8ugPDj6li08SrGSLwX+1vy3NPlzBzESQIoDLhKaNmE0eVofOyY6a+
         3AzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOg84BIL4xQRP3MO/aXO52buPBsvauauBaUk9MIZub8=;
        b=xE/EG1BefWZK/SWwbkZo8/UHWwPsT8Cy8OKC2FeOA6bCkWT5obXmFzZik5qRzatPgN
         NVNYK9wsfcjdyfn6759Ogo08MzbCr8LJ0TTPJuvh04tB/cKIyFJwC+AgMopWDPHJeECZ
         LmjDXAi2Ix+CWttX55nQuxNC6+N3EdlVvpalRiA/kAVr+IGCrkibbCBm4Y9hHC1iSe16
         nDohuICWWm6JV5shvZv8BcaZ3DmwGtL+D7NigOVcyanMmD1OcR5iRRe7WvEZm9GuMc+x
         vXxvxzU/JTDShjr3VVWYhQrlgQmfuV4O/YPyW8K2q+Z1Cb+3sP2mKigWz/vFFL9o8VF4
         tbqg==
X-Gm-Message-State: AOAM533pfVGxyOxgoXBVC2Dm64zBdILKprfyXCO0OQSMFFOMs3wyQrCK
        xN8M3l2AOhPq/uWgcR43Rx3lZA==
X-Google-Smtp-Source: ABdhPJxcmwC4nGeuFy/KRdJLKioMtzoK88H6jW8SYyE+vJtOjc5C4KCm5edQ5ur75NCG1V94Z2fwbA==
X-Received: by 2002:a05:600c:2182:b0:397:58f5:c6cf with SMTP id e2-20020a05600c218200b0039758f5c6cfmr18471215wme.86.1653914356468;
        Mon, 30 May 2022 05:39:16 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k7-20020a1ca107000000b00394708a3d7dsm10137222wme.15.2022.05.30.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 05:39:15 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mtk-sd: fix typo
Date:   Mon, 30 May 2022 14:38:56 +0200
Message-Id: <20220530123857.692076-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: Fianl -> Final.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 195dc897188b..c7d196f805ec 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2318,7 +2318,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 	else
 		val = readl(host->base + PAD_DS_TUNE);
 
-	dev_info(host->dev, "Fianl PAD_DS_TUNE: 0x%x\n", val);
+	dev_info(host->dev, "Final PAD_DS_TUNE: 0x%x\n", val);
 
 	return 0;
 
-- 
2.36.1

