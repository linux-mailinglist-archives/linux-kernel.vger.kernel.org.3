Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41475A21D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbiHZH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbiHZH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:27:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC57B29B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:27:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so927620lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7Wpx+azOCmq8UWW2j/ZjozWWfYLuvQ/dJ2IBmBpdWss=;
        b=TOQwSM1L/RF+yXaRDCUQYlUJus/Tw4LGwAI9gnJuDgxgneIiuNxDtJQUq921EiZJfO
         6Dmes3IRFlur/abjm85bDJh9XMTVE49ZkxKc3huzutWlXdRpnGx5X1ffKOArfYm5yV0b
         Gz5rDS7CEOyD0SKiqFK+NmrQHUUHAYxnErIeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7Wpx+azOCmq8UWW2j/ZjozWWfYLuvQ/dJ2IBmBpdWss=;
        b=e+xEcTHwA5NsYQJrPrC5n9ChY4MUIisMf5TzEvpPA2LNBMa9Mpd7pfZcN6GRlaqNqG
         aSdcjqGibpMKZoZ20HhhCRh3XHQk6GK2FMSDuEbPN0pIGNkdgoYaZa2sxivm1mrNbxev
         5LT09s7liKtC90uaukkOY3LR3dYfJLJ5tcx+dYI2S6ZAX9/tT1/8BlVvHloRegXpjrYu
         AbJQsW3tgVY/mGOO9zsH2rqnGDzvcpNn0WNlp43LC4Kwt35wbA4BQ8LNJKcmWNK+h6O/
         HR6D6RBVgJarN2Ac7Iua6OEnsl0ewW0W3TxAzdRwWW7+YG6fsXSNjFp8FlMtITrVVSMH
         sMFg==
X-Gm-Message-State: ACgBeo31tLFPqXjSNQiZg/RIqta5VMFGCkiIL5APFaW/N3HOAYjvcL9N
        941R17o8un0oRXLGJje+1rr+WGTLMezCqedAnEi3Tw==
X-Google-Smtp-Source: AA6agR5oEwkixZT704+Lw+lqx2WWt/3lpORR1HbM3w6LfSZCulylQ5eX97DDcE4Roa5vETDy6vZZ3olRn8KtffbU0XI=
X-Received: by 2002:a05:6512:1103:b0:492:f0b1:282f with SMTP id
 l3-20020a056512110300b00492f0b1282fmr2005934lfg.172.1661498839946; Fri, 26
 Aug 2022 00:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220820082936.686924-1-dario.binacchi@amarulasolutions.com>
 <20220820082936.686924-2-dario.binacchi@amarulasolutions.com> <20220825211241.GA1688421-robh@kernel.org>
In-Reply-To: <20220825211241.GA1688421-robh@kernel.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 26 Aug 2022 09:27:09 +0200
Message-ID: <CABGWkvobb7yLdBZ+RsJ=oiRsgfmDo0DJ-pvnsFndUE0qRmoHOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: net: can: add STM32 bxcan DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        michael@amarulasolutions.com, Dario Binacchi <dariobin@libero.it>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Aug 25, 2022 at 11:12 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Aug 20, 2022 at 10:29:33AM +0200, Dario Binacchi wrote:
> > Add documentation of device tree bindings for the STM32 basic extended
> > CAN (bxcan) controller.
> >
> > Signed-off-by: Dario Binacchi <dariobin@libero.it>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v2:
> > - Change the file name into 'st,stm32-bxcan-core.yaml'.
> > - Rename compatibles:
> >   - st,stm32-bxcan-core -> st,stm32f4-bxcan-core
> >   - st,stm32-bxcan -> st,stm32f4-bxcan
> > - Rename master property to st,can-master.
> > - Remove the status property from the example.
> > - Put the node child properties as required.
> >
> >  .../bindings/net/can/st,stm32-bxcan.yaml      | 136 ++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
> > new file mode 100644
> > index 000000000000..288631b5556d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
> > @@ -0,0 +1,136 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/can/st,stm32-bxcan.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: STMicroelectronics bxCAN controller
> > +
> > +description: STMicroelectronics BxCAN controller for CAN bus
> > +
> > +maintainers:
> > +  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > +
> > +allOf:
> > +  - $ref: can-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - st,stm32f4-bxcan-core
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Input clock for registers access
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - resets
> > +  - clocks
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +patternProperties:
> > +  "^can@[0-9]+$":
> > +    type: object
> > +    description:
> > +      A CAN block node contains two subnodes, representing each one a CAN
> > +      instance available on the machine.
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - st,stm32f4-bxcan
> > +
> > +      st,can-master:
> > +        description:
> > +          Master and slave mode of the bxCAN peripheral is only relevant
> > +          if the chip has two CAN peripherals. In that case they share
> > +          some of the required logic, and that means you cannot use the
> > +          slave CAN without the master CAN.
> > +        type: boolean
> > +
> > +      reg:
> > +        description: |
> > +          Offset of CAN instance in CAN block. Valid values are:
> > +            - 0x0:   CAN1
> > +            - 0x400: CAN2
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        items:
> > +          - description: transmit interrupt
> > +          - description: FIFO 0 receive interrupt
> > +          - description: FIFO 1 receive interrupt
> > +          - description: status change error interrupt
> > +
> > +      interrupt-names:
> > +        items:
> > +          - const: tx
> > +          - const: rx0
> > +          - const: rx1
> > +          - const: sce
> > +
> > +      resets:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        description:
> > +          Input clock for registers access
> > +        maxItems: 1
> > +
> > +    additionalProperties: false
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupts
> > +      - resets
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/stm32fx-clock.h>
> > +    #include <dt-bindings/mfd/stm32f4-rcc.h>
> > +
> > +    can: can@40006400 {
> > +        compatible = "st,stm32f4-bxcan-core";
> > +        reg = <0x40006400 0x800>;
> > +        resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
> > +        clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
>
> Missing 'ranges'.

In the file arch/arm/boot/dts/stm32f429.dtsi, I didn't find any other
node using the 'ranges' property, so
I didn't use it for the CAN node either.

>
> > +        can1: can@0 {
> > +            compatible = "st,stm32f4-bxcan";
> > +            reg = <0x0>;
> > +            interrupts = <19>, <20>, <21>, <22>;
> > +            interrupt-names = "tx", "rx0", "rx1", "sce";
> > +            resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
> > +            st,can-master;
>
> No clocks?

It uses the parent node clock, since it is in master mode.

Thanks and regards,
Dario

>
> > +        };
> > +
> > +        can2: can@400 {
> > +            compatible = "st,stm32f4-bxcan";
> > +            reg = <0x400>;
> > +            interrupts = <63>, <64>, <65>, <66>;
> > +            interrupt-names = "tx", "rx0", "rx1", "sce";
> > +            resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
> > +            clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
> > +        };
> > +    };
> > --
> > 2.32.0
> >
> >



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
