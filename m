Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40046571A61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiGLMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGLMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:47:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F74B23D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:47:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r9so9718455ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YD8kD4qfracZEUI+3UjgH4UxjUFKWQi1NIztv2hWw7o=;
        b=JcWqcCN9lVaPmawlxMSW73H88FzDkqlj0HpiiMlCsuCGhKpxaYmkXlAU8JPMxZus+5
         GUBk8tnLKVBvLYIa4/TXSQ9ZYBzF+VlIXmlg0hRcj6baA6TECSz4WADZZUhx0ubwTtFd
         xqLCB3V9ivpW48UyV9czI3cWgcRGRWY4U9K7Hd5kDSc6HgIed1Mp8ki+ijcH/cpDqUts
         IMrt2RT8F7WAyORm3gwMmj/qB6qvcug4OUMwFf7KtnAuBHbbBrB59Pxk+rYX3wMxVpC7
         +7eggUHn89c/rn1fzSDCSzQBHg/VgT+MaHaDNG8AnCIeGwLVjGK4Hg6PVIUYA207WiV1
         qffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YD8kD4qfracZEUI+3UjgH4UxjUFKWQi1NIztv2hWw7o=;
        b=deU0Dv3clnrGoNLvFhxMWv4ct9HAdLz9wizGBUgx8wo9zsCXtWniinNlVsJ+dLAOek
         eh5zb7E0yL7zdDEQKGbC83mM9beMNmD+UEmmtO2dmYHuL5Ahx8huwtumHetxCP4k+oOF
         /d7JQxzyrOX399IEf+9PiA4Tsa3kwIOeHeVowmoZ+3Y1Lym1XU1BIcm4Iqn3LoXnVrv9
         BudXb6Cm7YTZHMDJ0XqP+X1ReqwZcDtZLqfDYeD9cz+W2tqxdtROGDU7uHzbmvXsVwQu
         n48Q98UaZT+KJNKDu1GSxsNVQdxA56AtXfR8+sBasXMx2MBuLxwcFcbIYtN983ta9ZWs
         yVVQ==
X-Gm-Message-State: AJIora8MnXvLJPn501ad766kV3pqjld67p1/zBjFRRh5h62tlZ+NGiLX
        ws9p88esG7UxOhvU0K5TNffmew==
X-Google-Smtp-Source: AGRyM1tZQghvQchWPAU5p58dXqMIjBDYv0QssnpP+1w5eB5mUGpNm2aL38/IFyg2WRjgm6sDXZpFcg==
X-Received: by 2002:a2e:bc27:0:b0:25b:c3b8:dada with SMTP id b39-20020a2ebc27000000b0025bc3b8dadamr13764754ljf.356.1657630048099;
        Tue, 12 Jul 2022 05:47:28 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b0047faab456cesm2154182lfr.237.2022.07.12.05.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 05:47:27 -0700 (PDT)
Message-ID: <410cf9aa-471b-644c-9540-9bc0b89b8fd9@linaro.org>
Date:   Tue, 12 Jul 2022 14:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
 <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
 <eec6aee5cd023fff6d986882db0330e1ab85a59d.camel@mediatek.com>
 <0301ebc6-1222-e813-f237-f14ad8444940@linaro.org>
 <b6523c64-dfe2-13b0-db60-fb4f53ed1e31@collabora.com>
 <1eb212ea-c5a9-b06f-606f-1271ac52adf9@linaro.org>
 <c243bc9c-0862-450d-6bff-00ec5591e791@collabora.com>
 <d8bc3b20-45db-a869-2aff-9cda8e0fca92@linaro.org>
 <83162e4f-a31f-79cf-ba01-58b45fd4f62e@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <83162e4f-a31f-79cf-ba01-58b45fd4f62e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 12:33, AngeloGioacchino Del Regno wrote:
