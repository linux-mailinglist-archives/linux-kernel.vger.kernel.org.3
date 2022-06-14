Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26354BCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351271AbiFNVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFNVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:22:19 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8E4ECE9;
        Tue, 14 Jun 2022 14:22:19 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id r3so7513580ilt.8;
        Tue, 14 Jun 2022 14:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJ7oqbtybKBkB0Ag7vT1yQWpqQMSkI/6sxH61W3XByo=;
        b=qWAh3oZL6fO23HzULFZxzWv98Bs0NNUk0P6AlKHPd1E5Nf9Ct9H38i4zGuOL4JHemo
         SzA83+v1NM+3cy1snexaUEu7kzuYEx+pktpEWrhyghv6LE7/LMUZQ9vI9EY79vwa24l9
         B//xzlPERYH36dXLkyM3GeDB7+6XU3xW+upwACyrG2WHDWRNJwCJI/C8768/xHmxBSCM
         AOUEQ7oxo8s57+Reie/F5oZqnMYNxAiKomQAqKoLJOnhGT1WSKm6w4avmhQDr6l6UbdR
         adXVSTG0kn1XlXaLr0zXMd41+sMuoUEnAq0+7g5rTl4x8MvJaI9r/Yk2M4M/mKGRk5uc
         1D0Q==
X-Gm-Message-State: AJIora8wy2hRb6O6cLuTzUk85wAGJEZeLle6L5J5fRL6NR2YjMw4R2LK
        2g3r7bIADgba/ooru9HGNA==
X-Google-Smtp-Source: AGRyM1tUB8HljEWpwIqWOb25UGejqXfhJnyZMVhHQl4YipIIOeQY0g4ivzM9vJEOIjZeesIVSR7o7g==
X-Received: by 2002:a05:6e02:1607:b0:2d1:e622:3f0a with SMTP id t7-20020a056e02160700b002d1e6223f0amr4184323ilu.287.1655241738198;
        Tue, 14 Jun 2022 14:22:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5-20020a92d0c5000000b002d5c572f410sm5906255ila.63.2022.06.14.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:22:17 -0700 (PDT)
Received: (nullmailer pid 2648115 invoked by uid 1000);
        Tue, 14 Jun 2022 21:22:15 -0000
Date:   Tue, 14 Jun 2022 15:22:15 -0600
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
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
Message-ID: <20220614212215.GA2627610-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-3-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-3-brad@pensando.io>
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

On Mon, Jun 13, 2022 at 12:56:45PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 4207fed62dfe..35bc4cf6f214 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -13,10 +13,24 @@ maintainers:
>  allOf:
>    - $ref: mmc-controller.yaml
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Cadence host controller registers
> +            - description: Byte-lane control register
> +          minItems: 2

This doesn't work. The if/then is additional constraints on the main 
section which says there is only 1 register region. The main section 
needs the above, but with 'minItems: 1'. Then the if/then should be:

if:
  properties:
    compatible:
      const: amd,pensando-elba-sd4hc
then:
  properties:
    reg:
      minItems: 2
else:
  properties:
    reg:
      maxItems: 1


> +
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
> -- 
> 2.17.1
> 
> 
