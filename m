Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6E559A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiFXNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiFXNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:41:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87E2B19E;
        Fri, 24 Jun 2022 06:41:41 -0700 (PDT)
X-UUID: 5d65dbfd7b5c4d098b06a06e00eb90c3-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:585eb436-6609-450d-9a28-3f294052cda8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:780070ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:1,File:ni
        l,QS:nil,BEC:nil,COL:0
X-UUID: 5d65dbfd7b5c4d098b06a06e00eb90c3-20220624
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 827207606; Fri, 24 Jun 2022 21:41:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 21:41:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 21:41:35 +0800
Message-ID: <e2f9f60f2ab7a18e9326845a95ccea28a02c39a9.camel@mediatek.com>
Subject: Re: [PATCH v1 2/4] pinctrl: add drive for I2C related pins on mt8192
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Jun 2022 21:41:35 +0800
In-Reply-To: <20220609182537.zbqk7gqsyscayv7b@notapiano>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
         <20220608053909.1252-3-guodong.liu@mediatek.com>
         <20220609182537.zbqk7gqsyscayv7b@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <
robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sean
Wang <sean.wang@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
Zhiyong Tao <zhiyong.tao@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 2/4] pinctrl: add drive for I2C related pins on
mt8192
Date: Thu, 9 Jun 2022 14:25:37 -0400

Hi Guodong,

thank you for the patch. Please see some suggestions below.

On Wed, Jun 08, 2022 at 01:39:07PM +0800, Guodong Liu wrote:
> This patch provides the advanced drive raw data setting version
> for I2C used pins on mt8192

Please add "mediatek:" on the commit title for this patch and patch 1,
like you
did for 3 and 4.

will fix it in next version,thanks!
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 31
> +++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index 9faf7001369d..d11ff5519e1e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> @@ -1259,6 +1259,32 @@ static const struct mtk_pin_field_calc
> mt8192_pin_r1_range[] = {
>  	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 5, 1),
>  };
>  
> +static const struct mtk_pin_field_calc mt8192_pin_drv_adv_range[] =
> {
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
> @@ -1357,6 +1383,7 @@ static const struct mtk_pin_reg_calc
> mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
>  	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8192_pin_r1_range),
>  	[PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8192_pin_e1e0en_range),
>  	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8192_pin_e0_range),
> +	[PINCTRL_PIN_REG_DRV_ADV]	=
> MTK_RANGE(mt8192_pin_drv_adv_range),

Nit: use space instead of tab before the =.

will fix it in next version,thanks!

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

