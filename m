Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C74B9BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiBQJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:22:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiBQJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:22:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928516409;
        Thu, 17 Feb 2022 01:22:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3518054wmq.3;
        Thu, 17 Feb 2022 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uEF/FU/QB3+JPW9i0x2lAGeqkeJMKwTkLaDfp85o4eA=;
        b=DY+MxSUAazGgw0yYDJltTUdAkc4UgtVq4+ctUknKf21YBPaMDiGfUnVX7BHtJJuqHu
         1SYdMuGzCw+h4q8+FwO+M7XjGOkzjXPQXhTwf+I9PpvoHSRBA7ehI1K3BugPXbedrc1p
         aVCOobSkjGFu+kR91na4ZDELFbcmv+HlgA1AhukRVY4kzK+XIK2j+TyqNlRN/gd+Of8X
         UoYHrOua6xlip9UDXmcWaMftQmZ4uA2bIKAOPpCj3yS/X50MySCDwh/RP6Pxma3ui19H
         exH1l/GR9ZT+PrEB9p+ai3Fvt3S68xBiawm9KjnFnYyGYdVy02sqs/MBti/L5jSXVGY9
         Dylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uEF/FU/QB3+JPW9i0x2lAGeqkeJMKwTkLaDfp85o4eA=;
        b=KlMT0THTZGIHoJCzbdRD2XN+gFLTRKkC7Cgj9DAeI917O+B9TTb1hvG7Patdz5VoAy
         tkYaGVAQGfMBXzxyhOlywfeIng1l9BJ9w+2Wd/O/uwOWT+6UVcGUBFvX1rabuQ7FgM44
         KanWsJZqQQDyzOUjNlwwcpnNpdc/877X21i2byjmc2Pi8DrlAyVRbiVi5WS9yk2bmiBC
         /fHMcdApwKMVtkWIPVA5YJCPj19vmqKDoj8YrXPPg8PP/D5oZMaWV+TCJAON+CFhYSSW
         /zlteqyvleTV06571uXpmhsAh9jbP+hgmOAyuWqVvIiA7N22XKAGphQshTKL6mipHgoA
         MvjQ==
X-Gm-Message-State: AOAM532kBfWdngLhZDgknj82aIZkFY+VhY9MvFjUL8B204klvFIhb4Af
        xVyUoxQxVvhbiyuYlJzwCxA=
X-Google-Smtp-Source: ABdhPJxLAKZpTcdUX9zsbSPT39Xp2a3eU0dgLLZ3ehz2f2hFJv3v5S8CmNO4M+fKKNRAi5NErhBVvg==
X-Received: by 2002:a1c:7c0d:0:b0:37d:1e29:5cc6 with SMTP id x13-20020a1c7c0d000000b0037d1e295cc6mr5162767wmc.31.1645089725110;
        Thu, 17 Feb 2022 01:22:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id f18sm1184725wre.66.2022.02.17.01.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:22:04 -0800 (PST)
Message-ID: <b8721c78-e422-7dff-3cf1-7a9bcda6dce3@gmail.com>
Date:   Thu, 17 Feb 2022 10:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2 9/9] serial: atmel: remove redundant assignment in
 rs485_config
Content-Language: fr-FR
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-10-LinoSanfilippo@gmx.de>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20220216001803.637-10-LinoSanfilippo@gmx.de>
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


Le 16/02/2022 à 01:18, Lino Sanfilippo a écrit :
> In uart_set_rs485_config() the serial core already assigns the passed
> serial_rs485 struct to the uart port.
> 
> So remove the assignment from the drivers rs485_config() function to avoid
> redundancy.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2d09a89974a2..2ab589a3d86c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -299,11 +299,9 @@ static int atmel_config_rs485(struct uart_port *port,
>   	/* Resetting serial mode to RS232 (0x0) */
>   	mode &= ~ATMEL_US_USMODE;
>   
> -	port->rs485 = *rs485conf;
> -
>   	if (rs485conf->flags & SER_RS485_ENABLED) {
>   		dev_dbg(port->dev, "Setting UART to RS485\n");
> -		if (port->rs485.flags & SER_RS485_RX_DURING_TX)
> +		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
>   			atmel_port->tx_done_mask = ATMEL_US_TXRDY;
>   		else
>   			atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;

Thanks !
