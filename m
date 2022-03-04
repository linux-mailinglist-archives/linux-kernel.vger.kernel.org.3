Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5435D4CD545
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiCDNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiCDNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:37:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3221B84C6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:36:42 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFC1C3F613
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646401000;
        bh=G8BoUtDwWRG/T6yTrFWDQ38LNVbbwgFUxvn7b9NKrcg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=p2sqZf6zeFWkI9WbU+Uiv4kofVFXQWKWBFHH7MBNKlfAF5dKC5lkuW8oTJh5FdwD7
         8ijxwIiJSMFTRFybcBmoF21UA30Aui1pC6RVOYh0MD0aAbKiud3u9iYareIawk1k2S
         +srM8HXGMNpxWMGbODADb1KG07bwsnFLUlzUXtjHilr2OgqitAz7N50P3qEHE3VsWT
         yvHu5Uou15Rap0iR/FQwqVe15yK+iyuzVAwxgIR9MjlUsVKWEC0eTUbwy3oXgxhUC3
         7yxhD9t5JwLj0JR8lq4NUs1E4rlcv0O20US0ugXcoEGCJwaIS8Ig5xd1ed0jaEksov
         qHK+7BkoHIPIA==
Received: by mail-ed1-f69.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so4574689edw.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G8BoUtDwWRG/T6yTrFWDQ38LNVbbwgFUxvn7b9NKrcg=;
        b=veGAcq3XaaMvd9lwoJRHGgNjmkNchlPHteRQQm2Cx+ZlLU2Ro4pkniPPujB3iLvv/R
         /AhfsZQ2vQMaGLU7FkeiFvuCQSG6h6G4ZcudqCFJqhHE/Yv8TXZXRo+ucO6CDYLtDIkF
         W3+vRM6h9FLlEYrycsH1aQax3qAfIA6jFriTOLTGqDsil4T0HHMGbUv0vloUPyVybeW6
         BOIwFoNSx2OttlF9uv+4MG6HTrZ1S1hSAcRY0FFKPyaFv+q/OEq4oeHyDkjTVxi4a6db
         cKFfbqg/SOArKiUeKK9tcthrFJ0CCgLIBbb4WkmzLOsqKXgabDL42W1oMb1/HqQalgAA
         mo3w==
X-Gm-Message-State: AOAM531yPqvfdSn7riKVAhooMCmYO2+n4NzRhE1q9FRDL258sfiQx7Hy
        rTLUVvhEXomEDey/TrI4ex+hgyq04gNxw9ft74q9aoZpcS5bsv8n73O/4Cv1ZirdWewuwGNcVIn
        HYu6UVA0ONcYAOQKvLVqqlMX6fc/lzmJ2w9kPug7I0A==
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id g8-20020a1709065d0800b006dab4ea0937mr2982743ejt.446.1646401000568;
        Fri, 04 Mar 2022 05:36:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXSloxVKU/uB+P+Qe8lxuU0aSrsdcd2j1OAvPHH2N5wZJyWjhLLLr1TExNVWeKR3YLHFUbvg==
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id g8-20020a1709065d0800b006dab4ea0937mr2982729ejt.446.1646401000352;
        Fri, 04 Mar 2022 05:36:40 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906284500b006cc551d6cabsm1774511ejc.63.2022.03.04.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:36:39 -0800 (PST)
Message-ID: <f58869e3-8b5c-ed4b-c11c-27a8e465c3a2@canonical.com>
Date:   Fri, 4 Mar 2022 14:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: remoteproc: Add AVM WASP
Content-Language: en-US
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
 <20220227115832.13490-3-kestrelseventyfour@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227115832.13490-3-kestrelseventyfour@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2022 12:58, Daniel Kestrel wrote:
> AVM Fritzbox router boards may contain an additional ATH79
> based SoC that has the wifi cards connected.
> This patch adds bindings for this remote processor.
> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> new file mode 100644
> index 000000000000..8b39fafc60aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AVM WASP processor controller bindings
> +
> +maintainers:
> +  - Daniel Kestrel <kestrelseventyfour@gmail.com>
> +
> +description: |
> +  This document defines the bindings for the remoteproc component that loads and
> +  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
> +  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - avm,fritzbox3390-wasp
> +      - avm,fritzboxx490-wasp

This should be specific compatible instead of wildcard "x490".

> +
> +  avm,wasp-mdio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Lantiq GSWIP switch mdio.
> +
> +  avm,wasp-port:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Network port, where the WASP SoC is connected to.
> +
> +  avm,reset-gpios:
> +    description: Reset gpio of the WASP SoC.

maxItems

> +
> +  avm,startup-gpios:
> +    description: Startup gpio of the WASP SoC.

maxItems

> +
> +required:
> +  - compatible
> +  - avm,wasp-mdio
> +  - avm,wasp-port
> +  - avm,reset-gpios
> +  - avm,startup-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    remoteproc {
> +        compatible = "avm,fritzboxx490-wasp";
> +        avm,wasp-mdio = <&gswip_mdio>;
> +        avm,wasp-port = <&port5>;
> +        avm,reset-gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
> +        avm,startup-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +    };


Best regards,
Krzysztof
