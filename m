Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCD4B9CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiBQKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:04:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiBQKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:04:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59AEEA7C;
        Thu, 17 Feb 2022 02:04:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u2so6889668wrw.1;
        Thu, 17 Feb 2022 02:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=meJGBOtEnLdfoDm8EYIbdOA16spw/euuzJMtqF+WBis=;
        b=pVySiP6mJ5FxXyjyFW+t9ZnwOouOKwiw87S40ccwEKhBH916hm2UrUNmFMcIRHVdl5
         TR6L0ZX5tGjk8D6muyusTKBHo6SQOvUbqpPw01QqpZavmn5E0tMndzWjHXQg7FAtLxSi
         gQ/worNo0DMHTGNIjY47/Ot/UcyXpZ0Bpvwg0jXVYPrd/3rBzINe5TA41Wa/9eBXb295
         a34NlSlDJkKoITkZLHtgIjIMLuEyd/KLJsFi92IFkFIzaa2tZt7B6UgNY4FJENi1P+Zq
         F94dLtTgukS7MhdxLGrJp5UQMdZu024LKTsJzLC4QZRs437h6uxEeujj4KKkMqlw8Ga2
         4MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=meJGBOtEnLdfoDm8EYIbdOA16spw/euuzJMtqF+WBis=;
        b=srkJ1g7yvfDQrsmrc2BScfYQS91jazMfZH2zC2kZBsN2QrJBrrEEJnvuARotxe0A/Y
         WZg4phSlEiJgGtQnN4s7N1qAE7fk4p+5jAlWPJlfAkpP23JOlqyRVYoy7iY+mcM5PoyV
         VfmhjgPITmSahf/jCOOCWUkK+u9Y8wf1r6anB9HEADjoZtjDqXcLRxsaqW9cJ+mKa1NO
         e2LvMQ03nY1qitI5UZla3kJDq1QcYiWWcPJygEMkE1D9ABXxsIUtDP3gT909B4ZCpR1n
         giJbx0BU3OaU4UQusEQcm0NmkNaTSg/BiX34HULHO6UULSxIC/EuxrhvdP5/86v6lG1M
         5wEg==
X-Gm-Message-State: AOAM531QwtHDPHugoVQx+xFFyK6LiIyqzSelIXdPnMHv7CxgzYP5vRaL
        +CkbDCsEpwWuEAR5LODNpzg=
X-Google-Smtp-Source: ABdhPJxyOiz0T2pKxrlwMmUNxTuxOagK7yClAldWgq19nau4JhvuP1VmSsYHGbvi/xK/Q+/jdW9YcQ==
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr1667525wry.707.1645092239051;
        Thu, 17 Feb 2022 02:03:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id ay34sm732313wmb.29.2022.02.17.02.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:03:58 -0800 (PST)
Message-ID: <7d257438-b6cc-8a57-e8e4-b6fd6d0b4cac@gmail.com>
Date:   Thu, 17 Feb 2022 11:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] tty: serial: atmel: add earlycon support
Content-Language: fr-FR
To:     Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220217094620.1148571-1-michael@walle.cc>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220217094620.1148571-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/02/2022 à 10:46, Michael Walle a écrit :
> Add early console support which relies on the bootloader for the
> initialization of the UART.
> Please note, that the compatibles are taken from at91-usart MFD
> driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/Kconfig        |  1 +
>   drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0e5ccb25bdb1..407a98ec0791 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -139,6 +139,7 @@ config SERIAL_ATMEL_CONSOLE
>   	bool "Support for console on AT91 serial port"
>   	depends on SERIAL_ATMEL=y
>   	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
>   	help
>   	  Say Y here if you wish to use an on-chip UART on a Atmel
>   	  AT91 processor as the system console (the system
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2d09a89974a2..73d43919898d 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2673,6 +2673,30 @@ static struct console atmel_console = {
>   	.data		= &atmel_uart,
>   };
>   
> +static void atmel_serial_early_write(struct console *con, const char *s,
> +				     unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, atmel_console_putchar);
> +}
> +
> +static int __init atmel_early_console_setup(struct earlycon_device *device,
> +					    const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = atmel_serial_early_write;
> +
> +	return 0;
> +}
> +
> +OF_EARLYCON_DECLARE(atmel_serial, "atmel,at91rm9200-usart",
> +		    atmel_early_console_setup);
> +OF_EARLYCON_DECLARE(atmel_serial, "atmel,at91sam9260-usart",
> +		    atmel_early_console_setup);
> +
>   #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
>   
>   #else
Thanks !
