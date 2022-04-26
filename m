Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D146510A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354958AbiDZUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbiDZUeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:34:15 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115DA2CE01;
        Tue, 26 Apr 2022 13:31:07 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id t6-20020a056830224600b00605491a5cd7so13831238otd.13;
        Tue, 26 Apr 2022 13:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wXjPKtNZTtKNBuOy/a9KKwId4T2O7MJMpPr2sIf2PbY=;
        b=U12n1SP9zIMrH0YG+APnlncHzWREQSEJH2W4zoFKtreAW5wpxisVc21qQTBX/cMS06
         iT4MXRr/Rw14oZ7dJnqdWvh64mqVnmhWcmeMgz3Z/LpKz1kKuUZ1Sd1tkiugBndoeCDL
         lg7XoHeZPigLciWAvpPL6uuRNIODb04/9ExnHVnVhnaRA4MoeVWYD0GIdLfqzTdYuma7
         HuaqHcUb7AihjH1TSy7d45cQzmZGIpL/5/EOW16v9wxtfadnrVvgqtvXn0JLMX+FCVXo
         TDwFP/dSRxOtSttxjGLw9oovnvEe44E9Z2NdZrHMHXXw781RtXV0MefDtPN5tACVa7NN
         6S7w==
X-Gm-Message-State: AOAM530E6VKI/xBcma7dcJhD4zGe9bpv3sOCFz3PVBIJ4XtLmzej+7Ie
        OkpEutzxaw6yfkz3a+bfXA==
X-Google-Smtp-Source: ABdhPJwYoKqpVwgCbbe2QW9WNBJvChNr9GEFiXHGCjmCGqjpyaWklBOqdUhhYuhF5A2I8esCGPeyHQ==
X-Received: by 2002:a05:6830:8d:b0:605:4b4f:cdf7 with SMTP id a13-20020a056830008d00b006054b4fcdf7mr9324809oto.45.1651005066307;
        Tue, 26 Apr 2022 13:31:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x21-20020a4a6215000000b0033993dc1d65sm6006125ooc.8.2022.04.26.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:31:05 -0700 (PDT)
Received: (nullmailer pid 2484879 invoked by uid 1000);
        Tue, 26 Apr 2022 20:31:05 -0000
Date:   Tue, 26 Apr 2022 15:31:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
Cc:     "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <YmhWic3rG8ERtCYY@robh.at.kernel.org>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-4-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419154555.24191-4-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 03:45:58PM +0000, Rokosov Dmitry Dmitrievich wrote:
> Introduce devicetree binding json-schema for MSA311 tri-axial,
> low-g accelerometer driver.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/iio/accel/memsensing,msa311.yaml      | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> new file mode 100644
> index 00000000..3e4660f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MEMSensing digital 3-Axis accelerometer
> +
> +maintainers:
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +description: |
> +  MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> +  sensitivity consumer applications. It has dynamical user selectable full
> +  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> +  with output data rates from 1Hz to 1000Hz.
> +  Datasheet can be found at following URL
> +  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> +
> +properties:
> +  compatible:
> +    const: memsensing,msa311
> +

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These apply to 'reg' in a child node, but you don't have child nodes so 
drop them.

> +
> +  reg:
> +    maxItems: 1
> +    description: I2C registers address
> +
> +  interrupts:
> +    maxItems: 1
> +    description: optional I2C int pin can be freely mapped to specific func
> +
> +  interrupt-names:
> +    const: irq
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        msa311: msa311@62 {

accelerometer@62 {

> +            compatible = "memsensing,msa311";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio_intc>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "irq";
> +            status = "okay";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c75be17..4227914 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12482,6 +12482,7 @@ MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
>  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
>  F:	drivers/iio/accel/msa311.c
>  
>  MEN A21 WATCHDOG DRIVER
> -- 
> 2.9.5
> 
