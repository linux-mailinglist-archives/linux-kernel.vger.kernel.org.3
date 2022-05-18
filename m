Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37C52B34C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiERHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiERHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:12:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC009E0F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:12:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f4so1965868lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Lfj5OmdOY55KHgcwKvO3b5AfZ3EYYjLorTp93VLd7p8=;
        b=jcj5HiuvL8X+P6hCwA9QfLbXNAcANZ96gfAhSR+AhceTo+Mvuigsa/pzHdQFlqIdGe
         5mN2JufMO+gg8CJ8N3uMzVWk8R26kbYb4kLcPIZl6uoi/L5QyeXur+cqYBQA2rUZu6oT
         hkphMcpE0dxOSjy6pMwjlNekFUqB1wDJz1hq/k/RlTBK9wafKXxqCa39oAATTVVtMsJW
         dtla7KaPB0W8fftcPVcYdgqCI3K9vbErIwe+4Hp2WNNPbKDhxdATx8GFhRinV5AzHoka
         ob3Z9XYAFQz/jHovET9R6zP5E+NmZVKW7HGx4OXFuA9GN+2zM9kOrZmSsafqrxUU4xUs
         PdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lfj5OmdOY55KHgcwKvO3b5AfZ3EYYjLorTp93VLd7p8=;
        b=cBxRazSM4WxzXLvoN8nnYZJewwvz73byAsMM8SUEFIS4sTbwUKwpgTwxJLMloB2j9y
         pxUNFuQhhuraB12w7dpRsz8VVYRNEfUFCMxmh6xWMnC5nzVl9K7wrLW0Oo2eD+V9r7CB
         jb7mjoxo7AthNcyCKZDTc9HDIzF43tH/R/69OgHmNnQZwglYe6vrZdwttqCIH6rRkWda
         UN3n7P2pYQWvkkm32cUXxtl8II7HBL6G/Cb5zTLhl+3i3vc2LSBIyIMKdaFQoN4nRXV0
         9r/h+8Y9LNCWKPuEc/OR9oQoU6Hi1/jTboRAyKJq6AlKMlxMydFRFskhHL6IpDTO8ciw
         +nHg==
X-Gm-Message-State: AOAM530SV6fDpy7QwEH213xRCEh0KNkemEnbzYotfzikvhOWEXZV6zIG
        egq5RI8++rMLUX01MwL9pxB1Bg==
X-Google-Smtp-Source: ABdhPJxD+zNWMqHTLYyHj0yaHaelXapgrsiCCT2XBorrDJgmEDzlkh+h38uDJAAoAERZQWA84ePKEg==
X-Received: by 2002:a05:6512:3e1b:b0:472:5f64:e1d9 with SMTP id i27-20020a0565123e1b00b004725f64e1d9mr19001904lfv.489.1652857927034;
        Wed, 18 May 2022 00:12:07 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004779f2ce1e7sm121483lfk.53.2022.05.18.00.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:12:06 -0700 (PDT)
Message-ID: <c7c49632-b4b6-6252-76b5-d3aa45b08339@linaro.org>
Date:   Wed, 18 May 2022 09:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] dmaengine: ep93xx_dma: Remove unneeded ERROR check
 before clk_put
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-2-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516084139.8864-2-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 10:41, Wan Jiabing wrote:
> clk_put() already uses !clk and IS_ERR(clk) to check ERROR or NULL.
> Remove unneeded ERROR or NULL check for edmac->clk.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/dma/ep93xx_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 971ff5f9ae84..60dc7b3f3d0d 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -1398,8 +1398,7 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
>  	if (unlikely(ret)) {
>  		for (i = 0; i < edma->num_channels; i++) {
>  			struct ep93xx_dma_chan *edmac = &edma->channels[i];
> -			if (!IS_ERR_OR_NULL(edmac->clk))
> -				clk_put(edmac->clk);
> +			clk_put(edmac->clk);

clk_put() which calls __clk_put() seems to print warning on IS_ERR, so
this does not look equivalent code.


Best regards,
Krzysztof
