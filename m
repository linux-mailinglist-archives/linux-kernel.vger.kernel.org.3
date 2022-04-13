Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC34FF16D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiDMIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiDMIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:10:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F62DD4A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:08:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so2629245wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lVcO1/lC7e7USSSpiAYT+piKROxqG4y5tiLaA2XBQrE=;
        b=xp86yr6Vj8c3yGnWzdMbXhYA9IABVafmRxPBYWZDA66yn/TT9oE1TxwiMBfSIowTE+
         7swhRvEGEieoD/NxJr2V7NaNLxDUBaJ2SuvKCUQa15NixdStDES21jlu9XQMNpgwTD+3
         sblkIeFTErHZZ8ilgxWd/632xzly4MGYq+PB+uhBQt0guKyKY2lol3PBFUOUejKdOsNF
         dxVBz+exvq5Z3KyhAwRWQrdZTy2DYOKdwbsDZZOAd7siIp1AivN0DX1nFNFL97EZmEHx
         Nb9knnh1vMm5V+n0eqxw2W7CUzCXx2XgwjmnjjR22LL761Q+t8Nc8YMUlU3j0UnPQZCR
         KnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lVcO1/lC7e7USSSpiAYT+piKROxqG4y5tiLaA2XBQrE=;
        b=JDCGhkqEyX35ej65xngDzIGDX+PqKCDuZPgBwGABsu4ShTbuzrg/A+MHuL61P1HbiP
         R4hiYLBXPjln/sejohcJVMwXc5ymnuBg/nV8zt+vaNGZ+bZpSO14UcaS10PgVHq/WNYC
         0iHL21kRqEKUBvRu2o+5Hv8t3B6s3bynC24qZf9UgFUe2OMSNZEf5mLahAi48BsJtnyr
         E7Z0XKJoRuTjKIGoOZE0q94mLvS7gU8xywFCDVqncDF6wseld5DgLNw5FD39K25Xn+pt
         FM9HSDh1KdIxMqlXOVy+/YuGSEtarJaNovvDW4ywGPDUSvkSTvuPfDGXWLvVOMg27kRz
         m3ng==
X-Gm-Message-State: AOAM5332z43vTE7+DoOr2GBjHtYhaOeJiWrpEeysw3JVo3zg2iwguFhQ
        fLLxm5+FcmQmpnMNBDHjlfcGag==
X-Google-Smtp-Source: ABdhPJyUAS0tkOnj0v7VsHut18QbcF8WjHXmfN7pryvAb2cvBZUa+xjKvFVwLKZrLKTNpq/yna5l3g==
X-Received: by 2002:a05:600c:1d9d:b0:38e:c8e0:209f with SMTP id p29-20020a05600c1d9d00b0038ec8e0209fmr6642680wms.43.1649837281955;
        Wed, 13 Apr 2022 01:08:01 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8949:72f1:7713:24f8? ([2a01:e34:ed2f:f020:8949:72f1:7713:24f8])
        by smtp.googlemail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm1776807wmn.16.2022.04.13.01.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:08:01 -0700 (PDT)
Message-ID: <d470c4dc-6e16-1bb4-379e-250e2adf3e5f@linaro.org>
Date:   Wed, 13 Apr 2022 10:07:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220412101409.7980-2-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Krzysztof

On 12/04/2022 12:14, Keerthy wrote:
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
>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..8483c495cb9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -0,0 +1,62 @@
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
> +    const: ti,j721e-vtm
> +    oneOf:
> +      - enum:
> +          - ti,j721e-vtm
> +          - ti,j7200-vtm
> +
> +  reg:
> +    maxItems: 3
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
> +    wkup_vtm0: wkup_vtm0@42040000 {
> +        compatible = "ti,j721e-vtm";
> +        reg = <0x42040000 0x350>,
> +            <0x42050000 0x350>,
> +            <0x43000300 0x10>;
> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu_thermal: mpu_thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&wkup_vtm0 0>;
> +
> +        trips {
> +                mpu_crit: mpu_crit {
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
