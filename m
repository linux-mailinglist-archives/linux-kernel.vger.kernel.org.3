Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836345A4A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiH2Lgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiH2Lek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:34:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8107E023;
        Mon, 29 Aug 2022 04:20:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s23so4083195wmj.4;
        Mon, 29 Aug 2022 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kxFHxw5tUjZxCZ2GBgc9GYMmh2Gtq2Cyp8o30geZz5o=;
        b=MA697DqQnMRrj6wgc66/A7msIAa4J9t7qWMk4UU6vZlGylRqlyl1K39To1Un5SrE1t
         gbzkXv25oTELyejHii9cCIhCpCpg5WI9Ml7I0E39Df4Uy4gOYwbNw7Gaqgbe+g1b6d10
         6VmVqpthoJpxDAnk7ELjKF0d4i25zbI8ZMrJvgb0N7uyUT9dMPpQnfbveBY0CUNQWX1j
         zbtfTeQvp7QlfZ3awSHBT4YWYklV0KSO2NYAu/YwJ5ZAg80nPdxUqZi+cMk2mUmeRiKk
         e4DS3+qEaz1BoJB/i5R3Ma7aTJl4cn/qw5UZ4M8VV3+vgOYaBwlhpZsjm6VPVQQ9r1wH
         doZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kxFHxw5tUjZxCZ2GBgc9GYMmh2Gtq2Cyp8o30geZz5o=;
        b=EBZMhJYVa4JS2+pAVNRfcW5kQInn0vHbBBigKSQafoMAcgMb5cvqCMcWUWPppRzgfE
         rPDLL/PJrPjMTAd3Opa0hw+cqSPjZ/NqtGjjP9bgnL8L3H2CWWIiCApXiPYyC/WivG22
         XwLViaiPmfxNPAIHNrjHkpUnQN+UKxElpFeHnaKthIazF3NkL7eBO5SWkqU5lYWcfOCZ
         /DSGr7Y5Ye+Msr2AazxJtOWrpyNNAx2uzV8TSC1Y2+zFfXFkc4txOVSpwotrn/LIVyi3
         RdhgwZayZl7cR2NmOHq8dhMQsXb8HE3lsvxembRka3H6H0rQ47kkHXyiNWwbAneirip1
         GO9g==
X-Gm-Message-State: ACgBeo2vxKL/Bn+tRKtBEhbHaeppVnKh0GIwctejxVS56lxz/Y8pOdlD
        2eE9evxQVz+ntNjZHHV5eiMGk+k5MVs=
X-Google-Smtp-Source: AA6agR4b6FUzmJBDIZ/3/4jEr5QLoLgJC9eT6kBwOwTgAV4f0sHGu25uZEhVI+lmiHK5yZIKCNDmWA==
X-Received: by 2002:a05:600c:4f92:b0:3a5:f545:a6ce with SMTP id n18-20020a05600c4f9200b003a5f545a6cemr6268545wmq.149.1661771225707;
        Mon, 29 Aug 2022 04:07:05 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b002237fd66585sm6710878wrt.92.2022.08.29.04.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:07:04 -0700 (PDT)
Message-ID: <778646cb-1b25-52d7-abd5-274757f40e93@gmail.com>
Date:   Mon, 29 Aug 2022 13:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/4] spi: mt7621: Fix an error message in
 mt7621_spi_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, gregkh@linuxfoundation.org, neil@brown.name,
        blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <928f3fb507d53ba0774df27cea0bbba4b055993b.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <928f3fb507d53ba0774df27cea0bbba4b055993b.1661599671.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2022 13:42, Christophe JAILLET wrote:
> 'status' is known to be 0 at this point. The expected error code is
> PTR_ERR(clk).
> 
> Switch to dev_err_probe() in order to display the expected error code (in a
> human readable way).
> This also filters -EPROBE_DEFER cases, should it happen.
> 
> Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/spi/spi-mt7621.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index b4b9b7309b5e..351b0ef52bbc 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -340,11 +340,9 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "unable to get SYS clock, err=%d\n",
> -			status);
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "unable to get SYS clock\n");
>   
>   	status = clk_prepare_enable(clk);
>   	if (status)
