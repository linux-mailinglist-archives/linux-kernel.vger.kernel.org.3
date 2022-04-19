Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82ED5061DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbiDSB45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbiDSB44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:56:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651A2A265;
        Mon, 18 Apr 2022 18:54:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so570330wms.0;
        Mon, 18 Apr 2022 18:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXHIuO3Zg/MMr8+Axpf8/PPvILA/PMGB3lcXS1iPaso=;
        b=F8+43CuJ9YoLXL8CxHf19t5/rFf1MBn3vz//kBoy3/VGeE66S5LvVuZk/WGItU4AtY
         nJBVQMKNqpBCvymiDhaWv2OBkZyfbBs0KyixioJTc7IX/+XTaELXLFl/qVPBuj+g9hqJ
         4SKtgUNgUpj7RWBkdQMT9/dR5oH9DAChWwMUvNgRz9W7hZ5WHM6cJJ+Fm5MhuEdBVQ/Q
         MsyuqcurFCPYnkdXsD5rU+v3fMk22IDOquOZeo14BZQdAQb6YcLfGXQPKJYSd4wT+0hM
         rn9HrTscfeWEyhxJZTSgBJxdndvjKQP/387HxwTfkd6fkdYfWgLjuSAIFDd+6/PllI1o
         NFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXHIuO3Zg/MMr8+Axpf8/PPvILA/PMGB3lcXS1iPaso=;
        b=yVQ05r+J90W8hTZ/SErVQKammuxCyF2U+dFBtHvhyl/ks7+LrVNMEmTPlrj3v0bMZP
         9olBw94zYlY/4XL4WzeTgd8uuVCSAXHKKZaKNYYm8/NgP8Zqh7M5klm6acLUTokAPpF2
         ay9FsAzIaxWpEkgxItMIIYK/fUCzxFP07JeD6bZJinN+0ko2R5CeT5y7wfgNnV4FG7X9
         YGC1Ud7Ry8iwF7nSnX5bW+pVWigvIRYSwYM8wKRFq6xFN6X3GiMWLde6nUZmLgT9/tW6
         yjflvJM2ZrQB5ODN/QhoerUZZkrL7JCL6a6HXVoBZT5SwaumzLnT/Z2C0lP3oSXlCKQJ
         549g==
X-Gm-Message-State: AOAM5330CI4jjfd8i2iiDV4CN8yZ4Y4Sfm0PZev5W5IKPWjl+yxk4e4M
        zX8w3udtHDS/Vtre7Fm1jwI74ygHqAo506m5mKY=
X-Google-Smtp-Source: ABdhPJz6tK7tm2CrLT8+1v60pEArnfBEA7Be12W5T0Je3SDwxlYwvHGdSScaEn8EPULM1JSHyBv43dCv+XgnsGKbknk=
X-Received: by 2002:a05:600c:a03:b0:38c:f953:ae13 with SMTP id
 z3-20020a05600c0a0300b0038cf953ae13mr13482468wmp.99.1650333253086; Mon, 18
 Apr 2022 18:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220418125630.2342538-1-gengcixi@gmail.com> <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
In-Reply-To: <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 19 Apr 2022 09:53:37 +0800
Message-ID: <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
4=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 00:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 18/04/2022 14:56, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Add a new bindings to describe ums512 clock compatible string.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512=
-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.ya=
ml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > new file mode 100644
> > index 000000000000..89824d7c6be4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > @@ -0,0 +1,112 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2022 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: UMS512 Clock Control Unit Device Tree Bindings
>
> Remove "Device Tree Bindings". You could do the same also in the
> subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
> ums512 clock controller").
>
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  compatible:
>
> Put the compatible first, by convention and makes finding matching
> bindings easier.
>
> > +    oneOf:
> > +      - items:
> > +          - const: sprd,ums512-glbregs
> > +          - const: syscon
> > +          - const: simple-mfd
>
> Why do you need simple-mfd for these? This looks like a regular syscon,
> so usually does not come with children. What is more, why this "usual
> syscon" is a separate clock controller in these bindings?
there is a warning log before add these const.  and the reason we need
the simply-mfd
is some clock is a child of syscon node,which should set these compatible.
failed to match any schema with compatible: ['sprd,ums512-glbregs',
'syscon', 'simple-mfd']
>
> > +      - items:
> > +          - enum:
> > +              - sprd,ums512-apahb-gate
> > +              - sprd,ums512-ap-clk
> > +              - sprd,ums512-aonapb-clk
> > +              - sprd,ums512-pmu-gate
> > +              - sprd,ums512-g0-pll
> > +              - sprd,ums512-g2-pll
> > +              - sprd,ums512-g3-pll
> > +              - sprd,ums512-gc-pll
> > +              - sprd,ums512-aon-gate
> > +              - sprd,ums512-audcpapb-gate
> > +              - sprd,ums512-audcpahb-gate
> > +              - sprd,ums512-gpu-clk
> > +              - sprd,ums512-mm-clk
> > +              - sprd,ums512-mm-gate-clk
> > +              - sprd,ums512-apapb-gate
> > +
> > +  clocks:
> > +    minItems: 1
>
> maxItems needed
the previous version did has the maxitems, but makes error when run
'make DT_CHECKER_FLAGS=3D-m dt_binding_check O=3D./dt-out  \
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/clock/sprd,ums512-clk.y=
aml'
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml=
:
properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items':
[{'const': 'ext-26m'}, {'const': 'ext-32k'}, {'const': 'ext-4m'},
{'const': 'rco-100m'}]} should not be valid under {'required':
['maxItems']}
hint: "maxItems" is not needed with an "items" list

