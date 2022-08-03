Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670BB588D11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiHCNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiHCNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:38:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3771186C4;
        Wed,  3 Aug 2022 06:38:04 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-32194238c77so171759347b3.4;
        Wed, 03 Aug 2022 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEmnRhUglwgaMG2x8XfL+UPh5kqurYSbdexAPUQtz+g=;
        b=irhK4yngUwEW391KpWw9RU4kcByAludlJD+Xq561IHNOdtLNiRzmLarGUmdFj/cXxj
         p+l/n9g3lgGxuUhxdtlBWklJnFAcQZUwBh+2q3bNv4foibskugl2lDqcml9IF8rAlO+W
         aEcNRZNP1k8xIBQQ32MAt7Rr8ageEeGf8nnNpVqkSsRF1v5PrGlX0bzL2mXg6XhBzTsB
         PKHVAbg/FOeaDno5+Hr719lY7Ii4YdQlNPDfpq5zsIZ4WKfOwV0+vZxREMUvj/+oS0Q4
         2zzDYP68T2nCFvWls+6HETS0/LmW3k1L7o1DwvAFyf9RK5y/Gv1cA3bkcZ3CapsI8+uF
         dwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEmnRhUglwgaMG2x8XfL+UPh5kqurYSbdexAPUQtz+g=;
        b=y/PUp5cszsaThgRAGNvlPmODlieD407K90mbI5PGq88CectZ7k6QOChcUxNWwDaYk6
         aUxiksvVUJyWmz6mDztGra/un6h9CceLKLZ51EAc7LXbU4dKwWIecNZw0gNnqLjip/o0
         N/M+2qFVuRDfyfw8nTefXUuNPEY51GZZuDs/xGlQCKmQcvT+3Mie5Xt6puR1yrD6xDYW
         eZFNYPaOBvlcnypf73CP2qaEVlCLBCnqFLECEf2UEW/mWw2YZUA6Pt6nrxeVirocjx3o
         rLuYWGu4aZLkvjTqebYonl0rUVP3FVQMpbX8Oq3xPgq5BKSYM+VRXpfgmkXayc6mCmTC
         smGg==
X-Gm-Message-State: ACgBeo2y+KYWdQpHZj6SD2dM6hrZtKfWOpdthTZb8xn06PHms4cF2Fcq
        DRcpsFy3fw7g3wqbdQHpbNUPbl01xav4fek4JkY=
X-Google-Smtp-Source: AA6agR47J72Y4rSQyi/AtMa1SmS5iMh5fVLkME8ZjIfk5YKGyblzQNzEq/Vqn97R7+3KEImCOQbKTXePX5YHdgl8QHc=
X-Received: by 2002:a81:1d09:0:b0:31d:a40:8332 with SMTP id
 d9-20020a811d09000000b0031d0a408332mr24629133ywd.138.1659533884058; Wed, 03
 Aug 2022 06:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <4ff10b73-d04b-cda8-6603-f6f342f5ce9a@linaro.org>
In-Reply-To: <4ff10b73-d04b-cda8-6603-f6f342f5ce9a@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 3 Aug 2022 14:37:37 +0100
Message-ID: <CA+V-a8utnf6EBCia5zNcLHgpJikWcB3csT=82EV_ekSse6xyQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: dt-bindings: media: Document RZ/G2L CRU
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

On Tue, Aug 2, 2022 at 8:37 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/08/2022 23:47, Lad Prabhakar wrote:
> > Document the CRU block found on Renesas RZ/G2L SoC's.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v2 -> v1
> > * Dropped endpoint stuff from port1 as suggested by Rob
> > * Updated description for endpoint
> >
> > RFC v1 -> RFC v2
> > * Dropped CSI
> > ---
> >  .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > new file mode 100644
> > index 000000000000..d7389693dae9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  The CRU image processing module is a data conversion module equipped with pixel
> > +  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
> > +  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> No need for oneOf, unless you already have a patch adding second case to
> oneOf.
>
Agreed, I will drop that.

> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-cru     # RZ/V2L
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
> > +          Input port node, describing the Image Processing module connected to the
> > +          CSI-2 receiver.
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
>
> Also 4-space for DTS example, please.
>
Agreed.

Cheers,
Prabhakar
