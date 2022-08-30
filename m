Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251FC5A6173
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiH3LON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH3LNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:13:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0DD9EA1;
        Tue, 30 Aug 2022 04:13:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-324ec5a9e97so263987617b3.7;
        Tue, 30 Aug 2022 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Bwh3DGnbZqNlQ7US14g5KeAbB+d9U52bRYCLzAnaFkU=;
        b=b9WJ9Yv196Ex+J2/AQAww1MFcJ4K2KhvoOZ4zFMU27W/aJhVjoOLLnu+avud4kueZ/
         mjB5RkDZH6qXi6yI4trjZBzwnCkgUpYfK+LSWUy1LrljzfTP2eJRLO5i5cjmENB75MTB
         o/UngNQsrk2muDJg85UPa+0/TZ/c5utNKbNmpYTv3m2XB4GtCPDuiq2KBIk7UdGrMOvW
         2bj/BHGbRtra2ypjHZqLoNXvDSb2XyO+UlHhLb3B8dj7st80n1HGqjnU9v+KJsYzS1M3
         2zdxxJnzD9b9tFwJbdOF4NNj1UTOL8tu1Pqw8+EVKlkJKwbXH/xjVguoxOHRVb7/4ubJ
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Bwh3DGnbZqNlQ7US14g5KeAbB+d9U52bRYCLzAnaFkU=;
        b=dU5MUTX3aA1t+rQI6ts+vk/wB+ZdM+gMr2VuA0NgZ/oZKmZhGxQ6tuMuRVF33HGgnr
         iiq81PudKytlpt8rWUQNpeczQDZuhKn/vIGhYJ2DKFo2YvcsX5T5vMK6vnX/Y9BFx9/j
         5aanElZgSEmGkZUcvB9BFHw2+oqujY1VxxXpcZEoy2kAJFE6npIWO/SiLoCn75Z7nPca
         V/+e8MRZTpJk0RWvsSj0lQBDYzVVswAjwdUYhseNjxYBem1KOhoghN676Sk4SxzfyFFZ
         0aJD0zAt15swLZO8BgY8yDmzyJzAOGiziQXY8ACHuf3k/Ov/hifWXZ67zS6IiIySRHPQ
         sQGA==
X-Gm-Message-State: ACgBeo0LPAWTsrFYzkcAJgAIBqZWZ5kwTvuwDrhSzq4gbL3MZOTPM/jv
        qbaroWteUErhPt++IwipUI5O7R25fixLfyyVgGo=
X-Google-Smtp-Source: AA6agR4xyFS5E2JcXlPCOGbgogie5UbAjwXtRKc4il93NCyCngR87xjnlPjHgKh7P+aiLjcGt3oX3PXSOcIbJ/8OFoc=
X-Received: by 2002:a25:8b8c:0:b0:67b:5c18:870 with SMTP id
 j12-20020a258b8c000000b0067b5c180870mr11198176ybl.244.1661858029391; Tue, 30
 Aug 2022 04:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yw1Oz5Zcwgig8/Xy@pendragon.ideasonboard.com>
In-Reply-To: <Yw1Oz5Zcwgig8/Xy@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Aug 2022 12:13:21 +0100
Message-ID: <CA+V-a8sh=JJk=c7B=xRWQSad3+_0pDb6aqiwfP-qPx-knzYd7A@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: dt-bindings: media: Document RZ/G2L CRU
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

Thank you for the review.

On Tue, Aug 30, 2022 at 12:42 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Mon, Aug 01, 2022 at 10:47:16PM +0100, Lad Prabhakar wrote:
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
> No oneOf here either.
>
Agreed, I will drop it.

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
>
> Both ports should be mandatory as they exist at the hardware level.
> Connections (through endpoints) are optional.
>
Agreed, I will make the ports as required.

Cheers,
Prabhakar
