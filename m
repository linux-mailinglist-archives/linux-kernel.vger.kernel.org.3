Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5C527D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiEPFnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiEPFnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:43:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD7DF76;
        Sun, 15 May 2022 22:43:07 -0700 (PDT)
X-UUID: 074eb6915b3c406aa043d7378e4a2c00-20220516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:26e03723-d3a7-41b9-bcb0-ec5d52cd0861,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:a84b5df2-ab23-4aed-a67b-f96514452486,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 074eb6915b3c406aa043d7378e4a2c00-20220516
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1874855302; Mon, 16 May 2022 13:43:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 May 2022 13:43:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 16 May 2022 13:43:01 +0800
Message-ID: <7c996c665a57fdd9ba8d6df4dc085f70afc1b933.camel@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mmsys: Add support for MT6795 Helio
 X10
From:   CK Hu <ck.hu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>,
        <kernel@collabora.com>
Date:   Mon, 16 May 2022 13:43:01 +0800
In-Reply-To: <20220513170350.502501-1-angelogioacchino.delregno@collabora.com>
References: <20220513170350.502501-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

On Fri, 2022-05-13 at 19:03 +0200, AngeloGioacchino Del Regno wrote:
> Add MM support for the MT6795 SoC, using the mmsys default routing
> table.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
> 
> In order for this patch to have any meaning and functionality, it is
> required to also have in-tree the [1] MT6795 clocks series, even
> though that's not required to actually compile this code.
> 
> [1] 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=641493__;!!CTRNKA9wMg0ARbw!ywDb_Gj4oV0iYHK_PbtJSNejzsJGlFVjX-1O0G1mR0vZX_5VeMtlZJ_AS6K_Mg$
>  
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> b/drivers/soc/mediatek/mtk-mmsys.c
> index 06d8e83a2cb5..38b36b881a3b 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -57,6 +57,13 @@ static const struct mtk_mmsys_match_data
> mt6779_mmsys_match_data = {
>  	},
>  };
>  
> +static const struct mtk_mmsys_driver_data mt6795_mmsys_driver_data =
> {
> +	.clk_driver = "clk-mt6795-mm",
> +	.routes = mmsys_default_routing_table,

mt6795 should have its own routing table instead of default one. The
default one is used for mt8173, mt2701, mt2712 which no one knows how
to separate them. If you don't know the routing table of mt6795, just
left this as NULL.

Regards,
CK

> +	.num_routes = ARRAY_SIZE(mmsys_default_routing_table),
> +	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data =
> {
>  	.clk_driver = "clk-mt6797-mm",
>  };
> @@ -363,6 +370,10 @@ static const struct of_device_id
> of_match_mtk_mmsys[] = {
>  		.compatible = "mediatek,mt6779-mmsys",
>  		.data = &mt6779_mmsys_match_data,
>  	},
> +	{
> +		.compatible = "mediatek,mt6795-mmsys",
> +		.data = &mt6795_mmsys_driver_data,
> +	},
>  	{
>  		.compatible = "mediatek,mt6797-mmsys",
>  		.data = &mt6797_mmsys_match_data,

