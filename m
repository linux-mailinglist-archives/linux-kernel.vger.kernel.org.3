Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75E8495666
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbiATWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:38:21 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36467 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiATWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:38:18 -0500
Received: by mail-oi1-f170.google.com with SMTP id r138so11101637oie.3;
        Thu, 20 Jan 2022 14:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JdY5i/vcjbMJ0CM6vrTsc2SV9D4UAPr/paJ/LZ4quKU=;
        b=hGgdyJa1yMHhTz5S6JTDzJO6IEnMFP9U3/5udsMm3SSqOkWl7zB7VWTI7NoDg8k6eP
         RPoNksF25A9SqHzcAwDOLe4j9ZwXgqP9gcq8yAqTL3XAd4SC52LW/L6V6VBrZ1ZXK848
         4S6ljmX+DhZHldmPXsMkf3RebrbVDHsRlMvrjVB2TC3k9R8txBWhlvxa4kv9FEI7qFym
         51vgf04+Lq2gmu7ge/xxf0pAX5z/9MQwLolS7O+j4GSfXIUjp7xhH/3Mu3DcxDA3WD+7
         XOfBQPPZpMO2d6E+zKNQS7xYerzoOwWd1V7I87hh/zdC1p87NrckSc09XTpTZc/t8bNl
         sz3w==
X-Gm-Message-State: AOAM5324G+LR8MnOOGfeTSz1imkB1o8Ce9xedQ+7r/K+yt7CVQHsx/KB
        h2aEBVWOyGpoXMr1hregKQ==
X-Google-Smtp-Source: ABdhPJyl7JvGUpPUz9KEz1EogbtYVo2DcE2eLMLcKFmUHz9O/XaZ0ejP62Kqpwa0ZPL4skeK9sz7OQ==
X-Received: by 2002:a05:6808:1a23:: with SMTP id bk35mr9736209oib.52.1642718297796;
        Thu, 20 Jan 2022 14:38:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o12sm235957ooi.18.2022.01.20.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:38:17 -0800 (PST)
Received: (nullmailer pid 2067772 invoked by uid 1000);
        Thu, 20 Jan 2022 22:38:15 -0000
Date:   Thu, 20 Jan 2022 16:38:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v5 3/4] mfd: dt-bindings: google,cros-ec: reference
 Samsung SPI bindings
Message-ID: <YenkV2rgEXQJ6Bc5@robh.at.kernel.org>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
 <20220120175747.43403-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120175747.43403-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:57:46PM +0100, Krzysztof Kozlowski wrote:
> The ChromeOS Embedded Controller appears on boards with Samsung Exynos
> SoC, where Exynos SPI bindings expect controller-data node.  Reference
> newly added dtschema for this property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 58a1a9405228..66a995bbbbe9 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -31,7 +31,7 @@ properties:
>  
>    controller-data:
>      description:
> -      SPI controller data, see bindings/spi/spi-samsung.txt
> +      SPI controller data, see bindings/spi/samsung,spi-peripheral-props.yaml
>      type: object

We should be able to drop all of this if unevaluatedProperties is used.

>  
>    google,cros-ec-spi-pre-delay:
> @@ -148,18 +148,21 @@ patternProperties:
>  required:
>    - compatible
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - google,cros-ec-i2c
> -          - google,cros-ec-rpmsg
> -then:
> -  properties:
> -    google,cros-ec-spi-pre-delay: false
> -    google,cros-ec-spi-msg-delay: false
> -    spi-max-frequency: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - google,cros-ec-i2c
> +              - google,cros-ec-rpmsg
> +    then:
> +      properties:
> +        google,cros-ec-spi-pre-delay: false
> +        google,cros-ec-spi-msg-delay: false
> +        spi-max-frequency: false
> +
> +  - $ref: /schemas/spi/samsung,spi-peripheral-props.yaml

SPI device schemas should reference spi-peripheral-props.yaml only. 
spi-peripheral-props.yaml in turn should reference all the vendor 
specific peripheral property schemas.

You should be able to do just:

else:
  $ref: /schemas/spi/spi-peripheral-props.yaml

Can you please hold off sending anything referencing 
spi-peripheral-props.yaml until after the merge window. Otherwise, the 
checks fail (though I trust you've run validation).

Rob
