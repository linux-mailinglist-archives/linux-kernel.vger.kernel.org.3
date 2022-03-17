Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7C4DC7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiCQNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiCQNf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:35:56 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5511D8327;
        Thu, 17 Mar 2022 06:34:39 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id u16so6396582wru.4;
        Thu, 17 Mar 2022 06:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tiddZtdatCAOBeWoKQ39T3OINXD+ANIwjKxCq8gFVyg=;
        b=r5Xue6WFoXurEsZZDzrwuYYHerUIraIHaA8RcD1K2dwTdrJR/ys9oxo8JnZUeiowya
         /JKKn+N2g9pdGaVg+WXJFfuGBd9hqyxWORyB+eIw+TkEMv58C2IK+43ibfqKc5ZNdOdQ
         rslf09TaabA/6ht9ox4jWORmdh71/MDAsvzzxx5SUsW7srpNBvBlvoHlW8x+yoUGy20k
         DdIhJH17iUKZvgiz9q0Imu+GT5JuMLZjIOGTnAb6bUaKQxwqnXgImUEC5tHpyhjdpDu8
         QwbC9TkJFV+i3bsCSwB8b/El6XBcQ3tr5AavmNxLVAeoamTzNLkBj58mMDw+CiaATA26
         dacQ==
X-Gm-Message-State: AOAM530YHZkbfpsp45xK7mSYZoZvp3oXxlegV0dkvQb5cq51ZK/iZ/Ub
        gAC7oJwDfj/oMudRHyNv5js=
X-Google-Smtp-Source: ABdhPJwAnfd4irGcCYcMc4ioXDUc5jApZtA3VHsE3K+y3gDHzFM/81yNXsSr4TkmhdNbWlYAtnsHIg==
X-Received: by 2002:adf:9123:0:b0:1ef:9b6d:60c1 with SMTP id j32-20020adf9123000000b001ef9b6d60c1mr4030511wrj.169.1647524078009;
        Thu, 17 Mar 2022 06:34:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm4314005wmh.31.2022.03.17.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 06:34:35 -0700 (PDT)
Message-ID: <e26ab4e4-6774-e292-8fcb-c86b33af048a@kernel.org>
Date:   Thu, 17 Mar 2022 14:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH v4 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220317012404.8069-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <971850ad-96af-2abb-f4bf-ba6188e2d732@kernel.org>
 <CA+V-a8t+=dVsofAT=Qk-v3hvJ7_zGNNLoj_EQK8hUGptnQROhQ@mail.gmail.com>
In-Reply-To: <CA+V-a8t+=dVsofAT=Qk-v3hvJ7_zGNNLoj_EQK8hUGptnQROhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 12:55, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Thu, Mar 17, 2022 at 9:44 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 17/03/2022 02:24, Lad Prabhakar wrote:
>>> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>  .../renesas,rzg2l-irqc.yaml                   | 131 ++++++++++++++++++
>>>  1 file changed, 131 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
>>> new file mode 100644
>>> index 000000000000..a14492ec9235
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
>>> @@ -0,0 +1,131 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
>>> +
>>> +maintainers:
>>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> +  - Geert Uytterhoeven <geert+renesas@glider.be>
>>> +
>>> +description: |
>>> +  IA55 performs various interrupt controls including synchronization for the external
>>> +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
>>> +  interrupts output by each IP. And it notifies the interrupt to the GIC
>>> +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
>>> +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
>>> +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
>>> +      stand-up edge detection interrupts)
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/interrupt-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - renesas,r9a07g044-irqc    # RZ/G2L
>>> +      - const: renesas,rzg2l-irqc
>>> +
>>> +  '#interrupt-cells':
>>> +    const: 2
>>> +
>>> +  '#address-cells':
>>> +    const: 0
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  reg:
>>> +    maxItems: 1> +
>>> +  interrupts:
>>> +    maxItems: 41
>>> +
>>> +  clocks:
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: clk
>>> +      - const: pclk
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - '#interrupt-cells'
>>> +  - '#address-cells'
>>> +  - interrupt-controller
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - power-domains
>>> +  - resets
>>> +
>>> +additionalProperties: false
>>
>> This should be rather unevaluatedProperties and remove
>> interrupt-controller:true from properties.
>>
> Ok will do.

After some tests it seems interrupt-controller:true is required in
properties, so only change unevaluatedProperties.


Best regards,
Krzysztof
