Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929685AE015
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIFGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiIFGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:45:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2121E08
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:45:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z29so15836864lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 23:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZBvc14dw1aVjJGwRcNxp9/bKqOeZSOpSOdkaETJzKoo=;
        b=UOGjVcRMaOqvf6IdAdT/eVbiWpywhHfbWqzJa9n9DKRMf6qnFLfAzVim09JtXEVWwn
         g0mfjUu0+HhnqT5i/YgSSMhp+nmxexEbYNKBE07wvZCN9NFm9pw9+EexZIj/pdozSs3p
         twczIBZo6QI592NP5U+HBIx9TXfi9nOBdCCrOhfEiF5gNrnvUprWFcb+BF0m9V62e24X
         QBKc45m25S0GFlFZWh1kdFecsMqQ6MR2VNNZmevfq0wajDLKhoruM0KgYbPIQfN1dH2d
         nIhnwrWMMcs36qz+Wg+DchuxFtHyIHnMWa4FoOkAqB9BwzhwkVZwyXOZECVJJHBIHJtQ
         87ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZBvc14dw1aVjJGwRcNxp9/bKqOeZSOpSOdkaETJzKoo=;
        b=O932PyzGej6UiWc6bPLWZ9DBy996e/MojIkgo898+GoqafHtRjg6H2W5beB+DfL68l
         AceILdX/508xpyZV3lTOGm7jy0ge6+l+BXvzf+3wPLDDA1NxkHlq/bTgJrt8b59sxjHI
         JUYaYZQZs/MRHIRZ8GjLKl/2cQaed7o8BhMNL115ICtImg5Eul4iS3C2ynZ1LfiM6YQJ
         JHfTKsisflGcK1cLb0LqQ++DA3/Xn9Y6QqyxWtbk8qIVa3Ki8UzKdwQ/ISPGAUfZu7PP
         Dx2U3BvUh+BqiNrbYsskh3eQQf13v6eIPxcY0emJkYxZXT2hf8yqYavD//ctvPB3ljss
         OyDA==
X-Gm-Message-State: ACgBeo14yjxLlXwNClqo6CtlBuCsJshqir7J92VLVkkj1bELWzS6PZeK
        9NeUOGNjps1RHxsseTgRhzBrxA==
X-Google-Smtp-Source: AA6agR68RCDkvcQYd4i357fiq8OQ6A3BDAvEAXsz8NzphwPiJOHiCBWDhKaGjd6UJ0R0Fkj8wTfHDg==
X-Received: by 2002:a05:6512:1284:b0:496:91bc:39cc with SMTP id u4-20020a056512128400b0049691bc39ccmr1480001lfs.531.1662446724694;
        Mon, 05 Sep 2022 23:45:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b0048b365176d9sm1525832lfq.286.2022.09.05.23.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 23:45:24 -0700 (PDT)
Message-ID: <3649a134-0ea7-b67c-8b5a-2971f090446c@linaro.org>
Date:   Tue, 6 Sep 2022 08:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v7 1/2] dt-bindings: misc: fastrpc convert bindings to
 yaml
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20220905144554.1772073-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905144554.1772073-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 16:45, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@.
> 
> Also add qcom,non-secure-domain, qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't
> fail right off the bat.

qcom,non-secure-domain is in original binding, so I don't understand why
it is being "added".

> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v6:
>  * renamed the parent node name in the example from smd-edge to glink-edge
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 118 ++++++++++++++++++

As you can see in Rob's bot report - the patchset introduces errors and
is not bisectable.

You also need to fix qcom,glink-edge.yaml

>  2 files changed, 118 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> deleted file mode 100644
> index 5ec124b138a6..000000000000
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> +++ /dev/null
> @@ -1,88 +0,0 @@
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
> -- qcom,non-secure-domain:
> -	Usage: required
> -	Value type: <boolean>
> -	Definition: Property to specify that dsp domain is non-secure.
> -
> -- qcom,vmids:
> -	Usage: optional
> -	Value type: <u32 array>
> -	Definition: Virtual machine IDs for remote processor.

You miss qcom,vmids in the conversion.

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
> index 000000000000..2b446272cc14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,118 @@
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

no "items", as it is not a list.

> +      - const: qcom,fastrpc
> +
> +  label:
> +    items:

ditto (plus this actually does not define even how many items)

> +      enum:
> +        - adsp
> +        - mdsp
> +        - sdsp
> +        - cdsp
> +
> +  qcom,glink-channels:
> +    description:
> +      A list of channels tied to this function, used for matching
> +      the function to a set of virtual channels.
> +    $ref: "/schemas/types.yaml#/definitions/string-array"

maxItems: 1

> +
> +  qcom,non-secure-domain:
> +    description:
> +      Used to mark the current domain as non-secure.
> +    type: boolean
> +
> +  qcom,smd-channels:
> +    description:
> +      Channel name used for the RPM communication
> +    $ref: "/schemas/types.yaml#/definitions/string-array"

maxItems: 1


> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "(compute-)?cb@[0-9]*$":
> +    type: object
> +
> +    description: >
> +      Each subnode of the Fastrpc represents compute context banks available on the dsp.
> +
> +    properties:
> +      compatible:
> +        items:

Drop items

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
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'

Use consistent quotes, either ' or "



Best regards,
Krzysztof
