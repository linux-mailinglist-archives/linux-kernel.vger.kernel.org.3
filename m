Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527E857BC52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiGTRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiGTRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:07:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A96A9C7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:07:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x10so21409715ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nF82CbSzjB4MC9wpaiQHIZyp0ZgcCOKfhBJIGXNa9bA=;
        b=VgMxapGwYUwEykbln/Ma9xEWCj8W9oq8F1ll3h3azeOIofeVNXnlWinr2ECbzWKNfK
         SbmsnBPA3ZPgHlmvK+uI1Wa7L/OSGUBHDzbWt5SBxRWYrvi2x4nvyqwf9GfmpwGzmKJY
         m8d4fxNDMG6swC3unwWBDE1ONxxgk8YQewPKla8B1xpOg7WIh5JlvHLQ0raF44sDFS56
         lzfwuqT2Cbf21oRDRMyok3TfjZ8QQj1eXoa1IUzymhL8gAwOK6c5wj72BY/LhvA3jZ+2
         bRgI8/dXd6wpkjhG8vP47IQm8EFchOqyDWYBY1J79/khr8cYGXL1du6yMLiYpu5Qm2E9
         +G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nF82CbSzjB4MC9wpaiQHIZyp0ZgcCOKfhBJIGXNa9bA=;
        b=sivRjhjQPBKydZQ8n4pJgPmkg8bQ7jLigPuRzkGjlAJVLQkKj7eEB9qO/P6K4vAvYP
         ml5Osg8/mnDQDuLBcEsGlexq+36M9Sx3d8+BHwnYzLofvhS3YC9PwpZ78HGza6Ococqy
         SyXLGpqgxmFcF1VYOuHWpnWD9CQ3PSeLi+MT9B5w+wxnvab0dCpyMtqbJChL7oUJfrXK
         EiXzNlZr9NT3Fw5RVe4InceJU/zJvMm0Kp1Ikw+jQwwGVI/t3hOCapkaieQ5VksFpaFO
         pBXyVwhXXE01bwZYHuyMkbZV23nr0a7Yi0oOlmXQpQC67jZ9C02hEEJzcYYYanTx8lDF
         6EYQ==
X-Gm-Message-State: AJIora/XNNqqXzVVJ4zdU2n9FpwdMtmfueciSi8ZdLoK+j4jB/1wHNvj
        MSguxFuX/HPRj+dVwpKqVuOJpg==
X-Google-Smtp-Source: AGRyM1t0cefk6MLwhVq0hDuIoMkoIoRaFwVpce73Q4Cdi1YynQTyz1YKCigu5bvy0UQLy/JsS1cpKw==
X-Received: by 2002:a2e:8814:0:b0:25d:6833:655d with SMTP id x20-20020a2e8814000000b0025d6833655dmr16845259ljh.172.1658336864412;
        Wed, 20 Jul 2022 10:07:44 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512358200b00486d8a63c07sm3916674lfr.121.2022.07.20.10.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:07:43 -0700 (PDT)
Message-ID: <abd47815-c84b-115b-f6f2-b6ec0dbf1bef@linaro.org>
Date:   Wed, 20 Jul 2022 19:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MSC Technologies
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720150007.2168051-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 17:00, Martyn Welch wrote:
> Add "msc" vendor prefix for MSC Technologies GmbH
> (https://www.msc-technologies.eu).

Does not really work - leads to Avnet, so there is no MSC anymore?

> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes in v2:
>   - New addition
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 0496773a3c4d..1658357bc1c4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -816,6 +816,8 @@ patternProperties:
>    "^mrvl,.*":
>      description: Marvell Technology Group Ltd.
>      deprecated: true
> +  "^msc,.*":
> +    description: MSC Technologies GmbH.

This should be rather msct or msctech, but anyway in fact you maybe
should use avnet?

>    "^mscc,.*":
>      description: Microsemi Corporation
>    "^msi,.*":


Best regards,
Krzysztof
