Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC84D5E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiCKJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347464AbiCKJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:22:52 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF41BD05A;
        Fri, 11 Mar 2022 01:21:49 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id j17so12043279wrc.0;
        Fri, 11 Mar 2022 01:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3PWKx/GG7lvu/JjEo7HaErVf5eLJj3x+U8mzOkpm4PA=;
        b=53U5Mw6aVJGlHPEvjR82QFxgDo9mVxy0XlWQ92Yt4S/5p/zZLLrY9BqkDXXJwKgmXN
         xrX9sDSOGlGR6AxnmqTNnTbMg1w1MjFDsLBovU08kwsvQku1D3Cxq/RHfaL7Ajd0+tjQ
         0Z/0d99aUyulmHT3vsmctaJXEnmrOrvy1xTGWzeAO5dtc27Gju9jNczXxID+EVZ7dSAp
         N1qbmd/ITgESxgrJ6dCgvC+KzjylEfKDaFja3TYTOv5jz1wy+64DLwgj2LSuStLkEVni
         hNr5WZp52+1ZpiJhITk87mnwE872UvmhmzUwWCWE5YtjZJYjaIViVO/b76XPP2HaWKAI
         a1aw==
X-Gm-Message-State: AOAM533kcitS6nLbgOHcF2s3PI6CJx6VTg7e6TEJRJqOOw7O50rNpRSj
        0V7KeECQKzLkN/MuJ3lbVHSuvbN3kDk=
X-Google-Smtp-Source: ABdhPJw4pyA7cBFM2v3sxvGR9xY4shXmmwYpFXW/tyzlTvFLL+i47S3C+2xWK3LbVXoQeyu7A8WBuA==
X-Received: by 2002:a5d:59ac:0:b0:203:9615:31db with SMTP id p12-20020a5d59ac000000b00203961531dbmr1665156wrr.457.1646990507935;
        Fri, 11 Mar 2022 01:21:47 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm6156925wrs.23.2022.03.11.01.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:21:47 -0800 (PST)
Message-ID: <0fb3795e-0ab1-494b-aefd-ccfa78420723@kernel.org>
Date:   Fri, 11 Mar 2022 10:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] serial: 8250_fintek.c: Report chipID
Content-Language: en-US
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <20220311070203.18159-2-twoerner@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220311070203.18159-2-twoerner@gmail.com>
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

On 11. 03. 22, 8:02, Trevor Woerner wrote:
> Provide some feedback to confirm this driver is enabled, and specify which
> chip was detected.

No, we don't do that. In fact, the output is mostly useless as it 
doesn't even tell the user what device this is about.

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_fintek.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index d9f0e546b1a1..03ad2354d808 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -155,11 +155,22 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
>   
>   	switch (chip) {
>   	case CHIP_ID_F81865:
> +		pr_info("Fintek F81865\n");
> +		break;
>   	case CHIP_ID_F81866:
> +		pr_info("Fintek F81866\n");
> +		break;
>   	case CHIP_ID_F81966:
> +		pr_info("Fintek F81966\n");
> +		break;
>   	case CHIP_ID_F81216AD:
> +		pr_info("Fintek F81216AD\n");
> +		break;
>   	case CHIP_ID_F81216H:
> +		pr_info("Fintek F81216H\n");
> +		break;
>   	case CHIP_ID_F81216:
> +		pr_info("Fintek F81216\n");
>   		break;
>   	default:
>   		return -ENODEV;

thanks,
-- 
js
