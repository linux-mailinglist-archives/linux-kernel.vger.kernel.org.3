Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46112589AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiHDLXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHDLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:23:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B434D83F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:23:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x39so20750534lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/tehabPNXgzKT/PZB7LTyS6v91bSlhrWIId3zLr+jw4=;
        b=ptSAimzffHbj+u6lIXfdEShRglTiiYM1pRsRfzv++T2A/tZwGMMRW7Y+F29sDxh6po
         ll6WLhN9K8+2Ywn4bgym+AIjnawgPEPTXyxdyfqB7hl53g58NBjU+5A8HFlpnwksCgB9
         gH0068c95fv1E+izSBzOAyVDZaaHnpGmL1oQWeiwBmB91uoPXPmMq9cnm1JWkd6kZI4k
         fdAnGmMTD0TzjQJZYmboUrY5hGsKbrAKSpJ8JH5+G8i6HE0ArxhFaTSW1qI37mClWUuM
         G96UlJPCd4/ngqqekypUqdETNExWe4HujR8hn7p+WOydknuzJPvOWhb1l4YY2bVVDUaN
         Pp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/tehabPNXgzKT/PZB7LTyS6v91bSlhrWIId3zLr+jw4=;
        b=26PVfp5Pkg9wNY8sh6v1fLNSVZkKZkPwkoOizBFv5o1GDG5gsBbi1UF/eVGFWMdfEi
         JeB6u/58977jw1ZrI4ZXAl6zR35eQQldlnrzUYjfN0baGh5EH7UiyhT65sDn+Q1DELiG
         ayKKWO7SsI16xZYvQYXJaPOPMwEY3ACi3hScWjYBq1IjTEunanizYvmyqTIllrzikdo1
         lotoqdw7ziN2sYE3FF0jPYbkg5uScKdzkT4jZZSNiZAuNnNWjf1jvIwRdIxdidJHetwt
         THFh/fMxSm8SSLfG+rrEPiPZnz6pcGY3HqD+l/yovmKNyQmAlfsh0ZSebQfQ7e/lbJsZ
         zmCg==
X-Gm-Message-State: ACgBeo2TpKWHtahamxm5XWzNtresQ72oyhGsw//whUf5zeNLcHXHOEeM
        XAU0CEuhUHxPG2qqp/QHrJhO+g==
X-Google-Smtp-Source: AA6agR5ea4gvC20yipsPb61s9LV+gP4i+TEIUBShBVLemuPDarIdi1x8bQFShv7dqERenK+JvlRlHQ==
X-Received: by 2002:a05:6512:308d:b0:48b:b7d:f1e5 with SMTP id z13-20020a056512308d00b0048b0b7df1e5mr592496lfd.199.1659612220803;
        Thu, 04 Aug 2022 04:23:40 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e504a000000b0025e5358857esm95943ljd.13.2022.08.04.04.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:23:40 -0700 (PDT)
Message-ID: <10887a45-cd28-8396-b3e7-745e22e00c27@linaro.org>
Date:   Thu, 4 Aug 2022 13:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220803151726.31628-1-j-luthra@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220803151726.31628-1-j-luthra@ti.com>
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

On 03/08/2022 17:17, Jai Luthra wrote:
> Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  .../bindings/sound/ti,tlv320aic3x.yaml        | 158 ++++++++++++++++++
>  .../devicetree/bindings/sound/tlv320aic3x.txt |  97 -----------
>  2 files changed, 158 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
> new file mode 100644
> index 000000000000..f0ed856162ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tlv320aic3x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TLV320AIC3x Codec
> +
> +description: |
> +  TLV320AIC3x are a series of low-power stereo audio codecs with stereo
> +  headphone amplifier, as well as multiple inputs and outputs programmable in
> +  single-ended or fully differential configurations.
> +
> +  The serial control bus supports SPI or I2C protocols, while the serial audio
> +  data bus is programmable for I2S, left/right-justified, DSP, or TDM modes.
> +
> +  The following pins can be referred in the sound node's audio routing property:
> +
> +  CODEC output pins:
> +     LLOUT
> +     RLOUT
> +     MONO_LOUT
> +     HPLOUT
> +     HPROUT
> +     HPLCOM
> +     HPRCOM
> +
> +  CODEC input pins for TLV320AIC3104:
> +     MIC2L
> +     MIC2R
> +     LINE1L
> +     LINE1R
> +
> +  CODEC input pins for other compatible codecs:
> +     MIC3L
> +     MIC3R
> +     LINE1L
> +     LINE2L
> +     LINE1R
> +     LINE2R
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
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specification for the active low RESET input.
> +
> +  gpio-reset:
> +    maxItems: 1
> +    description:
> +      Deprecated, please use reset-gpios instead.
> +    deprecated: true
> +
> +  ai3x-gpio-func:
> +    description: AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2

No need for minItems if they equal to maxItems.

> +    maxItems: 2
> +

Except that, Rob's bot reports several other properties used in DTS. You
can document them in that commit - just mention in commit msg - or a
follow-up commit just for undocumented properties.

Best regards,
Krzysztof
