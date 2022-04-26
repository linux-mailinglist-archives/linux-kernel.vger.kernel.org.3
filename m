Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370B50F8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbiDZJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346843AbiDZIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:45:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7991546;
        Tue, 26 Apr 2022 01:35:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bz24so12079749qtb.2;
        Tue, 26 Apr 2022 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MX4vOhzYQqxe/6ioulymTKqPZgxEMTYGPJeDxEb8L4A=;
        b=VL4pcSVBuJM2bnh8rLbrUm0y8adJi6vaYPktQzUL3HHS6E9fi4DCCoAt5fCxCg0BdE
         e+2lPWjBsrT2t300U1JCGqMuAtoqNaEkhLnHNTaNh6guaB4E1pbg0TDxF5LfrVK0hU1E
         lqARju3qAhWjmnYKrVoG5/S92P+MRImS+QoxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MX4vOhzYQqxe/6ioulymTKqPZgxEMTYGPJeDxEb8L4A=;
        b=OiNimLNb4iH2hSZAHu6Upt6LD9wQvzLcPOlhRmXZdgd0zhKb38cQD5VJMUd+71r5nQ
         9KMo5iss0l6Z0zmFKmleXtinS9giXzrUL7a0zGS7Ro3sXdYctWKaXyJNZ7Jk8cC3dmQa
         jdTkN5+HJG91tnuh8nLOpfVJHq2M1UqISyWxtpHLLS5EnHL5s4xV/kaclV5zhfwDe5gJ
         xJsj3frmrsVwxpuVlVjWh2WRJmq+6++h/3cPmOXmdL5tMbJD+dwqKJkacLT7hdVBN1wi
         Y8Tl8kis6LXtNZRBqN/S0MT7XGohOrvS6GVd14+vGHJsqZynT1HoDF2b3PIg1czzgnVr
         UGUw==
X-Gm-Message-State: AOAM530iHlrxehO4y9sIUEInIA5gwIpRnQg/9UgSYUj98OBEAkoC4E6x
        I2aPHsHg5ombPHsZaHSYqcLzRzLrL8n+13WcSSM=
X-Google-Smtp-Source: ABdhPJz2mzhqu6B2cvzIz1ZBaACtI91w2Kuc7FS9HFztq9oN9ipATALm+M2aAJrOqWRGmtgoCMVf35NR7B+BW650jf0=
X-Received: by 2002:a05:622a:c4:b0:2e1:cb5b:9b5c with SMTP id
 p4-20020a05622a00c400b002e1cb5b9b5cmr14578628qtw.69.1650962155447; Tue, 26
 Apr 2022 01:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-5-j.neuschaefer@gmx.net> <31cb9af1-173d-bef5-64da-ccf5a01f2485@linaro.org>
