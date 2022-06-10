Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE76546784
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbiFJNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347988AbiFJNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:43:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9053B017;
        Fri, 10 Jun 2022 06:43:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c21so3490260wrb.1;
        Fri, 10 Jun 2022 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MUhIkPArPHIPy06gz4cSE3aTOOxY2nSP5WV+XoCfzRk=;
        b=gfEantf23UcbfjS8pXanrdVio9fVjQjgt2UwdfPJxIu8MnoMYfTfDEx2DaaKfE//wp
         eMI/uB72kj0DwmR527jsT2ngw1guB6kcJ0KAXW+9z1P0HLo0LyEVQIT7NJwpf9FTqGDI
         CUfeLlawkfomFRlCGp03nHLu+g31TiSeZvDoh2trJNtU/Bn371/PjHgwG6eG8n1ctDxB
         w6aKoLPIgZQCIy0iDGvbYzDUGTWhpisZXZy9RG0Gts/AQ2YMN19hPptomhtZE1tofr8k
         NjzsXOqQSRBuLZlXE8oqlkwo8mQh71BSu/Tq4gYi+XKNaHx66Y3MNSPJ1MMvs0vZgukU
         BI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MUhIkPArPHIPy06gz4cSE3aTOOxY2nSP5WV+XoCfzRk=;
        b=1AgN/VPtSaCPhVt3yp/HxUns+4oc1A5Gmoklbn/x9+jag3/zNyE1IY2N6ibPG33JPf
         90OyA+JFh5lz4sCe8vWrQ9pbQfqPzZTzHBYzzX6ZkvArj4CmaneV6Eu7ae5B9jb/iGKC
         ZMhHDrwB3g7wCd33n3OcDokJeXeJJ72qso4RC6n7bMZKRmEStF/Z7AGrhCTSrtSsUhJ8
         7iDjs84RnM08W42g3HZJzggqkQTy5GiF+Qx4bQLQOFpZmAF+Y+X/9tM3X+YQz2jF1NQS
         oqGTiXJAUuPwDFd18fHs6XdOCwBh0+0CpAmHsiRnzi9qin6+8JtBgw+VbcSf+9qA6g/c
         sowQ==
X-Gm-Message-State: AOAM531m6JDS3jNgvTtJNHbnbP19Nu4rjODL8oHViY2fA89QjiqrwC+j
        5QQdns8iVVWEF5NiGwqfB6w=
X-Google-Smtp-Source: ABdhPJx4aZn9694mJK4XN6HyC801doDfIPOi9jbg69UBn5J6e6C9uw4xjG7rsstJPoeOdA7qMBTgvw==
X-Received: by 2002:adf:e488:0:b0:20f:d981:4b42 with SMTP id i8-20020adfe488000000b0020fd9814b42mr44429368wrm.455.1654868596987;
        Fri, 10 Jun 2022 06:43:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d6a8d000000b0020c5253d8f7sm27652541wru.67.2022.06.10.06.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 06:43:16 -0700 (PDT)
Message-ID: <a46eec81-aa2c-74c0-210d-4d28ba46e815@gmail.com>
Date:   Fri, 10 Jun 2022 15:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] tty: serial: atmel: improve clock management
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, patrice.chotard@foss.st.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
 <20220525133733.1051714-3-claudiu.beznea@microchip.com>
 <5dae58ca-487a-cbd8-00f8-9951a425f70e@gmail.com>
 <4a189186-9871-09ab-d7e1-9346f7af0bfe@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <4a189186-9871-09ab-d7e1-9346f7af0bfe@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Le 08/06/2022 à 10:18, Claudiu.Beznea@microchip.com a écrit :
> Hi,
> 
> On 02.06.2022 12:29, Richard Genoud wrote:
>>
>> Hi,
>>
>> Le 25/05/2022 à 15:37, Claudiu Beznea a écrit :
>>> atmel_port->clk was requested in atmel_init_port() (which is called only
>>> on probe path) only if atmel_port->clk was NULL. But atmel_port->clk is
>>> NULL on probing path. Thus don't check this. Along with this the clock is
>>> now requested with devm_clk_get() and the clock request has been moved in
>>> atmel_serial_probe() function to avoid disabling/re-enabling it on probe
>>> path for multiple times. All the checks of atmel_port->clk were removed
>>> along with clk_put() and atmel_port->clk = NULL. Now, on probing time the
>>> clock is enabled at the beginning and disabled at the end of probe. As
>>> atmel_console_setup() is called in the middle of probe and clock is
>>> already enabled at that time the clk_prepare_enable() in
>>> atmel_console_setup() has also been removed.
>> Could you split this patch into smaller steps ?
>> I think it will be easier to read and review.
> 
> I kept it as a single patch as it is all related to clock management.
> 
> Having the clock enabled only at the beginning of probe and disabled at the
> end of probe lead to removing the code in atmel_init_port(), also removing
> the code under CONFIG_SERIAL_ATMEL_CONSOLE in probe. Same for the rest of
> the removed code.
> 
> With this, would you still want to split it in multiple patches?

I think that, at least, the switch from clk_get() to devm_clk_get() can 
be in a separate patch.
But in general, I prefer when patches are self-explaining rather than a 
bigger patch with a longer explanation of what it does in the commit 
message.

Regards,
Richard

