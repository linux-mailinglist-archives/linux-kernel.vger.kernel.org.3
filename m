Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63A544188
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiFICiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiFICiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:38:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710F30F6FD;
        Wed,  8 Jun 2022 19:38:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l81so14902989oif.9;
        Wed, 08 Jun 2022 19:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ieMANlrQtUWOfoehGYdhasPyzPg5B2AlHcSNfojNt9U=;
        b=boTT6UcDYkkXzt9lAVqIHN7f5bWEtUve8hm+LT+bM2jI33COyj3iE+vKJO7dB+WHFe
         m96gYQKZoUf78+WWudFew1BBZ0iFd+4ktC0+AXQ+4O9ksszTMVYOkPTWcwbtCgE6EPSb
         i5DFyHL0SB+b1GStwHybxy1UUd4nw56h53PWMpS3I+2P/I7zZVdFknX49BPDo0Yqoe/0
         Slsg7Eza+A6pficvGUi8ZYNNsS98fVlKi2WOTdE/YAVncHl8onnm7FL8+Itf6zXbvpgk
         Ac7eLmib7dxXpsmhJwaUtbdzP0ss9dMsfcLw2OhHvw/JdDp1hBFR4EgEd48EJJ5q0pMf
         MP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ieMANlrQtUWOfoehGYdhasPyzPg5B2AlHcSNfojNt9U=;
        b=y3i+Ul+fmoBYJeDgYU7JvugM8PgidsZ6AF5TCck2XD6rZndI2dS5ufm2PurE1r/+C4
         IUQVlDuqVusV8YR0Jw3+xTyEX46SZuZ0uEatKvSB6eo6CfRQuxwK3K7NB8zAwsH1qlEi
         BnO53QkSAUEzirBpcG9RZJNp5YWBBFEXtP+bSujK7k7uURbQPldhIO+WjVe9isYLa1n9
         OjnE+6Nb1sK7kPYoAV02Ajtr6sLzFFgr5uiZwg2a6ntBNpLjFM1nGsWIYYY3fqFP8Cic
         1cpTetH3Go6jvSeD+5s6JTRteGm5PqL8CqJ58vvQ0z7Gw6M4TzgDu7vBSwGv7wGGJIYN
         xwSQ==
X-Gm-Message-State: AOAM530dygRqs8t32LeUXhMS0h7zdfWOKhos8ZNYA8ygtHQRV9uKrhLn
        YDr7h1q1ddrPoxwFYz+X6egLZJtUdOs=
X-Google-Smtp-Source: ABdhPJwoA6fwpshvsnYxHxIZDYwoZgwoq+OsqccYINIDqvZKkRSyJay1HBGhT/uhV88COblziZlvnQ==
X-Received: by 2002:aca:3a84:0:b0:32e:418e:a693 with SMTP id h126-20020aca3a84000000b0032e418ea693mr525602oia.205.1654742297493;
        Wed, 08 Jun 2022 19:38:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r23-20020a9d7cd7000000b0060c01dbd39esm4167105otn.11.2022.06.08.19.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 19:38:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d7225066-df9d-4b14-685e-ce1ea42676f1@roeck-us.net>
Date:   Wed, 8 Jun 2022 19:38:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] watchdog:Fix typo in comment
Content-Language: en-US
To:     luoxueqin <luoxueqin66@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>
References: <20220609013011.54175-1-937225041@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220609013011.54175-1-937225041@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 18:30, luoxueqin wrote:
> From: Luo Xueqin <luoxueqin@kylinos.cn>
> 
> Spelling mistake in comment.
> 
> Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Please version your patches in the future.

Thanks,
Guenter

> ---
>   drivers/watchdog/pc87413_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index 9f9a340427fc..c7f745caf203 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -442,7 +442,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
>   	}
>   }
>   
> -/* -- Notifier funtions -----------------------------------------*/
> +/* -- Notifier functions -----------------------------------------*/
>   
>   /**
>    *	pc87413_notify_sys:

