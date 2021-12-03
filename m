Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F2467E47
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382894AbhLCTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbhLCTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:39:28 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710DCC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:36:03 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id ay21so7405505uab.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSx+w54klGuKdyt/Un3Z3/lbOI5wwX527aHiYsNckNM=;
        b=g1iuVtVfLev2/JnJbWWAnGGWRo55ELpwERWRCixjW9lUjdOplstty8WTG4TdggNkmk
         FAiHTaXQ/hk9R8J3foJaRGFsYhqVviIR2e6wkU/CvE47Oyk8bPyQsRJVuQKBiHUF5E8J
         Yl4N9R0dWrjS8k6PjcWaFXUJnFPJ/Z4V0/aHBvBFZElMZlIyf/rjVGSia6bdeGT+94zO
         ikEw8P0COhI2yD5r0Yyek1POIqV2xkwJijBxxHRQDLFqs9mAVZ+SBo6LwHGVqghwSZs+
         wgLUUhIJWJjU3gRiNsxit5FWKqlu/+JEeFcF0e/fAg4XGTKxlpkhnoSVjfe3cn1n8iXV
         jKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSx+w54klGuKdyt/Un3Z3/lbOI5wwX527aHiYsNckNM=;
        b=s5FZLXEm4fhxbWrltBLnmhaqWYk5ounFcHYmrUDEnzYzzVUMhEpAI49o/C/kb6LxwP
         pAjyOLq60pPTPb1wmRcFLmmYOLv2dbb83nmnytfqiyffzbLudZ0diYwUDgfBLUS99+p3
         dBDLOHvRfTSHug2S3uvTRowLvG4oRZmseONn20v6xODwj1VM5C3+m2vSIEfCfhrkGg9H
         XstnCdrK3g1Eu2qFTiu/DhlsUXws9GkfA+f/u+SRpGuSeEEEg/jfsvsx3XN9NcxdAMI/
         a8QYBfIlM1QCYqdGR/VKmEurQaCzvsl7JF2kI8E99i/f7s4BEyjHQuIhZ1mgJuIPOri+
         Eokg==
X-Gm-Message-State: AOAM533A6zGD+Fmf0WZjCoPsebr52hMUeFOaH6SY8cUYAoSdXpRsNq4S
        6YxjF1InCnQE6/gTdk7qYucKmVmByjByEhkjRO0ClQ==
X-Google-Smtp-Source: ABdhPJwK5xgq7p4wgh3VKjYDgxwNIVxLXmzl2/lBJJF3NnAK1jP9sXAl8rZi5X4mJ+y8WZzQmAD7cj8QOBL12BBfl4g=
X-Received: by 2002:a67:d31c:: with SMTP id a28mr23447616vsj.20.1638560162395;
 Fri, 03 Dec 2021 11:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
In-Reply-To: <YaZ8BpUaaC+sJYqx@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 3 Dec 2021 21:35:51 +0200
Message-ID: <CAPLW+4kGGk+umKTVRPNM7R=GaUQa31Uid=K+9ofq8w2mqzGAEA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Rob Herring <robh@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 21:31, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 01:13:21PM +0200, Sam Protsenko wrote:
> > Add constants for choosing USIv2 configuration mode in device tree.
> > Those are further used in USI driver to figure out which value to write
> > into SW_CONF register. Also document USIv2 IP-core bindings.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> >   - Combined dt-bindings doc and dt-bindings header patches
> >   - Added i2c node to example in bindings doc
> >   - Added mentioning of shared internal circuits
> >   - Added USI_V2_NONE value to bindings header
> >
> >  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> >  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> >  2 files changed, 152 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> >  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> >
> > diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > new file mode 100644
> > index 000000000000..a822bc62b3cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > @@ -0,0 +1,135 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung's Exynos USI (Universal Serial Interface) binding
> > +
> > +maintainers:
> > +  - Sam Protsenko <semen.protsenko@linaro.org>
> > +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > +
> > +description: |
> > +  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
> > +  USI shares almost all internal circuits within each protocol, so only one
> > +  protocol can be chosen at a time. USI is modeled as a node with zero or more
> > +  child nodes, each representing a serial sub-node device. The mode setting
> > +  selects which particular function will be used.
> > +
> > +  Refer to next bindings documentation for information on protocol subnodes that
> > +  can exist under USI node:
> > +
> > +  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> > +  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^usi@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    const: samsung,exynos-usi-v2
>
> Use SoC based compatibles.
>

