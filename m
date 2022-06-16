Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519954EA31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378416AbiFPTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378000AbiFPTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:34:29 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE720BE7;
        Thu, 16 Jun 2022 12:34:28 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id y12so2485887ior.7;
        Thu, 16 Jun 2022 12:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S25L3CWj8vlpCKxhB9Xc3nOC1i/DIzMtuE6udLAVvAw=;
        b=UhEqWLtq3KDyovkfe6Rf1SzZu3tBvz4GDP36+Ue0XKPN7bq9ViYZS8dwDhwPTYyYJt
         6LVVPcK1NZ++bFlvT7lluIUOwdTeFHyZSR/pDhWl59q93h0BZIqgMdB2r8vFgQKDkOX/
         71aEWQ74Xq/fTPT2LXHHvXjswk68PGlePXesLBXXiykdMVneJKG4r/eJjPjB6T5qAKbt
         2tfWZgvuG54gnSTrfOsCRyuQsOMoxTvPPbYjF+4om2kFswGkuoBXeGFD4Ts96Nka7Uos
         cEaY5AXkFlbVDYlAwoWS61tnlWw+9aDUll2rDYVkSYoJLoa+cuuKlSzzWNklkN6C4pWi
         Y+1g==
X-Gm-Message-State: AJIora80ZRZt6mJ25sBx4yS/WN2v+m+G1Mk7vtXA6IcD/j+HWhtwB1Bx
        /dqpmj8IhhLoXoo4dYxGPEI5spWvGg==
X-Google-Smtp-Source: AGRyM1va6r6iyrhQi4eq1CrI+Yui4VKcqrJgOWcZsH0/31J0I9HiVCiaDneHZ+Hl/LPro4MUZoKSyA==
X-Received: by 2002:a05:6638:4705:b0:331:7c49:7048 with SMTP id cs5-20020a056638470500b003317c497048mr3614855jab.182.1655408067485;
        Thu, 16 Jun 2022 12:34:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z5-20020a05660229c500b0065a47e16f4esm1584402ioq.32.2022.06.16.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:34:26 -0700 (PDT)
Received: (nullmailer pid 3867979 invoked by uid 1000);
        Thu, 16 Jun 2022 19:34:24 -0000
Date:   Thu, 16 Jun 2022 13:34:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: drm/bridge: anx7625: Add mode-switch
 support
Message-ID: <20220616193424.GA3844759-robh@kernel.org>
References: <20220615172129.1314056-1-pmalani@chromium.org>
 <20220615172129.1314056-5-pmalani@chromium.org>
 <CAE-0n53ub30HXB325wPoMB4C3n4j_9FWnNu5AmtYgU3PBvs8mQ@mail.gmail.com>
 <CACeCKadSCXZo3E4JZiwxFn_4CH3KDfQkk=xRrxSqCEWAgYhV6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKadSCXZo3E4JZiwxFn_4CH3KDfQkk=xRrxSqCEWAgYhV6Q@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 01:54:36AM -0700, Prashant Malani wrote:
> On Thu, Jun 16, 2022 at 12:42 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-06-15 10:20:20)
> > >
> > >  .../display/bridge/analogix,anx7625.yaml      | 64 +++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> >
> > Can this file get a link to the product brief[1]? It helps to quickly
> > find the block diagram.
> 
> Sure, but I don't really think that should be included in this patch
> (or series).
> I'd be happy to submit a separate patch once this series is resolved.
> 
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index 35a48515836e..bc6f7644db31 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -105,6 +105,34 @@ properties:
> > >        - port@0
> > >        - port@1
> > >
> > > +  switches:
> > > +    type: object
> > > +    description: Set of switches controlling DisplayPort traffic on
> > > +      outgoing RX/TX lanes to Type C ports.
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^switch@[01]$':
> > > +        $ref: /schemas/usb/typec-switch.yaml#
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          reg:
> > > +            maxItems: 1
> > > +
> > > +        required:
> > > +          - reg
> > > +
> > > +    required:
> > > +      - switch@0
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -167,5 +195,41 @@ examples:
> > >                      };
> > >                  };
> > >              };
> > > +            switches {
> >
> > Is "switches" a bus?
> 
> No.
> 
> >
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +                switch@0 {
> > > +                    compatible = "typec-switch";
> >
> > Is this compatible matched against a driver that's populated on this
> > "switches" bus?
> 
> No. Patch 6/7 has the implementation details on how the anx driver
> performs the enumeration of switches.
> 
> >
> > > +                    reg = <0>;
> > > +                    mode-switch;
> > > +
> > > +                    ports {
> > > +                        #address-cells = <1>;
> > > +                        #size-cells = <0>;
> > > +                        port@0 {
> > > +                            reg = <0>;
> > > +                            anx_typec0: endpoint {
> > > +                                remote-endpoint = <&typec_port0>;
> > > +                            };
> > > +                        };
> > > +                    };
> >
> > I was expecting to see these simply be more ports in the existing graph
> > binding of this device, and then have the 'mode-switch' or
> > 'orientation-switch' properties be at the same level as the compatible
> > string "analogix,anx7625". Here's the reasoning, based on looking at the
> > product brief and the existing binding/implementation.
> >
> > Looking at the only existing implementation of this binding upstream in
> > mt8183-kukui-jacuzzi.dtsi it looks like one of these typec ports is
> > actually the same physically as the 'anx7625_out' endpoint (reg address
> > of 1) that is already defined in the binding. It seems that MIPI DSI/DPI
> > comes in and is output through 2 lanes, SSRX2 and SSTX2 according to the
> > product brief[1], and that is connected to some eDP panel
> > ("auo,b116xw03"). Presumably that is the same as anx_typec1 in this
> > patch? I suspect the USB3.1 input is not connected on this board, and
> > thus the crosspoint switch is never used, nor the SSRX1/SSTX1 pins.
> >
> > The existing binding defines the MIPI DSI/DPI input as port0 and two of
> > the four lanes of output that is probably by default connected to the
> > "DisplayPort Transmitter" as port1 because that's how the crosspoint
> > switch comes out of reset. That leaves the USB3.1 input possibly needing
> > a port in the ports binding, and the other two lanes of output needing a
> > port in the ports binding to describe their connection to the downstream
> > device. And finally information about if the crosspoint switch needs to
> > be registered with the typec framework to do typec things, which can be
> > achieved by the presence of the 'mode-switch' property.
> >
> > On a board like kukui-jacuzzi these new properties and ports wouldn't be
> > specified, because what is there is already sufficient. If this chip is
> > connected to a usb-c-connector then I'd expect to see a connection from
> > the output ports in the graph binding to the connector node's ports.
> > There aren't any ports in the usb-c-connector binding though from what I
> > see.
> >
> > I believe there's also one more use case here where USB3.1 or MIPI
> > DSI/DPI is connected on the input side and this device is used to steer
> > USB3.1 or DP through the crosspoint switch to either of the two output
> > pairs. This last scenario means that we have to describe both output
> > pairs, SSRX1/SSTX1 and SSRX2/SSTX2, as different ports in the binding so
> > they can be connected to different usb-c-connectors if the hardware
> > engineer wired the output pins that way.
> >
> > TL;DR: Can we add 'mode-switch' as an optional property and two more
> > ports at address 2 and 3 for the USB3.1 input and the SSRX1/SSTX1 pair
> > respectively to the existing graph part of this binding?
> 
> Sorry, but I got lost midway through the preceding explanation. 

Made sense to me.

> The binding
> can always add additional ports to each "switch" to accomplish the
> graph connections
> you are alluding to (if the driver needs/uses it, which I don't think
> this one does at present).

Why is the switch special? If I just look at this from a block diagram 
perspective, I just see a list of interfaces that need to be described 
in the graph.

> Adding extra ports to existing ports gets tricky from a mode-switch
> enumeration perspective (which
> ports should have the modes switches, which shouldn't? Do you follow
> the remote end points for each port
> and see which one is a Type C connector? 

The driver knows which port is which because the binding has to define 
it. So you have to check 2 of them (SSRX1/SSTX1 and SSRX2/SSTX2) to find 
usb C connectors.

> What if we add an
> intermediate switch device in the future?)
> Having a dedicated "switch" binding makes this consistent and easy
> (port0 will always have the end-point for the switch).
> 
> While there may be more than 1 valid approach here, I believe the
> current one is appropriate.

To put it simply, if you want to define a generic binding, I want to see 
at least 2 users of it. What I really want to see is someone looking at 
all the Type-C related bindings and h/w possibilities, not just 1 
problem or their own h/w. IOW, a Type-C binding czar.

Rob
