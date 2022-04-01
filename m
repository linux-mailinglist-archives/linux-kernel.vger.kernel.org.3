Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2124EF927
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiDARtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351180AbiDARs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:48:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD122EE5B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:47:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d7so5254989wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=efz6kQHlKSDKuo0UJzo1gGazPM6P/T8R4LJSdPrvKJs=;
        b=n7ATkdGp7ME3W7umtrkKxdU2MECDroSb4NlocHystdlRv5nOZyIaGgB8yQYAGAbHh6
         7x4LJYTGw8n61emmuUEIZrje/aAMkfxzgoiy0FYky++oHGHpaBNfsJkKVw74Xn1LY9fT
         x6usEKYbrmyjeubM5Yw4nZ+7bxtsTCjoOfOQPsrY1kXiel4e8IhdXzfTEb6VsiRmPZHg
         ajTwgjuPbkZncXCpBY97sDi23JbcGYmRMwGwTrlO7x4aOyrKi3HTUFLdfbksbhfWHYvd
         bwonzzRv3O4gJoNVl4QbJac0CjjgY1qiVZDGOdwQUYBN8Sy+Qip7T49wA6hnpjbX8MRr
         cpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=efz6kQHlKSDKuo0UJzo1gGazPM6P/T8R4LJSdPrvKJs=;
        b=KaAWARTs9r8NIuOkpaFiy0Iixk7Du1wiklrxvrmUwospGC4SGzLAcghV2gtI+JlLb2
         vOSXaVnVqRSEv65JaDJk84GJgrJ96WN8NBzl2Kuf0ZezjfT/bX2xrKUY0P9HW4ahBU5d
         JvLF+4dZ9MJr+4WzFWK5iQbGbPB6nDRlgF3VxYnz8S16RVjOKzTCbVi4+QiaenWtXESm
         SRAjLzWGkOKEo+WuE0qawEJz7skgmgfYGXNBu+B9wRNG0lDKpTV6w7qwst4+w4dL2Oc1
         hrVcy+BgN1vceK/n9RHW6bjTo+Mmrv2+juhRoQIrFsMYzBatd+NnhlGVzOyEn3l12PtW
         y7hQ==
X-Gm-Message-State: AOAM532ZXS6mGKlfKrIMRQn2Vx9tSSF2udzf8VjDXJDMa64XozGOZHB/
        Xwhlm2wEJV4CViU2z3nlKWd0t24CgVkALxi+
X-Google-Smtp-Source: ABdhPJzQS49mhQ/58uhTnHcYWbrUqN+CyydIJtnWl9USCFiQdLlIwLc3SH0snLXOldWSdeDoyQPM5w==
X-Received: by 2002:adf:fb0b:0:b0:205:dfbd:8601 with SMTP id c11-20020adffb0b000000b00205dfbd8601mr8150339wrr.527.1648835224884;
        Fri, 01 Apr 2022 10:47:04 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm2779448wrg.70.2022.04.01.10.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 10:47:04 -0700 (PDT)
