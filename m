Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12EF4F9EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiDHVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiDHVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:14:14 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372B187B92;
        Fri,  8 Apr 2022 14:12:10 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id r8so10099752oib.5;
        Fri, 08 Apr 2022 14:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQV88Wncy+sFJVshappGK0lQZjUfJDBJIGxPr0CLJDM=;
        b=EvzNumx+2+ci8gPLHLmrfusRorbNEvY9m/vi4bIvrHfqN6dVU9YYnXRk+gf5Zmc5pA
         mkAdtKChnTBzVuGxJpz53nKZVaub24VdEuiYz6vHEZw/orkYW/3ViTlhh84/cgDQfyho
         x3P7W9mc9BHjhmEvA8DgtFqd3xVbAVt8PgXmPd6CArz3oYn6Lk2xQTNm2RxRCwl1szbH
         6qgcb4AhqU2/sqE1i0iVe7RGhPSvSw3gVMThktA9zndfps2YPM/LZMoMWuCx86J2YGhg
         y8ylvnCqrCkl3/nYHm6EZobJAndx+yke0RPUKUWj/IQPd5AMAUxu0x0LJctyPwIx5tkY
         TM7Q==
X-Gm-Message-State: AOAM5322xy0z0ttlKvpxXphqKr07TVpnbEjjaquxYRztWnmh94Ip3Zhs
        6BiMjzPZWLv0O2L5fYmZ8Tj/pugw6A==
X-Google-Smtp-Source: ABdhPJwgayvKCJkT67GWWcOJ8t7e7vNECjz++q6KwPK6vYwLsJuYnrkPQrsymj/1ROQAtop7cTV/zQ==
X-Received: by 2002:a05:6808:1281:b0:2ec:eac7:1d0d with SMTP id a1-20020a056808128100b002eceac71d0dmr781840oiw.169.1649452329113;
        Fri, 08 Apr 2022 14:12:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j145-20020acaeb97000000b002d9f37166c1sm8991041oih.17.2022.04.08.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:12:08 -0700 (PDT)
Received: (nullmailer pid 4074368 invoked by uid 1000);
        Fri, 08 Apr 2022 21:12:08 -0000
Date:   Fri, 8 Apr 2022 16:12:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH 10/14] dt-bindings: reset: snps,hsdk-reset: Convert to
 yaml
Message-ID: <YlClKKHnTwsNUayj@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-10-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-10-p.zabel@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:43:34PM +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Synopsys HSDK reset controller
> to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../bindings/reset/snps,hsdk-reset.txt        | 28 -----------
>  .../bindings/reset/snps,hsdk-reset.yaml       | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
> deleted file mode 100644
> index 830069b1c37c..000000000000
> --- a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Binding for the Synopsys HSDK reset controller
> -
> -This binding uses the common reset binding[1].
> -
> -[1] Documentation/devicetree/bindings/reset/reset.txt
> -
> -Required properties:
> -- compatible: should be "snps,hsdk-reset".
> -- reg: should always contain 2 pairs address - length: first for reset
> -  configuration register and second for corresponding SW reset and status bits
> -  register.
> -- #reset-cells: from common reset binding; Should always be set to 1.
> -
> -Example:
> -	reset: reset@880 {
> -		compatible = "snps,hsdk-reset";
> -		#reset-cells = <1>;
> -		reg = <0x8A0 0x4>, <0xFF0 0x4>;
> -	};
> -
> -Specifying reset lines connected to IP modules:
> -	ethernet@.... {
> -		....
> -		resets = <&reset HSDK_V1_ETH_RESET>;
> -		....
> -	};
> -
> -The index could be found in <dt-bindings/reset/snps,hsdk-reset.h>
> diff --git a/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml
> new file mode 100644
> index 000000000000..a7cb5580c070
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/snps,hsdk-reset.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/snps,hsdk-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys HSDK reset controller
> +
> +maintainers:
> +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +
> +properties:
> +  compatible:
> +    const: snps,hsdk-reset
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Should always contain 2 pairs address - length: first for reset
> +      configuration register and second for corresponding SW reset and status
> +      bits register.

items:
  - description: reset configuration register
  - description: corresponding SW reset and status bits register


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
> +    #include <dt-bindings/reset/snps,hsdk-reset.h>
> +
> +    reset: reset@880 {
> +        compatible = "snps,hsdk-reset";
> +        #reset-cells = <1>;
> +        reg = <0x8A0 0x4>, <0xFF0 0x4>;
> +    };
> +
> +    // Specifying reset lines connected to IP modules:
> +    ethernet {
> +        resets = <&reset HSDK_ETH_RESET>;
> +    };

No need to show the consumer side in every provider. Please drop.

Rob
