Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859CB5897E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiHDGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiHDGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:51:14 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4223F;
        Wed,  3 Aug 2022 23:51:13 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id w19so1229396ejc.7;
        Wed, 03 Aug 2022 23:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iLIYfyOix2Y74BfL9+vWR1ZPq7wwcIzufyYR6kbSUN8=;
        b=7Oy9pK4rG6sn2YNOY+TWS+T9RDYmj5Tmz9Xko4nhZeIN3GgMKyo3tR0D0xg/iSjPaJ
         UGUPDMKeW6ccj312y3lZnetwli787aZltNw8I0tE1aWL6SMW1frMeqctgQyA1PGyLLtc
         CpJw2mc4oiTxH2EfuIrlqQNxpbBEH3JZ66O9FUGHkrS/40qwqMkO21MDDnXBUaTb7kMN
         FtVnCdIuC/tN+71bNk1w+F6IJo3VFrtq+5zk+wNdSXCA4X3Qr/6JDzy4mwMRkKjMadkp
         jOMk4yU5Dn28/1cFg1EaT3QMyn5Y/6Rnw2mHwNQBkLRPJg1hJdwlH+ZhkfdvuGaPFREY
         UeTw==
X-Gm-Message-State: ACgBeo0xYmrDL0UxscuFKzPQDrT77XoEkaO3IBMGA3IpvwK1kke+CoFh
        u20qc29X4u7M4j+sWYO8P1gudPPid7g=
X-Google-Smtp-Source: AA6agR6DdqirEM/JxL6wQLqX2HmxIhlOhGTvj8yboePFoXC4j1y8EWKExyWfKi3BKBXlXTLom4uX4w==
X-Received: by 2002:a17:906:9749:b0:730:c005:5d59 with SMTP id o9-20020a170906974900b00730c0055d59mr324623ejy.419.1659595872090;
        Wed, 03 Aug 2022 23:51:12 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ez17-20020a056402451100b0043ba7df7a42sm203765edb.26.2022.08.03.23.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 23:51:11 -0700 (PDT)
Message-ID: <c63877d8-4df2-778e-7e3d-2fdd0e14d4e1@kernel.org>
Date:   Thu, 4 Aug 2022 08:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] serial: fsl_lpuart: RS485 RTS polariy is inverse
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Diaz <nicolas.diaz@nxp.com>
References: <20220802163854.1055323-1-shenwei.wang@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220802163854.1055323-1-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 22, 18:38, Shenwei Wang wrote:
> The setting of RS485 RTS polarity is inverse in the current driver.
> 
> When the property of 'rs485-rts-active-low' is enabled in the dts node,
> the RTS signal should be LOW during sending. Otherwise, if there is no
> such a property, the RTS should be HIGH during sending.

What commit this fixes? I.e. I am missing a Fixes tag below.

> Signed-off-by: Nicolas Diaz <nicolas.diaz@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index afa0f941c862f..abc3a3674bc39 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1394,9 +1394,9 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
>   		 * Note: UART is assumed to be active high.
>   		 */
>   		if (rs485->flags & SER_RS485_RTS_ON_SEND)
> -			modem &= ~UARTMODEM_TXRTSPOL;
> -		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
>   			modem |= UARTMODEM_TXRTSPOL;
> +		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> +			modem &= ~UARTMODEM_TXRTSPOL;
>   	}
>   
>   	writeb(modem, sport->port.membase + UARTMODEM);

thanks,
-- 
js
suse labs
