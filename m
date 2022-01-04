Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90848448D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiADP3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:29:47 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33346 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiADP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:29:44 -0500
Received: by mail-ot1-f53.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso47791576otf.0;
        Tue, 04 Jan 2022 07:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWoBmQ/Xq0c3l218W4If/18Ogxhx6vVmLTRO9/MBVEk=;
        b=L/PLA48iCsM8zlcRJD+1cdugU7oIoGLkfCbF30P4Yp2V/G9FAn1jE3tMUBEvq0qtob
         k9fM6aZLnx2RdOr5p8ziK6MJ81BSfzOnpJWX9SL0+mMcTgcymhBO1tJk6cN16Etwryus
         fnbr9dBdZTc+g3jBSVD1OlMljhp6U1yJk4zbGX97WbYL2mX0ASpPYQi8QpBEbRGStb2V
         eemfZwkO6Xq+rbT/WKwNDM01iKnw1pAdwEC957gyl2qaVVfGNui6+k0vzamuCZ+tk5Ho
         I+9SOjDo2De61m2oOWEH+02VZEQS5KQtA13H5CZYrVQxYzmwGcY7uGvFaNemrP6QZntm
         sE+w==
X-Gm-Message-State: AOAM533zOAGDUOLM7LkRfiRhz4cOtpKtuZhi+LamgQJpI+6xJQVKGbUJ
        XfCmRSEgQXjk9JP1LLcqJw==
X-Google-Smtp-Source: ABdhPJys1YUFCxDtCeyfPt60STEmiPO3oYdgxBYsW9u1PDFxyC2a9WwVQUeMgPmRD4v/QTwGTyyrMg==
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr33368896otr.323.1641310183378;
        Tue, 04 Jan 2022 07:29:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n18sm7900663ooj.30.2022.01.04.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:29:42 -0800 (PST)
Received: (nullmailer pid 872552 invoked by uid 1000);
        Tue, 04 Jan 2022 15:29:41 -0000
Date:   Tue, 4 Jan 2022 09:29:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: dt-bindings: maxim,max77693: convert to
 dtschema
Message-ID: <YdRn5cvksYXK4icV@robh.at.kernel.org>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228163930.35524-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 05:39:29PM +0100, Krzysztof Kozlowski wrote:
> Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/maxim,max77693.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
> new file mode 100644
> index 000000000000..81242c8cd77c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max77693.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77693 MicroUSB and Companion Power Management IC regulators
> +
> +maintainers:
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
> +  Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
> +  additional information and example.
> +
> +patternProperties:
> +  "^ESAFEOUT[12]$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Safeout LDO regulator.
> +
> +    properties:
> +      regulator-min-microvolt: true
> +      regulator-max-microvolt: true

If you want to define which properties are valid from regulator.yaml, 
then you need to define all of them (regulator-name is missing), and use 
'additionalProperties: false'. Or you can just drop these. 

> +
> +    required:
> +      - regulator-name
> +
> +  "^CHARGER$":

Fixed string, not a pattern. Place under 'properties'.

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
> +additionalProperties: false
> -- 
> 2.32.0
> 
> 
