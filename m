Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904E530DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiEWKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiEWKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DA403E8;
        Mon, 23 May 2022 03:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB9E611CA;
        Mon, 23 May 2022 10:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A984C385A9;
        Mon, 23 May 2022 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653301434;
        bh=y+sP4vTc6GXPb2q2jeON7sbrRR8FJJVBeRF9X7Rz+Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMA00BlSIzMMi7wqj/fmwy8D9Uf5fSJz66AOEWfc6ECF219ZDuqs5y4UyrFMWJGpt
         bUq3+P4EZPrgf4v/7s/bwWxDaXoXZRBG6XzR5ngvrN6RvFIMSB35cxj6leENtOInIQ
         4/I30rTjMIt8QCi4sAkpJUsk0ZMTurXC+wuF4HxtX6pEXUDHqChF3+LdDO3d0mxfao
         X1SFFs1RFIpIVhdrQB/Hhue0tMXZVI0ieCvqy8soIDAbkkOexpW/VAHhXITWzwQkK3
         vkGWI089NJVKGFfKVRfhlcgBObeBawSRcnzcQDFBTae+h13N4A5oj7K2sWgi9G7bkv
         sc7bGflnzCPWw==
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 2/2] clk: mediatek: Delete MT8192 msdc gate
Date:   Mon, 23 May 2022 12:23:39 +0200
Message-Id: <20220523102339.21927-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220523102339.21927-1-matthias.bgg@kernel.org>
References: <20220523102339.21927-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The msdc gate is part of the MMC driver. Delete the not used code.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>

---

Changes in v3:
- add Reviewed-by tag

Changes in v2:
- add Reviewed-by tag

 drivers/clk/mediatek/clk-mt8192-msdc.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 87c3b79b79cf..635f7a0b629a 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -12,28 +12,15 @@
 
 #include <dt-bindings/clock/mt8192-clk.h>
 
-static const struct mtk_gate_regs msdc_cg_regs = {
-	.set_ofs = 0xb4,
-	.clr_ofs = 0xb4,
-	.sta_ofs = 0xb4,
-};
-
 static const struct mtk_gate_regs msdc_top_cg_regs = {
 	.set_ofs = 0x0,
 	.clr_ofs = 0x0,
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MSDC(_id, _name, _parent, _shift)	\
-	GATE_MTK(_id, _name, _parent, &msdc_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
-
 #define GATE_MSDC_TOP(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &msdc_top_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
-static const struct mtk_gate msdc_clks[] = {
-	GATE_MSDC(CLK_MSDC_AXI_WRAP, "msdc_axi_wrap", "axi_sel", 22),
-};
-
 static const struct mtk_gate msdc_top_clks[] = {
 	GATE_MSDC_TOP(CLK_MSDC_TOP_AES_0P, "msdc_top_aes_0p", "aes_msdcfde_sel", 0),
 	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_0P, "msdc_top_src_0p", "infra_msdc0_src", 1),
@@ -52,11 +39,6 @@ static const struct mtk_gate msdc_top_clks[] = {
 	GATE_MSDC_TOP(CLK_MSDC_TOP_AHB2AXI_BRG_AXI, "msdc_top_ahb2axi_brg_axi", "axi_sel", 14),
 };
 
-static const struct mtk_clk_desc msdc_desc = {
-	.clks = msdc_clks,
-	.num_clks = ARRAY_SIZE(msdc_clks),
-};
-
 static const struct mtk_clk_desc msdc_top_desc = {
 	.clks = msdc_top_clks,
 	.num_clks = ARRAY_SIZE(msdc_top_clks),
@@ -64,9 +46,6 @@ static const struct mtk_clk_desc msdc_top_desc = {
 
 static const struct of_device_id of_match_clk_mt8192_msdc[] = {
 	{
-		.compatible = "mediatek,mt8192-msdc",
-		.data = &msdc_desc,
-	}, {
 		.compatible = "mediatek,mt8192-msdc_top",
 		.data = &msdc_top_desc,
 	}, {
-- 
2.36.0

