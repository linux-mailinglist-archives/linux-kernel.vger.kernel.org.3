Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059754DC51B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiCQL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiCQL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:57:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37E1E5339;
        Thu, 17 Mar 2022 04:55:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2dbd8777564so55792467b3.0;
        Thu, 17 Mar 2022 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1imX/kmpwhOvZYEuM6ilnAvljdguknxkeSADcDK5dg=;
        b=UwpwJrpf8u261FdbY45NXED0y8WNbE0Kp+zJE6PkD3Hj2RJi9czoTRtcLAbFJTBemD
         0x+PX4ZIjNeiHj6071ngWLX21LkCLDomztVYjMw/wq8lqwIeg0+0ZFBhCbfn8MbN3KQt
         6L2kWRK5/MdbwuGIdjI7ifCUIGK8rKwHpAu3FBcuhpfuiASxaAWwoo2MFvkrVSm2qxyq
         M+wAyJlCJUZ6CkATMv5XDq0CvBCgQEc4S+r3Y2YyTmr11iZlGQDv8jP8fxVqcued3gvT
         RL+WR0ZW22rKqB9+bJEQyP2kDiSV2RWEDyXLl99Spymz2UNMOLa/5I5vTgYH7KIlYq4C
         tkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1imX/kmpwhOvZYEuM6ilnAvljdguknxkeSADcDK5dg=;
        b=ajb9DIlmIWqrXClqXP9L9JlFoSEiKdtMYl1GVKOQM9+TQ+qU8gL1bnkkw4ZV2F7ZSG
         yne5x557DFdmKbSt8N7+jen/eKOvs96f7h9PQHYAO9UHN0Dd0UsvP2d0ufxExeiTp6Bh
         kEp5zdj6JWWEo39bpjAalGc4PnkdyXvA4G+X9c+2ot1eNTeDMKMjZEUSO3c7LiUT8VVI
         BH5CjtFYfja4rU3Jn9lg5XiIImsl8xbNtBTmwGD0W0EOPFa0Jj9VY0lAwE3km1DGK1Fb
         rcQLbD/qVBqDvDYF0g35EIBqbTSWisIMFxToxc5lGQxTjJQNxrouNSaFpy0Di+J3it6p
         s+eA==
X-Gm-Message-State: AOAM5312a0FMrdWDzZoloMb2Vyo4XSq3+rfUYw7XLS6V0mzffTSVPnJp
        RunNGFBFjuo2tFChcGxwCK5lmmM+vNWKH6hC8jE=
X-Google-Smtp-Source: ABdhPJza79A7llMZNNdliE4IS5hibyoV277veg5NMU/IHlBnK4jHf1oUNAbRWPkrZdr8EiyWovZYwD+ey3iSGLde4OE=
X-Received: by 2002:a0d:c0c7:0:b0:2e5:bf19:2698 with SMTP id
 b190-20020a0dc0c7000000b002e5bf192698mr2393516ywd.119.1647518154588; Thu, 17
 Mar 2022 04:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220317012404.8069-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <971850ad-96af-2abb-f4bf-ba6188e2d732@kernel.org>
In-Reply-To: <971850ad-96af-2abb-f4bf-ba6188e2d732@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Mar 2022 11:55:28 +0000
Message-ID: <CA+V-a8t+=dVsofAT=Qk-v3hvJ7_zGNNLoj_EQK8hUGptnQROhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

On Thu, Mar 17, 2022 at 9:44 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/03/2022 02:24, Lad Prabhakar wrote:
> > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../renesas,rzg2l-irqc.yaml                   | 131 ++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > new file mode 100644
> > index 000000000000..a14492ec9235
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > @@ -0,0 +1,131 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +
> > +description: |
> > +  IA55 performs various interrupt controls including synchronization for the external
> > +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> > +  interrupts output by each IP. And it notifies the interrupt to the GIC
> > +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> > +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > +      stand-up edge detection interrupts)
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-irqc    # RZ/G2L
> > +      - const: renesas,rzg2l-irqc
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +
> > +  '#address-cells':
> > +    const: 0
> > +
> > +  interrupt-controller: true
> > +
> > +  reg:
> > +    maxItems: 1> +
> > +  interrupts:
> > +    maxItems: 41
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: clk
> > +      - const: pclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - '#interrupt-cells'
> > +  - '#address-cells'
> > +  - interrupt-controller
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +
> > +additionalProperties: false
>
> This should be rather unevaluatedProperties and remove
> interrupt-controller:true from properties.
>
Ok will do.

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +
> > +    irqc: interrupt-controller@110a0000 {
> > +            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
> > +            #interrupt-cells = <2>;
> > +            #address-cells = <0>;
> > +            interrupt-controller;
> > +            reg = <0x110a0000 0x10000>;
>
> Put the reg after compatible in DTS code. The ordering of properties in
> bindings is a bit odd, but I wasn't following order by myself, so cannot
> complain. :)
>
Ok will fix that in next version.

Cheers,
Prabhakar
