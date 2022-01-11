Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32648BA66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiAKWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:03:00 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34553 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiAKWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:02:59 -0500
Received: by mail-oi1-f180.google.com with SMTP id r131so997868oig.1;
        Tue, 11 Jan 2022 14:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzcggNXrl+/nvnyNoDfUICfrCjf9o6dGiDjvwXyMqlU=;
        b=ZHdHFKZdtX3TVcByzZ7iyNE8EDr1d9T2QnneDK46fS1chqSeCMyHmc8DRJ9varvfrw
         hDtvdDqIwey/9yNBbNfK/y24LGaRQtAxTPtyeoaRILfKz27ftwez0ZChY/lN11H9GFk+
         U1dghNJpUKo/XlfGNrcyw3P0IwJa2QAqFHySLy38+lvpm+917qIi2LZAzdGhsvbR7HYQ
         C4ZnZnvrBIALRkl/TiOyPJWTq7ap/RnmYfxfMAlfn5ePeg/Rfd4FM46H+2DoFvCpUqKa
         C9tUKKvhzO4pctTMXUuLEmYDY53U/zjM8vFX9urMn+X7Sn5DBrI1EDigQIJiZmZP9OCp
         4fQg==
X-Gm-Message-State: AOAM533sGu51+LhXZmTHx+s+UtdLaBO2wdWucw+fPdPbYhp98ammRNA4
        cEaRZ9QB9bGxFid54EBLz0FIh8bK5g==
X-Google-Smtp-Source: ABdhPJy9tSOjgmQ2GN+VKcOL/vf6bOsG38+XJvZa3GbKbRmrs5Uxp1HgGdX4SPbn93MDf9qW2pd3Cw==
X-Received: by 2002:a05:6808:138e:: with SMTP id c14mr3307430oiw.55.1641938578643;
        Tue, 11 Jan 2022 14:02:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1sm2250342oti.51.2022.01.11.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:02:58 -0800 (PST)
Received: (nullmailer pid 3582417 invoked by uid 1000);
        Tue, 11 Jan 2022 22:02:57 -0000
Date:   Tue, 11 Jan 2022 16:02:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: one-bit-adc-dac yaml
 documentation
Message-ID: <Yd3+kSr5xtL53jUQ@robh.at.kernel.org>
References: <20220111115919.14645-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111115919.14645-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 01:59:18PM +0200, Cristian Pop wrote:
> This adds device tree bindings for the one-bit-adc-dac.

I have no idea what a one-bit-adc-dac is. Please describe or provide a 
reference to what this h/w looks like.

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> V1->V2                                                                     

This belongs below the '---'

>  - I am aware of the recommendation of rename/move this driver. Should we  
>    consider "drivers/io/gpio.c"?                                           
>  - Add .yaml file                                                          
>  - Remove blank lines, remove unnecessary coma                             
>  - Remove macros for channels                                              
>  - Check if channel is input for write_raw                                 
>  - Use labels instead of extend_name                                       
>  - Fix channel indexing                                                    
>  - Use "sizeof(*channels)" in devm_kcalloc()                               
>  - Remove assignment: " indio_dev->dev.parent = &pdev->dev;"               
>  - Remove "platform_set_drvdata"                                           
>  - Remove "adi" from compatible string since is not ADI specific driver.
> ---
>  .../bindings/iio/addac/one-bit-adc-dac.yaml   | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> new file mode 100644
> index 000000000000..dbed0f3b1ca4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/one-bit-adc-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices one bit ADC DAC driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  One bit ADC DAC driver
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,one-bit-adc-dac
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  in-gpios:
> +    description: Input GPIOs
> +
> +  out-gpios:
> +    description: Output GPIOs

No constraints on how many GPIOs?

> +
> +required:
> +  - compatible
> +  - in-gpios
> +  - out-gpios
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADDAC.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: |
> +          The channel number.
> +
> +      label:
> +        description: |
> +          Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    one-bit-adc-dac@0 {
> +        compatible = "one-bit-adc-dac";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        in-gpios = <&gpio 17 0>, <&gpio 27 0>;
> +        out-gpios = <&gpio 23 0>, <&gpio 24 0>;
> +
> +        channel@0 {
> +          reg = <0>;

What does '0' correspond to?

> +          label = "i_17";

Why is this needed? 'label' is supposed to correspond to physical 
labelling of ports. IOW, for identification by humans looking at the 
device.

This all looks duplicated from information in in-gpios and out-gpios.

> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +          label = "i_27";
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +          label = "o_23";
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +          label = "o_24";
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
