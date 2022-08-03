Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69934588D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiHCNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiHCNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:36:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231671835B;
        Wed,  3 Aug 2022 06:36:39 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31f41584236so171611797b3.5;
        Wed, 03 Aug 2022 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbEkmhp4ylSkvGtJq77wNtGsbmQWNZVmdOV2TFt4T7E=;
        b=OJhNdbraYgEHabTSeFWTYvJphQ3Pz27f+t7+ioW3V/haNlNvOn4wmk8v8YedDYZz9N
         4USr7sCGi/lE7DF8TM4E3NMDBKErysp2FJioIhaY8m5cqtzxJN810g8h0LVS4Mu6yk31
         hKzZKaZ5R3mH+aPk29TfE/PCOoBbcHoNPDSWE9XGTisbu1yhgw55AGVrfZis/sYXUlPA
         /5qWyJAs/N1ZPzF9Jim4ibKFMlI8aumtoXyXwX3ho/hq287yhwElX/twYsiJ7vr0cARv
         5wV14XcwNRLIjt1URTfHH+m5BUmYLBjEw232yVLG+sltUGiCgaHbuYhOg/SFCfs+Mytz
         vJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbEkmhp4ylSkvGtJq77wNtGsbmQWNZVmdOV2TFt4T7E=;
        b=HCAH/jcrOnZ0CqqETXWGyOUvE7lTsxstjGCGEzxP+DUPDS0XNap5E1VqTEXjUZihCs
         K55MtKp4hw46xot5bYx6JCLtAVfADWBOJ971mz5EM08RHphgxXtMCiBBUb352/WO1LjF
         QA57lo8qo0pNqbHgOhfkzbf7XQgHE3kOO3joKoyKFYdo1XI95vl/bIyZAvKQv4nd5RGa
         1dCp5OGLfbwV0kTiKaKzZcBBWP6Y2BUBuAjaEOndIjYwn/B/r9ldVg590r4xd0Yk+0LH
         PdgCuMcfwqDVdVMLXupkim8rDgB9cGiiN1rJyKU4LJPcmM6Pc4YwvUJD6V/pCsEckx3X
         PEXg==
X-Gm-Message-State: ACgBeo0cNF8AB+Y6U/Wx9mRISvV1NkaJjbqOLlRD6f/y70UGdH/lWgZ0
        2VVeyWQP9ZerQEQaltLUDdwZSSOzNK7XYK6kLq0=
X-Google-Smtp-Source: AA6agR4g0h3lylwEXIBoN0wpm372EG37CIaJoLbhb1HtoTHCDTPZtuSfCJzq9B64sIcZcGPri+8ZY1qT/quddQnfw1g=
X-Received: by 2002:a0d:d60f:0:b0:325:1853:2b with SMTP id y15-20020a0dd60f000000b003251853002bmr11734428ywd.24.1659533798315;
 Wed, 03 Aug 2022 06:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <4b1d5266-40a9-9897-7caf-d3d41c0aa598@linaro.org>
In-Reply-To: <4b1d5266-40a9-9897-7caf-d3d41c0aa598@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 3 Aug 2022 14:36:11 +0100
Message-ID: <CA+V-a8vWDk94kxWRF0App7fEmpeB6-rb0Nu8ZG+QuT10aC11=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

On Tue, Aug 2, 2022 at 8:36 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/08/2022 23:47, Lad Prabhakar wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v2 -> v1
>
> Too many "media" in the subject prefixes.
>
I followed the pattern seen by "git log --oneline
Documentation/devicetree/bindings/media/", but I do agree I can drop
the extra "media" after "dt-bindings:"

> > * Fixed review comments pointed by Rob and Jacopo.
> >
> > RFC v1 -> RFC v2
> > * New patch
> > ---
> >  .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > new file mode 100644
> > index 000000000000..f82f88c096df
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > @@ -0,0 +1,149 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
> > +  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
> > +  with the Image Processing module, which provides the video capture capabilities.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-csi2       # RZ/V2L
> > +          - const: renesas,rzg2l-csi2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    const: csi2_link
> > +
> > +  clocks:
> > +    items:
> > +      - description: Internal clock for connecting CRU and MIPI
> > +      - description: CRU Main clock
> > +      - description: CPU Register access clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sysclk
> > +      - const: vclk
> > +      - const: pclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    items:
> > +      - description: CRU_CMN_RSTB reset terminal
> > +
> > +  reset-names:
> > +    const: cmn-rstb
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description:
> > +          Input port node, single endpoint describing the CSI-2 transmitter.
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 4
> > +                items:
> > +                  maximum: 4
> > +
> > +            required:
> > +              - clock-lanes
> > +              - data-lanes
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output port node, Image Processing block connected to the CSI-2 receiver.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +  - reset-names
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    csi20: csi2@10830400 {
>
> Node name just "csi"
>
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
OK will replace it with csi.

>
> > +            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
> > +            reg = <0x10830400 0xfc00>;
>
> Please use 4-space indentation for example DTS.
>
Sure will do.

Cheers,
Prabhakar

> > +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
> > +            clock-names = "sysclk", "vclk", "pclk";
> > +            power-domains = <&cpg>;
> > +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>;
> > +            reset-names = "cmn-rstb";
> > +
> > +            ports {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> > +                    port@0 {
> > +                            reg = <0>;
> > +
> > +                            csi2_in: endpoint {
> > +                                    clock-lanes = <0>;
> > +                                    data-lanes = <1 2>;
> > +                                    remote-endpoint = <&ov5645_ep>;
> > +                            };
> > +                    };
> > +
> > +                    port@1 {
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            reg = <1>;
> > +
> > +                            csi2cru: endpoint@0 {
> > +                                    reg = <0>;
> > +                                    remote-endpoint = <&crucsi2>;
> > +                            };
> > +                    };
> > +            };
> > +    };
>
>
> Best regards,
> Krzysztof
