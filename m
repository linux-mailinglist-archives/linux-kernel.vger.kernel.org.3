Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57952B4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiERI1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiERI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:27:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFF1157C8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:27:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so441424wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EjqmNzNHU62tbGWEmGCSZ/quQcHD8ef7lqrbwmVPudg=;
        b=l0KEje+nRrOVaYyABLHpk/z7KT6s2EzSKaWTOvSZjAdbPwkFb6/+OsoW2dHRIrb4Rs
         MHfuy2yQx/EsZT0D/AqfHL2hZEw7DKuvSr40QZYcYiNnQ/z9ENrQ7HqkYHZ/DK1O8k8R
         QQ6WMyrc3XW//fZyijLHTBHrn5zPGiDk0OAJxIfDzLJJmJa50V25x3qpbxzJh00t8cNV
         TQhVJX2HZ7uYczoOeYS6THjh/QK0IcLJQ+P4KuaZzkC/RZk0bcwVpxx4q3REARP5SLPB
         Md28A1GdYJxHXtWSDtGTSSCTh/H5MVqAVpkGR50V/JfX6fosGF2ESLexvdLXNd9uxkDY
         hMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EjqmNzNHU62tbGWEmGCSZ/quQcHD8ef7lqrbwmVPudg=;
        b=X23SzQXqjj6ya/eZJrFv5sHr2i9h7z7roQj0pOcIhfvojyYxmjUKUN43n6HmzXknCA
         qzB8QrsDavHfHa5bA7DRMwPPg2cb8pL+PbN6niB9Wd+OlhR98Dec2zJmCQbFUe5TNwqw
         /DeWVz7xelSMhO9wpYKlchE0TfdtTtPSwDWweqpSkdo28EjLr0QK49bsq5wK0+xRizmd
         ztoc6ftZxfarPKSk/CBUIM95G2cHQGPn+ANLP6AL+kEu2w8Nq6pl2ieaeiKiTDR2JWRU
         3anUECQB0qSxuoXRLhJszLx+2ioTI/WDhthXceBHtMDu/0xOoQMX+0WBXQgbs6e6Zxfb
         M78A==
X-Gm-Message-State: AOAM531uG4N8za3C9rQRtuCLGosFoOCfKpu7vadbusAh9BssQIywv8wS
        xT7O9X+/2QiIGo9zdaC4gt45cg==
X-Google-Smtp-Source: ABdhPJzsQmvAd0aRM2QlN6e8UT8l1YW2ynIkGdTxBw24pZOfbRtG8tLNrRz+RztnCqXbypwm6Sypcw==
X-Received: by 2002:a05:6000:2a2:b0:20c:734f:d38a with SMTP id l2-20020a05600002a200b0020c734fd38amr22637848wry.417.1652862439796;
        Wed, 18 May 2022 01:27:19 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8ba:b9c:a451:5abb? ([2a01:e34:ed2f:f020:8ba:b9c:a451:5abb])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05600c214d00b003942a244ed1sm1087483wml.22.2022.05.18.01.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 01:27:19 -0700 (PDT)
Message-ID: <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
Date:   Wed, 18 May 2022 10:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v9 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517172920.10857-1-j-keerthy@ti.com>
 <20220517172920.10857-2-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220517172920.10857-2-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

I would like to pick this series, does the DT bindings have your blessing ?


On 17/05/2022 19:29, Keerthy wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 63 +++++++++++++++++++
>   1 file changed, 63 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..c74f124ebfc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -0,0 +1,63 @@
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
> +    enum:
> +      - ti,j721e-vtm
> +      - ti,j7200-vtm
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
> +              <0x42050000 0x350>,
> +              <0x43000300 0x10>;
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
> +            mpu_crit: mpu-crit {
> +                temperature = <125000>; /* milliCelsius */
> +                hysteresis = <2000>; /* milliCelsius */
> +                type = "critical";
> +            };
> +        };
> +    };
> +...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
