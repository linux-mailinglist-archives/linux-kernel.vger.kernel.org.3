Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5B544D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiFINWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiFINWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:22:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAA18373
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:22:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n28so31188188edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nPMBIqsJZwcPYHy4tA1bMGL8vPZI0Il4YAYQQ5QYP70=;
        b=HcyOqScH0H7f0QBbSZpnZWOuxME9FUTvh0o4cXzuLeQk+NOezh1q7LxxcYFZFNw6zU
         mZniV6vvuxjuq/HjCk6/69/omoJIFpua/zC/93/JWnALilG9KhAyGa9gcJ4kgLg6R9Vt
         pZW6nyofEFdiiGFNE+i8EhE9mebe/H8CMU/KCEy/nj87uAZy2ryT/0BvVfwSmRm5kdk3
         uErkK9ou5SC8ttxhJFbJo4KLQuWVsH4uRg56RWUuqbr/fg1iUbt2ecsdwSxi4HLg6B9b
         uWNziFNvxq0Mm4Jc3V5lIfdIrksokxD/8ZBurL9kl5GI1zCostGBmEYlaJCm0vtjsMrP
         QjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nPMBIqsJZwcPYHy4tA1bMGL8vPZI0Il4YAYQQ5QYP70=;
        b=OTrj1SloTF/U1seiqZRCdnXd9o86bkjHplq5qOwi3Q79lNgMIxb0bE8l/x40hlHQi2
         3EXGRjPTFfNNzGJSyPyGWdjEjUhQRKR+xzqJYlnepA8B9/YwKWtIPw+Jc8XD/upPjJ7Y
         SK39omUHag1pN5TairzMqqpcbPfWDRSPSZ/fg3ox2S8ae+7OWNGDMmK0oBHsUO/gCzW/
         RIkHRSHKJubIxPMV8hUv08laO3g5KG7v3dxpwXUGXDFfmhH6OSuDcJODLJ/9HXfZyUEI
         1hLz0lASc7CPGGYIBYxJu1mXOqn0q8bhokL7C3hv8UJHL2CE/R5ZQze6pkpE2/kZ5k8E
         V5TQ==
X-Gm-Message-State: AOAM5326H4lMKCRqM07Y1u+0+EVCaNH8GeBXzDZvO1uReLtDgFo6iR3U
        h4Sct4pqw3ZPVDCjiqCo5W0Qrg==
X-Google-Smtp-Source: ABdhPJycqxez50LdWJaT0BJ8GA7qrEg33IF52lV1YBM9+fDCeVtIUlfKDd3+doY6QFvG1RpSBUGiyA==
X-Received: by 2002:a05:6402:27cc:b0:42d:de10:4b6c with SMTP id c12-20020a05640227cc00b0042dde104b6cmr46324557ede.424.1654780956908;
        Thu, 09 Jun 2022 06:22:36 -0700 (PDT)
Received: from [192.168.0.198] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709062ed600b006feb875503fsm2211664eji.78.2022.06.09.06.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:22:35 -0700 (PDT)
Message-ID: <082366b0-6811-b492-c68c-12f9a9ee512e@linaro.org>
Date:   Thu, 9 Jun 2022 15:22:32 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1geJyaDrP2CBY3FHe5y-L=bCptX1pzAkNypY+TS5vXzMA@mail.gmail.com>
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

On 09/06/2022 15:17, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comments.
> 
> On Wed, 8 Jun 2022 at 13:03, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/06/2022 11:56, Tomer Maimon wrote:
>>> Add binding for the Arbel BMC NPCM8XX Clock controller.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 63 +++++++++++++++++++
>>>  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 +++++++++++++++
>>>  2 files changed, 113 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>> new file mode 100644
>>> index 000000000000..e1f375716bc5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>> @@ -0,0 +1,63 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton NPCM8XX Clock Controller Binding
>>> +
>>> +maintainers:
>>> +  - Tomer Maimon <tmaimon77@gmail.com>
>>> +
>>> +description: |
>>> +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
>>> +  generates and supplies clocks to all modules within the BMC.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nuvoton,npcm845-clk
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: 25M reference clock
>>> +      - description: CPU reference clock
>>> +      - description: MC reference clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: refclk
>>> +      - const: sysbypck
>>> +      - const: mcbypck
>>> +
>>
>> I asked what is the suffix about and you replied "ck"... ok, so let's
>> make clear. This should be:
>>
>>     items:
>>       - const: ref
>>       - const: sysbyp
>>       - const: mcbyp
>>
>> or something similar, without the same suffix all over.
> The clock names are the same clock name in our spec, this why we
> prefer to leave the clock names as is.

The naming with useless suffixes does not help. If your spec had
"refclk_really_clock_this_is_a_clock" you also would insist on that? It
does not make sense.

>>
>>> diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
>>> new file mode 100644
>>> index 000000000000..229915a254a5
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
>>
>> Same comment as before. No changes here...
>>
> about the comments from V1::
> - Krzysztof: Filename - same as bindings, so nuvoton,npcm845-clk.h
> In NPCM7XX we use the same include file and clock source
> dt-binding
> https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
> dt-binding include
> https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> we prefer to be align with our older BMC version

Older has incorrect name, so do not align to incorrect one. What is the
logic behind having header not matching the bindings file? It makes it
only more difficult to connect these two.

> 
> - Krzysztof: Dual license, same as bindings.
> modified in the file * SPDX-License-Identifier: (GPL-2.0-only OR
> BSD-2-Clause) */
> the same license approved in en7523-clk include file and pushed to
> Linux kernel 5.19 :
> https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/en7523-clk.h

I don't understand this comment at all. I am not commenting about
en7523-clk.h. I am commenting about the header here - it should have
dual license. What en7523-clk.h has to do with it?

Best regards,
Krzysztof
