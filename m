Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E95B0E97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIGUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiIGUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:50:39 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1D52DF0;
        Wed,  7 Sep 2022 13:50:35 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-128121a9851so3693783fac.13;
        Wed, 07 Sep 2022 13:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XpaMqgzQduMkVaFdjS8sZuoWxamJB73mDfIYxsQEGzM=;
        b=ZyClzmMkb0bG/2HGswZh6EglijHrXaZys50CRcQk4btN7fLAQQBqEkBeP6Wy2SSpZZ
         12ba5PXzk+YzS2jT8aP5T56aAx1/0elPW4YKuF5Z54heKxQg0nx2qnUCBayXjScSWOjx
         45W+c0j25Gk3GEpaWqBblPCpv7dl1L8+PPQcg6nQMSO8XULOg8eSaLafeVzC69tHRqnS
         tsuRb5ZEenEnlU7BpCmVB/rK5a7mJkdQI1e7ay2+BdBRERqxdvZNT+NSseWfd9EyFQ1G
         hkLk/xIpJjaLnA5KNS/ZDzhs2dTfml5+oLoC3plfEpKMw5s8Ue4a3p+U9/5nURDytZFE
         J9BA==
X-Gm-Message-State: ACgBeo3HRXrQhXFmTjL5p2sHUW9045UxAjbHaAnFyicbwitnhqEZqePV
        jOhYfLY4osaOUNNpf4TFqw==
X-Google-Smtp-Source: AA6agR4y0lnUCMGP5KqdujGB7vvUBgedIl3yykVGAFTXJQtN736AfICOgzZNv2SREifIEOY0hIcY6g==
X-Received: by 2002:a05:6871:96:b0:11d:ca1b:db19 with SMTP id u22-20020a056871009600b0011dca1bdb19mr180703oaa.74.1662583834165;
        Wed, 07 Sep 2022 13:50:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g12-20020a056870c14c00b0012644cc4feasm6349515oad.55.2022.09.07.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:50:33 -0700 (PDT)
Received: (nullmailer pid 320445 invoked by uid 1000);
        Wed, 07 Sep 2022 20:50:33 -0000
Date:   Wed, 7 Sep 2022 15:50:33 -0500
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
Subject: Re: [PATCH v1 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Message-ID: <20220907205033.GA317033-robh@kernel.org>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-5-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902060012.3758637-5-neal_liu@aspeedtech.com>
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

On Fri, Sep 02, 2022 at 02:00:12PM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> Advanced High-Performance Bus (AHB) Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> new file mode 100644
> index 000000000000..ca09eb531666
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device Tree Bindings
> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description: |
> +  Advanced High-performance Bus Controller (AHBC) supports plenty of mechanisms
> +  including a priority arbiter, an address decoder and a data multiplexer
> +  to control the overall operations of Advanced Highperformance

High-performance

> +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate with the
> +  related peripherals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-ahbc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ahbc: bus@1e600000 {
> +        compatible = "aspeed,ast2600-ahbc";
> +        reg = <0x1e600000 0x100>;

Shouldn't devices on the bus be child nodes? 

> +    };
> -- 
> 2.25.1
> 
> 
