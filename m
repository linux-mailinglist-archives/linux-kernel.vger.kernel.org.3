Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1561A5162C6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbiEAIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiEAIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:37:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3F1AF1C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:33:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so22888395ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=juphbGtVRI7AgwIBx/gVkRn1JsqVAIzvaH2H1Ynllr4=;
        b=Ink2fnHkVWHDhPUFXh+DIhg9JOPJqIFKPZidd0JPdal2U+pv+v44Rrrq2/+XykLTUC
         yiYFlX95J2ma8UL59qsoWaNO+5mj9DOQZZv7ZyOBoG0wXBU8HiaZydTfzKaZR1JfAKjZ
         ZMgmAizrjpzSZwwM5qmeChXnYGKGWJGbSn0Jb2ktSExcVYcgtGtO9aWPpneL+0PSJWsT
         hZzEnFGlo55eHclKU+tDgSkMwrzaUXbHRcd4Y+7SzjjLkW1jnyEtokp+ryzytujT0qlt
         n0zmdzgN/evgrXCOsiFOodHpK6p5MUBcUJGFmNWutvGWTDtN7W/2D4pLVYqEVhn1xo5J
         EoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=juphbGtVRI7AgwIBx/gVkRn1JsqVAIzvaH2H1Ynllr4=;
        b=XO9YIC92bKtjED39sLfD2M1LNtzCR4MPL5rcrSIedzVGwyaVHGUOoZrWKQv60ZpNVz
         4wfkBPBQ1w3he0x8Di5v3zq+Y/Wq2O7/671MkngWUi6B+DHaINHuXkO7vMA1zHOBtcym
         Prr5pTaKquBXRhHPdOBWxMU4jsRe0irOV185HJHhq+zjlNeFQPptEbKgNOdU1psDZdql
         96hyebIF7ml1pxDrq5De8GszSSI2yC1Dmr+7xapDJvEkrgnQkTYvxoYb1g8ArWxzRLJe
         CcC6ckBblN2AHMT4TzKMp18w/kxNDMI3xL6SyMG9QbLJLfgzZ7khdKiYk6ZAUc0O+/WG
         9RUQ==
X-Gm-Message-State: AOAM53271dDLi31Q4wKykABTDxDyDa9KaSkXDBBj6mpm/G7NlUQ9au4C
        ig89auAIuFQdSV5wh+lyutZEcQ==
X-Google-Smtp-Source: ABdhPJxAWLnuoKSS1igYp6oJJh+6W/c2qh9JvOdGJryIMghe4U60loFIZvJD6/J0AKyCZMskknqNKw==
X-Received: by 2002:a17:907:7da2:b0:6f4:1b12:fea3 with SMTP id oz34-20020a1709077da200b006f41b12fea3mr5239590ejc.95.1651394034166;
        Sun, 01 May 2022 01:33:54 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og10-20020a1709071dca00b006f3ef214dccsm2364144ejc.50.2022.05.01.01.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:33:53 -0700 (PDT)
Message-ID: <9d40d129-1ab8-fb2b-48cd-7f206da45632@linaro.org>
Date:   Sun, 1 May 2022 10:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220430205101.459782-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430205101.459782-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 22:50, Robert Marko wrote:
> Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
> only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.
> 
> We also have to make sure that correct interrupts are set according to
> compatibles, so populate interrupt information per compatibles.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 79 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index b6406bcc683f..44ebdfd4560a 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -56,22 +56,19 @@ properties:
>                - qcom,sm8350-tsens
>            - const: qcom,tsens-v2
>  
> +      - description: v2 of TSENS with combined interrupt
> +        items:

It's just an enum, no list here.

> +          - enum:
> +              - qcom,ipq8074-tsens
> +
>    reg:
>      items:
>        - description: TM registers
>        - description: SROT registers
>  
> -  interrupts:
> -    minItems: 1
> -    items:
> -      - description: Combined interrupt if upper or lower threshold crossed
> -      - description: Interrupt if critical threshold crossed
> +  interrupts: true

minItems: 1
maxItems: 2

>  
> -  interrupt-names:
> -    minItems: 1
> -    items:
> -      - const: uplow
> -      - const: critical
> +  interrupt-names: true

minItems: 1
maxItems: 2


Best regards,
Krzysztof
