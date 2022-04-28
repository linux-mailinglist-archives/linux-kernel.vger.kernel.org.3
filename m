Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F6512BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiD1GoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1GoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:44:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406C5D5FF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:40:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so7543434ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g4ePX7G8X59yI/6hK2LFLFfdo4oBytYEY/83QyfibjA=;
        b=jVp+JM3y8a9ObmevGUR7dwqAqrXopLU2pWMmZvlw0Vdcrz3CELRZq+auxAZcpNpNO/
         boNJveutpKxLbIuIRbH1nJhH6VgdYNiiDkRrIrXLpikV73w50S6qPyFUOX8GKXDlSgy4
         OJDIUNQPIKQqE8L2iYd0bIeAb/Yhwsu7QT7IXJ5TusUTeePLEBHSFujZ0YRZXQE5nGRd
         FJnKPECStPsfPBxqwAuyfYWSc7V2RyTix1v6ytZnWFU2EhaGhLprV223qK+mXrcRbpw1
         TL52G/mxAqe1w72c8Tv38ORCxciWDi8I+al0JsxL3joPSAbYuepXQnzDNT2aAylny59b
         9lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4ePX7G8X59yI/6hK2LFLFfdo4oBytYEY/83QyfibjA=;
        b=EsGLlaknc2w4dOOCwc2KJATMeU6lOktS/umbUsZZvfUwQ6V65E48Q2wWBHXakbXqLB
         C7OcV90Nhm15Udi2A5Gg9bdGRGyEdSINrBFsSSHspwZxid5xcVGrMBO8dMxXdoxjje4M
         7gV3TqmBinA2ld2VpY4PuOKa594JvQjPfcR0/hZ9IkR17xr/r/9eC7iGxGW5gxmhT5QV
         LJfJ+QdL31BMgL4Ufwm+nRLnsMx0wUyl10JPXWePQbW5O+PcfhpDa0z8BIEqIpk6A5L2
         Ob2Ae5A+OtTurTOCfCHW5Koloy8LX4C4o9fwuXIN5Ya7p24sD6OsoQJGV7pQlk711iJW
         6vgw==
X-Gm-Message-State: AOAM533e76XN0D2Jp7XbiYYCLFGHG8uiZV4dHwomHql9xKTT4UvRVmzL
        Dz8iqEnZnDdQtHvzVBtHGuDXbA==
X-Google-Smtp-Source: ABdhPJz4z22JlAvsEbghIRkpGgckZCqesm5hhXuET4dcbdH5mMusYCHlByL0Rm4+EjZShXHVrbFXGg==
X-Received: by 2002:a17:907:3f1c:b0:6f3:98ab:4735 with SMTP id hq28-20020a1709073f1c00b006f398ab4735mr17988072ejc.547.1651128044392;
        Wed, 27 Apr 2022 23:40:44 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm7889328ejd.133.2022.04.27.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:40:43 -0700 (PDT)
Message-ID: <49dd007b-f6f6-0278-8f06-f81cf951fcd3@linaro.org>
Date:   Thu, 28 Apr 2022 08:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 12/17] dt-binding: mt8192: Add infra_ao reset bit
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-13-rex-bc.chen@mediatek.com>
 <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
 <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
 <418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org>
 <9547368870f6a8d5c5e6bd5dd497ddbe04c51b93.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9547368870f6a8d5c5e6bd5dd497ddbe04c51b93.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 10:23, Rex-BC Chen wrote:
> On Mon, 2022-04-25 at 15:52 +0800, Krzysztof Kozlowski wrote:
>> On 25/04/2022 07:01, Rex-BC Chen wrote:
>>> On Sat, 2022-04-23 at 18:28 +0800, Krzysztof Kozlowski wrote:
>>>> On 22/04/2022 08:01, Rex-BC Chen wrote:
>>>>> To support reset of infra_ao, add the bit definition for
>>>>> thermal/PCIe/SVS.
>>>>>
>>>>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>>>>> ---
>>>>>  include/dt-bindings/reset/mt8192-resets.h | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/include/dt-bindings/reset/mt8192-resets.h
>>>>> b/include/dt-bindings/reset/mt8192-resets.h
>>>>> index be9a7ca245b9..d5f3433175c1 100644
>>>>> --- a/include/dt-bindings/reset/mt8192-resets.h
>>>>> +++ b/include/dt-bindings/reset/mt8192-resets.h
>>>>> @@ -27,4 +27,14 @@
>>>>>  
>>>>>  #define MT8192_TOPRGU_SW_RST_NUM				
>>>>> 23
>>>>>  
>>>>> +/* INFRA RST0 */
>>>>> +#define MT8192_INFRA_RST0_LVTS_AP_RST				
>>>>> 0
>>>>> +/* INFRA RST2 */
>>>>> +#define MT8192_INFRA_RST2_PCIE_PHY_RST				
>>>>> 15
>>>>> +/* INFRA RST3 */
>>>>> +#define MT8192_INFRA_RST3_PTP_RST				
>>>>> 5
>>>>> +/* INFRA RST4 */
>>>>> +#define MT8192_INFRA_RST4_LVTS_MCU				
>>>>> 12
>>>>> +#define MT8192_INFRA_RST4_PCIE_TOP				
>>>>> 1
>>>>
>>>> These should be the IDs of reset, not some register
>>>> values/offsets.
>>>> Therefore it is expected to have them incremented by 1.
>>>>
>>>>
>>>
>>> Hello Krzysztof,
>>>
>>> This is define bit.
>>>
>>> There is serveral reset set for infra_ao while it's not serial.
>>> For MT8192, it's 0x120/0x130/0x140/0x150/0x730.
>>> We are implement #reset-cells = <2>, and we can use this reset
>>> drive
>>> more easier.
>>>
>>> For example, in dts, we can define
>>> infra_ao: syscon {
>>> 	compatible = "mediatek,mt8192-infracfg", "syscon";
>>>  	reg = <0 0x10001000 0 0x1000>;
>>>  	#clock-cells = <1>;
>>> 	#reset-cells = <2>;
>>> };
>>>
>>> thermal {
>>> 	...
>>> 	resets = <&infra_ao 0x730 MT8192_INFRA_RST4_LVTS_MCU>;
>>> 	...
>>> };
>>>
>>> If it's acceptabel, I can update all bit difinition from 0 to 15
>>> for
>>> all reset set.
>>
>> Bits are not acceptable, because you embed specific device
>> programming
>> model (register bits) into the binding.
>>
>> These should be IDs, so decimal numbers incremented from 0, so:
>> #define MT8192_INFRA_RST0_LVTS_AP_RST				0
>> #define MT8192_INFRA_RST4_LVTS_MCU				1
>> #define MT8192_INFRA_RST4_PCIE_TOP				2
>>
>> And what is 0x730 in your example? It does not look like ID of a
>> reset...
>>
>> Entire changeset look wrong from DT point of view.
>>
>> Best regards,
>> Krzysztof
> 
> Hello Krzysztof,
> 
> Got it. I will modify them to reset index.
> And the dts in my next version would somthing like this:
> 
> ----
> #define MT8192_INFRA_THERMAL_CTRL_RST			0
> #define MT8192_INFRA_PEXTP_PHY_RST			79
> #define MT8192_INFRA_PTP_RST				101
> #define MT8192_INFRA_RST4_PCIE_TOP			129
> #define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140

These are still not IDs, incremented by one.

So again from beginning:
0
1
2
...

Do not encode hardware register bits into the binding.

Best regards,
Krzysztof
