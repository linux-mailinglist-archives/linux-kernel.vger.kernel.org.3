Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629785714C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiGLIh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiGLIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:37:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3CA44FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:37:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a39so9042381ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CenrAMUhuy7No5JoRejBvuvAOSnjGpy/yDxPGevvI6w=;
        b=TNiGyZvtDjh/rLQpYxoih0/HM/mJIDIXidnoQkzLB8nJx3KN27Wmq2fwspjkk0jJIY
         Sipgh3cMsW0pY0S1027VqXD52CaN6ht7b+EbZZune4iCXpgIJG2pgyOh4rlccMmICvsm
         ziubgm7D8MfSzruhCUhTUu2TGu9vqSZOEblP2UGvbRSoUj9Ue2WHKyceiw9KtK9D7IrO
         NU9D9k8Odkt4+8K0nv66yS2ifBcOSAt3Na0XGohYpU4sNpgMVmIvefGP6xm4+QoQtvMy
         j3A+GyGgjNcKsddivpyyZ/vbXWXWN3yHYcIBm6nH+jZsoPM8fMXOdGXmXUiymyI69seA
         tOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CenrAMUhuy7No5JoRejBvuvAOSnjGpy/yDxPGevvI6w=;
        b=ZWj0jR3A6Zainu169H8cVBYCjjlS61dUoAgXOqDuGBj//yTNZILfPclCRp3mrzJLJJ
         qVpvG8fn93/p1tb8oH0EBhTUGyFDa/xv112IRn4yNJRNcPyx2FicPczkFwO+HMavctE0
         UVqN9CHylOWjGlvggp/d1Ww5/OjPIkrjZKhH9hi3yMLmnWw9yZkzDY7VDqMAbYn3MYy1
         8YdQIFtGmKq7tZPjDkJcXFl1RfIqspiSAXLROOD6t77z6xQnHMkPWj4qNMWLxN3PE7kt
         mQrWRVBqvqqbjPICvfpQp5PPbdJ4ZrDc5z8n18prmnznr65SvVMOYKJ94RLd+GwMckLz
         ov2Q==
X-Gm-Message-State: AJIora/ASZDIqEjO9YeZVqkranyFNWAA+Aw1kBnsdYLT7NtF4/9DALie
        b6nhIvBlao+b+mZWFsqA/98psQ==
X-Google-Smtp-Source: AGRyM1vJVOlhps4ABBcnniF1AYWAiwD0akYFf+tbCizI9CmKnyi4+od3r3nmnLJoJHB3N2pNUSj7Ug==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr12385394ljp.442.1657615068373;
        Tue, 12 Jul 2022 01:37:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id g7-20020a056512118700b0047f647414efsm2056015lfr.190.2022.07.12.01.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:37:47 -0700 (PDT)
Message-ID: <1eb212ea-c5a9-b06f-606f-1271ac52adf9@linaro.org>
Date:   Tue, 12 Jul 2022 10:37:44 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b6523c64-dfe2-13b0-db60-fb4f53ed1e31@collabora.com>
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

On 12/07/2022 10:17, AngeloGioacchino Del Regno wrote:
> Il 06/07/22 17:18, Krzysztof Kozlowski ha scritto:
>> On 06/07/2022 14:00, Tinghan Shen wrote:
>>> Hi Krzysztof,
>>>
>>> After discussing your message with our power team,
>>> we realized that we need your help to ensure we fully understand you.
>>>
>>> On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
>>>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>>>> Add power domains controller node for mt8195.
>>>>>
>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>>>   1 file changed, 327 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>> index 8d59a7da3271..d52e140d9271 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>> @@ -10,6 +10,7 @@
>>>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>>>   #include <dt-bindings/phy/phy.h>
>>>>>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>>>> +#include <dt-bindings/power/mt8195-power.h>
>>>>>   
>>>>>   / {
>>>>>   	compatible = "mediatek,mt8195";
>>>>> @@ -338,6 +339,332 @@
>>>>>   			#interrupt-cells = <2>;
>>>>>   		};
>>>>>   
>>>>> +		scpsys: syscon@10006000 {
>>>>> +			compatible = "syscon", "simple-mfd";
>>>>
>>>> These compatibles cannot be alone.
>>>
>>> the scpsys sub node has the compatible of the power domain driver.
>>> do you suggest that the compatible in the sub node should move to here?
>>
>> Not necessarily, depends. You have here device node representing system
>> registers. They need they own compatibles, just like everywhere in the
>> kernel (except the broken cases...).
>>
>> Whether this should be compatible of power-domain driver, it depends
>> what this device node is. I don't know, I don't have your datasheets or
>> your architecture diagrams...
>>
>>>
>>>>> +			reg = <0 0x10006000 0 0x1000>;
>>>>> +			#power-domain-cells = <1>;
>>>>
>>>> If it is simple MFD, then probably it is not a power domain provider.
>>>> Decide.
>>>
>>> this MFD device is the power controller on mt8195.
>>
>> Then it is not a simple MFD but a power controller. Do not use
>> "simple-mfd" compatible.
>>
>>> Some features need
>>> to do some operations on registers in this node. We think that implement
>>> the operation of these registers as the MFD device can provide flexibility
>>> for future use. We want to clarify if you're saying that an MFD device
>>> cannot be a power domain provider.
>>
>> MFD device is Linuxism, so it has nothing to do here. I am talking only
>> about simple-mfd. simple-mfd is a simple device only instantiating
>> children and not providing anything to anyone. Neither to children. This
>>   the most important part. The children do not depend on anything from
>> simple-mfd device. For example simple-mfd device can be shut down
>> (gated) and children should still operate. Being a power domain
>> controller, contradicts this usually.
>>
> 
> If my interpretation of this issue is right, I have pushed a solution for it.
> Krzysztof, Matthias, can you please check [1] and give feedback, so that
> Tinghan can rewrite this commit ASAP?
> 
> Reason is - I need the MT8195 devicetree to be complete to push the remaining
> pieces for Tomato Chromebooks, of course.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=658527

I have two or three similar discussions, so maybe I lost the context,
but I don't understand how your fix is matching real hardware.

In the patchset here, Tinghan claimed that power domain controller is a
child of 10006000. 10006000 is also a power domain controller. This was
explicitly described by the DTS code.

Now you abandon this hierarchy in favor of syscon. If the hierarchy was
correct, your patchset does not match the hardware, so it's a no-go.
Describe the hardware.

However maybe this patch did not make any sense and there is no
relationship parent-child... so what do you guys send here? Bunch of
hacks and work-arounds?

Your DTS should reflect the hardware, not some hacks.

Best regards,
Krzysztof
