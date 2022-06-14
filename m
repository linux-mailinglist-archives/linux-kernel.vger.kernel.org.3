Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3D54BCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbiFNVcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357051AbiFNVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:32:17 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F35159E;
        Tue, 14 Jun 2022 14:32:17 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id h18so7537992ilj.7;
        Tue, 14 Jun 2022 14:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAWSxknMxGX+lY0dvgXNI7EytYZUhbO7QGP6wzKtlDA=;
        b=PVT5d87Ho3efHh28u8ameF8F4zecVLn3N1JLsaVSnKU/RmpDOzU/FG0dgzN1LLXkr8
         TU8jVPUXla/BMSZ+acu445X6EcmiNAP0wA2pDaN/qXKzBYnimebVzzxKMN3Lpli1cBua
         FncPnbT/uU2GKQjCjlR328pFzxARbfPabfA5YO9M9RHWV7OJgq31d5T4eay/+CzFWEjg
         4EZAkBHFx2O9PQ/oV33EWovM5fD8Xg66pRWDwr3gGnx07UyTV1q20DBqlMdc1m1FO05g
         ONpuOG2X4+KUy34QyIhIUVNPt2+QK3dFNw2U8toVRLBIB/ya+WLimSgjYdqmXZj6Lz1b
         99bg==
X-Gm-Message-State: AJIora/ryK76m8WvXdZRRfYJsa73qMx6iJ73aqYfCTESuV0RnKePfcQE
        rmu7G/UHfb4nNbiEZjJd7g==
X-Google-Smtp-Source: AGRyM1vOcu3sfkryYXXqwTbiJ63jPjdO1e/P/MZ52O46TCKMI1eK6Od0VH4ZduDiY/K9JrSBd8qJVA==
X-Received: by 2002:a05:6e02:1a03:b0:2d2:c409:b12e with SMTP id s3-20020a056e021a0300b002d2c409b12emr4062820ild.125.1655242336198;
        Tue, 14 Jun 2022 14:32:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v7-20020a023847000000b003316536ebc1sm5367228jae.73.2022.06.14.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:32:15 -0700 (PDT)
Received: (nullmailer pid 2684027 invoked by uid 1000);
        Tue, 14 Jun 2022 21:32:12 -0000
Date:   Tue, 14 Jun 2022 15:32:12 -0600
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
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
Message-ID: <20220614213212.GA2682090-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-8-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-8-brad@pensando.io>
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

On Mon, Jun 13, 2022 at 12:56:50PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document bindings for AMD Pensando Elba SR Reset Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../reset/amd,pensando-elbasr-reset.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> new file mode 100644
> index 000000000000..03bb86ebcfd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Reset Controller Device Tree Bindings
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +description: |
> +  AMD Pensando Elba SoC reset controller driver which supports a resource
> +  controller connected to the Elba SoC over a SPI bus.  The Elba reset
> +  controller must be defined as a child node of the Elba SPI bus
> +  chip-select 0 node.
> +
> +  See also:
> +  - dt-bindings/reset/amd,pensando-elba-reset.h
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    const: amd,pensando-elbasr-reset
> +
> +  reg:
> +    const: 0
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        spi@0 {

'spi' is reserved for SPI buses. I thought this was an MFD.

> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          rstc: reset-controller@0 {
> +            compatible = "amd,pensando-elbasr-reset";
> +            reg = <0>;
> +            #reset-cells = <1>;
> +          };
> +        };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