In this particular case, I'd really prefer to have it like this. Most
likely we'll only have USIv1 and USIv1 in the end, and I think that
would be more clear to have USI version in compatible, rather than SoC
name. Please let me know if you have a strong opinion on this one --
if so I'll re-send.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus (APB) clock
> > +      - description: Operating clock for UART/SPI/I2C protocol
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: ipclk
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  samsung,sysreg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Should be phandle/offset pair. The phandle to System Register syscon node
> > +      (for the same domain where this USI controller resides) and the offset
> > +      of SW_CONF register for this USI controller.
> > +
> > +  samsung,mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Selects USI function (which serial protocol to use). Refer to
> > +      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
>
> This seems to be redundant. Just check which child is enabled.
>

I think it's not that easy. Soon we'll have USIv1 support added, and
that has some weird configurations, like having dual I2C mode (two
child I2C nodes must be enabled) and UART+I2C mode, etc. Looks like it
might take some not very elegant logic to figure out which exactly
mode value should be written in SW_CONF register in that way, it's
much easier to just specify mode in USI node. Also, that reflects
hardware better: we actually write that specified mode to SW_CONF
register. Also, later we might want to be able to switch that mode via
SysFS, e.g. for testing purposes. Current design seems to be better
suited for some things like that.

Please let me know if you have a strong opinion on this one, or it's
ok to leave it as is.

All other comments are addressed and will be present in v3. Thanks for
the review!

> > +
> > +  samsung,clkreq-on:
> > +    type: boolean
> > +    description:
> > +      Enable this property if underlying protocol requires the clock to be
> > +      continuously provided without automatic gating. As suggested by SoC
> > +      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
> > +      multi-master mode. Usually this property is needed if USI mode is set
> > +      to "UART".
> > +
> > +      This property is optional.
> > +
> > +patternProperties:
> > +  # All other properties should be child nodes
> > +  "^.*@[0-9a-f]+$":
>
> Only 'serial', 'spi', or 'i2c' are valid.
>
> > +    type: object
> > +    description: Child node describing underlying USI serial protocol
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - ranges
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - samsung,sysreg
> > +  - samsung,mode
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/soc/samsung,exynos-usi.h>
> > +
> > +    usi0: usi@138200c0 {
> > +        compatible = "samsung,exynos-usi-v2";
> > +        reg = <0x138200c0 0x20>;
> > +        samsung,sysreg = <&sysreg_peri 0x1010>;
> > +        samsung,mode = <USI_V2_UART>;
> > +        samsung,clkreq-on; /* needed for UART mode */
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> > +        clock-names = "pclk", "ipclk";
> > +        status = "disabled";
>
> Why are you disabling your example? Remove status.
>
> > +
> > +        serial_0: serial@13820000 {
> > +            compatible = "samsung,exynos850-uart";
> > +            reg = <0x13820000 0xc0>;
> > +            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> > +            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> > +            clock-names = "uart", "clk_uart_baud0";
> > +            status = "disabled";
> > +        };
> > +
> > +        hsi2c_0: i2c@13820000 {
> > +            compatible = "samsung,exynosautov9-hsi2c";
> > +            reg = <0x13820000 0xc0>;
> > +            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
> > +            clock-names = "hsi2c_pclk", "hsi2c";
> > +            status = "disabled";
> > +        };
> > +    };
> > diff --git a/include/dt-bindings/soc/samsung,exynos-usi.h b/include/dt-bindings/soc/samsung,exynos-usi.h
> > new file mode 100644
> > index 000000000000..a01af169d249
> > --- /dev/null
> > +++ b/include/dt-bindings/soc/samsung,exynos-usi.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (c) 2021 Linaro Ltd.
> > + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> > + *
> > + * Device Tree bindings for Samsung Exynos USI (Universal Serial Interface).
> > + */
> > +
> > +#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
> > +#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
> > +
> > +#define USI_V2_NONE          0
> > +#define USI_V2_UART          1
> > +#define USI_V2_SPI           2
> > +#define USI_V2_I2C           3
> > +
> > +#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H */
> > --
> > 2.30.2
> >
> >
