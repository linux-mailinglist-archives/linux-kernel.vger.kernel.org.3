Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675C4DE2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbiCRUla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiCRUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:41:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D566122BDC;
        Fri, 18 Mar 2022 13:40:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v35so17800502ybi.10;
        Fri, 18 Mar 2022 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVp1w9NSmxaFeYurA8RKxT/i3A6lZfLYPbCAR6Ix1v0=;
        b=Fxm0IYClQ7mZTdGPutUhNB+CcRqg2eAXb4Xrt8BiZlgOp61krOQGkOtPDOhyF25tFB
         h9uVxt3DtI0l7RPfkUMBfociPLwcv8v82aWtqjxodZVc39L5KTz52+0jYJCWgNC2rynx
         QSPEsSDqgvsUezpR368TyL3KkqZApW0xUreL4P5GqkYFkIrxzM7gm9xu4+VEhBWFFCjA
         gOf9VtS3xcDn2dqESKrO3JQRayt/tp1eeYpb1NPw0kqlaS+Gm8jGxSJZo1+B7uxk3jQI
         mxsdY/jMfIcY6QtTMhAJVOL/H1uxJUMN09p65818HGfoz1oLLWfyaBMvmHN3h9GB44yG
         w1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVp1w9NSmxaFeYurA8RKxT/i3A6lZfLYPbCAR6Ix1v0=;
        b=ELc0cH4A86IB41b1nMwml2KQ854FeG3Fp2XOAXa1kX9ljpMd1KVGau0Go4P0cL7gaY
         P8aKw+MaX+g5aX6CA7o0f7e/5gwB3J/Y9yzjKV41VTJlJJx9mWLuXG4tX6o/KkcfH7DC
         If8uE80eZ+94aSJrpSO6scZZUr5qOoXnDAQ3sBWqlSNeHuMGvxAAmNxNF2+J9rG3ifQy
         uf490wFh2v88pieKd4m1Mj5cLjKGusBCr2NFPe0PTqbxRrMPiRLhc1GtmMQLYmIZWiDG
         Ynz7idck/Oopk40GdpRZ0+TXy+jyWJIyBzb4kI9i74o4cvDquOL2VAzp/kdNE5ZunYxl
         Vfug==
X-Gm-Message-State: AOAM530Gj84vC8pVIoQ816PjIdlpfeCGhMBOJvHbRKuasUkInHGct49F
        J8tpzUeMiauwtMH74fo4XiNpX+T/HruDEctzc5E=
X-Google-Smtp-Source: ABdhPJww4JQScKFu65C+KZ/IY6mSJq4LNtDfEpDasGeaPwhtLJa0KbZioNUXf5I2xtaeR4leOrldqHNuqGTROpqOS2U=
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id
 i203-20020a253bd4000000b0063367725ac1mr11490111yba.431.1647636007056; Fri, 18
 Mar 2022 13:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <YgGfjMttGecxcuv+@robh.at.kernel.org>
In-Reply-To: <YgGfjMttGecxcuv+@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 18 Mar 2022 20:39:40 +0000
Message-ID: <CA+V-a8v8y4MmZ8O_Nbii3wjmNv2sEcDMuXz4pgNkROrjQqMSLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] media: dt-bindings: media: Document RZ/G2L CRU
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the review.

On Mon, Feb 7, 2022 at 10:39 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 21, 2022 at 01:05:41AM +0000, Lad Prabhakar wrote:
> > Document the CRU block found on Renesas RZ/G2L SoC's.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Dropped CSI
> > ---
> >  .../bindings/media/renesas,rzg2l-cru.yaml     | 152 ++++++++++++++++++
> >  1 file changed, 152 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > new file mode 100644
> > index 000000000000..a03fc6ef0117
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > @@ -0,0 +1,152 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
> > +  capabilities for the Renesas RZ/G2L family of devices.
> > +
> > +  Depending on the instance the Image Processing input is connected to
> > +  external SoC pins or to a CSI-2 receiver.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
>
> Don't need oneOf when there is only 1 entry.
>
There are two more SoC's to be added as soon this patch series get
merged, so to keep the changes minimal later I will keep oneOf here.

> > +          - enum:
> > +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> > +          - const: renesas,rzg2l-cru
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: image_conv
> > +      - const: image_conv_err
> > +      - const: axi_mst_err
> > +
> > +  clocks:
> > +    items:
> > +      - description: CRU Main clock
> > +      - description: CPU Register access clock
> > +      - description: CRU image transfer clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: vclk
> > +      - const: pclk
> > +      - const: aclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    items:
> > +      - description: CRU_PRESETN reset terminal
> > +      - description: CRU_ARESETN reset terminal
> > +
> > +  reset-names:
> > +    items:
> > +      - const: presetn
> > +      - const: aresetn
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description:
> > +          Input port node, single endpoint describing a parallel input source.
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              hsync-active: true
> > +              vsync-active: true
> > +              bus-width: true
> > +              data-shift: true
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output port node, describing the RZ/G2L Image Processing module
> > +          connected the CSI-2 receiver
>
> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: Endpoint connected to CSI2.
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
>
> You can drop all the endpoint stuff. Just 'endpoint' should be valid as
> well for example. The graph schema covers all that.
>
Will do.

Cheers,
Prabhakar
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - reset-names
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # Device node example with CSI-2
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    cru: video@10830000 {
> > +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> > +            reg = <0x10830000 0x400>;
> > +            interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
> > +            clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> > +            clock-names = "vclk", "pclk", "aclk";
> > +            power-domains = <&cpg>;
> > +            resets = <&cpg R9A07G044_CRU_PRESETN>,
> > +                     <&cpg R9A07G044_CRU_ARESETN>;
> > +            reset-names = "presetn", "aresetn";
> > +
> > +            ports {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> > +                    port@1 {
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            reg = <1>;
> > +
> > +                            crucsi2: endpoint@0 {
> > +                                    reg = <0>;
> > +                                    remote-endpoint= <&csi2cru>;
> > +                            };
> > +                    };
> > +            };
> > +    };
> > --
> > 2.17.1
> >
> >