> Il 12/07/22 11:03, Krzysztof Kozlowski ha scritto:
>> On 12/07/2022 10:53, AngeloGioacchino Del Regno wrote:
>>> Il 12/07/22 10:37, Krzysztof Kozlowski ha scritto:
>>>> On 12/07/2022 10:17, AngeloGioacchino Del Regno wrote:
>>>>> Il 06/07/22 17:18, Krzysztof Kozlowski ha scritto:
>>>>>> On 06/07/2022 14:00, Tinghan Shen wrote:
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> After discussing your message with our power team,
>>>>>>> we realized that we need your help to ensure we fully understand you.
>>>>>>>
>>>>>>> On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
>>>>>>>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>>>>>>>> Add power domains controller node for mt8195.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>>>>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>>>>>>>> ---
>>>>>>>>>     arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>>>>>>>     1 file changed, 327 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>> index 8d59a7da3271..d52e140d9271 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>>>     #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>>>     #include <dt-bindings/phy/phy.h>
>>>>>>>>>     #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>>>>>>>> +#include <dt-bindings/power/mt8195-power.h>
>>>>>>>>>     
>>>>>>>>>     / {
>>>>>>>>>     	compatible = "mediatek,mt8195";
>>>>>>>>> @@ -338,6 +339,332 @@
>>>>>>>>>     			#interrupt-cells = <2>;
>>>>>>>>>     		};
>>>>>>>>>     
>>>>>>>>> +		scpsys: syscon@10006000 {
>>>>>>>>> +			compatible = "syscon", "simple-mfd";
>>>>>>>>
>>>>>>>> These compatibles cannot be alone.
>>>>>>>
>>>>>>> the scpsys sub node has the compatible of the power domain driver.
>>>>>>> do you suggest that the compatible in the sub node should move to here?
>>>>>>
>>>>>> Not necessarily, depends. You have here device node representing system
>>>>>> registers. They need they own compatibles, just like everywhere in the
>>>>>> kernel (except the broken cases...).
>>>>>>
>>>>>> Whether this should be compatible of power-domain driver, it depends
>>>>>> what this device node is. I don't know, I don't have your datasheets or
>>>>>> your architecture diagrams...
>>>>>>
>>>>>>>
>>>>>>>>> +			reg = <0 0x10006000 0 0x1000>;
>>>>>>>>> +			#power-domain-cells = <1>;
>>>>>>>>
>>>>>>>> If it is simple MFD, then probably it is not a power domain provider.
>>>>>>>> Decide.
>>>>>>>
>>>>>>> this MFD device is the power controller on mt8195.
>>>>>>
>>>>>> Then it is not a simple MFD but a power controller. Do not use
>>>>>> "simple-mfd" compatible.
>>>>>>
>>>>>>> Some features need
>>>>>>> to do some operations on registers in this node. We think that implement
>>>>>>> the operation of these registers as the MFD device can provide flexibility
>>>>>>> for future use. We want to clarify if you're saying that an MFD device
>>>>>>> cannot be a power domain provider.
>>>>>>
>>>>>> MFD device is Linuxism, so it has nothing to do here. I am talking only
>>>>>> about simple-mfd. simple-mfd is a simple device only instantiating
>>>>>> children and not providing anything to anyone. Neither to children. This
>>>>>>     the most important part. The children do not depend on anything from
>>>>>> simple-mfd device. For example simple-mfd device can be shut down
>>>>>> (gated) and children should still operate. Being a power domain
>>>>>> controller, contradicts this usually.
>>>>>>
>>>>>
>>>>> If my interpretation of this issue is right, I have pushed a solution for it.
>>>>> Krzysztof, Matthias, can you please check [1] and give feedback, so that
>>>>> Tinghan can rewrite this commit ASAP?
>>>>>
>>>>> Reason is - I need the MT8195 devicetree to be complete to push the remaining
>>>>> pieces for Tomato Chromebooks, of course.
>>>>>
>>>>> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=658527
>>>>
>>>> I have two or three similar discussions, so maybe I lost the context,
>>>> but I don't understand how your fix is matching real hardware.
>>>>
>>>> In the patchset here, Tinghan claimed that power domain controller is a
>>>> child of 10006000. 10006000 is also a power domain controller. This was
>>>> explicitly described by the DTS code.
>>>>
>>>> Now you abandon this hierarchy in favor of syscon. If the hierarchy was
>>>> correct, your patchset does not match the hardware, so it's a no-go.
>>>> Describe the hardware.
>>>>
>>>> However maybe this patch did not make any sense and there is no
>>>> relationship parent-child... so what do you guys send here? Bunch of
>>>> hacks and work-arounds?
>>>>
>>>
>>> For how I get it, hardware side, the SPM (System Power Manager) resides inside
>>> of the SCPSYS block (consequently, in that iospace).
>>>
>>> As Matthias pointed out earlier, SCPSYS provides more functionality, but the
>>> only one that's currently implemented upstream is the System Power Manager,
>>> responsible for managing the MTCMOS (power domains).
>>>
>>> In any case, now I'm a little confused on how to proceed, can you please give
>>> some suggestion?
>>
>> You should make SCPSYS (0x10006000, AFAIU) a proper driver with its own
>> compatible (followed by syscon if needed), even if now it is almost
>> empty stub. The driver should populate OF children and then you can
>> embed SPM inside and reference to parent's regmap. No need for
>> simple-mfd. Later the SCPSYS can grow, if you ever need it.
>>
>>
> 
> I see an issue with such approach: the SCPSYS doesn't have a mailbox, doesn't
> need power management from the Linux side, doesn't have any register to check
> HW revision, it's always online (hence it doesn't need Linux to boot it), it
> doesn't need any root clock, nor regulator, nor mmu context, and there's no
> retrievable "boot log" of any sort.

No problems, there are other drivers who do not need any resources,
except address space.

> 
> Hence, a driver with its own compatible would be an empty stub forever: it's
> not going to get any "scpsys root handling" at all, because there's none to do.

But it is a power domain provider, so you need to embed it in some
dirver, don't you?


> Digging through some downstream kernels, the only other functionality that I
> can find in the SCPSYS is a MODULE_RESET (which is used to reset the SCP System)
> and a INFRA_IRQ_SET, used to set "wake locks" on the AP and CONNSYS (modem).

So why was power domain provider added to SCPSYS? Guys, I don't know
your architecture, so I deduct it based on pieces of DTS code I see.

> 
> Both of these may only be used in the SCP mailbox driver (which is *not* SCPSYS)
> to perform an ipi_send operation (but currently we simply en/disable the clock
> and that's enough), or to perform a reset and firmware reload of the SCP (but
> currently we're simply powering off and back on: this may change in the future).
> 
> So, at the end of the day, we would end up having a copy of simple-pm-bus and
> nothing else, which doesn't look like being optimal at all.

No, because you need that power domain driver, don't you? If you don't
need power domain provider/driver, why the heck this is there:

+		scpsys: syscon@10006000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
                        ^^^^^^^^^^^^^^^^^
Entire discussion started from this.

> 
> My own vision is that either using syscon (as shown in the series that you've
> checked), keeping "simple-mfd", or changing it to "simple-bus" (whatever) is
> the cleanest (and best approach) - please otherwise explain why having such

Again, simple-mfd is just MFD, not a power domain provider.

simple-bus should not have it's own address space, so combining it with
syscon is rather wrong.

https://lore.kernel.org/linux-devicetree/Ynq52E93mcTXcw9H@robh.at.kernel.org/

> a practically forever-stub driver (practically, a copy of simple-pm-bus.c)
> would be beneficial in any way.
> 

Of course not, but your DTS is saying it is not a stub.

Best regards,
Krzysztof
