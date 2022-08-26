Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20725A2B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiHZPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiHZPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:39:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6B11A1C;
        Fri, 26 Aug 2022 08:39:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k17so1092558wmr.2;
        Fri, 26 Aug 2022 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MOtWtmaDFMIySeLE9Js113f5P0+EXoCQS1R6JsEcSbQ=;
        b=gZtzZqqAQtgWdXborkrmVTMGKMSHVjEIEnLiJkdCqn3zzJqPr8bPJULbLqZ8ikl37a
         +7HTYejc+nHXOManj2mYNhzvqnN3XYmD3P8KC6J/SB0VWIIppXEUqAoSmT1LaFtf/fSO
         PvutQ61YcBLdm4XjGIQxCa921kUpR9xrz2BhkCYY3NwCB1ZJDnPDuFvhkccxagn63c5y
         ybim+hig6TobRv8l5JL8mQcB2lW7F5fvKwMiAej6Px7gJ+ympkCIpyVEyYDQvYF5Au6H
         3nKOUg6EwbjYmKT+pyrY8TWT2fZedIFapE3Px4lJ8QbBdzAcXZPWFMoug+/CVrnBsnzV
         a0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MOtWtmaDFMIySeLE9Js113f5P0+EXoCQS1R6JsEcSbQ=;
        b=oOTvHXo7ly/j3AsIqg0WXkkcWI7jA+AFvmF69uoyWuF6g3Lbq5BnV8sNA4JtV0UTcZ
         4bVjXGB6+jTucpeOPO5Fwf9HFyePqv0k3xUEZnSv3gkuBG2R7FqmtXkHX73yAlhsAdNM
         rUE6fBYf99OWlld3hbHBgZgIkE85Ch11U9E4tflRgKU05YKV4fUDqyWJxV7UhNTJ9ld/
         pvCZA9dLQS8yH4E0ZLr/Ye5R7D1mrK7ZpSXMbAFeFMJxCfQtXoAOPJXfrfbkF1pjm/3p
         7HPqiOe9VIBKIKY0pP6bqpCP3VgYv+EUkdCMOfBsIodV8J54gqjhpGydi9LxO9HlCFaN
         4k/Q==
X-Gm-Message-State: ACgBeo1ASwP8HEIfBUyk8YYAUKHyZAfG0B9OreqDQ3IMlUS7aEYjFq7a
        VOzx8mUmIWpA5xKS/9ao3Xg=
X-Google-Smtp-Source: AA6agR5AoXPkL721SdanPx83BCkCCPrUSRFNojtDVoeIavHfGdwo4ztYoyqHkgG0kLOwPtD5BNFJ6w==
X-Received: by 2002:a7b:ce11:0:b0:3a6:1e4d:8d7b with SMTP id m17-20020a7bce11000000b003a61e4d8d7bmr35044wmc.101.1661528389951;
        Fri, 26 Aug 2022 08:39:49 -0700 (PDT)
Received: from [192.168.1.130] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5c1e916c8sm17667866wmq.1.2022.08.26.08.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 08:39:48 -0700 (PDT)
Message-ID: <efedfd3d-9779-514b-0481-f0b669d2e326@gmail.com>
Date:   Fri, 26 Aug 2022 17:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220825091448.14008-1-rex-bc.chen@mediatek.com>
 <3ed3d73a-1671-708e-7c42-498cca6aaf1d@gmail.com>
 <8f3dba943170361211d9bb4c8bf1be12bbfdec20.camel@mediatek.com>
 <adcbb2b7-cddd-4546-bdf2-66d056a40c1d@linaro.org>
 <916bd99bcc4fa77eae5734b22365ce73acd90d58.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <916bd99bcc4fa77eae5734b22365ce73acd90d58.camel@mediatek.com>
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



