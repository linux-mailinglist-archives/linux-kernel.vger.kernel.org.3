Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B233542358
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiFHFaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiFHF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:28:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE91137C76;
        Tue,  7 Jun 2022 19:52:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id be31so31149295lfb.10;
        Tue, 07 Jun 2022 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BI8cyUkiseZ6PPtOnXzhSkA0pyub0JYKY0CWFua4rTg=;
        b=L+xbdkhNvNDEHULysuGF+Mx7AlPUHX4fUbsF0kfVsrgqdj2S71m91lgloZXazUL3RB
         rPPq2uPj2h0UdaIBTZKJsBwh4kdHxSD0mdql9GLpv6K9inlf9BRWMEH+lbKeh0GiW5x/
         qYhn8yqM6GuX+3uIG1eGUUVV/gGrQAC8xfytItYvUU0V5QSWWEyr4OgLdm91Gd2IGcH9
         rXkEogb+m8ifZWcMgKRrdxZl0DZptlb5PpZ5XbDJauL/FeBdEC+2FQaq33pddV/4Nv6V
         htYG4OLxCvGYae3v5LSPm/Ib9JkHmMX6OyB1yVtrZBEs7boLMzjTtKrY7Oq0IzOdlE5r
         +9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BI8cyUkiseZ6PPtOnXzhSkA0pyub0JYKY0CWFua4rTg=;
        b=wexkp0Qpa8i7qZnrQahG0YrRT5PcHlABfPuKCpDXDgEmSsaCwUB0AXtMzxx0EvlRkh
         da1voTekQwfXWerVSCayRbWqBvAv7tCxNKUmqAa5qbab0EGq3BHXszEPSQNapKedCy39
         yfe8fDgkX0zhqKxOywS7vifZi5GUsgiP8s3npEZTtkMzaSwWbbT0wCdFTh432TJN4cg6
         2dhHlMMIt8+pnvgNV0V4J0nQ8XKdIzdAlu7Mcmp3xov0VN8/nA8ze13U0yHGlsmlpoMb
         KuKWjeGXu4TSQtIB1rwxI5kePaeX+2Y8L5DWCyRYn2vKdqqWlPmzrQY7cr80LjDXF+Qu
         Ckig==
X-Gm-Message-State: AOAM530LmUabViCap5pnBHY2tWRqkUIjMoVRssKKBmM+RCH+/c0SdX41
        kOuU1UWRHtkNM6VU6geToc/9g/ZWZ38oLScYhVY=
X-Google-Smtp-Source: ABdhPJy5XZ3uo5WLLTVFBq8lc62CYb9i9+NtOLbSgnpqRIK5Oop7EVbfQkNkCc6nem9+z5uVedCK4eRXtBPTWBqpxQg=
X-Received: by 2002:a05:6512:2251:b0:478:fc67:b09f with SMTP id
 i17-20020a056512225100b00478fc67b09fmr19895053lfu.196.1654656775857; Tue, 07
 Jun 2022 19:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com> <96ecca0b-b65c-749d-d66b-33443cacf2e4@linaro.org>
In-Reply-To: <96ecca0b-b65c-749d-d66b-33443cacf2e4@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 8 Jun 2022 10:52:44 +0800
Message-ID: <CADiBU39BTr9FjtXgBe55aOTHNVotHfC1n=aHrH3XAcVoWkk8sA@mail.gmail.com>
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
=B46=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:52=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 07/06/2022 07:52, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek RT5120 PMIC devicetree document.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++++++=
++++++++
> >  1 file changed, 180 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt512=
0.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml =
b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> > new file mode 100644
> > index 00000000..376bf73
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> > @@ -0,0 +1,180 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/richtek,rt5120.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT5120 PMIC
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT5120 provides four high-efficiency buck converters and one LDO=
 voltage
> > +  regulator. The device is targeted at providingthe processor voltage,=
 memory,