Message-ID: <5b0b3301-d92b-3eae-fb91-9b6388103f8c@linaro.org>
Date:   Fri, 1 Apr 2022 19:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: qcom,smp2p: convert to dtschema
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 19:10, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,smp2p.txt          | 110 -------------
>  .../bindings/soc/qcom/qcom,smp2p.yaml         | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 110 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
> deleted file mode 100644
> index 49e1d72d3648..000000000000
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -Qualcomm Shared Memory Point 2 Point binding
> -
> -The Shared Memory Point to Point (SMP2P) protocol facilitates communication of
> -a single 32-bit value between two processors.  Each value has a single writer
> -(the local side) and a single reader (the remote side).  Values are uniquely
> -identified in the system by the directed edge (local processor ID to remote
> -processor ID) and a string identifier.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: must be one of:
> -		    "qcom,smp2p"
> -
> -- interrupts:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: one entry specifying the smp2p notification interrupt
> -
> -- mboxes:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: reference to the associated doorbell in APCS, as described
> -		    in mailbox/mailbox.txt
> -
> -- qcom,ipc:
> -	Usage: required, unless mboxes is specified
> -	Value type: <prop-encoded-array>
> -	Definition: three entries specifying the outgoing ipc bit used for
> -		    signaling the remote end of the smp2p edge:
> -		    - phandle to a syscon node representing the apcs registers
> -		    - u32 representing offset to the register within the syscon
> -		    - u32 representing the ipc bit within the register
> -
> -- qcom,smem:
> -	Usage: required
> -	Value type: <u32 array>
> -	Definition: two identifiers of the inbound and outbound smem items used
> -		    for this edge
> -
> -- qcom,local-pid:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: specifies the identifier of the local endpoint of this edge
> -
> -- qcom,remote-pid:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: specifies the identifier of the remote endpoint of this edge
> -
> -= SUBNODES
> -Each SMP2P pair contain a set of inbound and outbound entries, these are
> -described in subnodes of the smp2p device node. The node names are not
> -important.
> -
> -- qcom,entry-name:
> -	Usage: required
> -	Value type: <string>
> -	Definition: specifies the name of this entry, for inbound entries this
> -		    will be used to match against the remotely allocated entry
> -		    and for outbound entries this name is used for allocating
> -		    entries
> -
> -- interrupt-controller:
> -	Usage: required for incoming entries
> -	Value type: <empty>
> -	Definition: marks the entry as inbound; the node should be specified
> -		    as a two cell interrupt-controller as defined in
> -		    "../interrupt-controller/interrupts.txt"
> -		    If not specified this node will denote the outgoing entry
> -
> -- #interrupt-cells:
> -	Usage: required for incoming entries
> -	Value type: <u32>
> -	Definition: must be 2 - denoting the bit in the entry and IRQ flags
> -
> -- #qcom,smem-state-cells:
> -	Usage: required for outgoing entries
> -	Value type: <u32>
> -	Definition: must be 1 - denoting the bit in the entry
> -
> -= EXAMPLE
> -The following example shows the SMP2P setup with the wireless processor,
> -defined from the 8974 apps processor's point-of-view. It encompasses one
> -inbound and one outbound entry:
> -
> -wcnss-smp2p {
> -	compatible = "qcom,smp2p";
> -	qcom,smem = <431>, <451>;
> -
> -	interrupts = <0 143 1>;
> -
> -	qcom,ipc = <&apcs 8 18>;
> -
> -	qcom,local-pid = <0>;
> -	qcom,remote-pid = <4>;
> -
> -	wcnss_smp2p_out: master-kernel {
> -		qcom,entry-name = "master-kernel";
> -
> -		#qcom,smem-state-cells = <1>;
> -	};
> -
> -	wcnss_smp2p_in: slave-kernel {
> -		qcom,entry-name = "slave-kernel";
> -
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> new file mode 100644
> index 000000000000..8c362ce3c05b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,smp2p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Shared Memory Point 2 Point
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  The Shared Memory Point to Point (SMP2P) protocol facilitates communication
> +  of a single 32-bit value between two processors.  Each value has a single
> +  writer (the local side) and a single reader (the remote side).  Values are
> +  uniquely identified in the system by the directed edge (local processor ID to
> +  remote processor ID) and a string identifier.
> +
> +properties:
> +  compatible:
> +    const: qcom,smp2p
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Reference to the mailbox representing the outgoing doorbell in APCS for
> +      this client.
> +
> +  qcom,ipc:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to a syscon node representing the apcs registers
> +          - description: u32 representing offset to the register within the syscon
> +          - description: u32 representing the ipc bit within the register
> +    description:
> +      Three entries specifying the outgoing ipc bit used for signaling the
> +      remote end of the smp2p edge.
> +
> +  qcom,local-pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

While converting the next schema (SMD) I found here a mistake. This is
not an array, but one number.

I'll send a v2.


Best regards,
Krzysztof
