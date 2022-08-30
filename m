Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5C5A6AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiH3RfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiH3Rex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:34:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226F3C32ED;
        Tue, 30 Aug 2022 10:31:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b16so7530788wru.7;
        Tue, 30 Aug 2022 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RwMqBrb3R5uXGn2qw7GPWZ3bQeQTjtorEPuMXuemwpo=;
        b=DO1BUFiyGD31tTnmVEmLSCO9IulJniLpXrCp6fQPjw26NzRGgWtBNBha3lscYPhfNi
         VwRj2dWGNRFzxCun6FjTqwfRTTElS3IJ58LM3lOyUsXXr8n2VGLvxxwiIa2ABSgXZF2p
         1bCQHgNwxbSSCm6lPjKPGPAaU2wfze8CRuDBX8lhDhPBObXu0CgMHCZdFnrV8pIxwXRP
         sYeFVgq5GYUhhapcE5LOrajAXxeRV6VEZMGLYWAqy2HcjLJV77WCl/yS51O1/V+XeFh5
         1n0NBYADXBeSbJHX0QCRHDEQa50cI9mvaUyARXKChTLfM/ZSFN3h5wetXoxW/2nOQzhB
         6jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RwMqBrb3R5uXGn2qw7GPWZ3bQeQTjtorEPuMXuemwpo=;
        b=cb6nTTPULWfYHnnDxphXm1srnElxwg1DU1vK1PlhJeGQZD/OTf0BmKQ83OVwQEpdK1
         8vfMSOuiWfqy1QuaP3JDgrI7w8WikPUm0OF6OlU5l+ahEJ45ReTjW6+GW2caXKhnA3sT
         R9iO8t9eWC4NcEDBFbEWI8JsNl0cM1aZZ20qfJmQLbfLgqJStumuPABQliZXAcmpHgBs
         iORF4JhT7H47XSXswdaQF4zlTKuU2TF22UZhZ51IKQjCcmMHsLlql+WD90sqVsm8QL0f
         w59gdYSMON7CBPMqnea5HI3Am0JXr5LbEWwz72qfUiIDxAy+SftBrECvJNXCKAPaPKEu
         SHPg==
X-Gm-Message-State: ACgBeo0ojSl2SI7CwLit7yF9DSGU5VcfplukT8dx+8HJKKNY7/6XCvDJ
        Nury4J4rf97xrorlQKZEeRA=
X-Google-Smtp-Source: AA6agR55K1nw1QG8nObLBgLURKElil+KJlOaDpAsKBhiWoXC4bYD6Q6OLD2Mg5Iqc2sOsSq+QyS13A==
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id g9-20020a5d64e9000000b002207dd763ebmr9552329wri.590.1661880590302;
        Tue, 30 Aug 2022 10:29:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4848000000b00226d01a4635sm10111450wrs.35.2022.08.30.10.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:29:49 -0700 (PDT)
Message-ID: <07e1091b-a8d6-9dd9-f702-42f46ef912de@gmail.com>
Date:   Tue, 30 Aug 2022 19:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Content-Language: fr-FR
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, kavyasree.kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-6-sergiu.moga@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220817075517.49575-6-sergiu.moga@microchip.com>
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

