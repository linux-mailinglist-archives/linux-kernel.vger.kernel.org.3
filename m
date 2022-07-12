Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B513457151C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiGLIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGLIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:53:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875CE59;
        Tue, 12 Jul 2022 01:53:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00E4D6601795;
        Tue, 12 Jul 2022 09:53:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657616017;
        bh=NgZakB7kND01kxSiME/1yDeBgv1tECpM/++JNRjAb6Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cNsIc+/VJ1E7BC3G/pg8eF+77QxoJ4gfw8Zh/EuSfmQj9zDzy9BQJKEcChM+6Em1R
         RnBqH0V6JDS4lDD2qHgr7/O3wwMjUtUiWTjTnmNcGNQN8bRCJYPQcKHCfqEn5l4zA7
         /PQMA+nh4Ey3bTzgcVUtSI7HteoqjwUXJsh/S+K3GQxQxT09KjgzSgCU5Z4EEsilQK
         JhcC8T0VQ6KTIuEbBCq9fAiFp28IYyh63dyDXTvKrkU36lIQZ40oUN1cc/r1Y+j59h
         BGl4v1FEcCDvvI2fB4WhQhZkEBApo7JvR4o3xlgR6JxJh9puBftDg3FlOT9xJ342Xi
         nmukDrHnh2ong==
Message-ID: <c243bc9c-0862-450d-6bff-00ec5591e791@collabora.com>
Date:   Tue, 12 Jul 2022 10:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1eb212ea-c5a9-b06f-606f-1271ac52adf9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 10:37, Krzysztof Kozlowski ha scritto:
> On 12/07/2022 10:17, AngeloGioacchino Del Regno wrote:
>> Il 06/07/22 17:18, Krzysztof Kozlowski ha scritto:
>>> On 06/07/2022 14:00, Tinghan Shen wrote:
>>>> Hi Krzysztof,
>>>>
>>>> After discussing your message with our power team,
>>>> we realized that we need your help to ensure we fully understand you.
>>>>
>>>> On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
>>>>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>>>>> Add power domains controller node for mt8195.
>>>>>>
>>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>>>>    1 file changed, 327 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>> index 8d59a7da3271..d52e140d9271 100644
>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>>>>> @@ -10,6 +10,7 @@
>>>>>>    #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>    #include <dt-bindings/phy/phy.h>
>>>>>>    #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>>>>> +#include <dt-bindings/power/mt8195-power.h>
>>>>>>    
>>>>>>    / {
>>>>>>    	compatible = "mediatek,mt8195";
>>>>>> @@ -338,6 +339,332 @@
>>>>>>    			#interrupt-cells = <2>;
>>>>>>    		};
>>>>>>    
>>>>>> +		scpsys: syscon@10006000 {
>>>>>> +			compatible = "syscon", "simple-mfd";
>>>>>
>>>>> These compatibles cannot be alone.
>>>>
>>>> the scpsys sub node has the compatible of the power domain driver.
>>>> do you suggest that the compatible in the sub node should move to here?
>>>
>>> Not necessarily, depends. You have here device node representing system
>>> registers. They need they own compatibles, just like everywhere in the
>>> kernel (except the broken cases...).
>>>
>>> Whether this should be compatible of power-domain driver, it depends
>>> what this device node is. I don't know, I don't have your datasheets or
>>> your architecture diagrams...
>>>
>>>>
>>>>>> +			reg = <0 0x10006000 0 0x1000>;
>>>>>> +			#power-domain-cells = <1>;
>>>>>
>>>>> If it is simple MFD, then probably it is not a power domain provider.
>>>>> Decide.
>>>>
>>>> this MFD device is the power controller on mt8195.
>>>
>>> Then it is not a simple MFD but a power controller. Do not use
>>> "simple-mfd" compatible.
>>>
>>>> Some features need
>>>> to do some operations on registers in this node. We think that implement
>>>> the operation of these registers as the MFD device can provide flexibility
>>>> for future use. We want to clarify if you're saying that an MFD device
>>>> cannot be a power domain provider.
>>>
>>> MFD device is Linuxism, so it has nothing to do here. I am talking only
>>> about simple-mfd. simple-mfd is a simple device only instantiating
>>> children and not providing anything to anyone. Neither to children. This
>>>    the most important part. The children do not depend on anything from
>>> simple-mfd device. For example simple-mfd device can be shut down
>>> (gated) and children should still operate. Being a power domain
>>> controller, contradicts this usually.
>>>
>>
>> If my interpretation of this issue is right, I have pushed a solution for it.
>> Krzysztof, Matthias, can you please check [1] and give feedback, so that
>> Tinghan can rewrite this commit ASAP?
>>
>> Reason is - I need the MT8195 devicetree to be complete to push the remaining
>> pieces for Tomato Chromebooks, of course.
>>
>> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=658527
> 
> I have two or three similar discussions, so maybe I lost the context,
> but I don't understand how your fix is matching real hardware.
> 
> In the patchset here, Tinghan claimed that power domain controller is a
> child of 10006000. 10006000 is also a power domain controller. This was
> explicitly described by the DTS code.
> 
> Now you abandon this hierarchy in favor of syscon. If the hierarchy was
> correct, your patchset does not match the hardware, so it's a no-go.
> Describe the hardware.
> 
> However maybe this patch did not make any sense and there is no
> relationship parent-child... so what do you guys send here? Bunch of
> hacks and work-arounds?
> 

For how I get it, hardware side, the SPM (System Power Manager) resides inside
of the SCPSYS block (consequently, in that iospace).

As Matthias pointed out earlier, SCPSYS provides more functionality, but the
only one that's currently implemented upstream is the System Power Manager,
responsible for managing the MTCMOS (power domains).

In any case, now I'm a little confused on how to proceed, can you please give
some suggestion?

Thanks,
Angelo

> Your DTS should reflect the hardware, not some hacks.
> 
> Best regards,
> Krzysztof
