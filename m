Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE0484525
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiADPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:46:10 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44688 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiADPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:45:52 -0500
Received: by mail-oi1-f180.google.com with SMTP id be32so59964144oib.11;
        Tue, 04 Jan 2022 07:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bR+VnRjjUTwZhvl7ylzl1ud079Lz2W/GxJ0fPmozOqM=;
        b=4qFDW4fw00HfSlXbju0C9sJGUi/xpJxCBuitNWWKInhcwa8EFzBPPIINHLn/wkYiKb
         orft6N+kErigVutXqL4vQoQv7s55KAAxDfbiLrKNZ4Mk1zBR0ITZwEvjdwStqjwhiZVL
         n24gsCZGsYP/6KBUygxT5RBmwuzRFvp0YIvSpVBBRE5YywNBAC5+nGfQvgCtACKQxfEA
         Gx9llaOMv5iCy/RPqmQyLKuItjHDd11jZWZcDtADzOqylWE5s/fG90Gcw+NRLir6IFwU
         /dRNaIsErKReuCiM38GrNw/CsZcKCYy+q3oXZjep3BA+zJndSQsmR+o0Z8MutXodv0SL
         Azsw==
X-Gm-Message-State: AOAM530nJhHImJnpONSNsVgRNFdkHvTW+unY+4ph/Md9uZzcHWPyg0YB
        JTrfJ9rulD9OTjo1uv4xNQ==
X-Google-Smtp-Source: ABdhPJwmXBTcLbs7rkUj5WzWeJ2TvhW5C6c2JfagvvfUX27bxcz6n5/oI9/iWxKjToezekQheBMyRA==
X-Received: by 2002:aca:6746:: with SMTP id b6mr35772057oiy.167.1641311152109;
        Tue, 04 Jan 2022 07:45:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c17sm7062803otn.72.2022.01.04.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:45:51 -0800 (PST)
Received: (nullmailer pid 899058 invoked by uid 1000);
        Tue, 04 Jan 2022 15:45:50 -0000
Date:   Tue, 4 Jan 2022 09:45:50 -0600
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
Subject: Re: [PATCH 4/5] dt-bindings: mfd: maxim,max77843: add MAX77843
 bindings
Message-ID: <YdRrrsp1/UFYx5GN@robh.at.kernel.org>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
 <20211229124631.21576-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229124631.21576-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 01:46:30PM +0100, Krzysztof Kozlowski wrote:
> Document the bindings for MAX77843 MFD driver, based on Exynos5433 TM2
> devicetree.  These are neither accurate nor finished bindings but at
> least allow parsing existing DTS files.
> 
> The example DTS was copied from existing DTS
> (exynos5433-tm2-common.dtsi), so keep the license as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/maxim,max77843.yaml          | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
> new file mode 100644
> index 000000000000..7f3d74f254af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77843.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77843 MicroUSB and Companion Power Management IC
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
> +  Integrated Circuit (MUIC).
> +
> +  The Maxim MAX77843 is a MicroUSB and Companion Power Management IC which
> +  includes voltage current regulators, charger, fuel-gauge, haptic motor driver
> +  and MicroUSB management IC.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77843
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  extcon:
> +    $ref: ../extcon/maxim,max77843.yaml

/schemas/extcon/...

> +
> +  motor-driver:
> +    type: object
> +    properties:
> +      compatible:
> +        const: maxim,max77843-haptic
> +
> +      haptic-supply:
> +        description: Power supply to the haptic motor
> +
> +      pwms:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - haptic-supply
> +      - pwms
> +
> +  regulators:
> +    $ref: ../regulator/maxim,max77843.yaml

And here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
