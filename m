Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FF58A7FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiHEIVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHEIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:21:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9074E3E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:21:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so2373901lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SBUuFiz/VDWMI2OJalxtSfG/SXidOC9PQ998o7vzahU=;
        b=Nb6sBy9TLlxKcxgL0XerQ6xLCQKP8U2euxXhT7Uu8LrpSwyRU3Hp/7+LTAn2EcPH9n
         zdVc1OZzG21bCg3JXuaGY3N2vx2gWeoQndeYh2NKPnrxXAEJ60Wo3MogTGswwQvxS7rD
         aJ9h7bkl+DiiRgqG3lwLFbh2pMxEJ4IRTWbKEhRVzmnKhrIM84WimPhwnlA7zkanCCr8
         4QqTY2z1hpZxbnGnODJVR0pq4NZNmUGl8xCi0rkJmZrRcYDog7XSvy+IbiYKS7LGf0LG
         6Oih3+kshSZ2nrJZS+aeQR4lO7PvUGoQNewdNM115HlvWXxBK1kJir8lXLmVrjK9zHMv
         nOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SBUuFiz/VDWMI2OJalxtSfG/SXidOC9PQ998o7vzahU=;
        b=dorja77NHgIrK+j/nwLD9AUOv1dQXTSyF7x7dLur3CVZ7H9OuiAba7nj14/niJr2Tm
         wtthoOlHNFrIT5CKizG/irN/5Ah8bsi8whxjBqcgsRiYrt8UWOv7bBlc++JU0Bpx4f5g
         1msPPVXhE2+ge2R4jIz5dy5yWKkpGjGacQMcxDAH+2wvrzTXr8QEy6Qz/fkf26QweGW/
         OJpc8LPUmu+2cJKb9ofbzIyQyh35Pp2AYvcAOdBdDD5gZCz0iIbBHbgOkdXRwKCboZud
         mj1tT/2HBCuRF8ZHyNLX/A30ItgtPKHV0SwwuZV064kpj1PGZYDKaOhl54Qwa+xOjBae
         gUMA==
X-Gm-Message-State: ACgBeo3Bu8HFlRdEIDVn+xZEP7jrPZiKU0xbXnaK2eMK6+DL8yJ62zJV
        0+4ew+SmUZNDVrYjESZWht1W8w==
X-Google-Smtp-Source: AA6agR4Sz+5EXQ1U2l6iQKUZo4mMFmM29ugOmMqyrB6IqERZVbLuRtXk27pb4Dk2YrqAQI9Ne5OWIw==
X-Received: by 2002:a05:6512:3d9f:b0:48b:965:71be with SMTP id k31-20020a0565123d9f00b0048b096571bemr1899268lfv.461.1659687699326;
        Fri, 05 Aug 2022 01:21:39 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id x12-20020a056512078c00b0048b4690c78esm125510lfr.288.2022.08.05.01.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:21:38 -0700 (PDT)
Message-ID: <a3cd55ad-cec2-9570-2078-6724ab1d7300@linaro.org>
Date:   Fri, 5 Aug 2022 10:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 4/4] dt-binding: perf: Add Amlogic DDR PMU
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
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-4-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805071426.2598818-4-jiucheng.xu@amlogic.com>
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

On 05/08/2022 09:14, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 

Bindings go first in the series, before their implementation.

> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v3 -> v4:
>   - Fix "$id: relative path/filename doesn't match actual path or
>     filename" warning
> 
> Changes v2 -> v3:
>   - Remove oneOf
>   - Add descriptions
>   - Fix compiling warning
> 
> Changes v1 -> v2:
>   - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>   - Delete "model", "dmc_nr", "chann_nr" new properties
>   - Fix compiling error
> ---
>  .../bindings/perf/amlogic,g12-ddr-pmu.yaml    | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
> new file mode 100644
> index 000000000000..4d018574ffd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
> @@ -0,0 +1,52 @@
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
> +description: |
> +  Amlogic G12 series SoC integrate DDR bandwidth monitor.
> +  A timer is inside and can generate interrupt when timeout.
> +  The bandwidth is counted in the timer ISR. Different platform
> +  has different subset of event format attribute.
> +
> +properties:
> +  compatible:
> +    items:

You have only one item, so remove "items".

> +      - enum:
> +          - amlogic,g12b-ddr-pmu
> +          - amlogic,g12a-ddr-pmu
> +          - amlogic,sm1-ddr-pmu
> +
> +  reg:
> +    items:
> +      - description: Physical address of DMC bandwidth register
> +          and size of the configuration address space.

Skip obvious pieces, so only:

description: DMC bandwidth register space

> +      - description: Physical address of DMC PLL register and
> +          size of the configuration address space.

description: DMC PLL bandwidth register space


> +
> +  interrupts:
> +    items:
> +      - description: The IRQ of the inside timer timeout.
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
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ddr_pmu@ff638000 {

No underscores in node names, generic node names, so just "pmu".
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "amlogic,g12a-ddr-pmu";
> +        reg = <0xff638000 0x100
> +               0xff638c00 0x100>;

This is still not fixed. Binding says you have two items, but you
declared here only one item.

Best regards,
Krzysztof
