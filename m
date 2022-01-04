Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56EB4844FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiADPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:44:27 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43993 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiADPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:26 -0500
Received: by mail-ot1-f42.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so47784214otu.10;
        Tue, 04 Jan 2022 07:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88ToW1HxpPdWlQecnSmTubeVq6bgfhtdA0w+XJ2iNAI=;
        b=bFSxP3i1ZXPo6uSeUP6W0FYHfjiO4KjGeki2++UJ8VOQQLHcUj9WPtttOFxRhoPGn5
         947f1Zvug/i/M+JGoe5WLLsYHQeogYkHWcpnXo+zGoLcH/YM3ip1j/xEY6H0X4lqd9KW
         b5GUXrHv9NASiNh+ikUryItFFXz2wT55x78bAn0zc5V0WsPynAG7BvWWa06tIIvdWzsl
         3Yw7zcpBnhqtgqv35kJCnY6nIH56bftMvrLYPrbA/gQhK7X4o6g9yLlMYQpMs42tRdmr
         mfLi3kWUrbeEKkEVHlWyB1P8bX/IRHfotx+fcR2B4badpWUTu4i3slgbeLLPqYUd72mC
         VxFw==
X-Gm-Message-State: AOAM531vC4xDAenhENwDhQ/omEHtiYDbjSpYM3q1QPq+Edcpz3mEsgPU
        nHGVzvWPxS8UTYSaPNebtg==
X-Google-Smtp-Source: ABdhPJxTKO48T7iMJ0FASBAz6U0gvPANFg6vuYbCKuBo12BXIhtRIkIl/HxfUzDKoNRt0JgdLt1R4w==
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr36840685oth.233.1641311065950;
        Tue, 04 Jan 2022 07:44:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm7944529oog.43.2022.01.04.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:44:25 -0800 (PST)
Received: (nullmailer pid 896773 invoked by uid 1000);
        Tue, 04 Jan 2022 15:44:24 -0000
Date:   Tue, 4 Jan 2022 09:44:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 3/5] regulator: dt-bindings:  maxim,max77843: add
 MAX77843 bindings
Message-ID: <YdRrWGry08M+h2IZ@robh.at.kernel.org>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
 <20211229124631.21576-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229124631.21576-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 01:46:29PM +0100, Krzysztof Kozlowski wrote:
> Document the bindings for MAX77843 regulator driver.  The bindings are
> almost identical to MAX77693 bindings, except the actual names of
> regulators.

Same issues here as your other Maxim regulator conversions.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/maxim,max77843.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
> new file mode 100644
> index 000000000000..1ab58c756d7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max77843.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77843 MicroUSB and Companion Power Management IC regulators
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77843 MicroUSB Integrated
> +  Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77843-regulator
> +
> +patternProperties:
> +  "^SAFEOUT[12]$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Safeout LDO regulator.
> +
> +    properties:
> +      regulator-min-microvolt: true
> +      regulator-max-microvolt: true
> +
> +    required:
> +      - regulator-name
> +
> +  "^CHARGER$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Current regulator.
> +
> +    properties:
> +      regulator-min-microamp: true
> +      regulator-max-microamp: true
> +
> +    required:
> +      - regulator-name
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> -- 
> 2.32.0
> 
> 
