Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA84FFEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiDMTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiDMTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:17:08 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A471EED;
        Wed, 13 Apr 2022 12:12:55 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id s1so3083095oie.6;
        Wed, 13 Apr 2022 12:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kx6X/hwl6jdNnDDQ52TpbqWRgcBx9sA8wo37ZQdrUfI=;
        b=3jqA7Q1Aw628EWZsp5nvvptiujbAQkTGyWpTBcKd+hd5rIOPx1osrGktE0PEc0CI7t
         FZ6fwWG+wUNokzdsYREOV2a0l935i9ig3DbV4KCK08jc+Hh+SwGP3cut/wgmqAEncTH/
         1QJ5i2Ajf6jt2tEwe8ES1o/SgFWqKzfRa60S+uoHOFaZQeaKyXnEHOcztr1fPu1C7Ial
         q9BXfEA/pRZvbyieDOeFQZYbtNaDSWIAWjxTe7Mo8b+WXlrXfXCTYhXaJ3NL+wK1O1Ur
         2214fu4aBgw8WmliUokI2ZH/iYygxWlDAvXLLe73bIZV7Q4fydjXrwyydjuIHfse8ths
         UJkg==
X-Gm-Message-State: AOAM530SIEFaU7Qlzp0WdbPtxfbRMpEDU1gE/Bs7rPtoxKunj0B8Db6U
        lSI39YyZC5XSJZtHl6qCGf1Gbw/NRg==
X-Google-Smtp-Source: ABdhPJyOvJoKJyw2OaRPAhYndbNCWeL4sOOOM3ybEpVJ8dkuOflu8i3rs3akLnt7N7KhtGIzJb6eYw==
X-Received: by 2002:a05:6808:e83:b0:2f7:3e70:fdc9 with SMTP id k3-20020a0568080e8300b002f73e70fdc9mr140601oil.172.1649877174137;
        Wed, 13 Apr 2022 12:12:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm13780659oia.27.2022.04.13.12.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:12:53 -0700 (PDT)
Received: (nullmailer pid 3665385 invoked by uid 1000);
        Wed, 13 Apr 2022 19:12:52 -0000
Date:   Wed, 13 Apr 2022 14:12:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dt-binding
Message-ID: <YlcgtLmXwc2s2+oJ@robh.at.kernel.org>
References: <20220407082148.571442-1-gengcixi@gmail.com>
 <20220407082148.571442-2-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407082148.571442-2-gengcixi@gmail.com>
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

On Thu, Apr 07, 2022 at 04:21:42PM +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> sprd,ump9620-adc is one variant of sc27xx series, add ump9620
> description and sample in dt-bindings.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 57 +++++++++++++++++--
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> index caa3ee0b4b8c..0d0f317b75c5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - sprd,sc2723-adc
>        - sprd,sc2730-adc
>        - sprd,sc2731-adc
> +      - sprd,ump9620-adc
>  
>    reg:
>      maxItems: 1
> @@ -34,12 +35,39 @@ properties:
>      maxItems: 1
>  
>    nvmem-cells:
> -    maxItems: 2
> +    description: nvmem-cells.
>  
>    nvmem-cell-names:
> -    items:
> -      - const: big_scale_calib
> -      - const: small_scale_calib
> +    description: Names for each nvmem-cells specified.

These descriptions of common properties are redundant. Just use 'true' 
for the property values.

> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +            - sprd,ump9620-adc

Use 'const'

> +then:
> +  properties:
> +    nvmem-cells:
> +      maxItems: 2
> +    nvmem-cell-names:
> +      items:
> +        - const: big_scale_calib
> +        - const: small_scale_calib
> +
> +else:
> +  properties:
> +    nvmem-cells:
> +      maxItems: 6
> +    nvmem-cell-names:
> +      items:
> +        - const: big_scale_calib1
> +        - const: big_scale_calib2
> +        - const: small_scale_calib1
> +        - const: small_scale_calib2
> +        - const: vbat_det_cal1
> +        - const: vbat_det_cal2
>  
>  required:
>    - compatible
> @@ -69,4 +97,25 @@ examples:
>              nvmem-cell-names = "big_scale_calib", "small_scale_calib";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@504 {
> +            compatible = "sprd,ump9620-adc";
> +            reg = <0x504>;
> +            interrupt-parent = <&ump9620_pmic>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            #io-channel-cells = <1>;
> +            hwlocks = <&hwlock 4>;
> +            nvmem-cells = <&adc_bcal1>, <&adc_bcal2>,
> +                          <&adc_scal1>, <&adc_scal2>,
> +                          <&vbat_det_cal1>, <&vbat_det_cal2>;
> +            nvmem-cell-names = "big_scale_calib1", "big_scale_calib2",
> +                               "small_scale_calib1", "small_scale_calib2",
> +                               "vbat_det_cal1", "vbat_det_cal2";
> +        };
> +    };
>  ...
> -- 
> 2.25.1
> 
> 
