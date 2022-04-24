Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364250D214
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiDXNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiDXNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:39:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF1BF95B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:36:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g23so8571277edy.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/EdG3nHwTGUCliwTmZJUfLlt3R/Q52QoI4USODyrZfw=;
        b=qp1u0vQKHX7wv7Q6+Xuc8ngCOKGvQvZdVYW6bTt8Fq/+2diNEq3D3lGFa6YaH3JfBE
         9mFClXex0r33AT8UjbYBy2txHvXkjs9jqudPi7ddcDdDexudDU7sGEgpFOMLxxXJrByX
         t2BIkqj5E5tOd7RnHjUWlepuuCEFKtuXZ09JCKEOP10HS9qTJU83FQbdUBL6VOlfDiWs
         QvOBG1+R6vIplrlgyMDw5SiOXQDuLK2zwBZeu7CH8aWrHO9eIMqhRDI2cWqGXAnqWp3y
         vmTOUjiKPZDn+LZ7E4ULmOTcEzMR/6vshgsGoXrNjVJpPs7tVts5SBpJembzQrT+C8xD
         On+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/EdG3nHwTGUCliwTmZJUfLlt3R/Q52QoI4USODyrZfw=;
        b=hN5377MjGHd8y3L2XoV9B7SGUuyZNvLq9SQfb1xV7MdmlrxR0wSfbSvdgulXQdy17C
         tH+byuvdKGD5HaPF+cNQWybDx40tQ8mHfEI93gqN9uFBB5GsU5047JQIHFgABmFp7VJs
         +IT9+1yjh1kiJ7FCA5bTbkxYfCwdi/TpHo0slkLxC8h7TKO5N6T+deHLkDkZPb3oHyGw
         SJ/WX+FZ2HsWrANxrAU8DmxmIDVPKGHZxkOFFsOPZ56BcYGyoOZF/siRtnUM+HLbXCOm
         r4Jsey7GR6CDCw4OqNj5T5Nyx5pOWhdltK0iZA8v5/rAfQZRVuNJv74v83ImbRv7FL9p
         C5TA==
X-Gm-Message-State: AOAM532XMC/03XKN4yuwIFsQlpPNqXdSQrlu+l33A7dQRgUha+NkqmOg
        0TWDz/vzQYxx3CAnslTvl7shgg==
X-Google-Smtp-Source: ABdhPJxlpPGEItk3eQNtWahn1dRXGvHCtQE8Qy+39QGAT0sGcc2ILpn0RBqxOYTuFMVN5KYjpzL1Zg==
X-Received: by 2002:a05:6402:298c:b0:41d:6b63:aa67 with SMTP id eq12-20020a056402298c00b0041d6b63aa67mr14446366edb.42.1650807385592;
        Sun, 24 Apr 2022 06:36:25 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s5-20020a508dc5000000b004241a4abbdfsm3319529edh.45.2022.04.24.06.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 06:36:25 -0700 (PDT)
Message-ID: <184784e4-0a85-c0bb-fdda-b8c41d8abc0f@linaro.org>
Date:   Sun, 24 Apr 2022 15:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220424101637.20721-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424101637.20721-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 12:16, David Heidelberg wrote:
> Convert Qualcomm GLINK binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v1:
>  - remove quotes around qcom,intent
>  - use additionalProperties

Thank you for your patch. There is something to discuss/improve.

