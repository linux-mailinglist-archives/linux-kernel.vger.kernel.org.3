Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B705462C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347330AbiFJJuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346666AbiFJJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:50:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4832F6D1B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:50:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x62so34533460ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rt0vsBETdsgUvTDEEF7Ic9okr/eCyvwvGWQNcegTZ1U=;
        b=K/yzPSh9wFBjDJiOA6mpuNoAmJIKYwK3g8Env7ES4l8idYzYh5vHjgqeOxkl5OR6bn
         IMj7pH0hNN2Hbo7fdFYujHzzlaDKoaPPfHTj7ois4W2c1KFVLn0j1kc8kPreMz+fwBD2
         8Y7cGMwLibjZGW9UUAyX77himHkESzcNGvtnAlQuUpORd6vmIxb5pD+jpchqbs8DPaIj
         QJpE1T69z+wZwgdXiAnaQrf79KtOQD3foIrBEiB1NjabSUmVvNpTXF/nBck0nNsBEuBA
         7BUPkg6E92dCrSV3VCVSZUnCfAbpDLrtjYK2KcdxC1RkfdaaJ1EXR9xblSWsZT6vQHQW
         b6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rt0vsBETdsgUvTDEEF7Ic9okr/eCyvwvGWQNcegTZ1U=;
        b=IPz00jLv1r41OUSK/Lh0XCyaLvphCabciNIErt4OtWTuDIF5LQO2JwRTWQTXPXF/q2
         1/ygQDc9/bVFTAd7PeIPwfbooa8C+XUPmo6k0udvzFCOBp4d+KXBCfOEybwfgBQllzr7
         ZuUVwhBeD6p/pUz6fYUuGrspl4HS1D7T67enPVc+4F7wYz1J8Mfh64xcZJGgx7kTNRm2
         z8FbxTrkbwF6a3KmpkI1c4TFSjwryRo1Oo/EVvOdKjPqcMTEcAwZ9LHrcW38lPIQ+ONh
         cFdABKq9B59M5piTNKtL7E488FfczByZx63YcTHdI0OJu9YPgUsPhovWZhgpPkS7Se3J
         gRIA==
X-Gm-Message-State: AOAM530JHpOUOr1LpWCNSKEnvBfL3vKbLrqmEk70Y8+YkLQdA+RSudTf
        DK/dX7y3pPAhagpJ+O1lWHoYXw==
X-Google-Smtp-Source: ABdhPJwbncSEwRQLaREXRi0rWknK/es2MLMTWpIk6/6WsQooAUY1QVyYSs0C9HIhLSoLy3pXr+xjPQ==
X-Received: by 2002:a05:6402:3551:b0:431:51e1:856f with SMTP id f17-20020a056402355100b0043151e1856fmr30811673edd.323.1654854599932;
        Fri, 10 Jun 2022 02:49:59 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yz17-20020a170906dc5100b0070b1ecdc12bsm10807528ejb.112.2022.06.10.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:49:59 -0700 (PDT)
Message-ID: <073fcd16-12ae-ed4f-5eac-534bf73e68fe@linaro.org>
Date:   Fri, 10 Jun 2022 11:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 06/20] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
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
 <20220608095623.22327-7-tmaimon77@gmail.com>
 <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org>
 <CAP6Zq1geJyaDrP2CBY3FHe5y-L=bCptX1pzAkNypY+TS5vXzMA@mail.gmail.com>
 <082366b0-6811-b492-c68c-12f9a9ee512e@linaro.org>
 <CAP6Zq1jaUH9g+xRvgT0Xn---A9S9Linn-TKLMgnoTq+xgbi74Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1jaUH9g+xRvgT0Xn---A9S9Linn-TKLMgnoTq+xgbi74Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 23:21, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> 
> On Thu, 9 Jun 2022 at 16:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 09/06/2022 15:17, Tomer Maimon wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks for your comments.
>>>
>>> On Wed, 8 Jun 2022 at 13:03, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 08/06/2022 11:56, Tomer Maimon wrote:
>>>>> Add binding for the Arbel BMC NPCM8XX Clock controller.
>>>>>
>>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>>> ---
>>>>>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 63 +++++++++++++++++++
>>>>>  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 +++++++++++++++
>>>>>  2 files changed, 113 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>>>>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..e1f375716bc5
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>>>> @@ -0,0 +1,63 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Nuvoton NPCM8XX Clock Controller Binding
>>>>> +
>>>>> +maintainers:
>>>>> +  - Tomer Maimon <tmaimon77@gmail.com>
>>>>> +
>>>>> +description: |
>>>>> +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
>>>>> +  generates and supplies clocks to all modules within the BMC.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - nuvoton,npcm845-clk
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: 25M reference clock
>>>>> +      - description: CPU reference clock
>>>>> +      - description: MC reference clock
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: refclk
>>>>> +      - const: sysbypck
>>>>> +      - const: mcbypck
>>>>> +
>>>>
>>>> I asked what is the suffix about and you replied "ck"... ok, so let's
>>>> make clear. This should be:
>>>>
>>>>     items:
>>>>       - const: ref
>>>>       - const: sysbyp
>>>>       - const: mcbyp
>>>>
>>>> or something similar, without the same suffix all over.
>>> The clock names are the same clock name in our spec, this why we
>>> prefer to leave the clock names as is.
>>
>> The naming with useless suffixes does not help. If your spec had
>> "refclk_really_clock_this_is_a_clock" you also would insist on that? It
>> does not make sense.
> Sorry but I don't understand why the clock name cause an issue, we
> prefer it will be the same as in our spec-clock diagram
> BTW, the same naming found in NPCM7XX
> https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt#L36

Because the names should not have irrelevant information.
interrupt-names should have "txirq". dma-names should not have "txdma".
clock-names should not have "refclock" or "refclk" because it is
irrelevant duplication. These are bindings, not DTS, so whatever you
have in your spec matters less. DTS is the representation of hardware
and there you can name clocks closer to the spec so it is easier for
you, if that's your preference.

And if your spec has "refclk_really_clock_this_is_a_clock" you still
should not use it.

Anyway, you should discuss it last time when I pointed it out. Instead
my comments were ignored and you decided to send v2. That's not how
discussion works and it will not bring you closer to your point.


Best regards,
Krzysztof
