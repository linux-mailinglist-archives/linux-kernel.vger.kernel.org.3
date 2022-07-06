Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D55689F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiGFNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiGFNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:48:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6424F12;
        Wed,  6 Jul 2022 06:48:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so7470658wrx.12;
        Wed, 06 Jul 2022 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ys6nhaWDkYktLlUqq0SwlRalsF7YwG4ENbLhHnvqbhY=;
        b=fV8aJ9j+yuHCeCJsnseihO3elQIXDVuluuk4eEAuWmKG+ZK7rCd24w3roTCv9M3cST
         X5kMf3UXuNCGkNWELxZKURXY0ztY/VKtR6/sCuBqAOOoH759XuEGDMn/RcFj0qaYKaLe
         kTRu9z4IqfmlqILQRbqADqlV2hrVFq77785WL1jQIwYmp+9cY0tfQOInOH7Enyih4OQy
         6QzZVmfouiDIElYWsH34+xwHK6E3jiSnOTph+07cgrvKE00fQA4IeucMqhvFgxJVPpbh
         Fjf7bydjRVlNfviN68vi9tA2pbet372RqOUYk7ePKh4exRP1IaJp4myFJmdOIavAtPu3
         TN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ys6nhaWDkYktLlUqq0SwlRalsF7YwG4ENbLhHnvqbhY=;
        b=HIRDzxkRCmlFy2evCMis/b7qaFCu8ZplTIUdsIK+8YxsdbHJAh2R6KXtwbqrONUblU
         lJ2PoFXeci7aO4E76i+8Iqx0Bl1rebVLiZ7S+tIOkTmxYEYkz/Iii4D0yYpakVA0vIdt
         E6Yue1qNWDZlfobW9UeXr9FEOuNeKn4IqfCRPsJbqn0TpOq3h7JpCYrQZmMzfKhmPK1F
         nqw/UsvUHrqlI0b0Q+UJbzft1iJzXp2xguQJTfn3C7RENRwHDvtiocglA8iX9sf9t7Qk
         qBkFph+bHzaWY+SMucuwGT555F1RySVnj49tH1QiIrSZG+zBHBzt+Lob7FQ6L55J2YLL
         xf/w==
X-Gm-Message-State: AJIora/MTWSMGqMM644hiP0gQGtR/R59W0need5K7YEm0d9kXNLorKzs
        qaqzHI0EcbUQ0NYX/Hs8fBtQ1IGmngtt0A==
X-Google-Smtp-Source: AGRyM1uKokpPXD3KIW+1SGhOJH0F4Ot+3fwFEVIyD8thjoxNU4UTGfcWYVexdf/YGnIyZIvbYxqHnQ==
X-Received: by 2002:a5d:4201:0:b0:21d:7b63:1b43 with SMTP id n1-20020a5d4201000000b0021d7b631b43mr3917188wrq.225.1657115288718;
        Wed, 06 Jul 2022 06:48:08 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm25703913wmi.29.2022.07.06.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:48:07 -0700 (PDT)
Message-ID: <9757b32c-c196-f7e0-3c61-1d4edae854dc@gmail.com>
Date:   Wed, 6 Jul 2022 15:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
 <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
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



On 04/07/2022 14:36, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
>> The max clock items for the dts node with compatible
>> 'mediatek,mt8195-smi-sub-common' should be 3.
>>
>> However, the dtbs_check of such node will get following message,
>> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>>           From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>>
>> Remove the last 'else' checking to fix this error.
> 
> Missing fixes tag.
> 

 From my understanding, fixes tags are for patches that fix bugs (hw is not 
working etc) and not a warning message from dtbs_check. So my point of view 
would be to not add a fixes tag here.

Regards,
Matthias

>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> ---
>>   .../memory-controllers/mediatek,smi-common.yaml        | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> index a98b359bf909..e5f553e2e12a 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> @@ -143,7 +143,15 @@ allOf:
>>               - const: gals0
>>               - const: gals1
>>   
>> -    else:  # for gen2 HW that don't have gals
>> +  - if:  # for gen2 HW that don't have gals
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - mediatek,mt2712-smi-common
>> +            - mediatek,mt8167-smi-common
>> +            - mediatek,mt8173-smi-common
>> +
> 
> Without looking at the code, it's impossible to understand what you are
> doing here. The commit msg says one, but you are doing something else.
> 
> Write commit msg explaining what you want to achieve and what you are doing.
> 
> 
> Best regards,
> Krzysztof
