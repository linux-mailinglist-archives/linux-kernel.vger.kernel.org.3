Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5715B024B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIGLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGLCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:02:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F04A0618
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:02:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so252388lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2ZksrWzCxdsKB9eboZRhKTKOwecPVr614XThFnZuMQY=;
        b=SIo4JRXgobwzKo6dx+BfhDNvQHYrI9/AYfht4q9L8F+4CaGLDRmnqEfj5BGNkFnJmm
         OVJUB/LQj+KrH1zZNEWFcnYE/F3wNw1KodqzDT6pUOwn60hHNmFTqiBXxGxR0d3CPsKu
         UY/aaqqExMFOlgK+bjMsFqrlCbCDBstxETcDpSmatuFLoHauewPR48ZZqiLbrvXoTWST
         0T5Ox0yhRCyzsW1OMStINawkqE7I4n+jFBjqoqxIob5WDuusC9mctkIxOd7oH7YUnd7E
         uMMR+HG4+C2sPvQHY6MQ+7au4+XP1ns3QKzTd20CSNhq4Y2CGU7sUtlsDIbsgq+lWL1+
         +soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2ZksrWzCxdsKB9eboZRhKTKOwecPVr614XThFnZuMQY=;
        b=4BCfWT6oZB1VL9hN4ZoZM8fL6NyClZ25iNQu35nXZ76wxQnSvHkfmEvwWf+0Uf8EYJ
         Hs307ZUD1UQLKgDSR3Mp+RADefpFmFHWsOlh/OcrNav6xBs//uF0gKNlvPB2fqWBfADU
         06F1xdTmpjVs9L+0+55SAi/YCC8T4ihsAMqR9WKK9Wqa8Xm76JIzZDfsRakDGsh09gHC
         52OFzjNdk0Hd9atE8xjz6I7+G1XSsB0Ui1cirutTFsy0PV8H/W1WPP/VtbnkrcUwVmLh
         OA57M1xkwRqtuI6i29dz6nECIC/3QaSA7ok03Mzy6oksKbFRJ8ecvTW25uQA4EDc3T4w
         rjnA==
X-Gm-Message-State: ACgBeo0KzbFjGKj6HNJ1v/5Qet/ahTzlQNqOpP3kpydX1otmNTvM7P5k
        yO+UF/pZn+C0uDYfvPjNW/rBDQ==
X-Google-Smtp-Source: AA6agR6pn15B0Te5FrvBxcTxQWV/My4R3Gt6Azp1JBIecWmKlQYgEcWkG2mc9R779tkRuU44NRWeJw==
X-Received: by 2002:a05:6512:1329:b0:492:e050:b0dc with SMTP id x41-20020a056512132900b00492e050b0dcmr1024413lfu.136.1662548523015;
        Wed, 07 Sep 2022 04:02:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b00492c017de43sm2402693lfe.127.2022.09.07.04.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:02:02 -0700 (PDT)
Message-ID: <d11b17d8-bc36-3a64-3de0-b188eeb5e9ba@linaro.org>
Date:   Wed, 7 Sep 2022 13:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/8] dt-bindings: Add bindings for Tegra234 NVDEC
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
 <20220906132823.2390953-4-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906132823.2390953-4-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 15:28, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Update NVDEC bindings for Tegra234. This new engine version only has
> two memory clients, but now requires three clocks, and as a bigger
> change the engine loads firmware from a secure carveout configured by
> the bootloader.
> 
> For the latter, we need to add a phandle to the memory controller
> to query the location of this carveout, and several other properties
> containing offsets into the firmware inside the carveout. These
> properties are intended to be populated through a device tree overlay
> configured at flashing time, so that the values correspond to the
> flashed NVDEC firmware.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../gpu/host1x/nvidia,tegra210-nvdec.yaml     | 118 +++++++++++++++---
>  1 file changed, 98 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
> index 3cf862976448..27128a195b66 100644
> --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
> @@ -24,17 +24,11 @@ properties:
>        - nvidia,tegra210-nvdec
>        - nvidia,tegra186-nvdec
>        - nvidia,tegra194-nvdec
> +      - nvidia,tegra234-nvdec
>  
>    reg:
>      maxItems: 1
>  
> -  clocks:
> -    maxItems: 1
> -
> -  clock-names:
> -    items:
> -      - const: nvdec

Please leave them here with wide constraints (min/maxItems).

> -
>    resets:
>      maxItems: 1
>  
> @@ -50,18 +44,6 @@ properties:
>  
>    dma-coherent: true
>  
> -  interconnects:
> -    items:
> -      - description: DMA read memory client
> -      - description: DMA read 2 memory client
> -      - description: DMA write memory client
> -
> -  interconnect-names:
> -    items:
> -      - const: dma-mem
> -      - const: read-1
> -      - const: write

Please leave them here with wide constraints (min/maxItems).

> -
>    nvidia,host1x-class:
>      description: |
>        Host1x class of the engine, used to specify the targeted engine
> @@ -79,7 +61,103 @@ required:
>    - reset-names
>    - power-domains
>  
> -additionalProperties: false
> +unevaluatedProperties: false

This looks not needed/related.

> +
> +allOf:

Put allOf before additionalProperties:false.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-nvdec
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: NVDEC clock
> +            - description: FUSE clock
> +            - description: TSEC_PKA clock
> +        clock-names:
> +          items:
> +            - const: nvdec
> +            - const: fuse
> +            - const: tsec_pka
> +        interconnects:
> +          items:
> +            - description: DMA read memory client
> +            - description: DMA write memory client
> +        interconnect-names:
> +          items:
> +            - const: dma-mem
> +            - const: write
> +        nvidia,memory-controller:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            phandle to the memory controller for determining carveout information.

All fields should be defined in top-level. You can disallow them for
other variants, but if the allOf:if:then gets too big, it's a sign to
split the binding.

> +        nvidia,bl-manifest-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to bootloader manifest from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +        nvidia,bl-code-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to bootloader code section from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +        nvidia,bl-data-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to bootloader data section from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +        nvidia,os-manifest-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to operating system manifest from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +        nvidia,os-code-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to operating system code section from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +        nvidia,os-data-offset:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description:
> +            Offset to operating system data section from beginning of firmware. Typically set as
> +            part of a device tree overlay corresponding to flashed firmware.
> +      required:
> +        - nvidia,memory-controller
> +        - nvidia,bl-manifest-offset
> +        - nvidia,bl-code-offset
> +        - nvidia,bl-data-offset
> +        - nvidia,os-manifest-offset
> +        - nvidia,os-code-offset
> +        - nvidia,os-data-offset

blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:

Best regards,
Krzysztof
