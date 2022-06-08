Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94A65428A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiFHH6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFHH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:57:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27E1E0AEA;
        Wed,  8 Jun 2022 00:25:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m25so18422512lji.11;
        Wed, 08 Jun 2022 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c9sFern1Uze4cTzolTMuXyyaQXW5pVqBf1oUfBBmYvI=;
        b=QEOx1XZrhbL74/B9SEIpn77bR+Bbf5EMb/mN5++wapT+1wqPWeJs+H2buTcJY5bXHm
         besE88Qpt70NKKqtkvZZRGjvBmjFgLX4yMYwPdjJMlyl5kLN4vfEzDi2rmvCQ8xGpKhr
         RWqpItaUsb0DomDLImmi1Gv58fLzxwfzDfi0iLAR2Sozb9s0dUMYKazfEoRTU+5HCCLP
         kNevl0JHLzJAkorRi/YiLMqxzN4Xb029VjGVEc5uWN2RBezRTLwTy6YkNrTcaTrWD0o0
         qjSGHshuxyotkZAj+9jpz5VPetrMorlGFZVyDpQTZKCAGqUGjdyt31LBQmLV9u7afP/9
         2YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c9sFern1Uze4cTzolTMuXyyaQXW5pVqBf1oUfBBmYvI=;
        b=MVggIucpJASFLsLcYEjYhs45mdy9V7wpdOgr58UonbmyTRmbDWNV6/VsTLGYtPdrAS
         vfFxK4Aw8JZocwyUtWYc1izqj8TE0goOwB1W+a+ik3VE945hLxhI2JIOEfwTLbHqGJ/7
         IJ+pks8gm7C9fDQb/NSkk+Ancxf8CE3gIfpnEYty0rIsKL2dTr+7jGPyIQaKVnOUlVeb
         /0ek10UCrvLPm73HUD3Ot2zn4B3Svm9/eer1dUr1l/dlsk9XDy2yjIBbBbIKxVhzpFSQ
         l4+1aghalug4N5FSReFTgo6ViJrzdPxTlRMAPjskXBgd9dU9krvh+ndswiww1HlF3sU3
         B17g==
X-Gm-Message-State: AOAM530L2W0g3JaYBv5SBTHo2FNMYnKzAuBrXPDlyUgCr73PFekgLtw3
        gg2qI2TqAE1Z1lmrgrQ8wI+/WQRAhh62yTkgwEn4dMfL
X-Google-Smtp-Source: ABdhPJxvnDFm5w11l2Mb0U4ayn5JKSd7+2PTFKc8tztSi2QkVJDuM/+mnQFl0dTORfnyB2SYYCi7kh2Ik7wEhsuzHfk=
X-Received: by 2002:a2e:904a:0:b0:255:7b02:8f32 with SMTP id
 n10-20020a2e904a000000b002557b028f32mr15646970ljg.133.1654673131629; Wed, 08
 Jun 2022 00:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com> <96ecca0b-b65c-749d-d66b-33443cacf2e4@linaro.org>
 <CADiBU39BTr9FjtXgBe55aOTHNVotHfC1n=aHrH3XAcVoWkk8sA@mail.gmail.com> <678ce480-cbbc-ffa8-10bf-d93021a0df0a@linaro.org>
