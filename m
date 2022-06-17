Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9505A54F57B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381345AbiFQKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380066AbiFQKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:35:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7A6AA70;
        Fri, 17 Jun 2022 03:35:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b138so4100723iof.13;
        Fri, 17 Jun 2022 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rOxytpr3JE53RNJSPRdeBWhwwL5aBsV68OtuK0gPSKc=;
        b=VXLvhpaQU0zgeMjKkkqDHD1I+K0rIshiGzQkNBPk2HQGNqDDUZT5LxEKFLtoSchSaZ
         fKpgnNsU0HTiilSwtx0LgLcenSKqGXiW3QiesMvmIoG8bZYBxjvxIm4ZMCMJssMi06O7
         DmqBTjSMvAsNPKw0iZwY8THSaeWRxbZvzA5XCoxwOMwh8aFihG4t0lDRFgRD8H/l72fJ
         4WO9j/DcS912xHkAAyWAdl+uQmxw6JQHU9ZhlfeMjFsP+HiYKJpSZDjCjXLCjJ4UMtG5
         sj63siSb6Jqs6FXFchQDLzzEq6UOf/Duny841OrK6jdAGRvH8toYDeFHZA1bsbuZ+Yvc
         ewGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rOxytpr3JE53RNJSPRdeBWhwwL5aBsV68OtuK0gPSKc=;
        b=UUU13xS7uvl9HledfE/X7S4w/Mro+2VwQ1vxTNT6HAsMbCGoTxhFo+DnWLOyhJxV9Y
         +oF2iT76MlV79lzKIKePDUUbzWbb+Fum6otvQ3904J6bN/OWdOQ+tAEX/y0uYgyT4Hm0
         w6/0x+/5GROCe8NLHtnh/NCv0lcATOUQdDvburz5dBlqEM7iqQDdXq4YHaYVX08MRhRm
         5QGBvaTR7c+zbSAWW6u8Yat1tX6NctPMA63bROGtDmh9/rr1uVvLQeZlU9Iyq6rZXORc
         97o+c1KlFAmGJ9Z4GKcKNUCyXjjimocuCGs/p8+SrkHrreyABHu0pdyiMD+zq8Hx0nQI
         bTbA==
X-Gm-Message-State: AJIora9fTUrTBrts99yncrscDoSRRbFdBlpriXzo8y45Q1C1FQVJVSxX
        4iNA3RokeNIMp7S3NlLZM3N10atafc5HGt0FbDo=
X-Google-Smtp-Source: AGRyM1udgMHgKDiQMYRnn7E3oN5h0pbJ2A1MrxTn2OBrvOJsKft+xj/e2gq23SyVxC5kFN9WD040jXi32G7pqDTUjpk=
X-Received: by 2002:a05:6638:2113:b0:331:feae:af81 with SMTP id
 n19-20020a056638211300b00331feaeaf81mr4897345jaj.196.1655462146064; Fri, 17
 Jun 2022 03:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-6-peterwu.pub@gmail.com>
 <9c38f708-1376-aa89-2c56-c08d320bcf2b@linaro.org>
In-Reply-To: <9c38f708-1376-aa89-2c56-c08d320bcf2b@linaro.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 18:35:34 +0800
Message-ID: <CABtFH5KhijZDRA+K=stpOV0t8K3cqCMoLXpLShcdm9F8emrKCA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] dt-bindings: backlight: Add Mediatek MT6370 backlight
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks for your helpful feedback, I have some questions want to
confirm with you below.

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=B8=85=E6=99=A85:13=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 13/06/2022 04:11, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add mt6370 backlight binding documentation.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../backlight/mediatek,mt6370-backlight.yaml  | 107 ++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/me=
diatek,mt6370-backlight.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,=
mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/me=
diatek,mt6370-backlight.yaml
> > new file mode 100644
> > index 000000000000..25a05e607e83
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-=
backlight.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-back=
light.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT6370 Backlight
> > +
> > +maintainers:
> > +  - ChiaEn Wu <chiaen_wu@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  The MT6370 Backlight WLED driver supports up to a 29V output voltage=
 for
