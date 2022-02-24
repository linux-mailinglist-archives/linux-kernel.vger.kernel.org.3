Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41944C3639
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiBXTyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBXTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:54:53 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3825D6CB;
        Thu, 24 Feb 2022 11:54:23 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso2089791oti.3;
        Thu, 24 Feb 2022 11:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njTe0/+lEpH/gJZOgGCS3W9+oEq9MCorzign5DzP55k=;
        b=voynlO6jzLgUX6e0e6C7+AQsAxfGZOdD4CugloYXrmTaXA7Qdio+WA78sxUDS3BLHO
         Vt61mjnG+q24eDFlo+4CHsGDpsMcDIKJhumsKIteHs1ipH5kfsfmy/1MEDcztjs5mn7k
         lH1Z46/GQNA3bCCC6/MlP7wc3MzgTvbBwHVfJTpYWuJZZnxn7qmnEKuPfmdWFo94aALe
         fCenJym0V2z9bzaOkTbhn0oZL5wPOz2gbnGHdG7s7nJK4S0bYNI2sO8nvgIewQk7YxGG
         sCNYBBeot1oEQKUVOJvnfTlsF+oKqqvZDbtQwxuHV/6S4gD4Vlvr65Rxi/zKCi+UMF9u
         eErQ==
X-Gm-Message-State: AOAM531HGge0EWxDxCjJ+qfIuAVvyfCLGsMnUebgWV+fJu8FxrLBy2Oz
        yWHoiurxayJSWDA1H3RAAw==
X-Google-Smtp-Source: ABdhPJxkG/S5jS++HWcm7n39QBP/eF9cfi6idHK3/E231CmG31VfArqaJYNwWiM1J8/5Jeo6aeYzRA==
X-Received: by 2002:a4a:1506:0:b0:2da:ee84:9759 with SMTP id 6-20020a4a1506000000b002daee849759mr1531237oon.65.1645732461513;
        Thu, 24 Feb 2022 11:54:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u22-20020a056830119600b005afa6a85e22sm138443otq.45.2022.02.24.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:54:20 -0800 (PST)
Received: (nullmailer pid 3482595 invoked by uid 1000);
        Thu, 24 Feb 2022 19:54:18 -0000
Date:   Thu, 24 Feb 2022 13:54:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 10/13] dt-bindings: iio: imu: add documentation for Bosch
 BNO055 bindings
Message-ID: <YhfiamXM3GGm/ZYj@robh.at.kernel.org>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-11-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217162710.33615-11-andrea.merello@gmail.com>
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

On Thu, Feb 17, 2022 at 05:27:07PM +0100, Andrea Merello wrote:
> Introduce new documentation file for the Bosch BNO055 IMU
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

Your author and Sob emails need to match.

> ---
>  .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
> new file mode 100644
> index 000000000000..e0d06db161a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bno055.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BNO055
> +
> +maintainers:
> +  - Andrea Merello <andrea.merello@iit.it>
> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
> +  internal MCU for sensor fusion
> +  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bno055
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    serial {
> +      imu {
> +        compatible = "bosch,bno055";
> +        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
> +        clocks = <&imu_clk>;
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      imu@28 {
> +        compatible = "bosch,bno055";
> +        reg = <0x28>;
> +        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
> +        clocks = <&imu_clk>;
> +      };
> +    };
> -- 
> 2.17.1
> 
> 
