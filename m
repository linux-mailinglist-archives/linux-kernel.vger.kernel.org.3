Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CC50CED3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiDXDS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiDXDSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:18:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D601B9B;
        Sat, 23 Apr 2022 20:15:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so16308302wrc.0;
        Sat, 23 Apr 2022 20:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WpZl1eDbTl8L5h6pp/lwpzQKXmpUJMkk+Xg6ZZpHnFo=;
        b=bTxKqgqiGoSgX/J++WwuOAVkMK7jffkB+/mXcZXxInFZjpSD2E9jDAImJJbxQEwtzx
         OH7M/EXBgiv1SvcLEbYu/bAPUxALyPwWaLlcjmMZHZ2EabBAlvxalav4Fai5UrOGK84r
         IMEw1v9zkjoWzF8FyTLDJLldFCzvc/c4HGYXU0KS7pmGx37hlnFbVv3EdxArOQRqeyyq
         sPiPxfxvx4jS6y66SO08aYVRvr8b8/za3iZaLFTPvkAaGjk/gbFPCFGsGYveX2+QW8St
         sPhvDYPliglrPbw+6siDiyhbDNDgprtIw3SAmnPVqpAszyhYKI6zCi32eDzBt3/a4snO
         ZA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WpZl1eDbTl8L5h6pp/lwpzQKXmpUJMkk+Xg6ZZpHnFo=;
        b=DqDTKvLohPpV+oPwaHY2DouVB8Vifp1QArceJcUUD2yDNeeMBOhrA8D6lqDD956Lw5
         nGFVLHBkU9B/CpywJi9fSZhr3BQIccUSK7VQw9bnSYik01qCeEHlcuqmIpNibK1L30VG
         n5QddTjQ+9awzQMhlq3W67FWQ0Keb7BoHgX/z6E+gSHa2XY3eQBefH5mA59yspxeRdfI
         MbCyclQYU8BtF+C9ZcWJvDS9exVsh4Hw6TjmdekOEmuy1VB+E/i0LKzLrCNG2pvL/Rm3
         Thl8DJdlgLyPikoiDsRIpgGuIH9LRPYMKORjXiCCayUbXVFFo7k5svPbTvoMrQjOqhWT
         G1LQ==
X-Gm-Message-State: AOAM530XV8pFe0EpymxNb2DvoxKwYaCu6/I6bb1zS/iZdlloRQwf1F4D
        ujh33xzxqwnk6XGHsR1okZEdZnOu8qMCRTm+xC4=
X-Google-Smtp-Source: ABdhPJypN7WQoJioTvhOXHv8P94YLOJNbZHRXFFzhj8FGR+6aY4YxPNytGYQC2lIOjec6QYLujA4sfkB72EaSu+r4CI=
X-Received: by 2002:a05:6000:15cd:b0:20a:aaf7:33e4 with SMTP id
 y13-20020a05600015cd00b0020aaaf733e4mr9376876wry.406.1650770121745; Sat, 23
 Apr 2022 20:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220418125630.2342538-1-gengcixi@gmail.com> <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org> <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
In-Reply-To: <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Sun, 24 Apr 2022 11:14:45 +0800
Message-ID: <CAF12kFsqOSZDZ9iw+KfR-x533YzNa=yxR1rqWuoGX=vBgh+wGw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof:
I find the history discuss about the sp9863 clock[1] and last
ums512-clk dt-bindings patch[2] which from chunyan.
please refer to the reasons below.

These clocks are at the same register range with global registers.
the registers shared with more than one devices
 which  basically are multimedia devices. You may noticed that these
are all gate clocks which are in the global registers
 ranges and are used to controll the enable status of some devices or
some part of devices.

