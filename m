Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2515C5909E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiHLBcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHLBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:32:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41092BF71;
        Thu, 11 Aug 2022 18:32:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b96so25133233edf.0;
        Thu, 11 Aug 2022 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Yu55T4L0tuXafN1uZTmyVTcIyoH+0dEPzfrt7zhu/EM=;
        b=RVMfC9D4XbQ2ECXnO3ivEpeoUuYwiYciNFHdseF9wRNym7lHwKPpcTkPQx8vMWKkks
         l7vffeMoBS0SNGmuOOmFzQ1qDZ+3SHBJmY5QSstebwkdVnXiOYKKxxbwHfKfBPSLPTZW
         /bEu0qClUybC0C73NsUC7AECvW5yhfaj561w3HlSc9PVDsMDomKFBkkYzWGlWfKFu8u8
         bpzE7CLl36brv/OC/reheeNFP5QovQL5/xXAz6TqSBhiqzSzDbqEU7kF3vFiX3ba7u3f
         Sj9ScuIaWprPMS8QZJ6OlfRyvEnDwSDE9DN66yk33kgcy39ZhD3jTbd+tpBk8cjWoxdQ
         IUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Yu55T4L0tuXafN1uZTmyVTcIyoH+0dEPzfrt7zhu/EM=;
        b=FCBzF6J0vW5ms4naoPDLT9eEdAb+6Y4xotqbzOSVXQmzLzqu0xKs6LXMZ51gnH4zoA
         UwRVCLbgva3RV+wV3ZT+bRcjJpi8ZqNmRgVQWPJI05PUU41DQ79YIg+9f/hT+ZvvSA/T
         6Tj5YQyKzSVlxMi3vWxcVlzOJ/t3pSVjIgjUBlFtmZANpjocHsqnrvX+ApvBAKUPjvdm
         uDOCznbqfZhNrSLa53bCDwCw9n0BJM7VM6JSaZKGsLoNVLhVFhZvlmfLE4wATdZ5i/4w
         N6IDBK9emew5XRlSqW0uHWazlbMCxLlP4kc0MSth93WQsJoOQQ1zOXbwsGuoeyZRsjdx
         a5UQ==
X-Gm-Message-State: ACgBeo16Zl41eGj+R16lAWYoNdu25zjDWSbC2xR0TLm81iF9sa+WzOkI
        SxyoW/tcYwGhlZ4t+bldUTLhzHsASWDeiBbi2OI=
X-Google-Smtp-Source: AA6agR7KtMGU/rsla2f7fwENtwgXLzDc8MR3ZiQqpxnnG/Ft8aj9l+1lBnO+G/fY21kqT5zoqP3r6bdeV6mAxZPfefs=
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id
 o13-20020a056402438d00b0043db383660fmr1490810edc.283.1660267962604; Thu, 11
 Aug 2022 18:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com> <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
In-Reply-To: <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 12 Aug 2022 09:32:31 +0800
Message-ID: <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B48=E6=9C=8811=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A10:12=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 11/08/2022 16:41, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add bindings for the Richtek RT9471 I2C controlled battery charger.
> >
>
> Thank you for your patch. There is something to discuss/improve.
>
> > +properties:
> > +  compatible:
> > +    const: richtek,rt9471
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ceb-gpios:
> > +    maxItems: 1
>
> This looks not standard, so please provide a description.
It's the external 'charge enable' pin that's used to control battery chargi=
ng.
The priority is higher than the register 'CHG_EN' control.
In the word, 'b' means it's reverse logic, low to allow charging, high
to force disable charging.

description:
  External charge enable pin that can force control not to charge the batte=
ry.
  Low to allow charging, high to disable charging.

>
> > +
> > +  wakeup-source: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
>
> Why a charger driver is a interrupt-controller?
There're 32 nested IRQs from RT9471.
The original thought is to make the user easy to bind the interrupt
into their driver.

For charger driver, does it mean legacy IRQ handler is more preferred?
>
> > +
> > +  usb-otg-vbus-regulator:
> > +    type: object
> > +    unevaluatedProperties: false
> > +    $ref: /schemas/regulator/regulator.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - wakeup-source
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      charger@53 {
> > +        compatible =3D "richtek,rt9471";
> > +        reg =3D <0x53>;
> > +        ceb-gpios =3D <&gpio26 1 0>;
>
> Isn't the last value a GPIO flag? If yes, use appropriate define.
I already specify GPIOD_OUT_LOW in the gpiod_request flag.
Do I need to convert the gpio request code to GPIOD_OUT_HIGH,
and specify here as GPIO_ACTIVE_LOW?
>
>
>
> Best regards,
> Krzysztof