Le 17/08/2022 à 09:55, Sergiu Moga a écrit :
> Previously, the atmel serial driver did not take into account the
> possibility of using the more customizable generic clock as its
> baudrate generator. Unless there is a Fractional Part available to
> increase accuracy, there is a high chance that we may be able to
> generate a baudrate closer to the desired one by using the GCLK as the
> clock source. Now, depending on the error rate between
> the desired baudrate and the actual baudrate, the serial driver will
> fallback on the generic clock. The generic clock must be provided
> in the DT node of the serial that may need a more flexible clock source.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>   drivers/tty/serial/atmel_serial.c | 52 ++++++++++++++++++++++++++++++-
>   drivers/tty/serial/atmel_serial.h |  1 +
>   2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 30ba9eef7b39..0a0b46ee0955 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -15,6 +15,7 @@
>   #include <linux/init.h>
>   #include <linux/serial.h>
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/console.h>
>   #include <linux/sysrq.h>
>   #include <linux/tty_flip.h>
> @@ -77,6 +78,8 @@ static void atmel_stop_rx(struct uart_port *port);
>   #endif
>   
>   #define ATMEL_ISR_PASS_LIMIT	256
> +#define ERROR_RATE(desired_value, actual_value) \
> +	((int)(100 - ((desired_value) * 100) / (actual_value)))
>   
>   struct atmel_dma_buffer {
>   	unsigned char	*buf;
> @@ -110,6 +113,7 @@ struct atmel_uart_char {
>   struct atmel_uart_port {
>   	struct uart_port	uart;		/* uart */
>   	struct clk		*clk;		/* uart clock */
> +	struct clk		*gclk;		/* uart generic clock */
>   	int			may_wakeup;	/* cached value of device_may_wakeup for times we need to disable it */
>   	u32			backup_imr;	/* IMR saved during suspend */
>   	int			break_active;	/* break being received */
> @@ -2115,6 +2119,8 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>   		 * This is called on uart_close() or a suspend event.
>   		 */
>   		clk_disable_unprepare(atmel_port->clk);
> +		if (atmel_port->gclk && __clk_is_enabled(atmel_port->gclk))
> +			clk_disable_unprepare(atmel_port->gclk);
>   		break;
>   	default:
>   		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
> @@ -2129,7 +2135,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>   {
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>   	unsigned long flags;
> -	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
> +	unsigned int old_mode, mode, imr, quot, div, cd, fp = 0;
> +	unsigned int baud, actual_baud, gclk_rate;
>   
>   	/* save the current mode register */
>   	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
> @@ -2288,6 +2295,37 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>   		cd /= 8;
>   		mode |= ATMEL_US_USCLKS_MCK_DIV8;
>   	}
> +
> +	/*
> +	 * If there is no Fractional Part, there is a high chance that
> +	 * we may be able to generate a baudrate closer to the desired one
> +	 * if we use the GCLK as the clock source driving the baudrate
> +	 * generator.
> +	 */
> +	if (!fp && atmel_port->gclk) {
> +		if (__clk_is_enabled(atmel_port->gclk))
> +			clk_disable_unprepare(atmel_port->gclk);
> +		clk_set_rate(atmel_port->gclk, 16 * baud);
> +		gclk_rate = clk_get_rate(atmel_port->gclk);
> +		actual_baud = clk_get_rate(atmel_port->clk) / (16 * cd);
> +		if (abs(ERROR_RATE(baud, actual_baud)) >
> +		    abs(ERROR_RATE(baud, gclk_rate / 16))) {
> +			mode |= ATMEL_US_GCLK;
> +
> +			/*
> +			 * Set the Clock Divisor for GCLK to 1.
> +			 * Since we were able to generate the smallest
> +			 * multiple of the desired baudrate times 16,
> +			 * then we surely can generate a bigger multiple
> +			 * with the exact error rate for an equally increased
> +			 * CD. Thus no need to take into account
> +			 * a higher value for CD.
> +			 */
> +			cd = 1;
> +			clk_prepare_enable(atmel_port->gclk);
> +		}
> +	}
> +
>   	quot = cd | fp << ATMEL_US_FP_OFFSET;
>   
>   	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
> @@ -2883,6 +2921,16 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err;
>   
> +	atmel_port->gclk = devm_clk_get_optional(&pdev->dev, "gclk");
> +	if (atmel_port->gclk) {
> +		ret = clk_prepare_enable(atmel_port->gclk);
> +		if (ret) {
> +			atmel_port->gclk = NULL;
> +			return ret;
> +		}
> +		clk_disable_unprepare(atmel_port->gclk);
> +	}
> +
>   	ret = atmel_init_port(atmel_port, pdev);
>   	if (ret)
>   		goto err_clk_disable_unprepare;
> @@ -2929,6 +2977,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
>   	 * is used
>   	 */
>   	clk_disable_unprepare(atmel_port->clk);
> +	if (atmel_port->gclk && __clk_is_enabled(atmel_port->gclk))
> +		clk_disable_unprepare(atmel_port->gclk);
>   
>   	return 0;
>   
> diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
> index 0d8a0f9cc5c3..fb718972f81a 100644
> --- a/drivers/tty/serial/atmel_serial.h
> +++ b/drivers/tty/serial/atmel_serial.h
> @@ -63,6 +63,7 @@
>   #define		ATMEL_US_PAR_MARK		(3 <<  9)
>   #define		ATMEL_US_PAR_NONE		(4 <<  9)
>   #define		ATMEL_US_PAR_MULTI_DROP		(6 <<  9)
> +#define ATMEL_US_GCLK                          BIT(12)
>   #define	ATMEL_US_NBSTOP		GENMASK(13, 12)	/* Number of Stop Bits */
>   #define		ATMEL_US_NBSTOP_1		(0 << 12)
>   #define		ATMEL_US_NBSTOP_1_5		(1 << 12)

Correct me if I'm wrong, but GCLK is selected by the bit 12 only in UART_MR, not in USART_MR.
In USART_MR, it seems to be controlled by bits 4-5 (and bit 12 is for stop bits, as we can see above, and in the datasheet).
cf https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA5D2-Series-Datasheet-DS60001476H.pdf
page 1637

Regards,
Richard.
