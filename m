Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE414DCFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCQU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiCQU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342E154078
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so5628730wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDd6Lum4WVHK2qnq9j8fS4muA5cEDXa7xMcM4rmC0VU=;
        b=bQxQxJAopjBa0cH3DEA/wH7NmBNJs68v3ttaUHN/+kGRSs6CQsIpqCvzQQN2lyiZa5
         O9dMEpnnsSy4JfQpypICumZkQ/hfGH9OX3mg4mdQbuAAS0E+BjA+6mbMnUOanIeTVNmP
         KHpuqC9s2au36N2guRPz4Q5RluOow2CMFqhnPmaCuhE69JVLbrCaxtYcqg5q18QeuJ4s
         MaK6NCzRLP/CRb74vXmwyBHCN6mQc44u7+4d8P8rU+iSIduD1scckg/ESB2SFEJ1GVSN
         WwuAdMYz6HZJhzuD/xRei98D5eYjbgGxlPMNoCoQkBKCfdZvip7YoM0SD4XpebERtwpg
         eu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDd6Lum4WVHK2qnq9j8fS4muA5cEDXa7xMcM4rmC0VU=;
        b=iEev7IXLgQZkN2SdI9j/V6qJjHHCHNvvoeI3+b2DqqenksclaN/lbqykWrwUuatXpz
         K4uSWHKSgWOubyLXH1Wojuk95uh5tmpoiUB7n4GRLjmYatrucYfV7pMjmMg5ZHNbXKOc
         wjNonOuDHV1NTPWeWNERQJCbEoE6cGl5Gv2w8mCFIZAzFBkbsvATosBs3m48rB+GyeFD
         3prtLP4/84to4AbXdVsbSTlRc02xT9wYsr7yQZHY0Nr0EogwwpsMsTKh2f391F0+4x50
         mnvPb2PiTna9bVccybu0IIHrMX37RM4SsEjMxOCC3npEW+YSMjpkr84WBzbNmEYamxxX
         UoTA==
X-Gm-Message-State: AOAM531aNGVRAZHBBop/NhPQCJh8hBdWN1GNuyfpzQsPhVKhbw30fTl7
        QxCTmpivMgsmPYFTgNP/3b//Iw==
X-Google-Smtp-Source: ABdhPJyQHkhV6+UUIW8gnu0AAX3hcWcWqqY3Ps0tnLgGEr/efCECgC8g9vsbSOUGQX3PgDIA0DNkUg==
X-Received: by 2002:a05:600c:4e07:b0:38c:8187:13c3 with SMTP id b7-20020a05600c4e0700b0038c818713c3mr3010470wmq.11.1647550576305;
        Thu, 17 Mar 2022 13:56:16 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 07/19] crypto: sun8i-ss: test error before assigning
Date:   Thu, 17 Mar 2022 20:55:53 +0000
Message-Id: <20220317205605.3924836-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
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

The first thing we should do after dma_map_single() is to test the
result.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index eaa0bbaf5581..49e2e947b36b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -420,15 +420,15 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	}
 
 	addr_pad = dma_map_single(ss->dev, pad, j * 4, DMA_TO_DEVICE);
-	rctx->t_src[i].addr = addr_pad;
-	rctx->t_src[i].len = j;
-	rctx->t_dst[i].addr = addr_res;
-	rctx->t_dst[i].len = digestsize / 4;
 	if (dma_mapping_error(ss->dev, addr_pad)) {
 		dev_err(ss->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
 		goto theend;
 	}
+	rctx->t_src[i].addr = addr_pad;
+	rctx->t_src[i].len = j;
+	rctx->t_dst[i].addr = addr_res;
+	rctx->t_dst[i].len = digestsize / 4;
 
 	err = sun8i_ss_run_hash_task(ss, rctx, crypto_tfm_alg_name(areq->base.tfm));
 
-- 
2.34.1

