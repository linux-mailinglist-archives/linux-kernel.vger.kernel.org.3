Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7358CB8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiHHPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243580AbiHHPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:49:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3F15701;
        Mon,  8 Aug 2022 08:49:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d7so8883946pgc.13;
        Mon, 08 Aug 2022 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=+NP/N0HwgYcfN4UPczUY+PGLtARnpcj8slx8KQukuLI=;
        b=Tep/Z/+BFJQew58xNEyUtktTIRZIk/HwrGRV8ANywkcnFgO9VKF217y6DMiB01z9G7
         o5WamWmzZUU6MDQxm5BrOoPSFuLRslCtDNxCEibAIi6Jxko4ZEGiNhv86oBQX767fnxd
         Igd2k/nm3Y6o4lNsFjOxxUR2b6HaNRm3AeIcwALU/oUEhEn44458rwOfhE6gJGWP/DZx
         Q7DqJt6wQPMS/I3tY9rxnjfxq2YD6dzgOBJm+nC61SV4N3dAIdN9nAsXf/ElHDZBjdrh
         beUFx4Ub3oldHN4++fvSb3oTqCt2vHU2yQ+gTl9NRRjm4ngGmKK7sbuuu0WEMrq4NjLr
         GB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=+NP/N0HwgYcfN4UPczUY+PGLtARnpcj8slx8KQukuLI=;
        b=0GV8kF9jBDmvbop25CaIzdY1TBVlm9vBSeFcbCY+jDqbbMl9P0I+BGRo5Typ10VNf6
         vEaJXw/tYj+lMdJwVmBmbvz5cVBGVWcIS33R7fWGp+558HmOqb9zWh86CHFZvHd6rMMV
         12aGFVQ/PBBkK/HQv1QDNWj7L46WPZIu/BonmplI0uNQTEzi8a3cYkbJJXYfwKrkYJL1
         9jFVqzKCmM+OlKoqM1QMZz+J3iXMaDhOy6U8tr4+s4BbXWm1gDJ8OmRneL0cg1KyU8W/
         CDT/khrGAo9VrTUO96o2m7WK5zX8/OvI3whxUZJ+MZHP0R2gi7Kv1ACeEW5eNQHZXi7m
         zI7Q==
X-Gm-Message-State: ACgBeo3/fRatEG3SWBA5pxAvFU87fGfvfBN2/E6hfpTlEadUoIxp2m2n
        6MOc7jSv7ISzPdK8iWrjmr0=
X-Google-Smtp-Source: AA6agR7M/RDbrjBh3l4F2fsZrE2NDUtRkmRoJ2pWCjualnC33PiKbuaQG3wg+QxKonMWpCkV7enQog==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr6109095pfb.23.1659973743771;
        Mon, 08 Aug 2022 08:49:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a621506000000b0052d24402e52sm8793676pfv.79.2022.08.08.08.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:49:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <965b4295-6b39-cd77-ab76-47102ab5046e@roeck-us.net>
Date:   Mon, 8 Aug 2022 08:49:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: Remove redundant word in comments
Content-Language: en-US
To:     shaomin Deng <dengshaomin@cdjrlc.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808153956.8374-1-dengshaomin@cdjrlc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220808153956.8374-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 08:39, shaomin Deng wrote:
> There is a rebundant word "we" in comments, so remove it.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

I really wish there was a rule against such cosmetic changes. People
don't realize how much maintainer time is involved in reviewing and
applying that stuff.

Oh well.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/eurotechwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
> index ce682942662c..e26609ad4c17 100644
> --- a/drivers/watchdog/eurotechwdt.c
> +++ b/drivers/watchdog/eurotechwdt.c
> @@ -192,7 +192,7 @@ static void eurwdt_ping(void)
>    * @ppos: pointer to the position to write. No seeks allowed
>    *
>    * A write to a watchdog device is defined as a keepalive signal. Any
> - * write of data will do, as we we don't define content meaning.
> + * write of data will do, as we don't define content meaning.
>    */
>   
>   static ssize_t eurwdt_write(struct file *file, const char __user *buf,

