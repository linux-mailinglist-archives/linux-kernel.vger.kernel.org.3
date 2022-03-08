Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D64D1054
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbiCHGce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbiCHGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:32:29 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE13D483;
        Mon,  7 Mar 2022 22:31:31 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id w4so20534548edc.7;
        Mon, 07 Mar 2022 22:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ExA2winC/bnMZ2JkgE+r6xBTL0yncJAqBVQpnJpaDj8=;
        b=lE3oc88hOOIIRS8ohC43jQkwJDBEiBIi1HrZfgXpJvIHM7SLmlPVOWD3xYss0Cz7jn
         v3bixF0W04C5mdWixeGrLOJZiauHNOaNR4apHRlA5dEm2EJoxg9WaDKCvu6/VWjbbLjI
         XnBf+jRdFGgNWYHN0C/FyGOEv9txVU2BCQh3r5k4txzC4h5+c+RkYsSGnPeOPRhvokmw
         T67PR+U7pkXlykmDoOoZQkT98TZEKcTuKcH3DasprdPkGCHzmmWeb/qQUmoW4lJL3lTC
         3gVluY5NU72a+2Kk+uSIy+T1BaFIWR/nHrRyI4sy1/gthQ9YX4e7MnHOsO00bEAE65eD
         rIBw==
X-Gm-Message-State: AOAM5306iQy+DaFb4YjvCpkEIAGJr4SdcRERpxUngloM4SB7gI337DxP
        XY6XEBR3ZolVKM6bsa5Cmjg=
X-Google-Smtp-Source: ABdhPJzNzVQZgW80pNg0y9KL0gbSYgXIJIIH824sOsoUVfDF1ii/M9Z4dMNbQ3K8tQNuqIg8h+IvWA==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr14667857edi.154.1646721089642;
        Mon, 07 Mar 2022 22:31:29 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y41-20020a50bb2c000000b0041622779c50sm4374661ede.37.2022.03.07.22.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 22:31:29 -0800 (PST)
Message-ID: <0eff632e-4a9d-f593-72de-243ff4c7733f@kernel.org>
Date:   Tue, 8 Mar 2022 07:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] serial: 8250_mtk: make two read-only arrays static const
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307230055.168241-1-colin.i.king@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220307230055.168241-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 03. 22, 0:00, Colin Ian King wrote:
> Don't populate the read-only arrays fraction_L_mapping and
> fraction_M_mapping on the stack but instead make them static
> const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_mtk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index fb65dc601b23..f4a0caa56f84 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -289,10 +289,10 @@ static void
>   mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>   			struct ktermios *old)
>   {
> -	unsigned short fraction_L_mapping[] = {
> +	static const unsigned short fraction_L_mapping[] = {
>   		0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
>   	};
> -	unsigned short fraction_M_mapping[] = {
> +	static const unsigned short fraction_M_mapping[] = {
>   		0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
>   	};

And perhaps make them both unsigned char?

thanks,
-- 
js
suse labs
