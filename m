Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911EC55F5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiF2F5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiF2F5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:57:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06317584
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:57:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fi2so30302666ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1WfdVfNcXkp3OxFuJuEQhMM39v5eC68bY2ADm6rLKI0=;
        b=JkUoMSVHOd8FXIU1nP7mHg39NA+HAkmXOBLZHIkIRWjuF2QXpez6vuJMIWGUWFHEby
         5o4bGCiXixkuKlUlu2olkq0QLN2UOIntPX6lG3+7PbXV+avqVfJ253cahNkw20GGXPeA
         MHvSKO3EVsTxg+HQtXEwBaZzsvry24d4BvkcEdAr5jVs9aGqW6Xuvyy663JNPBbkngxL
         ek6xf1/RqwKb2cDwtZy8lrOxsp43tHw2dRO21IpABqGEytjhcHxUraOi/YMWnoRgDrmq
         fIbCX7sv+Ga3+sPyzf/OYbX6uTY+nt3ooO/FRKAj9IUFTzcd83VY9OMyTF/rzwkUp2rw
         iYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1WfdVfNcXkp3OxFuJuEQhMM39v5eC68bY2ADm6rLKI0=;
        b=zPHv27uopo+JusJNSko3UutXFTf9m1B79XUVnBtNCZ2G6IzXrLKIbvaQqEWeM4HFF6
         H9qZQ0Fv6HYxHynVnPVORGGcok2lKHP2xy7UPydtyf1O6haiwgEGozgfsMj09uJ3acFI
         4ofM9ck0BEl6SK0JEJxXEO5j/Rnn6JefVbRPESqNgozIQHHjx7sZuhWmPMzDJ1kzsNvw
         GyaClk/hvWZx/WJzzDXUC4hD7iD4JHnPGeLKv66JUuGfidkMsJ2lcHO2oPfXUG9f14AV
         lIYUO3dPRlLgcPsZDbXVGNa1UPisp1rmDNBwGfdkYG6MtnUEeN3GYuyxO5WEz93yC//o
         VeBg==
X-Gm-Message-State: AJIora88KYF+XimP9u20c6ruZvdY6lHpt3c0ol7TDMiag89GdaxSRhJJ
        8iigblCImrtu67m8Bf4f+Qc5EQ==
X-Google-Smtp-Source: AGRyM1tKY3/ufkVIb0NqXcBrOPVDKBLhqSVvGuyqn+dsBxeoxntoXm1sQv41p5v8Kn71T36sBhLAmA==
X-Received: by 2002:a17:907:7213:b0:726:9f27:8fc8 with SMTP id dr19-20020a170907721300b007269f278fc8mr1551543ejc.523.1656482262769;
        Tue, 28 Jun 2022 22:57:42 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b00435d4179bbdsm10892308edv.4.2022.06.28.22.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 22:57:42 -0700 (PDT)
Message-ID: <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
Date:   Wed, 29 Jun 2022 07:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629032008.1579899-3-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 05:20, Neal Liu wrote:
> Add HACE reset bit definition for AST2500/AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/dt-bindings/clock/aspeed-clock.h  | 3 ++-
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index 9ff4f6e4558c..6e040f7c3426 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -46,11 +46,12 @@
>  #define ASPEED_RESET_MCTP		1
>  #define ASPEED_RESET_ADC		2
>  #define ASPEED_RESET_JTAG_MASTER	3
> -#define ASPEED_RESET_MIC		4
> +#define ASPEED_RESET_HACE		4

I did not ack such change. This is a significant change from previous
version, invalidating my previous ack.

This breaks the ABI, so NAK without proper explanation why ABI break is
accepted.

>  #define ASPEED_RESET_PWM		5
>  #define ASPEED_RESET_PECI		6
>  #define ASPEED_RESET_I2C		7
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
> +#define ASPEED_RESET_MIC		18
>  
>  #endif
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 62b9520a00fd..d8b0db2f7a7d 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -111,6 +111,7 @@
>  #define ASPEED_RESET_PCIE_RC_O		19
>  #define ASPEED_RESET_PCIE_RC_OEN	18
>  #define ASPEED_RESET_PCI_DP		5
> +#define ASPEED_RESET_HACE		4
>  #define ASPEED_RESET_AHB		1
>  #define ASPEED_RESET_SDRAM		0
>  


Best regards,
Krzysztof
