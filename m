Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43683532D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiEXPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiEXPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:19:18 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73779193C5;
        Tue, 24 May 2022 08:19:17 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f233f06563so11015912fac.7;
        Tue, 24 May 2022 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJ7rZvdt4VLS6Ce2lZxnAMjqSa9bdOshXdO7Tpa1RYE=;
        b=s33JESsyNbTJdeyf4G/nozwuKCyrVSclk5wIutVFyuYjoj2Kr0Vf41J3oicoHW5dES
         3zq5nNQK+xY2Ab09yNxjz5dcyrDJ9bCgtBLQS4RGsRZZc+l8onRY8BgmPjyBl/Wlvl4M
         R3sISX1lKsJCQEtv1xFDpZs0/JjaDFKYK9QhLgm1A0HjZzrMf+HDo56OiY8E0kWHM8uk
         h86LPSacQYHNydRr7jKdqfmK+6tQ8GXUE9xkskqZl24Pyasye0zsgVdU9t/IJUBds2QP
         ptlnEY3wnZ84Efe7rWDVuOrAhVAsCtm02JRdJuoAmjirR3WOyEPSuEsGto43r8cQ60os
         opxw==
X-Gm-Message-State: AOAM533U19EODn+WxTCK1v6uOFYNTjPDmyyoF62qQxoRnAy47DKKasRj
        2lg9tfDf/cHdaRaTVfaFwCcHsTkdtA==
X-Google-Smtp-Source: ABdhPJwT6h8YyMFaEc6eguFxjhU7jET5JCCWTKtF1BfZkK25Jg4TeGRLPkCk6Ku2rwXDXfEuLLqveA==
X-Received: by 2002:a05:6870:fba9:b0:f2:2adf:476b with SMTP id kv41-20020a056870fba900b000f22adf476bmr2835019oab.279.1653405556520;
        Tue, 24 May 2022 08:19:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b000e686d1389esm5155618oao.56.2022.05.24.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:19:15 -0700 (PDT)
Received: (nullmailer pid 3814603 invoked by uid 1000);
        Tue, 24 May 2022 15:19:14 -0000
Date:   Tue, 24 May 2022 10:19:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220524151914.GB3730540-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
 <20220517191055.GA1424316-robh@kernel.org>
 <20220522150247.zznapdonuq7dsbup@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522150247.zznapdonuq7dsbup@mobilestation>
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

On Sun, May 22, 2022 at 06:02:47PM +0300, Serge Semin wrote:
> On Tue, May 17, 2022 at 02:10:55PM -0500, Rob Herring wrote:
> > On Thu, May 12, 2022 at 02:17:49AM +0300, Serge Semin wrote:
> > > In order to create a more sophisticated AHCI controller DT bindings let's
> > > divide the already available generic AHCI platform YAML schema into the
> > > platform part and a set of the common AHCI properties. The former part
> > > will be used to evaluate the AHCI DT nodes mainly compatible with the
> > > generic AHCI controller while the later schema will be used for more
> > > thorough AHCI DT nodes description. For instance such YAML schemas design
> > > will be useful for our DW AHCI SATA controller derivative with four clock
> > > sources, two reset lines, one system controller reference and specific
> > > max Rx/Tx DMA xfers size constraints.
> > > 
> > > Note the phys and target-supply property requirement is preserved in the
> > > generic AHCI platform bindings because some platforms can lack of the
> > > explicitly specified PHYs or target device power regulators.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Folks, I don't really see why the phys/target-supply requirement has been
> > > added to the generic AHCI DT schema in the first place. Probably just to
> > > imply some meaning for the sub-nodes definition. Anyway in one of the
> > > further patches I am adding the DW AHCI SATA controller DT bindings which
> > > won't require having these properties specified in the sub-nodes, but will
> > > describe additional port-specific properties. That's why I get to keep the
> > > constraints in the ahci-platform.yaml schema instead of moving them to the
> > > common schema.
> > > 
> > > Changelog v2:
> > > - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> > > 
> > > Changelog v3:
> > > - Replace Jens's email address with Damien's one in the list of the
> > >   schema maintainers. (@Damien)
> > > ---
> > >  .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
> > >  .../bindings/ata/ahci-platform.yaml           |  68 +---------
> > >  2 files changed, 123 insertions(+), 62 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > > new file mode 100644
> > > index 000000000000..620042ca12e7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > > @@ -0,0 +1,117 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Common Properties for Serial ATA AHCI controllers
> > > +
> > > +maintainers:
> > > +  - Hans de Goede <hdegoede@redhat.com>
> > > +  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > > +
> > > +description:
> > > +  This document defines device tree properties for a common AHCI SATA
> > > +  controller implementation. It's hardware interface is supposed to
> > > +  conform to the technical standard defined by Intel (see Serial ATA
> > > +  Advanced Host Controller Interface specification for details). The
> > > +  document doesn't constitute a DT-node binding by itself but merely
> > > +  defines a set of common properties for the AHCI-compatible devices.
> > > +
> > > +select: false
> > > +
> > > +allOf:
> > > +  - $ref: sata-common.yaml#
> > > +
> > > +properties:
> > > +  reg:
> > > +    description:
> > > +      Generic AHCI registers space conforming to the Serial ATA AHCI
> > > +      specification.
> > > +
> > > +  reg-names:
> > > +    description: CSR space IDs
> > > +
> > > +  interrupts:
> > > +    description:
> > > +      Generic AHCI state change interrupt. Can be implemented either as a
> > > +      single line attached to the controller as a set of the dedicated signals
> > > +      for the global and particular port events.
> > > +
> > > +  clocks:
> > > +    description:
> > > +      List of all the reference clocks connected to the controller.
> > > +
> > > +  clock-names:
> > > +    description: Reference clocks IDs
> > > +
> > > +  resets:
> > > +    description:
> > > +      List of the reset control lines to reset the controller clock
> > > +      domains.
> > > +
> > > +  reset-names:
> > > +    description: Reset line IDs
> > > +
> > > +  power-domains:
> > > +    description:
> > > +      List of the power domain the AHCI controller being a part of.
> > 
> 
> > There's not really any point in listing all the above properties here, 
> > because they all have to be listed in the device specific schemas.
> 
> I agree with dropping the reset, clocks and power-related properties,
> but it would be good to somehow signify that at least one IRQ is
> required. Is it possible to somehow set such constraint with open
> upper bound? If currently it isn't what about setting minItems: 1 (one
> generic IRQ) and maxItems: 32 (in case of the per-port IRQs platform)?

