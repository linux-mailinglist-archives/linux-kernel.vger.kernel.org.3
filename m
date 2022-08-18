Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91266598014
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiHRIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHRIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:25:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BBAFACA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:25:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u1so1207369lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GeDInS0HAs8QReh6tItClEiurwlPP8TPLKQ+QrQqXko=;
        b=JwA58aF+G5s1e2+NfsXssQeCz5TX6jda5LlFFs4GBRNTXVhM85X6hsKI2LG+gACyXr
         IUhlBoV1ug8W5VVfakjrWebiN8Y0dJbS5kJpQ8MMucb6x1u4099mUWFRkjYGkci8rgq0
         TiVbtNtHRI3kvSoJcH7qTDQpaBANG0GRdV66JQ1MHkDa8MDQ8pDf9o8ibq2G2Gy5uyLR
         5klmjJeGeDqbvWDhpBPWgYd3/DqFVgnQYf9+DLT5wClpL7WZ8Emz0CJCBFm5uAec9ky0
         o9ZuE8SdWe+S0gcQ0Twr6DN0o+jxRdEaVXwjfeDeXEVr7XRzrPiSaArOzsG0Co0Btmf1
         sOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GeDInS0HAs8QReh6tItClEiurwlPP8TPLKQ+QrQqXko=;
        b=OmIdSI+Fv8NX1b9DyS9fkbqRz8EC83p8u0IErstQrL3OTVP7oJedxcv9wK2HoFUzf6
         vTXlM1vxEUBg9H4UwgTVoUKY5uIt365FPlrGmTvDYk5GRaSk95D1WAuBvX1MH7+LHXon
         0S+yEUi3hpw6mSXzlKJt8W5QGyc33rD1hi3xU3hMgFKSxZi+TwDtRQ4tOq6ynghziCze
         WoTutvCcHjPgQJYWAEAjadx9eGlaB+RvPig9WnVPmhi7zDMTFgTG0PUxWmi/++MbtkkQ
         VKOVgn3AFHgkSXsk+Mlmv8fUlBn9mMhTZhbBXEQ4+zPhHLUQrIgTzN4WYtRCvffGkPx2
         BYuw==
X-Gm-Message-State: ACgBeo0YjxP39ITNgfc1VP77Fkl7HCwcZl+NCZe13LpCi+j2SJEuWu/a
        q6fMj0bE1jyjV/vLnaYf8yHjTw==
X-Google-Smtp-Source: AA6agR54egXJZqZpdKTmvYFQXJaybgU+WirjMCScZ8ypakyTZr0EbSGyWikC0cyZQBbjB1L4Te8/ow==
X-Received: by 2002:a05:6512:228a:b0:48a:fa84:e298 with SMTP id f10-20020a056512228a00b0048afa84e298mr584111lfu.183.1660811139643;
        Thu, 18 Aug 2022 01:25:39 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id f26-20020ac251ba000000b0048a79e3dd6csm136950lfk.26.2022.08.18.01.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:25:39 -0700 (PDT)
Message-ID: <0a10f55c-1e91-de8d-74c1-e2778841b7fc@linaro.org>
Date:   Thu, 18 Aug 2022 11:25:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 3/4] dt-binding: perf: Add Amlogic DDR PMU
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
References: <20220817113423.2088581-1-jiucheng.xu@amlogic.com>
 <20220817113423.2088581-3-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817113423.2088581-3-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 14:34, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

(...)

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
> +    pmu {
> +        #address-cells=<2>;
> +        #size-cells=<2>;
> +
> +        pmu@ff638000 {
> +

No need for blank line.

> +            compatible = "amlogic,g12a-ddr-pmu";
> +            reg = <0x0 0xff638000 0x0 0x100>,
> +                  <0x0 0xff638c00 0x0 0x100>;
> +            interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };

With above fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
