Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F44FB659
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiDKIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiDKIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:53:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968E25D4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so646978wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=m6Rr8Q+wNYGD2XdkMJAOXQ4QLeHTvBKuFe3IakxIc9o=;
        b=2gVvFevmuFI4scv9tPcT0ePc8WClLdpec0D+yRT76NvO+/jTUBuB7nKNKaEFf3CxdE
         CGbQ95TQ/n2nlj8YRwk4C9VCNtLpzQCq3aTdJX0v/dcXGrha8M6VKP9w6E7RQPdgpIsh
         kGNtFSEet6RuGe6lEIJDpOJJyElFcJyoUugHM6G2aASpuVUwHdE5CdhruhL/q76Mr3X+
         KcVlCtjv97fQvopOKNhnYs6MSyeQnfejmbQKu6rKu6ewpVbnMid8Iw7AOn1izrVfVUqe
         DjUK2fNVVlLU6tLTBGSYgeTxiIqQQfFCLaHGooEwdL9OBhA3zn9eqv1yBOJEt81WKSBp
         Crvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=m6Rr8Q+wNYGD2XdkMJAOXQ4QLeHTvBKuFe3IakxIc9o=;
        b=nqHAZ9/KEewaOmzwBYzhwjsqkliVvxUuBj19k5jRqafm21ZoY4CkUzzIfX9fFk5vzO
         h+lQvNG7+I7PLoP0ibmi3Y9ZgKSFtbcXnWWfjd1o0Vz9UOTbCKKTXQiZ3nJazDYKBxhU
         Yy6aRPKOO9ls51gV8L8AZG54Ra3csPxCn7LsfSaOnx2Kf0ufjC4FSOQTGKAD9qHSNTs4
         8OcirqQS/fNWNcRQrIM4Rg1y/nV2JlTi566aWcN2UdjJC/ixdFVZpDIUpz73lEkLlxfE
         7Vx/ziapE/uO2HhrUp/m+gRc+sQVa9ViCrrfSJCe6nn8luFuXtcKUxlm65BfnkPe4P/F
         Yj7g==
X-Gm-Message-State: AOAM532wMdCckCQXH+QxG/U87IPHbM92pk2Dlknxo0fc+pc+0X837QbE
        /1+T4UmJxw8z1unt8IQ0ZLJsCg==
X-Google-Smtp-Source: ABdhPJxWXrwR4K9SIIL0U56pGlKvwNYLYLRcg+MDZygJPCmSwC0yOOXBgd65Dx2bXtovwHAtjIDEig==
X-Received: by 2002:a05:600c:2306:b0:38e:bf1a:a669 with SMTP id 6-20020a05600c230600b0038ebf1aa669mr1381664wmo.11.1649667063694;
        Mon, 11 Apr 2022 01:51:03 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d1:e096:d183:1bc5? ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm27276509wre.34.2022.04.11.01.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:51:03 -0700 (PDT)
Message-ID: <d6ef87bd-8721-effd-8d26-13cd6d674cce@baylibre.com>
Date:   Mon, 11 Apr 2022 10:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin
 labeling for CON1
Content-Language: en-US
To:     Guillaume Giraudon <ggiraudon@prism19.com>, kernel-dev@prism19.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220410205624.14295-1-ggiraudon@prism19.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220410205624.14295-1-ggiraudon@prism19.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/04/2022 22:56, Guillaume Giraudon wrote:
> The labels for lines 61 through 84 on the periphs-banks were offset by 2.
> Realigned them to match the Banana Pi M5 schematics.
> 
> Signed-off-by: Guillaume Giraudon <ggiraudon@prism19.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 5751c48620ed..754c3d43ef0b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -448,7 +448,7 @@
>   		"",
>   		/* GPIOA */
>   		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
>   		"CON1-P27", /* GPIOA_14 */
>   		"CON1-P28", /* GPIOA_15 */
>   		/* GPIOX */

Can you repost with a Fixes tag ?

Thanks,
Neil
