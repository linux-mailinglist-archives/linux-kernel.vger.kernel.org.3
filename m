Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AE54B456
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356519AbiFNPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiFNPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:15:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4533C702;
        Tue, 14 Jun 2022 08:15:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k19so11708681wrd.8;
        Tue, 14 Jun 2022 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IXuDe0y1N7g0HQ+gRNGCz3TLBK6SHrrUtGI9qXS70nI=;
        b=pNE5vPgqmLRxJYRUwLn2HygBM6ytJdDox1fo8PavsqAlLYbvUXKHMA7QW/EKefImgn
         vCsmD6HVBAt1GjEMoJvYBgbfgyAcZBE9j+BAjgaRHWxosTq/rTgYCpc81ougivQSnSdo
         MQrnA/hMkYQ0J3u4SGpJxbsKjp0OZpX3yjrZ0xGxhZPOG3Ltop5iqtB9VcRT1Wy3GfK9
         IEQarUkCk6Or41YYY1+vKUsT2qQLqaMG2LJXsL0baMqYWDGHgxxz1wjVelA8DEq+YcTf
         0iNIa9bByS4Ue98OyUC31rOtmb+CHhqr3S9W3EGxGkxx/V85oRMN2Mrdp9DUCwhFAhYe
         MP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IXuDe0y1N7g0HQ+gRNGCz3TLBK6SHrrUtGI9qXS70nI=;
        b=BCRmNnMuvJDOjifWn8Euw3WDVm421XUQJQ+kjFw5TF3CqCFK1vkLn8UiLUIqRH0c77
         DUCiIYgjiP0Orp6S7cWK6XaIKsy8OUoBXHreI1/B6PE3LgRGeKhKjlYYDGKg2Wjv7SeO
         KbFMGrobDPgycOGPLY68NxQSa7gujDWUPIpFUmUUL29UwQDGRHxrKVEzZLn5d69qW46H
         Q1IGCo4I3bVDfEKXUlF3ZDwrWtFfhSaaANgBqnqycQloKdOdTd8PTlTPf/yIkuDD+9Kr
         373CMzHaT79hnACZuoZCiYcNEe0Cq2v+7OCOaxBkyUKqML+4+vhW1HuLM1smuSM87XoO
         UOOA==
X-Gm-Message-State: AJIora+mFAMa00c0SjP4ogHEJYn6cL7WJOcz8FCLMhX0joc9wCBkeur3
        tGSNTBsG0L8vkzYilvEd/iA=
X-Google-Smtp-Source: AGRyM1vbq7YuSWWy21Fn37KJrbY6DIxBAJG8TbMUpC1uDPhvtrmHbIIb6r7vg7XBmdrSGnOv4jXjCw==
X-Received: by 2002:a5d:40c7:0:b0:210:3135:e662 with SMTP id b7-20020a5d40c7000000b002103135e662mr5240739wrq.280.1655219700487;
        Tue, 14 Jun 2022 08:15:00 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id h206-20020a1c21d7000000b0039746638d6esm13745526wmh.33.2022.06.14.08.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:14:59 -0700 (PDT)
Message-ID: <da05a10b-dd4d-6d93-0cd3-e4695d9b767e@gmail.com>
Date:   Tue, 14 Jun 2022 17:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to infracfg
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220609100802.54513-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 12:07, AngeloGioacchino Del Regno wrote:
> This driver will get support for more SoCs and the list of infracfg
> compatibles is expected to grow: in order to prevent getting this
> situation out of control and see a long list of compatible strings,
> add support to retrieve a handle to infracfg's regmap through a
> new "mediatek,infracfg" phandle.
> 
> In order to keep retrocompatibility with older devicetrees, the old
> way is kept in place.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..90685946fcbe 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1140,22 +1140,32 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> -		switch (data->plat_data->m4u_plat) {
> -		case M4U_MT2712:
> -			p = "mediatek,mt2712-infracfg";
> -			break;
> -		case M4U_MT8173:
> -			p = "mediatek,mt8173-infracfg";
> -			break;
> -		default:
> -			p = NULL;
> +		infracfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,infracfg");
> +		if (IS_ERR(infracfg)) {
> +			/*
> +			 * Legacy devicetrees will not specify a phandle to
> +			 * mediatek,infracfg: in that case, we use the older
> +			 * way to retrieve a syscon to infra.
> +			 *
> +			 * This is for retrocompatibility purposes only, hence
> +			 * no more compatibles shall be added to this.
> +			 */
> +			switch (data->plat_data->m4u_plat) {
> +			case M4U_MT2712:
> +				p = "mediatek,mt2712-infracfg";
> +				break;
> +			case M4U_MT8173:
> +				p = "mediatek,mt8173-infracfg";
> +				break;
> +			default:
> +				p = NULL;
> +			}
> +
> +			infracfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);
>   		}
>   
> -		infracfg = syscon_regmap_lookup_by_compatible(p);
> -
> -		if (IS_ERR(infracfg))
> -			return PTR_ERR(infracfg);
> -
>   		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
>   		if (ret)
>   			return ret;
