Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A984F9CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiDHS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDHS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:27:40 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36B195338;
        Fri,  8 Apr 2022 11:25:35 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r8so9673806oib.5;
        Fri, 08 Apr 2022 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQfJAKUgvClkkyeIs6rV92XnnDXDzlXjyxiEcCWwtPU=;
        b=JCOKm2epdNbLbzOfOW7NJN9KKvwqsWZZsu7qLW7p8f4aTU3Bp9Fh1FKhc3jJopzbcr
         IngDn/os6nhGWfKL4KINWjLHHHjeDhPOg8Pbo5DOghmezeS54X4Wl/ruAZ8q3Hb5tyZY
         Rply5WtKgCI6EBMEgRnD9oAWJPZalkadlyWU5TMLETd/2feGwpQWBUitM3plq8HylWKy
         JRprlYuLL3TuLDscHjEhtqXZ/1nUINCheB2Y8lwJfXyI+BLgUIm/cr0lUdBEWXmsll8M
         trMGcGExgyS0UzVQK/7UOYg0kpJ+AsiUQ8b/gbrgA84Kn9mmulQOYOaA5s2jeXFHplvw
         /WuQ==
X-Gm-Message-State: AOAM530LQlmLT6b+s2ZTdrEifvBzLK15lXFapp79JQHzdHzTaikEFkrl
        oHZGpVyXICcShS8alb52zQ==
X-Google-Smtp-Source: ABdhPJzlQwv14QkshbNP1Oi/GdkIrCLDU8BlOxyh9LjdZe+xlONWhQsKwHIiwkgNu3FuyPLiAB6bsA==
X-Received: by 2002:a05:6808:18a4:b0:2da:5b12:840a with SMTP id bi36-20020a05680818a400b002da5b12840amr511330oib.241.1649442335043;
        Fri, 08 Apr 2022 11:25:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 12-20020a05687012cc00b000de97cc1beesm9285382oam.43.2022.04.08.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:25:34 -0700 (PDT)
Received: (nullmailer pid 3815891 invoked by uid 1000);
        Fri, 08 Apr 2022 18:25:33 -0000
Date:   Fri, 8 Apr 2022 13:25:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH 09/14] dt-bindings: reset: snps,dw-reset: Convert to yaml
Message-ID: <YlB+Hd6IGdM8SD8X@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-9-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-9-p.zabel@pengutronix.de>
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

On Thu, Apr 07, 2022 at 05:43:33PM +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Synopsys DesignWare reset
> controller to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>
> ---
>  .../bindings/reset/snps,dw-reset.txt          | 30 -------------
>  .../bindings/reset/snps,dw-reset.yaml         | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> deleted file mode 100644
> index 0c241d4aae76..000000000000
> --- a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Synopsys DesignWare Reset controller
> -=======================================
> -
> -Please also refer to reset.txt in this directory for common reset
> -controller binding usage.
> -
> -Required properties:
> -
> -- compatible: should be one of the following.
> -	"snps,dw-high-reset" - for active high configuration
> -	"snps,dw-low-reset" - for active low configuration
> -
> -- reg: physical base address of the controller and length of memory mapped
> -	region.
> -
> -- #reset-cells: must be 1.
> -
> -example:
> -
> -	dw_rst_1: reset-controller@0000 {
> -		compatible = "snps,dw-high-reset";
> -		reg = <0x0000 0x4>;
> -		#reset-cells = <1>;
> -	};
> -
> -	dw_rst_2: reset-controller@1000 {
> -		compatible = "snps,dw-low-reset";
> -		reg = <0x1000 0x8>;
> -		#reset-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> new file mode 100644
> index 000000000000..f9b36ddc0ea1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/snps,dw-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare Reset controller
> +
> +maintainers:
> +  - Luis Oliveira <Luis.Oliveira@synopsys.com>

Mail bounces, needs a new one.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - snps,dw-high-reset # for active high configuration
> +      - snps,dw-low-reset  # for active low configuration
> +
> +  reg:
> +    maxItems: 1
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
> +    dw_rst_1: reset-controller@0000 {
> +        compatible = "snps,dw-high-reset";
> +        reg = <0x0000 0x4>;
> +        #reset-cells = <1>;
> +    };
> +
> +    dw_rst_2: reset-controller@1000 {
> +        compatible = "snps,dw-low-reset";
> +        reg = <0x1000 0x8>;
> +        #reset-cells = <1>;
> +    };
> +
> -- 
> 2.30.2
> 
> 
