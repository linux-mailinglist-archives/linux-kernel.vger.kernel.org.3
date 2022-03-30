Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC74ECD28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbiC3TW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350723AbiC3TWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:22:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3A98F73;
        Wed, 30 Mar 2022 12:20:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22UJJ9pl115222;
        Wed, 30 Mar 2022 14:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648667949;
        bh=HXP0I68YYcbtnXwobfKnkky9m9FMx1koQq3CNDnNl/s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=b0dOSS3TBcb/XaU+beH5EgUePch8ipiuqJc1igewV0Pxye9W5HprO2qYOuhIHwRk/
         epiXZ65HYC8iwP3u0uiNHN3KmCFiN6pvTFd7tFvE4+KOA4WnsRNzMpXTHtEy0Wy4pi
         27SK/+GWs9/gD0iLusC1GEna6+Li4O6jeKrI3xeo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22UJJ9wk031699
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Mar 2022 14:19:09 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 30
 Mar 2022 14:19:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 30 Mar 2022 14:19:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22UJJ8cX013600;
        Wed, 30 Mar 2022 14:19:09 -0500
Date:   Thu, 31 Mar 2022 00:49:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 02/11] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Message-ID: <20220330191908.nhg52a5ayzczpzai@ti.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220325100849.2019209-3-clg@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/22 11:08AM, Cédric Le Goater wrote:
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> new file mode 100644
> index 000000000000..e16bbcd38560
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed SMC controllers bindings
> +
> +maintainers:
> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +  - Cédric Le Goater <clg@kaod.org>
> +
> +description: |
> +  This binding describes the Aspeed Static Memory Controllers (FMC and
> +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-fmc
> +      - aspeed,ast2600-spi
> +      - aspeed,ast2500-fmc
> +      - aspeed,ast2500-spi
> +      - aspeed,ast2400-fmc
> +      - aspeed,ast2400-spi
> +
> +  reg:
> +    items:
> +      - description: registers
> +      - description: memory mapping
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  "@[0-9a-f]+":
> +    type: object
> +
> +    properties:
> +      spi-rx-bus-width:
> +        enum: [1, 2, 4]

No need for this. It should already be taken care of by 
spi-peripheral-props.yaml

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    spi@1e620000 {
> +        reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "aspeed,ast2600-fmc";
> +        clocks = <&syscon ASPEED_CLK_AHB>;
> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;

Nitpick: Add a blank line here

> +        flash@0 {
> +                reg = < 0 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };

and here

> +        flash@1 {
> +                reg = < 1 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };

and here. Looks a bit nicer.

> +        flash@2 {
> +                reg = < 2 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea9d74b6236f..7d5f81dcd837 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3021,6 +3021,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>  F:	drivers/mmc/host/sdhci-of-aspeed*
>  
> +ASPEED SMC SPI DRIVER
> +M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +M:	Cédric Le Goater <clg@kaod.org>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> +
>  ASPEED VIDEO ENGINE DRIVER
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-media@vger.kernel.org
> -- 
> 2.34.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
