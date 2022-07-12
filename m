Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA64571EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiGLPXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiGLPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:22:46 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A4C1761;
        Tue, 12 Jul 2022 08:21:34 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h200so8117280iof.9;
        Tue, 12 Jul 2022 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDdtW6rNYIAp97Z79cLxZ45hBOzgYdm8qs6dwMe06kE=;
        b=udXhXjgi2WEeMemHhvb5hdhOGX3OIAtuCq1xW9wadYLW0gst3vybHdwF2jgRF4pYNv
         SbJOLjf+naRZhPgXPtt1IH+5e2rdKXrkcSQa5YsHbGm3wC/tH0gG6YanjlWksRZ2MWG0
         hW1wBjondEaoVCVZ3Qk2hwmivJ9lJsX4ZvrCiPM+V8wjngIOSq+1TAJWt3wb3M/DKjIc
         sAGc6qZmpnEiey0vOiKQUuaRZyXYnLBgV/rHNl1yDxw+YQ0YPvvXjqQSxZFKdXAWaYCX
         H4x4bholJ/OIcgjMqQp3fDVJQW+x2l/CmVaR5gt2h4DpytBWSV5csN54KIh09IPv+f1+
         uwUA==
X-Gm-Message-State: AJIora92EYhDyEyP3MEl9oN+sqZvnUqDP+DJS3KEWfLQSJGNWxJOrPx5
        9Og2BaxthyoKcM+4saQJ6g==
X-Google-Smtp-Source: AGRyM1u4Wa6kjd1im1mCu+hIdmoX1OrX7mux3KsADPgZgjKXuPCus7u6YBCHY1jBifOYL9R8YJ2wCg==
X-Received: by 2002:a05:6638:4126:b0:33f:6bc0:f8e7 with SMTP id ay38-20020a056638412600b0033f6bc0f8e7mr3449861jab.189.1657639293815;
        Tue, 12 Jul 2022 08:21:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m21-20020a02a155000000b00339e2f0a9bfsm4228957jah.13.2022.07.12.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:21:33 -0700 (PDT)
Received: (nullmailer pid 1879877 invoked by uid 1000);
        Tue, 12 Jul 2022 15:21:31 -0000
Date:   Tue, 12 Jul 2022 09:21:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, vkoul@kernel.org, kishon@ti.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v1 3/9] dt-bindings: reset: intel,rcu-gw: Update bindings
 for "legacy" SoCs
Message-ID: <20220712152131.GC1823936-robh@kernel.org>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-4-martin.blumenstingl@googlemail.com>
 <20220701163350.GA1078312-robh@kernel.org>
 <CAFBinCARuO0WFLufwgPxQkY_Mh+Pfn6V8QAe-HZ8sjUBKTYhtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCARuO0WFLufwgPxQkY_Mh+Pfn6V8QAe-HZ8sjUBKTYhtQ@mail.gmail.com>
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

On Sun, Jul 03, 2022 at 01:04:20AM +0200, Martin Blumenstingl wrote:
>  Hi Rob,
> 
> On Fri, Jul 1, 2022 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 02:44:35PM +0200, Martin Blumenstingl wrote:
> > > The Lantiq Amazon-SE, Danube, xRX100 and xRX200 SoCs have up to two USB2
> > > PHYs which are part of the RCU register space. The RCU registers on
> > > these SoCs are using big endian. Update the binding for these SoCs to
> > > properly describe this IP:
> > > - Add compatible strings for Amazon-SE, Danube and xRX100
> > > - Rename the xRX200 compatible string (which is not used anywhere) and
> > >   switch to the one previously documented in mips/lantiq/rcu.txt
> > > - Allow usage of "simple-mfd" and "syscon" in the compatible string so the
> > >   child devices (USB2 PHYs) can be described
> > > - Allow #address-cells and #size-cells to be set to 1 for describing the
> > >   child devices (USB2 PHYs)
> > > - #reset-cells must always be 3 (offset, reset bit and status bit) on the
> > >   legacy SoCs while LGM uses a fixed value of 2 (offset and reset bit -
> > >   status bit is always identical to the reset bit).
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > >  .../bindings/reset/intel,rcu-gw.yaml          | 84 +++++++++++++++++--
> > >  1 file changed, 79 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > > index be64f8597710..b90913c7b7d3 100644
> > > --- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > > +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > > @@ -11,9 +11,16 @@ maintainers:
> > >
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - intel,rcu-lgm
> > > -      - intel,rcu-xrx200
> >
> > It is okay to remove/change this because ?
> I'll update the description in v2. The "intel,rcu-xrx200" compatible
> string isn't used anywhere (upstream or downstream in OpenWrt).
> u-boot on Lantiq xRX200 SoCs is too old to pass a dtb to the kernel,
> so we're appending the DTB to the kernel image.
> 
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - lantiq,ase-rcu
> > > +              - lantiq,danube-rcu
> > > +              - lantiq,xrx100-rcu
> > > +              - lantiq,xrx200-rcu
> > > +          - const: simple-mfd
> >
> > This says child nodes have 0 dependence on anything in the parent node.
> > Such as a clock in the parent needing to be enabled.
> >
> > > +          - const: syscon
> >
> > Given the child nodes depend on this, I find the combination to be a
> > contradiction. But it's widely used, so oh well.
> I can think of two ways to solve this:
> 1) remove the simple-mfd compatible string and make the driver also
> discover child nodes
> 2) remove the simple-mfd compatible string and remove the USB PHY
> child nodes - then add add #phy-cells = <1> to the RCU node itself
> (and somehow update the RCU and USB PHY drivers accordingly)
> 3) introduce a separate child node for the reset-controller, then the
> child nodes depend on each other (but there's no strict dependency on
> the parent anymore other than the fact that the parent needs a
> "syscon" compatible string).
> 
> My understanding of this IP block is that it was initially designed as
> a reset controller, hence its name "reset controller unit" (RCU). Then
> additional logic was added after the fact.
> So I think 1) (dropping the simple-mfd compatible string) or 2)
> (dropping the simple-mfd compatible string and the child nodes
> altogether) is the right way to go here. Which route would you go and
> why?

2 would be my choice. That's the simplest binding. Unless the phy 
registers show up in different places on multiple devices, then maybe 
it's worth keeping the child node.

Rob
