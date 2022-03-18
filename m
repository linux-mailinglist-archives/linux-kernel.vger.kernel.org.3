Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89D4DDF80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiCRRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiCRRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:00:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0C19BE45;
        Fri, 18 Mar 2022 09:59:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id u103so16850168ybi.9;
        Fri, 18 Mar 2022 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgQVaJjLon+6FnpngVfV92KoMvQAYVxi37+bRkpaEGg=;
        b=Vf2UWnESNhfK5VDobP5e/UHCWnfkftXjm/aA52ZX079e9Bhsp/xiONHft8K6HnjoFE
         4AW3IKY19u989Y6UElubZNWU6j4GdLQ8ot/lrm6axdHU5lbR5TdHoRi7ZRAGoswbAmVu
         3hNmdttUrbYU7e+Q5BvPOvKsv9bTIbUqNGYok5V/Na5wbfeWtGMcc5Ud+I4h7dR6oZgw
         f5fShJi9gfUjAj6S/KkBmy+Wyep3HVo9UCNbP1dNwG/XYlDlmi4ZiblZ3Kjvl1OpWmOQ
         kaXLvxwK2QSKpS8YBQr1KD39jY2DuoMVYB8KoiPVLkVmz65UocmnHIW4M0EzKJonhoSK
         Ylag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgQVaJjLon+6FnpngVfV92KoMvQAYVxi37+bRkpaEGg=;
        b=gFTgI5XOGDO4hYEp37jIs8v7cyVZySDLsQRj//5k23k43RcemgZjwo4ngJB9YzAoZI
         EEJbp8QhJUiVQu/b2XVF7m5uu963/ygL0DggxlDH9ZaO2HTnqT43GHLj4RHDoWsIqfhz
         tot8BjspecCLlmNRzsQIG0WY5lo6pYNHM0NJRasntVRA6pTUWZeoCLFgdkgwgUXfzJ/B
         1jhCaXKHkmbhMdQ5WmHnEpp7deGM880b/YPhdJcrZG/iT9HEg7o3ttSqrhEUizCTXXhX
         UhRkTAhafL1q0ZPN/xCNYeJRAiHc+sxRADHNKUeFF66r2gjbkU0R8BNTaFaZVB1rs9IY
         qNhw==
X-Gm-Message-State: AOAM533eEDg5ZnkJWBdiYPuF1yAjxxMi5AYvhbqvcM8zQ1+y+yOwZTUf
        GetX0D+nR6g6tBZaoh8eMrDHpuyC8NGpM9n8N5I=
X-Google-Smtp-Source: ABdhPJxJ5CFFVJeRdlOJkyAG/dtdpH5y1dJw0SqCOeBd2Hrr/d03PQ0WSbKlYVibTqwfVaDAZpoY/ErC+qOBtw6Xhxg=
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id
 i203-20020a253bd4000000b0063367725ac1mr10569057yba.431.1647622743894; Fri, 18
 Mar 2022 09:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220215130116.fmqhoakn5fl4aout@uno.localdomain>
In-Reply-To: <20220215130116.fmqhoakn5fl4aout@uno.localdomain>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 18 Mar 2022 16:58:37 +0000
Message-ID: <CA+V-a8vidG=-AJGfg04_i5YQ65y5nbLFZ6R1u+u0+ytnTX81+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L
 CSI-2 block
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

On Tue, Feb 15, 2022 at 1:00 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Hi Prabhakar
>
> On Fri, Jan 21, 2022 at 01:05:40AM +0000, Lad Prabhakar wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi Geert/All,
> >
> > vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
> > pm_runtime. pclk clock is necessary for register access where as vclk clock
> > is only used for calculations. So would you suggest passing vclk as part of
> > clocks (as currently implemented) or pass the vclk clock rate as a dt property.
> >
> > Cheers,
> > Prabhakar
> >
> > v1->v2
> > * New patch
> > ---
> >  .../bindings/media/renesas,rzg2l-csi2.yaml    | 151 ++++++++++++++++++
> >  1 file changed, 151 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > new file mode 100644
> > index 000000000000..bf907768a157
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > @@ -0,0 +1,151 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L MIPI CSI-2 receiver
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  The RZ/G2L CSI-2 receiver device provides MIPI CSI-2 capabilities for the
> > +  Renesas RZ/G2L family of devices. MIPI CSI-2 is part of the CRU block which
> > +  is used in conjunction with the Image Processing module, which provides the
> > +  video capture capabilities.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-csi2     # RZ/G2{L,LC}
> > +          - const: renesas,rzg2l-csi2
>
> As per Rob's comment on the CRU bindings, you can remove oneOf:
>
I would like to keep it, as there will be RZ/V2L and RZ/G2UL entries
following as soon once as this gets merged in. So just want to avoid
the change hunk later.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: csi2_link
>
> Can this be just
>
>   interrupt-names:
>     const: csi2_link
> ?
>
Agreed.

> (I've run dt_binding_check and it does not complain)
>
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
> > +    items:
> > +      - const: cmn-rstb
>
> Here and above, is items: needed for a single entry ?
> (again, dt_binding_check does not complain if I remove it)
>
Agreed.

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
>
> Isn't the next processing block the CRU ? IOW, isn't this driver the
> CSI-2 receiver ?
>
On RZ/G2L CRU consists of CSI + image processing block (as seen in
[0]). As requested by Laurent in previous version I split up the
driver for CSI. So instead of mentioning CRU I have mentioned it as
"Image Processing block".

[0] https://renesas.info/wiki/File:CRU.png

Cheers,
Prabhakar

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
> > +            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
> > +            reg = <0x10830400 0xfc00>;
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
> > --
> > 2.17.1
> >
