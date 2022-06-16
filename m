Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66854DB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358908AbiFPHMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358853AbiFPHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:12:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F5F51;
        Thu, 16 Jun 2022 00:12:34 -0700 (PDT)
X-UUID: 450dc388895640b8bb5be844d54c3dc1-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:e5f7ed83-ef2d-4e55-a1e2-0bd5cfe595ce,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:e5f7ed83-ef2d-4e55-a1e2-0bd5cfe595ce,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:765873f6-e099-41ba-a32c-13b8bfe63214,C
        OID:91b86b891a75,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 450dc388895640b8bb5be844d54c3dc1-20220616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 481259333; Thu, 16 Jun 2022 15:12:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 15:12:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 15:12:28 +0800
Message-ID: <3de597c1ab963cc8f6dd89da089c6f0660517f34.camel@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: clk-mt8195-vdo0: Set rate on
 vdo0_dp_intf0_dp_intf's parent
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "Miles Chen =?UTF-8?Q?=28=E9=99=B3=E6=B0=91=E6=A8=BA=29?=" 
        <Miles.Chen@mediatek.com>,
        "chun-jie.chen@mediatek.com" <chun-jie.chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <jitao.shi@mediatek.com>, <mandyjh.liu@mediatek.com>
Date:   Thu, 16 Jun 2022 15:12:28 +0800
In-Reply-To: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
References: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 17:10 +0800, AngeloGioacchino Del Regno wrote:
> Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
> clock: this is required to trigger clock source selection on
> CLK_TOP_EDP, while avoiding to manage the enablement of the former
> separately from the latter in the displayport driver.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c
> b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> index 261a7f76dd3c..07b46bfd5040 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> @@ -37,6 +37,10 @@ static const struct mtk_gate_regs vdo0_2_cg_regs =
> {
>  #define GATE_VDO0_2(_id, _name, _parent, _shift)			
> \
>  	GATE_MTK(_id, _name, _parent, &vdo0_2_cg_regs, _shift,
> &mtk_clk_gate_ops_setclr)
>  
> +#define GATE_VDO0_2_FLAGS(_id, _name, _parent, _shift, _flags)	
> 	\
> +	GATE_MTK_FLAGS(_id, _name, _parent, &vdo0_2_cg_regs, _shift,	
> \
> +		       &mtk_clk_gate_ops_setclr, _flags)
> +
>  static const struct mtk_gate vdo0_clks[] = {
>  	/* VDO0_0 */
>  	GATE_VDO0_0(CLK_VDO0_DISP_OVL0, "vdo0_disp_ovl0", "top_vpp",
> 0),
> @@ -85,7 +89,8 @@ static const struct mtk_gate vdo0_clks[] = {
>  	/* VDO0_2 */
>  	GATE_VDO0_2(CLK_VDO0_DSI0_DSI, "vdo0_dsi0_dsi", "top_dsi_occ",
> 0),
>  	GATE_VDO0_2(CLK_VDO0_DSI1_DSI, "vdo0_dsi1_dsi", "top_dsi_occ",
> 8),
> -	GATE_VDO0_2(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf",
> "top_edp", 16),
> +	GATE_VDO0_2_FLAGS(CLK_VDO0_DP_INTF0_DP_INTF,
> "vdo0_dp_intf0_dp_intf",
> +			  "top_edp", 16, CLK_SET_RATE_PARENT),
>  };
>  
>  static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
> -- 
> 2.35.1
> 

Hello Angelo,

Thanks for this patch.
Another dp clock should also be fix.
After confirming with Jitao who is our dp expert.
The parent of CLK_VDO1_DPINTF should be top_dp instead of top_vpp.

Thanks!

--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -43,6 +43,9 @@ static const struct mtk_gate_regs vdo1_3_cg_regs = {
 #define GATE_VDO1_2(_id, _name, _parent,
_shift)                       \
        GATE_MTK(_id, _name, _parent, &vdo1_2_cg_regs, _shift,
&mtk_clk_gate_ops_setclr)

+#define GATE_VDO1_2_FLAGS(_id, _name, _parent, _shift,
_flags)                 \
+       GATE_MTK_FLAGS(_id, _name, _parent, &vdo1_2_cg_regs, _shift,
&mtk_clk_gate_ops_setclr, _flags)
+
 #define GATE_VDO1_3(_id, _name, _parent,
_shift)                       \
        GATE_MTK(_id, _name, _parent, &vdo1_3_cg_regs, _shift,
&mtk_clk_gate_ops_setclr)

@@ -99,7 +102,7 @@ static const struct mtk_gate vdo1_clks[] = {
        GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI0,
"vdo1_disp_monitor_dpi0", "top_vpp", 1),
        GATE_VDO1_2(CLK_VDO1_DPI1, "vdo1_dpi1", "top_vpp", 8),
        GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI1,
"vdo1_disp_monitor_dpi1", "top_vpp", 9),
-       GATE_VDO1_2(CLK_VDO1_DPINTF, "vdo1_dpintf", "top_vpp", 16),
+       GATE_VDO1_2_FLAGS(CLK_VDO1_DPINTF, "vdo1_dpintf", "top_dp", 16,
CLK_SET_RATE_PARENT),

BRs,
Bo-Chen

