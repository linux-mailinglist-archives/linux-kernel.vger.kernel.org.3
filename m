Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB954F81C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382055AbiFQNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382438AbiFQNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:06:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97336E30;
        Fri, 17 Jun 2022 06:06:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so5455229wrg.12;
        Fri, 17 Jun 2022 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2NdhKq319CMk9iQfR+Cv7bXlLg54sMlzF9l8guhOtiU=;
        b=PPYZ/PtJyHN9HSSukgXMGUtoFlrRIdnASuEzVuq6cLXLGtNvjINpV6uIdUMWQJ6yHC
         Vfdq3b1LB6AmjlpfZvMYcN8amm0T0j4xRRDZBnCkHUxfipH4Eq+pq9vOr1J0pqDomdKa
         PX0cUdUW+55FNlAYHsc8KKQEUVmNp+hTjl1JotzIK4Gu/N6+LP5K1b/JxOCIc4C9YS5r
         c7xHPVr4sE/fLT0URhKOnVSBfIlDWlMZd9BSUm+axIHY2DmDQro1YjNTVMXPq8yjBEY9
         rC9Mt3AhH2U22t69oSkL7B3gr6d/fbS7xWlWWxgIlWZGOittrSAE8dz9fQ+1zwKJuPnO
         vNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2NdhKq319CMk9iQfR+Cv7bXlLg54sMlzF9l8guhOtiU=;
        b=ny5RocHc3saTFoYXkll/PwkQOcpaQK+s8d2ZjF0H1fMVy/HKFnMjCR3mmuJpmF4DkB
         F8c4zIZEC0Uu2DqQKPtsVN6h5z0npVmwVi/H+vM8PIB17ndRweLcAMisGB7XZdFs+tgU
         exutTVjzaOao9niRplaxVitXl6+sfgmLf8knEVfcyaddC+6sLiJNgIFzjziGvFH2uSpg
         Dc5ptCaGdYbpHcJpP8CIgfVMC6ryX7vy0BWHpoEUW+G+Shof0k1HeQ/eI2QyE0+z8rSJ
         dgn7qiaLTlWiqyBNeAwN7VSTJ6T/r1Kku6yWbwoqqjNQYiC5P4J7UmF3GSAYdkVlVum1
         ng5w==
X-Gm-Message-State: AJIora+ws5ITygvD9zgV5AgkBszD8TEEcv2NApzB94xOr3Z2jgGrQKa9
        A9rPDL8ncqP1VBmHskiRPJo=
X-Google-Smtp-Source: AGRyM1sH3SUqJ7mGqosG6jZ2rrXJYCFfdsTxtmCcUl2qnSOz9cAwL67COV90mrxQBVpJRpNP15RyZQ==
X-Received: by 2002:a05:6000:18a8:b0:212:ae71:a3f6 with SMTP id b8-20020a05600018a800b00212ae71a3f6mr9125935wri.635.1655471207075;
        Fri, 17 Jun 2022 06:06:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b0039c84c05d88sm10647311wms.23.2022.06.17.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:06:46 -0700 (PDT)
Message-ID: <fec70c93-960d-711b-b6a1-ffc8ba23dfdb@gmail.com>
Date:   Fri, 17 Jun 2022 15:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/4] tty: serial: atmel: remove enable/disable clock
 due to atmel_console_setup()
Content-Language: fr-FR
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, patrice.chotard@foss.st.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
 <20220616140024.2081238-4-claudiu.beznea@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220616140024.2081238-4-claudiu.beznea@microchip.com>
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
> There is no need for clk_prepare_enable() at the beginning of
> atmel_console_setup() and clk_disable_unprepare() at the end of
> atmel_console_setup() as the clock is already enabled when calling
> atmel_console_setup() and its disablement is done at the end
> of probe.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 4cec97fd7241..3a94c2bdda72 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2617,7 +2617,6 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
>   
>   static int __init atmel_console_setup(struct console *co, char *options)
>   {
> -	int ret;
>   	struct uart_port *port = &atmel_ports[co->index].uart;
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>   	int baud = 115200;
> @@ -2630,10 +2629,6 @@ static int __init atmel_console_setup(struct console *co, char *options)
>   		return -ENODEV;
>   	}
>   
> -	ret = clk_prepare_enable(atmel_ports[co->index].clk);
> -	if (ret)
> -		return ret;
> -
>   	atmel_uart_writel(port, ATMEL_US_IDR, -1);
>   	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>   	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
> @@ -2914,17 +2909,6 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
Thanks !
