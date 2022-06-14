Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8F54A956
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbiFNGU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348084AbiFNGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:20:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1337A34;
        Mon, 13 Jun 2022 23:20:53 -0700 (PDT)
X-UUID: 583e974db5e54e26bd71afeec4986dd3-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:e558928f-da61-4ed5-8147-07caac326259,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:a7718407-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 583e974db5e54e26bd71afeec4986dd3-20220614
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2144520938; Tue, 14 Jun 2022 14:20:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 14:20:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 14:20:48 +0800
Message-ID: <de65caa980c270e4dedcf134d45185d41cd4c0ae.camel@mediatek.com>
Subject: Re: [PATCH v11 12/12] drm/mediatek: dpi: Add matrix_sel helper
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
Date:   Tue, 14 Jun 2022 14:20:48 +0800
In-Reply-To: <20220613064841.10481-13-rex-bc.chen@mediatek.com>
References: <20220613064841.10481-1-rex-bc.chen@mediatek.com>
         <20220613064841.10481-13-rex-bc.chen@mediatek.com>
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

On Mon, 2022-06-13 at 14:48 +0800, Bo-Chen Chen wrote:
> From: Guillaume Ranquet <granquet@baylibre.com>
> 
> Add a mtk_dpi_matrix_sel() helper to update the DPI_MATRIX_SET
> register depending on the color format.

Why set DPI_MATRIX_SET? New feature or bug fix? What does this matrix
work for?

Regards,
CK

> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 21 +++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 9668bd5dd14a..dc355a512963 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -387,6 +387,25 @@ static void mtk_dpi_config_disable_edge(struct
> mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0,
> EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi, enum
> mtk_dpi_out_color_format format)
> +{
> +	u32 matrix_sel = 0;
> +
> +	switch (format) {
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL:
> +	case MTK_DPI_COLOR_FORMAT_XV_YCC:
> +		if (dpi->mode.hdisplay <= 720)
> +			matrix_sel = 0x2;
> +		break;
> +	default:
> +		break;
> +	}
> +	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel,
> INT_MATRIX_SEL_MASK);
> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format
> format)
>  {
> @@ -394,6 +413,7 @@ static void mtk_dpi_config_color_format(struct
> mtk_dpi *dpi,
>  	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, true);
> +		mtk_dpi_matrix_sel(dpi, format);
>  		if (dpi->conf->swap_input_support)
>  			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_BGR);
> @@ -401,6 +421,7 @@ static void mtk_dpi_config_color_format(struct
> mtk_dpi *dpi,
>  		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, true);
>  		mtk_dpi_config_csc_enable(dpi, true);
> +		mtk_dpi_matrix_sel(dpi, format);
>  		if (dpi->conf->swap_input_support)
>  			mtk_dpi_config_swap_input(dpi, true);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> index f7f0272dbd6a..96c117202d0d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -230,4 +230,7 @@
>  #define EDGE_SEL_EN			BIT(5)
>  #define H_FRE_2N			BIT(25)
>  
> +#define DPI_MATRIX_SET		0xB4
> +#define INT_MATRIX_SEL_MASK	(0x1F << 0)
> +
>  #endif /* __MTK_DPI_REGS_H */

