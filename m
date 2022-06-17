Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC054F411
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiFQJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiFQJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:17:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054985132B;
        Fri, 17 Jun 2022 02:17:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so4937977wrg.7;
        Fri, 17 Jun 2022 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4vsv7dr3uzhUIk6MaDx153ivgxegdosI7Dsq/3/yc84=;
        b=ACBqxDq5QRbxMPRA+U5PmidBuoHJTv2BC8lJaw1nDyLaHxEIQnEbVgh1x+mlou/rkt
         mpMX1ICEMpkO/miqr5zblcumCBy1wNo90e4UIpwCqBap8reJuYojFB3S4xiXCzpN5lHz
         D1MJN+rWmHVdTmPS/Cu2Ip+wJ2npZ3xU5pHFcIlDHEHX6OdsqwvkZhYaABTrA9g23Sxr
         3x1ELieftG0IeDNRbsW3DE2oakM0Q6aBJDnIGTUSyccEivRbUMcMAOta9CCBSDE3u0Vh
         PLAr5yoDQ2rsKSt3GuZA32Dcl3bqUyoCgom7QI3GqQzEaUgsMZWYav/WoksfO/RixGrq
         djeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4vsv7dr3uzhUIk6MaDx153ivgxegdosI7Dsq/3/yc84=;
        b=3deE4FDfTeWfQd3CWfloUz2dVGciO6uQZg0RI48+osNny9sllR9xSbVYSrPQp+DUU4
         H0+l3bCW5q/YSmEe1DoZ5PHlF7qlRrrxdG3ho2sJicUk2ccO+i1CMm/P9JpRqb2wqaYd
         /X7lASNEM+GNXny/Zuhm8b8GYKo2NEyGK4ye1Q5+BxVB5Vzf+L0Y0STEbClCBvtl4puK
         qBli6H820ZMsfF5ZDxuOIPyxQBTP+UIgWbfqqUNE9xDnhtFm1Q/58lrYskVINYcgJ/Eq
         2aIW60lJf8aBgbRrF9IsKDcSctqtwP9kFLhKmsa5XRDhLDOcf0te2HR+jZcZDHP1U0ap
         7gZg==
X-Gm-Message-State: AJIora8kJPPDtWLS1jqndwD33amYJPjMaJQl/Zx0GqZym4+gu3/YD3a8
        I68Czs9NnsDVw13wVMt3H+Y=
X-Google-Smtp-Source: AGRyM1vtqhqNcKCv+Vd5UmcqgXsk7sCKRe+BlO71XkYROhDQY11lTbjAf8DBCYy7gmcuH56g07pzQw==
X-Received: by 2002:a05:6000:1445:b0:219:f383:40bc with SMTP id v5-20020a056000144500b00219f38340bcmr8645124wrx.53.1655457433484;
        Fri, 17 Jun 2022 02:17:13 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b00215859413f3sm3980329wrw.107.2022.06.17.02.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:17:12 -0700 (PDT)
Message-ID: <074b6829-c5c1-d3fa-d4b9-8b0ba001eabe@gmail.com>
Date:   Fri, 17 Jun 2022 11:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: mt6397: Add compatibles for
 MT6331 RTC and keys
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616091531.12646-1-angelogioacchino.delregno@collabora.com>
 <20220616091531.12646-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616091531.12646-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 11:15, AngeloGioacchino Del Regno wrote:
> The MT6331 PMIC provides many sub modules: regulators, audio
> codec, LED controller, keys, RTC and some GPIOs.
> It is always paired with a MT6332 Companion PMIC, which provides
> thermistors, WLEDs (display LED backlight), secondary AP cluster
> regulators, modem clocks, battery charger and fuel gauge.
> 
> Add the necessary compatibles to start implementing the basics.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/mt6397.txt | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 293db2a71ef2..f637bee2f3eb 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -29,6 +29,7 @@ Optional subnodes:
>   - rtc
>   	Required properties: Should be one of follows
>   		- compatible: "mediatek,mt6323-rtc"
> +		- compatible: "mediatek,mt6331-rtc"
>   		- compatible: "mediatek,mt6358-rtc"
>   		- compatible: "mediatek,mt6397-rtc"
>   	For details, see ../rtc/rtc-mt6397.txt
> @@ -52,8 +53,10 @@ Optional subnodes:
>   	see ../leds/leds-mt6323.txt
>   
>   - keys
> -	Required properties:
> -		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> +	Required properties: Should be one of the following
> +		- compatible: "mediatek,mt6323-keys"
> +		- compatible: "mediatek,mt6331-keys"
> +		- compatible: "mediatek,mt6397-keys"
>   	see ../input/mtk-pmic-keys.txt
>   
>   - power-controller
