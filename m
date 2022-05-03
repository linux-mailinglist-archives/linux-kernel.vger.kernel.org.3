Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68835518888
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiECPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiECPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:31:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC827B02
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:27:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so34186308ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L6oXqkRjevAiSpdcYfwuhncdluuEc39LTg7cz7sxv44=;
        b=p6Wlte4YRrG+PPoS7TrcRAaMr0qDMD7PmWOJ0pJJPpeH1mP4X9eBUE4gCMjniy7uxz
         7TRw9XBlGC5WN3G9wMym34kIRrPfJZ1gH3lBd7GelJX8UMX+bgNxIhauP2vff+6gtV2u
         7Xr4SYvE3iqG/A5Oy3ggbYQH9eaWJmLTsi1qbXEvWcQ3Z4No9G8A41dBoGRJhMHeAIN3
         cuTZIrVB0uMy0tnY3GPAWjQzsu/k0GNhOds+pgjoOIbOwkYafWtLi4mxYKK2barRqIWD
         nq6XjcsOoELKrONoKu4SNeYzC4Uu4asvRpF+jiQWmRn1BysUbjyROfa8t4mm7JC3DE98
         2zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L6oXqkRjevAiSpdcYfwuhncdluuEc39LTg7cz7sxv44=;
        b=wtL/rTxfDKS8S0L0wN/N8ruRql5VmAZYDGloAjJcanhohZ8di6pdUWkmPAEjq5+pXe
         XPwjpzGGyiJUcD29qp3j0BbIv0TW2eDkEGU3Z+HhZWHr2rQEQhrVWxvvWtsaOAXJlOcu
         vff2FeTTs8Lt/iLtCQqvqU13/wmKxYaUQN2GF9zDIIkqplTbWyVamJOlKBQdHRwklN+l
         c8xv1c5bsfeKMmmhJVh0hfsF5NGKq8TNV0u2l0nkUQg/I3QqjpbCgy6BMjdeI1alAn+E
         4REzM/9Fnpdja5GwQ34lT/Ur7zAsW5TIqQzWTY+llsnWzt5opKFeEqJTEK2RHkrUob6N
         DM0w==
X-Gm-Message-State: AOAM5314JqCnyq+3GE/xvfCVvol4vPCH6e6oZztzDwBlxnvxgyOBLyxC
        VTUB6HvNFT325U/2T98NzmuYDw==
X-Google-Smtp-Source: ABdhPJxc19WIlaFr9ahic1DRLVpqXf8A75EvOm0t8s1BnTCQdBOeU9gDZlV2u/An2woqNeimRSjzZA==
X-Received: by 2002:a17:907:6e2a:b0:6f4:69bb:7ef6 with SMTP id sd42-20020a1709076e2a00b006f469bb7ef6mr7018280ejc.0.1651591652601;
        Tue, 03 May 2022 08:27:32 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402150c00b0042617ba638esm7963161edw.24.2022.05.03.08.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:27:31 -0700 (PDT)
Message-ID: <bcf0eb84-c749-c900-1be4-aa5ecb1a5a8e@linaro.org>
Date:   Tue, 3 May 2022 17:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/8] dt-bindings: riscv: microchip: document icicle
 reference design
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, krzk+dt@kernel.org,
        palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220501192557.2631936-1-mail@conchuod.ie>
 <20220501192557.2631936-5-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501192557.2631936-5-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 21:25, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a compatible for the icicle kit's reference design. This represents
> the FPGA fabric's contents & is versioned to denote which release of the
> reference design it applies to.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> index 3f981e897126..7a1f883a39b5 100644
> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -20,8 +20,10 @@ properties:
>      items:
>        - enum:
>            - microchip,mpfs-icicle-kit
> +          - microchip,mpfs-icicle-reference-rtlv2203
>        - const: microchip,mpfs
>  
> +

No need for this line break.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  additionalProperties: true
>  
>  ...


Best regards,
Krzysztof
