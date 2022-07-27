Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B860358226F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiG0IvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiG0IvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:51:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F51A07A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:51:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u17so8917124lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1AeHnnhcT69ZrVfPR/zgIWRlaIcZ2YpF+8w0N1pOEoQ=;
        b=UQXl4JOAj4zgD6Ihx0+LdJYT+f3u0Hj1g8S16SQzNPc4kp2ueYOIOI3Cm7QqPHt8Pw
         g7uAjrSLRIZQT6bZhii3t7DvlV0kXlkxeNyc+J360ubmjy5/gFLPR6Al9HJqQMCkRMrf
         QNgfcip4vKmdFOUjZ8glPO+UXeYF1jnimpRQCWpZb+OqOrdpSRzXOc44mH68OPu/wSws
         X+e3nRT2016M+RZmay/TwhOMXw5URh3CU1HYWHVtvSJ7RX/0RDIaLwbkVuTGj0eWi4hD
         Zy0Xe2ww2VzQEXHcDlrCcFVG1rR/ExW2p+Q4pK30B9+MmB1uyx/OScDD+18eqlLkwJOo
         PsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1AeHnnhcT69ZrVfPR/zgIWRlaIcZ2YpF+8w0N1pOEoQ=;
        b=wc/l+uzNc0R0Av0P/MebT+iY+ErCrfsy/+QxsfH6SsXLyp/+i3PXnT2KQCQwElbf9J
         Aqx0ol6x5d6JxPOLHYbHj98tvATTY+bh3M/RzFqQBT2Zs5W9C+X9tMC6hmHIgxbBcWnW
         Z/sdgmWeHrqmCSN5bQZBu4RVtbIjmDdiaEbt4OuSziXLwz7OiaAeP3ss4HyJD8Y+NKxz
         E0TqkdngXveZbpu2uIZRD97TMI5WadLXL9diJHU/BqXGhmX+hEH7F5rvVUFsVKj1ebBk
         2LSkyDExT+97c5JEH/M2GSGw0Gd3WQwbchmpIwyZOFL4r5P/sUb59Gp6s8I/Y5hUHfwo
         L96Q==
X-Gm-Message-State: AJIora9JILYPyy433G6Nm5znfnpMoJnCVx8UbF8p/v4UhCSiDP85m9iK
        +hJv3TC0A8O+EgxUdniJ4AxG3A==
X-Google-Smtp-Source: AGRyM1uAQEDdTmc0WVn0GQ7HOUPV1XPXnbWhkzm7wPSzMTpaVTeB4B2RlsFGYOin2XkzwgspWV2ayg==
X-Received: by 2002:a2e:98d5:0:b0:25e:c1b:f262 with SMTP id s21-20020a2e98d5000000b0025e0c1bf262mr3740065ljj.343.1658911861726;
        Wed, 27 Jul 2022 01:51:01 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea447000000b0025d715bc088sm3754349ljn.0.2022.07.27.01.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 01:51:01 -0700 (PDT)
Message-ID: <7a02225c-5c7b-f342-e29e-995d1ae0f4e3@linaro.org>
Date:   Wed, 27 Jul 2022 10:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 20:06, Lad Prabhakar wrote:
> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> (RISC-V arch).

Your commit msg says one, but patch ignores r9a07g043f01 which sounds
entirely different for non-Renesas people. Be a bit more clear.

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> index ff80152f092f..f646df1a23af 100644
> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>  
> +# We want to ignore this schema if the board is of RISC-V arch
> +select:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          items:

It is only one item, so I guess you wanted here enum.

Just like syscon is doing...

> +            - const: renesas,r9a07g043f01
> +
>  properties:
>    $nodename:
>      const: '/'


Best regards,
Krzysztof
