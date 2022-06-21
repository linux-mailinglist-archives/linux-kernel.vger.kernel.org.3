Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215755291A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiFUBoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiFUBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:44:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB113F39;
        Mon, 20 Jun 2022 18:44:16 -0700 (PDT)
X-UUID: 61d68c7894884a72bc7e99e559836608-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:ff38315d-9a15-4ac3-8ac2-ee06f8f4d028,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:0778952d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 61d68c7894884a72bc7e99e559836608-20220621
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1530686825; Tue, 21 Jun 2022 09:44:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Jun 2022 09:44:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 09:44:08 +0800
Message-ID: <20029878ce6b7bcf9922277cee27e9fc27412907.camel@mediatek.com>
Subject: Re: [PATCH v12 04/14] drm/mediatek: dpi: implement a swap_input
 toggle in SoC config
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 21 Jun 2022 09:44:08 +0800
In-Reply-To: <20220620121028.29234-5-rex-bc.chen@mediatek.com>
References: <20220620121028.29234-1-rex-bc.chen@mediatek.com>
         <20220620121028.29234-5-rex-bc.chen@mediatek.com>
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

Hi, Bo-Chen:

On Mon, 2022-06-20 at 20:10 +0800, Bo-Chen Chen wrote:
> From: Guillaume Ranquet <granquet@baylibre.com>
> 
> The hardware design of dp_intf does not support input swap, so we add
> a bit of flexibility to support SoCs without swap_input support.
> We also add a warning message if the hardware is not supported and it
> needs to swap input.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> [Bo-Chen: Add modification reason in commit message.]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index c88d64889402..5aab3029c54d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -126,6 +126,7 @@ struct mtk_dpi_conf {
>  	const u32 *output_fmts;
>  	u32 num_output_fmts;
>  	bool is_ck_de_pol;
> +	bool swap_input_support;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val,
> u32 mask)
> @@ -390,18 +391,24 @@ static void mtk_dpi_config_color_format(struct
> mtk_dpi *dpi,
>  	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, true);
> -		mtk_dpi_config_swap_input(dpi, false);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_BGR);
>  	} else if ((format == MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
>  		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, true);
>  		mtk_dpi_config_csc_enable(dpi, true);
> -		mtk_dpi_config_swap_input(dpi, true);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, true);
> +		else
> +			dev_warn(dpi->dev,
> +				 "Failed to swap input, hw is not
> supported.\n");
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
>  	} else {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, false);
> -		mtk_dpi_config_swap_input(dpi, false);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
>  	}
>  }
> @@ -813,6 +820,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  };
>  
>  static const struct mtk_dpi_conf mt2701_conf = {
> @@ -823,6 +831,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  };
>  
>  static const struct mtk_dpi_conf mt8183_conf = {
> @@ -832,6 +841,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
>  	.output_fmts = mt8183_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  };
>  
>  static const struct mtk_dpi_conf mt8192_conf = {
> @@ -841,6 +851,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
>  	.output_fmts = mt8183_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  };
>  
>  static int mtk_dpi_probe(struct platform_device *pdev)

