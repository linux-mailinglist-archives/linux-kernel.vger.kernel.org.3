Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73107571547
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiGLJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiGLJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:03:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154BA44CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:03:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y11so6310289lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qJxUyqqHev67tpfClaZNAocOsbllu9hMYiypPtjySTQ=;
        b=omEU2Ab2IkEDRlh2Hu2HNGB8ChfxSCNmR9dyDAZn9HZlo/p4u4XFaYstZ4agyHy4GI
         0xkIMmpkbVnWpVj1urLHZdVpU8l56N3Kfv3dGm7rDQ7/eYR7F33OJ80IU4QXCoDBOQg9
         b3Sl6iYT4S2SGvoGnGHtPqHYWkMXqezq+O69BNnQn8M/LR5DbDVq56GkS+LR0v6MRagn
         N0S3mjnrJdGoNMaQWEtABwJPENqNg6e2mK/eWHzGGDktxY68xcC9PvwQxIfjETxNfZFT
         CSh6tqpevrraUr3U8nIb5k+NT4zhbwJJDsbFwv6sx4M128174WijWDlSsgxF8hAvd6rv
         3oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qJxUyqqHev67tpfClaZNAocOsbllu9hMYiypPtjySTQ=;
        b=fEeDPs3mVzSjjWo9GE09F7Y2yysqj088HFsxBkSjgPIPW1FAeMy5eOGuAU+UQ+/fJH
         jHXvA0kKlz+a6XIrqF4Naz4iWSnw4M7laiRsFf00KxW8vIgHuXlnJX1eaQYqLGiGgKm2
         xt5N2hzCoO1prfBWcq4qRJ8dUM76G/SQoWuaRXtfD/GM/+dVQb8t5QAMyUNnta0vh7uN
         VQyvDggQsvSBmx0uEceZcdbJRQBVPr+zuR62//fxuYu2foBCmg9gBVAtwlHiadJaL/e9
         hKGatm5YnwU1s12b+zM9WWXRHKo9E/hLLR9FJR1ISa3wVpEUiUl2BQpRAmzVNuHOh8fQ
         QF1Q==
X-Gm-Message-State: AJIora/qqlYe907HXjMM8Ez8Gb9Z7zrw6I1F0KH7hY9622dm4Zg1hN40
        VsVbTervTZYrcrLSt5mnabJVhg==
X-Google-Smtp-Source: AGRyM1vbDloanlf1JX4n1W5PjwRlQVj5gqoAPuLaNpzCxXvb1SDDgQlxyHSSFGNX9p+0kfp29S4bFQ==
X-Received: by 2002:ac2:4d43:0:b0:489:cb6e:b293 with SMTP id 3-20020ac24d43000000b00489cb6eb293mr11303350lfp.376.1657616597891;
        Tue, 12 Jul 2022 02:03:17 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm2059505lfh.286.2022.07.12.02.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:03:17 -0700 (PDT)
