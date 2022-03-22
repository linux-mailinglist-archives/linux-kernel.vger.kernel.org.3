Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC14E3575
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiCVASC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCVAR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:17:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FE8BF4D;
        Mon, 21 Mar 2022 17:15:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h126so31029073ybc.1;
        Mon, 21 Mar 2022 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOoeIR6C1c0HAXUC9LUDP+oPb673CZ3AP0dB7asqPvQ=;
        b=jkZU76Av1am5F29MVDhvmcFlzuQi3Zro+AhqI61FQAu6eSAx+1VMCJhyXfUNTVDzWh
         hmBaV/k4DSiIETe1bj8WabsTDiYd9na28Ayr4yjoW/7GurLJ++tBo9L9R5h1VACcbcTq
         eo2BqWalXP82yiFv7bRBaFFOckjKbSEdEUwTVeubqDEZR1TBRn/8IqAEdgonOq2nMvln
         h/LmHMrdQVHqwda9BKESZdKrMb+lwZMTJYL+TCxjYOCpbUdrCE/SqodSIwCTwgXmvIIf
         myIsst5Kjnj1xeEp2tL923shTcWZzQDIbmXqYsWXFImhKZESVpJA2TMobWsgwpq/Xe6R
         G/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOoeIR6C1c0HAXUC9LUDP+oPb673CZ3AP0dB7asqPvQ=;
        b=gYQaPk8PFMAmOyEHqjEGUq547HzbBjsUMA29PzxAzXsteuoUSzdm9AasSNRzkRXWsA
         agqXABT8ptPIZTOySV/8aNOYLoBUVnPHTWMkU6L2SRe9opQPb3dq5PXSJ0AuL89GKGHw
         uHHWQZDY32KsVaMEqaOSdWQMvalRcCNM8JK5P1V8I6A3LFlOLCE7Kilx979h9N/VKSfl
         kIll45OORcGALA5bpGmOMCxtemSAkeTGiv/+YahXLQOscCDOQ1ca+QwmawD6aY4dsHnr
         teJh0vgT+pLva5sL6ZmfDxZUjZAxeWgn0kUX/RpeMHwJGIxRv9gQUbitNACbCGD/UDaK
         9dlA==
X-Gm-Message-State: AOAM530/Sow181wx7j95TQrO5JB9uOLPAAP/hyAMKcs2JhsBBWYg5zbx
        Sfi6B6HxSJ6qQvad87rGobtKZi4od4HP8IuTcjY=
X-Google-Smtp-Source: ABdhPJwVTQqEP5pOyzLrRHAs4oWXGZh5pMim68+QZm9PnmV1ppoGg+RteR0T6tEaKgIkWBWE7crrqgGh4283QPz2hGI=
X-Received: by 2002:a25:d3cb:0:b0:629:182c:6c50 with SMTP id
 e194-20020a25d3cb000000b00629182c6c50mr25627885ybf.417.1647908028612; Mon, 21
 Mar 2022 17:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220215130651.hh3zb7ogl756pigt@uno.localdomain>
In-Reply-To: <20220215130651.hh3zb7ogl756pigt@uno.localdomain>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Mar 2022 00:13:22 +0000
Message-ID: <CA+V-a8sQeet5-3Jmq9q8xdP0nOnQNSU8OMbwnsD_SQKJzMfuCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] media: dt-bindings: media: Document RZ/G2L CRU
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Jacopo,

Thank you for the review.

On Tue, Feb 15, 2022 at 1:05 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Hi Prabhakar,
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
> Isn't this the port dedicated to the CSI-2 receiver input ?
>
Agreed.

> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: Endpoint connected to CSI2.
>
> And the andpoint should describe the connection between the CRU and
> the CSI-2 receiver ? (ie it should not contain CSI-2 specific
> properties, as those are specified by the CSI-2 receiver device node?)
>
Ok will drop the properties.

Cheers,
Prabhakar

> Thanks
>   j
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
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