> > +  4 channels of 8 series WLEDs. Each channel supports up to 30mA of cu=
rrent
> > +  capability with 2048 current steps (11 bits) in exponential or linea=
r
> > +  mapping curves.
> > +
> > +allOf:
> > +  - $ref: common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-backlight
> > +
> > +  default-brightness:
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  max-brightness:
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  enable-gpios:
> > +    description: External backlight 'enable' pin
> > +    maxItems: 1
> > +
> > +  mediatek,bled-pwm-enable:
> > +    description: |
> > +      Enable external PWM input for backlight dimming
> > +    type: boolean
> > +
> > +  mediatek,bled-pwm-hys-enable:
> > +    description: |
> > +      Enable the backlight input-hysteresis for PWM mode
> > +    type: boolean
> > +
> > +  mediatek,bled-pwm-hys-input-bit:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    enum: [0, 1, 2, 3]
> > +    description: |
> > +      The selection of the upper and lower bounds threshold of backlig=
ht
> > +      PWM resolution. If we choose selection 3 (6 bits), the variation=
 of PWM
> > +      resolution needs over than 64 steps (2^6).
> > +      value mapping:
> > +        - 0: 1
> > +        - 1: 2
> > +        - 2: 4
> > +        - 3: 6
>
> Nope, I said last time:
> "In any case you cannot have values mapping"
>
> Please use proper real world value, not some register bits. The property
> name also needs fixing.

I so apologized for misunderstanding your meaning...
I try to modify it like below.
--------
mediatek,bled-pwm-hys-input-threshold-steps:
  $ref: /schemas/types.yaml#/definitions/uint8
  enum: [1, 4, 16, 64]
  description: |
    The selection of the upper and lower bounds threshold of backlight
    PWM resolution. If we choose selection 64, the variation of PWM
    resolution needs over 64 steps.
--------
If these changes meet your expectations, I will try to modify
"bled-ovp-microvolt" and "bled-ocp-microamp" in the same way.
Thank you so much.

>
> > +
> > +  mediatek,bled-ovp-shutdown:
> > +    description: |
> > +      Enable the backlight shutdown when OVP level triggered
> > +    type: boolean
> > +
> > +  mediatek,bled-ovp-microvolt:
> > +    enum: [0, 1, 2, 3]
> > +    description: |
> > +      Backlight OVP level selection.
> > +      value mapping:
> > +        - 0: 17000000
> > +        - 1: 21000000
> > +        - 2: 25000000
> > +        - 3: 29000000
>
> No. Please test your bindings.
>
> microvolt cannot be 1 mV. It's 21000000, not 1. No value mappings.
>
> > +
> > +  mediatek,bled-ocp-shutdown:
> > +    description: |
> > +      Enable the backlight shutdown when OCP level triggerred.
> > +    type: boolean
> > +
> > +  mediatek,bled-ocp-microamp:
> > +    enum: [0, 1, 2, 3]
> > +    description: |
> > +      Backlight OC level selection.
> > +      value mapping:
> > +        - 0: 900000
> > +        - 1: 1200000
> > +        - 2: 1500000
> > +        - 3: 1800000
>
> Nope.
>
> > +
> > +  mediatek,bled-channel-use:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description: |
> > +      Backlight LED channel to be used.
> > +      Each bit mapping to:
> > +        - 0: CH4
> > +        - 1: CH3
> > +        - 2: CH2
> > +        - 3: CH1
> > +    minimum: 1
> > +    maximum: 15
> > +
> > +required:
> > +  - compatible
> > +  - mediatek,bled-channel-use
> > +
> > +additionalProperties: false
>
>
> Best regards,
> Krzysztof

Best regards,
ChiaEn Wu
