Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265BD477AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhLPRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:37:11 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44966 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhLPRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:37:10 -0500
Received: by mail-oi1-f171.google.com with SMTP id be32so37420111oib.11;
        Thu, 16 Dec 2021 09:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwmovSx8F4F/FPMo68cP1Yu86srqTZ7fb9r+GGBtWVw=;
        b=iTPqyklhEzyHqDhXwOQaOaTPsG84C2ncKYJqka0dOWkW0J7SamdtvfGB3FqJ68MV7a
         szWJG9c9Uoiv3T9c5nO1SkkIO2nUHCDfd8S4cHW3SI6v3obMLyUUhHbs/aF9jooKLTLe
         kYAsE3W+WEz/YBpJ9ULrftY96F8145A7ycd5OexznM64+i3gELbfw5g65IQgUnzT/BbX
         W7NVwzoutmkwUAk1Vo/MjcW6D7IBApwTCPRxQ7uiSWWKp1ACKBqd3b/NAwGmpG9z0sNL
         GUyAvFYmUSAyHs/lt6RrXO0gPrtrB2vpzAAl4gfuGtyJr2nowOqx6e6hoJf8Pl0OxlzM
         FRrQ==
X-Gm-Message-State: AOAM533E14nyKcevUn709K4aFlEybJ2JIsAbnm/Up+mUfT9+jWvdeRWp
        Pm4+obYJg44T83n6FEt5bw==
X-Google-Smtp-Source: ABdhPJxyUYs8Qt0YTgILbohB3Gz9g8HDapneUOhAFQmniGm0gkyMHdHihN5owpO9esDm4/JRocRSHQ==
X-Received: by 2002:aca:2b09:: with SMTP id i9mr5046685oik.14.1639676229588;
        Thu, 16 Dec 2021 09:37:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm1052437oij.16.2021.12.16.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:37:08 -0800 (PST)
Received: (nullmailer pid 443937 invoked by uid 1000);
        Thu, 16 Dec 2021 17:37:07 -0000
Date:   Thu, 16 Dec 2021 11:37:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     lakshmi.sowjanya.d@intel.com
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        tamal.saha@intel.com, pandith.n@intel.com,
        kenchappa.demakkanavar@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
Message-ID: <Ybt5QwJLAbpyauVD@robh.at.kernel.org>
References: <20211216150100.21171-1-lakshmi.sowjanya.d@intel.com>
 <20211216150100.21171-2-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216150100.21171-2-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:30:59PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add Device Tree bindings documentation and an entry in MAINTAINERS file
> for Intel Thunder Bay SoC's pin controller.

Seems Linus already applied this... You may need to send incremental 
changes.

> 
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  .../pinctrl/intel,pinctrl-thunderbay.yaml     | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml b/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
> new file mode 100644
> index 000000000000..528f0d8445dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/intel,pinctrl-thunderbay.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Thunder Bay pin controller Device Tree Bindings
> +
> +maintainers:
> +  - Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> +
> +description: |
> +  Intel Thunder Bay SoC integrates a pin controller which enables control
> +  of pin directions, input/output values and configuration
> +  for a total of 67 pins.
> +
> +properties:
> +  compatible:
> +    const: intel,thunderbay-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Specifies the interrupt lines to be used by the controller.
> +    maxItems: 2

Need to define what each one is.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +patternProperties:
> +  '^gpio@[0-9a-f]*$':
> +    type: object
> +
> +    description:
> +      Child nodes can be specified to contain pin configuration information,
> +      which can then be utilized by pinctrl client devices.
> +      The following properties are supported.
> +    $ref: pincfg-node.yaml#
> +
> +    properties:
> +      pins:
> +        description: |
> +          The name(s) of the pins to be configured in the child node.
> +          Supported pin names are "GPIO0" up to "GPIO66".

items:
  pattern: '^GPIO[1-6]?[0-9]$'

> +
> +      bias-disable: true
> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      drive-strength:
> +        description: Drive strength for the pad.
> +        enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
> +
> +      bias-bus-hold:
> +        type: boolean
> +
> +      input-schmitt-enable:
> +        type: boolean
> +
> +      slew-rate:
> +        description: GPIO slew rate control.
> +                      0 - Slow
> +                      1 - Fast

You need to use '|' if you want the formatting to be preserved.

> +        enum: [0, 1]
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    // Example 1
> +    pinctrl0: gpio@0 {

unit address is wrong

> +        compatible = "intel,thunderbay-pinctrl";
> +        reg = <0x600b0000 0x88>;
> +        gpio-controller;
> +        #gpio-cells = <0x2>;
> +        gpio-ranges = <&pinctrl0 0 0 67>;
> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;

How about showing a pin node.

> +    };
> +
> +    // Example 2
> +    pinctrl1: gpio@1 {

I don't see the point of the 2nd example. It is the same for purposes of 
examples.

> +        compatible = "intel,thunderbay-pinctrl";
> +        reg = <0x600c0000 0x88>;
> +        gpio-controller;
> +        #gpio-cells = <0x2>;
> +        gpio-ranges = <&pinctrl1 0 0 53>;
> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..db744ba259e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15127,6 +15127,11 @@ L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pinctrl/pinctrl-single.c
>  
> +PIN CONTROLLER - THUNDERBAY
> +M:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> +S:	Supported
> +F:	drivers/pinctrl/pinctrl-thunderbay.c
> +
>  PKTCDVD DRIVER
>  M:	linux-block@vger.kernel.org
>  S:	Orphan
> -- 
> 2.17.1
> 
> 
