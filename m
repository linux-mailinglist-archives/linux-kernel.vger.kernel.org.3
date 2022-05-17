Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07652ABA0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352551AbiEQTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352539AbiEQTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:10:59 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41526126;
        Tue, 17 May 2022 12:10:57 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f1d5464c48so917985fac.6;
        Tue, 17 May 2022 12:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLWGf6noqZ2UAsrYDmsOYBAadodi2Bs3NIlH+wwmFZo=;
        b=Azd0tm2mtuf/pKYeUOuT2jschQ/+L8iF+hBpsq2rZrhu4/r+f+ZFNu3ezDmnOONVfc
         lQYWIOXp5HPX1sb2cOOY6ZGkrXmhKkHA6xSC1PuGTY8ZkVJLZn3GivEIW0hi1p6FrJYm
         4UJgwDS1PRlGjEXSaDVcOhAomMFl4qxzI6uF1J37hhzQrpFDDDQR1MdUDdatdhstLPlg
         3Q0NyDYoA/TVWQaNiCthl2hxSHGW3Z9fZ5ne7p9dGGAMSNzo+PcshgdBJTTH7s1Rvctd
         OQKZ32O8w5wN+pb+DtnyOpBFqx0hIge3dM6SZlmksFE+eZQKWhs7vzUIP3WOtQmm3mPB
         6HVQ==
X-Gm-Message-State: AOAM5304giNkwmTmsDTZChL20o8kVpBVsAAu+lVm4wWb/UgJP5MUp++h
        EkkAfJ6dH0w6WdPiEAlncQ==
X-Google-Smtp-Source: ABdhPJy4miFKvM87CLia6X19+C4vW9J6H2mSavDuTAHJg59x2aj8kAcXZfvXKVJcD+y5m6DKMyvKxA==
X-Received: by 2002:a05:6870:f206:b0:d6:ca78:94f0 with SMTP id t6-20020a056870f20600b000d6ca7894f0mr14282937oao.4.1652814656913;
        Tue, 17 May 2022 12:10:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y80-20020aca4b53000000b00325cda1ffb6sm26413oia.53.2022.05.17.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:10:56 -0700 (PDT)
Received: (nullmailer pid 1444903 invoked by uid 1000);
        Tue, 17 May 2022 19:10:55 -0000
Date:   Tue, 17 May 2022 14:10:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220517191055.GA1424316-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 02:17:49AM +0300, Serge Semin wrote:
> In order to create a more sophisticated AHCI controller DT bindings let's
> divide the already available generic AHCI platform YAML schema into the
> platform part and a set of the common AHCI properties. The former part
> will be used to evaluate the AHCI DT nodes mainly compatible with the
> generic AHCI controller while the later schema will be used for more
> thorough AHCI DT nodes description. For instance such YAML schemas design
> will be useful for our DW AHCI SATA controller derivative with four clock
> sources, two reset lines, one system controller reference and specific
> max Rx/Tx DMA xfers size constraints.
> 
> Note the phys and target-supply property requirement is preserved in the
> generic AHCI platform bindings because some platforms can lack of the
> explicitly specified PHYs or target device power regulators.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Folks, I don't really see why the phys/target-supply requirement has been
> added to the generic AHCI DT schema in the first place. Probably just to
> imply some meaning for the sub-nodes definition. Anyway in one of the
> further patches I am adding the DW AHCI SATA controller DT bindings which
> won't require having these properties specified in the sub-nodes, but will
> describe additional port-specific properties. That's why I get to keep the
> constraints in the ahci-platform.yaml schema instead of moving them to the
> common schema.
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 
> Changelog v3:
> - Replace Jens's email address with Damien's one in the list of the
>   schema maintainers. (@Damien)
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
>  .../bindings/ata/ahci-platform.yaml           |  68 +---------
>  2 files changed, 123 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> new file mode 100644
> index 000000000000..620042ca12e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Serial ATA AHCI controllers
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
> +
> +description:
> +  This document defines device tree properties for a common AHCI SATA
> +  controller implementation. It's hardware interface is supposed to
> +  conform to the technical standard defined by Intel (see Serial ATA
> +  Advanced Host Controller Interface specification for details). The
> +  document doesn't constitute a DT-node binding by itself but merely
> +  defines a set of common properties for the AHCI-compatible devices.
> +
> +select: false
> +
> +allOf:
> +  - $ref: sata-common.yaml#
> +
> +properties:
> +  reg:
> +    description:
> +      Generic AHCI registers space conforming to the Serial ATA AHCI
> +      specification.
> +
> +  reg-names:
> +    description: CSR space IDs
> +
> +  interrupts:
> +    description:
> +      Generic AHCI state change interrupt. Can be implemented either as a
> +      single line attached to the controller as a set of the dedicated signals
> +      for the global and particular port events.
> +
> +  clocks:
> +    description:
> +      List of all the reference clocks connected to the controller.
> +
> +  clock-names:
> +    description: Reference clocks IDs
> +
> +  resets:
> +    description:
> +      List of the reset control lines to reset the controller clock
> +      domains.
> +
> +  reset-names:
> +    description: Reset line IDs
> +
> +  power-domains:
> +    description:
> +      List of the power domain the AHCI controller being a part of.

