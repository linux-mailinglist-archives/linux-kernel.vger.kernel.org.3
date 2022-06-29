Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A855FA71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiF2IZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiF2IZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:25:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4353BFB8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:25:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q6so30929882eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i9rPYCNsKDfbWoYjqUgzaKgkcSgzPZ+JXR+K4Y0bDbs=;
        b=Zo88AD7bUVgCpN76GlEuoeeL2hj38HRRCNQM+SXS0A5LNZvRQ+zdzvNDvYbpu2upDk
         zy3Z47h8xeq4TEYwQC5AyrDzqmIVlFXkzWSF3Gda7eezX0qSxxznB2Bvbjc+L/DGcltd
         PSOhl7dXScnPHp7dWkFoH0rw3ADXwO1mH9qdUvrmhYsZg4NnDKEgbC5+ypnUntse2Ad1
         2LwmtrKdfYmtLEDbsebIb43WkqUFSq/Rf3ds8WK2Bja4rzXfs0qIVnBYE5njkdXg3zVa
         jhYrUZZLxUioIbxiP/DL4AqkP15hCh5g93LUq7I3OhkZFaLCckUTMzUq2Dl6coKtzeEb
         yf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i9rPYCNsKDfbWoYjqUgzaKgkcSgzPZ+JXR+K4Y0bDbs=;
        b=tofISxWGbSQJszZXx5X8JDA+DuPBvW913EFq2JvEUjG4c4zPVd4OZo9aRYNOTK89yj
         d+dzEwglgjGJczRmKL/abGAnWR2JtBChWaJpv49PPCkXPBeoSquCBv7atWchD+EP2n1X
         Huc9FwG6PR8xZImwNvE0ovlZkMRjhmeeaOwOA/RvlSU4KdOUT5pWJFlI1oR7MRj8M7QJ
         oZMXh6/6vb2PSaDPROy8m/aRZ9cinToFO0QATpEQt76013EJWTAZvQ2bQoszt9X5XeZg
         ojUeDmMhiSaaAW46BCUG5ASImnDxwiSHV7f7ksyO3kQA9ivWfqLSpSZRFfxI86G7GjuK
         viUw==
X-Gm-Message-State: AJIora+RaNonq00RkDDCYXyG9ZhpKmzaxbt/pG6ZZTq+VpK5QJL/zgIW
        ERnZxa2LOQUMhfr0MjKBHxYDoQ==
X-Google-Smtp-Source: AGRyM1sMVevj1qymQUk8wAipSgCB8oumS6WTh3j4eu48ndExxP2/mLSsQNe604hrk4l5BlZw35pEbA==
X-Received: by 2002:a17:906:6a20:b0:726:7675:e15a with SMTP id qw32-20020a1709066a2000b007267675e15amr2024534ejc.668.1656491128068;
        Wed, 29 Jun 2022 01:25:28 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906a08200b006fed93bf71fsm7519203ejy.18.2022.06.29.01.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:25:27 -0700 (PDT)
Message-ID: <bc6f42d9-f821-ad0c-85c8-b4a4d2146485@linaro.org>
Date:   Wed, 29 Jun 2022 10:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656469212-12717-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 04:20, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the documentation for Richtek rtq6056.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2
> - Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.
> 
> ---
>  .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> new file mode 100644
> index 00000000..fe45d8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
> +  interface, and the device provides full information for system by reading
> +  out the loading current and power.
> +
> +  The device monitors both of the drops across sense resistor and the BUS
> +  voltage, converts into the current in amperes, and power in watts through
> +  internal analog-to-digital converter ADC. The programmable calibration,
> +  adjustable conversion time, and averaging function are also built in for
> +  more design flexibility.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rtq6056
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: Shunt IN+/IN- sensing node resistor
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      rtq6056@40 {

This was not fixed.


Best regards,
Krzysztof
