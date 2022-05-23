Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C976B5311EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiEWO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbiEWO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:26:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BA2B255
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:26:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so25873338lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G8pSkplAhfSaVtqePqq8XjdcWWlymy9x8EhPSya+xcQ=;
        b=lyhx55/zAIKWU6MNtflmwMRqCG3WK3SvnlXBXjiHgsLYWJSvlsGHURt2CfjXGw+w5Z
         9T/POO0IfWlxnm4ldWUCRi3apjNO415HWjuc39OoXNAAwX4IGXl8DNXTlHR+XFeoSJ9p
         ANhgfgJGy6QNR135WdYD6NGcQ6YwEPM2b22/HGCJoWDokpUm/cpTJdqUsFkRKzI83br0
         lHzoZTZdQLhPjghrdM9RLgmXELx7Y0Hp5ahgfmltIRWRh0vIOfL6daJIuXxC4l3vqGpQ
         MvPNaDEINtn11/AdRN7lye2gTDxYFv0orSrAwwsS1jgDwvlJjV1ZgVVNrOdTlpgFMDw2
         P81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G8pSkplAhfSaVtqePqq8XjdcWWlymy9x8EhPSya+xcQ=;
        b=sqrDZEjP7HG03oUEt83/sfsYNfKwJYgiCwNpT5e5u44p9kcc6W85yY0qtPFsdBdjSB
         ULgKK3lop4xHXq5FQY4C/G1gWUKfe6QdW6gOeNITVwPTpGr4ScLLyPhvWJJIwJT39v1P
         EHvrG4QWUL7AbFbDs3dQrgUEZZ1cX5K60zULX2hg/V6LTc7QujCm8ukqtnQRp5JfwTHK
         qrjiYY63dv3Hn0kJBIfg8R9MqRKj9UbjktiopvRyTB75SXOPRQ9uxWclqpTulArePWMu
         Mj5+lrMsUFdPJD4e9N5LX0pbVL42iRAQ0vXTrvDaSV4csBIhhMWsSEyioWi3QZx4YSc0
         2XDw==
X-Gm-Message-State: AOAM531FLABBAD9FYEeAKqGu/t/aDzPZ0XngQgQ23OGKz7SFhGK8464q
        OH0M8TmliZ0bt01bQYwzfilahg==
X-Google-Smtp-Source: ABdhPJz+utSxZTs2n/fqh1e5tT8yA+mZZbm0vbet8rrFRC+nV5H+flGflipWNlxlkpty5umsiRR7UQ==
X-Received: by 2002:a05:6512:33ce:b0:478:83ea:9e61 with SMTP id d14-20020a05651233ce00b0047883ea9e61mr433374lfg.264.1653316001764;
        Mon, 23 May 2022 07:26:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h16-20020a0565123c9000b00477a0eb9ab8sm1056497lfv.133.2022.05.23.07.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:26:41 -0700 (PDT)
Message-ID: <62562cdf-93e3-f642-5bbd-48329eff33ea@linaro.org>
Date:   Mon, 23 May 2022 16:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomer Maimon <tmaimon77@gmail.com>
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
        =?UTF-8?Q?Bj=c3=b6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-12-tmaimon77@gmail.com>
 <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org>
 <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
 <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 16:22, Geert Uytterhoeven wrote:
> Hi Tomer,
> 
> On Mon, May 23, 2022 at 4:03 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>> On Mon, 23 May 2022 at 12:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>> On 22/05/2022 17:50, Tomer Maimon wrote:
>>>> Add binding document and device tree binding
>>>> constants for Nuvoton BMC NPCM8XX reset controller.
>>>>
>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> 
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
>>>> @@ -0,0 +1,124 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +// Copyright (c) 2022 Nuvoton Technology corporation.
>>>> +
>>>> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
>>>> +#define _DT_BINDINGS_NPCM8XX_RESET_H
>>>> +
>>>> +#define NPCM8XX_RESET_IPSRST1                0x20
>>>> +#define NPCM8XX_RESET_IPSRST2                0x24
>>>> +#define NPCM8XX_RESET_IPSRST3                0x34
>>>> +#define NPCM8XX_RESET_IPSRST4                0x74
>>>
>>> What are these? All IDs should be incremental, decimal and start from 0.
>>
>> Register offset, we use the same method in NPCM7xx. please refer
>> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
>>
>> and the driver asserts the reset according to the reset include definitions
> 
> So if they're easy to look up the values, you could do without the
> definitions? Cfr. the interrupts properties in .dtsi files, where we
> typically just use the hardcoded numbers.
> 
> If you do decide to keep them, a comment explaining their origins
> would be useful.
> 
>>>> +
>>>> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
>>>> +#define NPCM8XX_RESET_GDMA0          3
>>>
>>> IDs start from 0 and do not have holes.
>>
>> This represents the reset BIT in the reset register.
> 
> Likewise, I think it's a good idea to document that in a comment, cfr.
> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/power/r8a7795-sysc.h#L8

Renesas is also doing it not correct (just like many others). The
bindings are not for register bits or offsets. Such data can be DTS but
not part of bindings. Imagine now you made mistake in this register
offset and hardware uses slightly different value. What now? Change
bindings? No. Bindings hold here ID, the abstraction, and ID stays fixed.


Best regards,
Krzysztof
