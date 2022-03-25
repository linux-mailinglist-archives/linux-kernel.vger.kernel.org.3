Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9F4E746E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357919AbiCYNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358054AbiCYNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:46:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82AFD0802;
        Fri, 25 Mar 2022 06:45:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so7605312lfa.12;
        Fri, 25 Mar 2022 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U7RXOe2HEKPXL9d1M0pQtidpwu68u/vbgF3NH6dmjFg=;
        b=F+AVndHHKDeOx9JeDmGsP4LYRRMgOWPEMkd7CRfMDgVLqKUklS5outZNV1y6MqCemk
         UK+wUsjnMuWrYRH87p7Bt0feSKM/95GleOVWdf7oll2eUH+ply2qzI944CQk9Id0Vmqw
         aa0vWG4IutIl3oKLCL1Nx+OEglTaVYftcxitz5+yZK+QYxv16G/Qfm8x7R466TBvEZS2
         fque7ov69l6K30VSGWafgAAxzlL7s4WEiCnLUBW6tlGut8F+vh4zUMKH7rg6sRP3LMkS
         H+zpQ7gartEGh4p7R4ltQor7XO8uLySUB1KEC/kDxK6Uq8Fdfg6xwoaekeNEfy3zw6nL
         PzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U7RXOe2HEKPXL9d1M0pQtidpwu68u/vbgF3NH6dmjFg=;
        b=Zd/V0W46DwfzZGhHVU0dxzhPViYd8KN98OCrBnFTMd2b84jkVT2gwkZg33ncK9P17Y
         LzGGNuMe6Kz4VMePF8t13n/o6O7jnDNYWx9QMsstxLEJVfb17jo3u1bDlmQsxhT81iL5
         qlrqk3uLgAzTKmCdt5GJa/OxP08cYG3jLwKXhIqpO6Bmi2lFO2L4bt6Vz9HlQU/TxvpK
         k+2gdbpT0KjkMyyd0R5KLTk5j/bFbTUJaQVn8cwW7WF4WxokxDyhxKpqkDzqMfL8RkGH
         +ZindAHh/jXsgssOZ8vOa+nKrobXaiINvPcZqX4gsyh2Il/cFAkwDbYsH0LIQq9xgoex
         qsIg==
X-Gm-Message-State: AOAM532Mtop/Gl5AWUuaTnACVq1Tkn59WR6Mj3rXYnT+XAwElFOT8WSh
        GTHKx6Q9xGCUSi1FHe4nRFXZVhx+yOM/BM2AKaA=
X-Google-Smtp-Source: ABdhPJw58yvTNAGSPofxofaYH3q15H1XOulhcu6A38UJbbTasvfZ25ge/9VoASATCmGhSzOo8eVmzO8YASZwrsq9SqM=
X-Received: by 2002:ac2:555e:0:b0:44a:3cfa:3fde with SMTP id
 l30-20020ac2555e000000b0044a3cfa3fdemr7744276lfk.448.1648215904036; Fri, 25
 Mar 2022 06:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-2-git-send-email-u0084500@gmail.com> <d9b883d2-8269-8419-3bcd-3761074bea96@kernel.org>
In-Reply-To: <d9b883d2-8269-8419-3bcd-3761074bea96@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Mar 2022 21:44:52 +0800
Message-ID: <CADiBU3_06mCfBFXc5XAaeNd+G=Yf4MK5Ze429H8iUm=kpFMa5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add binding for Richtek
 RT5759 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
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

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:14=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 25/03/2022 02:06, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add bindings for Richtek RT5759 high-performance DCDC converter.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../regulator/richtek,rt5759-regulator.yaml        | 90 ++++++++++++++=
++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt5759-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5759=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt575=
9-regulator.yaml
> > new file mode 100644
> > index 00000000..c24b583
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regula=
tor.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt5759-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT5759 High Performance DCDC Concverter
>
> typo: Converter
>
Ack in next.
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT5759 is a high-performance, synchronous step-down DC-DC conver=
ter that
> > +  can deliver up to 9A output current from 3V to 6.5V input supply, Th=
e output
> > +  voltage can be programmable with I2C controlled 7-Bit VID.
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RT5759/DS5759-00.pdf
> > +
> > +allOf:
> > +  - $ref: regulator.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt5759
> > +      - richtek,rt5759a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  regulator-allowed-modes:
> > +    description: |
> > +      buck allowed operating mode
> > +        0: auto mode (PSKIP: pulse skipping)
> > +        1: force pwm mode
> > +    items:
> > +      enum: [0, 1]
> > +
> > +  richtek,watchdog-enable:
> > +    description: enable the external watchdog reset pin listening
> > +    type: boolean
> > +
> > +if:
>
> This should be inside allOf. Move allOf here,
>
Ack in next.
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: richtek,rt5759
> > +then:
> > +  properties:
> > +    richtek,watchdog-enable: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  # example 1 for RT5759
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rt5759@62 {
>
> Generic node name, so pmic.
>
As my understanding, 'pmic' means there must be multiple channels of
buck or ldo.
But  rt5759 is only one channel buck converter.

> > +        compatible =3D "richtek,rt5759";
> > +        reg =3D <0x62>;
> > +        regulator-name =3D "rt5759-buck";
> > +        regulator-min-microvolt =3D <600000>;
> > +        regulator-max-microvolt =3D <1500000>;
> > +        regulator-boot-on;
> > +      };
> > +    };
> > +  # example 2 for RT5759A
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      rt5759a@62 {
>
> Ditto
>
> > +        compatible =3D "richtek,rt5759a";
> > +        reg =3D <0x62>;
> > +        regulator-name =3D "rt5759a-buck";
> > +        regulator-min-microvolt =3D <600000>;
> > +        regulator-max-microvolt =3D <1725000>;
> > +        regulator-boot-on;
> > +        richtek,watchdog-enable;
> > +      };
> > +    };
>
>
> Best regards,
> Krzysztof
