Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7895237EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbiEKP6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbiEKP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:56:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9D617E1A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so4937216ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NCe9eepcmm5pM5STfrqjZwU8j89Uv9lHGyRkx9Iwq7c=;
        b=Zf8SCCkecXCCgEpaj2bLTJnzLOAmeR7CkZ7qOrUm2VO2kmUIAyKx+F+AeNYE+hpIQx
         JmcJte49LifGKo1REd5LPpB9yjV+Wikmg6YEInDyICKBVxrljhKGKuvd6h5VDoltLs67
         9lfvO1SZbo645yyeoFeJ8SxtbSTXYgXVCZXlMWVqLhRJm0W6QD0rRfO8Y3l/nfxeSxJD
         s8/06VJGXUTALB4Idse2+Qy3zm0XwjY8OV3VduGeuqaAaJVUOzqYMcHVGOZhzkf6P3Ap
         mB892jCfGIVU/rzrsFIrST1Cu37urTZsLq6mCx9NhrKcYQOoNFm8YC/UvOmDe944YAmP
         48gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NCe9eepcmm5pM5STfrqjZwU8j89Uv9lHGyRkx9Iwq7c=;
        b=P2R+08Wd7mlTG7Q/0vZg2GW0gxBR1TaK/lHu7QzWrsDyYTPb6Wsujv9CSWyaQMHX4L
         51oajosClKlzCvCG/cdy1y7dhmCoEv0w0RQ0ioJywr+yFQIQpGCW8EJk1fAGFhxJ77b+
         SqKm7c5Rfser5dCdO/L0sIjrKCdou38lDa1HP5nzx0vb7PhJ7wkxae7+DVvAm6LtNFYG
         vypkL3z0pGn9fEpu9CKLeYN8NM6pSYg2Px2aP+amyUtEXPdypI+44r5cHhqYzH08hfN0
         IHI6Xr/7L/k7qFY/oo1B7imid97WIguVm0LdBGvW21Hg9ysVd/9npzASwYmj+e+od/i7
         0gQw==
X-Gm-Message-State: AOAM532MrP3IBqiorend4DDxklcykFOxJH+b2BgFUzQ4P2iW2U3mL0S5
        okvLMenv5NHHMVzT2XXx4D5y8w==
X-Google-Smtp-Source: ABdhPJwMm4BtwRwLHiFzR5GYSDOEL//zHF9zXAAhO7EeCdx/TbOGi5w/JLyVYJRIx/zVNYSRsIIgQQ==
X-Received: by 2002:a17:906:794e:b0:6f5:2072:b00a with SMTP id l14-20020a170906794e00b006f52072b00amr25202218ejo.277.1652284556612;
        Wed, 11 May 2022 08:55:56 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fl20-20020a1709072a9400b006f3ef214e13sm1078644ejc.121.2022.05.11.08.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:55:56 -0700 (PDT)
Message-ID: <59d23590-0b1e-39f0-80f1-d875081a276c@linaro.org>
Date:   Wed, 11 May 2022 17:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] dt-bindings: gpio: gpio-mvebu: convert txt binding to
 YAML
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 03:37, Chris Packham wrote:
> Convert the existing device tree binding to YAML format.
> 
> The old binding listed the interrupt-controller and related properties
> as required but there are sufficiently many existing usages without it
> that the YAML binding does not make the interrupt properties required.
> 
> The offset and marvell,pwm-offset properties weren't in the old binding
> and are added to the YAML binding. The offset property is required when
> the marvell,armada-8k-gpio compatible is used.

These properties do not look correct. It's some hacky design. As I see
in the driver, there is no reason to model the gpio under the syscon at
all. The GPIO has its own address space, which is for example in
armada-ap80x.dtsi 0x6f4000+0x1040.

Instead of describing it as a separate device under that address,
someone created a syscon node for entire address space, put the GPIO as
a fake child and added some new property "offset" indicating address
offset. Wait, what, why?

Why this cannot be a child of SoC, just like all other nodes are?

Since this is a conversion and offset was never previously accepted in
the bindings, it has to go to separate patch where you will need to get
Rob's ack on documenting offset.

(...)

> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +unevaluatedProperties: true
> +
> +examples:
> +  - |
> +      gpio@d0018100 {

Wrong indentation. See example schema.


> +        compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
> +        reg = <0xd0018100 0x40>, <0xd0018800 0x30>;
> +        ngpios = <32>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        interrupts = <16>, <17>, <18>, <19>;
> +      };
> +
> +  - |
> +      gpio@18140 {

Best regards,
Krzysztof
