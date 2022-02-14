Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16174B4007
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiBNDDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:03:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiBNDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:03:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969D50E02;
        Sun, 13 Feb 2022 19:03:38 -0800 (PST)
X-UUID: c752b54efb3e473dbc9dbce78ba4f3a4-20220214
X-UUID: c752b54efb3e473dbc9dbce78ba4f3a4-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1639215548; Mon, 14 Feb 2022 11:03:35 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 11:03:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 11:03:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 11:03:29 +0800
Message-ID: <77feef2c0b8b5523ef0acc342d394f05f6caabb3.camel@mediatek.com>
Subject: Re: [PATCH v3 3/3] pinctrl: canonical rsel resistance selection
 property
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 14 Feb 2022 11:03:29 +0800
In-Reply-To: <8c5cf4b7-dd73-49f6-60dd-b62b3fc3ecdb@collabora.com>
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
         <20220210062122.23974-4-guodong.liu@mediatek.com>
         <8c5cf4b7-dd73-49f6-60dd-b62b3fc3ecdb@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: AngeloGioacchino Del Regno <
angelogioacchino.delregno@collabora.com>
To: Guodong Liu <guodong.liu@mediatek.com>, Linus Walleij <
linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Matthias
Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 3/3] pinctrl: canonical rsel resistance
selection property
Date: Thu, 10 Feb 2022 09:50:45 +0100

Il 10/02/22 07:21, Guodong Liu ha scritto:
> Change "mediatek,rsel_resistance_in_si_unit" to "mediatek,rsel-
> resistance-in-si-unit"
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Hello Guodong,
thanks for the patch!

However, you forgot to add the required Fixes tag to this one; this
patch
should be fixing fb34a9ae383a ("pinctrl: mediatek: support rsel
feature").

Please add the required tag.

Thanks,
Angelo

Hi Angelo

We will update it for next version.

Thanks
Guodong
> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c
> b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index d4e02c5d74a8..38c0f0c4cf95 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -989,7 +989,7 @@ int mtk_paris_pinctrl_probe(struct
> platform_device *pdev,
>   	hw->nbase = hw->soc->nbase_names;
>   
>   	if (of_find_property(hw->dev->of_node,
> -			     "mediatek,rsel_resistance_in_si_unit",
> NULL))
> +			     "mediatek,rsel-resistance-in-si-unit",
> NULL))
>   		hw->rsel_si_unit = true;
>   	else
>   		hw->rsel_si_unit = false;
> 






