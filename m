Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C415B0E74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIGUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:48:14 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B702C22B0;
        Wed,  7 Sep 2022 13:48:12 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11eab59db71so38942932fac.11;
        Wed, 07 Sep 2022 13:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OgZSfbLdmWOALRRb7JBf/hZJkZ02I3rXxvpAaPJjtss=;
        b=oM0ttpfDJOpVyNtrbPIsvZrt6pVSyzM2a9KeeBkz/T8NNRyp8dun+zYUtmcEOvkKhw
         aZQ1OmTFdkxuHYypCF62TF0rNyJLJ3KnLOEmsnmHDiMz3+4jGkmug3WgZPA+1GV/wQAK
         5k/xh6LosdATqcGsZU5Ots60x+RveKTUNY5Upm5CzbZ/kSRTZoOH7ochlXs50SEBn0J4
         4e/qqo9soXyUjZiAFm/6jV7V63g2j6BvHNVBOVnPRhvUxGt8gI67uY0Ge+3GQ1LdqVIv
         sVitX9A4GtZAHl4lOM6wRAqEHUlRFaQ8XodnMADL+OOZrc/ieIO65Erpbc8DLvh6l1ZM
         0W+w==
X-Gm-Message-State: ACgBeo0oTzfWpqklRuKDS55sQXPjZnkGqebgZ6vHb7zuJMG1Ca2yPyCq
        rDvOEWBDNlHR4gR4YivfGg==
X-Google-Smtp-Source: AA6agR6NS6tXDzOLHfWF+BuC8XbobxkJmCcNwfL3/mQLtSgFA6uV0lRUjSxT5Zi+7Jar40NgasRRDg==
X-Received: by 2002:a05:6870:a791:b0:10d:8606:c68b with SMTP id x17-20020a056870a79100b0010d8606c68bmr165876oao.234.1662583691370;
        Wed, 07 Sep 2022 13:48:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w8-20020a9d5388000000b00616d3ec6734sm7400219otg.53.2022.09.07.13.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:48:11 -0700 (PDT)
Received: (nullmailer pid 316597 invoked by uid 1000);
        Wed, 07 Sep 2022 20:48:10 -0000
Date:   Wed, 7 Sep 2022 15:48:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>, linux-crypto@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v1 3/4] dt-bindings: crypto: add documentation for Aspeed
 ACRY
Message-ID: <20220907204810.GA312863-robh@kernel.org>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-4-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902060012.3758637-4-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:00:11PM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> ECDSA/RSA ACRY Engines Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/crypto/aspeed,ast2600-acry.yaml  | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> new file mode 100644
> index 000000000000..192b40cd0a39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED ACRY ECDSA/RSA Hardware Accelerator Engines Device Tree Bindings

Drop ' Device Tree Bindings'

> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  The ACRY ECDSA/RSA engines is designed to accelerate the throughput
> +  of ECDSA/RSA signature and verification. Basically, ACRY can be
> +  divided into two independently engines - ECC Engine and RSA Engine.

independent

> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-acry
> +
> +  reg:
> +    items:
> +      - description: acry base address & size
> +      - description: acry sram base address & size
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    acry: crypto@1e6fa000 {
> +        compatible = "aspeed,ast2600-acry";
> +        reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
> +        interrupts = <160>;
> +        clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 832da6d77374..09ab1c3adbb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3214,7 +3214,7 @@ ASPEED CRYPTO DRIVER
>  M:	Neal Liu <neal_liu@aspeedtech.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> +F:	Documentation/devicetree/bindings/crypto/aspeed,*
>  F:	drivers/crypto/aspeed/
>  
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> -- 
> 2.25.1
> 
> 
