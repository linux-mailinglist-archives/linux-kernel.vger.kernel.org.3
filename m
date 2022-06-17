Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9554F565
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381425AbiFQKcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381084AbiFQKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:32:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07533183A1;
        Fri, 17 Jun 2022 03:32:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n1so4942907wrg.12;
        Fri, 17 Jun 2022 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iA5EBcmQ2c66Y7u9KNeT7Oa6qN+dCkHMcbRicp+TCdo=;
        b=Q4Xq9nPeLmza0xBivwLO25heE+A+TUnj/WZPvFO68o9h13OrMKzYQU34eaB/Hf8ova
         5eSQfSwpIpry1VgIA5pqyLOYk2Q+gkVYx3MQkaC1vcPY4WXsm2ZkYOitNdtPH4UzowS0
         Whd7Vcpepoylf0ieasWfwAhwUtvyW2lhyCa/RB7vCgtCNs9Ul1oOqtx6tH4N6upnTtt7
         8/gNLXgCRVtuLvl+7bDjmAuMwGIC8O+ydxspWVNjjM8PJgxmVJIpzw9tjsoPRsztkSGZ
         bkQsN7fSCUXh1k8ZrjhW6so4sttZVALFkobi9njTL7p2VucNEXaRCQ6Ouq7jahxTMBbT
         gj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iA5EBcmQ2c66Y7u9KNeT7Oa6qN+dCkHMcbRicp+TCdo=;
        b=d+J/w1x3+B6IlyN0yZj4BJZGJ3/DIxYQkIWfE1ivDlbCi+sMk3UUA8ezq5eh19rdjC
         DfO5D1P8Q649ZabJChKcg8ApNFUUVwoGVDJXc4XJFJVZ6IicRhVH3udGEUoMftZ722uA
         E0XDKvVYvMUUJNA4ld1VVcpC+ZZCHiCGxJUgqKqISL/UX43PX08Gs2jzD8Zx+ySmiI30
         OkhknMP70/Ri7BbyBja4hpYtPrNBufeD4UD7IJbmxOgvnIwe6IC21J2ykyzZJE6orMNj
         k1qvAIzTb8rHWl13KU2Utmxkmj2ygmtwUnhDNipJ4gj5zVIsqMYKCgohRbbYIO9Mq5Pi
         gzMg==
X-Gm-Message-State: AJIora8IRHFItIT1iSu2S4EbuQ9FSy5TQTqru+vbo402i+KbWtlhlc9Z
        4HL4/s2AVUZ3u6e292QISSU=
X-Google-Smtp-Source: AGRyM1uYjq5wWC/zJtt6I45f6wFuWH7TuoP4yuwyBDBcRtSPi5ZO0u8mVAdeLwt9O7+QKkwBI1AHBg==
X-Received: by 2002:a5d:448c:0:b0:21a:91e9:b896 with SMTP id j12-20020a5d448c000000b0021a91e9b896mr2606677wrq.296.1655461964551;
        Fri, 17 Jun 2022 03:32:44 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm4269032wrf.44.2022.06.17.03.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:32:43 -0700 (PDT)
Message-ID: <3c2ac364-5eaf-b26f-2f93-d4cd93b53828@gmail.com>
Date:   Fri, 17 Jun 2022 12:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
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
 <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
 <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2022 14:28, AngeloGioacchino Del Regno wrote:
> Il 15/06/22 14:09, Matthias Brugger ha scritto:
>>
>>
>> On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
>>> On some SoCs (of which only MT8195 is supported at the time of writing),
>>> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
>>> register space and not in the IOMMU space: as it happened already with
>>> infracfg, it is expected that this list will grow.
>>>
>>> Instead of specifying pericfg compatibles on a per-SoC basis, following
>>> what was done with infracfg, let's lookup the syscon by phandle instead.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
>>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 90685946fcbe..0ea0848581e9 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -138,6 +138,8 @@
>>>   /* PM and clock always on. e.g. infra iommu */
>>>   #define PM_CLK_AO            BIT(15)
>>>   #define IFA_IOMMU_PCIE_SUPPORT        BIT(16)
>>> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
>>> +#define HAS_PERI_IOMMU1_REG        BIT(17)
>>
>>  From what I can see MTK_IOMMU_TYPE_INFRA is only set in MT8195 which uses 
>> pericfg. So we don't need a new flag here. For me the flag name 
>> MTK_IOMMU_TYPE_INFRA was confusing as it has nothing to do with the use of 
>> infracfg. I'll hijack this patch to provide some feedback on the actual code, 
>> please see below.
>>
>>>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)    \
>>>                   ((((pdata)->flags) & (mask)) == (_x))
>>> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>>>       u32            flags;
>>>       u32            inv_sel_reg;
>>> -    char            *pericfg_comp_str;
>>>       struct list_head    *hw_list;
>>>       unsigned int        iova_region_nr;
>>>       const struct mtk_iommu_iova_region    *iova_region;
>>> @@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>>               goto out_runtime_disable;
>>>           }
>>>       } else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
>>> -           data->plat_data->pericfg_comp_str) {
>>
>> Check for pericfg_comp_str is not needed, we only have one platform that uses 
>> MTK_IOMMU_TYPE_INFRA.
>>
> 
> Fair enough. I agree.
> 
>>> -        infracfg = 
>>> syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
>>
>> We can do something like this to make the code clearer:
>> data->pericfg = 
>> syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
>>          if (IS_ERR(data->pericfg)) {
>>
>> Using infracfg variable here is confusing as it has nothing to do with 
>> infracfg used with HAS_4GB_MODE flag.
> 
> Yes Matthias, using the infracfg variable is confusing - that's why I changed that
> already....
> 
>>
>> Regards,
>> Matthias
>>
>>> -        if (IS_ERR(infracfg)) {
>>> -            ret = PTR_ERR(infracfg);
>>> -            goto out_runtime_disable;
>>> +           MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
> 
> 
> 
>>> +        data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, 
>>> "mediatek,pericfg");
> 
> ....Here, where I'm assigning directly to data->pericfg :-P
> 

Uuuups, sorry, did look too much on the existing code and not enough on your patch.

> By the way, since it was only about one platform, my intention was to remove the
> pericfg_comp_str from struct iommu_plat_data (as you can see), but then, with the
> current code, I had to assign .....
> 
> 
>>> +        if (IS_ERR(data->pericfg)) {
>>> +            p = "mediatek,mt8195-pericfg_ao";
> 
> ...the string to 'p', because otherwise it would go over 100 columns.
> 
> In any case, I just checked and, apparently, MT8195 is really the one and only SoC
> that needs this pericfg register to be managed by Linux... even the latest and
> greatest smartphone chip (Dimensity 9000, MT6983) doesn't need this (at least,
> from what I can read on a downstream kernel).
> 
> On an afterthought, perhaps the best idea is to just leave this as it is and, as
> you proposed, avoid using that confusing infracfg variable, without adding the
> pericfg handle at all.

Either this or get also rid of the pericfg_comp_str in the _plat_data. I'm 
unemotional about this :)

Regards,
Matthias

> 
> After all, it's just one single SoC.
> 
> I'll send a new version soon!
> 
> Cheers,
> Angelo
> 
