Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E75A21A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbiHZHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiHZHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:20:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1633A26
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:20:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l1so882779lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CEGNVel+DD71gCbMY4+NplXPx6ttJvqdwAiSfqWyuyc=;
        b=jQ86Y7gtk1EpU4RztWNT1iTdh2AUuRrwXfiVeyrNKILZFHEST2uROvFtOFKzico+PW
         JdiP0jlcR/My88TNoWLOM2Dt+q69rIK++vjnpB/CrldlJdpweNn/cdutT1KaTsGdYAD0
         Qy6yv5wVKl49zb+u45pbzd7pK90bqNa5NjHr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CEGNVel+DD71gCbMY4+NplXPx6ttJvqdwAiSfqWyuyc=;
        b=cbnILpxArC+8KqtBIrD7msx7zUo8lzHsmLEYH4dyem6g51o1WfKzoqlUVmAZCdanXo
         +DZ3yBo8bpMaqaLHJaAd/1MJwbn+8f4Gr/0HkGpjba0gyjjfOLEEgujQy857TZALiNod
         D2RikSbedkPea13+Zb7TUNJXl9NGw/XUQDX2XCPJB5AR33ybsNT3Ud9FFKjhYna8gOds
         zDqVfA40qL7xenoH/PviBh68/qC1JrjShhKaXLuR5qJe4FheO0pzkMHVmuTaTC/2Odpl
         /HN5iEUBjIvHZsY5BHEuu2iRvgZl8DNzC18kGVY6r+dGyLGriLnuUzSnYp9vBwnv7WrZ
         8wpQ==
X-Gm-Message-State: ACgBeo1oy2bCEpMEThCHr56T4jJ0C+1u10tWsql37Y1QVF9q8+X1u410
        E2/p/zkVm4WMQeKBlrDEq4XIN29rVSL7yrxt0/hgwg==
X-Google-Smtp-Source: AA6agR5E9rzLsk8Bxfltxj6vo0as9RfWJbfBdrR4zX1Gwkiwxtu0fySwDNeWtkDdUojuZHozS10XTuWSiLTeFSkQNck=
X-Received: by 2002:a05:6512:3503:b0:48a:6060:5ebb with SMTP id
 h3-20020a056512350300b0048a60605ebbmr1974187lfs.429.1661498446570; Fri, 26
 Aug 2022 00:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
 <20220817143529.257908-2-dario.binacchi@amarulasolutions.com>
 <b851147b-6453-c19e-7c31-a9cf8f87c1a4@linaro.org> <CABGWkvomGpo9zWi59YNYfRfzAZZ90D9_HaiVV3Gs_x_eQ59e5A@mail.gmail.com>
 <d8db1648-edcd-3580-60d3-96ef91d6bbed@linaro.org>
In-Reply-To: <d8db1648-edcd-3580-60d3-96ef91d6bbed@linaro.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 26 Aug 2022 09:20:35 +0200
Message-ID: <CABGWkvpBHFUx_KHKxeL2sEK8bO7=+3HCUAgJM7zphM3q7soczg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: net: can: add STM32 bxcan DT bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
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

Hi Krzysztof,

On Mon, Aug 22, 2022 at 7:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/08/2022 11:08, Dario Binacchi wrote:
> > Hi Krzysztof,
> >
> > On Thu, Aug 18, 2022 at 10:22 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/08/2022 17:35, Dario Binacchi wrote:
> >>> Add documentation of device tree bindings for the STM32 basic extended
> >>> CAN (bxcan) controller.
> >>>
> >>> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>
> >> You do not need two SoBs. Keep only one, matching the From field.
> >
> > I started implementing this driver in my spare time, so my intention
> > was to keep track of it.
>
> SoB is not related to copyrights. Keep personal copyrights (with/next to
> work ones), but SoB is coming from a person and that's only one. Choose
> one "person".

Ok, I got it.

>
> >
> >>
> >>> ---
> >>>
> >>>  .../devicetree/bindings/net/can/st,bxcan.yaml | 139 ++++++++++++++++++
> >>>  1 file changed, 139 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/net/can/st,bxcan.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/can/st,bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,bxcan.yaml
> >>> new file mode 100644
> >>> index 000000000000..f4cfd26e4785
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/net/can/st,bxcan.yaml
> >>
> >> File name like compatible, so st,stm32-bxcan-core.yaml (or some other
> >> name, see comment later)
> >
> >>
> >>> @@ -0,0 +1,139 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/net/can/st,bxcan.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: STMicroelectronics bxCAN controller Device Tree Bindings
> >>
> >> s/Device Tree Bindings//
> >
> >>
> >>> +
> >>> +description: STMicroelectronics BxCAN controller for CAN bus
> >>> +
> >>> +maintainers:
> >>> +  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>> +
> >>> +allOf:
> >>> +  - $ref: can-controller.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - st,stm32-bxcan-core
> >>
> >> compatibles are supposed to be specific. If this is some type of
> >> micro-SoC, then it should have its name/number. If it is dedicated
> >> device, is the final name bxcan core? Google says  the first is true, so
> >> you miss specific device part.
> >
> > I don't know if I understand correctly, I hope the change in version 2
> > is what you requested.
>
> What is the name of the SoC, where this is in?

STM32F4

>
> >
> >>
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  resets:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    description:
> >>> +      Input clock for registers access
> >>> +    maxItems: 1
> >>> +
> >>> +  '#address-cells':
> >>> +    const: 1
> >>> +
> >>> +  '#size-cells':
> >>> +    const: 0
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - resets
> >>> +  - clocks
> >>> +  - '#address-cells'
> >>> +  - '#size-cells'
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +patternProperties:
> >>
> >> This goes after "properties: in top level (before "required").
> >>
> >>> +  "^can@[0-9]+$":
> >>> +    type: object
> >>> +    description:
> >>> +      A CAN block node contains two subnodes, representing each one a CAN
> >>> +      instance available on the machine.
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        enum:
> >>> +          - st,stm32-bxcan
> >>
> >> Why exactly do you need compatible for the child? Is it an entierly
> >> separate device?
> >
> > I took inspiration from other drivers for ST microcontroller
> > peripherals (e. g. drivers/iio/adc/stm32-adc-core.c,
> > drivers/iio/adc/stm32-adc.c) where
> > some resources are shared between the peripheral instances. In the
> > case of CAN, master (CAN1) and slave (CAN2) share the registers for
> > configuring the filters and the clock.
> > In the core module you can find the functions about the shared
> > resources, while the childrens implement the driver.
>
> In both cases you refer to the driver, but we talk here about bindings
> which are rather not related. So I repeat the question - is the child
> entirely separate device which can be used in other devices?

IMHO, I think so.

Thanks and regards,
Dario
>
>
> Best regards,
> Krzysztof



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
