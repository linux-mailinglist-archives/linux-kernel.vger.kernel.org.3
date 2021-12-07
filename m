Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6C46C018
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhLGQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbhLGQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:00:07 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA0FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 07:56:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so30403576wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s04DWXu5NLwyK43+n0H/Fmx6iCKArUlT2QSk1QCIXEA=;
        b=leLkaw4Wq4nrnYqRR9i+abimOSRyJ+xJHXAVfqjj+KuC25tQnYy5B0vVrQS/qMzUfv
         Nzx0Yc1/d8FmVVwS6NNwL81AmJmkekro1sv4KyZcFuf5jb+l3iQQ9lQk6kCK1ld3pvr1
         dMnxEv9T1vJTd9yaSL8QI8qOi/YqngfClRtusBdrp2eD85vVar9OmInaq8LtUAXrzbqB
         x2iYS+0r4q9sXr5Owqi3XjZXwMC0tOOYiLSPKJl62VOEL0rpErsrHTYOm5lzHy5tjOL2
         jiF7lRj7rSuVlNwYEensr/mIw6DHml4OQsxn7aicDRaCL2JCH/4JMQH4nEdm372RUWHy
         1H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s04DWXu5NLwyK43+n0H/Fmx6iCKArUlT2QSk1QCIXEA=;
        b=e7EbHvWxD0KaAUktGfYbB3irP1WF03CF+02fqx6kvI6DBwmAqw70188+Eqvrd+xp1c
         x6ugOifbWkkw/8Ts0W8V/J44daIUUOIxihG/T+h6mKFzYPrufDTL/XcyVMkfQrbcrsZq
         15yJwUguJg0gCsl4c5LJiozxVr1YmetQgoE7EXchlLw5QC/k4Kr8MSF+iwzBq6xvLFQS
         FX6unJuW9Ej3eYP+Jan4XR0gDRik7jhwRx0aer6rSpcmDkJVSkn0u4Z63znU95f9J3xZ
         9UP3CNkh3mmcWkwmW3MYcOu7TVN1wAwtDk6W4DbchZdaiPWqo0pt02oI2v5QriONEY9E
         NjyA==
X-Gm-Message-State: AOAM531CSl/r7GnxmpoT2EljHhFU4i1BTIIjvwoe/85Y+McwbmqoFg+O
        exHf/OJrYsiPEZ9WN3pZQP9KEjwIcJn1yA==
X-Google-Smtp-Source: ABdhPJxQBhRnVCXcNj/xSOYLWlR2ziSKQKPnBd1I2FJAjBpy539Q0U8rvPoTbp2fFBr9e85jDnZDXQ==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr50812916wro.169.1638892595418;
        Tue, 07 Dec 2021 07:56:35 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id j17sm11346wmq.41.2021.12.07.07.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:56:34 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: misc: convert Qualcomm FastRPC bindings to
 the YAML schema
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206193849.109079-1-david@ixit.cz>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f631075-85d0-7362-e3d6-b3abaec465e0@linaro.org>
Date:   Tue, 7 Dec 2021 15:56:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206193849.109079-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for the patch,


On 06/12/2021 19:38, David Heidelberg wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Also:
>   - simplify example
>   - embrace compute-cb@ subnodes instead of just cb@
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>


There is already a similar patch [1] in the list. If you have noticed 
it, Its better to let the author know about your plans so that we do not 
duplicate the same thing.

Your patch seems to have addressed issues with subnode names and example.

so am okay with this patch.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


FastRPC patches normally go via char-misc tree, so if Rob acks can you 
send it to Greg as well.


--srini


> ---
>   .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 ---------------
>   .../bindings/misc/qcom,fastrpc.yaml           | 94 +++++++++++++++++++
>   2 files changed, 94 insertions(+), 78 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> deleted file mode 100644
> index 2a1827ab50d2..000000000000
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
> index 000000000000..f42ab208a7fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  The FastRPC implements an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries. This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,fastrpc
> +
> +  label:
> +    items:
> +      enum:
> +        - adsp
> +        - mdsp
> +        - sdsp
> +        - cdsp
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "(compute-)?cb@[0-9]$":
> +    type: object
> +
> +    description: >
> +      Each subnode of the Fastrpc represents compute context banks available on the dsp.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +
> +      qcom,nsession:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 1
> +        description: >
> +          A value indicating how many sessions can share this context bank.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    smd-edge {
> +        label = "lpass";
> +        fastrpc {
> +            compatible = "qcom,fastrpc";
> +            label = "adsp";
> +            qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            compute-cb@1 {
> +                compatible = "qcom,fastrpc-compute-cb";
> +                reg = <1>;
> +            };
> +
> +            compute-cb@2 {
> +                compatible = "qcom,fastrpc-compute-cb";
> +                reg = <2>;
> +            };
> +        };
> +    };
> 
[1] 
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20211130092846.18804-1-srinivas.kandagatla@linaro.org/
