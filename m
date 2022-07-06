Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A932569595
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGFXBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFXBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:01:18 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5611C12F;
        Wed,  6 Jul 2022 16:01:17 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so23158082fac.13;
        Wed, 06 Jul 2022 16:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftg3nkiw4YMCBhVm4GjYQbi4EAw65M6tPEzJj7RvX3Q=;
        b=GanXydllfwsuwWs2wqfVjm1V7yclrBnEVLu3vo8lOT8FedPXQhHswVE78Z/fXP06yl
         U8v2UYPfheWAyFC09z/Y7ph8N7UyD5DRH+Svdyeq8Df7gUOybyyThlljLexVdYnXQL9l
         oHZTV3uTcPrKTAZfZFhDM2QWBi0QH+TbBkXvmN/K7eKFe43eAKK7rQ+edg5r6vQnIe0b
         J0hsKC/wl6Pdw6AYU9CuCK6vDR7hJZ6zMmIngkAlZOFzizLxHZRtfGZAWuArfQ2y4Jnr
         aVwQ4F+3hpMfbUbmr7dV49SViKz5ln74855YhOYotC5/wK7AaI52vUKjX5S/z4ppwXJN
         GeDA==
X-Gm-Message-State: AJIora8xF1xrcWsfTQic+rHFcL2SmGcfUHH/FvLjJgIt2mM/TDF11gzv
        6gHzO049NZ/uskW26inoDw==
X-Google-Smtp-Source: AGRyM1v1MWfpmm6E5fV9mEVufA395d+r9AZ9GUjfky5sGrak0Tl8WiMFGE2c/r0+HUr1dAdE29X2dw==
X-Received: by 2002:a05:6871:1d0:b0:101:59af:c6b7 with SMTP id q16-20020a05687101d000b0010159afc6b7mr679263oad.89.1657148476851;
        Wed, 06 Jul 2022 16:01:16 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:199f:283a:d3be:fc5c:70cd])
        by smtp.gmail.com with ESMTPSA id i21-20020a056808031500b00338869042fdsm468712oie.32.2022.07.06.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 16:01:16 -0700 (PDT)
Received: (nullmailer pid 660709 invoked by uid 1000);
        Wed, 06 Jul 2022 22:36:42 -0000
Date:   Wed, 6 Jul 2022 16:36:42 -0600
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
Message-ID: <20220706223642.GC572635-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-18-Sergey.Semin@baikalelectronics.ru>
 <20220614222754.GA2830345-robh@kernel.org>
 <20220617193744.av27axznbogademt@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617193744.av27axznbogademt@mobilestation>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:37:44PM +0300, Serge Semin wrote:
> On Tue, Jun 14, 2022 at 04:27:54PM -0600, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 11:17:55AM +0300, Serge Semin wrote:
> > > Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> > > SATA controller except a few peculiarities and the platform environment
> > > requirements. In particular it can have one or two reference clocks to
> > > feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> > > control for the application clock domain. In addition to that the DMA
> > > interface of each port can be tuned up to work with the predefined maximum
> > > data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> > > more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> > > device DT binding.
> > > 
> > > Note the DWC AHCI SATA controller DT-schema has been created in a way so
> > > to be reused for the vendor-specific DT-schemas (see for example the
> > > "snps,dwc-ahci" compatible string binding). One of which we are about to
> > > introduce.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v2:
> > > - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
> > >   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> > > 
> > > Changelog v4:
> > > - Decrease the "additionalProperties" property identation otherwise it's
> > >   percieved as the node property instead of the key one. (@Rob)
> > > - Use the ahci-port properties definition from the AHCI common schema
> > >   in order to extend it with DWC AHCI SATA port properties. (@Rob)
> > > - Remove the Hannes' rb tag since the patch content has changed.
> > > ---
> > >  .../bindings/ata/ahci-platform.yaml           |   8 --
> > >  .../bindings/ata/snps,dwc-ahci.yaml           | 129 ++++++++++++++++++
> > >  2 files changed, 129 insertions(+), 8 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > index e19cf9828e68..7dc2a2e8f598 100644
> > > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > @@ -30,8 +30,6 @@ select:
> > >            - marvell,armada-3700-ahci
> > >            - marvell,armada-8k-ahci
> > >            - marvell,berlin2q-ahci
> > > -          - snps,dwc-ahci
> > > -          - snps,spear-ahci
> > >    required:
> > >      - compatible
> > >  
> > > @@ -48,17 +46,11 @@ properties:
> > >                - marvell,berlin2-ahci
> > >                - marvell,berlin2q-ahci
> > >            - const: generic-ahci
> > > -      - items:
> > > -          - enum:
> > > -              - rockchip,rk3568-dwc-ahci
> > > -          - const: snps,dwc-ahci
> > >        - enum:
> > >            - cavium,octeon-7130-ahci
> > >            - hisilicon,hisi-ahci
> > >            - ibm,476gtr-ahci
> > >            - marvell,armada-3700-ahci
> > > -          - snps,dwc-ahci
> > > -          - snps,spear-ahci
> > >  
> > >    reg:
> > >      minItems: 1
> > > diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > new file mode 100644
> > > index 000000000000..af78f6c9b857
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > > @@ -0,0 +1,129 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Synopsys DWC AHCI SATA controller
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +description:
> > > +  This document defines device tree bindings for the Synopsys DWC
> > > +  implementation of the AHCI SATA controller.
> > > +
> > > +allOf:
> > > +  - $ref: ahci-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: Synopsys AHCI SATA-compatible devices
> > > +        contains:
> > > +          const: snps,dwc-ahci
> > > +      - description: SPEAr1340 AHCI SATA device
> > > +        const: snps,spear-ahci
> > > +      - description: Rockhip RK3568 ahci controller
> > > +        const: rockchip,rk3568-dwc-ahci
> > 
> 
> > This is never true because there is a fallback. We should keep what we 
> > had before.
> 
> Could you be more specific what you meant? I don't see
> "snps,spear-ahci" and "rockchip,rk3568-dwc-ahci" used with the fallback
> string so modification is correct in that case.

