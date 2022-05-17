Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30852AC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbiEQUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiEQUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:04:14 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5524CD72;
        Tue, 17 May 2022 13:04:13 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id a22-20020a9d3e16000000b00606aeb12ab6so12912772otd.7;
        Tue, 17 May 2022 13:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IIaQA4b3hHv2itAgFRZqCZtPkNhj3dWRuktwztUeYB0=;
        b=tkzuaoxfNVnHWLOyzE359WoNf7Zr0mWZ5CEebi4Fr/F3ejDpYUUuAbiUvIGJXnRx4B
         ZAQpLHS/sIl7rSmjcqDz0DXNKivGg5q83S7/KP1Gn8vjeIv5GNYtvFKH0LJ5Vm3u6zm3
         Qjk0q6oCxZ8WvpLqUke/M31dr7YuOohsj2hvqQmBk/ee6UruK4Hzp9zSTXb+H67vmY0t
         YU+QYT0ozhvjewtqtgY7ocPe9kUG3oN2Pw66js/La2wImOAULD5eva0eawpi/Bt+UwD0
         ysS1nsNhG1Xh+95Psa2tDIHlFp9N9Ef/Y85n8AY2ioDAfsrRufPic3+BnDL+IbbEg67J
         XYWg==
X-Gm-Message-State: AOAM5339vD9Wpx7pen5xCN9EgpH0wf4l4xUfhHsiKoP3CK5l9zlDjgXF
        gl6pfEG2+Eu9n25FEaL0IQ==
X-Google-Smtp-Source: ABdhPJzK+76emXX7coEe6iFrJmT3kQ+hsQh9vVP0K86w/fEgQvyGQUjTO8KvNZGDC6AVcfxP09fXog==
X-Received: by 2002:a9d:eec:0:b0:606:bc42:9b3e with SMTP id 99-20020a9d0eec000000b00606bc429b3emr8924788otj.105.1652817853015;
        Tue, 17 May 2022 13:04:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k12-20020a4a2a0c000000b0035eb4e5a6bbsm174260oof.17.2022.05.17.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:04:12 -0700 (PDT)
Received: (nullmailer pid 1535050 invoked by uid 1000);
        Tue, 17 May 2022 20:04:11 -0000
Date:   Tue, 17 May 2022 15:04:11 -0500
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
Subject: Re: [PATCH v3 18/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220517200411.GA1462130-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-19-Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 02:18:05AM +0300, Serge Semin wrote:
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
> ---
>  .../bindings/ata/ahci-platform.yaml           |   8 --
>  .../bindings/ata/snps,dwc-ahci.yaml           | 123 ++++++++++++++++++
>  2 files changed, 123 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 6cad7e86f3bb..4b65966ec23b 100644
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
> index 000000000000..a13fd77a451f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -0,0 +1,123 @@
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
> +
> +  reset-names:
> +    contains:
> +      description: Core and application clock domains reset control
> +      const: arst
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    type: object
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
> +      additionalProperties: true

You just defined a DT property called 'additionalProperties'. For this 
reason, I prefer placing additionalProperties above 'properties'.

As mentioned the way 'sata-port' schemas are done here doesn't work.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
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
> +        hba-fbscp;
> +        snps,tx-ts-max = <512>;
> +        snps,rx-ts-max = <512>;
> +      };
> +    };
> +...
> -- 
> 2.35.1
> 
> 
