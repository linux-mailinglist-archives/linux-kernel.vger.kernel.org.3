Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D434C6C11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiB1MV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiB1MVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:21:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB67084E;
        Mon, 28 Feb 2022 04:20:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n14so15123813wrq.7;
        Mon, 28 Feb 2022 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O2NOZlmqA7RgvZF4C7hoJG5AVQ4LzwSODZXV8jIzeG0=;
        b=ZrWnP68mmzEBBgBVYEcIMymr/Sic0PyF33XFAz9HwOzwsBwZSOuL3daxzw192vv/yw
         u4w9FmdrHcw/PUi+GQ3t4PATV1xvnxjv6Smph9MQWR3lcWgSEnXcgJvVb/fBvB+TZfuj
         du1RNrmOYaQLwN04wqseYfnrJ0nmogX55HvCgjyKWKOdjqa3EzFBEzSj8N6vQi/Q8uTt
         ppPYhdQWebpq/I6OuDQR8QbhVSFigTg5a7FIvUlXnFaVWKGLtkhKF7dqKgJCRy7py8zV
         nDMJPSDcKTrDsx+Q3721fQSebTDT7LJHc8EIVL2qkjzOCzv2F14YcsZVXVhT5MdlZFvF
         5/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O2NOZlmqA7RgvZF4C7hoJG5AVQ4LzwSODZXV8jIzeG0=;
        b=kDs73OGJdKC6QMrLQp+CFWb1KWBc/b9P3r04+xmTuWBX1E3dJtmAJxS4Y3Q+JfUVgi
         IDfknrTa3PZeJvaz0Ux+KSEwFW65xcdk+fV4KcPbouYZTlCxXGqeCp9hDXZqNWO9iw/h
         dd62NdHlRdkxWjGVdkXjVYHnYq0xiG/KI20XI6YKnZ4LV+6aJIaRpBiVHq/TgHgJReZn
         BtFfJnbtrUD8iinQWrys9lXgGSeSHSY7KBFcIZ6xE+iYkCZgmd7/PWrgeF+tL9KuIc03
         lNPurBIzm+xIefXoXOapPnsuC+qfjFqbJAtjInyb01/gbWnPz4ACpBNw+ke/9nYMpagM
         KFVg==
X-Gm-Message-State: AOAM5325U9TGdr8cuFm7A90fqQUOykQCWpsS5nl7kiiCgdje9BdvLrX7
        TkAQ4PgqEi/j5BbYuLeXZEs=
X-Google-Smtp-Source: ABdhPJwLaVfMPHuk8PUaO5u3HtsyXrViUDwFSuAZmGbc36/B95ADkzmeSzxSbvAicTIRVC/nO9f3Lg==
X-Received: by 2002:a5d:6d83:0:b0:1ef:d78a:41fb with SMTP id l3-20020a5d6d83000000b001efd78a41fbmr2817571wrs.355.1646050845207;
        Mon, 28 Feb 2022 04:20:45 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b001e68a5e1c20sm10460233wrn.4.2022.02.28.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 04:20:44 -0800 (PST)
Message-ID: <d4c5b734-1a29-8359-e5fa-b53fc58dd3e5@gmail.com>
Date:   Mon, 28 Feb 2022 13:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] iommu/mediatek: Add mt8186 iommu support
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
References: <20220223072402.17518-1-yong.wu@mediatek.com>
 <20220223072402.17518-3-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220223072402.17518-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2022 08:24, Yong Wu wrote:
> Add mt8186 iommu supports.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d9ca9ffe404c..174a2f3bd68a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -160,6 +160,7 @@ enum mtk_iommu_plat {
>   	M4U_MT8167,
>   	M4U_MT8173,
>   	M4U_MT8183,
> +	M4U_MT8186,
>   	M4U_MT8192,
>   	M4U_MT8195,
>   };
> @@ -1438,6 +1439,21 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>   };
>   
> +static const struct mtk_iommu_plat_data mt8186_data_mm = {
> +	.m4u_plat       = M4U_MT8186,
> +	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> +			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
> +			  MTK_IOMMU_TYPE_MM,
> +	.larbid_remap   = {{0}, {1, MTK_INVALID_LARBID, 8}, {4}, {7}, {2}, {9, 11, 19, 20},
> +			   {MTK_INVALID_LARBID, 14, 16},
> +			   {MTK_INVALID_LARBID, 13, MTK_INVALID_LARBID, 17}},
> +	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.banks_num      = 1,
> +	.banks_enable   = {true},
> +	.iova_region    = mt8192_multi_dom,
> +	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
> +};
> +
>   static const struct mtk_iommu_plat_data mt8192_data = {
>   	.m4u_plat       = M4U_MT8192,
>   	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> @@ -1507,6 +1523,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
>   	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>   	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>   	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> +	{ .compatible = "mediatek,mt8186-iommu-mm",    .data = &mt8186_data_mm}, /* mm: m4u */
>   	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
>   	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
>   	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
