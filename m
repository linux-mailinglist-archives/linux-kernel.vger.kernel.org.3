Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9D54EC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379113AbiFPVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379191AbiFPVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:13:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6636760AB6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:13:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d5so2224393plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kq/MImyJWDNQF4uVHL2hoQzE+MOoY9vKXhkH8pM9iWw=;
        b=oDMV4rTsW6tuuydGHoAl95ll57TYHtuIcLgxX6P7/F+8fIbQhjShTYv2VvzpwP7I2f
         ODHrtoYjkED2az8ySqcIMrm+pOu+7wc36Gixgd4SqjTTp2xGjJwjUIq7Ph9degSmWdKX
         yj+zZbeGwC2SAvyU6KbLZ+Xaj2RwEPcHQKXAY2iJoap6UrcUJyAmwqtTzidiQL+PewJN
         TXCl3YI8GHPSj+2facEjkfri+q2kbnFjLZgmiFiaUiSyp9HGqAx9gzJuFbGW9OmISdjg
         cuyrA3nq+PB2AEHmSSIN5WKjGpYumFtoXZ9U4IEaUlHrLbpqtigpthN2+jEEbLDZnr8E
         qDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kq/MImyJWDNQF4uVHL2hoQzE+MOoY9vKXhkH8pM9iWw=;
        b=kCRIqseDBlKDnQyO2B64OGLB34bAwWlgaFzJGLtXdxa2BBDVcRosL/EqE1RFq/sv93
         SEThuIafqprKDQFQ1dkX3hhp7G36gT5zYMwkoOPKMKsnsmOJBohumQ5dWjm4lNi0up7K
         i9PQ/q84CtLvmM70M9ChkPsTDXh8bFnXWdjaki055ev0PxqhXSP8GN3XSCnd+965gmqP
         HHT06FUpiIwQhhliadH//wMW+ThXwAKJkffPWS89vIl+uwzkZ3oVKRqVu3psnzhVAiUL
         l5s2glgi5qp34rtUNQN4FwEPKD2fhV5cvd7Io7CVUfEW7z+RmoGiRNEGBy4Zs4OsCUeN
         wSIw==
X-Gm-Message-State: AJIora+ye+9I39h6pYSxQqUb84bBVL1SUDmXWfb6I09bxnBsO7ln+6Hm
        p+U1mqkD0CZDmLfXg5DWbKUV5A==
X-Google-Smtp-Source: AGRyM1sXBnnmN0CPt8Et0W6JQWWLYChMrg1Zy3h2FXLYYO9nrTkigRzDuYC+LUgyDJpx2ZUWmbfawg==
X-Received: by 2002:a17:902:dccb:b0:168:f9f4:5773 with SMTP id t11-20020a170902dccb00b00168f9f45773mr6364361pll.124.1655414018850;
        Thu, 16 Jun 2022 14:13:38 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id o18-20020a629a12000000b0051bf246ca2bsm2187451pfe.100.2022.06.16.14.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 14:13:38 -0700 (PDT)
Message-ID: <9c38f708-1376-aa89-2c56-c08d320bcf2b@linaro.org>
Date:   Thu, 16 Jun 2022 14:13:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 05/15] dt-bindings: backlight: Add Mediatek MT6370
 backlight
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-6-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613111146.25221-6-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 04:11, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add mt6370 backlight binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../backlight/mediatek,mt6370-backlight.yaml  | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> new file mode 100644
> index 000000000000..25a05e607e83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6370 Backlight
> +
> +maintainers:
> +  - ChiaEn Wu <chiaen_wu@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  The MT6370 Backlight WLED driver supports up to a 29V output voltage for
> +  4 channels of 8 series WLEDs. Each channel supports up to 30mA of current
> +  capability with 2048 current steps (11 bits) in exponential or linear
> +  mapping curves.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-backlight
> +
> +  default-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  max-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  enable-gpios:
> +    description: External backlight 'enable' pin
> +    maxItems: 1
> +
> +  mediatek,bled-pwm-enable:
> +    description: |
> +      Enable external PWM input for backlight dimming
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-enable:
> +    description: |
> +      Enable the backlight input-hysteresis for PWM mode
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-input-bit:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      The selection of the upper and lower bounds threshold of backlight
> +      PWM resolution. If we choose selection 3 (6 bits), the variation of PWM
> +      resolution needs over than 64 steps (2^6).
> +      value mapping:
> +        - 0: 1
> +        - 1: 2
> +        - 2: 4
> +        - 3: 6

Nope, I said last time:
"In any case you cannot have values mapping"

Please use proper real world value, not some register bits. The property
name also needs fixing.

> +
> +  mediatek,bled-ovp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OVP level triggered
> +    type: boolean
> +
> +  mediatek,bled-ovp-microvolt:
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Backlight OVP level selection.
> +      value mapping:
> +        - 0: 17000000
> +        - 1: 21000000
> +        - 2: 25000000
> +        - 3: 29000000

No. Please test your bindings.

microvolt cannot be 1 mV. It's 21000000, not 1. No value mappings.

> +
> +  mediatek,bled-ocp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OCP level triggerred.
> +    type: boolean
> +
> +  mediatek,bled-ocp-microamp:
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Backlight OC level selection.
> +      value mapping:
> +        - 0: 900000
> +        - 1: 1200000
> +        - 2: 1500000
> +        - 3: 1800000

Nope.

> +
> +  mediatek,bled-channel-use:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      Backlight LED channel to be used.
> +      Each bit mapping to:
> +        - 0: CH4
> +        - 1: CH3
> +        - 2: CH2
> +        - 3: CH1
> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - mediatek,bled-channel-use
> +
> +additionalProperties: false


Best regards,
Krzysztof
