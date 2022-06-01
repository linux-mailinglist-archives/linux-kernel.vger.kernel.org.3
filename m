Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6A53A1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351773AbiFAKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351812AbiFAKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:04:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E135A93
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:03:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so2631633ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=92onIsfnQU4QWfZIhdpAqRgE4HYf0xEpGZfJ1tdg0UY=;
        b=gHr7AuP5mdT/9AXsHRh38QGrskKD2LKcexs69b9Rdu7QOjJax5QX/GZeEMJJ3NwmMP
         kH1pp5EgK+KcgNv0eHLHkFcn1jT5YEJ2eAJSS0ldtTgos9WxRqAPkFecGVlCi002jWJ8
         cOGjgKKWpJzcVCRADRLhpuG+7rOrocG1+NfhV9BdB0dEugHub+fWC6fnm+briys+8Vjd
         siI+ZXvklNVBzj/4deHJNWLlJieWpxia1x5YTeXRD/Pq8e9TljHLrz6rEHpc26dEPTUv
         eSFtMGIg7W5Qex7E9dLRKNwqv4ngl+/gQZ3tYfu0Qcjv6lumesRbznxeGpy/FuRDyAV2
         ANqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=92onIsfnQU4QWfZIhdpAqRgE4HYf0xEpGZfJ1tdg0UY=;
        b=cKJ5lRuRnTMkd3u1skW8uCYQvWNk5w2WTDxByCJXJUpJ5KwBN/2RrLOM849HwPhCCg
         Pf9R/2m6wXgDCYQyW1hC/NGKT9LF/fh3lKeprVHrbnEpAWuP/xbKAPr4M9QbO9/FA+a/
         ymHhAFabbvnWTwMrxL0sb6XD82enYSAeD+qB/wwOPVJJYLVA67Kky6n6eN4NbGZII43s
         ilI4Ikp7G435AdTIbsOsfwA4P03LqEwiXnBdRWLEdMXtbjrFG8qca5tmdFwXMVYKuH/q
         Q6UWbzZqI7HXYaNB/wtEKzkHhGCo824hVrCrXOkURRsrRGMaa7GLU4SfMsXfoZEg6MfP
         cBlw==
X-Gm-Message-State: AOAM5300fjZgzeW+YHEYe8HZPichSm0EEBwDHwly1emG6+9uVweury4O
        M5A5HdCnS5/YWrlRocSSsTX1DQ==
X-Google-Smtp-Source: ABdhPJwsJCUv/SqbvzjiYBS6yN4lVmi+3xJ5LLsHbHg+hdAs1UqqGr3udpbhfrS2ZnyB0x3mxgD/gw==
X-Received: by 2002:a17:907:3c81:b0:6e6:cf3e:6e14 with SMTP id gl1-20020a1709073c8100b006e6cf3e6e14mr57688342ejc.181.1654077808486;
        Wed, 01 Jun 2022 03:03:28 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w7-20020a056402070700b0042aa153e73esm719655edx.12.2022.06.01.03.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:03:27 -0700 (PDT)
Message-ID: <54f64086-5ff0-1295-af5a-4989ceff128e@linaro.org>
Date:   Wed, 1 Jun 2022 12:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/17] dt-bindings: watchdog: mtk-wdt: Add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-9-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-9-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index a97418c74f6b..0e63c4ba3785 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -19,6 +19,7 @@ Required properties:
>  	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>  	"mediatek,mt8192-wdt": for MT8192
>  	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
> +	"mediatek,mt8365-wdt", "mediatek,mt6589-wdt": for MT8365

Just for curiosity - how does this (and previous binding patches) depend
on your big list:
"This series has dependencies on the following series:"
?

>  
>  - reg : Specifies base physical address and size of the registers.
>  


Best regards,
Krzysztof
