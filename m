Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75859135D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiHLP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiHLP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:58:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC48ACA3D;
        Fri, 12 Aug 2022 08:58:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so1845796edb.9;
        Fri, 12 Aug 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zLYCQ6rxWkBVwB6B4jZyHQK9L5sqow/EvVD4ZkuTfxs=;
        b=iuLs4xuS/hmVPiqkl2JmtWw9mv7BeZOhkn/UJpzH4g8L1lmF6NDKzKy7yKR3MjXQ7f
         4iKDlFze3/D+MejtpBnRHH3dHn/tFZMe3oOYTNtujiCNe+Euxg/f0O//+tuFIoyrWZ/3
         qV4iVtaRWFzDibYKG8JV40Vjq5N65WuilykTWJEBPMKPLWyjlqUXs072cAaIMFgJnNir
         TV3b+9nJ7LWnV/Gx0JtFHRN3OeE2d/Ug3TPa8m3jXL+348a5QSiav0VTWzwPt5OTtxpY
         w6cZr5XVGBPl8aXJ6JXiBgQXrWMotJQ93++qphzgUUVOoXN9/blmjooh3njWpCIwRp6K
         pc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zLYCQ6rxWkBVwB6B4jZyHQK9L5sqow/EvVD4ZkuTfxs=;
        b=PPcxxE1vgWQU4QDWx09iLchgOaakMsATkwSYVPKwho/zW8WtT9S90lCoLLMMoS7VlV
         iPHyfuYvp2TddlWPbBJ3pb9I8X3PSFGnPAclN0mynJaDASqR/W7kPY7GNYFExT4SRyLY
         j4gDaaArcSMX5lQpkNVal/DbIehiSksM3NlBsydDdXTVCeAHfqYWRYSAqOeLu2stU9ik
         Ho+e2He9dzBJ1SK0pjgRhIuP3WCE1JhQjBXaG1FVxyYYBDfWWyIPqHodDzOF4r8tLmZt
         YIUvAzFpv0UnTeNir9qqKTmkGBcSGK/t3Gzt5jPrJ0pQvsbtraunLlColkWfUZYwzldB
         HTiQ==
X-Gm-Message-State: ACgBeo0ib2AvgJpANqq0OpbVE8dS/pvvWTpWvJubt5ydnmOnyVsgVcHv
        2o+z/VqBlx7merfu+9z41kd3A4H30B/k0e2YEzM=
X-Google-Smtp-Source: AA6agR72cP3VP4buVO2VW8pPGacgkpWt3se1wdKOTVFZ30hx6uVQGZ7BNQrB1DV33X6Og9WovC7TPjmXfMACUd44DuI=
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id
 eb5-20020a0564020d0500b00425b7ab776emr4377472edb.142.1660319887350; Fri, 12
 Aug 2022 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com> <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
 <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com> <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org>
In-Reply-To: <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 12 Aug 2022 23:57:56 +0800
Message-ID: <CADiBU38+9sR1r20=YWt-9s2+u7maHH+1VudCnV1-0+F4jYKdQQ@mail.gmail.com>
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
=B48=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:54=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 12/08/2022 04:32, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B48=E6=9C=8811=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A10:12=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> On 11/08/2022 16:41, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add bindings for the Richtek RT9471 I2C controlled battery charger.
> >>>
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>> +properties:
> >>> +  compatible:
> >>> +    const: richtek,rt9471
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  ceb-gpios:
> >>> +    maxItems: 1
> >>
> >> This looks not standard, so please provide a description.
> > It's the external 'charge enable' pin that's used to control battery ch=
arging.
> > The priority is higher than the register 'CHG_EN' control.
> > In the word, 'b' means it's reverse logic, low to allow charging, high
> > to force disable charging.
>
> Isn't this standard enable-gpios property?
Not the same thing, this charger includes power patch control.
This gpio is used to 'force disable' charge the battery.
>
> >
> > description:
> >   External charge enable pin that can force control not to charge the b=
attery.
> >   Low to allow charging, high to disable charging.
> >
> >>
> >>> +
> >>> +  wakeup-source: true
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupt-controller: true
> >>> +
> >>> +  "#interrupt-cells":
> >>> +    const: 1
> >>
> >> Why a charger driver is a interrupt-controller?
> > There're 32 nested IRQs from RT9471.
> > The original thought is to make the user easy to bind the interrupt
> > into their driver.
>
> Bindings are not related to the driver but to hardware...
>
Sorry, I mislead  your comment.
Refer to bq2515x.yaml, I think it's better to change this property to
'charge-enable-gpios'.
It's the same usage like as TI charger.
> >
> > For charger driver, does it mean legacy IRQ handler is more preferred?
>
> Who is the consumer of these interrupts? Can you show the DTS with the
> interrupt consumer?
>
> >>
> >>> +
> >>> +  usb-otg-vbus-regulator:
> >>> +    type: object
> >>> +    unevaluatedProperties: false
> >>> +    $ref: /schemas/regulator/regulator.yaml#
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - wakeup-source
> >>> +  - interrupts
> >>> +  - interrupt-controller
> >>> +  - "#interrupt-cells"
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +    i2c {
> >>> +      #address-cells =3D <1>;
> >>> +      #size-cells =3D <0>;
> >>> +
> >>> +      charger@53 {
> >>> +        compatible =3D "richtek,rt9471";
> >>> +        reg =3D <0x53>;
> >>> +        ceb-gpios =3D <&gpio26 1 0>;
> >>
> >> Isn't the last value a GPIO flag? If yes, use appropriate define.
> > I already specify GPIOD_OUT_LOW in the gpiod_request flag.
>
> It is not related to the DTS. Anyway writing "low" for a meaning of high
> is not correct usually...
>
> > Do I need to convert the gpio request code to GPIOD_OUT_HIGH,
> > and specify here as GPIO_ACTIVE_LOW?
>
> You need to properly describe the hardware. The polarity of logical
> signal is defined by DTS, not by driver. It does not make sense to do it
> in driver. What if on some board the signal is inverted?
>
From our discussion, binding example just keep the active level that the pi=
n is.
So 'GPIO_ACTIVE_LOW', thanks.

All of the above will be fixed in the next revision.

> Best regards,
> Krzysztof
