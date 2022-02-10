Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574AA4B08D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiBJIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:50:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiBJIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:50:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC17C2A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:50:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5A7BB1F45F95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644483049;
        bh=QB8v1TZ46BYQxibDWegAgbUNsBvd0WdJQaG+Wn+uyBY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fNQBfk80LkkNCaIMaWvxNI/HF+K/sMgLrX9ou1kchJKZOJljSkL0AsJuYT5tGPAmL
         Iv2lToQSBybMGoJe7oovnIuHB9tXIX0vtPJKOPuPd7G++oUy8eGWBC/vaqeW2oyHy6
         pmJmj3Tps/xUUR1NLYDBQzUgfdLrS7B56eEFv+Tqm4HL3U2NEgh1l5eVdZLhSDENkW
         Aj9DMPe5PPI3MLFjiihFXz+g+zipEmbHIuuu7vI/KkhZT83JXKFJ8MRHrS/Sp4WaIT
         qiMMZluWNYNwbki6cYzdJ5PgEYR0XHhn4tX222wGmcs5/hfCYQQhegJAEplZCDZitf
         a02NxyvkdrWOg==
Message-ID: <8c5cf4b7-dd73-49f6-60dd-b62b3fc3ecdb@collabora.com>
Date:   Thu, 10 Feb 2022 09:50:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 3/3] pinctrl: canonical rsel resistance selection
 property
Content-Language: en-US
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
 <20220210062122.23974-4-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210062122.23974-4-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/22 07:21, Guodong Liu ha scritto:
> Change "mediatek,rsel_resistance_in_si_unit" to "mediatek,rsel-resistance-in-si-unit"
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Hello Guodong,
thanks for the patch!

However, you forgot to add the required Fixes tag to this one; this patch
should be fixing fb34a9ae383a ("pinctrl: mediatek: support rsel feature").

Please add the required tag.

Thanks,
Angelo

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index d4e02c5d74a8..38c0f0c4cf95 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -989,7 +989,7 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
>   	hw->nbase = hw->soc->nbase_names;
>   
>   	if (of_find_property(hw->dev->of_node,
> -			     "mediatek,rsel_resistance_in_si_unit", NULL))
> +			     "mediatek,rsel-resistance-in-si-unit", NULL))
>   		hw->rsel_si_unit = true;
>   	else
>   		hw->rsel_si_unit = false;
> 



