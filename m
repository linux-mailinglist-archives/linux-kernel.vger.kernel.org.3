Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E23521426
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiEJLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbiEJLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:50:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797D1FE3C0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:46:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g23so19656740edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9fc4DPby0hC3+wp0CTHo7fj7huwHR34h2xJeQIEyKY8=;
        b=LAg58hFgcQjOa7ynGutntPZJEMGXJv1Et0eD5ui2671PeMFEwvfqHdTYnBM6eokYMd
         wRRV60rb7iWB+41Zdm/YyBL2KjKJ3ioaF1MQla/cPHcGqKe+DFvjBtAU1fIeRJmlaV0O
         S1gvtmfVIXm7lA7YgPfB2iU8+O07RiPWmNR1/vx+JunEEFPKt0GmmmI0Fc1Io2IRepQ9
         1hrwRAluEvpYkHiPmWlFDNdwrJWD2/4WE0mIi2WE1LAjY79s4sThtMu5+EhAY2XbZHUh
         2vpYeQ9oq77QfD/mShfKO5/b9WcogCTUqzJgpkDCshB8Jpc8P2oXpSDBmaYonMxFdJ3E
         F5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9fc4DPby0hC3+wp0CTHo7fj7huwHR34h2xJeQIEyKY8=;
        b=vVngJPRvytPkGqRIR8csjWjYUr/XlJuWMNbqN89CA+/EVVe07luE0rKSPL2kwipLxV
         Gbc7emroo67CMsDZCyWZ9w5yiIiccNU8vGCv/OQ9QPjZpRlSymwQ6ph06ZOfm2bR9QVk
         +RD0VhF8p9j16MiVcigmXMXCDym0v1pdMScAjHxPE+lHfwzJwy42Wc2w3J465QFj0oLS
         O8PvUrrWbESpXHAjVb0PnNyngEYk7gH97jaGvCoSgHPlwVohMWa4rJopvi5LKtA6ylMR
         YnJV5wYMrbmIexc4xFsOayoeMXbpRzq5TZqtkicVcPjVwRb2ODVZw2PBgkve97FQrfLC
         Iwyg==
X-Gm-Message-State: AOAM530HqP1PhXwjQ3aJTCz1eCGI654E7oHrm6AdvrZZIWixOUTyQKsF
        5J5BZw6IoZwwWGi0WHKie8WCxw==
X-Google-Smtp-Source: ABdhPJzXElWmmblik/m1NRxWy3j+yFO70xDN/HGVqbxKjXrf0egxTRK9s5LgEDH6z4dYkGjxH8UvPQ==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr22408384edb.118.1652183200869;
        Tue, 10 May 2022 04:46:40 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q23-20020a1709060f9700b006f3ef214dbdsm5972294ejj.35.2022.05.10.04.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 04:46:40 -0700 (PDT)
