Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA554E22C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377078AbiFPNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377132AbiFPNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:39:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EC2B251
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:39:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z17so1544839pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tZJ0udOOwaCxWMXlTkBG0pv6kYWe5fFc5cXr8AFWGxw=;
        b=IwB4vF+O7bkw0gmnipzROvuYX3jurvUS9fS3KCU/sdTK5DVzRyzIRSso7yMWQoR4XB
         +Ly595kBXCxhOfpHUDyAuLED/Td18kNYUEs6tzy2QG/BQb9uh5ederuqiMvkM0hVkDPx
         SfKvDeJfQDtbX0O0Mt57c/vkA5TO+7QYEtpRHBUcqW8tNQ9p0cgQt7NNm69X5UgNvq0b
         ZqK7E7hlY9kvnStImocycSZF3pBAgUAqcgarP02SUIQS3uM4BQFX8Jg7sBxjf8W53zxB
         YCPn7MuPyS4SMinubCY6953K6Qe+2cYsTo6UuP4BkvGxHlfxc9stUYIJFUq72+T/2o0Y
         TFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tZJ0udOOwaCxWMXlTkBG0pv6kYWe5fFc5cXr8AFWGxw=;
        b=bPLshLSbBHDdIs+774tZI0xv6p1cZyRj3eEJEJoe3rM5Qu4vWK49H4XiG+1mzToUYI
         w5eL/AePE15uvnmB+yHM4kbjNg0Ger7AFWgc6b7xgeNNjgsq0T0Etj6A8jNINbY0DYmm
         h7taPQC+vkDUePPDFUpqT5HaZhV4EiF6MlvvR7WAGDSox6JQ9m0o/eFb9TIWEqr8LFxm
         E+M2H6YXfU+YyGzUG1W+rI+betj4irqhmx9sIZC+pChRyOQ8uvgHlvkmXEHzUmiHUSkB
         LuoIy39y+8/a6BmmfwSo5YewyfaaLcUvbkc7lb4ZgbGkZVNo9a8D4oCvf6+vEjFH/QhO
         tbng==
X-Gm-Message-State: AJIora8s7/UmpP0Pn1DN9QGpiFfCtPNUZFfPHdI5ndOzLKN9utk3gLzO
        Iv2IZh+/w85D+2dhAtarOzyVZw==
X-Google-Smtp-Source: AGRyM1s1cA2evr96a50L5BABFDORqGyFaQ17SBTfpLNuKCJK5lJgbJW8qW9c08KC/QyKvvh+ZdCv8w==
X-Received: by 2002:a63:3e0b:0:b0:40c:42db:6601 with SMTP id l11-20020a633e0b000000b0040c42db6601mr161415pga.586.1655386740360;
        Thu, 16 Jun 2022 06:39:00 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b001e667f932cdsm3822017pje.53.2022.06.16.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:39:00 -0700 (PDT)
Message-ID: <d3432cce-079e-3d6d-91df-6da10bd69d08@linaro.org>
Date:   Thu, 16 Jun 2022 06:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for
 NPCM8XX
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
 <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
 <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
 <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org>
 <CAP6Zq1j=x3OcOPSOjJJmOcze7ziM=oWcKdbYzoHhGnvZipu_UQ@mail.gmail.com>
 <e6e478a5-9080-fb2f-9ccd-2490cdfab4c7@linaro.org>
 <CAP6Zq1gy=rj-wyqqNQF+Pt1dtHsf+90AnTGTqt-v9madj8tfGA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1gy=rj-wyqqNQF+Pt1dtHsf+90AnTGTqt-v9madj8tfGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 06:24, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> On Wed, 15 Jun 2022 at 20:03, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/06/2022 02:25, Tomer Maimon wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks for your clarification.
>>>
>>> We can remove the dt-binding file and use numbers in the DTS,
>>> appreciate if you can answer few additional questions:
>>> 1. Do you suggest adding all NPCM reset values to the NPCM reset
>>> document or the reset values should describe in the module
>>> documentation that uses it?
>>
>> What is "NPCM reset document"? Are these reset values anyhow different
>> than interrupts or pins?
> No, they represent the same values.


We do not document in the bindings actual pin or interrupt numbers...

>>
>>> 2. Some of the NPCM7XX document modules describe the reset value they
>>> use from the dt-binding for example:
>>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/adc/nuvoton%2Cnpcm750-adc.yaml#L61
>>
>> This is NPCM750
>>
>>> If we remove the NPCM8XX dt-binding file should we describe the
>>> NPCM8XX values in the NPCM-ADC document file?
>>
>> What is NPCM-ADC document file? What do you want to describe there?
>> Again - how is it different than interrupts?
> It is not different from the interrupts.
> I will remove the dt-binding reset include file, the reset property
> will use numbers and not macro's.

I have no clue what are you referring now... This is NPCM8xx and it has
no binding header with reset values. What to remove then?


Best regards,
Krzysztof
