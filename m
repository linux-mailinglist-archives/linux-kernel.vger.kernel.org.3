Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F050F554B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiFVNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiFVNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:31:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD2616F;
        Wed, 22 Jun 2022 06:31:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A94566017B3;
        Wed, 22 Jun 2022 14:31:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655904714;
        bh=GXPW8eVZucPlabvBsj1O4A8AjaBWiHsVboTbgSoHxTA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JLPoC68GILDBMexQ17xPftwnfPgsXyisoN95ynJ5FFvZ+KnXtDVl1tkBCMu3nCIBo
         P6SL0TVSKYV4VXFrD0QpYfYby2tCFSYtk/UiqurbS6d7G0WyJs25/jfhx+8MJ4EkN8
         qKOLW/e6wDmsD1bfuViqWlt74K6dddUmyNxHdn+k5ORYLSZ4ZgJreaFdXtN/sU3oOA
         ZAqyNQk08cdyUHIlbc6XOJwe8KbGEjjo8mZey708+TwvoFmLh64g2N0qDY4iZJ3dwV
         TMC3FHkgOpsxy1NXG94K46X00EEHmc8P6HqnE3pzwBBbINCy80z5931SXOm8I4Vyfa
         Eo71nviG5ZSXQ==
Message-ID: <26854a9b-09c2-c14e-eabe-cfc574d6012e@collabora.com>
Date:   Wed, 22 Jun 2022 15:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc: mediatek: mutex: add suffix 0 to
 DDP_COMPONENT_DITHER for mt8395
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220622131952.29583-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220622131952.29583-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/06/22 15:19, Jason-JH.Lin ha scritto:
> Add suffix 0 to DDP_COMPONENT_DITHER for mt8395.
> 
> Fixes: 141311b856d8 ("soc: mediatek: mutex: add MT8365 support")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>


Hello Jason-JH,

you must've missed my commit, sent two days ago, which is doing the same:

https://lore.kernel.org/lkml/20220620102454.131417-1-angelogioacchino.delregno@collabora.com/T/#u

Anyway, I have avoided to rename the definition, as from what I understand
MT8365 has only one dither mod and that's called "DITHER", not "DITHER0"...
...but I've added the suffix to the array assignment, as that's what we have
in the enumeration.

I think that #define MT8365_MUTEX_MOD_DISP_DITHER should be kept as-is.

Also... this commit is not fixing anything, as it was already working before,
so the Fixes tag shouldn't be present.

Regards,
Angelo

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index fa8e0ba38803..3b25fd6b91aa 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -130,7 +130,7 @@
>   #define MT8365_MUTEX_MOD_DISP_CCORR		13
>   #define MT8365_MUTEX_MOD_DISP_AAL		14
>   #define MT8365_MUTEX_MOD_DISP_GAMMA		15
> -#define MT8365_MUTEX_MOD_DISP_DITHER		16
> +#define MT8365_MUTEX_MOD_DISP_DITHER0		16
>   #define MT8365_MUTEX_MOD_DISP_DSI0		17
>   #define MT8365_MUTEX_MOD_DISP_PWM0		20
>   #define MT8365_MUTEX_MOD_DISP_DPI0		22
> @@ -358,7 +358,7 @@ static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>   	[DDP_COMPONENT_AAL0] = MT8365_MUTEX_MOD_DISP_AAL,
>   	[DDP_COMPONENT_CCORR] = MT8365_MUTEX_MOD_DISP_CCORR,
>   	[DDP_COMPONENT_COLOR0] = MT8365_MUTEX_MOD_DISP_COLOR0,
> -	[DDP_COMPONENT_DITHER] = MT8365_MUTEX_MOD_DISP_DITHER,
> +	[DDP_COMPONENT_DITHER0] = MT8365_MUTEX_MOD_DISP_DITHER0,
>   	[DDP_COMPONENT_DPI0] = MT8365_MUTEX_MOD_DISP_DPI0,
>   	[DDP_COMPONENT_DSI0] = MT8365_MUTEX_MOD_DISP_DSI0,
>   	[DDP_COMPONENT_GAMMA] = MT8365_MUTEX_MOD_DISP_GAMMA,


