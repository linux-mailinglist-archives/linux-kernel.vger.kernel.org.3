Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6252374C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiEKP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiEKP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:27:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF9377D2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:27:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p18so2993237edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+uroO/vY6XG1xI1X9Ud5Dc476KAfJP3kX2168zNzYO4=;
        b=fk1P5MGNZl3h9gT/nk2Obg3HmrryEHaslAi7OhrMkdNeVA7xAZBZr30WxMACYnUOyn
         7UkJGnNIy0nvFOqAmuFyuvYCrHTBjjmmjEaWyarProKucTZzxeRY+UoqKHheTPgwyY/P
         5/PUCzZ6A3xEXfap2TCG6EHAZgOCOl5Xh0eFKeDgO1oDfYR+5VwEA6oJDSEPIpPEZLEo
         sDO5y+6zTdcMaUbYDU2e/sj9nUsPpYNHnCYiqfVU3SuBFjR4ABn/oDvsysAlU9CDU3nx
         QD6H/Gk4grGiQchcEvi6PxhHdhzKBbq3PsPqdsBiDUU08NHEyYqUZcaYWgaAbtY8wcyw
         lWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+uroO/vY6XG1xI1X9Ud5Dc476KAfJP3kX2168zNzYO4=;
        b=50BSJoWSnq4FWGX3IYUPyTr0HEb3I8JDVp/Rqimk7pcsz3IEWAw9M2M2EXfzhPJk8L
         5ObP6Vd0NdU7q49EWc1prDzSYpM4J/ErAR2QDWPC2KwRcB+1SvXvH0RfUEhBnnA5x9lP
         nK7/sP1bHutc7m7fly7DH9sSHBERypUkI7COGokZWEViFDmvJNKgw/AcolcInoSGbeg5
         9Ik2S8KVKuluBwW1RTBuWhUZ6TkklKRXeojNdfOENC0gGB/7zNkDOQODrwTx1CKAkXPL
         +2/2ETveY6ethum/gMNmXVRIJFIwomtowYiFeLksvRa/XUMI9blRgTMFM81oiam1rojo
         yX8w==
X-Gm-Message-State: AOAM532w/0m6lBIJwLai32EhDmXcupLV7vQhpzT7r1yNr6iV2K3y3xf6
        aJ1aRBD9bWGlOR9S1Hq5vV3HKg==
X-Google-Smtp-Source: ABdhPJy96CstkysGFwN7nKsEZRY2/Sn2Wy/P5Gpj3mO5AwWu9FxTZSfFYCIVl9B5iV03G2Qb26uzaA==
X-Received: by 2002:a50:9f06:0:b0:425:c1ba:5037 with SMTP id b6-20020a509f06000000b00425c1ba5037mr30308853edf.285.1652282862097;
        Wed, 11 May 2022 08:27:42 -0700 (PDT)
Received: from [192.168.0.154] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bd23-20020a056402207700b0042617ba63a3sm1291335edb.45.2022.05.11.08.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:27:41 -0700 (PDT)
Message-ID: <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
Date:   Wed, 11 May 2022 17:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510094457.4070764-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 11:44, Claudiu Beznea wrote:
> Document Microchip OTP controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../bindings/nvmem/microchip-otpc.yaml        | 55 +++++++++++++++++++
>  include/dt-bindings/nvmem/microchip,otpc.h    | 18 ++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
>  create mode 040000 include/dt-bindings/nvmem
>  create mode 100644 include/dt-bindings/nvmem/microchip,otpc.h
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
> new file mode 100644
> index 000000000000..a8df7fee5c2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml

vendor,device.yaml
device should not be a wildcard but first compatible, so
microchip,sama7g5-otpc.yaml


> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/microchip-otpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip SAMA7G5 OTP Controller (OTPC) device tree bindings

s/device tree bindings//

> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description: |
> +  This binding represents the OTP controller found on SAMA7G5 SoC.

Entire description is duplicating title. Please describe the hardware or
skip it.

OTOH, you should mention the header, for example in description.

> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,sama7g5-otpc
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1

These come from nvmem.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>

How the clock is used here?

> +    #include <dt-bindings/nvmem/microchip,otpc.h>
> +
> +    otpc: efuse@e8c00000 {
> +        compatible = "microchip,sama7g5-otpc", "syscon";
> +        reg = <0xe8c00000 0xec>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        temperature_calib: calib@1 {
> +            reg = <OTP_PKT(1) OTP_PKT_SAMA7G5_TEMP_CALIB_LEN>;
> +        };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/nvmem/microchip,otpc.h b/include/dt-bindings/nvmem/microchip,otpc.h
> new file mode 100644
> index 000000000000..44b6ed3b8f18
> --- /dev/null
> +++ b/include/dt-bindings/nvmem/microchip,otpc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Same license as bindings.

> +
> +#ifndef _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
> +#define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
> +
> +/*
> + * Need to have it as a multiple of 4 as NVMEM memory is registered with
> + * stride = 4.
> + */
> +#define OTP_PKT(id)			((id) * 4)

Do I get it correctly - the offset or register address is now part of a
binding? You write here "id", however you use it as part of "reg", so
it's confusing.

> +
> +/*
> + * Temperature calibration packet length for SAMA7G5: 1 words header,
> + * 18 words payload.
> + */
> +#define OTP_PKT_SAMA7G5_TEMP_CALIB_LEN	(19 * 4)

Length of some memory region also does not look like job for bindings.

Best regards,
Krzysztof
