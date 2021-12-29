Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351D48166C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhL2Tk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhL2Tkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:40:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A373C061574;
        Wed, 29 Dec 2021 11:40:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e5so46298547wrc.5;
        Wed, 29 Dec 2021 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hGRJ1HYHgx6Z5TD/JKBwqHCaslyKNZyupIsR2i8Poyw=;
        b=YCaq8M0RQ4k5mZfPFoejGPd+TZ2z34WbpOscTPjrml2fkckagkJz9v34SuLJc4qaa4
         yF/31YJvfaIYvysmBWjd0PxW1fL0YnqSCnmOyowAeiSr8wg4XN98O8UVDXbm9rr3kenx
         3DVduU8Kzc1FvSYVdf0xL17Oa6zmJ3LB2boxOTYHtMTKY5RMMNA/B9LZjk2NqCWPUhkc
         h97n+NPbD4pYZIoGPCKaTTHdiGa5ESzMF31bhHAtkwXhJV4LgLRo6IrDvz/J1zy/ibbc
         MQr8cq+RiIzfH8Z26qkpOCjx72xGGTARvSc00ULHXhV607yZW64/mzqAbOOW38IHUXGG
         7dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hGRJ1HYHgx6Z5TD/JKBwqHCaslyKNZyupIsR2i8Poyw=;
        b=FYnKWBk/yU7dnXAvRf2BxSFWtRsSneya/w9WkTppwkIYnVBzbmSYWlWTr81ULRVpU5
         w8dpr1ZN+KtI7gEhIB4GLnvlESyhNVxay/2l9t0hgcUPRH4ZvAhW7Ylj2oBQBweZC/0n
         XTYayx9M1RYoQGzWqPArAkCI0Yj4d+dAifY8mmgVaai6kQZ3Ye0rQiEN56ucJ9Weot7J
         sxV8e1WFwXNZRkru9iHJ2QMEysjozy5y55s5ecf8W7+l2O92tUzboE5SB2QQNUFQmsqe
         5UWJKCb4cSFeYGgcVoKN4C4Zd13+PeSyjUdM+fC7A/6zImQxTSfGd7PlslmUwo/lOoVb
         7RsA==
X-Gm-Message-State: AOAM532Y84z8XN/WXzGd//oOtPMV10P7ESnaleHKj3ZHDknkHPfZnDq7
        WuRTLVUh/w6LUoWiHPu6jfUEDEvFh02sPw==
X-Google-Smtp-Source: ABdhPJwXpLlka8AsE24wSg4a1QSRHYJhtq9ZoTOxBuTvDapaJJDktWT/iUH9gkB6MFV6VqhffpiFDQ==
X-Received: by 2002:a5d:58f2:: with SMTP id f18mr22004078wrd.98.1640806852049;
        Wed, 29 Dec 2021 11:40:52 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id b19sm26799443wmb.38.2021.12.29.11.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 11:40:50 -0800 (PST)
Message-ID: <c2b47f56-ff83-d36a-2c4f-6e1fee439c5b@gmail.com>
Date:   Wed, 29 Dec 2021 20:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 2/4] dt-bindings: spi: spi-mtk-nor: add new clock name
 'axi' for spi nor
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211220121825.6446-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 13:18, Tinghan Shen wrote:
> Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
> for spi nor dma bus clock.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml       | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index 7393f30535df..478afebfec9c 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -43,14 +43,19 @@ properties:
>       maxItems: 1
>   
>     clocks:
> +    minItems: 2
>       items:
>         - description: clock used for spi bus
>         - description: clock used for controller
> +      - description: clock used for nor dma bus. this depends on hardware
> +                     design, so this is optional.
>   
>     clock-names:
> +    minItems: 2
>       items:
>         - const: spi
>         - const: sf
> +      - const: axi
>   
>   required:
>     - compatible
> @@ -84,4 +89,3 @@ examples:
>           };
>         };
>       };
> -
> 
