Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0651F2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiEIDZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiEIDWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:22:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B5941A0;
        Sun,  8 May 2022 20:18:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2493IHdW085931;
        Sun, 8 May 2022 22:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652066297;
        bh=lrwTkKgCgSSEev9c5TfJpMVwLN2aiNmjYPqohHDbx14=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qeur2vGO4zz758AaWb38eD9xkz+UEdXU5vMbuukvTRCQlLYBI9cogkNpk7P6+H/ml
         xujzbcpRd1YbBFUdVfS0oiURlLpjmTxmAgD1Ha4gvDIDdem04UhIMu7xUk9fUPuPZs
         KmxOWpDbZL5AhmiXdiPaQRk5UWgZBqaTbhkZQSOg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2493IHGC063722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 May 2022 22:18:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 8
 May 2022 22:18:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 8 May 2022 22:18:16 -0500
Received: from [10.250.234.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2493ICQA006580;
        Sun, 8 May 2022 22:18:13 -0500
Message-ID: <5859fed0-82b7-95eb-5719-9b0016916c50@ti.com>
Date:   Mon, 9 May 2022 08:48:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-2-j-keerthy@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20220427064635.24898-2-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2022 12:16 PM, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.

Hi krzysztof,

Any comments on this version?

- Keerthy

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 64 +++++++++++++++++++
>   1 file changed, 64 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..84b70fb108da
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
> +    maxItems: 3
> +    description:
> +      Must be 3, in order to specify three register spaces for VTM cfg1, cfg2
> +      and efuse register space.
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