> 
>  .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
>  .../bindings/soc/qcom/qcom,glink.yaml         | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> deleted file mode 100644
> index 1214192847ac..000000000000
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -Qualcomm GLINK edge binding
> -
> -This binding describes a Qualcomm GLINK edge, a fifo based mechanism for
> -communication between subsystem-pairs on various Qualcomm platforms. Two types
> -of edges can be described by the binding; the GLINK RPM edge and a SMEM based
> -edge.
> -
> -- compatible:
> -	Usage: required for glink-rpm
> -	Value type: <stringlist>
> -	Definition: must be "qcom,glink-rpm"
> -
> -- label:
> -	Usage: optional
> -	Value type: <string>
> -	Definition: should specify the subsystem name this edge corresponds to.
> -
> -- interrupts:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: should specify the IRQ used by the remote processor to
> -		    signal this processor about communication related events
> -
> -- qcom,remote-pid:
> -	Usage: required for glink-smem
> -	Value type: <u32>
> -	Definition: specifies the identifier of the remote endpoint of this edge
> -
> -- qcom,rpm-msg-ram:
> -	Usage: required for glink-rpm
> -	Value type: <prop-encoded-array>
> -	Definition: handle to RPM message memory resource
> -
> -- mboxes:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: reference to the "rpm_hlos" mailbox in APCS, as described
> -		    in mailbox/mailbox.txt
> -
> -= GLINK DEVICES
> -Each subnode of the GLINK node represent function tied to a virtual
> -communication channel. The name of the nodes are not important. The properties
> -of these nodes are defined by the individual bindings for the specific function
> -- but must contain the following property:
> -
> -- qcom,glink-channels:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: a list of channels tied to this function, used for matching
> -		    the function to a set of virtual channels
> -
> -- qcom,intents:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: a list of size,amount pairs describing what intents should
> -		    be preallocated for this virtual channel. This can be used
> -		    to tweak the default intents available for the channel to
> -		    meet expectations of the remote.
> -
> -= EXAMPLE
> -The following example represents the GLINK RPM node on a MSM8996 device, with
> -the function for the "rpm_request" channel defined, which is used for
> -regulators and root clocks.
> -
> -	apcs_glb: mailbox@9820000 {
> -		compatible = "qcom,msm8996-apcs-hmss-global";
> -		reg = <0x9820000 0x1000>;
> -
> -		#mbox-cells = <1>;
> -	};
> -
> -	rpm_msg_ram: memory@68000 {
> -		compatible = "qcom,rpm-msg-ram";
> -		reg = <0x68000 0x6000>;
> -	};
> -
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm-requests {
> -			compatible = "qcom,rpm-msm8996";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			qcom,intents = <0x400 5
> -					0x800 1>;
> -			...
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> new file mode 100644
> index 000000000000..12ccc875ff0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,glink.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm GLINK edge
> +
> +description: |
> +  Qualcomm GLINK edge, a fifo based mechanism for communication between
> +  subsystem-pairs on various Qualcomm platforms. Two types of edges can be
> +  described by the binding; the GLINK RPM edge and a SMEM based.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +properties:
> +  $nodename:
> +    pattern: "^(rpm-)?glink(-edge)?$"
> +
> +  compatible:
> +    const: qcom,glink-rpm
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: should specify the subsystem name this edge corresponds to

Drop all this "should specify" and similar. It's making description
unnecessary long and complicated. This is therefore "Name of subsystem
this edge corresponds to".

> +
> +  interrupts:
> +    description: >

No need for '>'.

> +      should specify the IRQ used by the remote processor to
> +      signal this processor about communication related events
> +    maxItems: 1
> +
> +  mboxes:
> +    description: >

The same.

> +      reference to the "rpm_hlos" mailbox in APCS, as described
> +      in mailbox/mailbox.txt

Skip the path (entire last part of sentence).

> +
> +  qcom,remote-pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: specifies the identifier of the remote endpoint of this edge
> +
> +  qcom,rpm-msg-ram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: RPM message memory resource
> +
> +additionalProperties:

This is a bit confusing... why it's not part of properties? Looks like
mix-up schema and actually you miss proper additionalProperties.

> +  type: object

Eh? Object here? I don't think you tested your bindings. If you test,
you will notice several errors.

> +  properties:
> +    qcom,glink-channels:

These go to children.

> +      $ref: /schemas/types.yaml#/definitions/string

Isn't this a list of strings?

> +      description: >
> +        a list of channels tied to this function, used for matching
> +        the function to a set of virtual channels
> +
> +    qcom,intents:
> +      $ref: /schemas/types.yaml#/definitions/uint32-array

Should

> +      description: >
> +        a list of size, amount pairs describing what intents should
> +        be preallocated for this virtual channel. This can be used
> +        to tweak the default intents available for the channel to
> +        meet expectations of the remote

min/max items. This looks like matrix, but it seems is not used that way. :(

> +
> +  required:
> +    - qcom,glink-channels
> +
> +  additionalProperties: false
> +
> +required:

compatible

> +  - interrupts
> +  - mboxes
> +  - qcom,smem

What's this?

> +  - qcom,local-pid

This is also something new. This does not look like proper bindings
conversion, or you copied some other bindings as template. You need to
really go through it and clean it up.

> +  - qcom,remote-pid

Isn't this conflicting with part below?

> +
> +anyOf:
> +  - required:
> +      - qcom,remote-pid
> +  - required:
> +      - qcom,rpm-msg-ram
> +
> +examples:
> +  # The following example represents the GLINK RPM node on a MSM8996 device,
> +  # with the function for the "rpm_request" channel defined, which
> +  # is used for regulators and root clocks.
> +  - |
> +    rpm-glink {
> +        compatible = "qcom,glink-rpm";
> +
> +        interrupts = <0 168 1>;
> +
> +        qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +

Remove unneeded blank lines between properties.

> +        mboxes = <&apcs_glb 0>;
> +
> +        rpm-requests {
> +            compatible = "qcom,rpm-msm8996";
> +            qcom,glink-channels = "rpm_requests";
> +
> +            qcom,intents = <0x400 5
> +                            0x800 1>;
> +        };
> +    };


Best regards,
Krzysztof