> 
> Thank you,
> Claudiu Beznea
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>    drivers/tty/serial/atmel_serial.c | 65 +++++++------------------------
>>>    1 file changed, 15 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/atmel_serial.c
>>> b/drivers/tty/serial/atmel_serial.c
>>> index 5c793a23dc54..2955b1012014 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -2501,24 +2501,7 @@ static int atmel_init_port(struct atmel_uart_port
>>> *atmel_port,
>>>        if (ret)
>>>                return ret;
>>>
>>> -     /* for console, the clock could already be configured */
>>> -     if (!atmel_port->clk) {
>>> -             atmel_port->clk = clk_get(&mpdev->dev, "usart");
>>> -             if (IS_ERR(atmel_port->clk)) {
>>> -                     ret = PTR_ERR(atmel_port->clk);
>>> -                     atmel_port->clk = NULL;
>>> -                     return ret;
>>> -             }
>>> -             ret = clk_prepare_enable(atmel_port->clk);
>>> -             if (ret) {
>>> -                     clk_put(atmel_port->clk);
>>> -                     atmel_port->clk = NULL;
>>> -                     return ret;
>>> -             }
>>> -             port->uartclk = clk_get_rate(atmel_port->clk);
>>> -             clk_disable_unprepare(atmel_port->clk);
>>> -             /* only enable clock when USART is in use */
>>> -     }
>>> +     port->uartclk = clk_get_rate(atmel_port->clk);
>>>
>>>        /*
>>>         * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
>>> @@ -2640,10 +2623,6 @@ static int __init atmel_console_setup(struct
>>> console *co, char *options)
>>>                return -ENODEV;
>>>        }
>>>
>>> -     ret = clk_prepare_enable(atmel_ports[co->index].clk);
>>> -     if (ret)
>>> -             return ret;
>>> -
>> Now, "int ret;" is unused, you can remove it.
>>
>>>        atmel_uart_writel(port, ATMEL_US_IDR, -1);
>>>        atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA |
>>> ATMEL_US_RSTRX);
>>>        atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
>>> @@ -2889,14 +2868,23 @@ static int atmel_serial_probe(struct
>>> platform_device *pdev)
>>>        atomic_set(&atmel_port->tasklet_shutdown, 0);
>>>        spin_lock_init(&atmel_port->lock_suspended);
>>>
>>> +     atmel_port->clk = devm_clk_get(&pdev->dev, "usart");
>>> +     if (IS_ERR(atmel_port->clk)) {
>>> +             ret = PTR_ERR(atmel_port->clk);
>>> +             goto err;
>>> +     }
>>> +     ret = clk_prepare_enable(atmel_port->clk);
>>> +     if (ret)
>>> +             goto err;
>>> +
>>>        ret = atmel_init_port(atmel_port, pdev);
>>>        if (ret)
>>> -             goto err_clear_bit;
>>> +             goto err_clk_disable_unprepare;
>>>
>>>        atmel_port->gpios = mctrl_gpio_init(&atmel_port->uart, 0);
>>>        if (IS_ERR(atmel_port->gpios)) {
>>>                ret = PTR_ERR(atmel_port->gpios);
>>> -             goto err_clear_bit;
>>> +             goto err_clk_disable_unprepare;
>>>        }
>>>
>>>        if (!atmel_use_pdc_rx(&atmel_port->uart)) {
>>> @@ -2905,7 +2893,7 @@ static int atmel_serial_probe(struct
>>> platform_device *pdev)
>>>                                     sizeof(struct atmel_uart_char),
>>>                                     GFP_KERNEL);
>>>                if (!data)
>>> -                     goto err_alloc_ring;
>>> +                     goto err_clk_disable_unprepare;
>>>                atmel_port->rx_ring.buf = data;
>>>        }
>>>
>>> @@ -2915,26 +2903,9 @@ static int atmel_serial_probe(struct
>>> platform_device *pdev)
>>>        if (ret)
>>>                goto err_add_port;
>>>
>>> -#ifdef CONFIG_SERIAL_ATMEL_CONSOLE
>>> -     if (uart_console(&atmel_port->uart)
>>> -                     && ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
>>> -             /*
>>> -              * The serial core enabled the clock for us, so undo
>>> -              * the clk_prepare_enable() in atmel_console_setup()
>>> -              */
>>> -             clk_disable_unprepare(atmel_port->clk);
>>> -     }
>>> -#endif
>>> -
>>>        device_init_wakeup(&pdev->dev, 1);
>>>        platform_set_drvdata(pdev, atmel_port);
>>>
>>> -     /*
>>> -      * The peripheral clock has been disabled by atmel_init_port():
>>> -      * enable it before accessing I/O registers
>>> -      */
>>> -     clk_prepare_enable(atmel_port->clk);
>>> -
>>>        if (rs485_enabled) {
>>>                atmel_uart_writel(&atmel_port->uart, ATMEL_US_MR,
>>>                                  ATMEL_US_USMODE_NORMAL);
>>> @@ -2958,12 +2929,8 @@ static int atmel_serial_probe(struct
>>> platform_device *pdev)
>>>    err_add_port:
>>>        kfree(atmel_port->rx_ring.buf);
>>>        atmel_port->rx_ring.buf = NULL;
>>> -err_alloc_ring:
>>> -     if (!uart_console(&atmel_port->uart)) {
>>> -             clk_put(atmel_port->clk);
>>> -             atmel_port->clk = NULL;
>>> -     }
>>> -err_clear_bit:
>>> +err_clk_disable_unprepare:
>>> +     clk_disable_unprepare(atmel_port->clk);
>>>        clear_bit(atmel_port->uart.line, atmel_ports_in_use);
>>>    err:
>>>        return ret;
>>> @@ -2997,8 +2964,6 @@ static int atmel_serial_remove(struct
>>> platform_device *pdev)
>>>
>>>        clear_bit(port->line, atmel_ports_in_use);
>>>
>>> -     clk_put(atmel_port->clk);
>>> -     atmel_port->clk = NULL;
>>>        pdev->dev.of_node = NULL;
>>>
>>>        return ret;
>> Thanks !
>>
>> Regards,
>> Richard
> 
