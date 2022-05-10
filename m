Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9592A5215F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiEJMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiEJMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:55:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05791B7A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:50:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so32798480ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZF8DHbmS388Np7uc8s/GbJpWl+U//ZF9U03m6TrvUIk=;
        b=ctEjS1mw40rwGEQrV75cPoX/8cKyE3G3wc99zCNkX/1TgQE/cgMkEPwEe62E7AaiE3
         nnZ9Rl8xfKJh1NCdVZ8EFwl++UI1129pwpPS1FMtgKe7rmOBQcp8Z41wLEDrI9j1D8yN
         C3z58X9tesEVEMdWw54jtWTovNwD82aYDPb2qRjxo3boLJ2j/4oWGjQH439PxGU7KIlj
         eV8U+ZUkWQeDg8OopLJwoJdBpyMvci8UeQfNu8F1gew0ZCn9y9JEMJ6owwOySJvqq6QA
         IW4rlVqWvwlOHhA3PUAqjlnI+tS6wDy6/9S3GdsTZkp7uqfLnJxZ/yBHhueuHWH1lYrz
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZF8DHbmS388Np7uc8s/GbJpWl+U//ZF9U03m6TrvUIk=;
        b=JXOHove8p2vKvei1WlUy9zx4VRZOPx2RzBIJaNQiDcN5zKL0Oj0CtnHHDVFnHt24oV
         HKsT0V+H6OgVxpyvEajRabxQCYi/mrNm+NlS2TLQyC4nOTglgemmKcZph7zUosyx0H0E
         /IqWFH08P2tPMt95vQ+U0mi+JSl/mx7ChFT/2xx5/x0oVl5kXJ0fPhRu4q0IKdseZ9cC
         0dxOrK3gwk31xnr8QCan0r9rvVmTe/xG7SlKpMX6x845NOQ0iW279O9e4/N/vr9F6VXm
         dqIxo+EAQC8RjPN66Zbt/XiUHgPWj0RYMks+VrbnwnMgQTwY31y8SoPuaWKNg+jbFVvF
         DRWw==
X-Gm-Message-State: AOAM531W2pmALkV2bgerVXY0DN1TLtCLE8ai1N4zuBGxuX2CrCFFYSbo
        DCKW7XL2fquF9jaV1sxSZwXNgg==
X-Google-Smtp-Source: ABdhPJxe0M9EVK6O6ql1Fso5MfAt7H4Somn7p3Sh53wP8LDECzarboslO+4IUO0usgu7zJ0vOUFXUQ==
X-Received: by 2002:a17:907:d01:b0:6f4:d873:d7a0 with SMTP id gn1-20020a1709070d0100b006f4d873d7a0mr19758976ejc.717.1652187043646;
        Tue, 10 May 2022 05:50:43 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en20-20020a17090728d400b006f3ef214e20sm6110205ejc.134.2022.05.10.05.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:50:42 -0700 (PDT)
Message-ID: <0cdf8323-7f23-a291-9d20-6d182bc84913@linaro.org>
Date:   Tue, 10 May 2022 14:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: marvell: add support for Methode eDPU
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        shawnguo@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        kostap@marvell.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
References: <20220509110028.144226-1-robert.marko@sartura.hr>
 <20220509110028.144226-2-robert.marko@sartura.hr>
 <8e22cbf7-eee1-0ec7-10f9-3839ec80dfbf@linaro.org>
 <CA+HBbNE1w5w6c8MwMuSwCFzjnyKOQ7Y0MV4bPijJW3rekWLo4w@mail.gmail.com>
 <fde74400-34aa-df80-5af5-cb4ee89c8e6f@linaro.org>
 <CA+HBbNGWbGu73JtCb68QMhF6o9KrcfZH2AtOL6jUAnxrmCBcsQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+HBbNGWbGu73JtCb68QMhF6o9KrcfZH2AtOL6jUAnxrmCBcsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 14:43, Robert Marko wrote:
> On Tue, May 10, 2022 at 1:46 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/05/2022 13:41, Robert Marko wrote:
>>> On Tue, May 10, 2022 at 12:20 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 09/05/2022 13:00, Robert Marko wrote:
>>>>> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
>>>>>
>>>>> They feature the same CPU, RAM, and storage as well as the form factor.
>>>>>
>>>>> However, eDPU only has one SFP slot plus a copper G.hn port.
>>>>>
>>>>> In order to reduce duplication, split the uDPU DTS into a common one.
>>>>>
>>>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>>>> ---
>>>>>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>>>>>  .../boot/dts/marvell/armada-3720-eDPU.dts     |  14 ++
>>>>>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 148 +---------------
>>>>>  .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 163 ++++++++++++++++++
>>>>>  4 files changed, 179 insertions(+), 147 deletions(-)
>>>>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>>>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
>>>>> index 1c794cdcb8e6..104d7d7e8215 100644
>>>>> --- a/arch/arm64/boot/dts/marvell/Makefile
>>>>> +++ b/arch/arm64/boot/dts/marvell/Makefile
>>>>> @@ -1,6 +1,7 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>>  # Mvebu SoC Family
>>>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>>>>> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
>>>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>>>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>>>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>>>>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>>>> new file mode 100644
>>>>> index 000000000000..6b573a6854cc
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>>>> @@ -0,0 +1,14 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include "armada-3720-uDPU.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "Methode eDPU Board";
>>>>> +     compatible = "methode,edpu", "marvell,armada3720";
>>>>
>>>> You need also bindings for the board compatible. Someone should convert
>>>> the Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt to YAML.
>>>
>>> Ok, I can convert the SoC compatibles at least for now.
>>> Any advice you can give me on how the handle the Espressobin boards
>>> having multiple board-specific compatibles?
>>> For example, Espressobin V7 has:
>>> "globalscale,espressobin-v7", "globalscale,espressobin"
>>>
>>
>> Documentation/devicetree/bindings/arm/fsl.yaml
> 
> Thanks, now it makes sense.
> 
>>
>>>>
>>>>> +};
>>>>> +> +  sfp_eth1: sfp-eth1 {
>>>>
>>>> Generic node names, please.
>>>
>>> Can you give me an example of what would be appropriate here because the SFP
>>> bindings example utilizes the same naming scheme as used here?
>>
>> "sfp" if you have only one sfp node.
> 
> There are 2 SFP nodes in total, that is why they are named according
> to the ethernet controller
> to which they are connected.
> uDPU has 2 SFP slots while eDPU has 1, so one was moved to uDPU DTS.

Ah, then let it be. sfp-1 and sfp-2 would also work, but that's not
important.


Best regards,
Krzysztof
