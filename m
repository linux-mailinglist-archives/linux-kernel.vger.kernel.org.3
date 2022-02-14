Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC44B4C54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiBNKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:40:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiBNKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F96715B8;
        Mon, 14 Feb 2022 02:02:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1E7051F43053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644832956;
        bh=EZtxgxaV8/I+n1d7kbiGccMyE4bZCHZgIhArtvVlxB4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=htFbV/VNcgY4e6NmjbTgWCT0U8vZZXgz2EkFHdw5T7VYpUSU/xek0vZEQ8ZV9UFQO
         Qx3ahY8d7vxDW3H0k4fBsj1X070vtiA5LoDwnQN2JMeAr4j1v8S/wUkCopc4LTqkX8
         c/ZKYxcnJLgjFbnF3R027FjtRqM5nhPH+SnY3ic7mN7X/BqlYsrJVLUQmrM31GIB0I
         PYfrNvgMjWw4gmBmzwVBibGvDRRhWjA1EqE3dRYHEhoK2U9DDpKwKWtt+T3ifVqWIq
         6g50M5CWKaxFaAwnMUe3CRfkFxGQ2v/BHquLmIwyODtbFc8X0I4nX0Bvizjx9biB6w
         SGzfEywYKl8KQ==
Message-ID: <c9ab3f7c-9b12-0c51-3de2-4abf42cdfb74@collabora.com>
Date:   Mon, 14 Feb 2022 11:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 3/3] pinctrl: canonical rsel resistance selection
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
References: <20220214030631.4969-1-guodong.liu@mediatek.com>
 <20220214030631.4969-4-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220214030631.4969-4-guodong.liu@mediatek.com>
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

Il 14/02/22 04:06, Guodong Liu ha scritto:
> Change "mediatek,rsel_resistance_in_si_unit" to
> "mediatek,rsel-resistance-in-si-unit"
> 
> Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

A note for maintainers: luckily, this property hasn't been used in any device-tree
yet, so we luckily (since naming convention was not compliant) don't have to worry
about retro-compatibility for old DTs; so...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

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

