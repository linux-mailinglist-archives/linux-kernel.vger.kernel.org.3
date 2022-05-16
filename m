Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6712528222
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiEPKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiEPKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:32:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3819C2D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:32:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j25so18864009wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RttnXZvU3aVxvRaSNtU7c8RHwC9HgssmoEkHoxVMQBM=;
        b=BTvtyT5KS3O7KQDTCvAOXzDvo7vlxqZY6GXK14238lvkCAYg+K092d1YrSZndxNxun
         7GVUQdCb7S9MD+c0jaYNkXszQAg67aKEiiMw0vqQ3l9Cea1BXn+jeUFPQmBgaprF9l72
         Ac8YwwSgdY42PBTqBAFlm7oAUy4ucN99TjkQjgdp/hkF81+hMyvyn70y7lGd0Ag25IBF
         23KTyYX1Tp3CjLvEPVUuZ5frwWTMMAUBdlRsIht/DWAebAvfS0hjjG/zq8XKSH2kNqHg
         khgrMjofQ5p7hM+YdJx9Eex9mnsBjqXHAJE2tLdRA5Z2RbsMOzz0ybDIx/Yq/Qp1TBM4
         /7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RttnXZvU3aVxvRaSNtU7c8RHwC9HgssmoEkHoxVMQBM=;
        b=jDbbeDoOyJEijzwXXVd9tlIqxTib9Bs/RzRHUlDr8V8ccYH/SUK+gxiHPRkt7EjCpT
         8wxyzOQwlbfiSXJWyoMpxf5dIGDR3xx6VKikhIE8kOrQez7wGa8E1Qd//IJUXq3xBazK
         37XcqyBhK0Qmf68lFyxST9/9m9zhtGUPYi2B6uIQAELi70NX0Fk3ygG7GMX04u9e3PXn
         +syM5V1u/A+06ic6BzXBHu+MB/MGhE/RMZ420XXt3VLiikpBn5T7Gn3KxRlVVgfNpvQ4
         6thsfwOkoAYubsdJvsyq+zV5JFJfgcO+V5suUzmAimp0/sBgmvMU/YLpdXx1lfRnrpbY
         cmgg==
X-Gm-Message-State: AOAM532QdITsJiyvuK3OgnC+KexmFVFWtfuY1pdj5NpyKNQO8VI7AOmJ
        AOiDtf0RaRD1DA+px/+U9M4rOQ==
X-Google-Smtp-Source: ABdhPJwdCf+BkcMYSxApqADPjW+dHt5DnvG160gLFyEFNPZNqcDHC2iHM205gH0uqDN53qEOS7fY3w==
X-Received: by 2002:adf:d1ec:0:b0:20c:61ef:93b6 with SMTP id g12-20020adfd1ec000000b0020c61ef93b6mr13754972wrd.694.1652697136459;
        Mon, 16 May 2022 03:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b464:e524:6a1d:33d0? ([2a01:e34:ed2f:f020:b464:e524:6a1d:33d0])
        by smtp.googlemail.com with ESMTPSA id v2-20020a05600c15c200b00395f15d993fsm4454619wmf.5.2022.05.16.03.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 03:32:15 -0700 (PDT)
Message-ID: <4568653d-706e-8621-3fee-d4a853517256@linaro.org>
Date:   Mon, 16 May 2022 12:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
References: <20220511110657.16305-1-j-keerthy@ti.com>
 <20220511110657.16305-2-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220511110657.16305-2-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc'ing krzysztof.kozlowski@linaro.org

On 11/05/2022 13:06, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 64 +++++++++++++++++++
>   1 file changed, 64 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..83f8f444a133
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments J72XX VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,j721e-vtm
> +          - ti,j7200-vtm
> +
> +  reg:
> +    items:
> +      - description: VTM cfg1 register space
> +      - description: VTM cfg2 register space
> +      - description: VTM efuse register space
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    wkup_vtm0: thermal-sensor@42040000 {
> +        compatible = "ti,j721e-vtm";
> +        reg = <0x42040000 0x350>,
> +            <0x42050000 0x350>,
> +            <0x43000300 0x10>;
> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu_thermal: mpu-thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&wkup_vtm0 0>;
> +
> +        trips {
> +                mpu_crit: mpu-crit {
> +                        temperature = <125000>; /* milliCelsius */
> +                        hysteresis = <2000>; /* milliCelsius */
> +                        type = "critical";
> +                };
> +        };
> +    };
> +...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
