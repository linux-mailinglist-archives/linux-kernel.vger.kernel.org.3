Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883AF50E7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbiDYSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiDYSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:03:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483002B275
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:00:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so31158598ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uLQr2x32akaYMf3E5hvQ+Jlniyq/FFxA4TjjQ4jUZOI=;
        b=PrCmRUGNO9zz2jb5NrEZNZ5sbY3qlWnI11McDz5JaYhy3cLmcUyoM0hBXp+Q64VOSS
         wjO1im9Jr/iZ948dU9nlzT4esy+8eE2uTROfucvuLtQh+DGf0Xt+ghAkyMUE0UhPbHne
         dJ9RxVudU4wFftK7SF7ZjoSHbVTNTcu3xpWzPQDNzipA0UYRhSfYLSjxkceVNu5Ar+aH
         561SjQpSCCrBUZFcaDLfYcCKyj++1kurUzjS+cEPB1+mk9hKYWuVzKk0fPlWwl7Q0YxG
         7OGw9ZwRHgVj5coRyB9wSOCA82MUvXYSThO8yBJC3v/Eq1m7Ku5LwAHpTUlZoN+Rmw5g
         /ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uLQr2x32akaYMf3E5hvQ+Jlniyq/FFxA4TjjQ4jUZOI=;
        b=so9aM/fJ2xlkDx0EyoOtLlcf3c9RI3SfuUslvEHh3Lgy6SyfyyGRJYVELRwoR6H+FN
         oeR8Fmh9e5Opg0eFyzIkOUGoWAClrBw8m4jTxBbQKEz74Ny+Kv6RPCacLXaOaqSKWVBT
         4meoKv2x/eJwKPY5hajjzZ+Q+Dv+nq8rklb2ik+ODEnKa1fOPbgwn7oE29OiWqkiImrV
         hIsFnLEIO1tRLaOKbrI6Ar58Eh2VIv0dH/GgsQqCGfOo/ERtO0Lxk5dbrkYTCqT9LEK9
         U4gcUMQgRYtkCwTUoKGCeBPbdDGxATIp9Y0Y8qLpZ8QeGEAaLYNfhDXEpLxV/6fuXfbg
         3/Sg==
X-Gm-Message-State: AOAM533LUBGe5t5NepGqsY/6XfEQsPmh+xF4Fnkb1FDV1igvNxJbMAFK
        kEJQYJUsXJBrHtPZY3W+r1Xrnw==
X-Google-Smtp-Source: ABdhPJyF5Bg4ezvxWrfynHW89qeddZNlKUwZzbBS7vOHrvONxZoFPTKlbsi2IiYzpSUOZ+XpHT+7Qg==
X-Received: by 2002:a17:907:3f13:b0:6f3:ad46:be1f with SMTP id hq19-20020a1709073f1300b006f3ad46be1fmr75899ejc.627.1650909648858;
        Mon, 25 Apr 2022 11:00:48 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906378500b006efb4ab6f59sm3848153ejc.86.2022.04.25.11.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:00:48 -0700 (PDT)
Message-ID: <60db784a-df7c-af2c-5602-bab8462b0223@linaro.org>
Date:   Mon, 25 Apr 2022 20:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64
 Model B
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
 <20220425171344.1924057-2-pgwipeout@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425171344.1924057-2-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 19:13, Peter Geis wrote:
> The Quartz64 Model B is a compact single board computer from Pine64
> based on the rk3566 SoC. It outputs on uart2 for the debug console.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index eece92f83a2d..d6650a366753 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -507,6 +507,11 @@ properties:
>            - const: pine64,quartz64-a
>            - const: rockchip,rk3566
>  
> +      - description: Pine64 Quartz64 Model B
> +        items:
> +          - const: pine64,quartz64-b

Since it is a single board, not a SoM, this should be rather part of
enum of Model A block.

See also Radxa ROCK Pi entry.

Keeping such approach - each single board in one item of oneOf - makes
the file very, very long...

Best regards,
Krzysztof
