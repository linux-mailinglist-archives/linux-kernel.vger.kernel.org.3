Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045C3582619
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiG0MH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiG0MHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:07:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0C4B489
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:07:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w18so8510007lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P+2FHV1UyVrnsYNntWHopzv4+MXcff3Of4ioJzVnCGI=;
        b=AnjWDI8tr9bmZBYUFMj9WPOl3m53p4x/SYpzv83Z2ehj6b2z5tMohFMPs66mns4vtc
         F/SNUthfL0SBnMR6A5PHNawbqprmZHCGM8GPGB15ac2wkhyNqIl1KNLdyBx61K+BAUNL
         jocFxnN7BpnKnJ6SSfKw6fW/CS1mnG4kGf3tr9tXRV49p8zNvIPdzlwfffMHUsqkw5jR
         vUEDwdjzBSf7aCCkIaQBkGOMv6Hh3n6kPErwGpbNTbtC015ZZXyQLxlpQDEWD0bnXXNz
         y30vudbTCmTfC10TrgUQx+B9RbsZ6WMfh6Ukm66KrPi9H8m7J2ALrcwfnlnV1kDfRvY8
         lKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P+2FHV1UyVrnsYNntWHopzv4+MXcff3Of4ioJzVnCGI=;
        b=w2PRi28RuLl91Ow7OFRh4ZPlA3xWjX97TSIhrrmzQ2p5Szg4uOXLbMOI9MvKS3b9l/
         Q50CVLH7KtBqyYi9OmuNZJPz5f4VUkNuscBpzy30r1Z4cJGzxbz24iMdzzFnWLBc3fPv
         mxT6CM1UthX5p9AtPB1jvXdt56st+EYRMcku/tO95dQHeKmIIk1Couv5PGYNYHTtYJGf
         AhRp6JwoYP7goi1IH+9ZhLX9q4yGIdnM7b8K5ywbJWok1w+LQczle261N6vDafQc3vbf
         PX5zPIsyvTtkii7oBOas3ldAMWoKnOAbYaqe5PJ7jhh7rQuDZLWalCdeKBrmwaOYnLiP
         BXjQ==
X-Gm-Message-State: AJIora+F6mz7vl9tIgS6fldNuX4/N462IYc8rOvMFObyWRoV/SiA50A4
        t80i2sEGz0kMu06ISGk17K3sUg==
X-Google-Smtp-Source: AGRyM1tefcSIkMswKYXFzdVt4s4uRUWesrNpwAbExSgtNMXR5q2dqpfuBJJUEyVR9BHyqpbYoCJv5Q==
X-Received: by 2002:a2e:8898:0:b0:25d:fc17:5efe with SMTP id k24-20020a2e8898000000b0025dfc175efemr7083795lji.132.1658923672053;
        Wed, 27 Jul 2022 05:07:52 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b14-20020a2eb90e000000b0025dda2c8013sm3912287ljb.28.2022.07.27.05.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 05:07:51 -0700 (PDT)
Message-ID: <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
Date:   Wed, 27 Jul 2022 14:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727114302.302201-2-apatel@ventanamicro.com>
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

On 27/07/2022 13:43, Anup Patel wrote:
> We add an optional DT property riscv,timer-can-wake-cpu which if present
> in CPU DT node then CPU timer is always powered-on and never loses context.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index d632ac76532e..b60b64b4113a 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -78,6 +78,12 @@ properties:
>        - rv64imac
>        - rv64imafdc
>  
> +  riscv,timer-can-wake-cpu:
> +    type: boolean
> +    description:
> +      If present, the timer interrupt can wake up the CPU from
> +      suspend/idle state.

Isn't this a property of a timer, not CPU? IOW, your timer node should
have "wakeup-source" property.

Now that's actual problem: why the RISC-V timer is bound to "riscv"
compatible, not to dedicated timer node? How is it related to actual CPU
(not SoC)?


Best regards,
Krzysztof
