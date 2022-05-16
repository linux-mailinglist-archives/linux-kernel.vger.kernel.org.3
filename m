Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC552846F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiEPMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiEPMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:47:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4015C393D8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:47:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 61CCE1F42F51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652705228;
        bh=xO6aHuo6qr2U+3Pw1vJl92VTpaOmj3hu2VdgDueiOp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAVwhi5fVzB511R2xm2K0fSzYH9ARO0hXPuFthBl2c1kESQLvsYx3vUWdSjGbI41p
         7r1L0SCFCDiF8s04Ggl1ADsjZpb+cVYvfYd8heJUczYJ1jjclBVnWocymXxC/A8PMx
         Rxm3tllXWSSxBQ6lmZZ2Jg9I6sCSEQmK7zFG+WkSsh7dV0LX8iMEjc5USrCi9kdA66
         /XXpo+24TNtv5eUQow4276ox7idic3MfG5UIFC6V7wsc5kWFw+7o08GKQk8JTj90t8
         4uV/ko+iM5fq45UN6VNkoc2J5l3QvF5vef8XrOouY2eT6sMUpvSGx/ToxNXSmGbajo
         owEq5I26yn5rQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 5/5] soc: mediatek: pwrap: Compress of_device_id entries to one line
Date:   Mon, 16 May 2022 14:46:59 +0200
Message-Id: <20220516124659.69484-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress each entry of the of_device_id tables in this driver to one
line instead of three, as they fit just fine in a single line.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 90 ++++++++--------------------
 1 file changed, 24 insertions(+), 66 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 7d02e1d4faf4..c018092e6cbe 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1960,33 +1960,17 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
-	{
-		.compatible = "mediatek,mt6323",
-		.data = &pmic_mt6323,
-	}, {
-		.compatible = "mediatek,mt6351",
-		.data = &pmic_mt6351,
-	}, {
-		.compatible = "mediatek,mt6357",
-		.data = &pmic_mt6357,
-	}, {
-		.compatible = "mediatek,mt6358",
-		.data = &pmic_mt6358,
-	}, {
-		.compatible = "mediatek,mt6359",
-		.data = &pmic_mt6359,
-	}, {
-		/* The MT6380 PMIC only implements a regulator, so we bind it
-		 * directly instead of using a MFD.
-		 */
-		.compatible = "mediatek,mt6380-regulator",
-		.data = &pmic_mt6380,
-	}, {
-		.compatible = "mediatek,mt6397",
-		.data = &pmic_mt6397,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
+	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
+	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
+	{ .compatible = "mediatek,mt6358", .data = &pmic_mt6358 },
+	{ .compatible = "mediatek,mt6359", .data = &pmic_mt6359 },
+	/* The MT6380 PMIC only implements a regulator, so we bind it
+	 * directly instead of using a MFD.
+	 */
+	{ .compatible = "mediatek,mt6380-regulator", .data = &pmic_mt6380 },
+	{ .compatible = "mediatek,mt6397", .data = &pmic_mt6397 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_slave_match_tbl);
 
@@ -2145,45 +2129,19 @@ static struct pmic_wrapper_type pwrap_mt8186 = {
 };
 
 static const struct of_device_id of_pwrap_match_tbl[] = {
-	{
-		.compatible = "mediatek,mt2701-pwrap",
-		.data = &pwrap_mt2701,
-	}, {
-		.compatible = "mediatek,mt6765-pwrap",
-		.data = &pwrap_mt6765,
-	}, {
-		.compatible = "mediatek,mt6779-pwrap",
-		.data = &pwrap_mt6779,
-	}, {
-		.compatible = "mediatek,mt6797-pwrap",
-		.data = &pwrap_mt6797,
-	}, {
-		.compatible = "mediatek,mt6873-pwrap",
-		.data = &pwrap_mt6873,
-	}, {
-		.compatible = "mediatek,mt7622-pwrap",
-		.data = &pwrap_mt7622,
-	}, {
-		.compatible = "mediatek,mt8135-pwrap",
-		.data = &pwrap_mt8135,
-	}, {
-		.compatible = "mediatek,mt8173-pwrap",
-		.data = &pwrap_mt8173,
-	}, {
-		.compatible = "mediatek,mt8183-pwrap",
-		.data = &pwrap_mt8183,
-	}, {
-		.compatible = "mediatek,mt8186-pwrap",
-		.data = &pwrap_mt8186,
-	}, {
-		.compatible = "mediatek,mt8195-pwrap",
-		.data = &pwrap_mt8195,
-	}, {
-		.compatible = "mediatek,mt8516-pwrap",
-		.data = &pwrap_mt8516,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
+	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
+	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
+	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
+	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
+	{ .compatible = "mediatek,mt7622-pwrap", .data = &pwrap_mt7622 },
+	{ .compatible = "mediatek,mt8135-pwrap", .data = &pwrap_mt8135 },
+	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
+	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
+	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
+	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
+	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
 
-- 
2.35.1

