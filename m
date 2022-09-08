Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D35B2062
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiIHOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiIHOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:19:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8681CB31
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:19:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l12so11648882ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wC85BMBPCwzTUwMd5Iag14pSJSSMz62X/DvEOmCC7v0=;
        b=GC7Sm8EwfdG/SPyUbSDJeCvfdERfhkmWMiZdQdgifYEGdd4KB6SyaQ3WoJlbRzOODX
         IDguqgEb8Zi2PH6/+S0Phelb3su/ae3bOvbmN7EQnIdt9Eewrk50oe5DVXcX0rbyXInA
         rHA5sGYTKJ4T+j7JCfQ8vXtdYF/pw7SndhOGuScwIeF7lAbTfkdnCNtHBeM4W6crklAo
         OJLIwGFaljsfhs7SPyr5qAdJMO4tdGk4B13/9C7/Nqd/tLH5mscxJQxDxOujzu5H/7K8
         SjviMxIKgfjJD1lAdgBj3xTul5085kO3FcOp7FBWg9ZglB9veC92XkeATEu+Ac7vRVmV
         wPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wC85BMBPCwzTUwMd5Iag14pSJSSMz62X/DvEOmCC7v0=;
        b=M3cKP1mr2uJWoXuNFU2iVmT/eV5u2Jwb6iAYwRi9cFAZTnLwdsEHaOTLkyKR+OJLuw
         K2dMlcz9G1aGCJCQ5vVoSRFoTgHf+cIQp4+5aX3b802Ys9t2DVA46Ld+P4OGeGDLqezv
         OuukfPhGu7TM9gNKnANim6t57ESLoGwiFVuoAwfqO9ZF68NJ9ev8jGofV/9mGL9lH9rj
         uFo1F6xf6ARx3uZojQApkWDlb4LIqTJK7FfzSaz9/CMsAE8Y9rjjaaLrO/jRbdwUqu2J
         e3yAK0GUt4ZPJDraArKLtrRlP2bOFg85PAgDzbpTUk6SBPOFLb0VO/7iOnEgfNkQ5QR7
         gMqw==
X-Gm-Message-State: ACgBeo210cLhY//NiHWqwJT/4jgsgaD8YEwlspzgEiEi8AkdebRinXZi
        BOqpznoffTFPtwAzcXW8rxhuJg==
X-Google-Smtp-Source: AA6agR5LbtJnTgoJj/DZo2lO/FIkaBkG8A1ukcaizAdMCAvN14xYbvbVYP3tsXyVnTXovzmlfrs7+A==
X-Received: by 2002:a2e:8509:0:b0:26a:c954:978c with SMTP id j9-20020a2e8509000000b0026ac954978cmr2682289lji.471.1662646786983;
        Thu, 08 Sep 2022 07:19:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f4b000000b00492ce573726sm3065358lfz.47.2022.09.08.07.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:19:45 -0700 (PDT)
Message-ID: <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
Date:   Thu, 8 Sep 2022 16:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Content-Language: en-US
To:     Jerry.Ray@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
 <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
 <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 15:58, Jerry.Ray@microchip.com wrote:
>> On 02/09/2022 21:22, Jerry Ray wrote:
>>> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for 
>>> evaluating many Microchip ethernet switch and PHY products.  Various 
>>> daughter cards can connect up via an RGMII connector or an RMII connector.
>>>
>>> The EDS board is not intended for stand-alone use and has no ethernet 
>>> capabilities when no daughter board is connected.  As such, this 
>>> device tree is intended to be used with a DT overlay defining the add-on board.
>>> To better ensure consistency, some items are defined here as a form of 
>>> documentation so that all add-on overlays will use the same terms.
>>>
>>> Google search keywords: "Microchip SAMA5D3-EDS"
>>>
>>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>>> ---
>>> v5->v6:
>>>  - Replaced underscores in names where I can, improving naming.
>>> v4->v5:
>>>  - patch now applies to v6.0-rc2
>>> v3->v4:
>>>  - Fixed regulators as necessary to get the board to boot from SD Card.
>>> v2->v3:
>>>  - Alphabetized pinctrl entries.
>>>  - cleaned up a warning in the regulators section.
>>>  - License tweaked to 'OR MIT'
>>>  - Included Makefile change
>>> v1->v2:
>>>  - Modified the compatible field in the device tree to reflect Microchip
>>>    Ethernet Development System Board.
>>> ---
>>>  arch/arm/boot/dts/Makefile             |   1 +
>>>  arch/arm/boot/dts/at91-sama5d3_eds.dts | 309 
>>> +++++++++++++++++++++++++
>>>  2 files changed, 310 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile 
>>> index 05d8aef6e5d2..e92e639a2dc3 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>>>       at91-sama5d2_icp.dtb \
>>>       at91-sama5d2_ptc_ek.dtb \
>>>       at91-sama5d2_xplained.dtb \
>>> +     at91-sama5d3_eds.dtb \
>>>       at91-sama5d3_ksz9477_evb.dtb \
>>>       at91-sama5d3_xplained.dtb \
>>>       at91-dvk_som60.dtb \
>>> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts 
>>> b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>>> new file mode 100644
>>> index 000000000000..b4fe1c5f2997
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>>> @@ -0,0 +1,309 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>>> +/*
>>> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
>>> + *    Development System board.
>>> + *
>>> + * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
>>> + *
>>> + * Author: Jerry Ray <jerry.ray@microchip.com>  */ /dts-v1/; #include 
>>> +"sama5d36.dtsi"
>>> +
>>> +/ {
>>> +     model = "SAMA5D3 Ethernet Development System";
>>> +     compatible = "microchip,sama5d3-eds", "atmel,sama5d36",
>>> +                  "atmel,sama5d3", "atmel,sama5";
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +
>>> +     clocks {
>>> +             slow_xtal {
>>
>> No underscores in node names. Override by label.
>>
>>> +                     clock-frequency = <32768>;
>>> +             };
>>> +
>>> +             main_xtal {
>>> +                     clock-frequency = <12000000>;
>>> +             };
>>> +     };
>>> +
>>> +     gpio {
>>> +             compatible = "gpio-keys";
>>> +
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&pinctrl_key_gpio>;
>>> +
>>> +             button-3 {
>>> +                     label = "PB_USER";
>>> +                     gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <0x104>;
>>> +                     wakeup-source;
>>> +             };
>>> +     };
>>> +
>>> +     memory@20000000 {
>>> +             reg = <0x20000000 0x10000000>;
>>> +     };
>>> +
>>> +     vcc_3v3_reg: buck-regulator-1 {
>>
>> Keep consistent prefix or suffix, so:
>> regulator-buck-1
>>
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "VCC_3V3";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             regulator-always-on;
>>> +     };
>>> +
>>> +     vcc_2v5_reg: ldo-regulator-2 {
>>
>> regulator-ldo-1
>> (why numbering of LDO regulators starts from 2? keep some sense in this)
>>
>>
> 
> There are N regulators on the board, so they are numbered 1 thru N.
> Regulator 2 is regulator 2 whether it's a buck or LDO.

So if this is supposed to match board schematics (which is good idea),
then maybe just "regulator-2"? The point is to have same generic name
and customize either prefix or suffix, but not both.

Best regards,
Krzysztof
