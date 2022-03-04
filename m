Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04754CD3F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiCDMGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiCDMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:05:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2541903EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:05:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0B0381F4666B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646395510;
        bh=VHYyfrj27ghhFNATqiJptaXl35MZfcmk6S/le8aQ8V0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lBWseeaKZhZUehk0Y28SYbDmAJ1Q/Hne5Swp5jgROU/3jmS5A7rr2qkQRqKMYQJY4
         mmWtA4wfg4dg2WR74NHRBkotetmfIKFd/19UPI1EziPT8FxeP1EryMr7JFB/XA2ZRx
         mSyoWgf1pGFRscJiMo5b2qdPe0ZiwGxdK50aBKTCf7tb8YD3mtWWJ41mOr8uNHbriY
         8OZQUnPQkqpf71Vcnoih32oZyX69Rf73umh86Yn/rFQSaGuCV4/S9OvMT1oP9vl3Uz
         x9yUuOZLt3UOFRI20SlICBP9nhbraU/Da4iFv0zG99PVBysrkjQSg3wMUCiL0Aeo4v
         rxwFr5/NQ7sOQ==
Message-ID: <4e45bd1d-c81c-97be-f505-cd03ffcdd442@collabora.com>
Date:   Fri, 4 Mar 2022 13:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2,3/3] drm/mediatek: Add mt8186 dsi compatible to
 mtk_dsi.c
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com
References: <1645178869-18048-1-git-send-email-xinlei.lee@mediatek.com>
 <1645178869-18048-4-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1645178869-18048-4-git-send-email-xinlei.lee@mediatek.com>
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

Il 18/02/22 11:07, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add the compatible because use different cmdq addresses in mt8186.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index bced4c7d668e..8c61c4f412bc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1140,6 +1140,12 @@ static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
>   	.has_size_ctl = true,
>   };
>   
> +static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
> +	.reg_cmdq_off = 0xd00,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>   static const struct of_device_id mtk_dsi_of_match[] = {
>   	{ .compatible = "mediatek,mt2701-dsi",
>   	  .data = &mt2701_dsi_driver_data },
> @@ -1147,6 +1153,8 @@ static const struct of_device_id mtk_dsi_of_match[] = {
>   	  .data = &mt8173_dsi_driver_data },
>   	{ .compatible = "mediatek,mt8183-dsi",
>   	  .data = &mt8183_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8186-dsi",
> +	  .data = &mt8186_dsi_driver_data },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
> 



