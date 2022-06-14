Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052554BCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353529AbiFNVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiFNVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:30:41 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A951307;
        Tue, 14 Jun 2022 14:30:40 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y79so10800256iof.2;
        Tue, 14 Jun 2022 14:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WEzh8uOJ4ejVdVVUTSHKNNS6sE3Yvu2T1kOBaTdaAxA=;
        b=G6Mb2Zz/16/Xbd7vH78xQSXqdlQbYBp/13ZZp0jjllDmyF83oRSBzkg5fqxmcGGXoW
         oVKBPVK+QDYC953EgqM7u65dxqaoME76wT7wlfFFq6nO6VcBOATjjr1M6XoDeM/BkUSh
         oEY8wgIwul2C2KD9jNwbJmFdskC+xbQitO5XRcy5awfIeAJ0ulvbXMzCPllx1+DogeSl
         PgEqAZedbjiAXHAZyOX6pRWvnkhbS4iLFcIG3NJ5Pib8GpXLhW9Pb8D4W2KWRFK1LdUu
         inL6GBKG2i99gLuLIG9cFuX8yJM1/VMTk4g8HNI2PNh/RFL21IZVga3uDcvvYIlTL3e7
         fpBg==
X-Gm-Message-State: AOAM531l8/82pgOAZyIk4nbDlJd7a02gFL8RWRvNc0c7AKnnKaX6tWiV
        JKi81oXScWVjZ0f+dqnZpg==
X-Google-Smtp-Source: ABdhPJw73T3RW6u/6ODSfkemfRspT9gvZl1tKry/kG4gXnYEbn7UBzl5xM772ykwvIUX7LlEzkmh2A==
X-Received: by 2002:a02:6642:0:b0:332:b49:2f6 with SMTP id l2-20020a026642000000b003320b4902f6mr4057580jaf.188.1655242239395;
        Tue, 14 Jun 2022 14:30:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id ce11-20020a0566381a8b00b0033158c4a312sm5363543jab.55.2022.06.14.14.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:30:39 -0700 (PDT)
Received: (nullmailer pid 2681877 invoked by uid 1000);
        Tue, 14 Jun 2022 21:30:36 -0000
Date:   Tue, 14 Jun 2022 15:30:36 -0600
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
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Message-ID: <20220614213036.GA2660642-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-7-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-7-brad@pensando.io>
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

On Mon, Jun 13, 2022 at 12:56:49PM -0700, Brad Larson wrote:
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
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> new file mode 100644
> index 000000000000..13356800b1cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Resource Controller bindings
> +
> +description: |
> +  AMD Pensando Elba SoC Resource Controller bindings attached to a SPI bus.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amd,pensando-elbasr
> +      - const: simple-mfd
> +
> +  spi-max-frequency:
> +    description: Maximum SPI frequency of the device in Hz.
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
> +    $ref: ../reset/amd,pensando-elbasr-reset.yaml

/schemas/reset/...

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        spi@0 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          spi-max-frequency = <12000000>;
> +
> +          rstc: reset-controller@0 {

Only one child does not make a MFD...

> +            compatible = "amd,pensando-elbasr-reset";
> +            reg = <0>;
> +            #reset-cells = <1>;
> +          };
> +        };
> +
> +        spi@1 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <1>;
> +          spi-max-frequency = <12000000>;

'simple-mfd' implies there are child nodes, but you have none. Is this 
complete?

> +        };
> +
> +        spi@2 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <2>;
> +          spi-max-frequency = <12000000>;
> +          interrupt-parent = <&porta>;
> +          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;

This one has interrupt but the others don't?

> +        };
> +
> +        spi@3 {
> +          compatible = "amd,pensando-elbasr", "simple-mfd";
> +          reg = <3>;
> +          spi-max-frequency = <12000000>;
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
