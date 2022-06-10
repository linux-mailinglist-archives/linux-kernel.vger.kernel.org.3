Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077325462F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348094AbiFJJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348108AbiFJJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:59:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D6B0431
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:59:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n28so34575301edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wq9gVVdD1/J4q1/EmaJv8aMnFa3KHaLmU1Qz7ppGNhE=;
        b=sESAYG8k3Sf9OIqWLT4EVVR1tdBRPzoeATKW1Bbr2Qec6XgtDTd0dLvf3JxpbsdtiN
         haM4S5D0p35YqjS96SRhlhV9PmgIBeJZRFmqLI2mTKsHDeogxhZjOgQrxOnzy+1/2XtD
         0eX4ckZuGDw9VkCsjWhZCr46CF8UjrkgRy6bgK/5g382J+YFtdU43gWuOYUyzULLe/G5
         0oLO+Ocf8dUlYZC2cquCijGI6UDKjYA4U3w5eOjWMvkknznKAeuz19JOqsRhoOxhN3jy
         C83YXicE7j8ja6i/EwLN5oSrZBoRFP5A1cJViH3BlNc9kFVxMxQaduFcPkr6w8n090DN
         bvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wq9gVVdD1/J4q1/EmaJv8aMnFa3KHaLmU1Qz7ppGNhE=;
        b=Nn2F5lcz0Ldo7LTLmoEksIWMCpHKryTsMkJmG7lAQ6gSQGH2ClYUnOf0T/z9tt2e6g
         lt0bDh38x0W1IDUjk/RiZUrkkoJJM/ZE1WJ+GWJZMBHp70Z0Aj+J1M2g6iPJsbZSL2Zj
         V31zI1/KqJE9nSx6wUkI/PlPZVjfn1FCkU2UzhbdGAgWI99PntLTyNvkQlXTK/nPZ8lb
         z0WIXn1WS8FlKkpnvQxQ+kqWlPFXQOJ4NsEI7jeWEcuJ8w5XIxPVpUYtxAa6slL0m/9h
         YsPmrdaZB9QLGq9KO2UxiK6yVzAnCyY+HECo3Phb0T9fVjkScXM4hI1DhgrIf6BGflI0
         YAwQ==
X-Gm-Message-State: AOAM530tWVwdptCSSrho4YFpeLS0fxuiGX9MoGth4fG/031ahMsB8Mi9
        uYTU83NZYviHIjH0b1g2Yt1cPw==
X-Google-Smtp-Source: ABdhPJznPfBVrxm6drYBka7ZGOrt2dIG3zy2ti6SB08YUWNwJwfIafeTfcbr7B/2U8M4buh900aY3w==
X-Received: by 2002:a05:6402:500b:b0:431:78d0:bf9d with SMTP id p11-20020a056402500b00b0043178d0bf9dmr22935174eda.184.1654855143357;
        Fri, 10 Jun 2022 02:59:03 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm11969760ejd.63.2022.06.10.02.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:59:02 -0700 (PDT)
Message-ID: <11245d23-76a2-1008-eac6-f396954857c7@linaro.org>
Date:   Fri, 10 Jun 2022 11:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device
 tree
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-19-tmaimon77@gmail.com>
 <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
 <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 00:29, Tomer Maimon wrote:
>>> +     clk_refclk: clk-refclk {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <25000000>;
>>
>> Ignored comment.
> Could we use it as a default clock-frequency?

In DTS? If my assumption, that this clock is not on SoC itself, is
correct, then the answer is no, you cannot. The clock physically sits on
the board, so it is defined by board DTS. Feel free to embed in SoC DTSI
most of the clock properties, but the core property - frequency - must
be outside.

>>
>>> +             clock-output-names = "refclk";
>>> +     };
>>> +
>>> +     /* external reference clock for cpu. float in normal operation */
>>> +     clk_sysbypck: clk-sysbypck {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <1000000000>;
>>
>> Ignored comment.
> same as above
>>
>>> +             clock-output-names = "sysbypck";
>>> +     };
>>> +
>>> +     /* external reference clock for MC. float in normal operation */
>>> +     clk_mcbypck: clk-mcbypck {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <1050000000>;
> same as above
>>> +             clock-output-names = "mcbypck";
>>> +     };
>>> +
>>> +     soc {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             compatible = "simple-bus";
>>> +             interrupt-parent = <&gic>;
>>> +             ranges;
>>> +
>>> +             gcr: gcr@f0800000 {
> I understand it sounds generic but I try to be as much compatible with NPCM7XX
> https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L91

Then fix NPCM7XX. Please do not multiple bad choices because it looks
similar. Fix the other wrong one.

>>
>> Ignored comment.
>>
>>> +                     compatible = "nuvoton,npcm845-gcr", "syscon",
>>> +                             "simple-mfd";
>>
>> This is not a simple-mfd... I see original bindings defined it that way,
>> but why? I think they should be corrected - remove simple-mfd from the
>> bindings and DTS.
> will remove in both places in V3
>>
>>
>>> +                     reg = <0x0 0xf0800000 0x0 0x1000>;
>>> +             };
>>> +
>>> +             gic: interrupt-controller@dfff9000 {
>>> +                     compatible = "arm,gic-400";
>>> +                     reg = <0x0 0xdfff9000 0x0 0x1000>,
>>> +                           <0x0 0xdfffa000 0x0 0x2000>,
>>> +                           <0x0 0xdfffc000 0x0 0x2000>,
>>> +                           <0x0 0xdfffe000 0x0 0x2000>;
>>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +                     #interrupt-cells = <3>;
>>> +                     interrupt-controller;
>>> +                     #address-cells = <0>;
>>> +                     ppi-partitions {
>>> +                             ppi_cluster0: interrupt-partition-0 {
>>> +                                     affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
>>> +                             };
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>> +     ahb {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             compatible = "simple-bus";
>>> +             interrupt-parent = <&gic>;
> 
>>> +             ranges;
>>> +
>>> +             rstc: rstc@f0801000 {
>>
>> Ignored comment.
>>
> I understand it sounds generic but I try to be as much compatible with NPCM7XX
> https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L109

Fix 7xx.


Best regards,
Krzysztof