On 26/08/2022 09:13, Bo-Chen Chen wrote:
> On Fri, 2022-08-26 at 15:00 +0800, Krzysztof Kozlowski wrote:
>> On 26/08/2022 05:07, Bo-Chen Chen wrote:
>>> On Thu, 2022-08-25 at 22:57 +0800, Matthias Brugger wrote:
>>>>
>>>> On 25/08/2022 11:14, Bo-Chen Chen wrote:
>>>>> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>>>>>
>>>>> For previous MediaTek SoCs, such as MT8173, there are 2 display
>>>>> HW
>>>>> pipelines binding to 1 mmsys with the same power domain, the
>>>>> same
>>>>> clock driver and the same mediatek-drm driver.
>>>>>
>>>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
>>>>> binding
>>>>> to
>>>>> 2 different power domains, different clock drivers and
>>>>> different
>>>>> mediatek-drm drivers.
>>>>>
>>>>> Moreover, Hardware pipeline of VDOSYS0 has these components:
>>>>> COLOR,
>>>>> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
>>>>> Quality)
>>>>> and they makes VDOSYS0 supports PQ function while they are not
>>>>> including in VDOSYS1.
>>>>>
>>>>> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR
>>>>> related
>>>>> component). It makes VDOSYS1 supports the HDR function while
>>>>> it's
>>>>> not
>>>>> including in VDOSYS0.
>>>>>
>>>>> To summarize0:
>>>>> Only VDOSYS0 can support PQ adjustment.
>>>>> Only VDOSYS1 can support HDR adjustment.
>>>>>
>>>>> Therefore, we need to separate these two different mmsys
>>>>> hardwares
>>>>> to
>>>>> 2 different compatibles for MT8195.
>>>>>
>>>>> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add
>>>>> mt8195
>>>>> SoC binding")
>>>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>>>> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>>>>> ---
>>>>> Changes for v2:
>>>>> 1. Add hardware difference for VDOSYS0 and VDOSYS1 in commit
>>>>> message.
>>>>> ---
>>>>>   
>>>>> .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>>>>> |
>>>>> 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>> .yam
>>>>> l
>>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>> .yam
>>>>> l
>>>>> index 6ad023eec193..bfbdd30d2092 100644
>>>>> ---
>>>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>> .yam
>>>>> l
>>>>> +++
>>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>> .yam
>>>>> l
>>>>> @@ -31,7 +31,8 @@ properties:
>>>>>                  - mediatek,mt8183-mmsys
>>>>>                  - mediatek,mt8186-mmsys
>>>>>                  - mediatek,mt8192-mmsys
>>>>> -              - mediatek,mt8195-mmsys
>>>>> +              - mediatek,mt8195-vdosys0
>>>>
>>>> Thanks for you patch. As I mentioned on v1, I propose to set
>>>> mediatek,mt8195-mmsys as fallback for mediatek,mt8195-vdosys0 to
>>>> not
>>>> break
>>>> backwards compatibility.
>>>>
>>>> Apart from that, the binding change will need some changes to
>>>> support
>>>> the new
>>>> binding. Please provide these together with this patch.
>>>>
>>>> Regards,
>>>> Matthias
>>>>
>>>
>>> Hello Matthias,
>>>
>>> Thanks for your comments.
>>> The purpose of this patch is to confirm we can separate mt8195
>>> mmsys
>>> into two compatibles. I think this modification is accepted.
>>
>> No, it is not accepted following Matthias comments. You received my
>> ack
>> based on assumption that ABI break is perfectly ok for platform
>> maintainer, as he has decisive voice. If anyone is not happy with a
>> ABI
>> break, then his concerns must be addressed.
>>
>> So let it be specific:
>> NAK.
>>
>>>
>>> After this, I think Jason-JH will push another series with this
>>> binding
>>> patch.
>>
>> I don't know what do you mean here - another series on top of wrong
>> patch?
>>
> 
> Hello Krzysztof,
> 
> For this mt8195 mmsys binding separation, we still need to modify
> driver for this. The reason I send this patch is to confirm we can do
> this binding modification and I also think we can not pick this patch
> here.
> 
> We will push another series and it contains modification of binding and
> drivers. (The series will push by Jason-JH Lin)
> 

Sounds good. So lets wait for Jason-JH Lin to send this series and we can go on 
with the review.

Thanks!
Matthias

> Maybe I should use "RFC" for this series, and I think it's more
> correct.
> 
> BRs,
> Bo-Chen
> 
>>> In Jason-JH's series, we will modify mmsys driver based on this.
>>> And I think we don't need to keep "mediatek,mt8195-mmsys" if we
>>> also
>>> modify mmsys drivers in the same series.
>>
>> This does not fux ABI break and broken bisectability.
>>
>>>
>>> Is it ok that postpones to pick this patch until we finish review
>>> follow-up series?
>>>
>>
>> No. You got a clear review to fix.
>>
>> Best regards,
>> Krzysztof
> 
