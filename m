Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E75136AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbiD1OVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiD1OVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:21:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0507B53D9;
        Thu, 28 Apr 2022 07:18:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so6975095wrc.9;
        Thu, 28 Apr 2022 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5XdPKzrNuCW9Uls4djg9CnJPr0HfyWEzzX13gHvuT9s=;
        b=WYm5siW9NgsC3mcU0a3rvvmjzgshlYltbHF/8MkclQWoK+UeqblajvhIEXxxYve1Hw
         ArzFVVgI0LhX+EQQMKgsLRnxr1l6oRxDxasL6i16yusWP0qQO05kK2pUFQ9rwO2PU7CV
         g/I+91SHjrw6N2nVnNSpIvSq/6Q2axMNSjt8G+cn8jFEaCbdNXqLDCTe+qYh+tyImRcs
         2C2UQopBi/UqDb8Z7mJP93le0PX8NtFtxYQqKo5iDqjqEk8jhUY5Mz9CaPTNwW+JgW6O
         iYGgtDnGkNWHOvHntQd/+h4c+Y7dY/FegmQSsb4AbzllTJvmfkKOktoV7v9L5Gg3S71D
         XaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5XdPKzrNuCW9Uls4djg9CnJPr0HfyWEzzX13gHvuT9s=;
        b=WBnbpbbgU4m8Xg3MzWHEPRsnH32R/MZXNrcwGQp9YqJCxAWJiIQETfLmgQD0PbfZQx
         18qjNxWE/tpBx3thYZDL9SzjKtwH7IMT85DbhOAc3OC4v9L5ew3rAGMGqTW7b1J7hq8I
         jbJ0pkBDPV39kJ8fhGaDbSCnlE6Ym9++dKagOloFIszDOQxxG7igVtZF0CM0y9GMnzLh
         9FhNx1+nabqKNrKvo78eIpL0gF2dHaNn+ucSSM8MsUKeYheP+xpx3kJfae0rbkis77oU
         wd2F6lw8LUSdvzUQIRKWAaAOlE4GDTX9vOXNT3818cdXzw6Hx1xIxRdFae7JHCUPsV7u
         rKTA==
X-Gm-Message-State: AOAM531j6k/IEZ8EM/AYjYmp0//pCrxg36NDuIyHGHbUfnOgnYgVSH4S
        x3mRSiHWsXo9srXh0skpP50=
X-Google-Smtp-Source: ABdhPJx0D91qDY3rAHXrUKYpJ6EndFNu0vi5Ze7REIXxyW9yTMg00OwkJnpjgHzk30D5LZMqwVL8fA==
X-Received: by 2002:a5d:47ab:0:b0:20a:7f8a:ec69 with SMTP id 11-20020a5d47ab000000b0020a7f8aec69mr26826607wrb.504.1651155485199;
        Thu, 28 Apr 2022 07:18:05 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id s10-20020adf978a000000b0020ae0154f1esm12625wrb.5.2022.04.28.07.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 07:18:03 -0700 (PDT)
Message-ID: <661261a7-45be-230b-b0b2-5837d2139030@gmail.com>
Date:   Thu, 28 Apr 2022 16:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 15/34] iommu/mediatek: Add IOMMU_TYPE flag
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
 <20220407075726.17771-16-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220407075726.17771-16-yong.wu@mediatek.com>
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
> Add IOMMU_TYPE definition. In the mt8195, we have another IOMMU_TYPE:
> infra iommu, also there will be another APU_IOMMU, thus, use 2bits for the
> IOMMU_TYPE.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 84d661e0b371..642949aad47e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -126,9 +126,17 @@
>   #define SHARE_PGTABLE			BIT(10) /* 2 HW share pgtable */
>   #define DCM_DISABLE			BIT(11)
>   #define NOT_STD_AXI_MODE		BIT(12)
> +/* 2 bits: iommu type */
> +#define MTK_IOMMU_TYPE_MM		(0x0 << 13)
> +#define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
> +#define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
>   
> -#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> -		((((pdata)->flags) & (_x)) == (_x))
> +#define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))

That could be:
MTK_IOMMU_HAS_FLAG(pdata, _x) \
                 MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, _x)

> +
> +#define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
> +				((((pdata)->flags) & (mask)) == (_x))
> +#define MTK_IOMMU_IS_TYPE(pdata, _x)	MTK_IOMMU_HAS_FLAG_MASK(pdata, _x,\
> +							MTK_IOMMU_TYPE_MASK)
>   
>   struct mtk_iommu_domain {
>   	struct io_pgtable_cfg		cfg;
