Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7C506F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352912AbiDSNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353332AbiDSNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:53:14 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85F38D8B;
        Tue, 19 Apr 2022 06:48:31 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e4so18159364oif.2;
        Tue, 19 Apr 2022 06:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsUApVIo+2QUrjaVycUT3ee7pF9FJXtnBR7YLOJOzQ0=;
        b=LwApJLYYpQhNMlEK6yg/73gcHTRBV9fiwpRdFGwUKf/4TAahyHsxekrWZ3Xe9wHnSC
         Q8mpz3qxy+My1S3v+UANJg7nLZe7KJccHI9UBkfUfPYou/KB+L38VW7tx5jwbp3IILUT
         g9+0LwbLafG31wUunXa8fJVUtHIDyr3I7PiJS+Acr+CkmmiDdLgoHj9JPgiJtWKE5HEH
         i4ND+xRqDhPcHGhMBmxOrGajYyM18u/nmAyr+tgplfn/dAmfbwIMg86GUNKFM+wgcqVk
         HjZ6JprfRS9SGwRRePZhveN/hIk0wj8GOv5AphEsufDg9W9G8xt87hNpLbo/ptR14hwV
         ZPsA==
X-Gm-Message-State: AOAM530qFwi1IglHc8myny0rVtHH2ahWV+0F9Fmi0taHrDUKKc4+W+aV
        CdP46kKyPlTCFmE7ugMIpfE2NAEqOw==
X-Google-Smtp-Source: ABdhPJwAGdbwdONC730t1SrxFQ9322c21cU+FAlo9bI1B0TpQpxVtg6Tt3SHk1LjWJNA3b+E3DTVOQ==
X-Received: by 2002:a05:6808:9ae:b0:2d9:a01a:4bf4 with SMTP id e14-20020a05680809ae00b002d9a01a4bf4mr7418713oig.283.1650376110729;
        Tue, 19 Apr 2022 06:48:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a056820028100b00335f00b5b9bsm5315376ood.15.2022.04.19.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:48:30 -0700 (PDT)
Received: (nullmailer pid 2438759 invoked by uid 1000);
        Tue, 19 Apr 2022 13:48:29 -0000
Date:   Tue, 19 Apr 2022 08:48:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Samuel Holland <samuel@sholland.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <Yl69rY2/Fwfhc520@robh.at.kernel.org>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
 <19aa74b7-0096-87c5-ef2c-9a135ad5505a@sholland.org>
 <Yl6Ezm6D7KKbE1Oa@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl6Ezm6D7KKbE1Oa@aptenodytes>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:45:50AM +0200, Paul Kocialkowski wrote:
> Hi Samuel,
> 
> On Fri 15 Apr 22, 20:59, Samuel Holland wrote:
> > On 4/15/22 10:37 AM, Paul Kocialkowski wrote:
> > > This introduces YAML bindings documentation for the Allwinner A31 Image
> > > Signal Processor (ISP).
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
> > >  1 file changed, 117 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > new file mode 100644
> > > index 000000000000..ffca216b841f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > @@ -0,0 +1,117 @@
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
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        description: CSI0 input port
> > > +
> > > +        properties:
> > > +          reg:
> > > +            const: 0
> > > +
> > > +          endpoint:
> > > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +            unevaluatedProperties: false
> > > +
> > > +        additionalProperties: false
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        description: CSI1 input port
> > > +
> > > +        properties:
> > > +          reg:
> > > +            const: 0
> > 
> > Should be "const: 1".
> > 
> > Otherwise,
> > Reviewed-by: Samuel Holland <samuel@sholland.org>
> 
> Good catch and thanks for the review!

Yes, but you should use '/schemas/graph.yaml#/properties/port' ref 
instead and drop 'properties'.

Rob
