Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56626463EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbhK3Tel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:34:41 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46997 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhK3Tej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:34:39 -0500
Received: by mail-oi1-f172.google.com with SMTP id s139so43280578oie.13;
        Tue, 30 Nov 2021 11:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+ALV3456RFLnzPiVC55XFMs5lI3BFoE+g2oCCtbN/4=;
        b=bZxGYDXAOAITSRjb4elY5yQ8/uRQM9IPdzgCBh0dKadvl35ON7bFfaQGWCelEpGzhY
         XRgllgfwkLWJti7fI4DT2k8Brnu0GDF+uSDCBZ36erpHqGTo1/XzZVznRIIK4c6SU94b
         LjbrMuSB7SEKW3dXAZFDRLfASonvW3H+EaNvrwTUf/Ie1m5umbMBpiXDQ5DXj1ibroe/
         a3L/2Nxr5kP8LA8OV84rBfvPTYN1NSeFnPtzEnJnACb6nE3zUHw81xgGmAovE+azVXsH
         luGny4Nf92C1MeF1SOYaFO0eKPr9232vFtuuMvMHg8C+gprmN0mAPCR7lao2tPNEc1Cg
         aPeQ==
X-Gm-Message-State: AOAM532CgHq+yGfrNKoLKZHiZuK/CNMtDfmJ9AQLrD4K7oPk7oDrbXxd
        6j0N8OGORezmgqcTPuGcoA==
X-Google-Smtp-Source: ABdhPJzy7vYNemrRDecOuNjNMbobzh4+LHNyE3YBe5yqxxQEPk+fRIsWPCX3Lk2L9Z398lHmhCoB2Q==
X-Received: by 2002:aca:6105:: with SMTP id v5mr1060970oib.20.1638300679795;
        Tue, 30 Nov 2021 11:31:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u28sm3256192otj.57.2021.11.30.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:31:19 -0800 (PST)
Received: (nullmailer pid 2866115 invoked by uid 1000);
        Tue, 30 Nov 2021 19:31:18 -0000
Date:   Tue, 30 Nov 2021 13:31:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI
 bindings
Message-ID: <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130111325.29328-2-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
> Add constants for choosing USIv2 configuration mode in device tree.
> Those are further used in USI driver to figure out which value to write
> into SW_CONF register. Also document USIv2 IP-core bindings.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Combined dt-bindings doc and dt-bindings header patches
>   - Added i2c node to example in bindings doc
>   - Added mentioning of shared internal circuits
>   - Added USI_V2_NONE value to bindings header
> 
>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> new file mode 100644
> index 000000000000..a822bc62b3cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung's Exynos USI (Universal Serial Interface) binding
> +
> +maintainers:
> +  - Sam Protsenko <semen.protsenko@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
> +  USI shares almost all internal circuits within each protocol, so only one
> +  protocol can be chosen at a time. USI is modeled as a node with zero or more
> +  child nodes, each representing a serial sub-node device. The mode setting
> +  selects which particular function will be used.
> +
> +  Refer to next bindings documentation for information on protocol subnodes that
> +  can exist under USI node:
> +
> +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> +
> +properties:
> +  $nodename:
> +    pattern: "^usi@[0-9a-f]+$"
> +
> +  compatible:
> +    const: samsung,exynos-usi-v2

Use SoC based compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus (APB) clock
> +      - description: Operating clock for UART/SPI/I2C protocol
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: ipclk
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  samsung,sysreg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Should be phandle/offset pair. The phandle to System Register syscon node
> +      (for the same domain where this USI controller resides) and the offset
> +      of SW_CONF register for this USI controller.
> +
> +  samsung,mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Selects USI function (which serial protocol to use). Refer to
> +      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.

This seems to be redundant. Just check which child is enabled.

> +
> +  samsung,clkreq-on:
> +    type: boolean
> +    description:
> +      Enable this property if underlying protocol requires the clock to be
> +      continuously provided without automatic gating. As suggested by SoC
> +      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
> +      multi-master mode. Usually this property is needed if USI mode is set
> +      to "UART".
> +
> +      This property is optional.
> +
> +patternProperties:
> +  # All other properties should be child nodes
> +  "^.*@[0-9a-f]+$":

Only 'serial', 'spi', or 'i2c' are valid.

> +    type: object
> +    description: Child node describing underlying USI serial protocol
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +  - samsung,sysreg
> +  - samsung,mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/samsung,exynos-usi.h>
> +
> +    usi0: usi@138200c0 {
> +        compatible = "samsung,exynos-usi-v2";
> +        reg = <0x138200c0 0x20>;
> +        samsung,sysreg = <&sysreg_peri 0x1010>;
> +        samsung,mode = <USI_V2_UART>;
> +        samsung,clkreq-on; /* needed for UART mode */
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> +        clock-names = "pclk", "ipclk";
> +        status = "disabled";

Why are you disabling your example? Remove status.

> +
> +        serial_0: serial@13820000 {
> +            compatible = "samsung,exynos850-uart";
> +            reg = <0x13820000 0xc0>;
> +            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> +            clock-names = "uart", "clk_uart_baud0";
> +            status = "disabled";
> +        };
> +
> +        hsi2c_0: i2c@13820000 {
> +            compatible = "samsung,exynosautov9-hsi2c";
> +            reg = <0x13820000 0xc0>;
> +            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> +            clock-names = "hsi2c_pclk", "hsi2c";
> +            status = "disabled";
> +        };
> +    };
> diff --git a/include/dt-bindings/soc/samsung,exynos-usi.h b/include/dt-bindings/soc/samsung,exynos-usi.h
> new file mode 100644
> index 000000000000..a01af169d249
> --- /dev/null
> +++ b/include/dt-bindings/soc/samsung,exynos-usi.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2021 Linaro Ltd.
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Device Tree bindings for Samsung Exynos USI (Universal Serial Interface).
> + */
> +
> +#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
> +#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
> +
> +#define USI_V2_NONE		0
> +#define USI_V2_UART		1
> +#define USI_V2_SPI		2
> +#define USI_V2_I2C		3
> +
> +#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H */
> -- 
> 2.30.2
> 
> 
