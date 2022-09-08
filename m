Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EC05B216C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIHO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiIHO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:59:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E021223B4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:59:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z20so20233126ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rs4Y8ca1KSOBzQSaXKtzIQIiEFtBZd3L46WD5pSs4zk=;
        b=evygGzatLG2WYoP289jHxz1e9Ntk3sXGNMF4pNktzLUF9JMbu9dsXox9I3rbOoQ1jP
         rvjU0AO/hN0keZya3XNPzLqYdicHkQHjkB3i3TFgAYmOMVj720ceITYVbywuquGq+Rv+
         WUkSyOu30x5hxBFCC+MPvtjm1GN6QBC22cQr1CL3W0WPX9xJ2B08Odm+SpCVSsSVp0C1
         jo35Xl+h7fbg6rdzb+vazjcELg40xfdIvjGbC5zXNp5OdO/G3ivHQVxywXmG0M/UrzSy
         SuYKUjzXT8rxOf6EewolDIBxmvvgwA2jXGL1XblQQS1ApLAkC+3iZITR20OZLrN5Qxvj
         RHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rs4Y8ca1KSOBzQSaXKtzIQIiEFtBZd3L46WD5pSs4zk=;
        b=gg2pcpVnKFnCKK7Fi+IHiRltV845S7CvVFUW0VlqkR6ox3p7T1n+YvdoIDAxRvVxKH
         5iogGhKcjk9zDIhy/iMKh+EWJvd+Izcm185fYKbF2b7hT39qnzRwZJ66W3iy0OeCGLtd
         frd70ofpOVdmKdgJp3My3mYTGHu4vy3n5mvIOQwF+FauudsusLnq5CUM7n1XR9HLoYAP
         6xlbKDxCKoKRGgb0WfulHmCfkJCxVmhwLk/tHGXrKf/KA2rcgfS6+5/B5D5SUahFg2eB
         0hYBughJmigDE4Vh3+lXL/dHxDhoXIOzS2l5RJYaVj5eYbcrkW6u625SEvGpHFc5JqVu
         1t1A==
X-Gm-Message-State: ACgBeo02SP8K45RKz17efOMMd3erys5/8dGTMaogFcLGlCGM1FBF9CKC
        VSfaU/eaFwpGg/lw7OwXTku4oA==
X-Google-Smtp-Source: AA6agR7SGoIqtCzqO7qLh0VevzpNTbtZJjuLKOfz58ReN20z1jZqaqK5SjtCxIr4O3jvpL9RTZRaCQ==
X-Received: by 2002:a05:651c:211d:b0:266:20b6:ae57 with SMTP id a29-20020a05651c211d00b0026620b6ae57mr2527537ljq.108.1662649147104;
        Thu, 08 Sep 2022 07:59:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e7012000000b00261ca0f940esm3097280ljc.62.2022.09.08.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:59:06 -0700 (PDT)
Message-ID: <dc22442d-83c0-e6b7-a356-9a6e8e4d8a83@linaro.org>
Date:   Thu, 8 Sep 2022 16:59:05 +0200
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
 <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
 <MWHPR11MB1693A5AF16E14FFA06D80653EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MWHPR11MB1693A5AF16E14FFA06D80653EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
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

