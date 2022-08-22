Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74EF59CADA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiHVV3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbiHVV3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:29:34 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBE751429;
        Mon, 22 Aug 2022 14:29:29 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id o204so6310942oia.12;
        Mon, 22 Aug 2022 14:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=U+Rr29AXEYccQWYkX+t5Iha+zsBj8Q3I4pac4LCK5Y8=;
        b=yIOx5lIUryrfCpcYPOHsFON+JSwaOx3w2UMVdIIXvoVwXD8EYC48Iz2W1dZMGBcesx
         EebyL3UZcplMhZlQ/xw4oHEcj6wwxadgq/Njv66s2vOcWb3ch0zzFHBjymCm7AboqMZH
         kZnsyGVgsj+rz73QyGZUCQ9RUe/jMvUsrpMukygcmBOQaei2NNgz02sjm6CbGnwYFlhO
         I+LaK2s6+gfpf6swnV2DUKV97wjym+jOCUrD39V+I5ygZRuuqhwkQuP55+7JRp20/pzT
         R7luJOg+moNKyl1QzruYL+nUY+P0nTpAokxDFp7vZlHamhJDMPWvkXMF6SPqtuQvc03j
         EXHQ==
X-Gm-Message-State: ACgBeo3y/3dktz3D4+OItE+0xjUl0jR/DnIWKFpMduUUqrHZZk6DvvUf
        qfLQff1rFqKMsEpG0YxKZA==
X-Google-Smtp-Source: AA6agR6n3q9+mEzrOa/HRvfhdArGtZr8Bl6RlRtiue3E0gXOAI7nsVHW0tDveDz+jwF83EkojLd5MA==
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id c14-20020a056808138e00b0034513d1fd66mr122078oiw.96.1661203769012;
        Mon, 22 Aug 2022 14:29:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a30-20020a056870d61e00b0010490c6b552sm3174798oaq.35.2022.08.22.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:29:28 -0700 (PDT)
Received: (nullmailer pid 883486 invoked by uid 1000);
        Mon, 22 Aug 2022 21:29:27 -0000
Date:   Mon, 22 Aug 2022 16:29:27 -0500
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
Subject: Re: [PATCH v6 02/17] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Message-ID: <20220822212927.GA882083-robh@kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-3-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820195750.70861-3-brad@pensando.io>
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

On Sat, Aug 20, 2022 at 12:57:35PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 4207fed62dfe..964b610eeef2 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -17,12 +17,14 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    interrupts:
>      maxItems: 1
> @@ -118,6 +120,15 @@ required:
>    - interrupts
>    - clocks
>  
> +if:
> +  properties:
> +    compatible:
> +      const: amd,pensando-elba-sd4hc
> +then:
> +  properties:
> +    reg:
> +      minItems: 2

else:
  properties:
    reg:
      maxItems: 1

> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.17.1
> 
> 
