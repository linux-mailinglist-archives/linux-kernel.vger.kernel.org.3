Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE73513769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348656AbiD1O4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiD1O4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:56:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CCB1AB2;
        Thu, 28 Apr 2022 07:52:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so10082956ejb.6;
        Thu, 28 Apr 2022 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=CH0gLHPMkRyk0v9r3+gHfXKV5CFksmMEo9DOYnqFl2k=;
        b=gSTt+xjDQ+ie0iT2u2y+n0J/h0tq9oP5hJUEixjpLElI1msGQ3WEqwiRqZQXii4zpG
         rmiReWpEVXy7VBKL7Jc52Vt5WDe4YOTzOYIAZLFhE2dvZSgwaqP8rakCQ0Pnz6Z4+hGQ
         pVlcLRanktLoYDDAK9PowP8gmsh8KIyg9UWZPwIJ7yJLLky0ubdqc5V+HHHuP9pljFuY
         Jst9ENckssXe5eiwRVd75zaAIMsPqiSEh2nlaTzoCVfP+/MfWwBBU7EC+m6NqoAnWGeX
         1jdaWXUog1U87dofBjw3OoOL5fFuuve9FoMLqNKqAZPKF1hwNEHlttn3NgQhHvPUwqZS
         ZkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CH0gLHPMkRyk0v9r3+gHfXKV5CFksmMEo9DOYnqFl2k=;
        b=PlBWJD6y6G0kaoaKIl2bhbX7Gmn7C60KxQIv5N5bjWQFX2do1AV9uxYnvYa9TGmbAN
         X0YZCyJwDOrHiQDRu1cGz+3e34tTfsTIzSCTVh9qIr2AlznF97wgkm27pL9qJAlok8XF
         0+MSqwylbyhHqfRtNnYPObfr2P+eFsJPJ52KE5lva3vs26Z8CmnW1NxyYoX9zwJs1jdP
         QoeHhFzKf5nt5bmZSxJDJ+BZLnkRSKMpsE1+CDwgdCk9ZGbVAbQmKLOMrpxduXGmNXdn
         eXwwwk5WvplXOONg4Xf9kmr65+PZgNJSePfF58LhMAceQxVYHPeMd2lKrVRHhKb3OmU5
         mvew==
X-Gm-Message-State: AOAM532VbkQw9bjcg0dTwGyHzukU45lVo3i+UNzRw0NV457mFW9Sif8u
        p23a6vktHJ+05mtPMfz/6mQ=
X-Google-Smtp-Source: ABdhPJwNJ16zR3gmI1Rt3eCeL8nSjebh14myevd9sJZuLR1UrdDa18EBFq97MNnEaLbQ2NuSxN2pNw==
X-Received: by 2002:a17:907:a412:b0:6f0:1071:25ac with SMTP id sg18-20020a170907a41200b006f0107125acmr32051305ejc.261.1651157575793;
        Thu, 28 Apr 2022 07:52:55 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id o4-20020a056402038400b0042617ba63c9sm1724338edv.83.2022.04.28.07.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 07:52:55 -0700 (PDT)
Message-ID: <6668c7bf-6cee-b4e1-bb11-bf2399cc4874@gmail.com>
Date:   Thu, 28 Apr 2022 16:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
References: <20220407075726.17771-1-yong.wu@mediatek.com>
 <20220407075726.17771-12-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 11/34] iommu/mediatek: Add a flag NON_STD_AXI
In-Reply-To: <20220407075726.17771-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2022 09:57, Yong Wu wrote:
> Add a new flag NON_STD_AXI, All the previous SoC support this flag.
> Prepare for adding infra and apu iommu which don't support this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 92f172a772d1..e7008a20ec74 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -122,6 +122,7 @@
>   #define IOVA_34_EN			BIT(8)
>   #define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
>   #define DCM_DISABLE			BIT(10)
> +#define NOT_STD_AXI_MODE		BIT(11)
>   
>   #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>   		((((pdata)->flags) & (_x)) == (_x))
> @@ -785,7 +786,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>   		regval = 0;
>   	} else {
>   		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> -		regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data, NOT_STD_AXI_MODE))
> +			regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;

That means that for mt8195 infra we write back the very same value we read from 
REG_MMU_MISC_CTRL. Is this necessary?
Maybe we can come up with a different flag called STD_AXI_MODE and use something 
like
} else if (!MTK_IOMMU_HAS_FLAG(data->plat_data, \
                            STD_AXI_MODE)) {

Reason is that it makes more sense to add a flag for one specific iommu instead 
of adding a flag to the common case (iommu is not following standard AXI protocol).

What do you think?

Regards,
Matthias

>   		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_WR_EN))
>   			regval &= ~F_MMU_IN_ORDER_WR_EN_MASK;
>   	}
> @@ -1058,7 +1060,8 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
>   
>   static const struct mtk_iommu_plat_data mt2712_data = {
>   	.m4u_plat     = M4U_MT2712,
> -	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE,
> +	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE |
> +			NOT_STD_AXI_MODE,
>   	.hw_list      = &m4ulist,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>   	.iova_region  = single_domain,
> @@ -1068,7 +1071,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   
>   static const struct mtk_iommu_plat_data mt6779_data = {
>   	.m4u_plat      = M4U_MT6779,
> -	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
> +	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
> +			 NOT_STD_AXI_MODE,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>   	.iova_region   = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
> @@ -1077,7 +1081,7 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   
>   static const struct mtk_iommu_plat_data mt8167_data = {
>   	.m4u_plat     = M4U_MT8167,
> -	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR,
> +	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
> @@ -1087,7 +1091,7 @@ static const struct mtk_iommu_plat_data mt8167_data = {
>   static const struct mtk_iommu_plat_data mt8173_data = {
>   	.m4u_plat     = M4U_MT8173,
>   	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> -			HAS_LEGACY_IVRP_PADDR,
> +			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
> @@ -1106,7 +1110,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   static const struct mtk_iommu_plat_data mt8192_data = {
>   	.m4u_plat       = M4U_MT8192,
>   	.flags          = HAS_BCLK | HAS_SUB_COMM | OUT_ORDER_WR_EN |
> -			  WR_THROT_EN | IOVA_34_EN,
> +			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
>   	.iova_region    = mt8192_multi_dom,
>   	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