>
> > +    description: |
> > +      The input parent clock(s) phandle for this clock, only list fixe=
d
> > +      clocks which are declared in devicetree.
>
> The description does not make sense. These are bindings for a clock
> controller, but you say here "for this clock", so what does "this" mean
> here?
>
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: ext-26m
> > +      - const: ext-32k
> > +      - const: ext-4m
> > +      - const: rco-100m
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
>
> Isn't reg also required? Always? Do you have examples where it is not
> required? How do you configure the clocks without "reg"? I see you
> copied a lot from sprd,sc9863a-clk.yaml but that file does not look corre=
ct.
>
> You have nodes with reg but without unit address ("rpll"). These nodes
> are modeled as children but they are not children - it's a workaround
> for exposing syscon, isn't it? The sc9863a looks like broken design, so
> please do not duplicate it here.
>
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      enum:
> > +        - sprd,ums512-ap-clk
> > +        - sprd,ums512-aonapb-clk
> > +        - sprd,ums512-mm-clk
> > +then:
> > +  required:
> > +    - reg
> > +
> > +else:
> > +  description: |
> > +    Other UMS512 clock nodes should be the child of a syscon node in
> > +    which compatible string should be:
> > +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> > +
> > +    The 'reg' property for the clock node is also required if there is=
 a sub
> > +    range of registers for the clocks.
> > +
> > +additionalProperties: true
>
> false
the "false" makes error log:
/path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.exam=
ple.dtb:
syscon@71000000: '#address-cells', '#size-cells',
'clock-controller@0', 'ranges' do not match any of the regexes:
'pinctrl-[0-9]+'
and I reference the patch
[https://www.spinics.net/lists/linux-leds/msg17032.html]

>
> > +
> > +examples:
> > +  - |
> > +    ap_clk: clock-controller@20200000 {
> > +      compatible =3D "sprd,ums512-ap-clk";
> > +      reg =3D <0x20200000 0x1000>;
> > +      clocks =3D <&ext_26m>;
> > +      clock-names =3D "ext-26m";
> > +      #clock-cells =3D <1>;
> > +    };
> > +
> > +  - |
> > +    ap_apb_regs: syscon@71000000 {
> > +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-mfd";
>
> So here is the answer why you added MFD, but I still don't get why do
> you need it for one child? It is quite a dance here and in your drivers,
> instead of adding "syscon" to your clock controller.

[1]in the if/else describtion,  th other UMS512 clock nodes should be
the child of a syscon node in
which compatible string should be:   "sprd,ums512-glbregs", "syscon",
"simple-mfd"

>
> This also pollutes the actual bindings because you did not add
> properties required for clock controllers, because of describing here
> the syscon part.
>
> > +      reg =3D <0x71000000 0x3000>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      #clock-cells =3D <1>;
> > +      ranges =3D <0 0x71000000 0x3000>;
> > +
> > +      apahb_gate: clock-controller@0 {
> > +        compatible =3D "sprd,ums512-apahb-gate";
> > +        reg =3D <0x0 0x2000>;
> > +        #clock-cells =3D <1>;
> > +      };
> > +    };
> > +
> > +...
>
>
> Best regards,
> Krzysztof
