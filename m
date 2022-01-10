Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D14489ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiAJSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiAJSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:09:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4EC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:09:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r9so26604848wrg.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GXGwooPMEfozZN6ft3FmkGHZRH13TcEJA6DyxBtW6iI=;
        b=uIbwgrkomMG6Pa4FXc1JGXM68MPxhNJbvAfhGCSJ8rEsvd7VDffQv4kGB5uFzXqyih
         wbWgQpJbt5dun6vBJOV2EOR2ckKN+YNcuCK8AJmGyBDkT6uyLQAxdCPUtvjjw/XMfJzC
         EPyA7D4yu3lHIre4fO4kwAOjJCaluFFy8VxBYFSjZiI9WteRNz/UkwQHSRCfWOTPqPDR
         L5nfB1I7xVF+QjHjRdIW2Mk56Xc0eOH9UNEbLTdASXHe+i9vuJ/wPrd9BmYyf8/6kVHL
         npI6P38WaRw4m43UGyEMxzZ2yx3A/Lxy0GsbD9KzqN/KSkdyCBM6s8UD9ssIgUNRU+5O
         n6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GXGwooPMEfozZN6ft3FmkGHZRH13TcEJA6DyxBtW6iI=;
        b=vVqFRYcqkLFqYylcO2ZdKwGd3G71vBrq+D6qYEQ91aHMDh2eKN8HenjcrOKk7ziaVh
         iiK6cwwZ6PRvD7Q6RXX3GQWh0tlOS0fF6tJ13e/3n8g95GdWWeZI5YJDs4Y8Luwsv+9x
         i3pCfrOwSTpiOs/0ZnC8DPZxNjRkxsyQICHpeDkQG5m49HdiZ0oDjPeqeHD43BPI8HdK
         J1sgQnC2cwIRmX+rKpS3n7VTiSLpZ3pM8jMDj23cN8U5C/SNAv5FPQLqM9gUb3KvY+Wp
         qwKZDMgoO1xaoxCABqEMkImoBS+hFDDiKTRihFmvWGiMOZwKbsNx3ugizBBUTh8dXVw/
         xTEw==
X-Gm-Message-State: AOAM5315ZCtZWyws03ICLwxZsZpanTzXVM9c0YzRD2BhnKCFp+BZLoCt
        GPaspqJYnJfGaS+ZHnYtwkFaBQ==
X-Google-Smtp-Source: ABdhPJzF9akSbX2kr008MfHZ89IfR1xQ9GDCSMvh4eyRYQDQQj439i89+buriCLodYxsVUMcTEZt7w==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr658235wrr.221.1641838189385;
        Mon, 10 Jan 2022 10:09:49 -0800 (PST)
