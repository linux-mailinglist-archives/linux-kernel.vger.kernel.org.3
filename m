Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFE4FF7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiDMNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiDMNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:41:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9C5FF15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:38:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so4034586ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iMNm5cMMRWBx6q53DUYrIONewJC2dWyH+H8kLXgxOFg=;
        b=ii3norTJVfcTqX9c/TW+FsugFydTXtBPxLu20kHlOrma7AzgGit5Ba5nVYL+sLEzvO
         tX7oLCAT9ZqcLyI8A+pyJjo2SpS1JlBYv0oE5zk8vm0OoUUB3Wk8MJn2uisvvgoFuD00
         L3+XcxdoLuZFdp35D/Z8eN9XAd29gKF6mHyjjpRJdlMSgmx8uYi7TWlPWRbmrePNJV2s
         Usj7uVdcWGfsMt4qUzlNzN6szZvz/Limvolm96xxU3Eiydr1Vn4J0SUQdspTy73JXuQQ
         JtK+yePl4bd867m/M5IfjPByWT2FKa/k7qVVLuOm+rjxyKo4eI1DJ1cwlRSi/DQ25tOw
         R40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iMNm5cMMRWBx6q53DUYrIONewJC2dWyH+H8kLXgxOFg=;
        b=GL4UUerCqpIEaAw5pPAOGGkG09mHFNVhF++98eq99L9LpYJvuJXnrqEsQxfFC/YyPx
         osDF2MnyNZdoYjSzJPHVhKlxpyWDi2KFQG+bwdvxlJYeko4UWL53jciNo+ulocXccxj8
         pwn4dnBd812RL9xE/Mt159fvJnl/avm8jN36+5pKd9z2sPTFKhO5PsOoNDf5yJ6Em+0a
         ITNE35Ad2cQBMihTyTLsvKrcsj8kn9ow12zdMQeqQuQwlRn5nwNErZvvxaMGtfY7jHYD
         WRAns1R3pPKNKaiBjKr4LcgJ5qB/lLtnyvlMS/KgMrb8R3+gtbXQaRS5S8BccAjeXkvn
         kQ+w==
X-Gm-Message-State: AOAM530jVx9pIpY3wOKaBi6IwFPLLjI1cQJw9p+kLVezy00WPRGlI5hS
        RI84mb0zHeYUC2FYuIHGPpQhLUovbEfZUNMl
X-Google-Smtp-Source: ABdhPJxg3FD/IlAF/2JxsWrX7ul105g9wCOUToaX9VP7SjqilKHhiNzbMFHc6AxHkx0MeW5nZFgGXQ==
X-Received: by 2002:a17:906:1615:b0:6bb:150f:adf8 with SMTP id m21-20020a170906161500b006bb150fadf8mr38768988ejd.272.1649857133430;
        Wed, 13 Apr 2022 06:38:53 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n25-20020aa7db59000000b00415965e9727sm1189483edt.18.2022.04.13.06.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:38:52 -0700 (PDT)
Message-ID: <79281f23-1eb8-6659-d126-eaa608c7abe5@linaro.org>
Date:   Wed, 13 Apr 2022 15:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense
 HAT schema
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220412201343.8074-1-cmirabil@redhat.com>
 <20220412201343.8074-5-cmirabil@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412201343.8074-5-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 22:13, Charles Mirabile wrote:
> This patch adds the device tree bindings for the Sense HAT
> and each of its children devices in yaml form.
>

Thank you for your patch. There is something to discuss/improve.

> +description:
> +  This device is part of the sensehat multi function device.
> +  For more information see ../mfd/raspberrypi,sensehat.yaml.
> +
> +  This device features a programmable 8x8 RGB LED matrix.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat-display

This binding is practically empty, so I wonder what's is purpose? Do you
plan to grow it? If this was already explained, sorry for bringing it up
again... :)

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
> new file mode 100644
> index 000000000000..c97cd1d8eac6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/raspberrypi,sensehat-joystick.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat Joystick
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Mwesigwa Guma <mguma@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description:
> +  This device is part of the sensehat multi function device.
> +  For more information see ../mfd/raspberrypi,sensehat.yaml.
> +
> +  This device features a five button joystick (up, down,left,
> +  right, click)
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat-joystick
> +
> +  interrupts:
> +    items:
> +      - description: pin number for joystick interrupt

Description is obvious, so just "maxItems: 1"

> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> new file mode 100644
> index 000000000000..2484ec91b430
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi Sensehat
> +
> +maintainers:
> +  - Charles Mirabile <cmirabil@redhat.com>
> +  - Mwesigwa Guma <mguma@redhat.com>
> +  - Joel Savitz <jsavitz@redhat.com>
> +
> +description:
> +  The Raspberry Pi Sensehat is an addon board originally developed
> +  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
> +  as well as several environmental sensors. It connects via i2c and
> +  a gpio for irq.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,sensehat
> +
> +  reg:
> +    items:
> +      - description: i2c device address

Description is obvious, so just "maxItems: 1"

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Why do you need these? You are not allowing any children with unit
addresses.

> +
> +  "joystick":
> +    $ref: ../input/raspberrypi,sensehat-joystick.yaml

Full path, so "/schemas/input/raspberrypi,sensehat-joystick.yaml#"

> +
> +  "display":
> +    $ref: ../auxdisplay/raspberrypi,sensehat-display.yaml

The same.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - joystick
> +  - display
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      sensehat@46 {

Generic node names please, so "hat".

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "raspberrypi,sensehat";
> +        reg = <0x46>;

Could you put compatible and then reg at beginning of properties (before
address/size)? It is more common convention and these are more important
properties.

> +        display {
> +          compatible = "raspberrypi,sensehat-display";
> +        };
> +        joystick {
> +          compatible = "raspberrypi,sensehat-joystick";
> +          interrupts = <23 GPIO_ACTIVE_HIGH>;

This does not look like proper interrupt flag. Wrong constant.

> +        };
> +      };
> +    };


Best regards,
Krzysztof
