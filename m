Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FD4CB0F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiCBVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiCBVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A63FDE2EB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u10so3110214wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq94Dr5+JVccORut3g3YoAFCHNwJha9oYdYCZSmtj94=;
        b=U0DTL4S6GNXCxomapNhQbk6QlG9hRPJv1j5HQJ0h09vEfdgbVOM7InDA3E6lUAdTrz
         uRqA9AxWXGRWAporGp8wFF71zA/8cO4jaRJAMomxRx/5b3yOIiw3cUEl6eBy0NyeIbP3
         G682W5sAueKScefqW0j5QuAPnx5vYhXW0wmSF+vzvUHpP/JUIWGKhUbv5RAus3Mhtim0
         C98fu98v22ASVbY9MBUXeo9MUKM5g0ZKZowOQZQkkebVmJlCFGOw693/tQ/c0TScfHf3
         D1gpk6n6UHErJxZz0XhgwkjyJzEiP4U+v/bZsagYAs84CFffnWvq7elwEuKrUcyLx+T3
         DiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq94Dr5+JVccORut3g3YoAFCHNwJha9oYdYCZSmtj94=;
        b=i/kjToFIg+uL1xwPN0yGotSYarw+jMMejUmskyL4BvqfKsTrmUHR0TBFx2FjB3w93w
         D+AYvvedn+qDCJXkF3QCe4OpWnYxDV/0c6kuGaqv5FqLE8mY0/KXUNR0krCMZ3R9dgLA
         r8j16zOECAXVbTflPEOoPyO3FHsuVxOlk/r1BwkEfq/9Li6WtU+FVG4ZpyFsUeWZfg+d
         +GETdqueyNUCDezwUx/VhFi0sljOVkMWSWEXpCOePQP+iPB/MEpSFJhlJQnPenr79/P3
         se8n+h4HLZC/XmDNnFoTWWGXCL9GII5n9XlAXBEhiDKjUxSuCJvqFp67FOVXU7q/hMav
         oAqA==
X-Gm-Message-State: AOAM533TEj5ykKo/DscrKi8KMaYGPwyUGpje4cyqAHcm2tm77Uz0RvUq
        cBBsf3iGV55PoG4UUkhu68Cy+w==
X-Google-Smtp-Source: ABdhPJzNrviGuhF6beRfYB3gHyxCFqqZ+/HGFHv0JfNIUXWA3/kfT5jahwXLRaO3xGZoJD2iUvKvtw==
X-Received: by 2002:a05:6000:3cc:b0:1ef:9b6d:60c6 with SMTP id b12-20020a05600003cc00b001ef9b6d60c6mr13743574wrg.480.1646255491524;
        Wed, 02 Mar 2022 13:11:31 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:31 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 11/18] crypto: rockhip: do not handle dma clock
Date:   Wed,  2 Mar 2022 21:11:06 +0000
Message-Id: <20220302211113.4003816-12-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA clock is handled by the DMA controller, so the crypto does not
have to touch it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 16 +---------------
 drivers/crypto/rockchip/rk3288_crypto.h |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 94ef1283789f..645855d2651b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -40,15 +40,8 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 			__func__, __LINE__);
 		goto err_hclk;
 	}
-	err = clk_prepare_enable(dev->dmaclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
-			__func__, __LINE__);
-		goto err_dmaclk;
-	}
+
 	return err;
-err_dmaclk:
-	clk_disable_unprepare(dev->hclk);
 err_hclk:
 	clk_disable_unprepare(dev->aclk);
 err_aclk:
@@ -59,7 +52,6 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 
 static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
 {
-	clk_disable_unprepare(dev->dmaclk);
 	clk_disable_unprepare(dev->hclk);
 	clk_disable_unprepare(dev->aclk);
 	clk_disable_unprepare(dev->sclk);
@@ -199,12 +191,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(crypto_info->dmaclk)) {
-		err = PTR_ERR(crypto_info->dmaclk);
-		goto err_crypto;
-	}
-
 	crypto_info->irq = platform_get_irq(pdev, 0);
 	if (crypto_info->irq < 0) {
 		dev_err(&pdev->dev, "control Interrupt is not available.\n");
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index c741e97057dc..963fbfc4d14e 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -191,7 +191,6 @@ struct rk_crypto_info {
 	struct clk			*aclk;
 	struct clk			*hclk;
 	struct clk			*sclk;
-	struct clk			*dmaclk;
 	struct reset_control		*rst;
 	void __iomem			*reg;
 	int				irq;
-- 
2.34.1

