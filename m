Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701B4CB142
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiCBV1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiCBV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:27:31 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBABDE6E;
        Wed,  2 Mar 2022 13:26:48 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso3484806ooi.3;
        Wed, 02 Mar 2022 13:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hbPLIPVEhqYqHfs1Um9iAPDP4qWKQ+uSdm7/6sopBSs=;
        b=Mv+LaJYB+SA4Gbw/TvkgP6UXGUyDAZl7xfL9R5cyflND5dmC+AIgvmlm/sue5gq32N
         G9ibPWfiMfcS5ujeZ63a/xhF33/qb3AEGL71TzJ9xkXY1oT0GHsYyDkHINacAqBCLaa5
         4Hak2Pw6NQX0CEqdXEQvp5E7NJi0LeFfaUntYSZLm2uD2kwO0Yw5GlkvLKpP78fA4rf3
         JW8L1DORTSxKni4xRJvo5OXaOZYY/4jeVJ3UOK3ZgrRNZZCiQ/0jE0rr6ubEYN0l4vW1
         3qJcUTKojMK94z3xwG/rxocbzJbBbZmqJqDcQR9IAkp0bQD765NVKEfIXKiYg2BplKs0
         oLug==
X-Gm-Message-State: AOAM533SYjxdYNBVRtRqL7/8fKqz7mHYTIhgQGKujWHxbTQoVOYgbRfw
        1vEXYC3YcMVSc204wIkADA==
X-Google-Smtp-Source: ABdhPJze+wINl7VQoz5UIFxIOi5ofrkD+iYOPHxAw6NzR+bGkT+e8/nTZouORjU+OMOwKXIhDU/5pA==
X-Received: by 2002:a05:6870:1242:b0:d3:6168:3191 with SMTP id 2-20020a056870124200b000d361683191mr1471979oao.9.1646256407349;
        Wed, 02 Mar 2022 13:26:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p185-20020aca5bc2000000b002d97bda3871sm49303oib.54.2022.03.02.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:26:46 -0800 (PST)
Received: (nullmailer pid 79377 invoked by uid 1000);
        Wed, 02 Mar 2022 21:26:45 -0000
Date:   Wed, 2 Mar 2022 15:26:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Message-ID: <Yh/hFS2XW9SjK4Pl@robh.at.kernel.org>
References: <20220302173114.927476-1-clg@kaod.org>
 <20220302173114.927476-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302173114.927476-4-clg@kaod.org>
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

On Wed, Mar 02, 2022 at 06:31:07PM +0100, Cédric Le Goater wrote:
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 90 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> new file mode 100644
> index 000000000000..0289a4f52196
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -0,0 +1,90 @@
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
> +
> +    required:
> +      - reg

No need for required here, spi-controller.yaml already enforces that.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> +        flash@0 {
> +                reg = < 0 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };
> +        flash@1 {
> +                reg = < 1 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };
> +        flash@2 {
> +                reg = < 2 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                spi-rx-bus-width = <2>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4175103e928d..f5ab77548ef6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2925,6 +2925,15 @@ S:	Maintained
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
> 
