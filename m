Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D25B20F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiIHOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiIHOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:43:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA631D2777
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:43:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w8so28041174lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n8VGGC+7+I4IjFN0ib/PUjyurgUsEjooklHf6RmDYUg=;
        b=ZxdGhDBFjbOpQmDm+bvokfEUhGG1h4jISBv5G5/iyMzHUYo7MnhY5DCOp8n4Is7E0Z
         TQTTn9foxYpacFYzuB0/d1SJabnhH/mgJR82/CeiVTjvwgeQHI53w1FF2AL2D7UwIFGY
         W2LUkr6K/RkMpBo8gNMhXcp4LiQSyz1W11dvTKUjs3+Ux4uh2UZTfG2vk7bkaCnY+eRm
         jTT/Chbtx29UvPTz+OGPLt1w/xNbNEERAhEFW+5WAGTncArweLWKH/9D5pyl2efWhl3i
         pIAhsH2AWnyEwLTYmujSexcgV4wPY/rtEZpEDVNeYcsz1uwAGG2Cc5lC2ROg/Z9A00TD
         vFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n8VGGC+7+I4IjFN0ib/PUjyurgUsEjooklHf6RmDYUg=;
        b=H6byXM+d4Z1dt3EzKg5YGUlR4rON7e8g90u89O7kh5R3YaywRKw+4nwFQx2BvIvCjC
         wvpK+5OEygCU0TXRZ//bCxkb9x2WjWPETDynyLMaDh3UaSOcHiPCv4GJCM4eZOSK59yj
         bvRxW1acOVCvQpWo6TDs74Entx+tUFFnCPaFHmcfn4w9vBJaIPfjrmqheNGqSBCffrOX
         3bV0F9w94wMMMEcSb61FvQ79ZwDBd/w6L4iBtnWzlz4rKUEgE8Lie8dCXhCESWrp8WQT
         WSppQ66TDV6JB2c8y6lmgbNP1DwdWK5GMn0LKvnQCcSkrvkIJjaqbmXl/QXLyekM034f
         OLAQ==
X-Gm-Message-State: ACgBeo2zt3AHEvU2eNFikuAPVTQvycxIRK6VlOoEzbmZxEOerXWMfzzF
        LtrPHdM81v17VGIiYcAj3NXwIw==
X-Google-Smtp-Source: AA6agR4vo2geJ+bD2HdOnszq/5/BOl1SbzOVNQ+QLutzfKR1QkYQv+a7YFX6i+H7RE1zgYN8hG1jsA==
X-Received: by 2002:a05:6512:152a:b0:496:80f3:7fe0 with SMTP id bq42-20020a056512152a00b0049680f37fe0mr2823929lfb.579.1662648195222;
        Thu, 08 Sep 2022 07:43:15 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a6-20020a05651c010600b002688cceee44sm3221569ljb.132.2022.09.08.07.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:43:14 -0700 (PDT)
Message-ID: <71d970bc-fe6f-91e7-80c1-711af1af5530@linaro.org>
Date:   Thu, 8 Sep 2022 16:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] dt-bindings: net: snps,dwmac: Update interrupt-names
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
References: <20220907204924.2040384-1-bhupesh.sharma@linaro.org>
 <20220907204924.2040384-5-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907204924.2040384-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:49, Bhupesh Sharma wrote:
> As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
> interrupt error msg") noted, not every stmmac based platform
> makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.
> 
> So, update the 'interrupt-names' inside 'snps,dwmac' YAML
> bindings to reflect the same.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index f89ca308d55f..4d7fe4ee3d87 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -105,10 +105,12 @@ properties:
>  
>    interrupt-names:
>      minItems: 1
> -    items:
> -      - const: macirq
> -      - const: eth_wake_irq
> -      - const: eth_lpi
> +    maxItems: 3
> +    contains:
> +      enum:
> +        - macirq
> +        - eth_wake_irq
> +        - eth_lpi
>  

This gives quite a flexibility, e.g. missing macirq. Instead should be
probably a list with enums:
items:
  - const: macirq
  - enum: [eth_wake_irq, eth_lpi]
  - enum: [eth_wake_irq, eth_lpi]


Best regards,
Krzysztof
