Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83995A6162
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiH3LKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiH3LKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:10:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021F647CA;
        Tue, 30 Aug 2022 04:10:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3376851fe13so264197917b3.6;
        Tue, 30 Aug 2022 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nMi96jo7aVtzV6gHY/awbFwjLueQUwadnmUfMNrWPWs=;
        b=N5QYfCJq7Cxaeozg3Gf3tMUV5fMKzuBbCiW2Pf2xoodoPo1NssosU9qMOyG2x8pBav
         ZpkqItxXDSYOL4cYHma9WvI49RgQEiu22j5ua4GVT5W03hlEdMQvXJT6hCMUAHj1ImiO
         4EcHDkd6QRPqmXek//SgS73D+HqtLclg0CP3dwAGxHPk+2Vcb7Ma/627r/vCjP+UFnQ4
         m6NMiM9YOtijdVirXkQdx73yGlROl91Ub+cI0qZFXgFy0yeH8zRKG1b7W7AEWKiaUiUS
         TiZOiSKHIq2LzmjkcF9/IPepSxzTncovLQtM/T7qxZNkvI+In0a0GAJq0dI7+Ir/RjJD
         qHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nMi96jo7aVtzV6gHY/awbFwjLueQUwadnmUfMNrWPWs=;
        b=mRSm0Vm2KxYq/kN7rG/w4BXtgLTaD0cMNeXhTo0EHGBLo/RJ8It3N4L9wNLBWu2fdo
         fPcvcZ+HAKPNwwV2frgsObW+0SPKG12Qd5kdauAUEFNQPvifSsbueCn7bg3BQ1Yw/1nB
         4XSAr1qWObjLFTgj7ggm4RIXp5IBEKLqCMLJT59/ZqH+jRffY85c07nXdzrjDgTLcLW+
         MENtRhLR2PgvO77fpgS6/QZ8ZSyidULJ5F83hzJB0aEgCGakykS5hxmoy8Pc5p6CdTah
         qlj2nRNNv7XAvNBmT2WAo+MQ172KJZagGi5o46iNDvp3ulqxiYBSe5vfhJP/IdugeA0l
         hp3A==
X-Gm-Message-State: ACgBeo2KinOS/HFf1EpJabg0qtBhi3fK7BFaomyPLFrWkdhXHJE5QIuj
        E9+lOjvoqX68sFEz8Fpa1Y4cXW4luqNaTYtsauc=
X-Google-Smtp-Source: AA6agR4CZCaWmPXoKzg6Ztgh4d98cRi1kgG4tJBVKN5dzRNiAybN999CPngmWWX6PkzbEE0vRkssrns3FT6fIUSBn8k=
X-Received: by 2002:a81:6a84:0:b0:341:9e24:58aa with SMTP id
 f126-20020a816a84000000b003419e2458aamr167202ywc.138.1661857835053; Tue, 30
 Aug 2022 04:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yw1MmyFxnWNpQx8q@pendragon.ideasonboard.com>
In-Reply-To: <Yw1MmyFxnWNpQx8q@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Aug 2022 12:10:07 +0100
Message-ID: <CA+V-a8uw-X+OC=Pa+gZtQvNF9OKU4Jd9Ne3YDJRNd4aMwsLZeQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch.

On Tue, Aug 30, 2022 at 12:32 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Mon, Aug 01, 2022 at 10:47:15PM +0100, Lad Prabhakar wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v2 -> v1
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
>
> You can drop the oneOf and write
>
Agreed.

>     items:
>       - enum:
>           - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
>           - renesas,r9a07g054-csi2       # RZ/V2L
>       - const: renesas,rzg2l-csi2
>
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
>
> If there's a single interrupt you can drop the name.
>
OK, I will drop it.

Cheers,
Prabhakar

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
>
> Same here.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
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
>
> --
> Regards,
>
> Laurent Pinchart