There's not really any point in listing all the above properties here, 
because they all have to be listed in the device specific schemas.

> +
> +  ahci-supply:
> +    description: Power regulator for AHCI controller
> +
> +  target-supply:
> +    description: Power regulator for SATA target device
> +
> +  phy-supply:
> +    description: Power regulator for SATA PHY
> +
> +  phys:
> +    description: Reference to the SATA PHY node
> +    maxItems: 1
> +
> +  phy-names:
> +    maxItems: 1
> +
> +  ports-implemented:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Mask that indicates which ports the HBA supports. Useful if PI is not
> +      programmed by the BIOS, which is true for some embedded SoC's.
> +    maximum: 0x1f

The AHCI spec says there's a max of 32 ports, not 5.

https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf

> +
> +patternProperties:
> +  "^sata-port@[0-9a-f]+$":
> +    type: object
> +    description:
> +      It is optionally possible to describe the ports as sub-nodes so
> +      to enable each port independently when dealing with multiple PHYs.
> +
> +    properties:
> +      reg:
> +        description: AHCI SATA port identifier
> +        maxItems: 1
> +
> +      phys:
> +        description: Individual AHCI SATA port PHY
> +        maxItems: 1
> +
> +      phy-names:
> +        description: AHCI SATA port PHY ID
> +        maxItems: 1
> +
> +      target-supply:
> +        description: Power regulator for SATA port target device
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: true

If device specific bindings can add their own properties (as this 
allows), then all the common sata-port properties needs to be its own 
schema document. That way the device binding can reference it, define 
extra properties and set 'unevaluatedProperties: false'.

If other properties aren't allowed, then you can just change this to 
false. That's what we had before this change.

> +
> +required:
> +  - reg
> +  - interrupts
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 9304e4731965..76075d3c8987 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -36,8 +36,7 @@ select:
>      - compatible
>  
>  allOf:
> -  - $ref: "sata-common.yaml#"
> -
> +  - $ref: "ahci-common.yaml#"
>  
>  properties:
>    compatible:
> @@ -69,90 +68,35 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    description:
> -      Clock IDs array as required by the controller.
>      minItems: 1
>      maxItems: 3
>  
>    clock-names:
> -    description:
> -      Names of clocks corresponding to IDs in the clock property.
>      minItems: 1
>      maxItems: 3
>  
>    interrupts:
>      maxItems: 1
>  
> -  ahci-supply:
> -    description:
> -      regulator for AHCI controller
> -
> -  phy-supply:
> -    description:
> -      regulator for PHY power
> -
> -  phys:
> -    description:
> -      List of all PHYs on this controller
> -    maxItems: 1
> -
> -  phy-names:
> -    description:
> -      Name specifier for the PHYs
> -    maxItems: 1
> -
> -  ports-implemented:
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> -    description: |
> -      Mask that indicates which ports that the HBA supports
> -      are available for software to use. Useful if PORTS_IMPL
> -      is not programmed by the BIOS, which is true with
> -      some embedded SoCs.
> -    maximum: 0x1f
> -
>    power-domains:
>      maxItems: 1
>  
>    resets:
>      maxItems: 1
>  
> -  target-supply:
> -    description:
> -      regulator for SATA target power
> -
> -required:
> -  - compatible
> -  - reg
> -  - interrupts
> -
>  patternProperties:
>    "^sata-port@[0-9a-f]+$":
>      type: object
> -    additionalProperties: false
> -    description:
> -      Subnode with configuration of the Ports.
> -
> -    properties:
> -      reg:
> -        maxItems: 1
> -
> -      phys:
> -        maxItems: 1
> -
> -      phy-names:
> -        maxItems: 1
> -
> -      target-supply:
> -        description:
> -          regulator for SATA target power
> -
> -    required:
> -      - reg
>  
>      anyOf:
>        - required: [ phys ]
>        - required: [ target-supply ]
>  
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.35.1
> 
> 
