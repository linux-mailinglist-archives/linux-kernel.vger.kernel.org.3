Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790754B28DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiBKPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:13:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiBKPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:13:37 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42B1A3;
        Fri, 11 Feb 2022 07:13:35 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id r27so9858849oiw.4;
        Fri, 11 Feb 2022 07:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nAFVbtRVtzhYKIqkkFFxa3DynoLvmGUt99SFwmIUitE=;
        b=s8NsgSiwpaGes4F/DU2604UOgpZCEH8KBAa569Nf9/VkCqPnY3EzktMkGF/hWN8AZn
         SclY0VCIQnKUGiGxMSWzxEfg9UVDokOtIqfKjhbbHnUfjtSxE6Vm/95/kOKZQsrGre1A
         pUUk/v+D2tBIbHwmFCom0QW10BImL3jT7NPqe7hk1ZoXbVmap9e19mhUObCYMhhF+ZX1
         5vz2xyBf9SbNO5cxC52dO7Xwq2QzG9MjE1m2eqa0YtV9hlIj4WS7XgceVAUu/Zs3e9Mf
         oSvAArg6jo1dI1US1jR5NrfYUW5Ja7pIkMr3DBJP/McXNhnDD/T5q9DQMmlQ/CStxqRJ
         4dkw==
X-Gm-Message-State: AOAM5308P0SzF+17eAaZAYhVbz0znhJFt+9wo4FHSlN7K7LqgrtI4euw
        HawhXIor0IWQoEBgUKqUIw==
X-Google-Smtp-Source: ABdhPJwaPHuiQHGSQ6kUYYw0O9nkOWW7a1boAaJFBE38Tc1cgFspZLWYz6Pn0l3DnSsVViQOAEGGUg==
X-Received: by 2002:aca:aa96:: with SMTP id t144mr415668oie.132.1644592415173;
        Fri, 11 Feb 2022 07:13:35 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id j3sm9649552oig.37.2022.02.11.07.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:13:34 -0800 (PST)
Received: (nullmailer pid 378308 invoked by uid 1000);
        Fri, 11 Feb 2022 15:13:31 -0000
Date:   Fri, 11 Feb 2022 09:13:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 61/66] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YgZ9GjgasiPljg9X@robh.at.kernel.org>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
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

On Mon, Feb 07, 2022 at 05:51:21PM +0200, Laurent Pinchart wrote:
> Hi Paul,
> 
> Thank you for the patch.
> 
> On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > This introduces YAML bindings documentation for the Allwinner A31 Image
> > Signal Processor (ISP).
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > new file mode 100644
> > index 000000000000..2d87022c43ce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> > +
> > +maintainers:
> > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun6i-a31-isp
> > +      - allwinner,sun8i-v3s-isp
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +      - description: DRAM Clock
> 
> That's interesting, does the ISP have a dedicated DRAM ?
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: mod
> > +      - const: ram
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: CSI0 input port
> > +
> > +        properties:
> > +          reg:
> > +            const: 0
> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> 
> If no other property than remote-endpoint are allowed, I'd write
> 
>           endpoint:
>             $ref: video-interfaces.yaml#
> 	    remote-endpoint: true

You just mixed a node and a property...

'remote-endpoint' is always allowed, so need to put it here and every 
other user. So 'unevaluatedProperties' is correct. But it would be good 
to define what properties from video-interfaces.yaml are used here.

Rob
