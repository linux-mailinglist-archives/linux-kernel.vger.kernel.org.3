Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02257C882
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiGUKDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiGUKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:03:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9327B0A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:03:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q7so1186922lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ud+C26ftZa8Rjz2cAIccHjrt/I9qI0gljR2yYnoWRkQ=;
        b=ZCTvTZvRn0VmeOXuCxr1aekjZ9egVJ37VVbflZ/+7uPXHfd//QVDshqRxWteSpAohk
         kztzMWMxyarvNzTNImqHPcuYrXBqOJrais30YJEMEPNUAaboPWk6sCrVRYykmRuP5T/3
         c+jMJv/1uBrLaeXl9AxiDfvkK7xRsh61QjAJ7yNgxHi7vdTuEB3cWBUuUwPB3qsZev/E
         s8QF3xJpMMBw0wW7/gu5ysMSqlwIGJW67C8VreBm/qzb4GnFb2jhbdKNdoYdhn6FIEgJ
         C9OI9NHvDkSo2J8So913fOF/oRRFiVhUSSW1LhVxeo94w89EOK2oogomVwodkxaOtDsY
         1qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ud+C26ftZa8Rjz2cAIccHjrt/I9qI0gljR2yYnoWRkQ=;
        b=7aiq0Df24r9gg0jzbjL8/rAMedy4yywpdIu486Be4kgXb+gpJepN0FO06cptrRZLUa
         7/ai07ITW47gQL7K3c/N92QxKIqKVSIefEcg426lS0U7f3eYdesYsGmy2yjiesMJMU6o
         3lN8RNHH4bQE8NkK+/S71k84oqvFludoCDfVe0i6RotfF3UBmpQAQbsed+ziPJ6LUO66
         DXi4UNKRG/02ktENXsGxgVWA7yAuNIc1DoBVWkptLFuF8IfPyYHuq55V4IZ/PWMxjpA/
         MS2Xk0I1WOzDbQex00N7czBg/NVp8Gv6S9jwVbhRmXgIIKuZ/OsUOtUVoAh4TFAy2uEc
         TZ0g==
X-Gm-Message-State: AJIora/UxWqPO6vOu1B8ymPuDmsO6nUJ4A/hlBDFYOoj0L0U+NUDmcze
        cEzwFfm9tO1RKaplfPFPFYHURw==
X-Google-Smtp-Source: AGRyM1sAtAw6jE5W/RlytvzZwARbxPwr67MRRb7HkXSh2iwahMPMd+mQxDNtQB8+L9mH/jg0RrKsAg==
X-Received: by 2002:a05:651c:109:b0:25d:5889:cfe6 with SMTP id a9-20020a05651c010900b0025d5889cfe6mr17777290ljb.184.1658397820158;
        Thu, 21 Jul 2022 03:03:40 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b0047255d211c7sm339564lfo.246.2022.07.21.03.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:03:39 -0700 (PDT)
Message-ID: <9448dcb4-7eac-7efa-0062-bcc1797fa09d@linaro.org>
Date:   Thu, 21 Jul 2022 12:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dt-bindings: gpio: fairchild,74hc595: add
 strobe-gpios property
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <20220721093422.2173982-2-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721093422.2173982-2-marcus.folkesson@gmail.com>
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

On 21/07/2022 11:34, Marcus Folkesson wrote:
> Some shift registers (74hc4094 for example) has a strobe signal to latch
> data from the serial input to the parallel output.
> 
> Add an optional strobe-gpios property to support those chips.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/gpio/fairchild,74hc595.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml b/Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml
> index a99e7842ca17..9893df9ae22c 100644
> --- a/Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml
> +++ b/Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml
> @@ -14,6 +14,8 @@ properties:
>      enum:
>        - fairchild,74hc595
>        - nxp,74lvc594
> +      - ti,cd54hc4094
> +      - ti,cd74hc4094
>  
>    reg:
>      maxItems: 1
> @@ -33,6 +35,10 @@ properties:
>      description: GPIO connected to the OE (Output Enable) pin.
>      maxItems: 1
>  
> +  strobe-gpios:
> +    description: GPIO connected to the STROBE pin
> +    maxItems: 1

This should be disallowed (in allOf:if:then) for variants which do not
support it (or do not have even STROBE pin).


Best regards,
Krzysztof
