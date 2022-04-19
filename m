Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D35077AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbiDSSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356278AbiDSSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:14:30 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B33D4A9;
        Tue, 19 Apr 2022 11:11:45 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e5ca5c580fso8052935fac.3;
        Tue, 19 Apr 2022 11:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGUi+rSbzOtxj4QXaJGlWpTyr6tFNLRS2yQX/fpYpkU=;
        b=RcVOazEW8IRiK9ZXe+svXgWP2x3EXXZuJv/8U0FQlD7tVLOzw5OZF2H3TFTIt54n9C
         OQEfxhgxYYBBRhEpg8vvKuOlr9dwzZOwPgI/OGRz3eVuonlWAWhbh1jfGtdgkaU5nmJ5
         Dhk9gu4bqqezKOOoWpllA/CUBovb6xdiMvtcLZtaJWtcgpZXD3SZ/69OAqP72UFvdwH2
         +8mj7iPt597sevKf9nj2fNPs3SadYWqSNQJFHK0K0jHVhuJYzqgD7ikLoheX9AnOZthK
         Me66BLy+1tjyw988eitPD3urLja3vyuRBkbVFShc5I7ul4gl46aiMUEw0GcpAFzeX7Ll
         SMtQ==
X-Gm-Message-State: AOAM532nIGwyoegUwkYhditkHi2nUCVySHFrrMTu/OOE/HMRc2VZrxGm
        x7kA9eP5vkRFG+Y4NOD0NlG2KQx0aw==
X-Google-Smtp-Source: ABdhPJxp2DvXf0avkdpJT4byQ1E9gsEH/MA0HYo4nYnBAVTEThA5jdc/aNEtV5W5o7PCngdMqxoXsA==
X-Received: by 2002:a05:6870:b288:b0:e2:b735:56bb with SMTP id c8-20020a056870b28800b000e2b73556bbmr7235582oao.27.1650391905192;
        Tue, 19 Apr 2022 11:11:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hc3-20020a056870788300b000e5dfc7d6b9sm2457874oab.14.2022.04.19.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:11:44 -0700 (PDT)
Received: (nullmailer pid 3079240 invoked by uid 1000);
        Tue, 19 Apr 2022 18:11:44 -0000
Date:   Tue, 19 Apr 2022 13:11:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Message-ID: <Yl77YPzpjT0hLNRN@robh.at.kernel.org>
References: <20220414214337.311880-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414214337.311880-1-linus.walleij@linaro.org>
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

On Thu, Apr 14, 2022 at 11:43:37PM +0200, Linus Walleij wrote:
> The Broadcom BCM4751 family of (A-)GPS chips have been around for
> some years. The latest iteration BCM4753 is for example mounted
> on the Huawei HiKey970.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/gnss/brcm,bcm4751.yaml           | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
> new file mode 100644
> index 000000000000..f06a4acf21cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gnss/brcm,bcm4751.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM4751 family GNSS Receiver Device Tree Bindings
> +
> +maintainers:
> +  - Johan Hovold <johan@kernel.org>
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  Broadcom GPS chips can be used over the UART or I2C bus. The UART
> +  bus requires CTS/RTS support. The number of the capsule is more
> +  elaborate than the compatibles BCM4751 may be printed
> +  BCM4751IFBG for example.
> +
> +allOf:
> +  - $ref: gnss-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm4751
> +      - brcm,bcm4752
> +      - brcm,bcm4753
> +
> +  reg:
> +    description:
> +      The I2C Address, not required on UART buses.
> +
> +  vdd-auxin-supply:
> +    description:
> +      Main voltage supply, pin name VDD_AUXIN, typically connected
> +      directly to a battery such as LiIon 3.8V battery or a 2.6V supply.
> +
> +  vddio-supply:
> +    description:
> +      IO voltage supply, pin name VDDIO, typically 1.8V
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: An optional active low reset line, should be flagged with
> +      GPIO_ACTIVE_LOW.
> +
> +  enable-gpios:
> +    description: Enable GPIO line, connected to pins named REGPU or NSTANDBY.
> +      If the line is active low such as NSTANDBY, it should be tagged
> +      GPIO_ACTIVE_LOW.
> +
> +required:
> +  - compatible
> +  - enable-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    serial {
> +        gnss {
> +            compatible = "brcm,bcm4751";
> +            vdd-auxin-supply = <&vbat>;
> +            reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> +            enable-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +            current-speed = <38400>;
> +        };
> +    };
> -- 
> 2.35.1
> 
> 
