Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E74568B51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiGFOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGFOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:35:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F31836D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:35:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f39so26282603lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vHzDk8iDFWu26W/brex+TMJ8rS3+AlVCn+1TtO/d/+w=;
        b=J6aEaA93f6HARN0t/xaA82XJaM88rLxgWepc8chGBv0nECRXeki8VoeFiLxbk0bD0W
         NECJ1vNaouHr3IyfPJEcxgkOj5p/xbvUvyLBpytO37yN5u2UmbJsFcNzJcn8NDBHt48k
         JOlyQBmcRJvvQf8MhHEF3PAlZN4cTRpAnGlU0PTzFmYT9irpHiG9yN6guR4setcg9okh
         dl+iEju53llS49uZgo+DBoF4kdjp+Zf0F1AVuNlEU+e+xQx0H65pxWjQK3ephirk+aB7
         y80eFot9nKxq9aXCX7zRAlAlSMsOjjstIDgHEv/NqvjjABvIw66RIQ3wHPtNeQ4dNH2w
         yu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vHzDk8iDFWu26W/brex+TMJ8rS3+AlVCn+1TtO/d/+w=;
        b=iSU1ROmwsKAEC28TCgb0qmiaKrESjPUBeGxt7UmdDYK2NgOsQ87jGXctIS0PIbJzk1
         hhNOy4hSVCgbuYBq2KRxeuG6lR56xUW2Nt6h9EQLcArp4FEJYmeDcpNEORioTfzRQpn+
         Umufuuo2LDhu+kg0voYDme+2YR3ZkiL18VIBOPBIPY/8jKJJgNRujJR0G0Mq4O5dJUNm
         i6S9xV7wqsUZJ4MlBrqiWZP3Q9MbXMmAOTK+VXAlzx02iU3kfn3Zb610Q2tOuJXj/jyS
         3kcVgSRxOWmM8bfrrspRx1SddlWpK+G2DaKKoFM7bRB8TWvz4/FRCuifIS685Jm2pAb7
         kHcw==
X-Gm-Message-State: AJIora9XY3DQLqs7tUjYS1hyG705XR6SZ3OC3SDRwTg5/CRup2Lfz77Q
        0+sLPyCyVlMNLTM2jLj74OHmEw==
X-Google-Smtp-Source: AGRyM1vZt21fHb4CPWwcERIsmHIfne9uEYyXkXvwQU6KzIQn9abhEBmceqxhXa74eYVxw2w3BF7y/Q==
X-Received: by 2002:a05:6512:32c1:b0:47f:9d5b:d558 with SMTP id f1-20020a05651232c100b0047f9d5bd558mr27803365lfg.488.1657118119332;
        Wed, 06 Jul 2022 07:35:19 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b0048600adb5d9sm425876lfr.10.2022.07.06.07.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:35:18 -0700 (PDT)
Message-ID: <27c99ecf-75ab-1798-2b59-3be397d153d0@linaro.org>
Date:   Wed, 6 Jul 2022 16:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
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
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
 <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
 <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
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

On 06/07/2022 15:41, Matthias Brugger wrote:
> 
> 
> On 04/07/2022 14:38, Krzysztof Kozlowski wrote:
>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>> Add power domains controller node for mt8195.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>   1 file changed, 327 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> index 8d59a7da3271..d52e140d9271 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -10,6 +10,7 @@
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/phy/phy.h>
>>>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>> +#include <dt-bindings/power/mt8195-power.h>
>>>   
>>>   / {
>>>   	compatible = "mediatek,mt8195";
>>> @@ -338,6 +339,332 @@
>>>   			#interrupt-cells = <2>;
>>>   		};
>>>   
>>> +		scpsys: syscon@10006000 {
>>> +			compatible = "syscon", "simple-mfd";
>>
>> These compatibles cannot be alone.
>>
> 
> You mean we would need something like "mediatek,scpsys" as dummy compatible 
> that's not bound to any driver?

Yes. syscon (and simple-mfd) must always come with a specific compatible.

> 
>>> +			reg = <0 0x10006000 0 0x1000>;
>>> +			#power-domain-cells = <1>;
>>
>> If it is simple MFD, then probably it is not a power domain provider.
>> Decide.
> 
> The SCPSYS IP block of MediaTek SoCs group several functionality, one is the 
> power domain controller. Others are not yet implemented, but defining the scpsys 
> as a MFD will give us the possibility to do so in the future.

No, quite the opposite. Having simple-mfd prevents you from implementing
it correctly later as a driver, because you cannot remove it. It would
be ABI break.

It's fine to have one block being a simple MFD having several children,
but then it's not a power controller. Children could be such power
controller, but not simple-mfd. Rob explained this several times:
https://lore.kernel.org/all/YXhINE00HG6hbQI4@robh.at.kernel.org/
https://lore.kernel.org/all/20220701000959.GA3588170-robh@kernel.org/


Best regards,
Krzysztof
