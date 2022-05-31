Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677C539827
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347794AbiEaUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbiEaUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:38:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973764CC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:38:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so19118807edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LnHG31HXQfKnbhGg7cjs5q5dHO7sV+EO7splsWy9LeQ=;
        b=G4bpmdn50HXz387vl8R3y2JvcN1BMO8J4TnlELbvBC3hch09KoDJys8Gb1VxVKVfMp
         WF4/5Bl7r3o0N8kDIFXar10RdRAF2ERfMar+yaboTm27MUMOFUcQYMywTvJn4plszWu8
         Ezu6XeSDZVZvjILJcLyo9KEkUpJBiujNlQNxKeqylfN4Z1m0gwC/cw2quZMAy9Tl2zNe
         8VT/AW2zGVespv4TQu1Zz7OhJPEKNhKrS9X+3H43j6OKle3lQ4bHS3gfG7NjX7SzzA4Y
         6dd+Ty88BqnmRjplgHfH6NgwyQ/L5t4nymBrZrAKk05FYWSm/8zJsHLfWc7dmq7YPoJ5
         1mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LnHG31HXQfKnbhGg7cjs5q5dHO7sV+EO7splsWy9LeQ=;
        b=ek9OvyQerccH6hvrqejNH+5pwnIh+aUrZrH8Lz4KKLDrjMfP0ypkXRqQx5o2Sm7di9
         R5lTHt+iMuQklEO3Puoo/PeoHbchVIUeOwCuo8joRN0L3VnOA03nckKdmJoN/hinrFcs
         fGMYwzToBkZWoZMr9UaIZb6dmj5vXxwp8J/ed+biNifzN09n1RWLrSAdH2UFIA0+aCmJ
         Dz+9FDp0TEMayzu157xmN5kJ2T7AWovfkOBIrVaViA4bOcvBhB6CkMVxmIHafVWTuXNs
         J4oNOCjzK9+aYiTe9O4OGxXGfkXarZQRd9tTrvcIEedWqRSJBSeutU+MZSGLfP3hPtrI
         PR7A==
X-Gm-Message-State: AOAM5301GYf+hKaLRdH3+ePp1ohYvfzyhYtA+lKOO6TVAPG2qLAXvJbn
        0q1AaV58v8d2niVrcOannJLzSQ==
X-Google-Smtp-Source: ABdhPJxkgTOHGDh/+1ZlJUDIpeS1F3D633+ql1GnhfBUpZG6Av5LP8dRbdIOBf6rA5kXSNJ0tE0G7w==
X-Received: by 2002:a05:6402:1f0f:b0:42d:d4a5:a38c with SMTP id b15-20020a0564021f0f00b0042dd4a5a38cmr10987637edb.140.1654029514252;
        Tue, 31 May 2022 13:38:34 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 12-20020a50874c000000b0042bc5a536edsm9094727edv.28.2022.05.31.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:38:33 -0700 (PDT)
Message-ID: <0036b3f3-fdf8-4635-18e9-461b93a87f19@linaro.org>
Date:   Tue, 31 May 2022 22:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/14] dt-bindings: leds: mt6370: Add Mediatek mt6370
 indicator documentation
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531104211.17106-1-peterwu.pub@gmail.com>
 <20220531104211.17106-3-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531104211.17106-3-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 12:42, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek mt6370 indicator documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../leds/mediatek,mt6370-indicator.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> new file mode 100644
> index 000000000000..823be3add097
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  see Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-indicator
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^(multi-)?led@[0-3]$":
> +    description: |
> +      Properties for a single LED.

Not useful description. Just skip it, I think schema allows it.

> +    $ref: common.yaml#
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          Index of the LED.

The same, regs are usually not described.

> +        enum:
> +          - 0 # LED output ISINK1
> +          - 1 # LED output ISINK2
> +          - 2 # LED output ISINK3
> +          - 3 # LED output ISINK4
> +
> +      mediatek,soft-start:
> +        description: |
> +          soft start step control, support /0.5ms/1ms/1.5ms/2ms.

Why here you start sentence lower-case?

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]

This has to be in logical values, so in ms, not in some register values.
Use proper unit suffix and enumerate the actual values.

> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false


Best regards,
Krzysztof
