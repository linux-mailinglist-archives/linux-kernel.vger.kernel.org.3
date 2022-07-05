Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591A5661FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiGEDtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGEDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:49:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4C10FEB;
        Mon,  4 Jul 2022 20:49:40 -0700 (PDT)
X-UUID: 2a6831c38c2a41b8a51a4984f1fa66c4-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:024001bc-b4c3-4759-b139-709d77edd7ca,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:fa2e6b63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 2a6831c38c2a41b8a51a4984f1fa66c4-20220705
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 650608357; Tue, 05 Jul 2022 11:49:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 5 Jul 2022 11:49:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 5 Jul 2022 11:49:33 +0800
Message-ID: <7847ac7e438d8c8544d88c960eca3af00d5f3520.camel@mediatek.com>
Subject: Re: [PATCH v15 05/16] drm/mediatek: dpi: Add support for
 quantization range
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <xinlei.lee@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 5 Jul 2022 11:49:33 +0800
In-Reply-To: <20220701035845.16458-6-rex-bc.chen@mediatek.com>
References: <20220701035845.16458-1-rex-bc.chen@mediatek.com>
         <20220701035845.16458-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Fri, 2022-07-01 at 11:58 +0800, Bo-Chen Chen wrote:
> For RGB colorimetry, CTA-861 support both limited and full range data
> when receiving video with RGB color space.
> We use drm_default_rgb_quant_range() to determine the correct
> setting.

Applied to mediatek-drm-next [1], thanks.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/?h=mediatek-drm-next

Regards,
CK

> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 34 ++++++++++++++++++--------
> ----
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 3473ee18ad97..0855bbdfe4e1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -238,16 +238,30 @@ static void mtk_dpi_config_fb_size(struct
> mtk_dpi *dpi, u32 width, u32 height)
>  	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
>  }
>  
> -static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi,
> -					 struct mtk_dpi_yc_limit
> *limit)
> +static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
>  {
> -	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
> +	struct mtk_dpi_yc_limit limit;
> +
> +	if (drm_default_rgb_quant_range(&dpi->mode) ==
> +	    HDMI_QUANTIZATION_RANGE_LIMITED) {
> +		limit.y_bottom = 0x10;
> +		limit.y_top = 0xfe0;
> +		limit.c_bottom = 0x10;
> +		limit.c_top = 0xfe0;
> +	} else {
> +		limit.y_bottom = 0;
> +		limit.y_top = 0xfff;
> +		limit.c_bottom = 0;
> +		limit.c_top = 0xfff;
> +	}
> +
> +	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_bottom << Y_LIMINT_BOT,
>  		     Y_LIMINT_BOT_MASK);
> -	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
> +	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_top << Y_LIMINT_TOP,
>  		     Y_LIMINT_TOP_MASK);
> -	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_bottom << C_LIMIT_BOT,
> +	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_bottom << C_LIMIT_BOT,
>  		     C_LIMIT_BOT_MASK);
> -	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_top << C_LIMIT_TOP,
> +	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_top << C_LIMIT_TOP,
>  		     C_LIMIT_TOP_MASK);
>  }
>  
> @@ -439,7 +453,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  				    struct drm_display_mode *mode)
>  {
> -	struct mtk_dpi_yc_limit limit;
>  	struct mtk_dpi_polarities dpi_pol;
>  	struct mtk_dpi_sync_param hsync;
>  	struct mtk_dpi_sync_param vsync_lodd = { 0 };
> @@ -474,11 +487,6 @@ static int mtk_dpi_set_display_mode(struct
> mtk_dpi *dpi,
>  	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
>  		pll_rate, vm.pixelclock);
>  
> -	limit.c_bottom = 0x0010;
> -	limit.c_top = 0x0FE0;
> -	limit.y_bottom = 0x0010;
> -	limit.y_top = 0x0FE0;
> -
>  	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
>  	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
>  	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
> @@ -526,7 +534,7 @@ static int mtk_dpi_set_display_mode(struct
> mtk_dpi *dpi,
>  	else
>  		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
>  
> -	mtk_dpi_config_channel_limit(dpi, &limit);
> +	mtk_dpi_config_channel_limit(dpi);
>  	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
>  	mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
>  	mtk_dpi_config_yc_map(dpi, dpi->yc_map);