In-Reply-To: <678ce480-cbbc-ffa8-10bf-d93021a0df0a@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 8 Jun 2022 15:25:20 +0800
Message-ID: <CADiBU38Gc2McH0ryRFPUAkmJzL1rxQnLHqvo5-+U_TPVjgHxzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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
=B46=E6=9C=888=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:02=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 08/06/2022 04:52, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B46=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:52=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> On 07/06/2022 07:52, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add Richtek RT5120 PMIC devicetree document.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++++=
++++++++++
> >>>  1 file changed, 180 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5=
120.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yam=
l b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> >>> new file mode 100644
> >>> index 00000000..376bf73
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> >>> @@ -0,0 +1,180 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/mfd/richtek,rt5120.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Richtek RT5120 PMIC
> >>> +
> >>> +maintainers:
> >>> +  - ChiYuan Huang <cy_huang@richtek.com>
> >>> +
> >>> +description: |
> >>> +  The RT5120 provides four high-efficiency buck converters and one L=
DO voltage
> >>> +  regulator. The device is targeted at providingthe processor voltag=
e, memory,
> >>> +  I/O, and peripheral rails in home entertainment devices. The I2C i=
nterface is
> >>> +  used for dynamic voltage scaling of the processor voltage, power r=
ails on/off
> >>> +  sequence control, operation mode selection.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - richtek,rt5120
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
>
> Your powerkey driver takes two interrupts. You should describe them in
> the powerkey.
>
> >>> +
> >>> +  interrupt-controller: true
> >>> +
> >>> +  "#interrupt-cells":
> >>> +    const: 1
> >>> +
> >>> +  wakeup-source: true
> >>> +
> >>> +  richtek,enable-undervolt-hiccup:
> >>> +    type: boolean
> >>> +    description: |
> >>> +      If used, under voltage protection trigger hiccup behavior, els=
e latchup as
> >>> +      default
> >>> +
> >>> +  richtek,enable-overvolt-hiccup:
> >>> +    type: boolean
> >>> +    description:
> >>> +      Like as 'enable-uv-hiccup', it configures over voltage protect=
ion to
> >>> +      hiccup, else latchup as default
> >>> +
> >>> +  vin1-supply:
> >>> +    description: phandle for buck1 input power source
> >>> +
> >>> +  vin2-supply:
> >>> +    description: phandle for buck2 input power source
> >>> +
> >>> +  vin3-supply:
> >>> +    description: phandle for buck3 input power source
> >>> +
> >>> +  vin4-supply:
> >>> +    description: phandle for buck4 input power source
> >>> +
> >>> +  vinldo-supply:
> >>> +    description: phandle for ldo input power source
> >>> +
> >>> +  regulators:
> >>> +    type: object
> >>> +
> >>> +    patternProperties:
> >>> +      "^buck[1-4]$":
> >>> +        type: object
> >>> +        $ref: /schemas/regulator/regulator.yaml#
> >>> +
> >>> +        properties:
> >>> +          regulator-allowed-modes:
> >>> +            description: |
> >>> +              Used to specify the allowed buck converter operating m=
ode
> >>> +              mode mapping:
> >>> +                0: auto mode
> >>> +                1: force pwm mode
> >>> +            items:
> >>> +              enum: [0, 1]
> >>> +
> >>> +        unevaluatedProperties: false
> >>
> >> Better to put it after '$ref' for readability.
> > OK, Fix in next
> >>
> >>> +
> >>> +      "^(ldo|exten)$":
> >>> +        type: object
> >>> +        $ref: /schemas/regulator/regulator.yaml#
> >>
> >> You need here unevaluatedProperties:false as well (for the ldo/exten
> >> properties)
> > Fix in next.
> >>
> >>> +
> >>> +    additionalProperties: false
> >>> +
> >>> +  powerkey:
> >>> +    type: object
> >>> +    description:
> >>> +      The power key driver may be optional. If not used, change node=
 status to
> >>> +      'disabled'
> >>
> >> This description is not helpful, does not describe the hardware. Pleas=
e
> >> describe hardware, not Devicetree usage.
> > That's because it's a PMIC. Power key is also connected to it.
> > For power key press, all power rails will start to power up.
> > But in the application, there may be other PMIC that's also connected
> > to power key.
> > That's why this power key driver may need to be optional.
> > One system only need one driver to report the power key status.
> >
> > Currently in some linux OS, it uses the auto module loading mechanism.
> > All kernel module files may be all the same, but it uses the
> > devicetree to decide how many devices
> > need to be declared. Since RT5120 power key device may be optional,
> > following by mfd_add_device, if of_node is
> > found, and status is "disabled", the sub device would be skipped.
> >
> > Actually, I'm also confused about it. There may be three ways to implem=
ent it
> > 1. not to build this kernel module -> seems to violate my above applica=
tion
> > 2. Use one boolean property to decide power key cell need to be used or=
 not??
> > 3. like as now, use the node status to decide it.
> >
> > Is there the better way to do it?
>
> The status does not determine whether device in the bindings is optional
> or not. Rather it's presence. In the term of bindings the "optional"
> means that something might not be there physically. E.g. clock line
> connected or not. System implementation - MFD, power off handling - is
> here (almost) irrelevant.
>
> In your case, the power key feature seems to be there always, so the
> "powerkey" node should be required and not disabled. Don't mention in
> description of hardware anything about disabling it or not.
>
> In your application, I would say it is interesting design that someone
> connects one power up line to two different PMICs in a conflicting way.
> This sounds like total mistake from hardware point of view.
>
> Anyway it is not the job for this patch to solve such conflicts.
>
Thanks,  I think your point is 'optional' keyword.
If there's only redundant description line, I may decide to remove it.
The property name already show its usage.
> Best regards,
> Krzysztof
