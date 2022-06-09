Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35AF545417
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbiFISZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiFISZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:25:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9597144782;
        Thu,  9 Jun 2022 11:25:45 -0700 (PDT)
Received: from notapiano (unknown [169.150.201.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34BE266017A8;
        Thu,  9 Jun 2022 19:25:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654799144;
        bh=wjYwbyy4txNdLBUZYKXoH1LINavwCoVlNaaWI8BLCAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3X604uAwDGo1mcYXm1Peo7/dNqEnhkV2oWvy8T8SZEadRJhtWLJbHclNkl61Vr+n
         PL4RaC7q2vzIqM1hL+DJ5aWo9oRSvDgfcdv9ThWyuMghbfzudQkHIg3eXAvIFYEDRh
         DtCVaiprK/t3xRctX6/Yd2wU1bCCPnEQ7gNT93mlXaHM4fauVKI4a6RKnvpaA9Ssdy
         giKgCZs+OJ8FsnnTBd18RLqgoimezvQ8A4XYleCsmg9IVdYrfz53/WSUHvnYZgz1Yv
         yktvQM9qr0zRzF/zVrSMQCJZKNppxa6FEN3+fiSrTlyq/AXD0wkNHL6GWnKLhKVIKK
         8AJJu9HWZ/ktA==
Date:   Thu, 9 Jun 2022 14:25:37 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 2/4] pinctrl: add drive for I2C related pins on mt8192
Message-ID: <20220609182537.zbqk7gqsyscayv7b@notapiano>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
 <20220608053909.1252-3-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608053909.1252-3-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

thank you for the patch. Please see some suggestions below.

On Wed, Jun 08, 2022 at 01:39:07PM +0800, Guodong Liu wrote:
> This patch provides the advanced drive raw data setting version
> for I2C used pins on mt8192

Please add "mediatek:" on the commit title for this patch and patch 1, like you
did for 3 and 4.

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 31 +++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index 9faf7001369d..d11ff5519e1e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> @@ -1259,6 +1259,32 @@ static const struct mtk_pin_field_calc mt8192_pin_r1_range[] = {
>  	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 5, 1),
>  };
>  
> +static const struct mtk_pin_field_calc mt8192_pin_drv_adv_range[] = {
> +	PIN_FIELD_BASE(89, 89, 2, 0x0040, 0x10, 0, 5),
> +	PIN_FIELD_BASE(90, 90, 2, 0x0040, 0x10, 5, 5),
> +
> +	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 0, 3),
> +	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 18, 3),
> +	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 15, 3),
> +	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 3, 3),
> +	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 12, 3),
> +	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 0, 3),
> +	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 9, 3),
> +	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 27, 3),
> +	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 6, 3),
> +	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 24, 3),
> +	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 3, 3),
> +	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 21, 3),
> +	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 0, 3),
> +	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 3, 3),
> +	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 3, 3),
> +	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 9, 3),
> +	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 0, 3),
> +	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 3, 3),
> +	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 0, 3),
> +	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 6, 3),
> +};
> +
>  static const struct mtk_pin_field_calc mt8192_pin_e1e0en_range[] = {
>  	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 0, 1),
>  	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 18, 1),
> @@ -1357,6 +1383,7 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
>  	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8192_pin_r1_range),
>  	[PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8192_pin_e1e0en_range),
>  	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8192_pin_e0_range),
> +	[PINCTRL_PIN_REG_DRV_ADV]	= MTK_RANGE(mt8192_pin_drv_adv_range),

Nit: use space instead of tab before the =.

Thanks,
Nícolas

>  	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8192_pin_e1_range),
>  };
>  
> @@ -1376,8 +1403,8 @@ static const struct mtk_pin_soc mt8192_data = {
>  	.drive_get	= mtk_pinconf_drive_get_rev1,
>  	.adv_pull_get = mtk_pinconf_adv_pull_get,
>  	.adv_pull_set = mtk_pinconf_adv_pull_set,
> -	.adv_drive_get = mtk_pinconf_adv_drive_get,
> -	.adv_drive_set = mtk_pinconf_adv_drive_set,
> +	.adv_drive_get	= mtk_pinconf_adv_drive_get_raw,
> +	.adv_drive_set	= mtk_pinconf_adv_drive_set_raw,
>  };
>  
>  static const struct of_device_id mt8192_pinctrl_of_match[] = {
> -- 
> 2.25.5
> 
