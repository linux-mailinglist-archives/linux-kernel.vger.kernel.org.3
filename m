Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCA539416
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbiEaPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiEaPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:36:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D186BFD0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:36:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so27437684ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lmor8msbWC8RoDOpFJKIyrGyj+A7W9X1XdQfh9y670I=;
        b=YLTH8SZkcOXaBCy5mZKkDcYse9C9OlcolxPNHPxcU56dSH2gNqjvQPin6uEwFyQ/QH
         D80r8XFRbzLhcuFLfyFble0TcfXvRbEYzZ3WaSZB2jsyH30eNtzjkjipcjf/t8kJwEF9
         lMhQH+q018QJzI9qbEbIVq2jZLF0r9Pbko8rOZzK7ikguiiwSOppzZy2eCxi3XXXOppc
         nU3kfd9BW/vAf9jFOv/0wODmJtYZ7Z5s3heH/P59FnyazznR/mzKfAV4e8Hb2HPXAgd5
         aM9ccgEN+RLhKvGGOIitO5atGTMfUM1CtlEZM8bZ+qmqVIVr1T8pVCWjz1wmsVOLvBYu
         g0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lmor8msbWC8RoDOpFJKIyrGyj+A7W9X1XdQfh9y670I=;
        b=QAGhI7y94Vvq/f87A/kFaIW523hY04n7mvOihKr6cb3qcvMp42r3Qw9fEmrPIwcfOK
         UAP4VXQosVGDUoXzt6P9qJhFF1s5Z7leGrpWVigj2vHUS8lZy726jL0ESFoI/ior1f5X
         ox4e1KtSX6RDE1TTm0ID5mvWggHfiov/INX8W2tkswMSbMz5LquNHlxRmBB1DC3wUjLa
         oE99/YMuzPKoPomdr7IprwPjjhDQFIEccnMa1qcQgngaWeTeqM369OMGZzArSAyq3mLB
         QIYtlQq76Psi14Oy1kwzTpYAzyorOTmVzmrrfVvDGqXnBGpmv/W+pTEV8WwN8MXowHgg
         0UGA==
X-Gm-Message-State: AOAM532bq7G8r4gEK9a6BG20QCMdgceCSjIYs65je6WPsU5NIyImT+3A
        XqSthRGDhBVkki87Jg1QtAb9hA==
X-Google-Smtp-Source: ABdhPJxm2wlP2EFxtOhD7af0DzEYMu8HyO3kL97zqettcs32QzdM63hOShjdYuP/84npq5pXBxRBUQ==
X-Received: by 2002:a17:907:3d8a:b0:6ff:a9a:bea7 with SMTP id he10-20020a1709073d8a00b006ff0a9abea7mr29701709ejc.134.1654011379585;
        Tue, 31 May 2022 08:36:19 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z5-20020a50f145000000b0042dc460bda6sm5509231edl.18.2022.05.31.08.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 08:36:19 -0700 (PDT)
Message-ID: <b8a770fc-d72d-efd2-a7a0-8bfd44308576@linaro.org>
Date:   Tue, 31 May 2022 17:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] dts: socfpga: Add Google Chameleon v3 devicetree
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>
Cc:     Alexandru M Stan <amstan@chromium.org>, SoC Team <soc@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Dinh Nguyen <dinguyen@kernel.org>
References: <20220530130839.120710-1-pan@semihalf.com>
 <20220530130839.120710-3-pan@semihalf.com>
 <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org>
 <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
 <e4ef2056-c990-b308-a9d5-98f11ac0ba51@linaro.org>
 <CAF9_jYR=sjP9wYW9wyfbrVYO4PDYTfMhjvyyh53U3a3+2Zyw=g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF9_jYR=sjP9wYW9wyfbrVYO4PDYTfMhjvyyh53U3a3+2Zyw=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 16:47, Paweł Anikiel wrote:
> On Tue, May 31, 2022 at 11:11 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 31/05/2022 03:20, Alexandru M Stan wrote:
>>> Hello Krzysztof
>>>
>>> On Mon, May 30, 2022 at 11:56 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 30/05/2022 15:08, Paweł Anikiel wrote:
>>>>> Add devicetree for the Google Chameleon v3 board.
>>>>>
>>>>> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
>>>>> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
>>>>
>>>> Your SoB chain looks odd. Who did what here?
>>>
>>> Sorry about this.
>>>
>>> It was mainly Pawel but I did some small changes at some point before
>>> it landed in our tree (particularly the GPIOs).
>>
>> Then usually Paweł should be the owner of the patch, not you.
>> Alternatively it could be also co-developed.
>>
>>>
>>>>
>>>>> ---
>>>>>  arch/arm/boot/dts/Makefile                    |  1 +
>>>>>  .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
>>>>>  2 files changed, 91 insertions(+)
>>>>>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>>> index 023c8b4ba45c..9417106d3289 100644
>>>>> --- a/arch/arm/boot/dts/Makefile
>>>>> +++ b/arch/arm/boot/dts/Makefile
>>>>> @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
>>>>>       s5pv210-torbreck.dtb
>>>>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
>>>>>       socfpga_arria5_socdk.dtb \
>>>>> +     socfpga_arria10_chameleonv3.dtb \
>>>>>       socfpga_arria10_socdk_nand.dtb \
>>>>>       socfpga_arria10_socdk_qspi.dtb \
>>>>>       socfpga_arria10_socdk_sdmmc.dtb \
>>>>> diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>>>> new file mode 100644
>>>>> index 000000000000..988cc445438e
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>>>> @@ -0,0 +1,90 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright 2022 Google LLC
>>>>> + */
>>>>> +/dts-v1/;
>>>>> +#include "socfpga_arria10_mercury_aa1.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "Google Chameleon V3";
>>>>> +     compatible = "google,chameleon-v3",
>>>>
>>>> You miss here enclustra compatible.
>>>
>>> Does this make sense? I don't expect this device tree to boot/work on
>>> an enclustra motherboard. It's only really compatible with a
>>> "chameleon-v3".
>>
>> You also do not expect it to boot on altr,socfpga, do you?
>>
>> If I understood correctly, this board has physically Mercury AA1 SoM, so
>> that compatible should be there.
> 
> Yes, you understood correctly.
> I looked at a similar device - the Cyclone V MCV (SoM) and the MCVEVK
> (base board):
> arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi

This one is clearly incorrect, so using it as example is wrong.

> arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts

Since it is based on wrong MCV, then no wonder it's the same.

> And there is no denx,mcv compatible anywhere, only denx,mcvevk.
> Also, devicetree bindings documentation lists denx,mcvevk under
> "Cyclone 5 boards", and, unless you consider the MCV to be a board,
> there isn't a good place to put denx,mcv (same story with mercury+
> aa1/chameleon).

socfpga are not the best example... upstreaming looks incomplete or even
incorrect, like this case of Enclustra SOM. Much better examples are
FSL-based SoMs. Although some of them are also not in the best shape.

Still someone might prefer to skip SoM compatible arguing that it cannot
be a separate final product. Sure, but also SoC cannot be a separate
product. Having SoM compatible allows to match against it and find
common hardware parts.

In any case you want to remove here parts of bindings (so affect ABI),
to which I do not agree.

>> Let me clarify - please use generic node names, as asked by Devicetree
>> specification (2.2.1. Node Name Requirements). There is also list of
>> some examples in the spec, but you can use some other generic node name.
>>
>> Several bindings also require it.
> 
> Do you mean something like this?
> ssm2603: audio-codec@1a {
> u80: gpio@21 {

Yes.


Best regards,
Krzysztof
