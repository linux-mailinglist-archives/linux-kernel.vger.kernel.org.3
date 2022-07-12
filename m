Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDC57270F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiGLUNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiGLUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:13:48 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC3B7EB;
        Tue, 12 Jul 2022 13:13:45 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id n68so8991192iod.3;
        Tue, 12 Jul 2022 13:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FD3iOLQdN91bZcY+dc8yYBURhvU2viDaJpl9SU9IenU=;
        b=Hvqc30j3isKxScnoo69gFhZFQ25/hWn1rLtgcRiNQ5QuOdZScb95qmnKnDdD3gKbX4
         X8tX5yi/hdSfP3LX92FqYFN8OsCmC9bd56sViGd3hDMN487ZGMtfvrCXAmzEgA6STlcS
         mI/YmuG+ZwiPAfPjYdQ/BMr35nMGthjOP6xb7HDM5450/VnOpEnVhHmPcJQhRZo8jYCC
         IREvfflBcyNZ129ZFzXTILINXjFTRUnvgyozrOaKnqiyA6HM6VWIXfGzfSZdSj4g6GcB
         uU6qEOXPT0KHQFbUfxW5G8/B40gtevvZrvn17NDFzGIsCya2veXwt5Zd8QU742hzttWq
         X7mw==
X-Gm-Message-State: AJIora+AtJ/UwE2fTPUAVhkJT39WCet/sPi44mYVOeaP0yEjAAH6MK9A
        wbP8N0bxEV2FptzMMgN/6A==
X-Google-Smtp-Source: AGRyM1vtymMdnzuF/JqdCbpN9B/QBFZTTbR503UfN7lSeYp249vszXWJ6d/7ED8IkcKRO8O40J2jdA==
X-Received: by 2002:a05:6638:272c:b0:33f:6fe4:b76f with SMTP id m44-20020a056638272c00b0033f6fe4b76fmr2999123jav.284.1657656824314;
        Tue, 12 Jul 2022 13:13:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w16-20020a92d2d0000000b002dc29c112a7sm4093666ilg.69.2022.07.12.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:13:43 -0700 (PDT)
Received: (nullmailer pid 2288992 invoked by uid 1000);
        Tue, 12 Jul 2022 20:13:42 -0000
Date:   Tue, 12 Jul 2022 14:13:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220712201342.GM1823936-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-18-Sergey.Semin@baikalelectronics.ru>
 <20220614222754.GA2830345-robh@kernel.org>
 <20220617193744.av27axznbogademt@mobilestation>
 <20220706223642.GC572635-robh@kernel.org>
 <20220707152539.tktdo4qnvwormkqk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707152539.tktdo4qnvwormkqk@mobilestation>
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

On Thu, Jul 07, 2022 at 06:25:39PM +0300, Serge Semin wrote:
> On Wed, Jul 06, 2022 at 04:36:42PM -0600, Rob Herring wrote:
> > On Fri, Jun 17, 2022 at 10:37:44PM +0300, Serge Semin wrote:
> > > On Tue, Jun 14, 2022 at 04:27:54PM -0600, Rob Herring wrote:
> > > > On Fri, Jun 10, 2022 at 11:17:55AM +0300, Serge Semin wrote:
> > > > > Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> > > > > SATA controller except a few peculiarities and the platform environment
> > > > > requirements. In particular it can have one or two reference clocks to
> > > > > feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> > > > > control for the application clock domain. In addition to that the DMA
> > > > > interface of each port can be tuned up to work with the predefined maximum
> > > > > data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> > > > > more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> > > > > device DT binding.
> > > > > 
> > > > > Note the DWC AHCI SATA controller DT-schema has been created in a way so
> > > > > to be reused for the vendor-specific DT-schemas (see for example the
> > > > > "snps,dwc-ahci" compatible string binding). One of which we are about to
> > > > > introduce.
> > > > > 
> > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changelog v2:
> > > > > - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
> > > > >   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> > > > > 
> > > > > Changelog v4:
> > > > > - Decrease the "additionalProperties" property identation otherwise it's
> > > > >   percieved as the node property instead of the key one. (@Rob)
> > > > > - Use the ahci-port properties definition from the AHCI common schema
> > > > >   in order to extend it with DWC AHCI SATA port properties. (@Rob)
> > > > > - Remove the Hannes' rb tag since the patch content has changed.
> > > > > ---
> > > > >  .../bindings/ata/ahci-platform.yaml           |   8 --
> > > > >  .../bindings/ata/snps,dwc-ahci.yaml           | 129 ++++++++++++++++++
> > > > >  2 files changed, 129 insertions(+), 8 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > > > index e19cf9828e68..7dc2a2e8f598 100644
> > > > > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > > > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > > > @@ -30,8 +30,6 @@ select:
> > > > >            - marvell,armada-3700-ahci
> > > > >            - marvell,armada-8k-ahci
> > > > >            - marvell,berlin2q-ahci
> > > > > -          - snps,dwc-ahci
> > > > > -          - snps,spear-ahci
> > > > >    required:
> > > > >      - compatible
> > > > >  
> > > > > @@ -48,17 +46,11 @@ properties:
> > > > >                - marvell,berlin2-ahci
> > > > >                - marvell,berlin2q-ahci
> > > > >            - const: generic-ahci
> > > > > -      - items:
> > > > > -          - enum:
> > > > > -              - rockchip,rk3568-dwc-ahci
> > > > > -          - const: snps,dwc-ahci
> > > > >        - enum:
> > > > >            - cavium,octeon-7130-ahci
> > > > >            - hisilicon,hisi-ahci
> > > > >            - ibm,476gtr-ahci
> > > > >            - marvell,armada-3700-ahci
> > > > > -          - snps,dwc-ahci
> > > > > -          - snps,spear-ahci
> > > > >  
> > > > >    reg:
> > > > >      minItems: 1
> > > > > diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..af78f6c9b857
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > > > @@ -0,0 +1,129 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Synopsys DWC AHCI SATA controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > > +
> > > > > +description:
> > > > > +  This document defines device tree bindings for the Synopsys DWC
> > > > > +  implementation of the AHCI SATA controller.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: ahci-common.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - description: Synopsys AHCI SATA-compatible devices
> > > > > +        contains:
> > > > > +          const: snps,dwc-ahci
> > > > > +      - description: SPEAr1340 AHCI SATA device
> > > > > +        const: snps,spear-ahci
> > > > > +      - description: Rockhip RK3568 ahci controller
> > > > > +        const: rockchip,rk3568-dwc-ahci
> > > > 
> > > 
> > > > This is never true because there is a fallback. We should keep what we 
> > > > had before.
> > > 
> > > Could you be more specific what you meant? I don't see
> > > "snps,spear-ahci" and "rockchip,rk3568-dwc-ahci" used with the fallback
> > > string so modification is correct in that case.
> > 
> 
> > Spear does not, just rockchip:
> > 
> > arch/arm64/boot/dts/rockchip/rk3568.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
> > arch/arm64/boot/dts/rockchip/rk356x.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
> > arch/arm64/boot/dts/rockchip/rk356x.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
> > 
> > So the 3rd entry is never true.
> 
> Then I'll have to split the schema up into two bindings:
> 1. snps,dwc-ahci-common.yaml: generic DW SATA AHCI properties and no "compatible"
> property constraint since you said fallback was useless.
> 2. snps,dwc-ahci.yaml: generic DW SATA AHCI DT-schema with
> competibles: ("snps,dwc-ahci"), ("snps,spear-ahci"),
> ("rockchip,rk3568-dwc-ahci","snps,dwc-ahci").
> 
> Are you ok with this?

