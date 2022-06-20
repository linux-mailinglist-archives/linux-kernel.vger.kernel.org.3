Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C7551355
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiFTIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiFTIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278E12D05;
        Mon, 20 Jun 2022 01:51:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a29so16148160lfk.2;
        Mon, 20 Jun 2022 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nmsby/owyh04k0ycvHIy9l6TCn3KX4vCVQ8FvknbAxM=;
        b=OhX35MjDbqMX8PT+D6KgZRwN4bXObTsbs0ih7IFYqtsvOa1wuBKqHj/RyYXlS3d87a
         acnj6QFINKrCvJVEwTCPQMx8iqGAfRdGKSIaOen1/wiSYmvuHHL9IZAc4FMsdJacFG8m
         Le4ZFTQhp7OU1Tp48G8+wSKci6gOp3qVE1kiWeGGwZnzYmS7g28O6WZuPZGEVT59zLuL
         vLX2rDcUHCgvd39E7LLZSfnomBVATG0w3h1mBxwquDjVC1X3LvfMXGT5oIXuwYF1BjCR
         qj3D6IeMXHff3qbezYRsA0jv/3e9ITV7luOJ27hBzyUnyGVW0jqTdrD6erT/DV9BZhxM
         j0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nmsby/owyh04k0ycvHIy9l6TCn3KX4vCVQ8FvknbAxM=;
        b=Li5jmL2vATkjTk3/K0AExIvlhU3HiPDjwSQsdF+MS65kWLofzBVX6eTe+1TetOltx7
         geW22ooKbl8Bye1oTrCeY7Ziw1VgSGRSAYtNk9IJQxCGgVhnAONRj6mPOPINkNkcY0TV
         0xIJlCkdTdqLLElnhcwavb48j/M2fiab1bz/sNIgBGHOX0JzrOHVFeM8r/Q9LNPpOnf0
         O9XYW7UNoIoB1MScsE/2Cvq6hsGh1DrVkVYobSPOyNJZ/ZnqEZCoTZcSdjH/Liz84VDY
         yV7q4yuPAjvcosRHGH0LgZ60jdaNBkQSDLTtNTKEuAWnNWN8WChmpGWnhLBYgewU/x64
         JMYQ==
X-Gm-Message-State: AJIora+574n4jiYVoHx3l/lJQxeLcRdj/D+VPPS1Q2WCIXYfZWJu4rlt
        MLjeaW2cmEBwdehVec8PWq5lVx59LTi1MEzeX2Q=
X-Google-Smtp-Source: AGRyM1sVjX2HtRVHYgJLfOUlDY1CN4gBAcxTLBHTjQ4lp3ME+dD6n0bXuPvlQwDNAMCQBdXF21S0fja6MceEuZ+Ul8M=
X-Received: by 2002:a05:6512:1390:b0:47f:74c4:dd45 with SMTP id
 p16-20020a056512139000b0047f74c4dd45mr1117184lfa.536.1655715098427; Mon, 20
 Jun 2022 01:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220619151225.209029-1-tmaimon77@gmail.com> <20220619151225.209029-6-tmaimon77@gmail.com>
 <040f149b-c441-c778-6d4f-f3b2b2afaf4e@linaro.org>
In-Reply-To: <040f149b-c441-c778-6d4f-f3b2b2afaf4e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 20 Jun 2022 11:51:27 +0300
Message-ID: <CAP6Zq1j9=wsK=HGLkvPRrVYrQdCqL0+LaujmTxnRY7fbK2zi1g@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 20 Jun 2022 at 11:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/06/2022 17:12, Tomer Maimon wrote:
> > Add binding for the Arbel BMC NPCM8XX Clock controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 49 +++++++++++++++++++
> >  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 49 +++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > new file mode 100644
> > index 000000000000..3d4fddc090ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM8XX Clock Controller Binding
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description: |
> > +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
> > +  generates and supplies clocks to all modules within the BMC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm845-clk
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +    description:
> > +      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
> > +      list of NPCM8XX clock IDs.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
>
> Use same quotes through your patchset - either " or '. Do not mix.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ahb {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        clock-controller@f0801000 {
> > +            compatible = "nuvoton,npcm845-clk";
> > +            reg = <0x0 0xf0801000 0x0 0x1000>;
> > +            #clock-cells = <1>;
> > +        };
> > +    };
> > +...
> > diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> > new file mode 100644
> > index 000000000000..e5cce08b00e1
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> > @@ -0,0 +1,49 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>
> My comment about filename is still waiting to be resolved. I asked for
> same filename as bindings in v1.
Right, forgot to modify the file name will be done in next version.
>
> https://lore.kernel.org/all/CAP6Zq1gXEqqquKzxTHoxYnvh2LCGt-ES+k=aX61FKyHW5WB62w@mail.gmail.com/
>
> I am still going to NAK it if it is not implemented.
>
> Best regards,
> Krzysztof

Best regards,

Tomer
