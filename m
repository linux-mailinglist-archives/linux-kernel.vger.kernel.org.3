Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56659862C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbiHROnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbiHROnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:43:35 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F886277;
        Thu, 18 Aug 2022 07:43:32 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso1379195pjd.1;
        Thu, 18 Aug 2022 07:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7IrASqplrkVpiIiYhE5AJVZ21/g9GJs8NehtB1NbKQo=;
        b=O1rX+4vyvcZ1+ChzNRfjvogwelOlPltwxrBtxH+m5zikEWlAoFoEfUhIXnF7XZFA7B
         g20deZBsLSDbxFSjn7MTh1GX1sWzPiwthgt6lSoqQUQyhU1F7RhSseXP6uT1p9fek5IT
         xT+nKp5EnkJarL6eMOV2ecvzJtR5Z8z91Xy3ElYPUgcxWbeS2ODQY/BYm9Tz+gB/9iYu
         I6XBAriZ96RNuBkcI7RSsK+y3YYXUmRkTk8XVeIO7MbK54X5QiSERfgOoislkzjolEHo
         29dFr8nKnee4h87j6tMK/2To8mShxAwLZHQLeEVbLv1oQob01D3yRMq3/lfBR8RUtkE6
         ZanA==
X-Gm-Message-State: ACgBeo083RBP6XqPr0Jl6rldDUip+fWJgxirQk2M+txSHazLB8kVPK/Q
        GGPgS8+RUmwp4mI/Jc9m6w==
X-Google-Smtp-Source: AA6agR4Ukpo8yvJAoeBSb8oFuIf6y3f7mzBWJQVcAch9qQg64UnhWee8W2i84xMGO7MLrU5vbciCvg==
X-Received: by 2002:a17:902:ecce:b0:16e:e6e9:69ba with SMTP id a14-20020a170902ecce00b0016ee6e969bamr3177308plh.97.1660833812118;
        Thu, 18 Aug 2022 07:43:32 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:80c2:7290:7acd:8d54:3db6:21d4])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902864800b0016f8e8032c4sm762868plt.129.2022.08.18.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:43:31 -0700 (PDT)
Received: (nullmailer pid 1837696 invoked by uid 1000);
        Thu, 18 Aug 2022 14:43:26 -0000
Date:   Thu, 18 Aug 2022 08:43:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Message-ID: <20220818144326.GA1829017-robh@kernel.org>
References: <20220816055848.111482-1-s-vadapalli@ti.com>
 <20220816055848.111482-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816055848.111482-2-s-vadapalli@ti.com>
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

On Tue, Aug 16, 2022 at 11:28:47AM +0530, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 27 ++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 73cffc45e056..527fd47b648b 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -54,6 +54,11 @@ patternProperties:
>      description:
>        Clock provider for TI EHRPWM nodes.
>  
> +  "phy@[0-9a-f]+$":
> +    type: object
> +    description:
> +      This is the register to set phy mode through phy-gmii-sel driver.

No properties for this node? A whole node for 1 register?

Or this node is ti,phy-gmii-sel.yaml? If so, add a $ref to it.

> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index ff8a6d9eb153..54da408d0360 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -53,12 +53,21 @@ properties:
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

Constraints? 

> +
>  allOf:
>    - if:
>        properties:
> @@ -73,6 +82,22 @@ allOf:
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

An array, but only 1 entry allowed?

> +          items:
> +            minimum: 1
> +            maximum: 4

Can't this be up above?

>    - if:
>        properties:
>          compatible:
> @@ -97,7 +122,7 @@ additionalProperties: false
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