Message-ID: <d8bc3b20-45db-a869-2aff-9cda8e0fca92@linaro.org>
Date:   Tue, 12 Jul 2022 11:03:14 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c243bc9c-0862-450d-6bff-00ec5591e791@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 10:53, AngeloGioacchino Del Regno wrote:
> Il 12/07/22 10:37, Krzysztof Kozlowski ha scritto:
>> On 12/07/2022 10:17, AngeloGioacchino Del Regno wrote:
>>> Il 06/07/22 17:18, Krzysztof Kozlowski ha scritto:
>>>> On 06/07/2022 14:00, Tinghan Shen wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> After discussing your message with our power team,
>>>>> we realized that we need your help to ensure we fully understand you.
>>>>>
>>>>> On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
>>>>>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>>>>>> Add power domains controller node for mt8195.
>>>>>>>
>>>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>>>>>> ---
>>>>>>>    arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>>>>>    1 file changed, 327 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>> index 8d59a7da3271..d52e140d9271 100644
>>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>    #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>    #include <dt-bindings/phy/phy.h>
>>>>>>>    #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>>>>>> +#include <dt-bindings/power/mt8195-power.h>
>>>>>>>    
>>>>>>>    / {
>>>>>>>    	compatible = "mediatek,mt8195";
>>>>>>> @@ -338,6 +339,332 @@
>>>>>>>    			#interrupt-cells = <2>;
>>>>>>>    		};
>>>>>>>    
>>>>>>> +		scpsys: syscon@10006000 {
>>>>>>> +			compatible = "syscon", "simple-mfd";
>>>>>>
>>>>>> These compatibles cannot be alone.
>>>>>
>>>>> the scpsys sub node has the compatible of the power domain driver.
>>>>> do you suggest that the compatible in the sub node should move to here?
>>>>
>>>> Not necessarily, depends. You have here device node representing system
>>>> registers. They need they own compatibles, just like everywhere in the
>>>> kernel (except the broken cases...).
>>>>
>>>> Whether this should be compatible of power-domain driver, it depends
>>>> what this device node is. I don't know, I don't have your datasheets or
>>>> your architecture diagrams...
>>>>
>>>>>
>>>>>>> +			reg = <0 0x10006000 0 0x1000>;
>>>>>>> +			#power-domain-cells = <1>;
>>>>>>
>>>>>> If it is simple MFD, then probably it is not a power domain provider.
>>>>>> Decide.
>>>>>
>>>>> this MFD device is the power controller on mt8195.
>>>>
>>>> Then it is not a simple MFD but a power controller. Do not use
>>>> "simple-mfd" compatible.
>>>>
>>>>> Some features need
>>>>> to do some operations on registers in this node. We think that implement
>>>>> the operation of these registers as the MFD device can provide flexibility
>>>>> for future use. We want to clarify if you're saying that an MFD device
>>>>> cannot be a power domain provider.
>>>>
>>>> MFD device is Linuxism, so it has nothing to do here. I am talking only
>>>> about simple-mfd. simple-mfd is a simple device only instantiating
>>>> children and not providing anything to anyone. Neither to children. This
>>>>    the most important part. The children do not depend on anything from
>>>> simple-mfd device. For example simple-mfd device can be shut down
>>>> (gated) and children should still operate. Being a power domain
>>>> controller, contradicts this usually.
>>>>
>>>
>>> If my interpretation of this issue is right, I have pushed a solution for it.
>>> Krzysztof, Matthias, can you please check [1] and give feedback, so that
>>> Tinghan can rewrite this commit ASAP?
>>>
>>> Reason is - I need the MT8195 devicetree to be complete to push the remaining
>>> pieces for Tomato Chromebooks, of course.
>>>
>>> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=658527
>>
>> I have two or three similar discussions, so maybe I lost the context,
>> but I don't understand how your fix is matching real hardware.
>>
>> In the patchset here, Tinghan claimed that power domain controller is a
>> child of 10006000. 10006000 is also a power domain controller. This was
>> explicitly described by the DTS code.
>>
>> Now you abandon this hierarchy in favor of syscon. If the hierarchy was
>> correct, your patchset does not match the hardware, so it's a no-go.
>> Describe the hardware.
>>
>> However maybe this patch did not make any sense and there is no
>> relationship parent-child... so what do you guys send here? Bunch of
>> hacks and work-arounds?
>>
> 
> For how I get it, hardware side, the SPM (System Power Manager) resides inside
> of the SCPSYS block (consequently, in that iospace).
> 
> As Matthias pointed out earlier, SCPSYS provides more functionality, but the
> only one that's currently implemented upstream is the System Power Manager,
> responsible for managing the MTCMOS (power domains).
> 
> In any case, now I'm a little confused on how to proceed, can you please give
> some suggestion?

You should make SCPSYS (0x10006000, AFAIU) a proper driver with its own
compatible (followed by syscon if needed), even if now it is almost
empty stub. The driver should populate OF children and then you can
embed SPM inside and reference to parent's regmap. No need for
simple-mfd. Later the SCPSYS can grow, if you ever need it.



Best regards,
Krzysztof
