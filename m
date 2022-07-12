Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77765571434
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGLIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGLIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:16:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23B9FE2A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:15:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn33so8971008ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gz399WGL/sxc1W3UfSmBpMoYFpV/x2jFmQy30J4h9co=;
        b=Bimnodoh6uwfH+NtlsoPLf/Oi3uwH1U9mdkas6pSxeNsfHtRE/ouuE4NVGQXKwO5Ax
         tgvQA8BXdm4JLpKz3Dr5HtOmGssyEfVYflCnkfelRrnRkJQ8oRqe64GooyhRUHDjxkU2
         uXEr9MrHoUyP7oUgs/ylu3G/cHCV6/1nzTL7WceYyjQxzpK/JAmDtnsXvuIZIKB1NGUC
         XbpACoUKcn5zHbBCzfUQFmokEf57OrJIzLb+9fqHGkyR8uL+Kl6bNRIwYHywCcX9/Fl7
         9Qp7DkcGbr3dz6kwCX9WBZZWJqGPKP9ClckhirLmqBZtK20HbS5z9B+ncQ52UQQxYQv+
         Rq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gz399WGL/sxc1W3UfSmBpMoYFpV/x2jFmQy30J4h9co=;
        b=eKSygiupd52e4P5NeM/hpUuI5zsrXUM+wT4IOfchYuQCMCg7VmO2kbSGna0YnjRUbw
         2UvUNKUWcceZc6yrbQ8Q4kT39Uv7x5pSCwpvvNDLHVg4Q+M6hZGGlH5MZeJIBwn/Gx7L
         pJXt6UN1WPSP6FqYHPHj5dxmOYJ7Pd6sPsu39ECbTCdSUtBt1VzRoMOWf54m+n0ueCKt
         GwoXn0ZqD1ab7AcKOD0n5o0+QN8K+kF2WokRKDHEze82/zwT9JchBz7gQBtubx95wkcn
         EL+zwzXmDDsZXpe+mOv29guVKPnUiDLK7JgTxoePmblGJep6HVA1vtGJXwNG1XkbHoKE
         5R1g==
X-Gm-Message-State: AJIora96mOdV12N/isoOrWmHSkA1iO/AKPZtydcVG6f2O4OKmEtQgpD5
        1sRgdB8GM9H8ief2FPqJHbxUaQ==
X-Google-Smtp-Source: AGRyM1uthbH4eFg5trDb190JDSVIAHXMJyTiKFa+qO5+e0KBkT0TIyS1XH4glZaTr2Im0vcadeZUXQ==
X-Received: by 2002:a2e:a172:0:b0:25d:6242:ee10 with SMTP id u18-20020a2ea172000000b0025d6242ee10mr8419047ljl.399.1657613757286;
        Tue, 12 Jul 2022 01:15:57 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id j5-20020a056512344500b004855e979abcsm2038559lfr.99.2022.07.12.01.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:15:56 -0700 (PDT)
Message-ID: <154dd9ef-cb8c-d8d7-ae62-a73bac160089@linaro.org>
Date:   Tue, 12 Jul 2022 10:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: npcm: Add npcm845
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220711134312.234268-1-tmaimon77@gmail.com>
 <20220711134312.234268-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711134312.234268-2-tmaimon77@gmail.com>
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

On 11/07/2022 15:43, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 ADC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> index 001cf263b7d5..c9e9c5bf5e5b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> @@ -14,7 +14,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: nuvoton,npcm750-adc
> +    oneOf:
> +      - items:

This does not make sense. oneOf with one item. You also create now list
breaking all existing users/ABI.

You probably wanted an enum here.

> +          - const: nuvoton,npcm750-adc
> +          - const: nuvoton,npcm845-adc
>  
>    reg:
>      maxItems: 1


Best regards,
Krzysztof