> > +  I/O, and peripheral rails in home entertainment devices. The I2C int=
erface is
> > +  used for dynamic voltage scaling of the processor voltage, power rai=
ls on/off
> > +  sequence control, operation mode selection.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt5120
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  wakeup-source: true
> > +
> > +  richtek,enable-undervolt-hiccup:
> > +    type: boolean
> > +    description: |
> > +      If used, under voltage protection trigger hiccup behavior, else =
latchup as
> > +      default
> > +
> > +  richtek,enable-overvolt-hiccup:
> > +    type: boolean
> > +    description:
> > +      Like as 'enable-uv-hiccup', it configures over voltage protectio=
n to
> > +      hiccup, else latchup as default
> > +
> > +  vin1-supply:
> > +    description: phandle for buck1 input power source
> > +
> > +  vin2-supply:
> > +    description: phandle for buck2 input power source
> > +
> > +  vin3-supply:
> > +    description: phandle for buck3 input power source
> > +
> > +  vin4-supply:
> > +    description: phandle for buck4 input power source
> > +
> > +  vinldo-supply:
> > +    description: phandle for ldo input power source
> > +
> > +  regulators:
> > +    type: object
> > +
> > +    patternProperties:
> > +      "^buck[1-4]$":
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml#
> > +
> > +        properties:
> > +          regulator-allowed-modes:
> > +            description: |
> > +              Used to specify the allowed buck converter operating mod=
e
> > +              mode mapping:
> > +                0: auto mode
> > +                1: force pwm mode
> > +            items:
> > +              enum: [0, 1]
> > +
> > +        unevaluatedProperties: false
>
> Better to put it after '$ref' for readability.
OK, Fix in next
>
> > +
> > +      "^(ldo|exten)$":
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml#
>
> You need here unevaluatedProperties:false as well (for the ldo/exten
> properties)
Fix in next.
>
> > +
> > +    additionalProperties: false
> > +
> > +  powerkey:
> > +    type: object
> > +    description:
> > +      The power key driver may be optional. If not used, change node s=
tatus to
> > +      'disabled'
>
> This description is not helpful, does not describe the hardware. Please
> describe hardware, not Devicetree usage.
That's because it's a PMIC. Power key is also connected to it.
For power key press, all power rails will start to power up.
But in the application, there may be other PMIC that's also connected
to power key.
That's why this power key driver may need to be optional.
One system only need one driver to report the power key status.

Currently in some linux OS, it uses the auto module loading mechanism.
All kernel module files may be all the same, but it uses the
devicetree to decide how many devices
need to be declared. Since RT5120 power key device may be optional,
following by mfd_add_device, if of_node is
found, and status is "disabled", the sub device would be skipped.

Actually, I'm also confused about it. There may be three ways to implement =
it
1. not to build this kernel module -> seems to violate my above application
2. Use one boolean property to decide power key cell need to be used or not=
??
3. like as now, use the node status to decide it.

Is there the better way to do it?
>
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - richtek,rt5120-pwrkey
> > +
> > +    required:
> > +      - compatible
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +  - regulators
> > +  - powerkey
>
> You wrote powerkey is optional... so the node should not be required, rig=
ht?
Yes, required. Please refer to the above explanation.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      pmic@62 {
> > +        compatible =3D "richtek,rt5120";
> > +        reg =3D <0x62>;
> > +        interrupts-extended =3D <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
> > +        interrupt-controller;
> > +        #interrupt-cells =3D <1>;
> > +        wakeup-source;
> > +
> > +        regulators {
> > +          buck1 {
> > +            regulator-name =3D "rt5120-buck1";
> > +            regulator-min-microvolt =3D <600000>;
> > +            regulator-max-microvolt =3D <1393750>;
> > +            regulator-allowed-modes =3D <0 1>;
> > +            regulator-boot-on;
> > +          };
> > +          buck2 {
> > +            regulator-name =3D "rt5120-buck2";
> > +            regulator-min-microvolt =3D <1100000>;
> > +            regulator-max-microvolt =3D <1100000>;
> > +            regulator-allowed-modes =3D <0 1>;
> > +            regulator-always-on;
> > +          };
> > +          buck3 {
> > +            regulator-name =3D "rt5120-buck3";
> > +            regulator-min-microvolt =3D <1800000>;
> > +            regulator-max-microvolt =3D <1800000>;
> > +            regulator-allowed-modes =3D <0 1>;
> > +            regulator-always-on;
> > +          };
> > +          buck4 {
> > +            regulator-name =3D "rt5120-buck4";
> > +            regulator-min-microvolt =3D <3300000>;
> > +            regulator-max-microvolt =3D <3300000>;
> > +            regulator-allowed-modes =3D <0 1>;
> > +            regulator-always-on;
> > +          };
> > +          ldo {
> > +            regulator-name =3D "rt5120-ldo";
> > +            regulator-min-microvolt =3D <1800000>;
> > +            regulator-max-microvolt =3D <1800000>;
> > +            regulator-always-on;
> > +          };
> > +          exten {
> > +            regulator-name =3D "rt5120-exten";
> > +            regulator-min-microvolt =3D <3000000>;
> > +            regulator-max-microvolt =3D <3000000>;
> > +            regulator-always-on;
> > +          };
> > +        };
> > +        powerkey {
> > +                status =3D "okay";
>
> Messed up indentation. No need for status in examples.
Fix in next.
>
> > +                compatible =3D "richtek,rt5120-pwrkey";
> > +        };
> > +      };
> > +    };
>
>
> Best regards,
> Krzysztof
