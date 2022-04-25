Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71950DA26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiDYHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiDYHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:34:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D746BF4D;
        Mon, 25 Apr 2022 00:31:14 -0700 (PDT)
X-UUID: 6af38d5ae7974373884764c4e35798f6-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0d139e3b-a55a-4be2-9d40-579c688deee9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:650500f0-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 6af38d5ae7974373884764c4e35798f6-20220425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572274440; Mon, 25 Apr 2022 15:31:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Apr 2022 15:31:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 15:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 15:30:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <allen-kh.cheng@mediatek.com>, <chun-jie.chen@mediatek.com>,
        <ikjn@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <weiyi.lu@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: Delete MT8192 msdc gate
Date:   Mon, 25 Apr 2022 15:30:54 +0800
Message-ID: <20220425073054.1391-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422143756.14806-1-matthias.bgg@kernel.org>
References: <20220422143756.14806-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

>The msdc gate is part of the MMC driver. Delete the not used code.
>
>Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>---
> drivers/clk/mediatek/clk-mt8192-msdc.c | 21 ---------------------
> 1 file changed, 21 deletions(-)
>
>diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
>index 87c3b79b79cf..635f7a0b629a 100644
>--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
>+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
>@@ -12,28 +12,15 @@
> 
> #include <dt-bindings/clock/mt8192-clk.h>
> 
>-static const struct mtk_gate_regs msdc_cg_regs = {
>-	.set_ofs = 0xb4,
>-	.clr_ofs = 0xb4,
>-	.sta_ofs = 0xb4,
>-};
>-
> static const struct mtk_gate_regs msdc_top_cg_regs = {
> 	.set_ofs = 0x0,
> 	.clr_ofs = 0x0,
> 	.sta_ofs = 0x0,
> };
> 
>-#define GATE_MSDC(_id, _name, _parent, _shift)	\
>-	GATE_MTK(_id, _name, _parent, &msdc_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
>-
> #define GATE_MSDC_TOP(_id, _name, _parent, _shift)	\
> 	GATE_MTK(_id, _name, _parent, &msdc_top_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> 
>-static const struct mtk_gate msdc_clks[] = {
>-	GATE_MSDC(CLK_MSDC_AXI_WRAP, "msdc_axi_wrap", "axi_sel", 22),
>-};
>-
> static const struct mtk_gate msdc_top_clks[] = {
> 	GATE_MSDC_TOP(CLK_MSDC_TOP_AES_0P, "msdc_top_aes_0p", "aes_msdcfde_sel", 0),
> 	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_0P, "msdc_top_src_0p", "infra_msdc0_src", 1),
>@@ -52,11 +39,6 @@ static const struct mtk_gate msdc_top_clks[] = {
> 	GATE_MSDC_TOP(CLK_MSDC_TOP_AHB2AXI_BRG_AXI, "msdc_top_ahb2axi_brg_axi", "axi_sel", 14),
> };
> 
>-static const struct mtk_clk_desc msdc_desc = {
>-	.clks = msdc_clks,
>-	.num_clks = ARRAY_SIZE(msdc_clks),
>-};
>-
> static const struct mtk_clk_desc msdc_top_desc = {
> 	.clks = msdc_top_clks,
> 	.num_clks = ARRAY_SIZE(msdc_top_clks),
>@@ -64,9 +46,6 @@ static const struct mtk_clk_desc msdc_top_desc = {
> 
> static const struct of_device_id of_match_clk_mt8192_msdc[] = {
> 	{
>-		.compatible = "mediatek,mt8192-msdc",
>-		.data = &msdc_desc,
>-	}, {

grep '"mediatek,mt8192-msdc"' * -RnH
arch/arm64/boot/dts/mediatek/mt8192.dtsi:868:                   compatible = "mediatek,mt8192-msdc";
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml:112:        compatible = "mediatek,mt8192-msdc";
drivers/clk/mediatek/clk-mt8192-msdc.c:67:              .compatible = "mediatek,mt8192-msdc",

I am wondering that in this case, should we have also modify the bindings document
(mediatek,mt8192-clock.yaml)?


thanks,
Miles

> 		.compatible = "mediatek,mt8192-msdc_top",
> 		.data = &msdc_top_desc,
> 	}, {
>-- 
>2.34.1
