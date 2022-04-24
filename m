Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9FD50D5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbiDXXU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 19:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDXXU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 19:20:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB55DA14;
        Sun, 24 Apr 2022 16:17:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BC0865C010E;
        Sun, 24 Apr 2022 19:17:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 24 Apr 2022 19:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650842273; x=1650928673; bh=ukhK/3p5rv4p+ixQouMflt4+T
        +mWNkdHDOYzih3p7Uc=; b=ZgtYGMJLu+mac01+DAYTZ0b8xT+Og/Lx7gii1iuci
        G33s0ZfpaZXpNjjAfsh1j2zUBsTpsq2QYROM8IWxtePYhZYmwyNzBemRGpZhVQNf
        u4PdbRnehe99W8WnDhtOqwWmk0e8QJB88z5Xh9riqiU8cD4kc3Z5wQUHvoc0t2ZX
        k/+U3J6316QBjh3LJKti3VFS5YZQsD8QLTmlLkIsmtIBjXkW3/XmeYOIClNBJgrn
        sbixv5kLO08IuRgMoJbkZYmJ/WZ5nukR07Ps01LJX4+ScCvL4fw8n5jC5dwu5jz8
        UV+wA7pVeYUAA3ajkKm1rlfQmSZqe4GU7VqppPExZH71A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650842273; x=1650928673; bh=u
        khK/3p5rv4p+ixQouMflt4+T+mWNkdHDOYzih3p7Uc=; b=mbIQwFTIE94auivFE
        sTfdUfxiDwtXw4VsO9TSzerZLQr5ueV758NYVCYWyiw8j7UTrlGGnKdQWECilEhH
        LIxwJf+6bx8E+BhqUS7e1b8BfelX/mKC3BU3D8imbHzw5Lsf8CPRSTS4NzO2wBiL
        FW+ry/lwD1sVthP/YBMUHeCZ3kqOiIEPfBx/epGKIWF7XdKzqWtqQ0bwQBWvenjR
        8gd9XMmTRXSKXorpDNj/IYol5x6pLkCJrdb76GCfGrqX85nmthySApPrOZS0QXZZ
        W3mmupJapOLKUXhrMGBtPcdCvL+gu9vY44tcOrHmu4eR00lj1oIE4VYsjBRh8gHL
        JN5ZQ==
X-ME-Sender: <xms:oNplYpnvePGjpFLxXcrnjHVAIJsEBAJRYLSxiuG2giy2yfJ-hfsdGQ>
    <xme:oNplYk2Ww07sfEoa53DKMrctWwlcl0-FOrC3xN2yZn513SyZ4CpcWY9RXcIiCEg_s
    Yu7vAN9vuMfm1XU9w>
X-ME-Received: <xmr:oNplYvqErI6S5L0hQM2qr7UxIQQuNCbNzwpd_e7p5lKB3FkZH1wkh_mxnSvmnYPy2l_42zjm7f909zKtMDJXHnnXNKE-rumYl4UEhl123J7YjBOc5lL10BSQ7k9c27mFRlWfFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:oNplYpmmSGYTGcRQGAregerKYU7hQm6ghAUjC0XSIEzeHlRxik1JjQ>
    <xmx:oNplYn0p7FERwylDQ8gC4LgvpsRrg5BAbgPOPnLAIZ_26P1WpiRiwQ>
    <xmx:oNplYouU9jQWPtKuiy6FZkAcgOtQ42myTjFe2emAGufgpElNvOOGbw>
    <xmx:odplYpyfKITICRD3YusCIUuNnw3A4JhonMGzT_YB46czZ62H8tRp3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 19:17:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits
Date:   Sun, 24 Apr 2022 18:17:50 -0500
Message-Id: <20220424231751.32053-1-samuel@sholland.org>
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

Newer variants of the MMC controller support a 34-bit physical address
space by using word addresses instead of byte addresses. However, the
code truncates the DMA descriptor address to 32 bits before applying the
shift. This breaks DMA for descriptors allocated above the 32-bit limit.

Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mmc/host/sunxi-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c62afd212692..46f9e2923d86 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -377,8 +377,9 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 		pdes[i].buf_addr_ptr1 =
 			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
 				    host->cfg->idma_des_shift);
-		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
-						    host->cfg->idma_des_shift);
+		pdes[i].buf_addr_ptr2 =
+			cpu_to_le32(next_desc >>
+				    host->cfg->idma_des_shift);
 	}
 
 	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
-- 
2.35.1

