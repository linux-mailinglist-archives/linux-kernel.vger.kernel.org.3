Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62947CEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbhLVJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbhLVJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:17:26 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2442C061574;
        Wed, 22 Dec 2021 01:17:25 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y68so4802940ybe.1;
        Wed, 22 Dec 2021 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7u4eqnJsEEr9EvH93DeWfQDx3AvMJFDo66OtlSTfoA=;
        b=KB2ICITcRqgTlzBuJ1Q9vHFskm454LnHCvnRzQYDe1i923obK7XmMQI5kZAnO822VS
         /6hc9cX5fWBT3qFNq6hNgwm4MbdzsmPNWBPA0vvSMg4IqRLHmQ8HlJ+B5jAVF7plMqXQ
         LYFd1rl/5vi3k2gHnu3OoOiH4n2K90U+ResC6+VIHH78oiZluw84lixq+BsppkYiMyZn
         +yF/Z+F73Uz4v8Cy47MBcT/4OyN+dlzrua5jOzxOl3iCp5Xy2HTk3egjpq/6BtINcwSC
         ygtseyDErMp8FpsDCzAuTlmj3EBcotRPmqw+F77fFWQ8cMaYZ9fSYkmayU4LhY01rgZ9
         AZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7u4eqnJsEEr9EvH93DeWfQDx3AvMJFDo66OtlSTfoA=;
        b=Djv6buKFQzcLE1hpdi4EEOtbxiLTsLumOaTCgrO8k44flb7HK+sofe4OlbuaGKaUYU
         yyfELn/akeEd6XHqez4IeSLvA9igspkIOnbBaT8EwHvhmYGOcogXnItHU4AVd3Gx1V3Z
         ksJc+B69qs6S+8LgobS+B69uzAVIlNiwSb4e50ay0bRUfArMcXMtAYQsU1dA28bVn8w5
         tQfu0TjO4FqYGZjEGdjYUFeUByR9WRdSdsE9HqQCQd9Ykef6VFNkXZrpGaD3tmtNJW9W
         6ymKbKAnG+EOj54kirWi2VzQLfblNLvUD+hNGlnX15PKM9zNv8/ziSFUzDygjiVok3YZ
         2c6g==
X-Gm-Message-State: AOAM533jx1Y+IlkhY+abMcVmkWt/X6Sqo7F2IkB49XeTaFYrnXnpm4hA
        JRPXp6LMd7YID3LU8eKS/kcWMf7Vu5QHX+sr8cG/Ij6Uaix9PA==
X-Google-Smtp-Source: ABdhPJxbR1UVqoWLclbsrkCaVSzA6zi1SiEBcXYK3pNkMTlAxG0GzZZqQrIsQ4KwqHr3A8Ev+XV14x6TuTT1cw7qB7g=
X-Received: by 2002:a25:4213:: with SMTP id p19mr2968537yba.41.1640164645164;
 Wed, 22 Dec 2021 01:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YbfQIPS270So+jUh@robh.at.kernel.org> <CA+V-a8tHL-DwNz3USQwh5NieTRvPhUAjZV-GqFsK67fgU+kF_w@mail.gmail.com>
 <YcGUmvq32fUXOMTo@pendragon.ideasonboard.com>
In-Reply-To: <YcGUmvq32fUXOMTo@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 22 Dec 2021 09:16:59 +0000
Message-ID: <CA+V-a8v9UnBBpoB7RneCQE+pf1ytWw6pyXHoH-n_J+2ry6yiQw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Document RZ/G2L CRU block
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
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

Hi Laurent,

Thank you for the review.

On Tue, Dec 21, 2021 at 8:47 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Tue, Dec 14, 2021 at 12:07:14PM +0000, Lad, Prabhakar wrote:
> > On Mon, Dec 13, 2021 at 10:58 PM Rob Herring wrote:
> > > On Tue, Dec 07, 2021 at 01:23:49AM +0000, Lad Prabhakar wrote:
> > > > Document the CRU block found on Renesas RZ/G2L SoC's.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++++++++++++++
> > > >  1 file changed, 227 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > > > new file mode 100644
> > > > index 000000000000..7b2835810516
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > > > @@ -0,0 +1,227 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +# Copyright (C) 2021 Renesas Electronics Corp.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
> > > > +
> > > > +maintainers:
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +
> > > > +description:
> > > > +  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
> > > > +  capabilities for the Renesas RZ/G2L family of devices.
> > > > +
> > > > +  Depending on the instance the Image Processing input is connected to
> > > > +  external SoC pins or to a CSI-2 receiver.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > >
> > > Don't need oneOf with only 1 entry.
> >
> > I added this as there will be couple of more SoC's using this driver.
>
> Will that be SoCs not compatible tieh the rzg2l-cru compatible string ?
>
Soc will be compatible with  rzg2l-cru but we will be adding SoC
specific string and then fallback to "renesas,rzg2l-cru" likewise done
for "renesas,r9a07g044-cru"

> If so oneOf may be needed, but you can also add it later.
>
Ive already added oneOf.

> > > > +          - enum:
> > > > +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> > > > +          - const: renesas,rzg2l-cru
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 4
> > > > +
> > > > +  interrupt-names:
> > > > +    items:
> > > > +      - const: csi2_link_int
>
> I'm not thrilled by this. It looks like the CSI-2 receiver and the image
> processing block are separate IP cores. Can we model them as separate DT
> nodes ? I expect the CSI-2 receiver to possibly be reused in other SoCs
> with a different integration.
>
The main reason for doing so is the registers for CSI are in same
block as CRU and the clock for register access is single. I'll have to
make the clock as shared and then can split this into a separate node.

