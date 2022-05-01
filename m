Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2151634A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbiEAJBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiEAJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:01:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9D5BE54
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:57:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l7so22886449ejn.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VxzhOhKNI29ABY/z1Q8INWKSwq3v8ujlfSDXX4pCSIs=;
        b=Nc0XV+AGpnLyL5MTK0YHYhYorLX6zh0t1zVTHhSVQ9WuqrLO4z7TFdSkQYDVYexvfC
         8bHjUi57kgKR1VJ/4cBa8UVzFhhZ94Hod1xfUbdoL3oiHv+yzW87UNFvDoX+l9n7NHAE
         SL9gMYeAYKexRzV3XrZI0rW5CSp0EZJGa/bS1NfbOU5V+lcKzv5G8yhkkUg5uxqbNrdr
         D80nOW5uCgmiphXWldTyqpckQQ1U01cwzcVLRH5opu5zlF3XuzGKCN8Cei2ds5+DbZMB
         5MsQJJw+mHMPB2kE0TqQPXl4Gz0DI9VWRgI/1Sno1dL46dydS7pk+I0aQppziq+YwwBA
         ooig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VxzhOhKNI29ABY/z1Q8INWKSwq3v8ujlfSDXX4pCSIs=;
        b=xRatm2aYtX+8lJ6fIK9BHaGsHtnz4SSiywMA6b1TmmUANX1jmvpgeHJYfovlcjxUH4
         4ucnN3UBi8Y8tq8JizZqow9+jwKZHA2op+HWWefPUOBUcN+AnLPGV21huaDawOV3rzw8
         PXpw4o0855IvVpElBaClvHXS/Mnk/XzTYpDTHNy9aWDSnK13X+KW5gWJMHlA+lShyOV3
         0YboPHoBRvvhXUnHO6XSbu2qplRDkoyE1ojpjqW+rgUISVKvNBOJqUANVEwjdkKEnpts
         Numzupm4NoLCl6Ci34BjV3Zebcgb+M4IYfKMwK9r1YHzrTZ4YYa7xx1iqwJMG+dE+5Qf
         JouA==
X-Gm-Message-State: AOAM531bKj4NXdIjxOCxyLxcf8GCVv92ikyFUPmGuSZSHO2/ixyiIVXK
        C8d10Qmt7KhjuI2bywOAOEHkGw==
X-Google-Smtp-Source: ABdhPJxECiGehT3UfPAMnfrXzNMRoQMI84gMv06eV57YnkzOPgX0NNKEMBNdrM7ajJHUdKKpsZ6heA==
X-Received: by 2002:a17:907:4c8:b0:6f3:beac:260c with SMTP id vz8-20020a17090704c800b006f3beac260cmr6610204ejb.321.1651395475314;
        Sun, 01 May 2022 01:57:55 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 20-20020a508e54000000b0042617ba637asm2437921edx.4.2022.05.01.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:57:54 -0700 (PDT)
Message-ID: <258640cd-01e3-2a9f-b2a5-79b2b6cc4f59@linaro.org>
Date:   Sun, 1 May 2022 10:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/8] dt-bindings: riscv: microchip: document icicle
 reference design
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, krzk+dt@kernel.org,
        palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220430130922.3504268-1-mail@conchuod.ie>
 <20220430130922.3504268-5-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430130922.3504268-5-mail@conchuod.ie>
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

On 30/04/2022 15:09, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a compatible for the icicle kit's reference design. This represents
> the FPGA fabric's contents & is versioned to denote which release of the
> reference design it applies to.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <mail@conchuod.ie>
> ---
>  .../devicetree/bindings/riscv/microchip.yaml          | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> index 3f981e897126..c9d8fcc7a69e 100644
> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -17,10 +17,13 @@ properties:
>    $nodename:
>      const: '/'
>    compatible:
> -    items:
> -      - enum:
> -          - microchip,mpfs-icicle-kit
> -      - const: microchip,mpfs
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microchip,mpfs-icicle-kit
> +          - const: microchip,mpfs

Blank line.

> +      - items:
> +          - const: microchip,mpfs-icicle-reference-rtlv2203

Why is this not compatible with microchip,mpfs?

>  
>  additionalProperties: true
>  


Best regards,
Krzysztof
