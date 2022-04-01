Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC94EFB60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352405AbiDAUWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbiDAUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:21:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA37EA7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i4so5804772wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90qrshqeexZn+j3Ms+SCj05GkLlxm5ir89IuuJpyvf4=;
        b=3+ZeTMDE7x9kVnmCOJZ6g0i28+h/qwZjZlnlfk1/Vpmtk1rqW5vYID4D6Ja805pbec
         LshDiyyDDxdsimsyEdx3+WInulmVpPdVnD7tITfLUiBEnq5OwND3cX54f+Zkho0qb/Up
         RQwWWeqcQrFM3xBvHEM1gMgXanrOEkcPWRxOFfg8U4MJXlZTvp9aK125em8GvnYbpizy
         vxx4lM0MjSsHQu0GjeJuIPJKMHXlEVvzYpjx445wq3IhnAT8uFnJEL+Fnh/VtbjRIxxV
         lFDIA+22wWSVpqhny6JnqLUbIJqcY+zTBXtwqpaHzD6qotrhBxbTg+Vxi4E0/HRIQEAT
         1yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90qrshqeexZn+j3Ms+SCj05GkLlxm5ir89IuuJpyvf4=;
        b=miQVG2VvqiKvqfhDUdx7agE8EF1fVLMxjbNB8NjTQuWjt8arEDx2hDB1gCG3GSP1uC
         KWTU6YqufsRAbduwH21gpoVxXhxtJid+57tcnQ/5qdqnivbwZiuLh9P3FZWdFV9HPcoi
         lcLEuXY+SMzNa1aHro5JY54oX/LFM14oe/OJ+EhqK+EzX2JaOJXAOx3zYk5NEdWkL6Mm
         j+DHirYW/kwz1vYJTgvSaRrIIrCwbKCURrGSDnlLEMEB6eXBwGEAoZqRP1LPQgYmRH73
         lLeO5CGuMLp1ZOpIm4SGXmq25E1vdOd4KZa5YYmPbXZrEswAjG7/3IX36yXOblK9ln1i
         xzSw==
X-Gm-Message-State: AOAM532KN/cwkAQS0AjcloIvhkcmH5KJIl44NIC2Thwm8fOpW8iWyX2g
        /2WVclmovjFZd16pQYCCTUYF/Q==
X-Google-Smtp-Source: ABdhPJy0hMZ7iH0NhjrOY75WBE5HCcFkLM02diKdDyLeunQVL/H99u58Pwzfg18UmEcqM1csMQHR8w==
X-Received: by 2002:adf:e947:0:b0:205:9051:ab61 with SMTP id m7-20020adfe947000000b002059051ab61mr8955237wrn.510.1648844308492;
        Fri, 01 Apr 2022 13:18:28 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 24/33] crypto: rockchip: rename crypto_info to main in TFM context
Date:   Fri,  1 Apr 2022 20:17:55 +0000
Message-Id: <20220401201804.2867154-25-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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

