Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A85A9EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIASNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIASNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:13:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E2474D8;
        Thu,  1 Sep 2022 11:13:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 476A56CD;
        Thu,  1 Sep 2022 20:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662055990;
        bh=w3cnA7QpTZH9H6rGUREb2H83enbsbvl5uMVJxERt/tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhnRqGz9TFyiYKIK2CaTWyN0MB8FLWTcnXcmfyvXrsZD0YnkrGc5EGUKCUnENitbn
         0Q1Z/815H54UeYyOvzJu2p6uq8X72wHo+nqgpahotmtHu7OcAqVBhXVR6Ceorq7nRH
         az8Kw0vX0PQjO85K3rRbbE5B4O0v8rDUbfHMKO1s=
Date:   Thu, 1 Sep 2022 21:12:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YxD2Kvrs+RjnPOnn@pendragon.ideasonboard.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-2-paul.kocialkowski@bootlin.com>
 <Ywk3W6pTOOlzLYVn@pendragon.ideasonboard.com>
 <YxDJtYgW/NYLw77u@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxDJtYgW/NYLw77u@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Sep 01, 2022 at 05:03:17PM +0200, Paul Kocialkowski wrote:
> On Sat 27 Aug 22, 00:12, Laurent Pinchart wrote:
> > On Fri, Aug 26, 2022 at 08:41:39PM +0200, Paul Kocialkowski wrote:
> > > This introduces YAML bindings documentation for the Allwinner A31 Image
> > > Signal Processor (ISP).
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../media/allwinner,sun6i-a31-isp.yaml        | 97 +++++++++++++++++++
> > >  1 file changed, 97 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > new file mode 100644
> > > index 000000000000..2fda6e05e16c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - allwinner,sun6i-a31-isp
> > > +      - allwinner,sun8i-v3s-isp
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus Clock
> > > +      - description: Module Clock
> > > +      - description: DRAM Clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: bus
> > > +      - const: mod
> > > +      - const: ram
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: CSI0 input port
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: CSI1 input port
> > > +
> > > +    anyOf:
> > > +      - required:
> > > +          - port@0
> > > +      - required:
> > > +          - port@1
> > 
> > I'd still like to see all ports that exist in the hardware being
> > mandatory. I assume at least one of the A31 and V3s has two connected
> > ports in the SoC or you wouldn't declare them both here :-)
> 
> Some SoCs (e.g. A83T) only have one CSI controller so we can't require both.
> This could be a decision based on the compatible but my personal opinion is
> that it's not really worth making this binding so complex.
> 
> We can always informally enforce that all possible links should be present
> when merging changes to the soc dts.
> 
> What do you think?

It makes the binding more complex, but it allows catching issues in an
automated way instead of relying on reviews. Lowering the review burden
is something I usually welcome :-) It's probably less of an issue here
as this is all about the SoC integration, not about board files, so I
won't insist too strongly even if I prefer bindings that are more
descriptive.

> > Apart from that, this looks good.
> > 
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > > +
> > > +    isp: isp@1cb8000 {
> > > +        compatible = "allwinner,sun8i-v3s-isp";
> > > +        reg = <0x01cb8000 0x1000>;
> > > +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > +        clocks = <&ccu CLK_BUS_CSI>,
> > > +             <&ccu CLK_CSI1_SCLK>,
> > > +             <&ccu CLK_DRAM_CSI>;
> > > +        clock-names = "bus", "mod", "ram";
> > > +        resets = <&ccu RST_BUS_CSI>;
> > > +
> > > +        ports {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            port@0 {
> > > +                reg = <0>;
> > > +
> > > +                isp_in_csi0: endpoint {
> > > +                    remote-endpoint = <&csi0_out_isp>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +...

-- 
Regards,

Laurent Pinchart
