Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358224F8116
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbiDGN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDGN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:58:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B31114DCF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:56:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso5719487wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=t5QhkfA9y7tJ3ykG1dO9EyBB58+Cc1c3AijbHVEEcOQ=;
        b=Y9CIiYhwRxRrjQLLG1vt1YSt/CNOatiRkDxb8EIhnWSivyaipiLU4JmlHsTtpoMzZ9
         mUcH0YQu43Ov0gm9k8ZxNbEk1Q/w23L4X+iVqEp89HzljTjDuUK1jEeNEMSaA7lvR5bU
         OD0CHpmH2QZZDPoVYCftq4bUtql15/j6FuRL+52wdAGoudbYkIhMk1Oh1QyJc/xLXhH4
         diqzMxSFl9nSyvCjREkwn6gxxG8BrG4Evm/O2cofUV6BwDmtmnLgzWFD3xYFMjlchR52
         vfDBzKwVgOIPkdy042ap/NSmYNOLB8nZSDgQEKflgeqCWSenXIa9JGfnyOmrCfFhSotR
         jHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=t5QhkfA9y7tJ3ykG1dO9EyBB58+Cc1c3AijbHVEEcOQ=;
        b=438FdtERYbi1OZJa4SkyumuyRqnFJW8Bl22h+9n4kxhetQqPYHliwJfVO8nQIMTXLb
         L4YX/qyI9imCOO9cYLeLO7rI7xOCnYMDEbNdc03kod7x7WvVndPLiYJ1FsUoRGkQcTmW
         c8zeZ8D0L+RToChaTY4UaOEiveYlljXMGATz8kuunXXiXs771E8rxjLrFgIzNrnZ79gf
         k+MDddAEYr1Up5eMJgQFbYxtCrRd5AdzORUkNqneDFvwMP1dhv8eD19aJG+1P9whVh2G
         t+eX1GFQsX78/yE8Mvd+kssnvfBmdljg9GlmqxTc58udLPZ+fmRNdaoMPnLxkm+xhoZ/
         9gMg==
X-Gm-Message-State: AOAM531HkDVUN8Oj+Y6QnpHMxlCbWuSKLg1g51wO6REKrScIlcf4w45q
        4iICwSDD+FDQzSBr4Z4rr9tPCQ==
X-Google-Smtp-Source: ABdhPJwW1VqNVXIlHo0NkxbWOQPtxC7d/cX4ne877T2cXoP9BUWryQMvDBPyojSUaaWP2zWhszx+8w==
X-Received: by 2002:a05:600c:4e51:b0:38e:6f91:d2c1 with SMTP id e17-20020a05600c4e5100b0038e6f91d2c1mr12489799wmq.128.1649339771183;
        Thu, 07 Apr 2022 06:56:11 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d64c8000000b0020784359295sm3639502wri.54.2022.04.07.06.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 06:56:10 -0700 (PDT)
Message-ID: <4d54fbbe-c2b0-877f-6fdf-449f2c1413f9@baylibre.com>
Date:   Thu, 7 Apr 2022 15:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] tty: serial: meson: Use DIV_ROUND_CLOSEST to
 calculate baud rates
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220407081355.13602-1-yu.tu@amlogic.com>
 <20220407081355.13602-2-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220407081355.13602-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 10:13, Yu Tu wrote:
> Due to chip process differences, chip designers recommend using baud
> rates as close to and larger as possible in order to reduce clock
> errors.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2bf1c57e0981..8e59624935af 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -299,10 +299,10 @@ static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   		cpu_relax();
>   
>   	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> +		val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
>   		val |= AML_UART_BAUD_XTAL;
>   	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> +		val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
>   	}
>   	val |= AML_UART_BAUD_USE;
>   	writel(val, port->membase + AML_UART_REG5);

I check the calculations, and with DIV_ROUND_CLOSEST(), result is always
closer to the required baudrate.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
