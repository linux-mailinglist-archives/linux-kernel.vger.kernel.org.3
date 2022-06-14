Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF454BDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiFNWb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350908AbiFNW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:28:28 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CF4AE37;
        Tue, 14 Jun 2022 15:27:57 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id h8so10893707iof.11;
        Tue, 14 Jun 2022 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ijnM6qqps/61JEPhDY+exeWmv8F27GG2ZRzYNTTkDdI=;
        b=YluoaUQFF5biecY8bQJWsyqOTFmtP7gVIV/xDz/hCPB60wg9F4wKIH+Je12VIrsnqr
         AT/bANsbnkX77La+0zsYP2NVs4LQzE6Ew8gNhUYHByI8vG/uaSUDTb+vy3LNPIPRauNr
         tavW1Xhwq2wp6r6cTMwipCt53IAm1HQ2Bpip8QJ4SyLJYRFcHSyUPsnJdU4ydAr6UfML
         BXw5UFfU3HtBDr/HwE3bgd4S23KGPL1SH1ZMhsaVR/mjx5CQl6xZeAYCkNadXz+5xEnn
         ESsH4TgAW2lGSp42ym4KtPIUmm0NDJpnhwx1AaC6+vR82uJ1iM9vZqzCudXk8UBd0POp
         sxwQ==
X-Gm-Message-State: AOAM532YwRGC45fuTX0xpFeF1TAMiO5j7NIGbev3U13cBsTY1der70Tu
        cpEM6595PuwMAPGpOXZ53Q==
X-Google-Smtp-Source: ABdhPJzbTj6BQ/OtQQ/H0TzS/7EgQ4bX0DXg7IDkhc9vrhCiPRjg/U1m4E4hYebaesNmCw3R6N/RTA==
X-Received: by 2002:a05:6638:d4d:b0:333:1aea:4b9f with SMTP id d13-20020a0566380d4d00b003331aea4b9fmr3988177jak.149.1655245676867;
        Tue, 14 Jun 2022 15:27:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s4-20020a056e02020400b002d3da8e4af5sm6212682ilr.23.2022.06.14.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:27:56 -0700 (PDT)
Received: (nullmailer pid 2841909 invoked by uid 1000);
        Tue, 14 Jun 2022 22:27:54 -0000
Date:   Tue, 14 Jun 2022 16:27:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220614222754.GA2830345-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-18-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:17:55AM +0300, Serge Semin wrote:
> Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> SATA controller except a few peculiarities and the platform environment
> requirements. In particular it can have one or two reference clocks to
> feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> control for the application clock domain. In addition to that the DMA
> interface of each port can be tuned up to work with the predefined maximum
> data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> device DT binding.
> 
> Note the DWC AHCI SATA controller DT-schema has been created in a way so
> to be reused for the vendor-specific DT-schemas (see for example the
> "snps,dwc-ahci" compatible string binding). One of which we are about to
> introduce.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
>   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> 
> Changelog v4:
> - Decrease the "additionalProperties" property identation otherwise it's
>   percieved as the node property instead of the key one. (@Rob)
> - Use the ahci-port properties definition from the AHCI common schema
>   in order to extend it with DWC AHCI SATA port properties. (@Rob)
> - Remove the Hannes' rb tag since the patch content has changed.
> ---
>  .../bindings/ata/ahci-platform.yaml           |   8 --
>  .../bindings/ata/snps,dwc-ahci.yaml           | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index e19cf9828e68..7dc2a2e8f598 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -30,8 +30,6 @@ select:
>            - marvell,armada-3700-ahci
>            - marvell,armada-8k-ahci
>            - marvell,berlin2q-ahci
> -          - snps,dwc-ahci
> -          - snps,spear-ahci
>    required:
>      - compatible
>  
> @@ -48,17 +46,11 @@ properties:
>                - marvell,berlin2-ahci
>                - marvell,berlin2q-ahci
>            - const: generic-ahci
> -      - items:
> -          - enum:
> -              - rockchip,rk3568-dwc-ahci
> -          - const: snps,dwc-ahci
>        - enum:
>            - cavium,octeon-7130-ahci
>            - hisilicon,hisi-ahci
>            - ibm,476gtr-ahci
>            - marvell,armada-3700-ahci
> -          - snps,dwc-ahci
> -          - snps,spear-ahci
>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> new file mode 100644
> index 000000000000..af78f6c9b857
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DWC AHCI SATA controller
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  This document defines device tree bindings for the Synopsys DWC
> +  implementation of the AHCI SATA controller.
> +
> +allOf:
> +  - $ref: ahci-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Synopsys AHCI SATA-compatible devices
> +        contains:
> +          const: snps,dwc-ahci
> +      - description: SPEAr1340 AHCI SATA device
> +        const: snps,spear-ahci
> +      - description: Rockhip RK3568 ahci controller
> +        const: rockchip,rk3568-dwc-ahci

This is never true because there is a fallback. We should keep what we 
had before.


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
> +      and embedded PHYs reference clock together with vendor-specific set
> +      of clocks.
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    contains:
> +      anyOf:
> +        - description: Application AXI/AHB BIU clock source
> +          enum:
> +            - aclk
> +            - sata
> +        - description: SATA Ports reference clock
> +          enum:
> +            - ref
> +            - sata_ref
> +
> +  resets:
> +    description:
> +      At least basic core and application clock domains reset is normally
> +      supported by the DWC AHCI SATA controller. Some platform specific
> +      clocks can be also specified though.

s/clocks/resets/ ?

This allows any number of resets which isn't great. I think this schema 
should just be the 'simple' cases where there's only 1 reset and 1 
clock (or how many the DWC block actually has if you have that info). 
More complicated cases get there own schema.

> +
> +  reset-names:
> +    contains:
> +      description: Core and application clock domains reset control
> +      const: arst
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    $ref: '#/$defs/dwc-ahci-port'
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +$defs:
> +  dwc-ahci-port:
> +    $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +
> +      snps,tx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Maximal size of Tx DMA transactions in FIFO words
> +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> +
> +      snps,rx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Maximal size of Rx DMA transactions in FIFO words
> +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/ata/ahci.h>
> +
> +    sata@122f0000 {
> +      compatible = "snps,dwc-ahci";
> +      reg = <0x122F0000 0x1ff>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      clocks = <&clock1>, <&clock2>;
> +      clock-names = "aclk", "ref";
> +
> +      phys = <&sata_phy>;
> +      phy-names = "sata-phy";
> +
> +      ports-implemented = <0x1>;
> +
> +      sata-port@0 {
> +        reg = <0>;
> +
> +        hba-port-cap = <HBA_PORT_FBSCP>;
> +
> +        snps,tx-ts-max = <512>;
> +        snps,rx-ts-max = <512>;
> +      };
> +    };
> +...
> -- 
> 2.35.1
> 
> 
