Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213BC59C191
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiHVOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiHVOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:25:50 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215432C12A;
        Mon, 22 Aug 2022 07:25:47 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11c896b879bso13055504fac.3;
        Mon, 22 Aug 2022 07:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=G07Tw8w3fntNDsB/UndMxA49LO4X204k9G0o50Lw9wE=;
        b=WC9XJSUmM3rIdvKbKxApVLRyXeFJvTjl4krDlhFTaIrhIJGO+j38sXtPqYm8UszgEA
         fWrL35ZUM6ygDlr+D96w+bzjRtqa5o8T5t2MZeqCXig12aVXCXEBLJvmVpc3bfGxCH0o
         57ipYs0ciRC6id2gG0nq8k87sYCoqubCIxGYKNBstAyvhWArpKplP7j0mqUm3ZpE0KsD
         5TDE2PJQuM9l9IdMTzmsFz08oL4OfwJkKwngH6h2ISuWRa1Q3UqO7IGrGvum2zHe9NFq
         TanJ+m/ylwWtFvN+J+w81bLMHisQj9vTri2kzJ+DlHrRv2UfMQqHUElB6FePL5Pny3RB
         TejA==
X-Gm-Message-State: ACgBeo0vXfc+HnyuSx08httA1tSreoOsB9p8QZwVuWK5Gw4rlOJdD87+
        IJfXj4W1LOkxSxxykK921w==
X-Google-Smtp-Source: AA6agR6a4Kk4I8rLJiBa/DQhIiR5/9u2/276l0A4HWxrkhm0udbG9IZa6W4vgzg+U5wH5Jv2z/yYtA==
X-Received: by 2002:a05:6870:ea83:b0:fe:365f:cb9d with SMTP id s3-20020a056870ea8300b000fe365fcb9dmr10123648oap.98.1661178345983;
        Mon, 22 Aug 2022 07:25:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id em29-20020a0568705b9d00b0010e81e27b99sm2962640oab.17.2022.08.22.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:25:45 -0700 (PDT)
Received: (nullmailer pid 3821949 invoked by uid 1000);
        Mon, 22 Aug 2022 14:25:44 -0000
Date:   Mon, 22 Aug 2022 09:25:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Message-ID: <20220822142544.GA3770388-robh@kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820195750.70861-7-brad@pensando.io>
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

On Sat, Aug 20, 2022 at 12:57:39PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.  The Elba SR is a Multi-function Device
> supporting device register access using CS0, smbus interface for
> FRU and board peripherals using CS1, dual Lattice I2C masters for
> transceiver management using CS2, and CS3 for flash access.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> new file mode 100644
> index 000000000000..ded347c3352c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Resource Controller bindings
> +
> +description: |
> +  AMD Pensando Elba SoC Resource Controller is a set of
> +  miscellaneous control/status registers accessed on CS0,
> +  a designware i2c master/slave on CS1, a Lattice rd1173
> +  dual i2c master on CS2, and flash on CS3.  The /dev interfaces
> +  created are /dev/pensr0.<CS>.  Hardware reset of the eMMC

/dev is a Linux thing and not relevant for the bindings.

> +  is implemented by a sub-device reset-controller which accesses
> +  a CS0 control register.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amd,pensando-elbasr
> +
> +  spi-max-frequency:
> +    description: Maximum SPI frequency of the device in Hz.

No need for generic descriptions of common properties.
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +patternProperties:
> +  '^reset-controller@[a-f0-9]+$':
> +    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        sysc: system-controller@0 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            spi-max-frequency = <12000000>;
> +
> +            rstc: reset-controller@0 {
> +                compatible = "amd,pensando-elbasr-reset";
> +                reg = <0>;

What does 0 represent here? A register address within 'elbasr' device?

Why do you need a child node for this? Are there other sub-devices and 
your binding is incomplete? Just put '#reset-cells' in the parent.

> +                #reset-cells = <1>;
> +            };
> +        };
> +
> +        i2c1: i2c@1 {
> +            compatible = "amd,pensando-elbasr";

You can't reuse the same compatible to represent different things.


> +            reg = <1>;
> +            spi-max-frequency = <12000000>;
> +        };
> +
> +        i2c2: i2c@2 {
> +            compatible = "amd,pensando-elbasr";

As this is a Lattice RD1173, I would expect a compatible based on that.


> +            reg = <2>;
> +            spi-max-frequency = <12000000>;
> +            interrupt-parent = <&porta>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +
> +        flash@3 {
> +            compatible = "amd,pensando-elbasr";

Isn't this a flash device?

> +            reg = <3>;
> +            spi-max-frequency = <12000000>;
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
