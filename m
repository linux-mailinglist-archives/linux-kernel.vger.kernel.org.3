Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7447420E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhLNMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLNMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:07:41 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83446C061574;
        Tue, 14 Dec 2021 04:07:41 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 131so45594304ybc.7;
        Tue, 14 Dec 2021 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU5wk5S012xqTD1gQyYvUFaZJkUyYz4X+YCYVNoID1o=;
        b=jo1/5ZSYOVvhd6VUpVNQxwMaPxq7K5uauDLeQX7BbED78ES76n+kO2dxI5xm1GJKkZ
         n24msv9sW3CQ3nPyaAD8eZV7RFErhyo22eGoOF2blArEugU4g6mvuY/Yj22NuE1lqMY6
         CdobDSMJmaLTTl7KLkBZwOI7XYZ6Tnfs8fECK+3IMWBNwP3gZjARj+AC8FqGY+JKozCT
         0PaSdkUpAru6yXpRp88sDf0Uhsad4YqRHv6lx4hmOyJZBMsIyTmAnVUBRFmfMcTyLYpe
         NwZ4gQR6E4c9t+X6nGM6EAuXK1LRAZi+PymFuXV5DQIU3XOkgRxUkPWbMmgFMwhiw/CY
         YbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU5wk5S012xqTD1gQyYvUFaZJkUyYz4X+YCYVNoID1o=;
        b=gtMuQXVDjwjoQbL0qiqoxPEIo3EVU7B3g2ymldoZ/PWp72wKhjmHMc9UzekdGTou0Y
         5Cc6B09O4zvm7NNbccfQOJ6yq0fPy1zhxbCCAnZeNYCGHAYsyP45wWkqkvgc/Hx4iSh0
         krRgueEQbeB6tAGTz4EglGGZ0hS88F4zuk1YasPDtSuohIwKBZDnrU6MOiHmrl4wx19M
         otkDZcd+cq4NUFPNVC9pF/XiColcCNC2n2oIrZTXEpiLfDLEJ2ZRaSxhetlK11BwTwML
         3G804bwi84BS+lrr0NnaD3LqPEEB6qOb9aYZyXWbPwo4pS3wzI7bOwtzS+navx5xZlm6
         WfMQ==
X-Gm-Message-State: AOAM531E2OseStxgk5TzVHFY6Cgvnzkxxp+RLuEL76G5waaMgDT04R+s
        3GmuKz2/hQB7U8EhAxbv+DByADaMkKbDPt1bbjE=
X-Google-Smtp-Source: ABdhPJxnzRQp4Y/l60JMMtyn81CqMHnROFR7anoBuR9EOy7qK4JAjzH6sLDdkRcX764FEd7eg4Cb0sSKV9nS5RTdQbY=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr5264483ybe.422.1639483660726;
 Tue, 14 Dec 2021 04:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <YbfQIPS270So+jUh@robh.at.kernel.org>
In-Reply-To: <YbfQIPS270So+jUh@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 14 Dec 2021 12:07:14 +0000
Message-ID: <CA+V-a8tHL-DwNz3USQwh5NieTRvPhUAjZV-GqFsK67fgU+kF_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Document RZ/G2L CRU block
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the review.

On Mon, Dec 13, 2021 at 10:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 01:23:49AM +0000, Lad Prabhakar wrote:
> > Document the CRU block found on Renesas RZ/G2L SoC's.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > new file mode 100644
> > index 000000000000..7b2835810516
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > @@ -0,0 +1,227 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2021 Renesas Electronics Corp.
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
> Don't need oneOf with only 1 entry.
>
I added this as there will be couple of more SoC's using this driver.

> > +          - enum:
> > +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> > +          - const: renesas,rzg2l-cru
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 4
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: csi2_link_int
> > +      - const: image_conv_int
> > +      - const: image_conv_err_int
> > +      - const: axi_mst_err_int
>
> _int is redundant.
>
Agreed will drop "_int".

> > +
> > +  clocks:
> > +    items:
> > +      - description: Internal clock for connecting CRU and MIPI
> > +      - description: CRU Main clock
> > +      - description: CPU Register access clock
> > +      - description: CRU image transfer clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sysclk
> > +      - const: vclk
> > +      - const: pclk
> > +      - const: aclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    items:
> > +      - description: CRU_CMN_RSTB reset terminal
> > +      - description: CRU_PRESETN reset terminal
> > +      - description: CRU_ARESETN reset terminal
> > +
> > +  reset-names:
> > +    items:
> > +      - const: cmn-rstb
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
> > +
> > +              vsync-active: true
> > +
> > +              bus-width: true
> > +
> > +              data-shift: true
> > +
> > +      port@1:
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
> > +              clock-lanes:
> > +                maxItems: 1
> > +
> > +              data-lanes:
> > +                maxItems: 1
> > +
> > +            required:
> > +              - clock-lanes
> > +              - data-lanes
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output port node, describing the RZ/G2L Image Processing module
> > +          connected the CSI-2 receiver
> > +
> > +        properties:
> > +          endpoint@0:
>
> Unless you have mutiple endpoints to define or endpoint properties to
> add, you don't need to specify anything more than the port.
>
Agreed will drop it.

Cheers,
Prabhakar

> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: Endpoint connected to CSI2.
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Input port node, describing the RZ/G2L CSI-2 module connected the
> > +          Image Processing block.
> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: Endpoint connected to CSI2.
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
> > +            reg = <0x10830000 0x10000>;
> > +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "csi2_link_int", "image_conv_int",
> > +                              "image_conv_err_int", "axi_mst_err_int";
> > +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> > +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> > +            clock-names = "sysclk", "vclk", "pclk", "aclk";
> > +            power-domains = <&cpg>;
> > +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
> > +                     <&cpg R9A07G044_CRU_PRESETN>,
> > +                     <&cpg R9A07G044_CRU_ARESETN>;
> > +            reset-names = "cmn-rstb", "presetn", "aresetn";
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
> > +                            csi2_in: endpoint@0 {
> > +                                    reg = <0>;
> > +                                    clock-lanes = <0>;
> > +                                    data-lanes = <1 2>;
> > +                                    remote-endpoint = <&ov5645_ep>;
> > +                            };
> > +                    };
> > +
> > +                    port@2 {
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            reg = <2>;
> > +
> > +                            csi2cru: endpoint@0 {
> > +                                    reg = <0>;
> > +                                    remote-endpoint= <&crucsi2>;
> > +                            };
> > +                    };
> > +
> > +                    port@3 {
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            reg = <3>;
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
