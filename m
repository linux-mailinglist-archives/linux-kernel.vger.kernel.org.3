Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC3489E75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiAJRf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:35:29 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42924 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiAJRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:35:28 -0500
Received: by mail-ot1-f48.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so9867350otr.9;
        Mon, 10 Jan 2022 09:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGSDbb7AuI5t4yuB5/UTAj6awe+qRFmKCnLO1wOEEv0=;
        b=Relv2Ng1ZW5vNu6J07hxrCBJNqIbPGRqVeuL0n1qCfIOSBl+HwJanvDSWOJLBqhpLz
         QEh1/1d6f1JOhR1LlaS1cdL+1txyFmyXEybZn6XvbAxjOMyasfCoAFXPUS8xKzTNTWgC
         6vg+egFH6P6v5OBZsuXQCQz5vPsmJ1p56HPL+IU/nV50SXJ1FZKdbRDL+Y1sJX5mtVuX
         5+TbA65zajqgToHkb+x4z9MQ/I+RolK5+JCz1pKPll3kgnFgtMEuFHfxZgo2mTxeX/9E
         nsarKf3OFObnftrbrU72mPcoa/5ihSScTnZmR8Ogf8p1oB7rRQnvp37IaP9i+/1haVyt
         QqQQ==
X-Gm-Message-State: AOAM532KBlSCn5oZ3wy/xrWP/eFpXX2kP1ZKuBORNVeruABNxCDQWHli
        ZHtW5uYMoNLdm2utakxVMA==
X-Google-Smtp-Source: ABdhPJxXuBR7XbQNEmHJiiuRBTu9ZsbHxp9B6cvGSpp8tIc37s5Gdp7fCyZN7KN54/RvOho095IumQ==
X-Received: by 2002:a9d:5541:: with SMTP id h1mr621550oti.115.1641836128080;
        Mon, 10 Jan 2022 09:35:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc7sm1471591oob.29.2022.01.10.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:35:27 -0800 (PST)
Received: (nullmailer pid 1149470 invoked by uid 1000);
        Mon, 10 Jan 2022 17:35:26 -0000
Date:   Mon, 10 Jan 2022 11:35:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH v5 2/2] devicetree: bindings SPI Add bindings doc for
 Sunplus SP7021
Message-ID: <YdxuXjhzsuMbrtRF@robh.at.kernel.org>
References: <cover.1641797029.git.lhjeff911@gmail.com>
 <7d25d1ee004dd668bc5cc122912c5dbeb6ff245f.1641797029.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d25d1ee004dd668bc5cc122912c5dbeb6ff245f.1641797029.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 02:47:22PM +0800, Li-hao Kuo wrote:
> Add devicetree bindings SPI Add bindings doc for Sunplus SP7021
> 
> Reviewed by Mr. Rob Herring <robh+dt@kernel.org>

Tag is wrong in multiple ways. It must be exactly what I gave:

Acked-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v5:
>  - no change.
>  - Reviewed by Mr. Rob Herring <robh+dt@kernel.org>
> 
>  .../bindings/spi/spi-sunplus-sp7021.yaml           | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> new file mode 100644
> index 0000000..096bfae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-sunplus-sp7021.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus sp7021 SPI controller
> +
> +allOf:
> +  - $ref: "spi-controller.yaml"
> +
> +maintainers:
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-spi
> +
> +  reg:
> +    items:
> +      - the SPI master registers
> +      - the SPI slave registers
> +
> +  reg-names:
> +    items:
> +      - const: master
> +      - const: slave
> +
> +  interrupt-names:
> +    items:
> +      - const: dma_w
> +      - const: mas_risc
> +      - const: slave_risc
> +
> +  interrupts:
> +    minItems: 3
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clocks-names
> +  - resets
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi@9C002D80 {
> +        compatible = "sunplus,sp7021-spi";
> +        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
> +        reg-names = "master", "slave";
> +        interrupt-parent = <&intc>;
> +        interrupt-names = "dma_w",
> +                          "mas_risc",
> +                          "slave_risc";
> +        interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
> +                     <146 IRQ_TYPE_LEVEL_HIGH>,
> +                     <145 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc SPI_COMBO_0>;
> +        resets = <&rstc RST_SPI_COMBO_0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pins_spi0>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1732a9e..2f487be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18247,6 +18247,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
>  M:	Li-hao Kuo <lhjeff911@gmail.com>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>  F:	drivers/spi/spi-sunplus-sp7021.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
