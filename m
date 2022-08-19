Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50297599463
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiHSFUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiHSFUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:20:43 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7FD41BB;
        Thu, 18 Aug 2022 22:20:42 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id z2so4363822edc.1;
        Thu, 18 Aug 2022 22:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TUX4sy2iunYKK4x1eMavnunBrVLLc6AU/HdXTMwGbpY=;
        b=PqiDh+Rdw5XZdVGKcWtgz634HenuPBktiFjLQIgqeMJwRB6/iRXtxw01E6UI4IV8aK
         6YD1gnMxQUeJeyEHcs7r6FiU5WX4yeHuauLury5SmEraC9Tj20pdol+p7A7/Utf3ZzyV
         CmDINSsO0R/RZZ3yfeLo8huPJF9aGB4gixikiEpICwUhIJ9gm5+JRnmnPmklIHgXlAG1
         wO2CYvJnqtfd4O9qX4b7mm+2BbC8IHV3nV7mlQ9Z0rFQwCNRlDhAb+dON1qby/13owQX
         rFy3u42DLbTiBX97HSFW5aOxsQjqnzwaycGh+mikJCbM6f0p8bVtQmc2hGg5CxVWDDCM
         1vWQ==
X-Gm-Message-State: ACgBeo3lE3V0HZnMvCBrYM3lIm+//xg3BQUMd584UGUnGEeTcVjdgVXO
        /1g9RzTf72W1MVuGdNbXRVw=
X-Google-Smtp-Source: AA6agR7hrh4jirKmh7PS/NBmra1V+zyPD4Hkql93VI6MbM0UmMGfp3qOGQksT67+t7AdjDZG3D2jBA==
X-Received: by 2002:aa7:dbc5:0:b0:440:b0d6:7586 with SMTP id v5-20020aa7dbc5000000b00440b0d67586mr4564779edt.85.1660886440996;
        Thu, 18 Aug 2022 22:20:40 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906770200b00730860b6c43sm1799004ejm.173.2022.08.18.22.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 22:20:40 -0700 (PDT)
Message-ID: <362b55e8-6f98-6723-6751-92dbe16ea924@kernel.org>
Date:   Fri, 19 Aug 2022 07:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 12/13] serial: document start_rx member at struct uart_ops
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <5d07ae2eec8fbad87e623160f9926b178bef2744.1660829433.git.mchehab@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <5d07ae2eec8fbad87e623160f9926b178bef2744.1660829433.git.mchehab@kernel.org>
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

On 18. 08. 22, 15:38, Mauro Carvalho Chehab wrote:
> Fix this doc build warning:
> 	./include/linux/serial_core.h:397: warning: Function parameter or member 'start_rx' not described in 'uart_ops'

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
> 
>   include/linux/serial_core.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index aef3145f2032..6e4f4765d209 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -141,6 +141,14 @@ struct gpio_desc;
>    *	Locking: none.
>    *	Interrupts: caller dependent.
>    *
> + * @start_rx: ``void ()(struct uart_port *port)``
> + *
> + *	Start receiving characters.
> + *
> + *	Locking: @port->lock taken.
> + *	Interrupts: locally disabled.
> + *	This call must not sleep
> + *
>    * @stop_rx: ``void ()(struct uart_port *port)``
>    *
>    *	Stop receiving characters; the @port is in the process of being closed.

thanks,
-- 
js
suse labs