In-Reply-To: <31cb9af1-173d-bef5-64da-ccf5a01f2485@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 26 Apr 2022 08:35:43 +0000
Message-ID: <CACPK8XdRYvike9Z98JzfO1r0W2jfkESr8xMGSH4kkigwZ_MkyQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 at 07:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2022 20:30, Jonathan Neusch=C3=A4fer wrote:
> > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > Add a devicetree binding for it, as well as definitions for the bit
> > numbers used by it.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
>
> Thank you for your patch. There is something to discuss/improve.
>
> >  .../bindings/clock/nuvoton,wpcm450-clk.yaml   | 74 +++++++++++++++++++
> >  .../dt-bindings/clock/nuvoton,wpcm450-clk.h   | 67 +++++++++++++++++
> >  2 files changed, 141 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpc=
m450-clk.yaml
> >  create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-cl=
k.yaml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> > new file mode 100644
> > index 0000000000000..0fffa8a68dee4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton WPCM450 clock controller binding
>
> s/binding//
>
> > +
> > +maintainers:
> > +  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > +
> > +description:
> > +  This binding describes the clock controller of the Nuvoton WPCM450 S=
oC, which
> > +  supplies clocks and resets to the rest of the chip.
>
> s/This binding describes//
>
> Just describe the hardware.
>
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,wpcm450-clk
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Reference clock oscillator (should be 48 MHz)
> > +
> > +  clock-names:
> > +    items:
> > +      - const: refclk
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    refclk: clock-48mhz {
> > +      /* 48 MHz reference oscillator */
> > +      compatible =3D "fixed-clock";
> > +      clock-output-names =3D "refclk";
> > +      clock-frequency =3D <48000000>;
> > +      #clock-cells =3D <0>;
> > +    };
> > +
> > +    clk: clock-controller@b0000200 {
> > +      reg =3D <0xb0000200 0x100>;
> > +      compatible =3D "nuvoton,wpcm450-clk";
> > +      clocks =3D <&refclk>;
> > +      clock-names =3D "refclk";
> > +      #clock-cells =3D <1>;
> > +      #reset-cells =3D <1>;
> > +    };
> > +
> > +    serial@b8000000 {
> > +      compatible =3D "nuvoton,wpcm450-uart";
> > +      reg =3D <0xb8000000 0x20>;
> > +      reg-shift =3D <2>;
> > +      interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
> > +      clocks =3D <&clk WPCM450_CLK_UART0>;
> > +    };
>
> Skip the consumer example, it's obvious/trivial/duplicating.
>
> > diff --git a/include/dt-bindings/clock/nuvoton,wpcm450-clk.h b/include/=
dt-bindings/clock/nuvoton,wpcm450-clk.h
> > new file mode 100644
> > index 0000000000000..86e1c895921b7
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
> > +#define _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
> > +
> > +/* Clocks based on CLKEN bits */
> > +#define WPCM450_CLK_FIU            0
> > +#define WPCM450_CLK_XBUS           1
> > +#define WPCM450_CLK_KCS            2
> > +#define WPCM450_CLK_SHM            4
> > +#define WPCM450_CLK_USB1           5
> > +#define WPCM450_CLK_EMC0           6
> > +#define WPCM450_CLK_EMC1           7
> > +#define WPCM450_CLK_USB0           8
> > +#define WPCM450_CLK_PECI           9
> > +#define WPCM450_CLK_AES           10
> > +#define WPCM450_CLK_UART0         11
> > +#define WPCM450_CLK_UART1         12
> > +#define WPCM450_CLK_SMB2          13
> > +#define WPCM450_CLK_SMB3          14
> > +#define WPCM450_CLK_SMB4          15
> > +#define WPCM450_CLK_SMB5          16
> > +#define WPCM450_CLK_HUART         17
> > +#define WPCM450_CLK_PWM           18
> > +#define WPCM450_CLK_TIMER0        19
> > +#define WPCM450_CLK_TIMER1        20
> > +#define WPCM450_CLK_TIMER2        21
> > +#define WPCM450_CLK_TIMER3        22
> > +#define WPCM450_CLK_TIMER4        23
> > +#define WPCM450_CLK_MFT0          24
> > +#define WPCM450_CLK_MFT1          25
> > +#define WPCM450_CLK_WDT           26
> > +#define WPCM450_CLK_ADC           27
> > +#define WPCM450_CLK_SDIO          28
> > +#define WPCM450_CLK_SSPI          29
> > +#define WPCM450_CLK_SMB0          30
> > +#define WPCM450_CLK_SMB1          31
> > +
> > +/* Other clocks */
> > +#define WPCM450_CLK_USBPHY        32
> > +
> > +#define WPCM450_NUM_CLKS          33
> > +
> > +/* Resets based on IPSRST bits */
>
> All these defines should be in second header in dt-bindings/reset/...

I disagree. It makes more sense to keep the definitions together, and
it's all for the same hardware and driver.

>
> > +#define WPCM450_RESET_FIU          0
>
>
> Best regards,
> Krzysztof
