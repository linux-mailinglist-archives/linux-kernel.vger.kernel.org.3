Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAD51A320
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351851AbiEDPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351727AbiEDPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:08:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404E41325
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:04:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dk23so3441096ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=x5Zoz/iyWDxLTQhXQBTElr/xGz3ziSFD9Wy1VQnSTXI=;
        b=hW6OlYQ9E4L5RU2mGkTdC1n2bf+wBHAt3hCerdvKM4BRmSIV1vRGVE6fKTSrqm7qT5
         ZN9S4rVAHb2tIgglQWUaO6LB3KlUlXAktMvMV6CqwC2Ih56jmxcwDgbYN2l928z15ySq
         qEsAfqqY/vUBImzo3VKRNO2IpEwx+5c6wfq+ENr3a71QWhwnETr4EdwQIcfMwLGHBUve
         tw66Rpm9IzhxDdislc2yTm1Q1WOhDDKbe16rz1RJR8MAEE2mHB8Fb/CubNbRBPDn3goL
         otmALhVVcItojb0jzE5GmyKWrG/mSKx6isqXcafGTKD6ERRJkEge1wses/Z/sDwAgWwa
         YFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x5Zoz/iyWDxLTQhXQBTElr/xGz3ziSFD9Wy1VQnSTXI=;
        b=47pKuU0Q6aeL2aiktQ+UzJpWo+9+iICyWoN7+SxI8+71ysgjirWntqcd3KrAOMhHIu
         Q8qLEkAKvrEUSkZ9qyVD7r0dtoWgn+l5y9AEXEqbRSJbIjj4hxBkFxVt1PLpoxGXNtmx
         vcD/BlQWWVlNCVVUs3ieFNZnicvcpI03R+bhmZDNlThrDxIxmhfcfCAEHHVEZX3AhPrb
         qNv+apes9GgrnVT9V8ug+4CeVkk5OVfyGCraaJl1FbVo1Fjwcmtz79OqgBPFIkDihCKl
         q6RH+EI7SSe9V+05uyMO7Ft0f0MEcOsGN0D0uakC2DtOrAgPh+ksv14Sx34Qjuqenau4
         XeSw==
X-Gm-Message-State: AOAM530oPBq4/3tMYNie5KG9ouMHUYQaJ+mNDNRXDeYpRY42ZZfoN2K8
        DV4TK0S8O2cmJwzTvRABowefpA==
X-Google-Smtp-Source: ABdhPJwIOV/eE5zBY57dkzYmTDhfsV2xNZbGb5Dm4XBxb47mkKoNVLltzkrubopudGNlgWmKnSyZpQ==
X-Received: by 2002:a17:907:7fac:b0:6f4:6b70:33d9 with SMTP id qk44-20020a1709077fac00b006f46b7033d9mr10666095ejc.380.1651676693967;
        Wed, 04 May 2022 08:04:53 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eb8-20020a170907280800b006f3ef214decsm5711399ejc.82.2022.05.04.08.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:04:53 -0700 (PDT)
Message-ID: <17407fe7-b11d-2ba8-acca-3e71cf1a3b2f@linaro.org>
Date:   Wed, 4 May 2022 17:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: add bindings for Intel HPS Copy
 Engine
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
 <20220503194546.1287679-2-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503194546.1287679-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add device tree bindings documentation for the Intel Hard
> Processor System (HPS) Copy Engine.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  .../bindings/misc/intel,hps-copy-engine.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml
> new file mode 100644
> index 000000000000..74e7da9002f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,hps-copy-engine.yaml

Please find appropriate directory matching this hardware, not "misc". As
a fallback SoC related bindings end up in "soc".

> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022, Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel,hps-copy-engine.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel HPS Copy Engine
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
> +
> +description: |
> +  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
> +  a bootable image from host memory to HPS DDR.  Additionally, there is a
> +  register the HPS can use to indicate the state of booting the copied image as
> +  well as a keep-a-live indication to the host.
> +
> +properties:
> +  compatible:
> +    items:

No "items", you have just one item.

> +      - const: intel,hps-copy-engine
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    agilex_hps_bridges: bus@80000000 {

Unused label...

> +        compatible = "simple-bus";
> +        reg = <0x80000000 0x60000000>,
> +              <0xf9000000 0x00100000>;
> +        reg-names = "axi_h2f", "axi_h2f_lw";
> +        #address-cells = <0x2>;

$ git grep address-cell
Do not use inconsistent coding. The same applies to your DTS.

> +        #size-cells = <0x1>;
> +        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;

Why do you even need the simple-bus above and cannot put the device
directly on the bus?

> +
> +        hps_cp_eng@0 {

No underscores in node names. Generic node name.

> +            compatible = "intel,hps-copy-engine";
> +            reg = <0x00000000 0x00000000 0x00001000>;
> +        };
> +    };


Best regards,
Krzysztof