[1].https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=3DFTe5S7CzAHC5mahXBH2fJm=
7mXS7Xys1Q@mail.gmail.com/
[2].https://lore.kernel.org/all/163425295208.1688384.11023187625793114662@s=
wboyd.mtv.corp.google.com/

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
4=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 14:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19/04/2022 03:53, Cixi Geng wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=
=B9=B44=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 00:28=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On 18/04/2022 14:56, Cixi Geng wrote:
> >>> From: Cixi Geng <cixi.geng1@unisoc.com>
> >>>
> >>> Add a new bindings to describe ums512 clock compatible string.
> >>>
> >>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >>> ---
> >>>  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++=
++
> >>>  1 file changed, 112 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums5=
12-clk.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.=
yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>> new file mode 100644
> >>> index 000000000000..89824d7c6be4
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>> @@ -0,0 +1,112 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +# Copyright 2022 Unisoc Inc.
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> >>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >>> +
> >>> +title: UMS512 Clock Control Unit Device Tree Bindings
> >>
> >> Remove "Device Tree Bindings". You could do the same also in the
> >> subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
> >> ums512 clock controller").
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Orson Zhai <orsonzhai@gmail.com>
> >>> +  - Baolin Wang <baolin.wang7@gmail.com>
> >>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> >>> +
> >>> +properties:
> >>> +  "#clock-cells":
> >>> +    const: 1
> >>> +
> >>> +  compatible:
> >>
> >> Put the compatible first, by convention and makes finding matching
> >> bindings easier.
> >>
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - const: sprd,ums512-glbregs
> >>> +          - const: syscon
> >>> +          - const: simple-mfd
> >>
> >> Why do you need simple-mfd for these? This looks like a regular syscon=
,
> >> so usually does not come with children. What is more, why this "usual
> >> syscon" is a separate clock controller in these bindings?
> > there is a warning log before add these const.  and the reason we need
> > the simply-mfd
> > is some clock is a child of syscon node,which should set these compatib=
le.
> > failed to match any schema with compatible: ['sprd,ums512-glbregs',
> > 'syscon', 'simple-mfd']
>
> Neither here nor later you did not answer the question - why do you need
> such complex construction, instead of adding syscon to the clock controll=
er?
>
> Let me paste again my concerns:
>
>   You have nodes with reg but without unit address ("rpll"). These nodes
>   are modeled as children but they are not children - it's a workaround
>   for exposing syscon, isn't it? The sc9863a looks like broken design,
>   so please do not duplicate it here.
>
> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
> Because of this you need to create complex ways to get the regmap for
> the clock controller... Why not making it simple? Clock controller with
> syscon?
>
> >>
> >>> +      - items:
> >>> +          - enum:
> >>> +              - sprd,ums512-apahb-gate
> >>> +              - sprd,ums512-ap-clk
> >>> +              - sprd,ums512-aonapb-clk
> >>> +              - sprd,ums512-pmu-gate
> >>> +              - sprd,ums512-g0-pll
> >>> +              - sprd,ums512-g2-pll
> >>> +              - sprd,ums512-g3-pll
> >>> +              - sprd,ums512-gc-pll
> >>> +              - sprd,ums512-aon-gate
> >>> +              - sprd,ums512-audcpapb-gate
> >>> +              - sprd,ums512-audcpahb-gate
> >>> +              - sprd,ums512-gpu-clk
> >>> +              - sprd,ums512-mm-clk
> >>> +              - sprd,ums512-mm-gate-clk
> >>> +              - sprd,ums512-apapb-gate
> >>> +
> >>> +  clocks:
> >>> +    minItems: 1
> >>
> >> maxItems needed
> > the previous version did has the maxitems, but makes error when run
> > 'make DT_CHECKER_FLAGS=3D-m dt_binding_check O=3D./dt-out  \
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/clock/sprd,ums512-c=
lk.yaml'
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > /path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.=
yaml:
> > properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items':
> > [{'const': 'ext-26m'}, {'const': 'ext-32k'}, {'const': 'ext-4m'},
> > {'const': 'rco-100m'}]} should not be valid under {'required':
> > ['maxItems']}
> > hint: "maxItems" is not needed with an "items" list
>
> Warning is about clock-names, not about clocks. Fix the bindings.
>
> >
> >>
> >>> +    description: |
> >>> +      The input parent clock(s) phandle for this clock, only list fi=
xed
> >>> +      clocks which are declared in devicetree.
> >>
> >> The description does not make sense. These are bindings for a clock
> >> controller, but you say here "for this clock", so what does "this" mea=
n
> >> here?
> >>
> >>> +
> >>> +  clock-names:
> >>> +    minItems: 1
> >>> +    items:
> >>> +      - const: ext-26m
> >>> +      - const: ext-32k
> >>> +      - const: ext-4m
> >>> +      - const: rco-100m
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - '#clock-cells'
> >>
> >> Isn't reg also required? Always? Do you have examples where it is not
> >> required? How do you configure the clocks without "reg"? I see you
> >> copied a lot from sprd,sc9863a-clk.yaml but that file does not look co=
rrect.
> >>
> >> You have nodes with reg but without unit address ("rpll"). These nodes
> >> are modeled as children but they are not children - it's a workaround
> >> for exposing syscon, isn't it? The sc9863a looks like broken design, s=
o
> >> please do not duplicate it here.
> >>
> >>> +
> >>> +if:
> >>> +  properties:
> >>> +    compatible:
> >>> +      enum:
> >>> +        - sprd,ums512-ap-clk
> >>> +        - sprd,ums512-aonapb-clk
> >>> +        - sprd,ums512-mm-clk
> >>> +then:
> >>> +  required:
> >>> +    - reg
> >>> +
> >>> +else:
> >>> +  description: |
> >>> +    Other UMS512 clock nodes should be the child of a syscon node in
> >>> +    which compatible string should be:
> >>> +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> >>> +
> >>> +    The 'reg' property for the clock node is also required if there =
is a sub
> >>> +    range of registers for the clocks.
> >>> +
> >>> +additionalProperties: true
> >>
> >> false
> > the "false" makes error log:
> > /path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.=
example.dtb:
> > syscon@71000000: '#address-cells', '#size-cells',
> > 'clock-controller@0', 'ranges' do not match any of the regexes:
> > 'pinctrl-[0-9]+'
> > and I reference the patch
> > [https://www.spinics.net/lists/linux-leds/msg17032.html]
>
> Which needs fixing. The "false" is a strict requirement for such end
> (non-extendable) bindings.
>
> >
> >>
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    ap_clk: clock-controller@20200000 {
> >>> +      compatible =3D "sprd,ums512-ap-clk";
> >>> +      reg =3D <0x20200000 0x1000>;
> >>> +      clocks =3D <&ext_26m>;
> >>> +      clock-names =3D "ext-26m";
> >>> +      #clock-cells =3D <1>;
> >>> +    };
> >>> +
> >>> +  - |
> >>> +    ap_apb_regs: syscon@71000000 {
> >>> +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-mfd";
> >>
> >> So here is the answer why you added MFD, but I still don't get why do
> >> you need it for one child? It is quite a dance here and in your driver=
s,
> >> instead of adding "syscon" to your clock controller.
> >
> > [1]in the if/else describtion,  th other UMS512 clock nodes should be
> > the child of a syscon node in
> > which compatible string should be:   "sprd,ums512-glbregs", "syscon",
> > "simple-mfd"
>
> No, it should not. Fix the drivers, fix the DTS and the bindings. Then
> the "should" disappears.
> >
> >>
> >> This also pollutes the actual bindings because you did not add
> >> properties required for clock controllers, because of describing here
> >> the syscon part.
>
>
>
> Best regards,
> Krzysztof