Yes.

> BTW if we had the fallback required the splitting up couldn't have
> been needed.

We generally end up needing a split like this anyways.


> > > My idea was to have the compatible strings with the required generic
> > > fallback "snps,dwc-ahci" for all new devices thus identifying the
> > > controller IP-core origin. But later you said "The generic IP block
> > > fallbacks have proven to be useless." I do agree that functionally it
> > > isn't that often used, but in some cases it can be handy for instance
> > > to implement quirks in the generic code or use the fallback as an
> > > additional info regarding the IP-core origin/version. So if I were you
> > > I wouldn't be that strict about dropping the generic IP-core fallback
> > > identifier. It's much easier to have it specified from the very
> > > beginning than adding it after it has been declared as not required.
> > 
> > I wish they were useful, but experience has shown they are not.
> 
> So what to do with the generic fallback compatibles then? Please
> answer to the next questions so I would correct all my currently
> stashed patches in accordance with it.
> 
> 1) Do you want all the new DT-binding schemas refusing to have the
> fallback compatibles except for the nodes which bindings have already
> been defined that way?

Yes. I wouldn't go quite as far as 'refusing'. I'm okay with a fallback 
in cases that are simple enough to actually work without platform 
specific code. As soon as the clocks, resets, phys, etc. aren't 
standard, that goes out the window. Based on experience, that pretty 
much never happens except on the IP vendor's FPGA.


> 2) What if a device IP-core has some versioning, but it's either
> not auto-detectable at runtime or can be auto-detected but starting
> from some IP-core version? Do we need it being specified in addition
> to the vendor-specific compatible string?

By the time you are probing the device, you know the specific SoC and 
can just set a version variable easily. Why have a string to parse that 
doesn't work for version comparisons (e.g GT/GE/LT).

Also, what if you don't know the exact IP version? Maybe you can guess 
that it is at least at certain version based on knowing the features, so 
you set that version. Would you really want to put that guess in DT when 
later on you might need to change it?

> 3) The same as 2), but shall it have a generic version-less fallback
> compatible string too?

If the device can function without the version specific compatible.

> 4) The same as 2), but what if it concerns a device which driver
> relies on the versioning?
> 
> 5) The same as 2), but what if it concerns the device which currently
> doesn't have a driver relying on the IP-core version?

Again, let the driver set the version based on the platform specific 
compatible.

> 6) What if we don't have the generic fallback compatible string
> required, but at some point a kernel would need it to
> implement a version/IP-core-specific quirk? If we had the generic
> fallback specified in dts the older systems would have been supported
> out-of-box, otherwise the firmware update would also needed.

Again, when you start probing the device, you already know the specific 
platform implementation. From that, you can easily imply the IP vendor 
and version. No DT change needed.

> IMO having the IP-core version + generic compatibles give many
> benefits and it's much easier to have them required from the very
> beginning instead of adding afterwards when then a need arises.

Certainly adding afterwards is broken. That's why we insist on SoC 
specific compatibles. Adding them when we have some platform specific 
quirk doesn't work.

Rob