Received: from [192.168.1.20] ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id q206sm7329985wme.8.2022.01.10.10.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:09:48 -0800 (PST)
Message-ID: <13178fd8-ad89-4434-903b-53fc8ce696bd@linaro.org>
Date:   Mon, 10 Jan 2022 18:10:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211227215433.114426-1-david@ixit.cz>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20211227215433.114426-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/12/2021 21:54, David Heidelberg wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
Please resend with From: Caleb Connolly <caleb@connolly.tech>
I'm not sure where authorship got muddled up here.
> 
> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>   - filled many missing compatibles >
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> depends on patch "arm64: dts: qcom: pms405: assign device specific compatible"
> ---
>   .../bindings/mfd/qcom,spmi-pmic.txt           |  93 -----------
>   .../bindings/mfd/qcom,spmi-pmic.yaml          | 152 ++++++++++++++++++
>   2 files changed, 152 insertions(+), 93 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>   create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> deleted file mode 100644
> index 3810a80536f7..000000000000
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -          Qualcomm SPMI PMICs multi-function device bindings
> -
> -The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
> -PMICs.  These PMICs use a QPNP scheme through SPMI interface.
> -QPNP is effectively a partitioning scheme for dividing the SPMI extended
> -register space up into logical pieces, and set of fixed register
> -locations/definitions within these regions, with some of these regions
> -specifically used for interrupt handling.
> -
> -The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
> -interfaced to the chip via the SPMI (System Power Management Interface) bus.
> -Support for multiple independent functions are implemented by splitting the
> -16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
> -each. A function can consume one or more of these fixed-size register regions.
> -
> -Required properties:
> -- compatible:      Should contain one of:
> -                   "qcom,pm660",
> -                   "qcom,pm660l",
> -                   "qcom,pm7325",
> -                   "qcom,pm8004",
> -                   "qcom,pm8005",
> -                   "qcom,pm8019",
> -                   "qcom,pm8028",
> -                   "qcom,pm8110",
> -                   "qcom,pm8150",
> -                   "qcom,pm8150b",
> -                   "qcom,pm8150c",
> -                   "qcom,pm8150l",
> -                   "qcom,pm8226",
> -                   "qcom,pm8350c",
> -                   "qcom,pm8841",
> -                   "qcom,pm8901",
> -                   "qcom,pm8909",
> -                   "qcom,pm8916",
> -                   "qcom,pm8941",
> -                   "qcom,pm8950",
> -                   "qcom,pm8994",
> -                   "qcom,pm8998",
> -                   "qcom,pma8084",
> -                   "qcom,pmd9635",
> -                   "qcom,pmi8950",
> -                   "qcom,pmi8962",
> -                   "qcom,pmi8994",
> -                   "qcom,pmi8998",
> -                   "qcom,pmk8002",
> -                   "qcom,pmk8350",
> -                   "qcom,pmr735a",
> -                   "qcom,smb2351",
> -                   or generalized "qcom,spmi-pmic".
> -- reg:             Specifies the SPMI USID slave address for this device.
> -                   For more information see:
> -                   Documentation/devicetree/bindings/spmi/spmi.yaml
> -
> -Required properties for peripheral child nodes:
> -- compatible:      Should contain "qcom,xxx", where "xxx" is a peripheral name.
> -
> -Optional properties for peripheral child nodes:
> -- interrupts:      Interrupts are specified as a 4-tuple. For more information
> -                   see:
> -                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> -- interrupt-names: Corresponding interrupt name to the interrupts property
> -
> -Each child node of SPMI slave id represents a function of the PMIC. In the
> -example below the rtc device node represents a peripheral of pm8941
> -SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
> -
> -Example:
> -
> -	spmi {
> -		compatible = "qcom,spmi-pmic-arb";
> -
> -		pm8941@0 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x0 SPMI_USID>;
> -
> -			rtc {
> -				compatible = "qcom,rtc";
> -				interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> -				interrupt-names = "alarm";
> -			};
> -		};
> -
> -		pm8941@1 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x1 SPMI_USID>;
> -
> -			regulator {
> -				compatible = "qcom,regulator";
> -				regulator-name = "8941_boost";
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> new file mode 100644
> index 000000000000..11aa2c61eded
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMICs multi-function device
> +
> +description: |
> +  Some Qualcomm PMICs used with the Snapdragon series SoCs are interfaced
> +  to the chip via the SPMI (System Power Management Interface) bus.
> +  Support for multiple independent functions are implemented by splitting the
> +  16-bit SPMI peripheral address space into 256 smaller fixed-size regions, 256 bytes
> +  each. A function can consume one or more of these fixed-size register regions.
> +
> +  The Qualcomm SPMI series includes the PM8941, PM8841, PMA8084, PM8998 and other
> +  PMICs.  These PMICs use a "QPNP" scheme through SPMI interface.
> +  QPNP is effectively a partitioning scheme for dividing the SPMI extended
> +  register space up into logical pieces, and set of fixed register
> +  locations/definitions within these regions, with some of these regions
> +  specifically used for interrupt handling.
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pm660
> +          - qcom,pm660l
> +          - qcom,pm6150
> +          - qcom,pm6150l
> +          - qcom,pm6350
> +          - qcom,pm7325
> +          - qcom,pm8004
> +          - qcom,pm8005
> +          - qcom,pm8009
> +          - qcom,pm8019
> +          - qcom,pm8110
> +          - qcom,pm8150
> +          - qcom,pm8150b
> +          - qcom,pm8150l
> +          - qcom,pm8226
> +          - qcom,pm8350
> +          - qcom,pm8350b
> +          - qcom,pm8350c
> +          - qcom,pm8841
> +          - qcom,pm8909
> +          - qcom,pm8916
> +          - qcom,pm8941
> +          - qcom,pm8950
> +          - qcom,pm8994
> +          - qcom,pm8998
> +          - qcom,pma8084
> +          - qcom,pmd9635
> +          - qcom,pmi8950
> +          - qcom,pmi8962
> +          - qcom,pmi8994
> +          - qcom,pmi8998
> +          - qcom,pmk8350
> +          - qcom,pmm8155au
> +          - qcom,pmr735a
> +          - qcom,pmr735b
> +          - qcom,pms405
> +          - qcom,smb2351
> +      - const: qcom,spmi-pmic
> +
> +  reg: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +
> +patternProperties:
> +  $nodename:
> +    pattern: '^pmic@.*$'
> +
> +  '(labibb|([a-z][a-z0-9]+-)?regulators)':
> +    type: object
> +
> +    required:
> +      - compatible
> +
> +  '@[0-9a-f]+$':
> +    type: object
> +    description: >
> +      Each child node of the PMIC represents a function of it.
> +
> +    properties:
> +      interrupts:
> +        description: >
> +          Interrupts are specified as a 4-tuple. For more information see
> +          Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +
> +      interrupt-names: true
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/spmi/spmi.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spmi@c440000 {
> +        compatible = "qcom,spmi-pmic-arb";
> +        reg = <0x0c440000 0x1100>,
> +              <0x0c600000 0x2000000>,
> +              <0x0e600000 0x100000>,
> +              <0x0e700000 0xa0000>,
> +              <0x0c40a000 0x26000>;
> +        reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +        interrupt-names = "periph_irq";
> +        interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
> +        qcom,ee = <0>;
> +        qcom,channel = <0>;
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        interrupt-controller;
> +        #interrupt-cells = <4>;
> +        cell-index = <0>;
> +
> +        pmi8998_lsid0: pmic@2 {
> +            compatible = "qcom,pmi8998", "qcom,spmi-pmic";
> +            reg = <0x2 SPMI_USID>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            pmi8998_gpio: gpios@c000 {
> +                compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
> +                reg = <0xc000>;
> +                gpio-controller;
> +                gpio-ranges = <&pmi8998_gpio 0 0 14>;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +        };
> +    };

-- 
Kind Regards,
Caleb (they/them)
