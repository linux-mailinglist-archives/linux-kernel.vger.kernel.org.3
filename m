Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9344CFFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiCGNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCGNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:22:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C2779397;
        Mon,  7 Mar 2022 05:21:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu29so26262141lfb.0;
        Mon, 07 Mar 2022 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sLcucPpxL9xylt1wEHMJm21D4vcmzPmOGwMENuWyav8=;
        b=MMAMvWOqGAoEob9QfNBLxp7moVDA3Zk1uh+ELT0MXGpXw7KjOXkwBn8y5egC8h119B
         dWyok83LFulsXp2QtvsKw98hu9Ibvwg7Sn4fT0wslTcSWZDkJOG6lywWyM6WlnSD8Tp4
         jX1SaIOxZdDd1ia6T2g2cdRMCtJ9DOSqqkEodaF/3Dne9NARXPUn55uXCrPYCrtGrqHC
         7FvujQYpfJVN0XDxF5QGVPbXdJtfM/n8ckPA0vfMyjIDm6VpPFxX82O7c7zB0A2g6lFk
         EA2I+NEHxc0VlRiWTKMJSjZEGqDoVCubTyRvezmJ9ka/8ph6dibo6mc8uNiZYenQuFMh
         iQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sLcucPpxL9xylt1wEHMJm21D4vcmzPmOGwMENuWyav8=;
        b=kCNwHsmyb1j2mETxUhr5Wv2Rx7roBITpXGoxB4vaHzgPetDYCKoeIBK//NtA7ZFXe1
         xvS5joFg8duSFom/jbs4QpbOw1bHhZlKw2HXcM7MOg/MoYvGC5+RDd0X5OIb/oeu56A5
         2D9HipQodgb/8uR0omWW4RcMgDCPGvb+ose8MdZLVaV9iKFTaI/k0s4uKDieZiY8b5ur
         FZ483Aa+yKQp9pckJFSXjs/zHwRre0iG3ElwsD/+as7D5uyRzmqvnVazNVPL6oJkoLFj
         +SrNjTrLgelAs05/4kXt+mLxlJ6zvG0un5KxHYDX+9Jq0VWdwiGchpd4JNVPeF9AeL+a
         utsQ==
X-Gm-Message-State: AOAM533XpoPgxOPPZ/VnFUOpMRGGCNFuRl1KbD7Ip2sfztVHx4/qcFD8
        mYvDHx5j6t0DMdfcE1SLHZR/lZNHhpKVDd+x0UY=
X-Google-Smtp-Source: ABdhPJwhiTzKf526SMMoHnxGJaw5TFjBVrHKeQdx+H0cL7PAiYH8ypz7zGtr3dAcKk5XsTbpByJ3e5f7VTu3VntUQqg=
X-Received: by 2002:a05:6512:3152:b0:448:2622:e77f with SMTP id
 s18-20020a056512315200b004482622e77fmr6506171lfi.407.1646659278437; Mon, 07
 Mar 2022 05:21:18 -0800 (PST)
MIME-Version: 1.0
References: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
 <1646647704-2331-2-git-send-email-u0084500@gmail.com> <1e6893ca-69f4-a2ed-6ecc-23507c04002b@canonical.com>
In-Reply-To: <1e6893ca-69f4-a2ed-6ecc-23507c04002b@canonical.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 7 Mar 2022 21:21:06 +0800
Message-ID: <CADiBU3_jC_+P4d-gjMRGpP0uBejUkCY-axNd4nh1Y_=95iav3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5190A PMIC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:14=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 07/03/2022 11:08, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add bindings for Richtek RT5190A PMIC.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++++=
++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt5190a-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190=
a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt51=
90a-regulator.yaml
> > new file mode 100644
> > index 00000000..b9f5836
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regul=
ator.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulator=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT5190A PMIC Regulator
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT5190A integrates 1 channel buck controller, 3 channels high ef=
ficiency
> > +  synchronous buck converters, 1 LDO, I2C control interface and periph=
erial
> > +  logical control.
> > +
> > +  It also supports mute AC OFF depop sound and quick setting storage w=
hile
> > +  input power is removed.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt5190a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vin2-supply:
> > +    description: phandle to buck2 input voltage.
> > +
> > +  vin3-supply:
> > +    description: phandle to buck3 input voltage.
> > +
> > +  vin4-supply:
> > +    description: phandle to buck4 input voltage.
> > +
> > +  vinldo-supply:
> > +    description: phandle to ldo input voltage
> > +
> > +  richtek,buck1-fixed-microvolt:
> > +    description: buck1 fixed voltage that depends on the external resi=
stor.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>
> You should use standard bindings for it.
>
Sorry, I didn't get the point for the meaning 'standard binding'.
Do you mean to change 'richtek,buck1-fixed-microvolt' or 'uint32' definitio=
n?
This voltage depends on the external resistor selection. It's 'fixed'
by the application.
> > +
> > +  richtek,buck4-fixed-microvolt:
> > +    description: buck4 fixed voltage that depends on the external resi=
stor.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  richtek,ldo-fixed-microvolt:
> > +    description: ldo fixed voltage that depends on the external resist=
or.
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > +
> > +  richtek,mute-enable:
> > +    description: this can be used to enable mute function.
>
> Please describe what is "mute" function". Your description copied
> property name, so it is not useful.
>
OK, I'll describe more detailed.
> > +    type: boolean
> > +
> > +  regulators:
> > +    type: object
> > +
> > +    patternProperties:
> > +      "^buck[1-4]$|^ldo$":
> > +        type: object
> > +        $ref: regulator.yaml#
> > +        description: |
> > +          regulator description for buck[1-4] and ldo.
> > +
> > +        properties:
> > +          richtek,latchup-enable:
> > +            type: boolean
> > +            description: |
> > +              If specified, undervolt protection mode changes from the=
 default
> > +              hiccup to latchup.
> > +
> > +        unevaluatedProperties: false
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - richtek,buck1-fixed-microvolt
> > +  - richtek,buck4-fixed-microvolt
> > +  - richtek,ldo-fixed-microvolt
> > +  - regulators
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
> > +      rt5190a@64 {
>
> Generic node name, so "pmic".
>
Ack in next.
> > +        compatible =3D "richtek,rt5190a";
> > +        reg =3D <0x64>;
> > +        interrupts-extended =3D <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> > +        vin2-supply =3D <&rt5190_buck1>;
> > +        vin3-supply =3D <&rt5190_buck1>;
> > +        vin4-supply =3D <&rt5190_buck1>;
> > +        richtek,buck1-fixed-microvolt =3D <5090000>;
> > +        richtek,buck4-fixed-microvolt =3D <850000>;
> > +        richtek,ldo-fixed-microvolt =3D <1200000>;
> > +
> > +        regulators {
> > +          rt5190_buck1: buck1 {
> > +            regulator-name =3D "rt5190a-buck1";
> > +            regulator-allowed-modes =3D <0 1>;
>
> Please describe these in header file in bindings and mention as one of
> regulator properties with description and enum.
>
OK, will add one dt-binding header file for the constant and mentioned
as one regulator property.
Ack in next.
>
>
> Best regards,
> Krzysztof
