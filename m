Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE9589E69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiHDPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiHDPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:10:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D61F629
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:10:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so31270155lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hpeUu0NXjIKeDxrj1XvCVY0IHP/A19r5SCTdBTc4poo=;
        b=Kh85gxdhYSlqdAnFGKtWf1X96UzuK99fB6PMLFsVEir/gy4CUTXn9Q7gSQH5HL+hmH
         5fiv8sKP+9XHg8rdOWvWxqwaj7k32XabwOvuFHXm6V4+fiSewoNo7hCDwZjQhDueqYs4
         XmK1MIYM4pM3wyYF1RxI+TH/M5vUofrOuwJjH0qoJncp45EVEmEP8BBdkio5kcQRusl5
         eCOAyTxCaTM1qoZfqFataziHaodtWfuCxYzmBQ/270eymSl6EMjyM2W4U37kyJfn992J
         UFAdcrInWKtDTeTvAAK+KXcKmUpewoBoic0kwTpHhwXWs6UQBsaP/Cx8RMrW0w73Raa0
         nGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hpeUu0NXjIKeDxrj1XvCVY0IHP/A19r5SCTdBTc4poo=;
        b=DCh8sZwdvzBc2Zb+A7hWLKr+notTDPaZk1kHlH43mVxDFCGsiyZX4daTjE+EpdW3jS
         kYFV8mMOx7MikblR98t2acgTrDiufp33LJXj8P/kYkqQhDu5YFCLsIfVY8T6ay7iid3O
         9xZUrQetJUKS7Y0lRqpOOILVqs5kMncdwpvgdxXxneWRWMp46D80MhCJeai0K7gUNYYv
         uvCLHMedXtmvf076pAYPCPUlzHJw8TERWJGGjH+6/TxEggAWhmocvCvDgiEoYNTkU0k3
         ACJ+pnWbYn6KvD3EMyxDHqSfMRjuQDMXuRQCpX+YWgp6Mu/LwOWD6Ccx9ruOylOqk4De
         xbFg==
X-Gm-Message-State: ACgBeo27uExH3JBfxq+RbOOunw4g6PHHLog0BDpESQMWTdU/kRbdkGnl
        rPbM0bwW00D1qLGx1kEbTUfzyw==
X-Google-Smtp-Source: AA6agR5P+y/EbBAMoQ+LTEgNQu0vBX7lomMzrDb+OspfhiiXti9s5Ad+GU6HMsv+zF+cKNzhJcVZ5Q==
X-Received: by 2002:a05:6512:3192:b0:48a:a8fe:1407 with SMTP id i18-20020a056512319200b0048aa8fe1407mr889711lfe.550.1659625821153;
        Thu, 04 Aug 2022 08:10:21 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id h4-20020a19ca44000000b0048b041d96dasm149994lfj.153.2022.08.04.08.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:10:20 -0700 (PDT)
Message-ID: <1260ddb0-7022-4934-e579-8ca6d9e87b7f@linaro.org>
Date:   Thu, 4 Aug 2022 17:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220804092710.64636-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804092710.64636-1-krzysztof.kozlowski@linaro.org>
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

On 04/08/2022 11:27, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed iin commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 1895ce9de461..20469519e497 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -80,7 +80,7 @@ properties:
>                - ibm,tacoma-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> -              - nuvia,dc-scm-bmc
> +              - qcom,dc-scm-bmc

I missed to add last-minute change, so this is not correct.

Best regards,
Krzysztof
