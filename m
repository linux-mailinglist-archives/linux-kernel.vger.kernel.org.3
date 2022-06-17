Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272A54F81B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382180AbiFQNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381864AbiFQNG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:06:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDAC2F3A5;
        Fri, 17 Jun 2022 06:06:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso2377784wml.1;
        Fri, 17 Jun 2022 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fBiOOlXN9f2O3t3pJNvdkfRbIOUEiHlHy6KD+EuBo00=;
        b=Ija0KNl4EJSrqreDjTMW00X012U4mWOX5qtd8QHmSXXm3/hhvi/zx2JdkLxFo5kxEF
         zrWkU1N2jLYqOJoEj+Y++zgz1hWlxF1Bann0RwcF1gQoYnbg20xRoKYv9BU8GyDSp2u2
         Gs3SxTj/VM5rg5Ziur4T/RMbsFYXhxXBq25aHtFDPEPb809YgqLp4odYfwAGa6oM4cps
         8wDz0kDFxWDCfrWq4s9Ft2jalslmxESohbNjY1kxmAlIGCgFaanGA5R1ltLcTH738eUF
         i2QCpzik2OGWmY9R6YQfcVXXKItoi61lRcavouhSah0fU+vIpdFVa0B0BK2w9aZj2cqd
         U5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fBiOOlXN9f2O3t3pJNvdkfRbIOUEiHlHy6KD+EuBo00=;
        b=Gb/wmaid9XyisitGrEx4t5HSvDhv+t9GWb/ABCwBdYT5XuEm/s0KZ44MLYouXsp87l
         SOYv6QDXqLdOEAZ/81HC4aiUyEtXrIiO54IeT2Uf3mhvBxzp7VMshCc6ga7pbHWJqEt0
         bCwtUw9j9p/PeNxDli7XuMmhasSAZi+buCkghBpSoDAgMdhJH/XahACjmk5jelnBVrr6
         +N/wH4eEVS061aOzyQmIyEw/YvNrFDtzT8a9oAJuUsaDi+ZzPB5fS+4BYpyduzpEahJF
         DFy7y8qhYHdauKhWGjv/x+AaFs9x1Qu4+ApARgxwgq9cXjEmYv7AixD58ZMKkStcEPP6
         LE5w==
X-Gm-Message-State: AOAM531lKd4KnZBlXYScwpZ6D753jK0ipNJdykKCquuZdeOtp+G2gNiI
        xeFpBhMln3XakLBckpNnpoM=
X-Google-Smtp-Source: ABdhPJwyN2sM2Hp3mRovXTnBEjkabCl7IJwjwOHbzRt5XpQxD0DVMvp8JrJChbHwkyzdm1Pj9QMC3Q==
X-Received: by 2002:a05:600c:3d8d:b0:39c:5232:107a with SMTP id bi13-20020a05600c3d8d00b0039c5232107amr20899367wmb.191.1655471185817;
        Fri, 17 Jun 2022 06:06:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0021b8213fa3bsm865455wrt.19.2022.06.17.06.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:06:24 -0700 (PDT)
Message-ID: <b08857ab-ce3d-d597-b229-1a61b849118d@gmail.com>
Date:   Fri, 17 Jun 2022 15:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/4] tty: serial: atmel: use devm_clk_get()
Content-Language: fr-FR
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, patrice.chotard@foss.st.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
 <20220616140024.2081238-3-claudiu.beznea@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220616140024.2081238-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/06/2022 à 16:00, Claudiu Beznea a écrit :
> Use devm_clk_get() for serial clock instead of clk_get()/clk_put().
> With this move the clk_get in driver's probe function.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 50 ++++++++++---------------------
>   1 file changed, 15 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c618d7e93058..4cec97fd7241 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2508,24 +2508,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>   	if (ret)
>   		return ret;
>   
> -	/* for console, the clock could already be configured */
> -	if (!atmel_port->clk) {
> -		atmel_port->clk = clk_get(&mpdev->dev, "usart");
> -		if (IS_ERR(atmel_port->clk)) {
> -			ret = PTR_ERR(atmel_port->clk);
> -			atmel_port->clk = NULL;
> -			return ret;
> -		}
> -		ret = clk_prepare_enable(atmel_port->clk);
> -		if (ret) {
> -			clk_put(atmel_port->clk);
> -			atmel_port->clk = NULL;
> -			return ret;
> -		}
> -		port->uartclk = clk_get_rate(atmel_port->clk);
> -		clk_disable_unprepare(atmel_port->clk);
> -		/* only enable clock when USART is in use */
> -	}
> +	port->uartclk = clk_get_rate(atmel_port->clk);
>   
>   	/*
>   	 * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
> @@ -2896,14 +2879,23 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   	atomic_set(&atmel_port->tasklet_shutdown, 0);
>   	spin_lock_init(&atmel_port->lock_suspended);
>   
> +	atmel_port->clk = devm_clk_get(&pdev->dev, "usart");
> +	if (IS_ERR(atmel_port->clk)) {
> +		ret = PTR_ERR(atmel_port->clk);
> +		goto err;
> +	}
> +	ret = clk_prepare_enable(atmel_port->clk);
> +	if (ret)
> +		goto err;
> +
>   	ret = atmel_init_port(atmel_port, pdev);
>   	if (ret)
> -		goto err_clear_bit;
> +		goto err_clk_disable_unprepare;
>   
>   	atmel_port->gpios = mctrl_gpio_init(&atmel_port->uart, 0);
>   	if (IS_ERR(atmel_port->gpios)) {
>   		ret = PTR_ERR(atmel_port->gpios);
> -		goto err_clear_bit;
> +		goto err_clk_disable_unprepare;
>   	}
>   
>   	if (!atmel_use_pdc_rx(&atmel_port->uart)) {
> @@ -2912,7 +2904,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   				     sizeof(struct atmel_uart_char),
>   				     GFP_KERNEL);
>   		if (!data)
> -			goto err_alloc_ring;
> +			goto err_clk_disable_unprepare;
>   		atmel_port->rx_ring.buf = data;
>   	}
>   
> @@ -2936,12 +2928,6 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   	device_init_wakeup(&pdev->dev, 1);
>   	platform_set_drvdata(pdev, atmel_port);
>   
> -	/*
> -	 * The peripheral clock has been disabled by atmel_init_port():
> -	 * enable it before accessing I/O registers
> -	 */
> -	clk_prepare_enable(atmel_port->clk);
> -
>   	if (rs485_enabled) {
>   		atmel_uart_writel(&atmel_port->uart, ATMEL_US_MR,
>   				  ATMEL_US_USMODE_NORMAL);
> @@ -2965,12 +2951,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   err_add_port:
>   	kfree(atmel_port->rx_ring.buf);
>   	atmel_port->rx_ring.buf = NULL;
> -err_alloc_ring:
> -	if (!uart_console(&atmel_port->uart)) {
> -		clk_put(atmel_port->clk);
> -		atmel_port->clk = NULL;
> -	}
> -err_clear_bit:
> +err_clk_disable_unprepare:
> +	clk_disable_unprepare(atmel_port->clk);
>   	clear_bit(atmel_port->uart.line, atmel_ports_in_use);
>   err:
>   	return ret;
> @@ -3004,8 +2986,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
>   
>   	clear_bit(port->line, atmel_ports_in_use);
>   
> -	clk_put(atmel_port->clk);
> -	atmel_port->clk = NULL;
>   	pdev->dev.of_node = NULL;
>   
>   	return ret;

Thanks !
