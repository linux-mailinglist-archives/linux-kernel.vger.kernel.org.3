Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC465B0E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIGUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIGUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:38:58 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D606B2485;
        Wed,  7 Sep 2022 13:38:55 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1278624b7c4so20740830fac.5;
        Wed, 07 Sep 2022 13:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wj0FlR0iIjBwEoHz1x7C+h5eigEetu70PRRI7k8iZXI=;
        b=SZ9dXa4aSHjWvKvgvKqvjJOEnCsVWuYEvaxG2aWsvqQHW4yERexjGoKP/t7I2cQ4OS
         FjAoeY3X4IGJ0y6zkgaTonZF0soSGVKuPaqWV2t9dGVj61bZJlTk9/ArDTusenL0za5J
         rQ/WopMWlXfnoSqDReuo94X70ue7mMJUWctRXaD77CdN0Nauc+tdvv0PcrawXc4Yvr9X
         jMbiuaAiBU2PZpE5GGFPZY90HwoZvocuxUhsdwcFqW29u0l3A0FE1OZdlJxFs+b22N32
         IpHEaIDSvyngc0Y4NsWNYc3Fd++rQNvz4KktArX1lKsFU0LqPTJwGzntVWlCQBteLYNY
         V8Jg==
X-Gm-Message-State: ACgBeo3Q1ABsT6LwUY7Vi14hPI26z5O+Nwh2DzdOf90RhbzFWoDXTmNU
        2Y8yVQb48zNHOG85DSYMy/NVlvI9kA==
X-Google-Smtp-Source: AA6agR4/Q5cbO4dYciSTsb3yHN0PCRBBmZM4f/2Aw8gY/7KQS5uOU1UdBufXQ5dMUiyzRiI3S/G4dw==
X-Received: by 2002:a05:6870:7394:b0:126:6f7b:15a2 with SMTP id z20-20020a056870739400b001266f7b15a2mr121415oam.227.1662583134465;
        Wed, 07 Sep 2022 13:38:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk26-20020a056830369a00b00636c81d4109sm7572324otb.46.2022.09.07.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:38:53 -0700 (PDT)
Received: (nullmailer pid 299944 invoked by uid 1000);
        Wed, 07 Sep 2022 20:38:53 -0000
Date:   Wed, 7 Sep 2022 15:38:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v9 25/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Message-ID: <20220907203853.GA288174-robh@kernel.org>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
 <20220901125710.3733083-26-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901125710.3733083-26-clabbe@baylibre.com>
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

On Thu, Sep 01, 2022 at 12:57:02PM +0000, Corentin Labbe wrote:
> The latest addition to the rockchip crypto driver need to update the
> driver bindings.

This sounds like you changed the driver, so change the binding. That 
would be an ABI break. But it looks like you are adding support for new 
h/w, so say that. Bindings aren't about a driver.

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 79 +++++++++++++++++--
>  1 file changed, 71 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> index 8a219d439d02..b7870a4cbdbe 100644
> --- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> @@ -13,6 +13,8 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3288-crypto
> +      - rockchip,rk3328-crypto
> +      - rockchip,rk3399-crypto
>  
>    reg:
>      maxItems: 1
> @@ -21,21 +23,82 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: aclk
> -      - const: hclk
> -      - const: sclk
> -      - const: apb_pclk
> +    minItems: 3
> +    maxItems: 4
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    reset-names:
> -    items:
> -      - const: crypto-rst
> +    minItems: 1
> +    maxItems: 3
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3288-crypto
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          items:
> +            - const: aclk
> +            - const: hclk
> +            - const: sclk
> +            - const: apb_pclk
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: crypto-rst
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3328-crypto
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: hclk_master
> +            - const: hclk_slave
> +            - const: sclk

Do we really need new names? Was 'aclk' not the bus master clock?

If the clocks and resets aren't the same, then maybe these 2 new chips 
should be their own binding.

> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: crypto-rst
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3399-crypto
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: hclk_master
> +            - const: hclk_slave
> +            - const: sclk
> +        resets:
> +          minItems: 3
> +        reset-names:
> +          items:
> +            - const: rst_master
> +            - const: rst_slave

'rst_' is redundant, drop.

> +            - const: crypto-rst
>  
>  required:
>    - compatible
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
