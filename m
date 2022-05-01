Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4198516342
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiEAI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiEAI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:59:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B41A3A9
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:55:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so13545250edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Q4D7i4GL8KP5hpGHA7/56lmG9H5Z77KSqaGV3uZPeM=;
        b=NRJ3Ud1Z3YxwLrFLtiUGSHKmaQQ/gEWMH1cpmTU5i/RMSE/lYjldRIEJfnx80xzGwF
         nB76PATx5V0L7aI82BrU+nvAqKp6dzYp6rwMKLigl1qoE1/aXy7GJSSypGa531b5On+N
         5raduwLXLRuYiPE2pwiFe3kB4NMa2pB1GxJcsPELuxbxAreDlahDphEKPIKGikeAwZ08
         uQKSsFe/dIr0c6xTCn4up4K1mAAGxLL1P4dJPRWtzAiKMLL/t52qk4yfYuponzXYK3Da
         nG41j1svssmDZ1WcSHXBsXzmDlC3ihEYTADFOTpAcG901AZmeXkdSkf0JZ+Z3A+vUyj3
         DH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Q4D7i4GL8KP5hpGHA7/56lmG9H5Z77KSqaGV3uZPeM=;
        b=mH584Cd5wjxfwfaDUbpw3hSyYaa4kP1WTGoGaXrAKq42hZs+EwbtJI9BbAwhFUznNU
         6zLhCuiCVI21oHbsqgMQDs4/GFtKyHEfoRD3qaGADbsIxpL6ZulMNy62tjd0AbxcbtxT
         PnidRupafL2QMYdrFWjqdAms5bkkeH3a1fcCaiZ10eBfBsdLFcii7Kdf6GbiVOKUdL2x
         KJFLw7P0l2ddEWc9NNUn6x4hKLEnD9otkU14aQPnzu9Tj6eoeaLVihmTACssWY7gOOOd
         aI9YFu9afCvMQR4xRID22bERoY0dD41vvvG1QTHKXw8d5hpEWWYTYTly80T9NJ15Bxkm
         A5XA==
X-Gm-Message-State: AOAM532U1Hpe6nR8bmozYel4qbSuxocI8CM8nhe7DDbebhd6u2wu4L+a
        HPuSxmhwVB8ymGOyqOBGXeRKeg==
X-Google-Smtp-Source: ABdhPJzRoUbN7p6a+QsrfdXpuNxUvP73pFrp/NOoq9oxKzcPe6GgKQtTMh5zIkfqEiGB5tCEKhuhTQ==
X-Received: by 2002:a05:6402:288a:b0:425:c5b2:59d9 with SMTP id eg10-20020a056402288a00b00425c5b259d9mr7923496edb.412.1651395338995;
        Sun, 01 May 2022 01:55:38 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2374240ejc.155.2022.05.01.01.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:55:38 -0700 (PDT)
Message-ID: <3c2f2e75-153b-05bf-9878-70fc1c1a81b1@linaro.org>
Date:   Sun, 1 May 2022 10:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add Nuvoton WPCM450
 clock/reset controller
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
 <20220429172030.398011-5-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429172030.398011-5-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 19:20, Jonathan Neuschäfer wrote:
> The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> Add a devicetree binding for it, as well as definitions for the bit
> numbers used by it.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Various improvements, suggested by Krzysztof Kozlowski
> 
> v1:
> - https://lore.kernel.org/lkml/20220422183012.444674-5-j.neuschaefer@gmx.net/
> ---
>  .../bindings/clock/nuvoton,wpcm450-clk.yaml   | 66 ++++++++++++++++++
>  .../dt-bindings/clock/nuvoton,wpcm450-clk.h   | 67 +++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
>  create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> new file mode 100644
> index 0000000000000..3ed3e40e39637
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton WPCM450 clock controller
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description:
> +  The clock controller of the Nuvoton WPCM450 SoC supplies clocks and resets to
> +  the rest of the chip.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,wpcm450-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference clock oscillator (should be 48 MHz)
> +
> +  clock-names:
> +    items:
> +      - const: refclk

Sorry for not bringing it up earlier - this should be just "ref". Names
in values should not have suffixes (so no "tx-dma", "wake-gpio",
"ref-clk" etc).

Best regards,
Krzysztof
