Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1653981D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347835AbiEaUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbiEaUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:40:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF1464DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:40:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er5so19100962edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Alpwe54um/pAMi391V2OXK5ebcRXESWz/C1BKY6Vx2U=;
        b=bpXiaXVheIuoXS4qYPJJkBRiRLc0xdm8fJsiezzNxaSbqbM0HnHijdjFweVTNkO5Bt
         OZqNy/x48s3aknETcJSY51qRmtTvaefEriEEJgQKisgFjaP183xCgKHWGQMMuAEHM6iq
         Tc3YKXQYkPZ94qbC96FiM34BqIpNNbIw3S8bJFm37gUnEIpXhZlKzpuEHXf1T8hzTbUW
         Du1P41pKola5rfLIqjTtayOOX87K1DlGcQtFT+ikof7IHHBi0DGNf1t+EUD7xcGMBNpZ
         EvT5U5w/Mdqm9rktSC9cQ0mZie8pKoeXyPlTqMEFXnEeubuvBemuKrU2SexCdF1YgbDO
         BdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Alpwe54um/pAMi391V2OXK5ebcRXESWz/C1BKY6Vx2U=;
        b=R0HjNaljcG/b9P2QDPfYM8ESEYsKtiX9zOzeK91C5FoSZynNAJdFNP9fX31YeU7d0I
         bdFVjvDJpArWIbPVEUJiJ3P+uT6DrxFn9hTOqh2qK/buZ0JE4wgEwJjJgUp7iQGpWf2R
         JVeYESwtuGT65svJSkCBE5S4iBCIKZx72sZyO8fFjxpEIBkJ5V/1CAXYUgmgMDWQ4wNH
         zs4c9mKks6+Nj01cEGqaTy3NGto9b0EHiJm0dbJLz+yAKa2bfycSACvnAkvtFqmoMux0
         /OO7qOP/uACrLGv92V4D5tuj/rFVoKacrVJO8UgDxdk7uvO8eq0Z26SAt7/bVYG6Q5KG
         ZkWg==
X-Gm-Message-State: AOAM533TbWpPyc+eskL8g2yTZG7PeKR+4/L5JEPIsmog9hD2iVgT1TQJ
        MZvsnyvLNHQE8lhnKsX7exz5hg==
X-Google-Smtp-Source: ABdhPJzdZx04tPobjk6aL2VQPYwY9rAKwfMAkoP+ACgtkB/OwGTdsTuE3oT/JNLygYdZnn9MWjUmsw==
X-Received: by 2002:a05:6402:c1:b0:42a:b8a5:8d5e with SMTP id i1-20020a05640200c100b0042ab8a58d5emr67401586edu.266.1654029614622;
        Tue, 31 May 2022 13:40:14 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b006ff01fbb7ccsm5299610ejb.40.2022.05.31.13.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:40:14 -0700 (PDT)
Message-ID: <3ab7892e-cee0-f5d6-7b58-1a9bfc803ea9@linaro.org>
Date:   Tue, 31 May 2022 22:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 12/14] dt-bindings: leds: Add Mediatek MT6370 flashlight
 binding documentation
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
 <20220531104211.17106-4-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531104211.17106-4-peterwu.pub@gmail.com>
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
> From: Alice Chen <alice_chen@richtek.com>
> 

Subject - same comment as previous #10 patch.

> Add Mediatek MT6370 flashlight binding documentation
> 
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> ---
>  .../leds/mediatek,mt6370-flashlight.yaml      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> new file mode 100644
> index 000000000000..b1b11bd3d410
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-mt6370-flashlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  see Documentation/devicetree/bindings/mfd/mt6370.yaml
> +  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-flashlight
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-1]$":
> +    type: object
> +    $ref: common.yaml#
> +    description:
> +      Properties for a single flash LED.

Same as patch #11.

> +
> +    properties:
> +      reg:
> +        description: Index of the flash LED.

As well.

> +        enum:
> +          - 0 #Address of LED1
> +          - 1 #Address of LED2

'#' starts a comment, so there is always a space after '#'

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
