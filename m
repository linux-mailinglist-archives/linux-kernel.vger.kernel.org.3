Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0474538D83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiEaJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiEaJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:12:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B12101E1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:12:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f9so25410477ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tCT50Fh+5piWSzBKb7EMdRddbudd57xtmdgm3CE6V14=;
        b=PGB/B7/Yzc2AzW6eApiu2Hn5uZicnKoLYS9im7otzR9PXX5JVzOTLEJELyx+CxnPXO
         +kH94qrP+Fl1d+WMT6EiSTc331sBIbuOTUPMvQwqTdp96XlohJi0+bXIk85NvMpqcHWv
         PMlCoYEKHzrRYolXGe6CxaIiSo0zu+GL7/Dddi2Ct3tghdM9ybWi3ZNw7TBTzEDJkFtw
         cihKAuay8eov8BIzWAq7KZRlpmNFYRlPBX/QyxeHOhR/CYTDhgqURHViPZmrT2Mink6l
         PAvfNK3B03KiznBxeXA4yCAhQ3oPrJLGl/EwlKLVqBkbF7e5sr6nOCIUcqTHeVzg38uv
         xw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCT50Fh+5piWSzBKb7EMdRddbudd57xtmdgm3CE6V14=;
        b=bJgMgnPi6dJgLQ/j2beGOYmk9u5nufHRM6tpVGw9w51hTA/BVd0QFaH5/gPpCFxmPC
         zDdyUD/CEbiMN8IThU5uPpZr7vOgoZaIOgh3ZZzPCieT97SAVzb7BhUh3X6p/mjwf8sB
         fDwHO16bLQamOHK/eDUIGprdBeLlAzT9yK0HV5IA9JPYjSHhkIwNTyHJyBGpASwSzIl+
         Ln5DgGAe45qKJ4NqLT2j2ZN/rMWtB/8kzz+dqlxe65hhcqMZYuOnFBI8eWOXmbJUfEwF
         P104pqcENx1R0ZtNpQ2Aq4Svzd47ObyUtWgr83MEA+F29dl21UD0CWvV8o21ZW4OTOfF
         WTCQ==
X-Gm-Message-State: AOAM531tXI4UFW1OnsGL1Q6B1Fs9C7IT7GOrPjRrOmVRRws8RGH+gCUg
        F0O9XXAtFASTfI7CKJRjDpIang==
X-Google-Smtp-Source: ABdhPJwO4McNyf+LCq8d8GlFSdkiQA/rXG1KcssvcKs4gyMH/JmH0M8NOi6N7hux818VUWZb9IUbxw==
X-Received: by 2002:a17:907:d16:b0:6f8:c054:29ac with SMTP id gn22-20020a1709070d1600b006f8c05429acmr53469868ejc.96.1653988319462;
        Tue, 31 May 2022 02:11:59 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mc22-20020a170906eb5600b006feb002a620sm4737178ejb.1.2022.05.31.02.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 02:11:58 -0700 (PDT)
Message-ID: <e4ef2056-c990-b308-a9d5-98f11ac0ba51@linaro.org>
Date:   Tue, 31 May 2022 11:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] dts: socfpga: Add Google Chameleon v3 devicetree
Content-Language: en-US
To:     Alexandru M Stan <amstan@chromium.org>
Cc:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>, soc@kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org
References: <20220530130839.120710-1-pan@semihalf.com>
 <20220530130839.120710-3-pan@semihalf.com>
 <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org>
 <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:20, Alexandru M Stan wrote:
> Hello Krzysztof
> 
> On Mon, May 30, 2022 at 11:56 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/05/2022 15:08, Paweł Anikiel wrote:
>>> Add devicetree for the Google Chameleon v3 board.
>>>
>>> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
>>> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
>>
>> Your SoB chain looks odd. Who did what here?
> 
> Sorry about this.
> 
> It was mainly Pawel but I did some small changes at some point before
> it landed in our tree (particularly the GPIOs).

Then usually Paweł should be the owner of the patch, not you.
Alternatively it could be also co-developed.

> 
>>
>>> ---
>>>  arch/arm/boot/dts/Makefile                    |  1 +
>>>  .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
>>>  2 files changed, 91 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 023c8b4ba45c..9417106d3289 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
>>>       s5pv210-torbreck.dtb
>>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
>>>       socfpga_arria5_socdk.dtb \
>>> +     socfpga_arria10_chameleonv3.dtb \
>>>       socfpga_arria10_socdk_nand.dtb \
>>>       socfpga_arria10_socdk_qspi.dtb \
>>>       socfpga_arria10_socdk_sdmmc.dtb \
>>> diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>> new file mode 100644
>>> index 000000000000..988cc445438e
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
>>> @@ -0,0 +1,90 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2022 Google LLC
>>> + */
>>> +/dts-v1/;
>>> +#include "socfpga_arria10_mercury_aa1.dtsi"
>>> +
>>> +/ {
>>> +     model = "Google Chameleon V3";
>>> +     compatible = "google,chameleon-v3",
>>
>> You miss here enclustra compatible.
> 
> Does this make sense? I don't expect this device tree to boot/work on
> an enclustra motherboard. It's only really compatible with a
> "chameleon-v3".

You also do not expect it to boot on altr,socfpga, do you?

If I understood correctly, this board has physically Mercury AA1 SoM, so
that compatible should be there.

It's the same for every other SoM. Neither Google nor Enclustra are
special...

> 
>>
>>> +                  "altr,socfpga-arria10", "altr,socfpga";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart0;
>>> +             i2c0 = &i2c0;
>>> +             i2c1 = &i2c1;
>>> +     };
>>> +};
>>> +
>>> +&gmac0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&gpio0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&gpio1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&gpio2 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&i2c0 {
>>> +     status = "okay";
>>> +
>>> +     ssm2603: ssm2603@1a {
>>
>> Generic node names.
> 
> Dumb question: what does this mean?
> 
> Are you saying the name is too generic? As someone reading the
> schematics this would be immediately clear what chip it's talking
> about.

Let me clarify - please use generic node names, as asked by Devicetree
specification (2.2.1. Node Name Requirements). There is also list of
some examples in the spec, but you can use some other generic node name.

Several bindings also require it.

> 
>>
>>> +             compatible = "adi,ssm2603";
>>> +             reg = <0x1a>;
>>> +     };
>>> +};
>>> +
>>> +&i2c1 {
>>> +     status = "okay";
>>> +
>>> +     u80: u80@21 {
>>> +             compatible = "nxp,pca9535";
>>
>> Generic node names.
> 
> FWIW: Schematic is full of these pca9535 io expanders, only one (U80)
> is visible to linux on an I2C bus.



Best regards,
Krzysztof
