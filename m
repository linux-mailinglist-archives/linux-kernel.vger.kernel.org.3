Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3534844EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiADPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:42:37 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33730 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiADPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:42:34 -0500
Received: by mail-oi1-f170.google.com with SMTP id w7so39264719oiw.0;
        Tue, 04 Jan 2022 07:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJ2M22MiC6qHtE01uvX9QDbyqekJ6ZeZPa/LG0UiJNs=;
        b=EgfNG7WEHh6yBy2mz7PHOfYMGTX7ix6TXxX4R08vTsTdW7vNg2yNM8UOXYnTO93MaC
         oV6zzfyU9MN+23ulCkEvXt2wHyaU9q7o/JDzKRnKJXZ/IPQSf/GyfOsfqrq596LgVTnv
         E4oUY4kRWCnUXAGj4TI3EnnvX0/5+BSX3xuMFMrRFWkvYG6vd8Ed+D608/sanuMILLe6
         ZdULsZI4gXKk1D+XEf0/j1tLCinuemuTMLQ+UHma679huD+Eio6N9Di4+yLg5pTph89q
         Jo8zGAIEWFHP65dMXuyP38K4ZSsDXC8FWrG+Nbu8g3jN9MTtBxMn47M+Gm8LMzJNRc+Q
         BJeA==
X-Gm-Message-State: AOAM530DKxZNKCYV9o1EMab1p3bUbiHI2NuZyXhrxJTxfPJJvsjIsGHS
        uDIqGzIV7BDjOjze92mUhw==
X-Google-Smtp-Source: ABdhPJzDLVAwUvkByszELJtXBV7b/HRkCQx6r7Ervxr45GWOAK69qShhw8QwUnKn7yf6JlY5Qz8nIg==
X-Received: by 2002:aca:dbd5:: with SMTP id s204mr40194703oig.41.1641310954075;
        Tue, 04 Jan 2022 07:42:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm9755640oih.58.2022.01.04.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:42:33 -0800 (PST)
Received: (nullmailer pid 893832 invoked by uid 1000);
        Tue, 04 Jan 2022 15:42:32 -0000
Date:   Tue, 4 Jan 2022 09:42:32 -0600
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
Subject: Re: [PATCH 2/5] dt-bindings: extcon: maxim,max77843: add MAX77843
 bindings
Message-ID: <YdRq6JVeeOVJj8ww@robh.at.kernel.org>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
 <20211229124631.21576-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229124631.21576-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 01:46:28PM +0100, Krzysztof Kozlowski wrote:
> Document the bindings for MAX77843 MUIC/extcon driver, based on
> Exynos5433 TM2 devicetree.  These are neither accurate nor finished
> bindings but at least allow parsing existing DTS files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/extcon/maxim,max77843.yaml       | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> new file mode 100644
> index 000000000000..1f15a6c700f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/maxim,max77843.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77843 MicroUSB and Companion Power Management IC Extcon
> +
> +maintainers:
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
> +  Integrated Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77843-muic
> +
> +  connector:
> +    $ref: ../connector/usb-connector.yaml#

/schemas/connector/...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Any connector to the data bus of this controller should be modelled using
> +      the OF graph bindings specified
> +    properties:
> +      port:
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - connector
> +
> +additionalProperties: false
> -- 
> 2.32.0
> 
> 
