Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722605820BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiG0HJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiG0HJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:09:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2256F3C8C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:09:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so18309525lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sf552mPgsYsMMY77D6I22t6pOm3pYqj+viQ1dNWKK5Y=;
        b=EfnhCF1HreZcHUhmcuTEdf5fbkyhxucRe3fJfSFtwTZWrOY13nsmnZ+wNMgulF9/Yg
         ZvAGrjaDWwAroarDr488fTcmkBt9bhxbVdDi4oXgdx/brzjoYGoXFXlzCFyQzm44FVwt
         FaMhloIL+26SxhgumPbvBuklERDDB3C087quGwBo9fQ+YiXR5XdPgazPeacSV/GORF32
         4eCNIukD7o3XxCX0j24tll/lsG+h7ZMiJ+jBIYPHvUqf5/jDj6jGF82JPPDpGuigjK4a
         XN88b60O6GaKttciEsllHHhmPDsCd2Yg1Va+uZpx9jLMD6UDv8cflOkrZtyKMK3Ql4Gj
         XC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sf552mPgsYsMMY77D6I22t6pOm3pYqj+viQ1dNWKK5Y=;
        b=pMxM1amXi+zayLSkE2SmQFuxR7XZMdoc1/eyy+J0ijEMEq053FxLwntP/+XwyZRd0X
         DeUfTwAGfRKFEfY1WVvmuZSd+s0t+H+fykFkzILqUI4fbPiKaGZ5IiuUM1SB+Wopy2S1
         gC7QB4ADzFUsj+k83IkzRP6OZmF9ISpnh4HpMl7d2dDW9fa2rp8r93YgdTpwhIce3CyH
         hHyYgGb3CBjAcS4M9A9rJ4V/w2FZQQPO3yChegP1i5T9vPjc3fTukXC7ZAqe/y0x+580
         ylVbNrH5IsWQEEII9OXCceMNoZjGnUPaGoPhHapIBOp6hl/7av3LGuD3GEpMfNn149f2
         ArJA==
X-Gm-Message-State: AJIora8JSVNc0rd4fChmCyI1BwrS7JjoRdjiBFeZCvaWcBK9yqm9KBlX
        r2qsauoLFJkKiYuFuGeNKtVgCA==
X-Google-Smtp-Source: AGRyM1uK9oExglPVaieaOMc4kk1/xZEEBcnjm26EnaG/q9CwC/wwPOx6aSi4/p5zLo9Ml3qvDo2oww==
X-Received: by 2002:a05:6512:3045:b0:48a:7635:ff22 with SMTP id b5-20020a056512304500b0048a7635ff22mr8141679lfb.314.1658905776265;
        Wed, 27 Jul 2022 00:09:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e930e000000b0025e0ca6f6b8sm674048ljh.77.2022.07.27.00.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 00:09:35 -0700 (PDT)
Message-ID: <a45957f9-bb51-8774-8f2f-675fd8314698@linaro.org>
Date:   Wed, 27 Jul 2022 09:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
 <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 01:03, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v1 -> v2:
>   - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>   - Delete "model", "dmc_nr", "chann_nr" new properties
>   - Fix compiling error
> ---
>  .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> 
> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> new file mode 100644
> index 000000000000..46ef52b61492
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic G12 DDR performance monitor
> +
> +maintainers:
> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    oneOf:

That's not oneOf...

> +      - items:
> +          - enum:
> +              - amlogic,g12b-ddr-pmu
> +                amlogic,g12a-ddr-pmu
> +                amlogic,sm1-ddr-pmu
> +          - const: amlogic,g12-ddr-pmu
> +
> +  reg:
> +    maxItems: 2

You need to list and describe the items.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ddr_pmu: ddr_pmu {
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

Code looks terrible...

> +
> +        compatible = "amlogic,g12a-ddr-pmu";
> +        reg = <0x0 0xff638000 0x0 0x100
> +               0x0 0xff638c00 0x0 0x100>;

That's one item. You need to separate regs.



Best regards,
Krzysztof
