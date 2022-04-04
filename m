Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8214F1FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiDDXHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiDDXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:07:07 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E7DDF75;
        Mon,  4 Apr 2022 15:33:43 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-df0940c4eeso12468080fac.8;
        Mon, 04 Apr 2022 15:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFbYSyMnRaOAPsRIho8VIJmpmJbNIv9X8l3e2PLIuGk=;
        b=19YlqOHS3QEIY8R2EV8v0673MzxZXvmRHcM1umg9x1a3ARdAX1BGG09wwl2dgLRAE0
         MHh9ngDYEowthte1fnSoqjW8BbNNebfp4SBLiD18dGkcZBKlkFVT6/hkq0eRK6V84xDH
         Tp311VzgHKn0IUnrHYtv8xktMk79BaQmkqkxbO6Mx05ibEfbM5T37xqcf1eYKVv2Hi8A
         8Wj6pgvwEF6KJ4ZSFas4zSqIQkKlEroURXOSACOqn2Rhz1Do9KmFsxxNi3u4UeZ6h1Qz
         SzJYMxQRluj6iH9LgrKYzuKhn8++BA9E+1b7WG8qxGN3jiAHACG+hH/dg5+SO3WSZv/w
         yVfQ==
X-Gm-Message-State: AOAM530PCCm44yehAibdNzEeIepkVIlYu8LxFqjQypZcdjv7Zp0WOYHl
        KIgA54Qwglc6H9XGQ21C0Q==
X-Google-Smtp-Source: ABdhPJzaae1aGrzkF/XNtzMKAMufkywO031pZPgCBLa4mPwpsOz4m9i8r7oqHhE61v4jq/W/VBuLZQ==
X-Received: by 2002:a05:6870:3383:b0:e1:de1c:8cab with SMTP id w3-20020a056870338300b000e1de1c8cabmr244743oae.28.1649111622656;
        Mon, 04 Apr 2022 15:33:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b002da82caced5sm4694284oih.3.2022.04.04.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:33:41 -0700 (PDT)
Received: (nullmailer pid 2123518 invoked by uid 1000);
        Mon, 04 Apr 2022 22:33:40 -0000
Date:   Mon, 4 Apr 2022 17:33:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,smsm: convert to dtschema
Message-ID: <YktyRALDWvNqYDgN@robh.at.kernel.org>
References: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:59:49PM +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory State Machine to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,smsm.txt           | 104 -------------
>  .../bindings/soc/qcom/qcom,smsm.yaml          | 138 ++++++++++++++++++
>  2 files changed, 138 insertions(+), 104 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
> deleted file mode 100644
> index 2993b5a97dd6..000000000000
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -Qualcomm Shared Memory State Machine
> -
> -The Shared Memory State Machine facilitates broadcasting of single bit state
> -information between the processors in a Qualcomm SoC. Each processor is
> -assigned 32 bits of state that can be modified. A processor can through a
> -matrix of bitmaps signal subscription of notifications upon changes to a
> -certain bit owned by a certain remote processor.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: must be one of:
> -		    "qcom,smsm"
> -
> -- qcom,ipc-N:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: three entries specifying the outgoing ipc bit used for
> -		    signaling the N:th remote processor
> -		    - phandle to a syscon node representing the apcs registers
> -		    - u32 representing offset to the register within the syscon
> -		    - u32 representing the ipc bit within the register
> -
> -- qcom,local-host:
> -	Usage: optional
> -	Value type: <u32>
> -	Definition: identifier of the local processor in the list of hosts, or
> -		    in other words specifier of the column in the subscription
> -		    matrix representing the local processor
> -		    defaults to host 0
> -
> -- #address-cells:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be 1
> -
> -- #size-cells:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be 0
> -
> -= SUBNODES
> -Each processor's state bits are described by a subnode of the smsm device node.
> -Nodes can either be flagged as an interrupt-controller to denote a remote
> -processor's state bits or the local processors bits.  The node names are not
> -important.
> -
> -- reg:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: specifies the offset, in words, of the first bit for this
> -		    entry
> -
> -- #qcom,smem-state-cells:
> -	Usage: required for local entry
> -	Value type: <u32>
> -	Definition: must be 1 - denotes bit number
> -
> -- interrupt-controller:
> -	Usage: required for remote entries
> -	Value type: <empty>
> -	Definition: marks the entry as a interrupt-controller and the state bits
> -		    to belong to a remote processor
> -
> -- #interrupt-cells:
> -	Usage: required for remote entries
> -	Value type: <u32>
> -	Definition: must be 2 - denotes bit number and IRQ flags
> -
> -- interrupts:
> -	Usage: required for remote entries
> -	Value type: <prop-encoded-array>
> -	Definition: one entry specifying remote IRQ used by the remote processor
> -		    to signal changes of its state bits
> -
> -
> -= EXAMPLE
> -The following example shows the SMEM setup for controlling properties of the
> -wireless processor, defined from the 8974 apps processor's point-of-view. It
> -encompasses one outbound entry and the outgoing interrupt for the wireless
> -processor.
> -
> -smsm {
> -	compatible = "qcom,smsm";
> -
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -
> -	qcom,ipc-3 = <&apcs 8 19>;
> -
> -	apps_smsm: apps@0 {
> -		reg = <0>;
> -
> -		#qcom,smem-state-cells = <1>;
> -	};
> -
> -	wcnss_smsm: wcnss@7 {
> -		reg = <7>;
> -		interrupts = <0 144 1>;
> -
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> new file mode 100644
> index 000000000000..a40d7fa13325
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,smsm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Shared Memory State Machine
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>

Like I mentioned elsewhere, I'd drop Andy.

> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  The Shared Memory State Machine facilitates broadcasting of single bit state
> +  information between the processors in a Qualcomm SoC. Each processor is
> +  assigned 32 bits of state that can be modified. A processor can through a
> +  matrix of bitmaps signal subscription of notifications upon changes to a
> +  certain bit owned by a certain remote processor.
> +
> +properties:
> +  compatible:
> +    const: qcom,smsm
> +
> +  '#address-cells':
> +    const: 1
> +
> +  qcom,local-host:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description:
> +      Identifier of the local processor in the list of hosts, or in other words
> +      specifier of the column in the subscription matrix representing the local
> +      processor.
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^qcom,ipc-[1-4]$":
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to a syscon node representing the APCS registers
> +          - description: u32 representing offset to the register within the syscon
> +          - description: u32 representing the ipc bit within the register
> +    description:
> +      Three entries specifying the outgoing ipc bit used for signaling the N:th
> +      remote processor.
> +
> +  "^.*@[0-9a-f]$":

Note that dropping '^.*' is equivalent.

Reviewed-by: Rob Herring <robh@kernel.org>
