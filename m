Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CB4C118B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiBWLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiBWLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:40:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA095A13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:40:22 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 148963FCAB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645616421;
        bh=gHH7mWoWO3tckDTcVzb7f0pipscP20lunZpjoSfW5fw=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=LwMay7NZg6O0rcqH0Ema3N+r5hwHA2Z5lCshoZ5zQ0FJ9AgPIe3x9Ds5cXx0444wt
         qSypCTdkkTCaHX/8ugM7yVKr0DrKTEyqFS/hHvxwOM1XkDInJgsEpQZNrkMHDs4KK9
         6Tex0Bjj/YOcz8AvwFU8OYNqOacR0BVTvHGxOlKIcNxEqCvfiJsUQ4ltvjt4iFz1ax
         mVQhz2P+7rlUuOx4AJD85gKGYMzZHuIHhokiVMJjUxajPZ/JT+uarch2LNlmZrZHtf
         1pb11/FB9mLD0zJu1Am/jCcTa0Eh/zBLt5N+Bj/nZ/Hb3ZOyjqvSLfJOmk1vf3WE/p
         IJKrXcHv+sFcg==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so13335323edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gHH7mWoWO3tckDTcVzb7f0pipscP20lunZpjoSfW5fw=;
        b=Tg3dotgv8CxTpoQcrZBgutqCFdt+BtHfFNsj+Hq0m0eYG3idov/SoHAL8ikVJoNjLg
         4CkJaTwg0W38xkoDXoi1qZ6LHn0W8dBK8VJ+FKdVRXkO3me7DsFM20Q+cxhALak1hFLW
         Kbb9Jnm+/pha2Dv/gcvp4AGRUKZfqpOjxHEOWYmU8c2CVRUpQZenUSx2iB25EsKQyzzU
         eu2vjvbp3ctEQpaKwSvQ/fVaFRjPRWJ7mqOIq7jGuaM3qveVled/pXIcFhE0cIuW2dXk
         EvgWaAyIR9N7do7rLKB/Qq0kAEFrDLIPw7y2qrB84mrAS/RphFud4L6ZJN8f42tQsKbJ
         LmFQ==
X-Gm-Message-State: AOAM530+31aG7Iw/B+1RobngVe+dCyMROFYy4B9mA8IIBgG9TyEq7AWJ
        tCvJxE3tqPMMUtMBCX8xR1vhSyK2+6d+DcS1QJpm4g1f7d/xEUBrs6pR9NttmheQeOVpDSzPznQ
        QpuSQjO+PZXS5eWJf5kjRI8q0zsQSOBIBJDAZZoW1BQ==
X-Received: by 2002:a17:906:814d:b0:6cd:eb64:2a11 with SMTP id z13-20020a170906814d00b006cdeb642a11mr22639369ejw.763.1645616420728;
        Wed, 23 Feb 2022 03:40:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEqQePWiF4fCxggYG1UaTLN7VWV1bMbYSXlf67gdRyuPVSaM1SWDgoWy3iBjwvat+EevGr0g==
X-Received: by 2002:a17:906:814d:b0:6cd:eb64:2a11 with SMTP id z13-20020a170906814d00b006cdeb642a11mr22639361ejw.763.1645616420529;
        Wed, 23 Feb 2022 03:40:20 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id gb37sm1773621ejc.223.2022.02.23.03.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:40:19 -0800 (PST)
Message-ID: <5343b876-8f47-2657-3755-4e79b9089657@canonical.com>
Date:   Wed, 23 Feb 2022 12:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: amplifiers: add ada4250 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220222103848.8530-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220222103848.8530-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 11:38, Antoniu Miclaus wrote:
> Add device tree bindings for the ADA4250 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v5:
>  - put dt-bindings patch first in the series
>  - add spaces after `:` in commit subject
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> new file mode 100644
> index 000000000000..2d22037496bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADA4250 Programmable Gain Instrumentation Amplifier
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ada4250
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  adi,refbuf-enable:
> +    description:
> +      Enable internal buffer to drive the reference pin.
> +    type: boolean
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      amplifier@0{

The same as in other patches from Analog. Space before '{'.

Please fix it in all other patchsets as well. You submit these days
around 3-4 different devices, which is cool and great. But please fix
pointed out issue not only here, but for every other driver/binding you
work on.

With the space added:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

> +        compatible = "adi,ada4250";
> +        reg = <0>;
> +        avdd-supply = <&avdd>;
> +      };
> +    };
> +...


Best regards,
Krzysztof
