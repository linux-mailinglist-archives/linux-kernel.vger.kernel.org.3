Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F255710EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiGLDfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGLDfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:35:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B812E9D8;
        Mon, 11 Jul 2022 20:35:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d5so6128228plo.12;
        Mon, 11 Jul 2022 20:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=COCLTcAnXZhUm3+B6DMh6MuXVtRuMpnTsiy7xNXHm1Q=;
        b=QskUpTewMlnyYGePADw9eQnwv3xL4ilf0SIX7ws/zmvzSd8nkB7gXHzE+qt3RHFIj+
         oZFOpBV8h7JLT51P3P+P5WAXoVawjw9Ju2ks8QyctH5jNXQKqdGEnD5IAuZVK4uQmgXT
         EI9WZc5FLXjOBfFVf0S1zvu/Jd8FVH7BiRw4pezZE4dF401lxduO8Sg7+Z0b+1E2KLrF
         sYk8lC/6Sldrm1ufrGtLS5hydnneQu+F/y3afTabeCH71IFDeIQWPFzBzD/dQYXaf8QE
         Olgpp1yw/vwJJmIBa4jF+pfcovfUqyPfdfRQbWV4eL2beymVaVf9lDy9eWwosJVX5O1W
         rTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=COCLTcAnXZhUm3+B6DMh6MuXVtRuMpnTsiy7xNXHm1Q=;
        b=lqMlmY6PzQe75H0J01gJuRPS0QBr8LlCGM2jlIFEQ9AIzE1XCGqQGtCZKFV7hqJ61h
         wKYY94WkkEXDi2OoaaWCGxGYwR/YwSWgzbx9WroJCJ/nkcy+WZLx9CWLpiBZl4ziEfae
         SEzeg+k4rkpCk9wL9Vcw/kTAV/WahmHYLGDQ418y2tB/TELaE7kVVo5A50x5WzIwqkgh
         GtOrD3C1/5niVvRstVH/hmqpvitTD7OBlNg6WuqCQe6rMhTwjUbjukX5PSoeoz0WhZ6a
         1CHZ6kEnowru9TUJ4GeWuBG6mjAybaPYsp3uOHMgm52yWwV0cVN0fXgkZs7GzBsYkOnJ
         /96A==
X-Gm-Message-State: AJIora+wheoleed15dYOJa9AFdI55Ho7CSd17ropbPCgapO70nUi+2y/
        +mMqxBhYqqDaVFOcIGyuT0M=
X-Google-Smtp-Source: AGRyM1vZSLM+x+dzyj1doqgNfjKohPCMmTbQb8mmdv29i5LhorPhobhyrFKv3+5M9SIsLE/A1MJDqQ==
X-Received: by 2002:a17:902:e5c6:b0:16c:413c:fbff with SMTP id u6-20020a170902e5c600b0016c413cfbffmr10204824plf.62.1657596933705;
        Mon, 11 Jul 2022 20:35:33 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d78-20020a621d51000000b00528c149fe97sm5500478pfd.89.2022.07.11.20.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 20:35:32 -0700 (PDT)
Message-ID: <ba372c31-f8b8-7987-5f7b-bb7c01b8233f@gmail.com>
Date:   Mon, 11 Jul 2022 20:35:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH -next] drivers/tty/serial: Add missing
 clk_disable_unprepare()
Content-Language: en-US
To:     Guo Mengqi <guomengqi3@huawei.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        nsaenz@kernel.org, athierry@redhat.com,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     xuqiang36@huawei.com
References: <20220617025827.130497-1-guomengqi3@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220617025827.130497-1-guomengqi3@huawei.com>
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



On 6/16/2022 7:58 PM, 'Guo Mengqi' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> Add missing clk_disable_unprepare() when get clk rate fails.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>

Looks about right, can we use the same prefix as the majority of other 
changes:

serial: 8250_bcm2835aux: Add missing clk_disable_unprepare()

and slap a:

Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")

Thanks!

> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 2a1226a78a0c..21939bb44613 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -166,8 +166,10 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   	uartclk = clk_get_rate(data->clk);
>   	if (!uartclk) {
>   		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
> -		if (ret)
> -			return dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
> +			goto dis_clk;
> +		}
>   	}
>   
>   	/* the HW-clock divider for bcm2835aux is 8,

-- 
Florian
