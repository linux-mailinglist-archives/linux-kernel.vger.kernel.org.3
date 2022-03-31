Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28344EE2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbiCaUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiCaUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:39:34 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C01DF855;
        Thu, 31 Mar 2022 13:37:46 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-dee0378ce7so548243fac.4;
        Thu, 31 Mar 2022 13:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aC+tCijUVPKI7nGBwd+nln2pgwufchUfIBD5KMT91Xk=;
        b=d4KTSNUx6UH6VhBWqz1cAyewX/8B2f8E3+obuX/B5oYNl3b5I9zlp8PKy8Cvf+8xiS
         k7j2ww1jL73U8rKEvjf3Tx+n4BT4x2QN8JBpjJrAv12cdD8a12QbQDOgissYwYTQVNQo
         KAfbsVkHRd5Zb/CdsUYLSWfcn5/QqwzdilS7T99410N+TSJyVnSr+DxwAtv2/cbO42eR
         torTaPdcYYsQ5f+hiLUKNLgJgrfa8aCJEh6lhDVwuhCkdXKX8STlo5IMks6YHuqHihDb
         KjEPZbHkhR9HcrHkjLJYRX7Cpn1u/h94TPuezISCHjq1ixyQEmtpWLeYBLImH0DTwHXh
         u0pw==
X-Gm-Message-State: AOAM5330aHL7YtEe3AhMF1aju1Hb1xpQDBoF0A2Bmm7HLbDIYxTlpSJc
        BAnxqnA3RGaPJPGpZmthag==
X-Google-Smtp-Source: ABdhPJxZPwZTST4T5zDJ7hQZzH4dKiGtYUkP7MRT9ZWl+bcyWzED9bnOP3hWhIPAXY/E4rf4oXLl5Q==
X-Received: by 2002:a05:6870:d1c7:b0:de:f3a2:c6f4 with SMTP id b7-20020a056870d1c700b000def3a2c6f4mr3571342oac.164.1648759065707;
        Thu, 31 Mar 2022 13:37:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q11-20020a4a330b000000b003289cbe97c6sm268863ooq.13.2022.03.31.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:37:45 -0700 (PDT)
Received: (nullmailer pid 1450145 invoked by uid 1000);
        Thu, 31 Mar 2022 20:37:44 -0000
Date:   Thu, 31 Mar 2022 15:37:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, cfli0@nuvoton.com
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller
 bindings
Message-ID: <YkYRGNr1o087/6MM@robh.at.kernel.org>
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-3-ychuang3@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331024256.14762-3-ychuang3@nuvoton.com>
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

On Thu, Mar 31, 2022 at 10:42:55AM +0800, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> new file mode 100644
> index 000000000000..bf5474b10420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Clock Control Module Binding
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description: |
> +  The MA35D1 clock controller generates clocks for the whole chip,
> +  including system clocks and all peripheral clocks.
> +
> +  See also:
> +    dt-bindings/clock/ma35d1-clk.h
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  assigned-clocks:
> +    maxItems: 4

These aren't usually in the clock controller...

> +
> +  assigned-clock-rates:
> +    maxItems: 4
> +
> +  clock-pll-mode:
> +    maxItems: 4

What's this? Not a standard property. Needs a type, description, and 
vendor prefix.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  # clock control module node:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    clk: clock-controller@40460200 {
> +        compatible = "nuvoton,ma35d1-clk";
> +        reg = <0x40460200 0x100>;
> +        #clock-cells = <1>;
> +    };
> +...
> -- 
> 2.30.2
> 
> 
