Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068A4D6E89
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiCLLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiCLLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:45:38 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A022C8F3;
        Sat, 12 Mar 2022 03:44:32 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id c25so11740618edj.13;
        Sat, 12 Mar 2022 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ATn9u/bdBEmlx4FdFy0VBiqJ1nbCom4LuXjsKICerUA=;
        b=DiDUxMv0bFKcVpIS9NbDdGOTh5Rk0rHKcZM7apX+9Ku5JQ+kn6X3h0u29sU6jRaBxK
         R4cHLr2xT9j4epq60MJnnWJRJkfBUy2gICOOU2Z3y5VIqBXguOvBrL1PWPx+9sbL/c7c
         CzUFZEpjMsEeDyzxiyHm8Zxd8DEmDT3keryIbsc47Zz8FkrahjI3f4BREPS7nz+8wLmi
         Zmo1oVKwDIvoWUd66H1qdk1qbrcLyygD8dOL6DYjHapICdcp2kQw+Aw3tQYVV8GFCFN3
         /e8YCRhR3ikKd+iOBUXGSLHpP4qTX+41QBk52C+b+fl5xmUsw4ZvKCbLpLUltpne84BC
         NNcw==
X-Gm-Message-State: AOAM531fEM0kb3fkkFkJKfZzrTuI9YLPIPrwIhbFOGfHRKio/vAs7V+w
        YGupnhu7b93ZuHzkK4YS8QM=
X-Google-Smtp-Source: ABdhPJw7ir2te4gEWeVn1V2WW+elPKC1t1vPcA4G7AOwRgTxpy9pskRkoNO/mkFmclGg067rKA0A9g==
X-Received: by 2002:a50:c35d:0:b0:416:278e:4299 with SMTP id q29-20020a50c35d000000b00416278e4299mr12818196edb.140.1647085471181;
        Sat, 12 Mar 2022 03:44:31 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id qx13-20020a170906fccd00b006bdeb94f50csm4151324ejb.203.2022.03.12.03.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 03:44:30 -0800 (PST)
Message-ID: <f21f4914-0d70-f176-717d-daefc0305d3a@kernel.org>
Date:   Sat, 12 Mar 2022 12:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] dt-bindings: gnss: Add two more chips
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220311235119.523374-1-linus.walleij@linaro.org>
 <20220311235119.523374-4-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220311235119.523374-4-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 00:51, Linus Walleij wrote:
> The CSR GSD4t is a CSR product using the SiRFstarIV core, and
> the CSR CSRG05TA03-ICJE-R is a CSR product using the SiRFstarV
> core.
> 
> These chips have a SRESETN line that can be pulled low to hard
> reset the chip and in some designs this is connected to a GPIO,
> so add this as an optional property.
> 
> Update the example with a reset line so users see that it need
> to be tagged as active low.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.yaml b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> index 91874241d0f3..e2ad1f01f9f3 100644
> --- a/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> +++ b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> @@ -25,6 +25,8 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - csr,gsd4t
> +      - csr,csrg05ta03-icje-r
>        - fastrax,uc430
>        - linx,r4
>        - wi2wi,w2sg0004
> @@ -39,6 +41,10 @@ properties:
>      description:
>        Main voltage regulator, pin names such as 3V3_IN, VCC, VDD.
>  
> +  reset-gpios:
> +    description: An optional active low reset line, should be flagged with
> +      GPIO_ACTIVE_LOW.
> +

maxItems

Best regards,
Krzysztof