Spear does not, just rockchip:

arch/arm64/boot/dts/rockchip/rk3568.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
arch/arm64/boot/dts/rockchip/rk356x.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
arch/arm64/boot/dts/rockchip/rk356x.dtsi:               compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";

So the 3rd entry is never true.

> My idea was to have the compatible strings with the required generic
> fallback "snps,dwc-ahci" for all new devices thus identifying the
> controller IP-core origin. But later you said "The generic IP block
> fallbacks have proven to be useless." I do agree that functionally it
> isn't that often used, but in some cases it can be handy for instance
> to implement quirks in the generic code or use the fallback as an
> additional info regarding the IP-core origin/version. So if I were you
> I wouldn't be that strict about dropping the generic IP-core fallback
> identifier. It's much easier to have it specified from the very
> beginning than adding it after it has been declared as not required.

I wish they were useful, but experience has shown they are not.

> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description:
> > > +      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
> > > +      and embedded PHYs reference clock together with vendor-specific set
> > > +      of clocks.
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    contains:
> > > +      anyOf:
> > > +        - description: Application AXI/AHB BIU clock source
> > > +          enum:
> > > +            - aclk
> > > +            - sata
> > > +        - description: SATA Ports reference clock
> > > +          enum:
> > > +            - ref
> > > +            - sata_ref
> > > +
> > > +  resets:
> > > +    description:
> > > +      At least basic core and application clock domains reset is normally
> > > +      supported by the DWC AHCI SATA controller. Some platform specific
> > > +      clocks can be also specified though.
> > 
> 
> > s/clocks/resets/ ?
> 
> Right, but only in the reference to "platform specific clocks" -> "... resets".
> 
> > 
> > This allows any number of resets which isn't great. I think this schema 
> > should just be the 'simple' cases where there's only 1 reset and 1 
> > clock (or how many the DWC block actually has if you have that info). 
> > More complicated cases get there own schema.
> 
> DWC SATA reference manual claims there can be resets implemented to
> each clock domain.
> 1) PM-clk <- PM-rst - PM keep-alive clock/reset.
> 2) aclk/hclk <- aresetn/hresetn - AXI/AHB clock domain/reset.
> 3) rbc*_clk <- rbc*_rst - PHY Receive Clock domain/reset. (Up to
> number of ports <= 8.)
> 4) asic*_clk <- asic*_rst - PHY Transmit Clock domain/reset. (Up to
> number of ports <= 8.)
> 5) rxoob*_clk <- rxoob*_rst - RxOOB Detection Clock domain/reset. (Up
> to number of ports <= 8.)
> 
> So to speak the IP-core can be equipped with up to 26 clocks and
> resets. Should we be more strict we would have needed to define the
> properties with all the names above and permit up to 26 clocks/resets
> items. (Do you want it to be done?). In our case for instance there
> is "aclk" and a single common "ref" clock for all 3, 4 and 5 domain
> (clock 1 is missing).

I imagine most implementations just tie most clocks together.

I guess there's not going to be much new SATA h/w, so perhaps fine 
as-is.

Rob
