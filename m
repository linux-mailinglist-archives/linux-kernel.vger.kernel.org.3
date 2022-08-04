Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD7589761
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiHDFnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiHDFnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:43:12 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07B3CBFA;
        Wed,  3 Aug 2022 22:43:11 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id kb8so20385703ejc.4;
        Wed, 03 Aug 2022 22:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NYGXES9gCdKWriC9iSphplvvC1wAt0B9f4Q6As9d98E=;
        b=OpEpQ7W9BzqjtWMbDJJhYCnGN8Mx2V2fOMtgmtct+ISva1OzZzZWz5hB30EgUOkxP0
         2Cx3wL8RV0P+J8oA5kZvNGP4vhw6Km4eKLVKr8Im7W8s+/fjZBwPTvC9qHS+ZRimpMEy
         lSclgeyK7NgmodDRCLFiMdwwFYjKZjmu4dY3ekl+6wEd/KRzLA5oEgg15ytoqpUe8CCA
         w7F4zeLtzcUCJ+KR4FHyqb1+RDAz24ZMOzS3OTtiWr3oSFOhR1fQMDpOPlXyYZp+1l9v
         nOz/JKwrevXH2xUkbLptZM3gY8fkVsWFd/qoUpLh3CemQdZO93KcW+JMpI0HOo1M5XlH
         akhg==
X-Gm-Message-State: ACgBeo0Qawcl2vNYVbsidCxLyIaQ741zwkaB+1TeZM31E1ZPQUdsDE6N
        wmsZIFbPstfDVCapLWggXws=
X-Google-Smtp-Source: AA6agR7pXBnzpbGeUNWgQq9rq+0ArEBa8bGb6zgH/nuVxjBqL2+JhwFxIrcxaq2AAJs+f0PPzm9nOQ==
X-Received: by 2002:a17:907:6d1e:b0:72b:4add:75db with SMTP id sa30-20020a1709076d1e00b0072b4add75dbmr165582ejc.717.1659591790111;
        Wed, 03 Aug 2022 22:43:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id fj19-20020a0564022b9300b0043bbbaa323dsm143068edb.0.2022.08.03.22.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 22:43:09 -0700 (PDT)
Message-ID: <83c91a99-7fb8-321a-5d52-8f0b4a7cf1cb@kernel.org>
Date:   Thu, 4 Aug 2022 07:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mxser: remove redundant assignment to hwid
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220730130925.150018-1-colin.i.king@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220730130925.150018-1-colin.i.king@gmail.com>
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

On 30. 07. 22, 15:09, Colin Ian King wrote:
> The variable hwid is assigned a value but it is never read. The
> assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/tty/mxser.c:401:7: warning: Although the value stored to 'hwid'
> is used in the enclosing expression, the value is never actually read
> from 'hwid' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/mxser.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 70b982b2c6b2..600c71e5eebc 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -398,7 +398,7 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
>   	oldmcr = inb(io + UART_MCR);
>   	outb(0, io + UART_MCR);
>   	mxser_set_must_xon1_value(io, 0x11);
> -	if ((hwid = inb(io + UART_MCR)) != 0) {
> +	if (inb(io + UART_MCR) != 0) {

Yes, hwid is read later, this was a dummy assignment.

>   		outb(oldmcr, io + UART_MCR);
>   		return MOXA_OTHER_UART;
>   	}

thanks,
-- 
js
suse labs