required:
  - interrupts

> 
> Regarding the reg and reg-names properties. Some constraints are added
> in one of the next patches of this series (you have already noticed
> that).
> 
> > 
> > > +
> > > +  ahci-supply:
> > > +    description: Power regulator for AHCI controller
> > > +
> > > +  target-supply:
> > > +    description: Power regulator for SATA target device
> > > +
> > > +  phy-supply:
> > > +    description: Power regulator for SATA PHY
> > > +
> > > +  phys:
> > > +    description: Reference to the SATA PHY node
> > > +    maxItems: 1
> > > +
> > > +  phy-names:
> > > +    maxItems: 1
> > > +
> > > +  ports-implemented:
> > > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > > +    description:
> > > +      Mask that indicates which ports the HBA supports. Useful if PI is not
> > > +      programmed by the BIOS, which is true for some embedded SoC's.
> > > +    maximum: 0x1f
> > 
> 
> > The AHCI spec says there's a max of 32 ports, not 5.
> > 
> > https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf
> 
> Right. The maximum constraint is dropped in the patch:
> [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common AHCI props constraints
> 
> > 
> > > +
> > > +patternProperties:
> > > +  "^sata-port@[0-9a-f]+$":
> > > +    type: object
> > > +    description:
> > > +      It is optionally possible to describe the ports as sub-nodes so
> > > +      to enable each port independently when dealing with multiple PHYs.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: AHCI SATA port identifier
> > > +        maxItems: 1
> > > +
> > > +      phys:
> > > +        description: Individual AHCI SATA port PHY
> > > +        maxItems: 1
> > > +
> > > +      phy-names:
> > > +        description: AHCI SATA port PHY ID
> > > +        maxItems: 1
> > > +
> > > +      target-supply:
> > > +        description: Power regulator for SATA port target device
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +    additionalProperties: true
> > 
> 
> > If device specific bindings can add their own properties (as this 
> > allows), then all the common sata-port properties needs to be its own 
> > schema document. That way the device binding can reference it, define 
> > extra properties and set 'unevaluatedProperties: false'.
> > 
> 
> Could you please be more specific the way it is supposed to look? We
> have already got the sata-port@.* object defined in the sata-common.yaml
> super-schema. Here I just redefine it with more specific properties.

If you want an example, see spi-peripheral-props.yaml and the change 
that introduced it.

If properties are defined in multiple locations, we have to be able to 
combine all those schemas to a single (logical, not single file) schema 
to apply it. That's the only way all the disjoint properties can be 
evaluated.

> Is it ok if I moved the sata-port@.* properties in the "definitions"
> section of the sata-common.yaml and ahci-common.yaml schema and
> re-used them right in the common bindings and, if required, in the
> device-specific schema?

Yes, I guess. There's not really any advantage to doing that. A separate 
schema file is only a small amount of boilerplate.

> Please confirm that the next schema hierarchy is what you were talking
> about and it will be ok in this case:
> 
> > Documentation/devicetree/bindings/ata/sata-common.yaml:
> ...
> + patternProperties:
> +   "^sata-port@[0-9a-e]$":
> +     $ref: '#/definitions/sata-port'
> + 
> + definitions:

'$defs' is preferred over 'definitions'.

> +   sata-port:
> +     type: object
> +   
> +     properties:
> +       reg:
> +         minimum: 0

That's the default.

> + 
> +     additionalProperties: true

Drop this.

> 
> > Documentation/devicetree/bindings/ata/ahci-common.yaml:
> ...
> + patternProperties:
> +   "^sata-port@[0-9a-e]$":
> +     $ref: '#/definitions/ahci-port'
> + 
> + definitions:
> +   ahci-port:
> +     $ref: /schemas/ata/sata-common.yaml#/definitions/sata-port
> +     properties:
> +       reg:
> +         minimum: 0
> +         maximum: 31
> ...
> + 
> +     additionalProperties: true

Drop this.

> 
> > Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml:
> ...
> + patternProperties:
> +   "^sata-port@[0-9a-e]$":
> +     $ref: /schemas/ata/ahci-common.yaml#/definitions/ahci-port
> +     properties:
> +       reg:
> +         minimum: 0
> +         maximum: 7
> + 
> +       snps,tx-ts-max:
> +         $ref: /schemas/types.yaml#/definitions/uint32
> + 
> +       snps,rx-ts-max:
> +         $ref: /schemas/types.yaml#/definitions/uint32
> +
> +     unevaluatedProperties: true

This needs to be false. And this should work as the $ref issue is only 
for the top-level schema.

Rob
