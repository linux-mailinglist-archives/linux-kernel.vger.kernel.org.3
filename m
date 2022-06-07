Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F353FE09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbiFGLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiFGLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:53:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2378A05F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:52:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gl15so20808217ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=piPevDvXMOwAc75XwvmVTymrw0B5BQHWDNrVAu3X6IE=;
        b=wVIw55Q3WAwg7C7Av5gAgSOFfDBIdKq09Lx535E9Dn/Zzla0tDuR3s8WBffHGv5qm4
         rJg7LOmUrJ6Yi3FNCkFdQBlLTLZpzDaBK4SFuSzZvxSeA7yPMDOa3H8SowTBar8tDQPM
         xVBuPRnVM4dJRQUp1Mn577eUqZA8ICQ+t5lyFKBcogS060GdBASE4Ma0+uTBiWnTnGs0
         J5bDZtJfnENlhi6zMHkB4AonbNSTrHOnBtoPy9d+b6oXu3grxWlJk2cxG9nPu3x8MKuI
         NSIUVMd7oWZTt/9n/17aMElEvRp0dO6TESJE/nja3YZKca8JvqcySpi/JMgtxoWvZ7SS
         2mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=piPevDvXMOwAc75XwvmVTymrw0B5BQHWDNrVAu3X6IE=;
        b=oIZdZOrwQtccMyVSqUa1CAyV9BVHZdkh99unb/SNnsOB5fh2UbD4oPVljpD3vsxkr5
         WcSkNQFEO54S62EWv+WJ97nUK+2lb3xzU4L+K9st6rswUvZd9XMd7xrnAiR2DNGOnSTi
         RnyD3d3+JHD0ZxVBFL2m/LfmpZXoqDUCGuk045/0249OUelXSgiMLbQNOkbCLeXTNgfa
         Cvh4sSuHdVfNHBGmr0npV+OaOE29zwsqanXDqUqSPLNAQX90nH51ukaG7mORgH6BXIRI
         vW4Rq5iGg/8YoVM6w8FWDX1d92najgGydZwgA0rCJippfn7lr5nvgKgJmZU3HR+wL2s4
         zCdA==
X-Gm-Message-State: AOAM530ebbwi87mqPM5xwQiVvDL33hw1/pLn1KtZEFvY7c5dlHvp28h1
        udnWbye7c8nB+eefMdNzydZuFA==
X-Google-Smtp-Source: ABdhPJylpNNk7xJhZOJCtrgQgkU74x1PYxnCIEo+xs0NtNCWCYhYQHsj29e7UbcnFvMwVi4kULs1tA==
X-Received: by 2002:a17:907:1b05:b0:6f0:18d8:7be0 with SMTP id mp5-20020a1709071b0500b006f018d87be0mr25896461ejc.561.1654602777986;
        Tue, 07 Jun 2022 04:52:57 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m26-20020a50ef1a000000b0042bae6fbee2sm10087662eds.74.2022.06.07.04.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 04:52:57 -0700 (PDT)
Message-ID: <96ecca0b-b65c-749d-d66b-33443cacf2e4@linaro.org>
Date:   Tue, 7 Jun 2022 13:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654581161-12349-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 07:52, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RT5120 PMIC devicetree document.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> new file mode 100644
> index 00000000..376bf73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt5120.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5120 PMIC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT5120 provides four high-efficiency buck converters and one LDO voltage
> +  regulator. The device is targeted at providingthe processor voltage, memory,
> +  I/O, and peripheral rails in home entertainment devices. The I2C interface is
> +  used for dynamic voltage scaling of the processor voltage, power rails on/off
> +  sequence control, operation mode selection.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5120
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  wakeup-source: true
> +
> +  richtek,enable-undervolt-hiccup:
> +    type: boolean
> +    description: |
> +      If used, under voltage protection trigger hiccup behavior, else latchup as
> +      default
> +
> +  richtek,enable-overvolt-hiccup:
> +    type: boolean
> +    description:
> +      Like as 'enable-uv-hiccup', it configures over voltage protection to
> +      hiccup, else latchup as default
> +
> +  vin1-supply:
> +    description: phandle for buck1 input power source
> +
> +  vin2-supply:
> +    description: phandle for buck2 input power source
> +
> +  vin3-supply:
> +    description: phandle for buck3 input power source
> +
> +  vin4-supply:
> +    description: phandle for buck4 input power source
> +
> +  vinldo-supply:
> +    description: phandle for ldo input power source
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^buck[1-4]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +
> +        properties:
> +          regulator-allowed-modes:
> +            description: |
> +              Used to specify the allowed buck converter operating mode
> +              mode mapping:
> +                0: auto mode
> +                1: force pwm mode
> +            items:
> +              enum: [0, 1]
> +
> +        unevaluatedProperties: false

Better to put it after '$ref' for readability.

> +
> +      "^(ldo|exten)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#

You need here unevaluatedProperties:false as well (for the ldo/exten
properties)

> +
> +    additionalProperties: false
> +
> +  powerkey:
> +    type: object
> +    description:
> +      The power key driver may be optional. If not used, change node status to
> +      'disabled'

This description is not helpful, does not describe the hardware. Please
describe hardware, not Devicetree usage.

> +
> +    properties:
> +      compatible:
> +        enum:
> +          - richtek,rt5120-pwrkey
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - regulators
> +  - powerkey

You wrote powerkey is optional... so the node should not be required, right?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@62 {
> +        compatible = "richtek,rt5120";
> +        reg = <0x62>;
> +        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        wakeup-source;
> +
> +        regulators {
> +          buck1 {
> +            regulator-name = "rt5120-buck1";
> +            regulator-min-microvolt = <600000>;
> +            regulator-max-microvolt = <1393750>;
> +            regulator-allowed-modes = <0 1>;
> +            regulator-boot-on;
> +          };
> +          buck2 {
> +            regulator-name = "rt5120-buck2";
> +            regulator-min-microvolt = <1100000>;
> +            regulator-max-microvolt = <1100000>;
> +            regulator-allowed-modes = <0 1>;
> +            regulator-always-on;
> +          };
> +          buck3 {
> +            regulator-name = "rt5120-buck3";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-allowed-modes = <0 1>;
> +            regulator-always-on;
> +          };
> +          buck4 {
> +            regulator-name = "rt5120-buck4";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-allowed-modes = <0 1>;
> +            regulator-always-on;
> +          };
> +          ldo {
> +            regulator-name = "rt5120-ldo";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-always-on;
> +          };
> +          exten {
> +            regulator-name = "rt5120-exten";
> +            regulator-min-microvolt = <3000000>;
> +            regulator-max-microvolt = <3000000>;
> +            regulator-always-on;
> +          };
> +        };
> +        powerkey {
> +                status = "okay";

Messed up indentation. No need for status in examples.

> +                compatible = "richtek,rt5120-pwrkey";
> +        };
> +      };
> +    };


Best regards,
Krzysztof