On 08/09/2022 16:50, Jerry.Ray@microchip.com wrote:
>>>>> The SAMA5D3-EDS board is an Ethernet Development Platform allowing 
>>>>> for evaluating many Microchip ethernet switch and PHY products.  
>>>>> Various daughter cards can connect up via an RGMII connector or an RMII connector.
>>>>>
>>>>> The EDS board is not intended for stand-alone use and has no 
>>>>> ethernet capabilities when no daughter board is connected.  As such, 
>>>>> this device tree is intended to be used with a DT overlay defining the add-on board.
>>>>> To better ensure consistency, some items are defined here as a form 
>>>>> of documentation so that all add-on overlays will use the same terms.
>>>>>
>>>>> Google search keywords: "Microchip SAMA5D3-EDS"
>>>>>
>>>>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>>>>> ---
>>>>> v5->v6:
>>>>>  - Replaced underscores in names where I can, improving naming.
>>>>> v4->v5:
>>>>>  - patch now applies to v6.0-rc2
>>>>> v3->v4:
>>>>>  - Fixed regulators as necessary to get the board to boot from SD Card.
>>>>> v2->v3:
>>>>>  - Alphabetized pinctrl entries.
>>>>>  - cleaned up a warning in the regulators section.
>>>>>  - License tweaked to 'OR MIT'
>>>>>  - Included Makefile change
>>>>> v1->v2:
>>>>>  - Modified the compatible field in the device tree to reflect Microchip
>>>>>    Ethernet Development System Board.
>>>>> ---
>>>>>  arch/arm/boot/dts/Makefile             |   1 +
>>>>>  arch/arm/boot/dts/at91-sama5d3_eds.dts | 309
>>>>> +++++++++++++++++++++++++
>>>>>  2 files changed, 310 insertions(+)
>>>>>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile 
>>>>> index 05d8aef6e5d2..e92e639a2dc3 100644
>>>>> --- a/arch/arm/boot/dts/Makefile
>>>>> +++ b/arch/arm/boot/dts/Makefile
>>>>> @@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>>>>>       at91-sama5d2_icp.dtb \
>>>>>       at91-sama5d2_ptc_ek.dtb \
>>>>>       at91-sama5d2_xplained.dtb \
>>>>> +     at91-sama5d3_eds.dtb \
>>>>>       at91-sama5d3_ksz9477_evb.dtb \
>>>>>       at91-sama5d3_xplained.dtb \
>>>>>       at91-dvk_som60.dtb \
>>>>> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts
>>>>> b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>>>>> new file mode 100644
>>>>> index 000000000000..b4fe1c5f2997
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
>>>>> @@ -0,0 +1,309 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>>>>> +/*
>>>>> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
>>>>> + *    Development System board.
>>>>> + *
>>>>> + * Copyright (C) 2022 Microchip Technology Inc. and its 
>>>>> +subsidiaries
>>>>> + *
>>>>> + * Author: Jerry Ray <jerry.ray@microchip.com>  */ /dts-v1/; 
>>>>> +#include "sama5d36.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "SAMA5D3 Ethernet Development System";
>>>>> +     compatible = "microchip,sama5d3-eds", "atmel,sama5d36",
>>>>> +                  "atmel,sama5d3", "atmel,sama5";
>>>>> +
>>>>> +     chosen {
>>>>> +             stdout-path = "serial0:115200n8";
>>>>> +     };
>>>>> +
>>>>> +     clocks {
>>>>> +             slow_xtal {
>>>>
>>>> No underscores in node names. Override by label.
>>>>
>>>>> +                     clock-frequency = <32768>;
>>>>> +             };
>>>>> +
>>>>> +             main_xtal {
>>>>> +                     clock-frequency = <12000000>;
>>>>> +             };
>>>>> +     };
>>>>> +
>>>>> +     gpio {
>>>>> +             compatible = "gpio-keys";
>>>>> +
>>>>> +             pinctrl-names = "default";
>>>>> +             pinctrl-0 = <&pinctrl_key_gpio>;
>>>>> +
>>>>> +             button-3 {
>>>>> +                     label = "PB_USER";
>>>>> +                     gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
>>>>> +                     linux,code = <0x104>;
>>>>> +                     wakeup-source;
>>>>> +             };
>>>>> +     };
>>>>> +
>>>>> +     memory@20000000 {
>>>>> +             reg = <0x20000000 0x10000000>;
>>>>> +     };
>>>>> +
>>>>> +     vcc_3v3_reg: buck-regulator-1 {
>>>>
>>>> Keep consistent prefix or suffix, so:
>>>> regulator-buck-1
>>>>
>>>>> +             compatible = "regulator-fixed";
>>>>> +             regulator-name = "VCC_3V3";
>>>>> +             regulator-min-microvolt = <3300000>;
>>>>> +             regulator-max-microvolt = <3300000>;
>>>>> +             regulator-always-on;
>>>>> +     };
>>>>> +
>>>>> +     vcc_2v5_reg: ldo-regulator-2 {
>>>>
>>>> regulator-ldo-1
>>>> (why numbering of LDO regulators starts from 2? keep some sense in 
>>>> this)
>>>>
>>>>
>>>
>>> There are N regulators on the board, so they are numbered 1 thru N.
>>> Regulator 2 is regulator 2 whether it's a buck or LDO.
>>
>> So if this is supposed to match board schematics (which is good idea), then maybe just "regulator-2"? The point is to have same generic name and customize either prefix or suffix, but not both.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I prefer names to be descriptive, but I suppose I can have the name generic and add a comment into the dts file.
> However, the comment doesn't make it into the loaded device tree.  Would you be okay with "regulator-2-ldo"?

You have the descriptive name in the regulator-name property, but ok,
can be in node name as well.




Best regards,
Krzysztof
