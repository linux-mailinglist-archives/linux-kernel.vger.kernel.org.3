Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F2539F51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbiFAIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350802AbiFAIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:21:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C848BD27
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:21:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fu3so674534ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uO7TEYH3azvhwUyM/ipGTxrXysRtvFN6/SIsGkR3HG8=;
        b=NjkKPpXGmU+NWHErKRRe69EDWMeEzFKN12rgI/cXEJyhK2DGo3DmwzEMiyOtRy1ihi
         IqaDhDD/6v3DkysFIjotnu5gx66Jl6NaYz5KU/2VGuB8wktg++UdGT1+tqBEI0T7iI24
         rWii3MCxkj3BWY441vC6tBOaQ0HIUi4C3keOLcsbYqeDfIiXmhXGibwTzPgLxKgmnL9b
         6lTeIkJAnvmIIUMQ0DaB60AQp0T0OuhKXlrrh0BlFL138DKvHgmwrZvi55lnimpNJW0b
         jHp84uVsOOPlPp+3Ki6RqdzbYs/R/270H669Sidw02IyMZcItzMOpnxJt/WBddIElBp/
         rDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uO7TEYH3azvhwUyM/ipGTxrXysRtvFN6/SIsGkR3HG8=;
        b=U9LGk+IfZ+0B0LpZBZr/ndLKWzmX5eTdRPRNaui2ZANVgJA2/DZn/QJnxXQrCeJrsq
         +kir6v72J0Lv6Rl2hQC7TqTue26dXaScXu8JWQdxeqf4KajpaWFdxqpAepMXm/T5+gCV
         EE4sD5Sto38Rqa1RVK4txTERlZ0eeQQZiG2NcPeqbvXPcDT5xzkiGy1fS/uclIhVLVr4
         flMBM+D8fmFn8AORduzmrKkngdT6PlYt5cG643q2dvugT8wesmY9eeGxNu7mgvTPi71w
         cCjDq+gLvB/sGFGeBjuftbDi9sk+/o6bphaT5qVBP0x56uUj6zqVuGvkwErf7UZwYxyH
         uAWw==
X-Gm-Message-State: AOAM531JCOf/g0agHS4vFPw+33tuaKFT1jL+idQ9GLiUToyuOURNuYra
        BxdN87nORd5PTOnFZfwNpuRAEg==
X-Google-Smtp-Source: ABdhPJxKj1Jtc7LrmTypfsrPkk0nq3I2k/e/DRTwB3m8//Qdldwrqd8prSgRiLOzKRRtSPx5IElP5Q==
X-Received: by 2002:a17:907:3e25:b0:6fe:fd4a:5b5e with SMTP id hp37-20020a1709073e2500b006fefd4a5b5emr37922766ejc.280.1654071662090;
        Wed, 01 Jun 2022 01:21:02 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kl10-20020a170907994a00b006fec69a3978sm408458ejc.207.2022.06.01.01.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:21:01 -0700 (PDT)
Message-ID: <23cd3eff-0b51-8b03-8df6-b2eb8e131ef3@linaro.org>
Date:   Wed, 1 Jun 2022 10:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] dt-bindings: arm: aspeed: document board
 compatibles
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220601080856.1548851-1-David_Wang6097@jabil.com>
 <20220601080856.1548851-2-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601080856.1548851-2-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 10:08, David Wang wrote:
> - Depends on Krzysztof Kozlowski's Document Board Compatibility Patch.
> - Document jabil board compatible.

This is not a proper cover letter.

https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L751

> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 5c9aa014432d..407cfbe85153 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -78,6 +78,7 @@ properties:
>                - ibm,rainier-bmc
>                - ibm,tacoma-bmc
>                - inventec,transformer-bmc
> +              - jabil,rbp-bmc  
>                - nuvia,dc-scm-bmc
>                - quanta,s6q-bmc
>            - const: aspeed,ast2600


Best regards,
Krzysztof
