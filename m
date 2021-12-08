Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83C46D0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhLHKPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:15:08 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:28708 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhLHKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638958296; x=1670494296;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=l+S2zXe567w1avDULeOZ2N9QauXrEcklwudDamCl2o8=;
  b=a9xOkG/wDJdbcd2j2jA4ByQ3igX3A95xLrwzqbL++WM67NX+4pRfYxs5
   r5GP3tuilxopAIYQBdJSVy+qiGeEBSS2W0HEV7d91dNCBPKrD8stOJYpT
   YcBc0em6Nv57B+FMQnCtWwgYRocBqUbXXI2AFwSKz8iv2HyFRvjW85UTT
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Dec 2021 02:11:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:11:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 02:11:34 -0800
Received: from [10.216.32.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 8 Dec 2021
 02:11:28 -0800
Subject: Re: [PATCH v5 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi
 pinctrl bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <plai@codeaurora.org>, <bgoswami@codeaurora.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
 <7ae29aa1-34da-c362-5712-4b787474d7f2@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <bde0c8b0-7244-1bd1-84b6-8efab4f01fa2@quicinc.com>
Date:   Wed, 8 Dec 2021 15:41:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7ae29aa1-34da-c362-5712-4b787474d7f2@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/2021 2:54 PM, Srinivas Kandagatla wrote:
Thanks froYour time Srini!!!
>
> On 07/12/2021 15:35, Srinivasa Rao Mandadapu wrote:
>> Add device tree binding Documentation details for Qualcomm SC7280
>> LPASS LPI pinctrl driver.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>
>
> I remember in my previous review that I requested you to use git mv 
> for renaming this
Yes. Created patch with "git mv" and commit. Not sure why diff is not as 
expected.
>
> If you do that you will endup diff stat something like this:
>
> ------------------------->cut<-----------------------------
> diff --git 
> a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml 
> b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml 
>
> similarity index 97%
> rename from 
> Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> rename to 
> Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> index e47ebf934daf..76f205a47640 100644
> --- 
> a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> +++ 
> b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
> +$id: 
> http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
> ------------------------->cut<-----------------------------
>
> --srini
>
>> .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 
>> +++++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml 
>> b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml 
>>
>> new file mode 100644
>> index 0000000..d32ee32
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> http://devicetree.org/schemas/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
>> +  Low Power Island (LPI) TLMM block
>> +
>> +maintainers:
>> +  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  This binding describes the Top Level Mode Multiplexer block found 
>> in the
>> +  LPASS LPI IP on most Qualcomm SoCs
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sc7280-lpass-lpi-pinctrl
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    description: Specifying the pin number and flags, as defined in
>> +      include/dt-bindings/gpio/gpio.h
>> +    const: 2
>> +
>> +  gpio-ranges:
>> +    maxItems: 1
>> +
>> +#PIN CONFIGURATION NODES
>> +patternProperties:
>> +  '-pins$':
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin 
>> configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: "/schemas/pinctrl/pincfg-node.yaml"
>> +
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in 
>> this
>> +          subnode.
>> +        items:
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-9][0-9])$"
>> +        minItems: 1
>> +        maxItems: 15
>> +
>> +      function:
>> +        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, 
>> qua_mi2s_ws,
>> +                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, 
>> i2s1_clk,
>> +                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
>> +                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, 
>> dmic3_clk,
>> +                dmic3_data, i2s2_data ]
>> +        description:
>> +          Specify the alternative function to be configured for the 
>> specified
>> +          pins.
>> +
>> +      drive-strength:
>> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
>> +        default: 2
>> +        description:
>> +          Selects the drive strength for the specified pins, in mA.
>> +
>> +      slew-rate:
>> +        enum: [0, 1, 2, 3]
>> +        default: 0
>> +        description: |
>> +            0: No adjustments
>> +            1: Higher Slew rate (faster edges)
>> +            2: Lower Slew rate (slower edges)
>> +            3: Reserved (No adjustments)
>> +
>> +      bias-pull-down: true
>> +
>> +      bias-pull-up: true
>> +
>> +      bias-disable: true
>> +
>> +      output-high: true
>> +
>> +      output-low: true
>> +
>> +    required:
>> +      - pins
>> +      - function
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - gpio-controller
>> +  - '#gpio-cells'
>> +  - gpio-ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    lpass_tlmm: pinctrl@33c0000 {
>> +        compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>> +        reg = <0x33c0000 0x20000>,
>> +              <0x3550000 0x10000>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        gpio-ranges = <&lpass_tlmm 0 0 15>;
>> +    };
>>
