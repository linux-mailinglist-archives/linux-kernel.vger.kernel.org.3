Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5E4E835C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiCZSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiCZSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:38:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B438197;
        Sat, 26 Mar 2022 11:36:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:4cb:3227:231:99f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 69D8D1F44FBF;
        Sat, 26 Mar 2022 18:36:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648319793;
        bh=0LbIskzUpKi13BEPgM5TnTSCxgDUwO8aXIcFBWj7xRE=;
        h=From:To:Cc:Subject:Date:From;
        b=cAIrxgy2Y+0pcqgObdaDi6S0q5QsLxN6WptKxFirODn0OlleztAfRQL1HWkmOmr2z
         DZIXz3mk/A9w7J+R+EjTBLJ0JVsFkPXg63k1ZpKl0i5kTs6UZHBt9s8b6nMnXU4tRl
         WkVAcejKbsExYRxGpZ9Yw/hpoxEmF54oRyAIBeUQotAT7FX0BoVUUJ+WNHWXNLEInn
         hL08afOr4lkDHh66HfTDYsuOt5QCjWrjfj2eIlJ3ip4jxgZV4Esq2s7Nh7Czzxtmkc
         q+Wk/p20kp8qJEHCRPnQ/yADOOmn+hat2awVsNGESa2lRdVuSsXA53Dzvh81xlWmVn
         sQTeMEKjxXbsA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org (open list:HANTRO VPU CODEC DRIVER),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: media: hantro: Fix typos
Date:   Sat, 26 Mar 2022 19:36:03 +0100
Message-Id: <20220326183603.66797-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in comments within the Hantro driver.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
 drivers/staging/media/hantro/hantro_hevc.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index c524af41baf5..c0645e335fc9 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -406,7 +406,7 @@ static int set_ref(struct hantro_ctx *ctx)
 
 	set_ref_pic_list(ctx);
 
-	/* We will only keep the references picture that are still used */
+	/* We will only keep the reference pictures that are still used */
 	ctx->hevc_dec.ref_bufs_used = 0;
 
 	/* Set up addresses of DPB buffers */
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index b49a41d7ae91..9c351f7fe6bd 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -59,7 +59,7 @@ dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
 	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
 	int i;
 
-	/* Find the reference buffer in already know ones */
+	/* Find the reference buffer in already known ones */
 	for (i = 0;  i < NUM_REF_PICTURES; i++) {
 		if (hevc_dec->ref_bufs_poc[i] == poc) {
 			hevc_dec->ref_bufs_used |= 1 << i;
-- 
2.25.1

