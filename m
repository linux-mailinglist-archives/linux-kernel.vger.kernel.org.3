Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8957C0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGTXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:37:31 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FB49B42;
        Wed, 20 Jul 2022 16:37:30 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id i5so2783447ila.6;
        Wed, 20 Jul 2022 16:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vcm1I9F6UV+nxAjMuSeIzBn7nWIliBqrkqSbC4OfyaE=;
        b=Hulu2HDgfLVqLadeeDRJLnmXwyU+XVjqtIQ/BayDoLivlAxhORkKOweKMsOnqlsySy
         HntmdSPSEZHQ8luQW6kDUYLxrgE6wdVVn7DMBxj4iWGAXBxgJHZSP0ZPq5UZJfXPL5bj
         dVnCld+28usxBW+aA52sX9Q7RTEHI2fg8qGB04FkYSpmI0ePaSSAlQKkNUR8y4E8jEbP
         TkR2sLxBXYx3BDYUGv1ijA5Xv/lqNvLjVqWuyKuC/kIUEz7z1Yus/B5m1PFtUvSteasC
         DJAv+PyjJWLNBQGWBeBXHBG8MHw2uTp2gW3P9fW2TQY+JKCM1z6f/lkvpgc63f3lVhQk
         OfVg==
X-Gm-Message-State: AJIora9VOT1q0kDW/LIfUqR2p364mbC9c4lv2jl+It6cuxuiWic/y5zT
        tv82Ips8B5LGyhkTrtSTIkUU5nAncQ==
X-Google-Smtp-Source: AGRyM1uUZ6cX+VLuuemFeSA0ieh+ZbKT8Q+Y8t9HnKvOFst/xH04uKBAPb183viJoDECYVW0FkErag==
X-Received: by 2002:a05:6e02:180d:b0:2dc:2561:4b81 with SMTP id a13-20020a056e02180d00b002dc25614b81mr20466483ilv.149.1658360249560;
        Wed, 20 Jul 2022 16:37:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j71-20020a02634a000000b003417ba4f66asm119873jac.41.2022.07.20.16.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:37:29 -0700 (PDT)
Received: (nullmailer pid 4192799 invoked by uid 1000);
        Wed, 20 Jul 2022 23:37:25 -0000
Date:   Wed, 20 Jul 2022 17:37:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 03/14] regulator: dt-bindings: Add interrupts support
 to TPS65219 PMIC bindings
Message-ID: <20220720233725.GA4187584-robh@kernel.org>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-4-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-4-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:17:31AM +0200, Jerome Neanne wrote:
> Add interrupt properties in PMIC TPS65219 bindings

Why is this a separate patch? Please make your binding complete. Where 
do these interrupts go to?

> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  .../bindings/regulator/ti,tps65219.yaml       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> index 2c655432b889..6a60e62a313c 100644
> --- a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> @@ -25,6 +25,17 @@ properties:
>      description: Optional property that indicates that this device is
>        controlling system power.
>  
> +  interrupts:
> +    description: Short-circuit, over-current, under-voltage for regulators, PB interrupts.
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    description: Specifies the PIN numbers and Flags, as defined in
> +      include/dt-bindings/interrupt-controller/irq.h
> +    const: 1
> +
>  patternProperties:
>    "^buck[1-3]-supply$":
>      description: Input supply phandle of one regulator.
> @@ -71,12 +82,16 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
>    - regulators
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -92,6 +107,13 @@ examples:
>              ldo3-supply = <&vcc_3v3_sys>;
>              ldo4-supply = <&vcc_3v3_sys>;
>  
> +            pinctrl-0 = <&pmic_irq_pins_default>;
> +
> +            interrupt-parent = <&gic500>;
> +            interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +
>              regulators {
>                  buck1_reg: buck1 {
>                      regulator-name = "VDD_CORE";
> -- 
> 2.17.1
> 
> 
