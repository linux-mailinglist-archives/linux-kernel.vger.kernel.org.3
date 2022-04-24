Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1750D5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiDXXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDXXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 19:09:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342337AAA;
        Sun, 24 Apr 2022 16:06:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2398C5C00ED;
        Sun, 24 Apr 2022 19:06:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Apr 2022 19:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650841603; x=1650928003; bh=3OBKHVbbE8+WTVho7BOdi/9Bu
        3xsWKZkElXAOTZAnrM=; b=kKwWgTyOPXVEgGX1P6Gl/7kmudauDIGT5B+8ZOWOh
        ELSRGWF0YCFV9tw9G9BKsAos/Zk0ODicyx2o2wYCfEavKcyeivMzFhwG0WJvnwBN
        uM/IRWJODjrgu6JH4qVoSbe7bUIQH7nP7Ey5Ig5jht9/2fp0yUymH0jMhxUx+jAS
        r/HNtHExs6o70MnwCFoT5kgTrWmQRhPietIrfP9at6jnU7+Qd0ghXObQVnjGchwQ
        U5udDeYBL4CN/Kv/pziu2N6eaekplTU6aBcYohmRQYDUbHMkHNQtgWeHSCCybua5
        0V/gr7buuBGtt+Wyrd26RT14ZbRQrsjl1DI4o3/A01PPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650841603; x=1650928003; bh=3
        OBKHVbbE8+WTVho7BOdi/9Bu3xsWKZkElXAOTZAnrM=; b=JRXOmA2beSZzcjNrF
        p6Pcn0x8ajbq3XBdIC4LJ5uPE2CdKmZJheKuqF4Rhi21KdgBGoEOF86dtWsXKANN
        kU7Xyi+XyyrF0Dov4jPlhXnJm9NRzCVx0JtV5KKX+LMTMVM8C2UQCQbucGPIWk/5
        mIeWl3yuxJcQYCwoFOtT7PL9drTiQOI2t4tl2kiEW7fZkZIPNWelU39Udq2qCmS6
        Y0MW+LWzjtKt2XD2J6iVzLbm0S7ona3JFyf7fM3oVlGzkkJDX1zz3IIu5WagGMAO
        v6KeKdnV/nWsYhtvUewPsZvPD2fVrxk5KfkslfyC7miV7U0KG9FO+kdueDhWo2m9
        bC86Q==
X-ME-Sender: <xms:AthlYutu5bcxXywKZaOouBuWyn85DftTLy7AbC0kSYoCLEcZmDRKgw>
    <xme:AthlYjd48cAO5mP00x9b-cGQli6vL8cTzR5Aclm3UndvFC-49-XN2ptdScRMc2qtp
    pW2bYA9JMJ7CIEeEQ>
X-ME-Received: <xmr:AthlYpzx5ZQRrBxQiif5HmZHsooFFW5fQAaXX2ZjSWI5l-oD7GKNZ4DzmfyZ-cR10iVmNwO3GwM3PQY66nBeW9yAI0szy4aT_p6YM2bwn4kEgYIqYzyU4U8RCO08dBNICQaewg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:AthlYpNzrUU2wIU7LDd9B0_KN19l4j30JliBUYgahCqRGvPQQW8m1g>
    <xmx:AthlYu8LeMIy6xeVywPSyy518ZlBmXfCmUXGwEkNZS4On_svFwKZng>
    <xmx:AthlYhVrEGs-7bLVbikf6Cr_gFDf871W2JIaX0W7BSPJT_2efb3TkQ>
    <xmx:A9hlYhVtG_SH9yTsl092Igdr69M2pBebl2i5mD-6t74FP805I-dNbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 19:06:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Chris Ball <chris@printf.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mike Turquette <mturquette@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] mmc: sunxi-mmc: Correct the maximum segment size
Date:   Sun, 24 Apr 2022 18:06:39 -0500
Message-Id: <20220424230640.31735-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the DMA descriptor documentation, the lowest two bits of
the size field are ignored, so the size must be rounded up to a multiple
of 4 bytes. Furthermore, 0 is not a valid buffer size; setting the size
to 0 will cause that DMA descriptor to be ignored.

Together, these restrictions limit the maximum DMA segment size to 4
less than the power-of-two width of the size field.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mmc/host/sunxi-mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c62afd212692..4bd5f37b1036 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -214,6 +214,9 @@
 #define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
 #define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
 
+/* Buffer size must be a multiple of 4 bytes. */
+#define SDXC_IDMAC_SIZE_ALIGN	4
+
 #define SDXC_CLK_400K		0
 #define SDXC_CLK_25M		1
 #define SDXC_CLK_50M		2
@@ -361,17 +364,15 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 {
 	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
 	dma_addr_t next_desc = host->sg_dma;
-	int i, max_len = (1 << host->cfg->idma_des_size_bits);
+	int i;
 
 	for (i = 0; i < data->sg_len; i++) {
 		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
 					     SDXC_IDMAC_DES0_OWN |
 					     SDXC_IDMAC_DES0_DIC);
 
-		if (data->sg[i].length == max_len)
-			pdes[i].buf_size = 0; /* 0 == max_len */
-		else
-			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
+		pdes[i].buf_size = cpu_to_le32(ALIGN(data->sg[i].length,
+						     SDXC_IDMAC_SIZE_ALIGN));
 
 		next_desc += sizeof(struct sunxi_idma_des);
 		pdes[i].buf_addr_ptr1 =
@@ -1420,7 +1421,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count	= 8192;
 	mmc->max_blk_size	= 4096;
 	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
-	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits);
+	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits) -
+				  SDXC_IDMAC_SIZE_ALIGN;
 	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
 	/* 400kHz ~ 52MHz */
 	mmc->f_min		=   400000;
-- 
2.35.1

