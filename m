Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F824FFAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiDMPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiDMPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:50:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205876621F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:48:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k23so4846208ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZUrQrM6enlfgMn/MObow0T//8GW1/W7c2olNoWx1WQk=;
        b=cYfqlHMdFO+1nIfKsAz4h6xPJv2H4bDpx6SKU16eUaPGolydDIUZXiFqJ4uFG9fEUD
         s1JN7QgJc9x8Fpc+CnbHbMZIMTs/EX3jXd84yTJB8toixzJQjfY3p85nNPujj7eJkSqX
         XrZlSeOQ35HWKlgeAeLgV7AllKwssXdC2jakg6tq5XVK0AzKtQYDcbsfryjfx8L23lFw
         /Q2W/520v3rByUE6mufw/9151seYEOyIeY43Y4O2pzCDIOK9xCJwRBdEm/wJTlaRH5Xl
         3S19cbHHB7nfQBbD/iOs0Q0+qb8gInlWh0m5iIQIsGlplV1XiE9kyB7TSucWpNE9EKym
         AqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZUrQrM6enlfgMn/MObow0T//8GW1/W7c2olNoWx1WQk=;
        b=CAhH+7LAwqVPqmQZMI0V3EOxAyWSGAPW8g758Lhg8Wk4hdNDoBQGVQ2fsmEoLbeW98
         g+g5MIPWZioj9RkQpWxSGE03nCN/WZeJCfjgWit3rTpyTKIfsPHUynwmJZSXSeiwzUGj
         YOkl6ZRhzVbQsU9Gnq6rlvmsouBEmNELx0UB2l/CduqKfTvZvpFDHB5kjwgukwpEzuWC
         O9UmcYCyGNeBirxUp3GKx3GepIYwjKH9ssTojybNH2ggq29HKjfghWjtwHxfH80+T5sW
         HKHHJg28kzzH4qZRm5/sK9G+JrOfh/bNJNfcQRi1siNfCCwt6NA6Hb+/Rmm+1o50R8Zh
         TV5A==
X-Gm-Message-State: AOAM531gH6nqKSwquyESxeuoH4xaF9nf2NRs/+Dwl399NMTXsXTOTMZo
        tanXbvgL/aE6D+7WA+/2yr8ZeWu6j9pe6G4L
X-Google-Smtp-Source: ABdhPJw7BMUh+VGZ5d6fOhsX9G0k6NTnqjs/n3rz6db8TkQALWGGalbmx8ZRBt7Za10zl8HCGtEraQ==
X-Received: by 2002:a17:907:724a:b0:6e8:4f12:b6fd with SMTP id ds10-20020a170907724a00b006e84f12b6fdmr23155552ejc.198.1649864892685;
        Wed, 13 Apr 2022 08:48:12 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm1246147edv.65.2022.04.13.08.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:48:12 -0700 (PDT)
Message-ID: <8c1909da-8877-9bff-deed-c8f39037b3eb@linaro.org>
Date:   Wed, 13 Apr 2022 17:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: crypto: ti,sa2ul: Add a new compatible
 for AM62
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, linux-crypto@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20220412073016.6014-1-j-choudhary@ti.com>
 <20220412073016.6014-2-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412073016.6014-2-j-choudhary@ti.com>
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

On 12/04/2022 09:30, Jayesh Choudhary wrote:
> Add the AM62 version of sa3ul to the compatible list.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
