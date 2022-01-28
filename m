Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3249F2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiA1FKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:10:06 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36428 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229504AbiA1FKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:10:05 -0500
X-UUID: acabda73893149d0abc8c6c3184289fb-20220128
X-UUID: acabda73893149d0abc8c6c3184289fb-20220128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1918095979; Fri, 28 Jan 2022 13:10:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 28 Jan 2022 13:10:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 13:10:00 +0800
Message-ID: <2a5d1498b29f4cf74160e1881e530f34cd69e263.camel@mediatek.com>
Subject: Re: [v1,2/3] drm/mediatek: Add mt8186 dsi compatible to mtk_dsi.c
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <jitao.shi@mediatek.com>
Date:   Fri, 28 Jan 2022 13:10:00 +0800
In-Reply-To: <1643283773-7081-3-git-send-email-xinlei.lee@mediatek.com>
References: <1643283773-7081-1-git-send-email-xinlei.lee@mediatek.com>
         <1643283773-7081-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xinlei:

On Thu, 2022-01-27 at 19:42 +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add the compatible of mt8186-dsi because we use different cmdq
> addresses in mt8186.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index e91b3ff..62af60d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1151,6 +1151,12 @@ static const struct mtk_dsi_driver_data
> mt8183_dsi_driver_data = {
>  	.has_size_ctl = true,
>  };
>  
> +static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
> +	.reg_cmdq_off = 0xd00,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-dsi",
>  	  .data = &mt2701_dsi_driver_data },
> @@ -1158,6 +1164,8 @@ static const struct of_device_id
> mtk_dsi_of_match[] = {
>  	  .data = &mt8173_dsi_driver_data },
>  	{ .compatible = "mediatek,mt8183-dsi",
>  	  .data = &mt8183_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8186-dsi",
> +	  .data = &mt8186_dsi_driver_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);

