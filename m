Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2995878A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiHBIEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiHBIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:04:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01823AE73
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:04:40 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s14so14803403ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ShX8SdjvHP5x/QEd5P7yAfW5q1aymhg/8ZpNAExgulI=;
        b=sW5x7sNbJm4KPJDaPbJSKP/ieBiy0VQV6/CwTUBzDue1/tqIDXiGuUa3pPKGip/gp7
         dvIASGX9muNVoZQezp0vMnf7L1LMoOqMU5yT9cz4AQVtRztDTuGLTRTxnJarqn0wrvg/
         ME1fncpdVr6vy8k0Npb+7fUiCN2Y9XxzQse3A96WsGPwXswnSmjky0hZpOdV6FhjulJj
         ZZ/oG+94OFhETqBbW/S/95+mrNbHoOqPSigy/svtn4ZVfCl1PQ9Ebfjco2kqb4Ll0EJ+
         wUhZ47JELQTKpt/xzT4O6hDHuGermjL1ws/kPYxw+fuYslE+1rOBC02k+xhg3k80AbX4
         RsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ShX8SdjvHP5x/QEd5P7yAfW5q1aymhg/8ZpNAExgulI=;
        b=0K4qWdb+NvHYrARg7OUMuFPXCHnM5UEBdTwJaDcf/hJhm/jh39g+myroVHYmK4znGV
         kIMtQVfNCW09ADnXlgSGFduh3uBFvHPnKC0AKSj1K0zbS/coRb83UxxbzK4l+9QZRkyv
         lPb10TSs6cmAbswortHsfvc1IRoJDkhL8tASaEu6IfHEwxyDnkWWS6wnUClsuDkRGl/O
         x0U5fD6zRpaiw9tYQx7QhkDzriZM9sm1SRmQJ+7DBwqf0MJqWXbYi+Gl+fimru+zdyXS
         phgIsJ1GBVlDvbJ8/1tgRjmVSGTkjbcryydxb6vlQwo3uaeCaPOwM3PDMHPaxUX34i8/
         7tQw==
X-Gm-Message-State: AJIora9jmnAP7nhkIpMyrGx/2f00tZDat5ONhJI/RD62b+OYO2xSuo7b
        37UOe6pUjPG14h858T0W61nrIA==
X-Google-Smtp-Source: AGRyM1usD347g/PCYf5onVBO1mElQUVrm5vGKhPd8Gyrw+2mzv2u3tW20rdNGIxVEc6umXcRtrExZA==
X-Received: by 2002:a05:651c:1147:b0:25d:eb36:755d with SMTP id h7-20020a05651c114700b0025deb36755dmr5848282ljo.16.1659427479158;
        Tue, 02 Aug 2022 01:04:39 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b0048b038c7624sm436240lfr.42.2022.08.02.01.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:04:38 -0700 (PDT)
Message-ID: <0893fab6-a7e1-bfa7-2497-239e044cc7ed@linaro.org>
Date:   Tue, 2 Aug 2022 10:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/4] dt-binding: perf: Add Amlogic DDR PMU
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
References: <20220801060049.1655177-1-jiucheng.xu@amlogic.com>
 <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
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

On 01/08/2022 08:00, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
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
>  .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> new file mode 100644
> index 000000000000..961656d4db6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#

You still did not test the bindings...

You received such comment (with instructions how to do it) and still
decided to send untested bindings.

That's not how submission procces should look like.

NAK, till you send something which you actually test.


Best regards,
Krzysztof
