Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4A54C829
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiFOMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiFOMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:09:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95DA4ECC7;
        Wed, 15 Jun 2022 05:09:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u8so15051136wrm.13;
        Wed, 15 Jun 2022 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=ufqEIhQJLn0a1lP22CtHnxpKmABhqIWqQFeboCEBeR8=;
        b=NNQJ/jGhKFi3TLolVvv6p5vDCUgaeZ2UDfX5QF22P23d0rNi2IA+3xgJlttCAlAbei
         rk6ebUX23qsziqFBje19orA87/iwUKsvIIxT1/tuq/V/zfiyuLMDGAhmMekYevaKip0L
         VFsqyo2qSHzhQaaVho66mGEdQ0v3EV+MXT2CiOUY0RceDlRJUVuTteYygqy1hEhOnhDy
         bDFcEuM9bSkckbpuY7bJcxBHX7aiGwNDqqmpKOCokXagegSOK3ZOIf+WH/TR6GhgAGAE
         JXb9yVmULvi4y4ygg6OY6k3egdNzz9CQUgXR20nHtdlWgf58B33lpzamh5904JHegno4
         8d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=ufqEIhQJLn0a1lP22CtHnxpKmABhqIWqQFeboCEBeR8=;
        b=PXcXzBJ8TsSyuTA5qHSrU42ASQ+T405gpVZ9gVRUU0xkpnJGU02er0RcTVY+ohYH9A
         65mxtzrj/BmSLGzQA8ZLblA0CqCmblO+NL5BoHX9Lo/b717dJmtCIuCZGlgLyVmHFp6U
         wJ625mKbUr4qIjUB7OZ2ea6MkxdFo2qT79OYlpCUBvh4uESZjaiUTOsdunsY8uUrCmze
         ZqBlE+dKZYXmkRi1XdCTTF9mSnsTUEvFRpT2eFKyIp7MTXbzIwyxLXWkv2fERVqt3Nti
         k1srIrf9hXONkf0zZejcFzGY0Lh8tYfFkIo0X4A0XT33TsYy8dp7ox9Tfp6eT52FMpBP
         WVWw==
X-Gm-Message-State: AJIora+e6jwdVJ8bCxRBWgBMlYWAOadZvFJRI18gTGLekKfck+wLEEWW
        5c5REELFJWfqogomAXYBgAJpOtpKZ5wW8g==
X-Google-Smtp-Source: AGRyM1spOOsJofsOCL+iHFbSiA5IRU/CCTL1EBYYpqTyOZwOes1IVw6CJtdit0i26miabw44PN2cEg==
X-Received: by 2002:a05:6000:1542:b0:218:549a:2a8e with SMTP id 2-20020a056000154200b00218549a2a8emr9738727wry.314.1655294992184;
        Wed, 15 Jun 2022 05:09:52 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id 64-20020a1c1943000000b0039c6390730bsm2249993wmz.29.2022.06.15.05.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:09:51 -0700 (PDT)
Message-ID: <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
Date:   Wed, 15 Jun 2022 14:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
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
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
In-Reply-To: <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
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



On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
> register space and not in the IOMMU space: as it happened already with
> infracfg, it is expected that this list will grow.
> 
> Instead of specifying pericfg compatibles on a per-SoC basis, following
> what was done with infracfg, let's lookup the syscon by phandle instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 90685946fcbe..0ea0848581e9 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,8 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
> +#define HAS_PERI_IOMMU1_REG		BIT(17)

 From what I can see MTK_IOMMU_TYPE_INFRA is only set in MT8195 which uses 
pericfg. So we don't need a new flag here. For me the flag name 
MTK_IOMMU_TYPE_INFRA was confusing as it has nothing to do with the use of 
infracfg. I'll hijack this patch to provide some feedback on the actual code, 
please see below.

>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>   	u32			flags;
>   	u32			inv_sel_reg;
>   
> -	char			*pericfg_comp_str;
>   	struct list_head	*hw_list;
>   	unsigned int		iova_region_nr;
>   	const struct mtk_iommu_iova_region	*iova_region;
> @@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {

Check for pericfg_comp_str is not needed, we only have one platform that uses 
MTK_IOMMU_TYPE_INFRA.

> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);

We can do something like this to make the code clearer:
data->pericfg = 
syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
		if (IS_ERR(data->pericfg)) {

Using infracfg variable here is confusing as it has nothing to do with infracfg 
used with HAS_4GB_MODE flag.

Regards,
Matthias

> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> -			goto out_runtime_disable;
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
> +		if (IS_ERR(data->pericfg)) {
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
>   		}
> -
> -		data->pericfg = infracfg;
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> @@ -1484,8 +1487,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
>   static const struct mtk_iommu_plat_data mt8195_data_infra = {
>   	.m4u_plat	  = M4U_MT8195,
>   	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
> -			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
> -	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +			    HAS_PERI_IOMMU1_REG | MTK_IOMMU_TYPE_INFRA |
> +			    IFA_IOMMU_PCIE_SUPPORT,
>   	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>   	.banks_num	  = 5,
>   	.banks_enable     = {true, false, false, false, true},
