Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCC546B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbiFJRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiFJRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:22:16 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12DB2AE0;
        Fri, 10 Jun 2022 10:22:13 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id z11so2590268ilq.6;
        Fri, 10 Jun 2022 10:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jl6FYYtuoCy1dAP3XZ0szSvPvpuq03JpAbqB4WDoN7w=;
        b=WsWswPEC5Y8M8utmiFSopEb7ki4t5WES4CVTEcF3AQgBYRd6gKqGYp6IJfxC1XDSim
         S1Vd7zE1HI4du1tysn79TdMpNrdU71d8ryYTra+jkwxFms+8vYoTJogz7Xpr8C9IzLEC
         IeuP+Jk60bOWdqAcOYJYR16EP0JkuAwOG44AIIipd2MybsHjMV0cz3bkuMQMOuwbW7v0
         7JxBZwmCEoThMY3KXWzfkiuNW2iClOrckLJ2mkWsR+Ys+N/izN28yhH6rZU56OH4Elly
         AEwhKH6ReMxLFoJ1NnprESKZvge2cFm/9SXqmvD3Ymyt7adAaGMquGzzAlIGPJTQTCHl
         L3RA==
X-Gm-Message-State: AOAM531IunOPdwOc54O27BYW4MwwuOMPzp9E/aKEDeRyw4RYLVG8WzsP
        sBjLEfAFZ7Eo1511pJAI8w==
X-Google-Smtp-Source: ABdhPJx61COgrJWQvRHZbWnm+L5STCz0ecy8rPGyLMPjyM1Ln376GXDbciNW4JSNKaB2v/QiAFPHUA==
X-Received: by 2002:a05:6e02:967:b0:2d3:9b99:e8af with SMTP id q7-20020a056e02096700b002d39b99e8afmr35420ilt.202.1654881732911;
        Fri, 10 Jun 2022 10:22:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c12-20020a6b4e0c000000b0065a47e16f4esm6222973iob.32.2022.06.10.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:22:12 -0700 (PDT)
Received: (nullmailer pid 1858748 invoked by uid 1000);
        Fri, 10 Jun 2022 17:22:10 -0000
Date:   Fri, 10 Jun 2022 11:22:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220610172210.GE1787330-robh@kernel.org>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
 <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
 <20220609153826.GA3828657-robh@kernel.org>
 <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
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

On Fri, Jun 10, 2022 at 05:25:25PM +0530, Harsh Agarwal wrote:
> 
> On 6/9/2022 9:08 PM, Rob Herring wrote:
> > On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
> > > Added support for multiport, mport, num_usb2_phy and num_usb3_phy
> > > properties. These properties are used to support devices having
> > > a multiport controller.
> > > 
> > > Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> > > ---
> > >   .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
> > >   1 file changed, 53 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > index d41265b..9332fa2 100644
> > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > @@ -343,6 +343,32 @@ properties:
> > >         This port is used with the 'usb-role-switch' property  to connect the
> > >         dwc3 to type C connector.
> > > +  multiport:
> > Again, I don't think this is going to play well if you need to describe
> > USB devices in your DT. For example, a USB hub with additional DT
> > properties.
> Thanks for the review Rob.
> Can you please explain why would one want to describe a USB hub in device
> tree ?

Because someone soldered a hub on the board and then connected extra 
things like resets, GPIOs, supplies which are all outside of standard 
USB. It's quite common...

There's some flavors of Beagle boards that have a USB ethernet on board. 
Guess what, they skipped out on a eeprom and so the device and a MAC 
address has to be described in DT (if you want a stable MAC addr).

> IF USB hub is attached to a root port , it would be enumerated by the SW. I
> am not clear how DT is coming
> into picture. Even if there was a scenario to add DT properties for a hub,
> then this multiport node would be like a nop
> as it just helps us to get the PHY phandles in a proper way.

It won't be enumerated by the SW if it has to be powered on first using 
non-standard resources.

> Do you feel we still might have a problem with multiport node ?

A board design could have a hub or device on any or all your ports.

> > > +    description:
> > > +      If a single USB controller supports multiple ports, then it's referred to as
> > > +      a multiport controller. Each port of the multiport controller can support
> > > +      either High Speed or Super Speed or both and have their own PHY phandles. Each
> > > +      port is represented by "mport" node and all the "mport" nodes are grouped
> > > +      together inside the "multiport" node where individual "mport" node defines the
> > > +      PHYs supported by that port.
> > > +
> > > +  num_usb2_phy:
> > > +    description: Total number of HS-PHYs defined by the multiport controller.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  num_usb3_phy:
> > > +    description: Total number of SS-PHYs defined by the multiport controller.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  mport:
> > > +    description: Each mport node represents one port of the multiport controller.
> > > +    oneOf:
> > > +      - required:
> > > +        - usb-phy
> > This is deprecated. Why are you adding it?
> Do you mean "usb-phy" is deprecated ?

It is replaced by 'phys'. Any new user should use 'phys'.

> Internally we use usb-phy with our downstream GLUE driver

Upstream does not care about that.

> > 
> > > +      - required:
> > > +        - phys
> > > +        - phy-names
> > Other multi port USB hosts just have a list of phys. Why can't you just
> > use phy-names to identify each phy:
> > 
> > phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
> >    "port3-hs";
> With the above method we would have to do some kind of string parsing on the
> phy-names to get the HS and SS PHYs as we need to cater to different
> combinations of Ports ( some support HS+SS , other supports SS only).

You are doing string parsing anyways to get the child nodes and 
properties.

> So one challenge here is with the "usb-phy". There we directly define the
> phy phandles and that might/might-not have proper sub-strings. eg
> USB_QMP_PHY . So extracting PHYS could be tricky if the phy-handle does not
> have proper substring like "SS" "HS" etc.

The schema can and should enforce that you have the proper strings.

> We cannot break existing implementation and so we thought of going with the
> "multiport" node approach, listing below some flexibility :

How would this break?

> 1. Better representation of the PHYs and it's relation with a port.
> 2. Here for each port we pick the first PHY as HS and 2nd PHY as SS as we
> have been doing traditionally.
> So for "usb-phy" we need not care how the PHY handles are named.
> 
> 3. It's future proof incase we need to add additional properties specific to
> a port. We can just add those properties inside MP_1 or MP_2 etc.
> Though nothing like this has yet been implemented.

Then you have to consider how the standard USB device binding fits into 
this, and it needs to work for anyone with multiple ports. The 
usb-hcd.yaml schema already defines that child nodes represent a USB 
device attached to a port on the host. 'reg' is the port number.

Rob