RK3399 will have 2 crypto_info and only one will own crypto algos which
we will call it main.
This wlll help differentiate with other dev variable.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h       |  4 ++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 19 ++++++++++---------
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 12 ++++++------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index b6cd67d1d0cb..79982fafd6b2 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -208,7 +208,7 @@ struct rk_crypto_info {
 /* the private variable of hash */
 struct rk_ahash_ctx {
 	struct crypto_engine_ctx enginectx;
-	struct rk_crypto_info		*dev;
+	struct rk_crypto_info		*main;
 	/* for fallback */
 	struct crypto_ahash		*fallback_tfm;
 };
@@ -223,7 +223,7 @@ struct rk_ahash_rctx {
 /* the private variable of cipher */
 struct rk_cipher_ctx {
 	struct crypto_engine_ctx enginectx;
-	struct rk_crypto_info		*dev;
+	struct rk_crypto_info		*main;
 	unsigned int			keylen;
 	u32 key[AES_MAX_KEY_SIZE / 4];
 	u8				iv[AES_BLOCK_SIZE];
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 1f72ded24920..3d119c2ddf9f 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -83,7 +83,7 @@ static void rk_ahash_reg_init(struct ahash_request *req)
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *dev = tctx->dev;
+	struct rk_crypto_info *dev = tctx->main;
 	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
@@ -201,7 +201,7 @@ static int rk_ahash_export(struct ahash_request *req, void *out)
 static int rk_ahash_digest(struct ahash_request *req)
 {
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
-	struct rk_crypto_info *dev = tctx->dev;
+	struct rk_crypto_info *dev = tctx->main;
 
 	if (rk_ahash_need_fallback(req))
 		return rk_ahash_digest_fb(req);
@@ -226,7 +226,7 @@ static int rk_hash_prepare(struct crypto_engine *engine, void *breq)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *rkc = tctx->dev;
+	struct rk_crypto_info *rkc = tctx->main;
 	int ret;
 
 	ret = dma_map_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
@@ -244,7 +244,8 @@ static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *rkc = tctx->dev;
+	struct rk_crypto_info *rkc = tctx->main;
+
 
 	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
 	return 0;
@@ -259,7 +260,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 	struct scatterlist *sg = areq->src;
-	struct rk_crypto_info *rkc = tctx->dev;
+	struct rk_crypto_info *rkc = tctx->main;
 	int err = 0;
 	int i;
 	u32 v;
@@ -336,13 +337,13 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 
 	algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 
-	tctx->dev = algt->dev;
+	tctx->main = algt->dev;
 
 	/* for fallback */
 	tctx->fallback_tfm = crypto_alloc_ahash(alg_name, 0,
 						CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(tctx->fallback_tfm)) {
-		dev_err(tctx->dev->dev, "Could not load fallback driver.\n");
+		dev_err(tctx->main->dev, "Could not load fallback driver.\n");
 		return PTR_ERR(tctx->fallback_tfm);
 	}
 
@@ -354,7 +355,7 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 	tctx->enginectx.op.prepare_request = rk_hash_prepare;
 	tctx->enginectx.op.unprepare_request = rk_hash_unprepare;
 
-	err = pm_runtime_resume_and_get(tctx->dev->dev);
+	err = pm_runtime_resume_and_get(tctx->main->dev);
 	if (err < 0)
 		goto error_pm;
 
@@ -370,7 +371,7 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	crypto_free_ahash(tctx->fallback_tfm);
-	pm_runtime_put_autosuspend(tctx->dev->dev);
+	pm_runtime_put_autosuspend(tctx->main->dev);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 9784b25e64ce..115ba7750d7b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -96,7 +96,7 @@ static int rk_cipher_handle_req(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct rk_cipher_ctx *tctx = crypto_skcipher_ctx(tfm);
-	struct rk_crypto_info *rkc = tctx->dev;
+	struct rk_crypto_info *rkc = tctx->main;
 	struct crypto_engine *engine = rkc->engine;
 
 	if (rk_cipher_need_fallback(req))
@@ -314,7 +314,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	unsigned int todo;
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
-	struct rk_crypto_info *rkc = ctx->dev;
+	struct rk_crypto_info *rkc = ctx->main;
 
 	algt->stat_req++;
 
@@ -437,11 +437,11 @@ static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 
 	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
 
-	ctx->dev = algt->dev;
+	ctx->main = algt->dev;
 
 	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ctx->fallback_tfm)) {
-		dev_err(ctx->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+		dev_err(ctx->main->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
 			name, PTR_ERR(ctx->fallback_tfm));
 		return PTR_ERR(ctx->fallback_tfm);
 	}
@@ -451,7 +451,7 @@ static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 
 	ctx->enginectx.op.do_one_request = rk_cipher_run;
 
-	err = pm_runtime_resume_and_get(ctx->dev->dev);
+	err = pm_runtime_resume_and_get(ctx->main->dev);
 	if (err < 0)
 		goto error_pm;
 
@@ -467,7 +467,7 @@ static void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
 
 	memzero_explicit(ctx->key, ctx->keylen);
 	crypto_free_skcipher(ctx->fallback_tfm);
-	pm_runtime_put_autosuspend(ctx->dev->dev);
+	pm_runtime_put_autosuspend(ctx->main->dev);
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
-- 
2.35.1

