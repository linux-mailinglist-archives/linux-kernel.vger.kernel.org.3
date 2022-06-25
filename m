Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6802355AC47
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiFYUBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiFYUBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:01:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771C14095
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:01:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so7776618edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eLUkWe3N3ho8cfTa3t+ONCUq2y/Cga4VTVfEgbT2d1U=;
        b=I2f9aiJ4WaR57Hl9e0IVnNn9g3MVdrAIgnzqHEx1MDg/UGlaNcpuj4OyVgpYP1pkl6
         4LgzUHyXA2VC/pIMRlodhwg34bqqqqkjlpXA9EJU0H2ksIKBr09Rb/T/avrwUeKAKZcV
         1o1+wQbjaw4HRM4VcoSsMo4ZAGRHcK+Nj4Z45cLKt58jrkBMH9BORte9KoVksmw6ptkJ
         XEO0wzI1igrcB1la/uawH7JovJkaIj/oBgy7tl5FlInlVMYpTOasxUKyINVBJVGgApmK
         Z513MT9xSUTHEyHNmd4wUtQVJf1/l108ht7zb6MihdORGAjzV/G8MrKyRVzYMauqxrL5
         mciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eLUkWe3N3ho8cfTa3t+ONCUq2y/Cga4VTVfEgbT2d1U=;
        b=STG4HVbHT+cnmDb+aZWZ80xee7CcRej3C4hTjcpSunUK3t5TuQRdAv0o3Ixmg9Nb5A
         xGA7IG3puqxoRCccjfcrUQYmDxRKkVuC3yVsYEzICyQQFCGGzEaHpeoEL9N8vRuq39za
         F6L3EeQbaF2u8kiav+wRvwt5Ej+KrN512DXzdyf0e9RdMMv3Ne6vzttjGroz0uEMXrn7
         yIBUzniat4g2Hn01qt9K33Pcw+MozTVVjI59n9Sz/xGPHwAcwk/DogS37jAFMOtz/gsD
         JjAVnnIHJenKaa1XJ/ZiH/y/JJfRfVYmf1GE94efrv6dAP0yAytrTxdEER043WyaA8R8
         bd+w==
X-Gm-Message-State: AJIora9VIsQBrNAtMeXFuAQRrQ6ycY5Cbl6Qds5xi02yANtYn62CZza+
        C9Ba/TPrrJv2JySpMAWchYlw8w==
X-Google-Smtp-Source: AGRyM1sknHsOi2FQ+azTJL4HGK/J1vfpZw0VDY8r98cQEG7zXxJxXdhGXAKaEoTZ33YbJW1joA6xWQ==
X-Received: by 2002:a50:fc90:0:b0:435:6b30:f1b0 with SMTP id f16-20020a50fc90000000b004356b30f1b0mr6885798edq.423.1656187299784;
        Sat, 25 Jun 2022 13:01:39 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a7-20020a056402236700b0043570d96d25sm4522957eda.95.2022.06.25.13.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:01:39 -0700 (PDT)
Message-ID: <59c043a4-dd40-1f6b-69d2-bc32b970e874@linaro.org>
Date:   Sat, 25 Jun 2022 22:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624180311.3007-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624180311.3007-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 20:03, Lad Prabhakar wrote:
> Document Renesas RZ/Five (R9A07G043) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC->v1:
> * Fixed Review comments pointed by Geert and Rob
> ---
>  .../sifive,plic-1.0.0.yaml                    | 40 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 27092c6a86c4..5eebe0b01b4d 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -28,7 +28,10 @@ description:
>  
>    While the PLIC supports both edge-triggered and level-triggered interrupts,
>    interrupt handlers are oblivious to this distinction and therefore it is not
> -  specified in the PLIC device-tree binding.
> +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> +  to specify the interrupt type as the flow for EDGE interrupts is different
> +  compared to LEVEL interrupts.
>  
>    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> @@ -57,6 +60,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-plic
>            - const: thead,c900-plic
> +      - const: renesas,r9a07g043-plic
>  
>    reg:
>      maxItems: 1
> @@ -64,8 +68,7 @@ properties:
>    '#address-cells':
>      const: 0
>  
> -  '#interrupt-cells':
> -    const: 1
> +  '#interrupt-cells': true
>  
>    interrupt-controller: true
>  
> @@ -91,7 +94,36 @@ required:
>    - interrupts-extended
>    - riscv,ndev
>  
> -additionalProperties: false
> +if:

Make it inside allOf. Avoids further indentation change on next variant.

> +  properties:
> +    compatible:
> +      contains:
> +        const: renesas,r9a07g043-plic
> +then:
> +  properties:
> +    clocks:
> +      maxItems: 1
> +
> +    resets:
> +      maxItems: 1
> +
> +    power-domains:
> +      maxItems: 1
> +
> +    '#interrupt-cells':
> +      const: 2
> +
> +  required:
> +    - clocks
> +    - resets
> +    - power-domains
> +
> +else:
> +  properties:
> +    '#interrupt-cells':
> +      const: 1
> +
> +unevaluatedProperties: false


This does not look correct, why changing additional->unevaluated here?


Best regards,
Krzysztof
