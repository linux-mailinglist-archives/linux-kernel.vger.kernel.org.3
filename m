Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7758875B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiHCG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiHCG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:29:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224D3AB2B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:29:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t22so25035105lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h2xnvN3rkMZcaAStopByq5FB4LTsZ0396BsEMoxv4z4=;
        b=ovnV16wU7LJzAaYtctJMZD4GwKkovlVo2PAUjCPHLzzbcPBQ3vfsc/rYVQ3qYyXbs6
         4oic7KpRvY672hnjYP0yEarW1MhOUVroEGQWcnNFNkhuMj2XNfrUYDtAIaO5/O5asuNf
         5xVAzXgqwzQJtRFAOfcWlBp+KXRPpFWR6Lu0l1EtM+mqzOq2R0fBUfOtyac/zm5VoxJy
         zt/xnq51popheJe4gkNWo1NmGZUMRkgZqPw8jDQRP10gs+Qt1yX3PkYDF8neNrBQhsBK
         bvlflAZ4ZTbAo6JL+Td9X+iJBjQLU3Tb1O83fm6oSl9rx/v4xyAGR/13Penrf1Lp2W97
         eElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h2xnvN3rkMZcaAStopByq5FB4LTsZ0396BsEMoxv4z4=;
        b=NI2OBwzv6iOcnI5b5YRWjNR+qrxV5j3IRlpGLUTqAuVcSNAZCkbsM7qmhyGQmVPG7n
         7WrHh0vJbAC9CRj0sslCTyCW5X36zb4tco4jPVcYx1Z4Sjx1gDjjju8lkSOFB4B9v14w
         PIWf85WW8VIi0lnKZRWgh9DDBtbgkB+QBgvC8RZzQAkEPdTrhYoWNNPH2rsGaF3BgzA5
         QAXCKQkko2AEQP9vcXkiFwASmufyOm55NLMELQlexnXzeUMAZ2ameQF9ekm2jLN0qbdR
         TjWebd4jVKOSUgbmNsXWZaNTq9Yp8aF5jzvaE+M0gbqHGgzYz0fpumhF7Dju88yGiw2h
         +ZFA==
X-Gm-Message-State: AJIora8Mx3T8nwxGmcDSkjqCpck2Q82IXq2NeiZjWOAl8l9W/NMWd9Gk
        XKfE987Ve5HY1R/ln9ZoqfPxEg==
X-Google-Smtp-Source: AGRyM1vsIr/v/vfg+vSqAa0rk6MpF5sy9zKVUL7orYXzO+Mvd7WPRVag2tcKP/G370pV2q4Ymk8GYw==
X-Received: by 2002:a05:6512:2185:b0:482:b4f0:f23 with SMTP id b5-20020a056512218500b00482b4f00f23mr9445294lft.31.1659508161102;
        Tue, 02 Aug 2022 23:29:21 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512358200b0048afd0c496fsm898381lfr.156.2022.08.02.23.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:29:20 -0700 (PDT)
Message-ID: <7effc23b-b61a-9887-3875-d102b8fa270e@linaro.org>
Date:   Wed, 3 Aug 2022 08:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220802214811.29033-1-j-luthra@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802214811.29033-1-j-luthra@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 23:48, Jai Luthra wrote:
> Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---


Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml b/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml
> new file mode 100644
> index 000000000000..6efb1d459543
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/tlv320aic3x.yaml#

Filename with vendor prefix, so ti,tlv320aic3x.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TLV320AIC3x Codec Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - Jai Luthra <j-luthra@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tlv320aic3x
> +      - ti,tlv320aic33
> +      - ti,tlv320aic3007
> +      - ti,tlv320aic3106
> +      - ti,tlv320aic3104
> +
> +  reg:
> +    maxItems: 1
> +    description: i2c slave address

Skip description.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specification for the active low RESET input.
> +
> +  ai3x-gpio-func:
> +    description: AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minItems: 3

uint32-array. Old bindings say about two items only. Mention any changes
to binding in cover letter.

> +    maxItems: 3
> +

You lost gpio-reset property. Also not explained in commit msg.

> +  ai3x-micbias-vg:
> +    description: MicBias required voltage. If node is omitted then MicBias is powered down.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    oneOf:
> +      - const: 1
> +        description: MICBIAS output is powered to 2.0V.
> +      - const: 2
> +        description: MICBIAS output is powered to 2.5V.
> +      - const: 3
> +        description: MICBIAS output is connected to AVDD.
> +
> +  ai3x-ocmv:
> +    description: Output Common-Mode Voltage selection.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    oneOf:
> +      - const: 0
> +        description: 1.35V
> +      - const: 1
> +        description: 1.5V
> +      - const: 2
> +        description: 1.65V
> +      - const: 3
> +        description: 1.8V
> +
> +  AVDD-supply:
> +    description: Analog DAC voltage.

New properties?

> +
> +  IOVDD-supply:
> +    description: I/O voltage.
> +
> +  DRVDD-supply:
> +    description: ADC analog and output driver voltage.
> +
> +  DVDD-supply:
> +    description: Digital core voltage.
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +#The pins can be used in referring sound node's audio-routing property.
> +
> +#CODEC output pins:
> +  # LLOUT
> +  # RLOUT
> +  # MONO_LOUT
> +  # HPLOUT
> +  # HPROUT
> +  # HPLCOM
> +  # HPRCOM
> +
> +#CODEC input pins for TLV320AIC3104:
> +  # MIC2L
> +  # MIC2R
> +  # LINE1L
> +  # LINE1R
> +
> +#CODEC input pins for other compatible codecs:
> +  # MIC3L
> +  # MIC3R
> +  # LINE1L
> +  # LINE2L
> +  # LINE1R
> +  # LINE2R

All this goes to top level description.


Best regards,
Krzysztof
