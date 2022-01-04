Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF84844C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiADPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:35:35 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38858 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiADPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:35:33 -0500
Received: by mail-oi1-f182.google.com with SMTP id s73so60026210oie.5;
        Tue, 04 Jan 2022 07:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Sl1wdkIsl6Ta/19UixjKojjWof/12N54aS+vBUZ0xc=;
        b=zyTDkDiWAzIE8PwCSzwAUhgUKgZ07VB9aFc1AITBY+7XkBKj3o+gEYUCoVu1uN42rs
         KJ6fn+H7VjudyguJ03IbzAyryLe8xgLwv+5Rf1/mNyRAESeiGXKNtAlMi8/faLxpuY9k
         /APKkL+1pEej6Fr7OpTOTSjxPFbmjOkiO9rZp8kBpRSNCC9VwHYYTcBKmmJgKXZXh5B4
         n1hjSIXbN1HV+/chPGSuirw8gHBFEAHcBoYhQoa+6U7NxYRm4lWSuvAlrKUF7SJH5p5b
         A0nv/StVBCyIMynXCTb2eL6RSn7BN4b/B/C8lH+W2zXhswizvWQ8FAEWv28nDyW0csRz
         R7SA==
X-Gm-Message-State: AOAM533FIEL4M31CxrIY6a+utqLM9PXDJ++vYBxCLIqOGhl5AHTYEApS
        AcKH4bADuYR0bPjC6fNn0g==
X-Google-Smtp-Source: ABdhPJy3731bmsVn395Zgfp+Qv6gBMK6U2osV7TqAWwszox9XQnqwhNjbfGVtivA0qvptS70MfJ14w==
X-Received: by 2002:a05:6808:16a3:: with SMTP id bb35mr40606254oib.72.1641310533059;
        Tue, 04 Jan 2022 07:35:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bk41sm9969116oib.31.2022.01.04.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:35:32 -0800 (PST)
Received: (nullmailer pid 882418 invoked by uid 1000);
        Tue, 04 Jan 2022 15:35:31 -0000
Date:   Tue, 4 Jan 2022 09:35:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mfd: maxim,max77802: Convert to dtschema
Message-ID: <YdRpQ2jIJ+vvg33q@robh.at.kernel.org>
References: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
 <20211228164305.35877-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228164305.35877-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 05:43:05PM +0100, Krzysztof Kozlowski wrote:
> Convert the MFD part of Maxim MAX77802 PMIC to DT schema format.  The
> example DTS was copied from existing DTS (exynos5800-peach-pi.dts), so
> keep the license as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/mfd/max77802.txt      |  25 ---
>  .../bindings/mfd/maxim,max77802.yaml          | 194 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 195 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77802.txt b/Documentation/devicetree/bindings/mfd/max77802.txt
> deleted file mode 100644
> index 09decac20d91..000000000000
> --- a/Documentation/devicetree/bindings/mfd/max77802.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Maxim MAX77802 multi-function device
> -
> -The Maxim MAX77802 is a Power Management IC (PMIC) that contains 10 high
> -efficiency Buck regulators, 32 Low-DropOut (LDO) regulators used to power
> -up application processors and peripherals, a 2-channel 32kHz clock outputs,
> -a Real-Time-Clock (RTC) and a I2C interface to program the individual
> -regulators, clocks outputs and the RTC.
> -
> -Bindings for the built-in 32k clock generator block and
> -regulators are defined in ../clk/maxim,max77802.txt and
> -../regulator/max77802.txt respectively.
> -
> -Required properties:
> -- compatible		: Must be "maxim,max77802"
> -- reg			: Specifies the I2C slave address of PMIC block.
> -- interrupts		: I2C device IRQ line connected to the main SoC.
> -
> -Example:
> -
> -	max77802: pmic@9 {
> -		compatible = "maxim,max77802";
> -		interrupt-parent = <&intc>;
> -		interrupts = <26 IRQ_TYPE_NONE>;
> -		reg = <0x09>;
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
> new file mode 100644
> index 000000000000..26f49fbace18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
> @@ -0,0 +1,194 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77802 Power Management IC
> +
> +maintainers:
> +  - Javier Martinez Canillas <javier@dowhile0.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77802 Power Management
> +  Integrated Circuit (PMIC).
> +
> +  The Maxim MAX77802 is a Power Management IC which includes voltage and
> +  current regulators (10 high efficiency Buck regulators and 32 Low-DropOut
> +  (LDO)), RTC and clock outputs.
> +
> +  The MAX77802 provides two 32.768khz clock outputs that can be controlled
> +  (gated/ungated) over I2C.  The clock IDs are defined as preprocessor macros
> +  in dt-bindings/clock/maxim,max77802.h.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77802
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: ../regulator/maxim,max77802.yaml

Use absolute path: /schemas/regulator/...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
