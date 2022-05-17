Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93012529E28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiEQJhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbiEQJhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:37:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226F44764;
        Tue, 17 May 2022 02:37:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so934139wms.5;
        Tue, 17 May 2022 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6bpt5PhKRS2nxh0KH3QMhV6usmzH2DoiTgMOR5LKlY=;
        b=b95mzv+H1fuom7FJmC5IfYzMBegHp5UBQ93ReG8v5w1FBMrlb3IHdgH+K+PfL9Gd7a
         6g9FRa1kg7PHBBhHlD94UTtBvuefUsFv18XedpdLjT1OpKJz8PZewsKTc6oS+kGFN43a
         fUbTeu5OmuB0RVNCWdGgcc2RpA2yTU6UnbZWqS/kwBNPG9fvUCiolyyYlKT/QlCZScKJ
         9/vLKty7wbn1iGRJXUTcDRqvLCkwzxC/lcX0xCD8lLyujq/z1l+xlFLpKhej7uCqFDMu
         4yvOSeNEriQaUaFY8AjkwoWbHJXRG7uMxJLGNVzExOsM4Nlqw+cit3za2IQMHyqdPSPj
         ZUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6bpt5PhKRS2nxh0KH3QMhV6usmzH2DoiTgMOR5LKlY=;
        b=sc0MJpa3+RkLodMLU7DpsGHsA1PcoW4oazlVZpQxSUDxSQfd3db4ocvDBbDfsnTNlU
         cVWTqyEsTv0E5jZxMAC6+RNXDXvaA5Xcd8QetRVDQLvoluUV/aLjTFbOF5tR6WmUBwrI
         c6W2v5iEVhj5ULT8I66shhQAXhoEQwDEoyto2U9S0pzruLgp+9iyxn5d2wf2eqJZ15ZS
         soAspsA0fQR0x2QmB/7MZI9uYosvNXl6kZrN+cGfpyxoPVk/OXoDZMfOsbhagGX9Bhgc
         85UZ4DxATs2PpEmunqn0FEU0VfoAl5PGNNhj1GW8PJrR9okIZ63V/ScQocfh5gooLGaT
         vGQw==
X-Gm-Message-State: AOAM530zvvB8/KnMkXhtvYKoR/oYSEC26gvX/hilwgmNyt6n2Ibyvcc6
        90xQylUfePKQ3QPh4AMWTtU=
X-Google-Smtp-Source: ABdhPJwQh+M0XoRHAjimlls7kwZEYt3NwpazeP5chnIi40MWbi4V+CLn1u5VVlKkgebvBjEFtn02fw==
X-Received: by 2002:a05:600c:3549:b0:394:89ba:e1be with SMTP id i9-20020a05600c354900b0039489bae1bemr20344806wmq.181.1652780255954;
        Tue, 17 May 2022 02:37:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c224100b0039706782e06sm1372542wmm.33.2022.05.17.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:37:35 -0700 (PDT)
Message-ID: <8a3079d2-1a2f-43ff-9072-91083a025c7b@gmail.com>
Date:   Tue, 17 May 2022 11:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10
 M4Us
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        yf.wang@mediatek.com, mingyuan.ma@mediatek.com
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
 <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
 <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 11:26, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 11:08, Yong Wu ha scritto:
>> On Fri, 2022-05-13 at 17:14 +0200, AngeloGioacchino Del Regno wrote:
>>> Add support for the M4Us found in the MT6795 Helio X10 SoC.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/iommu/mtk_iommu.c | 20 +++++++++++++++++++-
>>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 71b2ace74cd6..3d802dd3f377 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -157,6 +157,7 @@
>>>   enum mtk_iommu_plat {
>>>       M4U_MT2712,
>>>       M4U_MT6779,
>>> +    M4U_MT6795,
>>>       M4U_MT8167,
>>>       M4U_MT8173,
>>>       M4U_MT8183,
>>> @@ -953,7 +954,8 @@ static int mtk_iommu_hw_init(const struct
>>> mtk_iommu_data *data, unsigned int ban
>>>        * Global control settings are in bank0. May re-init these
>>> global registers
>>>        * since no sure if there is bank0 consumers.
>>>        */
>>> -    if (data->plat_data->m4u_plat == M4U_MT8173) {
>>> +    if (data->plat_data->m4u_plat == M4U_MT6795 ||
>>> +        data->plat_data->m4u_plat == M4U_MT8173) {
>>>           regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>>>                F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>>>       } else {
>>> @@ -1138,6 +1140,9 @@ static int mtk_iommu_probe(struct
>>> platform_device *pdev)
>>>           case M4U_MT2712:
>>>               p = "mediatek,mt2712-infracfg";
>>>               break;
>>> +        case M4U_MT6795:
>>> +            p = "mediatek,mt6795-infracfg";
>>> +            break;
>>>           case M4U_MT8173:
>>>               p = "mediatek,mt8173-infracfg";
>>>               break;
>>> @@ -1404,6 +1409,18 @@ static const struct mtk_iommu_plat_data
>>> mt6779_data = {
>>>       .larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>>>   };
>>> +static const struct mtk_iommu_plat_data mt6795_data = {
>>> +    .m4u_plat     = M4U_MT6795,
>>> +    .flags          = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
>>> +            HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
>>> +    .inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>>> +    .banks_num    = 1,
>>> +    .banks_enable = {true},
>>> +    .iova_region  = single_domain,
>>> +    .iova_region_nr = ARRAY_SIZE(single_domain),
>>> +    .larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping.
>>> */
>>> +};
>>
>> This is nearly same with mt8173_data. mt8173 has one more larb than
>> mt6795, its larbid_remap is also ok for mt6795.
>>
> 
> I think that we should be explicit about the larbid_remap property,
> since mt6795 has one less larb, we should explicitly say that like
> I did there... that's only for human readability I admit ... but,
> still, I wouldn't want to see people thinking that MT6795 has 6 LARBs
> because they've read that larbid_remap having 6 entries.
> 
>> thus it looks we could use mt8173 as the backward compatible.
>>      compatible = "mediatek,mt6795-m4u",
>>                   "mediatek,mt8173-m4u";
>>
>> After this, the only thing is about "mediatek,mt6795-infracfg". we have
>> to try again with mediatek,mt6795-infracfg after mediatek,mt8173-
>> infracfg fail. I think we should allow the backward case in 4GB mode
>> judgment if we have.
>>
>> What's your opinion? or some other suggestion?
>> Thanks.
> 
> I know, I may have a plan for that, but I wanted to have a good reason to
> propose such a thing, as if it's just about two SoCs needing that, there
> would be no good reason to get things done differently.
> 
> ...so, in order to provide a good cleanup, we have two possible roads to
> follow here: either we add a generic "mediatek,infracfg" compatible to the
> infra node (but I don't like that), or we can do it like it was previously
> done in mtk-pm-domains.c (I prefer that approach):
> 
> iommu: iommu@somewhere {
>      ... something ...
>      mediatek,infracfg = <&infracfg>;
> };
> 
> infracfg = syscon_regmap_lookup_by_compatible(node, "mediatek,infracfg");
> if (IS_ERR(infracfg)) {
>      /* try with the older way */
>      switch (...) {
>      case .... p = "mediatek,mt2712-infracfg";
>      ... blah blah ...
>      }
>      /* legacy also failed, ouch! */
>      if (IS_ERR(infracfg))
>          return PTR_ERR(infracfg);
> }
> 
> ret = regmap_read ... etc etc etc
> 

I prefer that approach as well.

Regards,
Matthias

> Cheers,
> Angelo
