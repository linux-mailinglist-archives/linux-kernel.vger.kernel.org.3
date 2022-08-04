Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0B5897B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiHDGVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:21:48 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A52981F;
        Wed,  3 Aug 2022 23:21:47 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id e13so5088777edj.12;
        Wed, 03 Aug 2022 23:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N6k+tlzFgkowCn7rYkdkXMm4KWRMRkrYOnyQhdzh6bI=;
        b=rM1cPnfD6U30NQtIfcs3RkwwK2v85z+z241ixuJHp5g/TJZdicDpgjbOKqVaI9X6JJ
         brOtHJCy3aYSFEycKJ1c+6LvebA0SPAZe6HpW0/6hhevOqCntGRzlqvzm73yp0TwZGIR
         GEp+pwHdn7cXcLPALMduDsrKhRHTsyeBA/f36YQupT6uHOFYMRZ0O8hOPHRhdj2oUjQE
         LBGaJsq0D/kjd/kOOHNYqj/0HYrH0pGTMWfyM55NAQU3N46bJxIlsAohmjLmm9nN8sC5
         ywLGSrRfSJvk2nxIsEmySi9XFCeuUZhwujFk6KGt9dJ544g4n5uoB0eytW3kexyYfb33
         cd6Q==
X-Gm-Message-State: ACgBeo3JAp6QBNYfaVtTqHIV0qaAAhHsvlNHxDc7aAm6abCxPH1IJDq5
        vNmcCVLdmdtybf1ALYQ4rDQ=
X-Google-Smtp-Source: AA6agR72QiqXNtcjKdiDiMaEETiudPcSB7MqYAYSS9Bhnfm9pED3uSy8J1YN/qnVz/UWT/Fvrw64ng==
X-Received: by 2002:a05:6402:424d:b0:43e:8bd8:f531 with SMTP id g13-20020a056402424d00b0043e8bd8f531mr461066edb.266.1659594105950;
        Wed, 03 Aug 2022 23:21:45 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b0072af102e65csm7942780ejk.152.2022.08.03.23.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 23:21:45 -0700 (PDT)
Message-ID: <9fdbd349-b464-8075-f377-ed442761b827@kernel.org>
Date:   Thu, 4 Aug 2022 08:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: serial: lpuart: disable flow control when wait
 transmit engine complete
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20220803015512.25472-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220803015512.25472-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 08. 22, 3:55, Sherry Sun wrote:
> When TX fifo has dirty data, user initialize the port and wait transmit
> engine complete, it should disable the flow control, otherwise tx fifo
> never be empty.

Sorry I cannot parse the above. Care to rephrase? (And maybe spellcheck?)

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index fc7d235a1e27..f0fccd2ff7ac 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>   	uart_update_timeout(port, termios->c_cflag, baud);
>   
>   	/* wait transmit engin complete */
> +	lpuart32_write(&sport->port, 0, UARTMODIR);
>   	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
>   
>   	/* disable transmit and receive */

thanks,
-- 
js
suse labs
