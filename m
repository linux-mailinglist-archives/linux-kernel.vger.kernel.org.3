Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8B46E163
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhLIECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhLIECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:02:17 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0FC061746;
        Wed,  8 Dec 2021 19:58:44 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so7048873oij.1;
        Wed, 08 Dec 2021 19:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FaNr5YpV3b9KhYBGKBKxUsZpHbcVFXKHi9EpoLTa4Ss=;
        b=EGA5dSqu1WvDwLqrGwAptMP2RFJnIirt8iHm+2cW+27Awc1zJ/WPF3QbO9c4wS/Dkp
         pnBGzBd2ndq4xXW0JMhp3ZIqBX7nuBsTw8qxG/DbWv14Uvckrcg4TREt/M6JYZIn+X1C
         sYKmUQrn8MzT3t63ADIaWq78QKuXX/N0sWcbpEt40FrR83I2PM99houMLnCDcgLsVOlU
         bhtHCsDXo3JMAn0mXzWCuJfOLHAqm8PpgjyXserNSoxifegOGmLZlikXS2GDBEILpB11
         vNSobtWFKt70yCaPAx0UWvTgk6YtKyF98fljGrd49m9UdQfovNfqNUMOQVELt/8bvrgN
         FM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FaNr5YpV3b9KhYBGKBKxUsZpHbcVFXKHi9EpoLTa4Ss=;
        b=P1Eh30Z8twC7s0NsZHqi7U7nJoEXuKCUTMv7bZqvTn5ol9FQiQEVbZaJAGK5zAwfGN
         0CPxNOl2E65SyGNLKcquoJHwpS6bc6ooZ+oBi4ie9UKt0KyYwONCqxAYInP9nuER1XGX
         MPDkemRmO+4pVtHjD+Fvzh0p8znLBpVc4hKbbiM9wKxsKyv0XqJalxpWMEbZXrIqI+sU
         ZMmewQ/bHZdIT41xZC/YByfVZb8jxjq9v2mCXmA6813JOCSiL0eg4JR8A5kOzwNZ+qvd
         HBtwSzXlfmhFfA1cdUvmAJ0A84oQc03rT1XEBg5lJwKp6oJ20cv4Y4GzejKJdB9NnKeR
         64/Q==
X-Gm-Message-State: AOAM5312bGHDE5BZ3Vxg9YUxDfy54WkgeJszR0jOlF1IIk+OS3e3SMms
        MPUDcxrVJp2qnTSDecjkn/k=
X-Google-Smtp-Source: ABdhPJyalaUvjdgUP09DhHVCi+lF9iI3uG7S5pFHbt/d4JNObnpX6tZMPHxGeOTQmpy8xgl0uc54Lw==
X-Received: by 2002:a54:4e0c:: with SMTP id a12mr3667808oiy.12.1639022323791;
        Wed, 08 Dec 2021 19:58:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9sm986974oij.16.2021.12.08.19.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 19:58:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] drivers:watchdog:remove unneeded variable
To:     cgel.zte@gmail.com, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
References: <20211209015353.409612-1-chi.minghao@zte.com.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <43c04d21-2d05-ced2-5f32-4310fca67dde@roeck-us.net>
Date:   Wed, 8 Dec 2021 19:58:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209015353.409612-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 5:53 PM, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
> return value form directly instead of
> taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>

No, this is an old watchdog driver. Functional fixes for those only, please.

Guenter

> ---
>   drivers/watchdog/pcwd_pci.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> index 54d86fcb1837..edbc0f28d399 100644
> --- a/drivers/watchdog/pcwd_pci.c
> +++ b/drivers/watchdog/pcwd_pci.c
> @@ -215,10 +215,7 @@ static inline void pcipcwd_check_temperature_support(void)
>   
>   static int pcipcwd_get_option_switches(void)
>   {
> -	int option_switches;
> -
> -	option_switches = inb_p(pcipcwd_private.io_addr + 3);
> -	return option_switches;
> +	return inb_p(pcipcwd_private.io_addr + 3);
>   }
>   
>   static void pcipcwd_show_card_info(void)
> 

