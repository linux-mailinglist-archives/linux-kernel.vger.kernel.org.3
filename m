Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD746353B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhK3NUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhK3NUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:20:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733FBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:17:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so44374634wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hYpaXVepDL6CrAHIWw3+OOCTiVuiY5cF93LIHOqBsM4=;
        b=yi8zACHxmR5vtP1uBWnMkBI7hZVPSyjyGSjFwWmlkQCK+rEMcSnvV20sMyPNa8Id1v
         EaCGmwLACXUxjyFPYyVJy5cLEdyVf4kYaQAjZRuRt5QJj2LYGCwBfKMPZwIyjMx2H0i2
         S5p8/zTT3V/qQiQDlhwzWD9F4r9HA0GOsk9YewbLUMmuHC8yqGGdk2lyDRhlzdFCZgp0
         66+dl7qTa4vRz4F2wFmVh9mpsQYP2eafBs0qb0TgYHhRPDfTt5OxJVAIxqPF71zCoNfh
         6+JSvjiEL7+YaTbopmRPq5Wk4mEVuJoU07/ey26osfNGOaxlZhxSupcdAssL10sPY2ho
         vS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYpaXVepDL6CrAHIWw3+OOCTiVuiY5cF93LIHOqBsM4=;
        b=E1/yW3sndqn+SH62nD44e5zNenazSKhhJl1PYvsMd9crrmSQDCdyjxJCxUoiMyEr1k
         8Dcx2oQ7AD7t/xSv5r2JAogfWjDuHv/17peUXbfz1WR+ax8BFBvmR87sNbYmKhusVR8c
         FfVIqROL7e9kBHc8xs26RDePZgnmFHW2rIEHBFHPbj1mfr/sOio4li1zxMK175pJJVlZ
         TX3S6nyLnEfZ8i4TogRMBG/p76Jhse8jVKf/cHWjaLo8+UUwEviPll1yDvlaqNzYIeuR
         BXalKoR3O+czUKvn10dK9d1JpADR8Jp7kJFZFJ7CymoWTPAsz6jwMpgRfeIIUE4aciRk
         m+6g==
X-Gm-Message-State: AOAM532BAMtTLcsqBHxhcGT3Bso74bl7sQZ4PtlEFJmy/JemytyJUg1x
        O+6FXov7nqFQxZFhRzIYEzbsRw==
X-Google-Smtp-Source: ABdhPJwUpGOs2kW8YRz1C1OMNeuNWpL4NC2ua+VZ4avjJ2rNvgPOi3vsBsnfVtuYLuLtbybSifvqNw==
X-Received: by 2002:a5d:58f9:: with SMTP id f25mr40093926wrd.206.1638278250021;
        Tue, 30 Nov 2021 05:17:30 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id d2sm2394594wmb.31.2021.11.30.05.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 05:17:29 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: misc: add fastrpc domain vmid property
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        ekangupt@qti.qualcomm.com, jeyr@qti.qualcomm.com
References: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
 <1638277072-6459-2-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <21a9313d-ecb7-9d39-fe60-4e565009783e@linaro.org>
Date:   Tue, 30 Nov 2021 13:17:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638277072-6459-2-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2021 12:57, Jeya R wrote:
> Add fastrpc domain virtual machine IDs property. This property is used
> to setup memory protection for remote processor.
> 
> "This patch depends on “dt-bindings: misc: fastrpc convert bindings to yaml"
> (https://patchwork.kernel.org/project/linux-arm-msm/patch/20211130092846.18804-1-srinivas.kandagatla@linaro.org/)"
> 


This comment should go after  ---


There is something wrong with the patch, You seems to have send wrong 
patch which does not match the subject line nor I see vmid property.

--srini

> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   .../devicetree/bindings/misc/qcom,fastrpc.txt      |  78 ---------------
>   .../devicetree/bindings/misc/qcom,fastrpc.yaml     | 109 +++++++++++++++++++++
>   2 files changed, 109 insertions(+), 78 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> deleted file mode 100644
> index 2a1827a..0000000
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -Qualcomm Technologies, Inc. FastRPC Driver
> -
> -The FastRPC implements an IPC (Inter-Processor Communication)
> -mechanism that allows for clients to transparently make remote method
> -invocations across DSP and APPS boundaries. This enables developers
> -to offload tasks to the DSP and free up the application processor for
> -other tasks.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc"
> -
> -- label
> -	Usage: required
> -	Value type: <string>
> -	Definition: should specify the dsp domain name this fastrpc
> -	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
> -
> -- #address-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 1
> -
> -- #size-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 0
> -
> -= COMPUTE BANKS
> -Each subnode of the Fastrpc represents compute context banks available
> -on the dsp.
> -- All Compute context banks MUST contain the following properties:
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc-compute-cb"
> -
> -- reg
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Context Bank ID.
> -
> -- qcom,nsessions:
> -	Usage: Optional
> -	Value type: <u32>
> -	Defination: A value indicating how many sessions can share this
> -		    context bank. Defaults to 1 when this property
> -		    is not specified.
> -
> -Example:
> -
> -adsp-pil {
> -	compatible = "qcom,msm8996-adsp-pil";
> -	...
> -	smd-edge {
> -		label = "lpass";
> -		fastrpc {
> -			compatible = "qcom,fastrpc";
> -			qcom,smd-channels = "fastrpcsmd-apps-dsp";
> -			label = "adsp";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			cb@1 {
> -				compatible = "qcom,fastrpc-compute-cb";
> -				reg = <1>;
> -			};
> -
> -			cb@2 {
> -				compatible = "qcom,fastrpc-compute-cb";
> -				reg = <2>;
> -			};
> -			...
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> new file mode 100644
> index 0000000..a9fd93c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Technologies, Inc. FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes Qualcomm FastRPC an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries. This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks.
> +
> +properties:
> +  compatible:
> +    const: qcom,fastrpc
> +
> +  label:
> +    enum:
> +      - adsp
> +      - mdsp
> +      - sdsp
> +      - cdsp
> +
> +  qcom,nsessions:
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    description: Virtual machine IDs of remote processor which is used to
> +                 setup memory protection.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^cb@[0-9a-f]$":
> +    type: object
> +    description: |
> +      Compute context bank
> +
> +    properties:
> +      compatible:
> +        const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +        description: Context Bank ID
> +
> +      qcom,nsessions:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: How many sessions can share this context bank.
> +                     Defaults to 1 when this property is not specified.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - label
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adsp {
> +        compatible = "qcom,msm8996-adsp-pil";
> +        interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
> +        clocks = <&xo_board>;
> +        clock-names = "xo";
> +        memory-region = <&adsp_region>;
> +        qcom,smem-states = <&smp2p_adsp_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        smd-edge {
> +            label = "lpass";
> +
> +            fastrpc {
> +                compatible = "qcom,fastrpc";
> +                label = "adsp";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                cb@1 {
> +                    compatible = "qcom,fastrpc-compute-cb";
> +                    reg = <1>;
> +                };
> +
> +                cb@2 {
> +                    compatible = "qcom,fastrpc-compute-cb";
> +                    reg = <2>;
> +                };
> +            };
> +        };
> +    };
> 
