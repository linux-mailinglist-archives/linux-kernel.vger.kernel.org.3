Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3053B60F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiFBJ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiFBJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:29:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596D13F71;
        Thu,  2 Jun 2022 02:29:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t13so5658871wrg.9;
        Thu, 02 Jun 2022 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=77Gpxnelo2/dzLY+errjgrjfiIA7jRfswZeq6VkrpC4=;
        b=S201HAOGhgwdYnrVEpOhkpqt+pH0TAM5mVos5XVgWFmyu9pt0r4/VwEybX8Oc07/Eh
         X5RJE4pTdgNWHCVGYO6xL+Imui5R3zJPTPu+VfZV/Vhj/K53F/Cw4WGKCNtCwhqxBcLv
         bQdSXTnNf3ADgxq9ADVSwnLynkcVdCehO7KsqfveQvoQDIIZdjdZtSvB22qr3FlbNK/k
         7rtpyYyldORov2TlUOuT0CZouw+VaKsVubp8AYPXwwVUj+krVM/BQsy0zsAAO2Jwkht7
         V6Kz2oODRSo4qluU9SdTiNll18vHH34ZcDKy/1EoQ/2ck14PBNOj+0VY6JYu8C0sHwnA
         uRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=77Gpxnelo2/dzLY+errjgrjfiIA7jRfswZeq6VkrpC4=;
        b=poWOu9VGKw0YaKVLCbyFUl8tOKjcAi0galCWfMFCRgVNQ8Mykfn+j0YPGfSkd1zxIc
         L/55XUFWKNkK9WPhj9+gmjuy8afpxJID67cIQK4A8F3IgJBVUT6nORGnAqUuDNxBcFOD
         xy8P/IKso8DPccXlBi4NuOzUK5ofPh78H5EpioM8bNA8LVlkI+cthAHnjmqAAeYt4j/j
         1/ejQLs7sf34y5dTbeKaq3XEmJTanh0tyCO0mSnAFgv2ILhZGakH7moY73qcJvGAeckC
         qTdF/hjHCJHVkDBesi8zrap11WTZmnXHqNJO0jGUDjI9wLO6GTENXwV5oeJgZpq7XcK5
         msGg==
X-Gm-Message-State: AOAM532o3hNHJj3unWIlL3mv9g1qmtcAxA8GwRKfT3OSkLB9MiC5tYIl
        zVwKjLcMncbqq6wfGB38/hc=
X-Google-Smtp-Source: ABdhPJxE4bp1e34dpAR0XXIxmkmYxmskLpltLRIHexUMOnKu5az1MV7atfofzSBm70J8E4WAtEJSOg==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr2904047wrz.690.1654162153418;
        Thu, 02 Jun 2022 02:29:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4fc1000000b0020fc4cd81f6sm3740571wrw.60.2022.06.02.02.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:29:12 -0700 (PDT)
Message-ID: <5dae58ca-487a-cbd8-00f8-9951a425f70e@gmail.com>
Date:   Thu, 2 Jun 2022 11:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] tty: serial: atmel: improve clock management
Content-Language: fr-FR
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        patrice.chotard@foss.st.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
 <20220525133733.1051714-3-claudiu.beznea@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220525133733.1051714-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 25/05/2022 à 15:37, Claudiu Beznea a écrit :
> atmel_port->clk was requested in atmel_init_port() (which is called only
> on probe path) only if atmel_port->clk was NULL. But atmel_port->clk is
> NULL on probing path. Thus don't check this. Along with this the clock is
> now requested with devm_clk_get() and the clock request has been moved in
> atmel_serial_probe() function to avoid disabling/re-enabling it on probe
> path for multiple times. All the checks of atmel_port->clk were removed
> along with clk_put() and atmel_port->clk = NULL. Now, on probing time the
> clock is enabled at the beginning and disabled at the end of probe. As
> atmel_console_setup() is called in the middle of probe and clock is
> already enabled at that time the clk_prepare_enable() in
> atmel_console_setup() has also been removed.
Could you split this patch into smaller steps ?
I think it will be easier to read and review.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   drivers/tty/serial/atmel_serial.c | 65 +++++++------------------------
>   1 file changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 5c793a23dc54..2955b1012014 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2501,24 +2501,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
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
> @@ -2640,10 +2623,6 @@ static int __init atmel_console_setup(struct console *co, char *options)
>   		return -ENODEV;
>   	}
>   
> -	ret = clk_prepare_enable(atmel_ports[co->index].clk);
> -	if (ret)
> -		return ret;
> -
Now, "int ret;" is unused, you can remove it.

>   	atmel_uart_writel(port, ATMEL_US_IDR, -1);
>   	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>   	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
> @@ -2889,14 +2868,23 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
> @@ -2905,7 +2893,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   				     sizeof(struct atmel_uart_char),
>   				     GFP_KERNEL);
>   		if (!data)
> -			goto err_alloc_ring;
> +			goto err_clk_disable_unprepare;
>   		atmel_port->rx_ring.buf = data;
>   	}
>   
> @@ -2915,26 +2903,9 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_add_port;
>   
> -#ifdef CONFIG_SERIAL_ATMEL_CONSOLE
> -	if (uart_console(&atmel_port->uart)
> -			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
> -		/*
> -		 * The serial core enabled the clock for us, so undo
> -		 * the clk_prepare_enable() in atmel_console_setup()
> -		 */
> -		clk_disable_unprepare(atmel_port->clk);
> -	}
> -#endif
> -
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
> @@ -2958,12 +2929,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
> @@ -2997,8 +2964,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
>   
>   	clear_bit(port->line, atmel_ports_in_use);
>   
> -	clk_put(atmel_port->clk);
> -	atmel_port->clk = NULL;
>   	pdev->dev.of_node = NULL;
>   
>   	return ret;
Thanks !

Regards,
Richard
