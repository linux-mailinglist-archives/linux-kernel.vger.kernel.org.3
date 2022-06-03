Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652F53D2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbiFCUgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFCUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:36:17 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103E517C0;
        Fri,  3 Jun 2022 13:36:16 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f16a3e0529so12090255fac.2;
        Fri, 03 Jun 2022 13:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8dXdL7BwFo8fOPVE3Qzvm+mzLoifCJEnz35lqHi64E=;
        b=PJ/Mmwrox2W0lRrFqUPtBgIR8GedIeadwYpjcucLeg+qCnF8/dV5HyKRCk0cLjRLHc
         9bYqczlvkYV37Z++A6Qhma5jY+2wkY7/x0KX7OOGQOIMPGYwUHX2shVFrCQBYS3m+52S
         SchhnYYq5AZtEK1vfSnMafOQME53Di2x95l4PBBzSHC8e9jdJ10N+KjpjG9+er+7z7Ze
         5Zd2SufcrkBNowrbCpeV2fkFGTYCpOOewXybSuC724LkOmVnmhqNKxNzkkAZZxYzyuF/
         tBVrB+5Fgk7/xIOjpAYnywykAzwQufXvFyzwr47DYzY93nbFstQEMfwmgkVrJViBpUv/
         z2aA==
X-Gm-Message-State: AOAM5319CjwT7Gb4A4pweqOiP/esqf53pHzThbxQe62tQa/iECPWfm/k
        LjfdLpkJpfzUsiktYTt2IA==
X-Google-Smtp-Source: ABdhPJzpseHU7sSb07u+B5Ya0LCN1oRyfiyJrs+sClWCZh4TeAVul+fzfWT3jOhN+TzWl+Gt+k5C5g==
X-Received: by 2002:a05:6870:599:b0:f1:67f6:5860 with SMTP id m25-20020a056870059900b000f167f65860mr23878857oap.114.1654288576169;
        Fri, 03 Jun 2022 13:36:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870618700b000f1b1ff7b8bsm3944323oah.51.2022.06.03.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:36:15 -0700 (PDT)
Received: (nullmailer pid 864564 invoked by uid 1000);
        Fri, 03 Jun 2022 20:36:15 -0000
Date:   Fri, 3 Jun 2022 15:36:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Message-ID: <20220603203615.GA862209-robh@kernel.org>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
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

On Fri, Jun 03, 2022 at 05:48:01PM +0530, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1 in
> flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> index 221bd840b49e..6050482ad8ef 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -16,7 +16,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: atmel,sama5d2-flexcom
> +    enum:
> +      - atmel,sama5d2-flexcom
> +      - microchip,lan966x-flexcom
>  
>    reg:
>      maxItems: 1
> @@ -46,6 +48,21 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 3]
>  
> +  microchip,flx-shrd-pins:
> +    description: Specify the Flexcom shared pins to be used for flexcom
> +      chip-selects.
> +    $ref: /schemas/types.yaml#/definitions/uint32

The driver seems to think this is an array.

> +    minimum: 0
> +    maximum: 20
> +
> +  microchip,flx-cs-names:
> +    description: Chip select names. "cts", "rts" for flexcom USART "CTS" and
> +      "RTS" lines. "cs0", "cs1" for flexcom SPI chip-select lines.
> +    items:
> +      enum: [ cs0, cs1, cts, rts ]
> +    minItems: 1
> +    maxItems: 2
> +
>  patternProperties:
>    "^serial@[0-9a-f]+$":
>      description: See atmel-usart.txt for details of USART bindings.
> @@ -80,6 +97,8 @@ examples:
>            #size-cells = <1>;
>            ranges = <0x0 0xf8034000 0x800>;
>            atmel,flexcom-mode = <2>;
> +          microchip,flx-shrd-pins = <9>;
> +          microchip,flx-cs-names = "cs0";
>  
>            spi0: spi@400 {
>                  compatible = "atmel,at91rm9200-spi";
> -- 
> 2.17.1
> 
> 
