Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF11E59CAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiHVVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbiHVVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:41:30 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F0A53001;
        Mon, 22 Aug 2022 14:41:29 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id o204so6348074oia.12;
        Mon, 22 Aug 2022 14:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a8ZkZv18wdtWSYdgJx+7DhHUTIQUoytjuM08wGVVPds=;
        b=UUmiRcALlOiYZ+TqJ8bsTdpLhYm3NkcE3YdLyG17/6NSTMOnJGd8xMxVSsHaqIJ4/l
         yVineoBUmKe3rlQrwxFwy8YsGWAeRYVcZlMxjY8mpi48/xpgt8qwjnbTrGAJOSUqLVvX
         v8Vh+qdpn9VBR7nQXZ5myMp9dH/pLsJd/5+I1t1GEuisiQZQQJg/qGeJvT6VBm+w+mph
         buS5J9WGlp144fkEnH7P6oPhnXnikR+EVysnlF1nAnWJVByPmgRkvXuA9pDhz3O17pGK
         wUcne6ox0UAgJI5NHe6+ju/fWDuElYgbaagTAq3+ANETdNz1ERMDAM8E8mMRFouv4gU2
         q00A==
X-Gm-Message-State: ACgBeo3a/JxWILH295CI+DdSgOUyRLr0gZqz5skfwJsfLPWjPcgwNe+P
        6oIMnEjrnNf79C7383J6zw==
X-Google-Smtp-Source: AA6agR4rGeZX+4l/wxYxBBIhwpM1DvoUSWsE4kMWF9j8i7roDl78N4XYQvOTxwGkWsfNa0bFiu0jfA==
X-Received: by 2002:a05:6808:30a5:b0:342:feaa:d406 with SMTP id bl37-20020a05680830a500b00342feaad406mr129253oib.256.1661204488678;
        Mon, 22 Aug 2022 14:41:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c7-20020a056870c08700b00118927e0dacsm3212873oad.4.2022.08.22.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:41:28 -0700 (PDT)
Received: (nullmailer pid 903367 invoked by uid 1000);
        Mon, 22 Aug 2022 21:41:26 -0000
Date:   Mon, 22 Aug 2022 16:41:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lee.jones@linaro.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        dan.carpenter@oracle.com, grygorii.strashko@ti.com,
        rogerq@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Message-ID: <20220822214126.GA896562-robh@kernel.org>
References: <20220822065631.27933-1-s-vadapalli@ti.com>
 <20220822065631.27933-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822065631.27933-2-s-vadapalli@ti.com>
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

On Mon, Aug 22, 2022 at 12:26:30PM +0530, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       |  6 ++++
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 ++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 73cffc45e056..466724cb4157 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -54,6 +54,12 @@ patternProperties:
>      description:
>        Clock provider for TI EHRPWM nodes.
>  
> +  "phy@[0-9a-f]+$":
> +    type: object
> +    $ref: ../phy/ti,phy-gmii-sel.yaml

/schemas/phy/...

> +    description:
> +      This is the register to set phy mode through phy-gmii-sel driver.
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index ff8a6d9eb153..0ffb97f1a77c 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -53,12 +53,24 @@ properties:
>        - ti,am43xx-phy-gmii-sel
>        - ti,dm814-phy-gmii-sel
>        - ti,am654-phy-gmii-sel
> +      - ti,j7200-cpsw5g-phy-gmii-sel
>  
>    reg:
>      maxItems: 1
>  
>    '#phy-cells': true
>  
> +  ti,qsgmii-main-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Required only for QSGMII mode. Array to select the port for
> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
> +      main port with the rest of them being the QSGMII_SUB ports.
> +    items:
> +      minimum: 1
> +      maximum: 4
> +
>  allOf:
>    - if:
>        properties:
> @@ -73,6 +85,22 @@ allOf:
>          '#phy-cells':
>            const: 1
>            description: CPSW port number (starting from 1)
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,j7200-cpsw5g-phy-gmii-sel
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +          description: CPSW port number (starting from 1)
> +        ti,qsgmii-main-ports:
> +          maxItems: 1

If the array size can only ever be 1, then it's a uint32, not a 
uint32-array.

> +    else:
> +      properties:
> +        ti,qsgmii-main-ports: false
>    - if:
>        properties:
>          compatible:
> @@ -97,7 +125,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    phy_gmii_sel: phy-gmii-sel@650 {
> +    phy_gmii_sel: phy@650 {
>          compatible = "ti,am3352-phy-gmii-sel";
>          reg = <0x650 0x4>;
>          #phy-cells = <2>;
> -- 
> 2.25.1
> 
> 