Message-ID: <fde74400-34aa-df80-5af5-cb4ee89c8e6f@linaro.org>
Date:   Tue, 10 May 2022 13:46:38 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+HBbNE1w5w6c8MwMuSwCFzjnyKOQ7Y0MV4bPijJW3rekWLo4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 13:41, Robert Marko wrote:
> On Tue, May 10, 2022 at 12:20 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 09/05/2022 13:00, Robert Marko wrote:
>>> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
>>>
>>> They feature the same CPU, RAM, and storage as well as the form factor.
>>>
>>> However, eDPU only has one SFP slot plus a copper G.hn port.
>>>
>>> In order to reduce duplication, split the uDPU DTS into a common one.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>>>  .../boot/dts/marvell/armada-3720-eDPU.dts     |  14 ++
>>>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 148 +---------------
>>>  .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 163 ++++++++++++++++++
>>>  4 files changed, 179 insertions(+), 147 deletions(-)
>>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
>>> index 1c794cdcb8e6..104d7d7e8215 100644
>>> --- a/arch/arm64/boot/dts/marvell/Makefile
>>> +++ b/arch/arm64/boot/dts/marvell/Makefile
>>> @@ -1,6 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  # Mvebu SoC Family
>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>>> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>> new file mode 100644
>>> index 000000000000..6b573a6854cc
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>> @@ -0,0 +1,14 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "armada-3720-uDPU.dtsi"
>>> +
>>> +/ {
>>> +     model = "Methode eDPU Board";
>>> +     compatible = "methode,edpu", "marvell,armada3720";
>>
>> You need also bindings for the board compatible. Someone should convert
>> the Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt to YAML.
> 
> Ok, I can convert the SoC compatibles at least for now.
> Any advice you can give me on how the handle the Espressobin boards
> having multiple board-specific compatibles?
> For example, Espressobin V7 has:
> "globalscale,espressobin-v7", "globalscale,espressobin"
> 

Documentation/devicetree/bindings/arm/fsl.yaml

>>
>>> +};
>>> +> +  sfp_eth1: sfp-eth1 {
>>
>> Generic node names, please.
> 
> Can you give me an example of what would be appropriate here because the SFP
> bindings example utilizes the same naming scheme as used here?

"sfp" if you have only one sfp node.

> 
>>
>>> +             compatible = "sff,sfp";
>>> +             i2c-bus = <&i2c1>;
>>> +             los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
>>> +             mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
>>> +             tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
>>> +             tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
>>> +             maximum-power-milliwatt = <3000>;
>>> +     };
>>> +};
>>> +
>>> +&sdhci0 {
>>> +     status = "okay";
>>> +     bus-width = <8>;
>>> +     mmc-ddr-1_8v;
>>> +     mmc-hs400-1_8v;
>>> +     marvell,pad-type = "fixed-1-8v";
>>> +     non-removable;
>>> +     no-sd;
>>> +     no-sdio;
>>> +};
>>> +
>>> +&spi0 {
>>> +     status = "okay";
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&spi_quad_pins>;
>>> +
>>> +     spi-flash@0 {
>>
>> Run dtbs_check and fix the errors.
> 
> Ok, will split the DTSI and eDPU commits and fixup nodes in between.
>>
>>> +             compatible = "jedec,spi-nor";
>>> +             reg = <0>;
>>> +             spi-max-frequency = <54000000>;
>>> +
>>> +             partitions {
>>> +                     compatible = "fixed-partitions";
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     /* only bootloader is located on the SPI */
>>> +                     partition@0 {
>>> +                             label = "firmware";
>>> +                             reg = <0x0 0x180000>;
>>> +                     };
>>> +
>>> +                     partition@180000 {
>>> +                             label = "u-boot-env";
>>> +                             reg = <0x180000 0x10000>;
>>> +                     };
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&pinctrl_nb {
>>> +     i2c2_recovery_pins: i2c2-recovery-pins {
>>> +             groups = "i2c2";
>>> +             function = "gpio";
>>> +     };
>>> +};
>>> +
>>> +&i2c1 {
>>> +     status = "okay";
>>> +     pinctrl-names = "default", "recovery";
>>> +     pinctrl-0 = <&i2c2_pins>;
>>> +     pinctrl-1 = <&i2c2_recovery_pins>;
>>> +     /delete-property/mrvl,i2c-fast-mode;
>>> +     scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>>> +     sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>>> +
>>> +     nct375@48 {
>>
>> Generic node names, representing class of a device.
> Ok, will rename in v2.
>>
>>> +             status = "okay";
>>
>> OK status is by default, why do you need it? Also, it goes as last property.
> 
> It's not needed, I have not changed any nodes, they are just
> copy/paste during the DTS split.
> Will drop it in v2.
> 

Hm, but the node names were different in original DTS, so this is not a
simple split. In such case better to correct coding styles in one patch
(node names, status etc) and then perform the split. The split should
create the same output DTB, which is not the case here.

Best regards,
Krzysztof
