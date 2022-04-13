Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50244FF47B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiDMKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDMKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:15:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2B26ACE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:13:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so3010699ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O7XNdb/rL+2wMW0kqfIXVVpZqHrnItm2fF5FP8Rt2gQ=;
        b=P3Wvpci3zVpfFl7NdYfwQvqZRaVoJsoVzHMylTtXNSWSPu5mW6PJPARSX2HeQxfZHu
         AwLvLXf2sn0pCYHGecBc3tTOPCHmVpmryBRLDCjfBwg+3v0DOSa4rVzRRVYjGrEvAssY
         0UF9bgYfyOCvQlMpJBVuYJhoBUdLotSBi7VZ6BLM9yDR6zzlOzINAXsG5e19vEsA66GX
         fxexwl0fesluocTDj9OLZPHrlzcbgRIlpoIJkft9ZuPtyvJFtTjxYpfgTBA3c+t188oG
         EFjOb2myJa+AYErrWY0W+scle8gV7WWZ2AhO4bY4E6uDTuEsTyW2GQ38fTTYUzFJ4tRi
         rb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O7XNdb/rL+2wMW0kqfIXVVpZqHrnItm2fF5FP8Rt2gQ=;
        b=plH5MZSnUHK3F0AIrVrWOz25bwazLeeZGJggNpKtnTySy8TCXONa1RQ1z2xPvjrW3v
         AVIeeWm5H6Bh8w9BFcvsi3hrs9nMufHIg3lz0S4INL7TuUluHrGxLHtTEGs6mN6XNAqK
         z/MlH3yo03RMz+GPXpvbytt7UKdBcSXKaclnHR+eWgrfvOKMWX0YGXdqX7MukZNW42RQ
         UWdKTs8wikf6ccTdFdtIO45Rrw0+wOyQ4m7nVAmC/DRuSShEI/qKbvDdqf3DhQT0uF5W
         jPCCga77dNJR22tccPDGn1+mQvSkTgr47IQz+HbHUP66nai+UNUFPaenkcQVtfoDY4qP
         GRhA==
X-Gm-Message-State: AOAM5322j2ssE4RZSnTZWj3f2qU1+To4EfBxD2ovTHPaMMG7+G98Tytu
        DQqMuzJWo3W3gyhbAuqde2P+3A==
X-Google-Smtp-Source: ABdhPJwMoStv0+wbhpVzgMS9VPUHYMgSWtrv52E/ZozAwjIZuxs5Ew+V7hMZUkzgZeDPJpDLiMgEKA==
X-Received: by 2002:a17:906:66c8:b0:6e8:8b06:1b32 with SMTP id k8-20020a17090666c800b006e88b061b32mr14078862ejp.236.1649844791814;
        Wed, 13 Apr 2022 03:13:11 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cb7-20020a170906a44700b006e879b4ba2dsm4565420ejb.56.2022.04.13.03.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:13:11 -0700 (PDT)
Message-ID: <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
Date:   Wed, 13 Apr 2022 12:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412101409.7980-2-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:14, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..8483c495cb9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments J72XX VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-vtm
> +    oneOf:
> +      - enum:
> +          - ti,j721e-vtm
> +          - ti,j7200-vtm

It seems you resent this ignoring all of Rob's comments. In changelog of
cover letter you wrote "Fixed all the comments on v4" but it's not true.
Maybe you sent us old patch?

Anyway, you need to follow Rob's comments.


Best regards,
Krzysztof
