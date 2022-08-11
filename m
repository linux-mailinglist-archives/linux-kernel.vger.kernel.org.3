Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC958FAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiHKKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiHKKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:48:47 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BEE92F44;
        Thu, 11 Aug 2022 03:48:45 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a7so32844160ejp.2;
        Thu, 11 Aug 2022 03:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2psXapoZ13xPQOZjFEvN9Z4DOi1cREWK0pz2T2YJtmo=;
        b=IpaDm60Ez/kHnqKOqwLqecSOwt+TofmQl/BUc7MHOIkH+fULgLOPOjr9Aw3pYpBSBv
         R42mufR3uBI1vhL2XhmgmHEcUOGhJgWprd7YeDkcdO7VPwITvhzUs5N9bqCJnBBY6pRX
         TFKmzXSL1kiu7hQ1UM8NGEUUbrQqAN9KMyUZMn57TtSuFmaOzXKbG6ICXX17Yw5kpCcT
         elrAgNcjQg16pGxgqd5BX1u9AweMno7CSdUgcZyt5ioxbgN8AlIEtvilOgwLtU+xKODg
         osd0C5snWFdL8DWNjt8XsYm/sYoxWe9a18UN+nWiheue9WpSWe8C5dkfys8QQzNXFQP2
         DVGA==
X-Gm-Message-State: ACgBeo1keGsGLQTGG8T2pNsCcORl7bVTfmz427qRZ34bkA5IU8tbUDEd
        eYXvNLOXCXmjp3BTnV0LQINQw+PsaC8=
X-Google-Smtp-Source: AA6agR7YlDJTfvAKpbFW/hQM6n5lS76ql3UMmCt24HIKcucEnGQwv4lfDeC9lNHbbPYUxsv5aMUahQ==
X-Received: by 2002:a17:907:2e19:b0:730:acf0:4921 with SMTP id ig25-20020a1709072e1900b00730acf04921mr21902909ejc.416.1660214924186;
        Thu, 11 Aug 2022 03:48:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f15-20020a50ee8f000000b0043bc4b28464sm9002313edr.34.2022.08.11.03.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 03:48:43 -0700 (PDT)
Message-ID: <2fd0f4e5-8b5d-4257-4700-71e68cff29f6@kernel.org>
Date:   Thu, 11 Aug 2022 12:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] serial: stm32: make info structs static to avoid sparse
 warnings
Content-Language: en-US
To:     Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     gregkh@linuxfoundation.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
References: <20220721212430.453192-1-ben-linux@fluff.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220721212430.453192-1-ben-linux@fluff.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 07. 22, 23:24, Ben Dooks wrote:
> The info structs are local only to the stm32-usart.c driver and are
> triggering sparse warnings about being undecalred. Move these into
> the main driver code and make them static to avoid the following
> warnings:
> 
> drivers/tty/serial/stm32-usart.h:42:25: warning: symbol 'stm32f4_info' was not declared. Should it be static?
> drivers/tty/serial/stm32-usart.h:63:25: warning: symbol 'stm32f7_info' was not declared. Should it be static?
> drivers/tty/serial/stm32-usart.h:85:25: warning: symbol 'stm32h7_info' was not declared. Should it be static?

Right, I would go even further. There is no point in having a separate 
header. So could you move the whole content to .c?

> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>   drivers/tty/serial/stm32-usart.c | 69 ++++++++++++++++++++++++++++++++
>   drivers/tty/serial/stm32-usart.h | 68 -------------------------------
>   2 files changed, 69 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0973b03eeeaa..01f1ab2c18c0 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -35,6 +35,75 @@
>   #include "serial_mctrl_gpio.h"
>   #include "stm32-usart.h"
>   
> +
> +/* Register offsets */
> +static struct stm32_usart_info stm32f4_info = {
> +	.ofs = {
> +		.isr	= 0x00,
> +		.rdr	= 0x04,
> +		.tdr	= 0x04,
> +		.brr	= 0x08,
> +		.cr1	= 0x0c,
> +		.cr2	= 0x10,
> +		.cr3	= 0x14,
> +		.gtpr	= 0x18,
> +		.rtor	= UNDEF_REG,
> +		.rqr	= UNDEF_REG,
> +		.icr	= UNDEF_REG,
> +	},
> +	.cfg = {
> +		.uart_enable_bit = 13,
> +		.has_7bits_data = false,
> +		.fifosize = 1,
> +	}
> +};
> +
> +static struct stm32_usart_info stm32f7_info = {
> +	.ofs = {
> +		.cr1	= 0x00,
> +		.cr2	= 0x04,
> +		.cr3	= 0x08,
> +		.brr	= 0x0c,
> +		.gtpr	= 0x10,
> +		.rtor	= 0x14,
> +		.rqr	= 0x18,
> +		.isr	= 0x1c,
> +		.icr	= 0x20,
> +		.rdr	= 0x24,
> +		.tdr	= 0x28,
> +	},
> +	.cfg = {
> +		.uart_enable_bit = 0,
> +		.has_7bits_data = true,
> +		.has_swap = true,
> +		.fifosize = 1,
> +	}
> +};
> +
> +static struct stm32_usart_info stm32h7_info = {
> +	.ofs = {
> +		.cr1	= 0x00,
> +		.cr2	= 0x04,
> +		.cr3	= 0x08,
> +		.brr	= 0x0c,
> +		.gtpr	= 0x10,
> +		.rtor	= 0x14,
> +		.rqr	= 0x18,
> +		.isr	= 0x1c,
> +		.icr	= 0x20,
> +		.rdr	= 0x24,
> +		.tdr	= 0x28,
> +	},
> +	.cfg = {
> +		.uart_enable_bit = 0,
> +		.has_7bits_data = true,
> +		.has_swap = true,
> +		.has_wakeup = true,
> +		.has_fifo = true,
> +		.fifosize = 16,
> +	}
> +};
> +
>   static void stm32_usart_stop_tx(struct uart_port *port);
>   static void stm32_usart_transmit_chars(struct uart_port *port);
>   static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch);
> diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
> index ee69c203b926..0ec41a732c88 100644
> --- a/drivers/tty/serial/stm32-usart.h
> +++ b/drivers/tty/serial/stm32-usart.h
> @@ -38,74 +38,6 @@ struct stm32_usart_info {
>   
>   #define UNDEF_REG 0xff
>   
> -/* Register offsets */
> -struct stm32_usart_info stm32f4_info = {
> -	.ofs = {
> -		.isr	= 0x00,
> -		.rdr	= 0x04,
> -		.tdr	= 0x04,
> -		.brr	= 0x08,
> -		.cr1	= 0x0c,
> -		.cr2	= 0x10,
> -		.cr3	= 0x14,
> -		.gtpr	= 0x18,
> -		.rtor	= UNDEF_REG,
> -		.rqr	= UNDEF_REG,
> -		.icr	= UNDEF_REG,
> -	},
> -	.cfg = {
> -		.uart_enable_bit = 13,
> -		.has_7bits_data = false,
> -		.fifosize = 1,
> -	}
> -};
> -
> -struct stm32_usart_info stm32f7_info = {
> -	.ofs = {
> -		.cr1	= 0x00,
> -		.cr2	= 0x04,
> -		.cr3	= 0x08,
> -		.brr	= 0x0c,
> -		.gtpr	= 0x10,
> -		.rtor	= 0x14,
> -		.rqr	= 0x18,
> -		.isr	= 0x1c,
> -		.icr	= 0x20,
> -		.rdr	= 0x24,
> -		.tdr	= 0x28,
> -	},
> -	.cfg = {
> -		.uart_enable_bit = 0,
> -		.has_7bits_data = true,
> -		.has_swap = true,
> -		.fifosize = 1,
> -	}
> -};
> -
> -struct stm32_usart_info stm32h7_info = {
> -	.ofs = {
> -		.cr1	= 0x00,
> -		.cr2	= 0x04,
> -		.cr3	= 0x08,
> -		.brr	= 0x0c,
> -		.gtpr	= 0x10,
> -		.rtor	= 0x14,
> -		.rqr	= 0x18,
> -		.isr	= 0x1c,
> -		.icr	= 0x20,
> -		.rdr	= 0x24,
> -		.tdr	= 0x28,
> -	},
> -	.cfg = {
> -		.uart_enable_bit = 0,
> -		.has_7bits_data = true,
> -		.has_swap = true,
> -		.has_wakeup = true,
> -		.has_fifo = true,
> -		.fifosize = 16,
> -	}
> -};
> -
>   /* USART_SR (F4) / USART_ISR (F7) */
>   #define USART_SR_PE		BIT(0)
>   #define USART_SR_FE		BIT(1)

thanks,
-- 
js
suse labs