> > > > +      - const: image_conv_int
> > > > +      - const: image_conv_err_int
> > > > +      - const: axi_mst_err_int
> > >
> > > _int is redundant.
> >
> > Agreed will drop "_int".
> >
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Internal clock for connecting CRU and MIPI
> > > > +      - description: CRU Main clock
> > > > +      - description: CPU Register access clock
> > > > +      - description: CRU image transfer clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: sysclk
> > > > +      - const: vclk
> > > > +      - const: pclk
> > > > +      - const: aclk
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    items:
> > > > +      - description: CRU_CMN_RSTB reset terminal
> > > > +      - description: CRU_PRESETN reset terminal
> > > > +      - description: CRU_ARESETN reset terminal
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: cmn-rstb
> > > > +      - const: presetn
> > > > +      - const: aresetn
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        unevaluatedProperties: false
> > > > +        description:
> > > > +          Input port node, single endpoint describing a parallel input source.
> > > > +
> > > > +        properties:
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > > > +
> > > > +            properties:
> > > > +              hsync-active: true
> > > > +
> > > > +              vsync-active: true
> > > > +
> > > > +              bus-width: true
> > > > +
> > > > +              data-shift: true
>
> No need for a blank line between all properties.
>
OK.

> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        unevaluatedProperties: false
> > > > +        description:
> > > > +          Input port node, single endpoint describing the CSI-2 transmitter.
> > > > +
> > > > +        properties:
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > > > +
> > > > +            properties:
> > > > +              clock-lanes:
> > > > +                maxItems: 1
>
> If lane reordering isn't supported, you could omit this.
>
OK will drop it.

> > > > +
> > > > +              data-lanes:
> > > > +                maxItems: 1
>
> Doesn't the CSI-2 receiver support more than one lane ?
>
my bad it should be enum with [1, 2, 4].

Cheers,
Prabhakar
> > > > +
> > > > +            required:
> > > > +              - clock-lanes
> > > > +              - data-lanes
> > > > +
> > > > +      port@2:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Output port node, describing the RZ/G2L Image Processing module
> > > > +          connected the CSI-2 receiver
> > > > +
> > > > +        properties:
> > > > +          endpoint@0:
> > >
> > > Unless you have mutiple endpoints to define or endpoint properties to
> > > add, you don't need to specify anything more than the port.
> >
> > Agreed will drop it.
> >
> > > > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > > > +            description: Endpoint connected to CSI2.
> > > > +
> > > > +        anyOf:
> > > > +          - required:
> > > > +              - endpoint@0
> > > > +
> > > > +      port@3:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Input port node, describing the RZ/G2L CSI-2 module connected the
> > > > +          Image Processing block.
> > > > +
> > > > +        properties:
> > > > +          endpoint@0:
> > > > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > > > +            description: Endpoint connected to CSI2.
> > > > +
> > > > +        anyOf:
> > > > +          - required:
> > > > +              - endpoint@0
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-names
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - resets
> > > > +  - reset-names
> > > > +  - power-domains
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  # Device node example with CSI-2
> > > > +  - |
> > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    cru: video@10830000 {
> > > > +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> > > > +            reg = <0x10830000 0x10000>;
> > > > +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                         <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > > > +            interrupt-names = "csi2_link_int", "image_conv_int",
> > > > +                              "image_conv_err_int", "axi_mst_err_int";
> > > > +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> > > > +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> > > > +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> > > > +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> > > > +            clock-names = "sysclk", "vclk", "pclk", "aclk";
> > > > +            power-domains = <&cpg>;
> > > > +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
> > > > +                     <&cpg R9A07G044_CRU_PRESETN>,
> > > > +                     <&cpg R9A07G044_CRU_ARESETN>;
> > > > +            reset-names = "cmn-rstb", "presetn", "aresetn";
> > > > +
> > > > +            ports {
> > > > +                    #address-cells = <1>;
> > > > +                    #size-cells = <0>;
> > > > +
> > > > +                    port@1 {
> > > > +                            #address-cells = <1>;
> > > > +                            #size-cells = <0>;
> > > > +
> > > > +                            reg = <1>;
> > > > +
> > > > +                            csi2_in: endpoint@0 {
> > > > +                                    reg = <0>;
> > > > +                                    clock-lanes = <0>;
> > > > +                                    data-lanes = <1 2>;
> > > > +                                    remote-endpoint = <&ov5645_ep>;
> > > > +                            };
> > > > +                    };
> > > > +
> > > > +                    port@2 {
> > > > +                            #address-cells = <1>;
> > > > +                            #size-cells = <0>;
> > > > +
> > > > +                            reg = <2>;
> > > > +
> > > > +                            csi2cru: endpoint@0 {
> > > > +                                    reg = <0>;
> > > > +                                    remote-endpoint= <&crucsi2>;
> > > > +                            };
> > > > +                    };
> > > > +
> > > > +                    port@3 {
> > > > +                            #address-cells = <1>;
> > > > +                            #size-cells = <0>;
> > > > +
> > > > +                            reg = <3>;
> > > > +
> > > > +                            crucsi2: endpoint@0 {
> > > > +                                    reg = <0>;
> > > > +                                    remote-endpoint= <&csi2cru>;
> > > > +                            };
> > > > +                    };
> > > > +            };
> > > > +    };
>
> --
> Regards,
>
> Laurent Pinchart
