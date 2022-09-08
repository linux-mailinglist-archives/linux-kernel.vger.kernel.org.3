Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133045B2524
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIHRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiIHRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:49:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3C19014;
        Thu,  8 Sep 2022 10:49:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 65so8450564pfx.0;
        Thu, 08 Sep 2022 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=6tvs4ayRExWvRUyu07Fc3dE/Ryea2CBbaJjmdbcY3zQ=;
        b=N9miSMEMgSmCGbHiQdE2LfUCX1ihj9UQdDXy4wUwvgQqAgT6c89By9B32Yr7ks4QW/
         kQ3r/GzhvTa+Qg8BbYzGl6AyHpJC846e6qN6kwPlHLifQDD2x4FUCdTpgvksa6uWVXcD
         hqNSr6yBzrXOpZ+L4PDO2vHgKyP9tpNtRpC0Hz/Q72HoumSKIVl0V1wYsTwRdY9xI42q
         VodiYMH0Gr7pg5pHaGd77fxN8sKYs6l3AOENeIXSIhU/uMbUuw829uxlnSnNtndJsT7b
         Aozkj+v0mARSnpsxipaFS3n/8JN/9DFfgycFsbUcAFTWHvb2qlaGj3EGU36VsVJcMwSm
         J6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=6tvs4ayRExWvRUyu07Fc3dE/Ryea2CBbaJjmdbcY3zQ=;
        b=XJumLrWSRotl32LB0dne57GZ30vrfIj818lWA1JKc4uhROHvROC77nKP8SsDke36qu
         psD9+rzAG3jom9pi83kBlUUc5JiQxWa3TweB6Su91JaKwTqCHi3ZtbvklIRGcS0JdJuA
         V+Sv2SA2qPEuA+pmAkJZpXqRPsXo+sjBMYS9706/1+WZbLerw7WBMxSMjedbJi9BbIIj
         JsvdlncGHA5RF9kAOQAEdoPISqLHI9DvpXLthEQMsQV6sLncZemkVrI9vypqNWWNFPnP
         vyYhvy6SibD6T1T6T/ZEB1DgkMtOQwlLE714xjFOCZWPRoIn6oxCSmRDmqiTxEQLTely
         zYXw==
X-Gm-Message-State: ACgBeo37nmweAf0LArC+UidGvALRgdWN3bYcs4If4HQZ2DvBQi6C8njz
        d+6XJBnkyZWl6o87qyCyIamClMCg3S4wJg==
X-Google-Smtp-Source: AA6agR4rP0sq0eTqJnNeFCoLicuac5FawsgASHi+dty/arH6J/GnQ6Y3EXP1Dq4hyzo0M3jlr3GItQ==
X-Received: by 2002:a63:4519:0:b0:434:ae87:ca5b with SMTP id s25-20020a634519000000b00434ae87ca5bmr8796465pga.194.1662659375463;
        Thu, 08 Sep 2022 10:49:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a300b00b002005c3d4d4fsm2032943pjb.19.2022.09.08.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:49:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <35ed4d8c-21c3-fd1f-bbab-fa826c33adab@roeck-us.net>
Date:   Thu, 8 Sep 2022 10:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 13/19] watchdog: booke_wdt: Replace PPC_FSL_BOOK3E by
 PPC_E500
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
 <015ac5217fd0f061e98df9cf98bce515855f2bc3.1662658653.git.christophe.leroy@csgroup.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <015ac5217fd0f061e98df9cf98bce515855f2bc3.1662658653.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 10:37, Christophe Leroy wrote:
> CONFIG_PPC_FSL_BOOK3E is redundant with CONFIG_PPC_E500.
> 
> Replace it so that CONFIG_PPC_FSL_BOOK3E can be removed later.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig     | 8 ++++----
>   drivers/watchdog/booke_wdt.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9295492d24f7..b7c03c600567 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1935,10 +1935,10 @@ config BOOKE_WDT
>   config BOOKE_WDT_DEFAULT_TIMEOUT
>   	int "PowerPC Book-E Watchdog Timer Default Timeout"
>   	depends on BOOKE_WDT
> -	default 38 if PPC_FSL_BOOK3E
> -	range 0 63 if PPC_FSL_BOOK3E
> -	default 3 if !PPC_FSL_BOOK3E
> -	range 0 3 if !PPC_FSL_BOOK3E
> +	default 38 if PPC_E500
> +	range 0 63 if PPC_E500
> +	default 3 if !PPC_E500
> +	range 0 3 if !PPC_E500
>   	help
>   	  Select the default watchdog timer period to be used by the PowerPC
>   	  Book-E watchdog driver.  A watchdog "event" occurs when the bit
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 75da5cd02615..932a03f4436a 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -27,7 +27,7 @@
>    */
>   
>   
> -#ifdef	CONFIG_PPC_FSL_BOOK3E
> +#ifdef	CONFIG_PPC_E500
>   #define WDTP(x)		((((x)&0x3)<<30)|(((x)&0x3c)<<15))
>   #define WDTP_MASK	(WDTP(0x3f))
>   #else
> @@ -45,7 +45,7 @@ MODULE_PARM_DESC(nowayout,
>   		"Watchdog cannot be stopped once started (default="
>   				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
> -#ifdef CONFIG_PPC_FSL_BOOK3E
> +#ifdef CONFIG_PPC_E500
>   
>   /* For the specified period, determine the number of seconds
>    * corresponding to the reset time.  There will be a watchdog
> @@ -88,7 +88,7 @@ static unsigned int sec_to_period(unsigned int secs)
>   
>   #define MAX_WDT_TIMEOUT		period_to_sec(1)
>   
> -#else /* CONFIG_PPC_FSL_BOOK3E */
> +#else /* CONFIG_PPC_E500 */
>   
>   static unsigned long long period_to_sec(unsigned int period)
>   {
> @@ -102,7 +102,7 @@ static unsigned int sec_to_period(unsigned int secs)
>   
>   #define MAX_WDT_TIMEOUT		3	/* from Kconfig */
>   
> -#endif /* !CONFIG_PPC_FSL_BOOK3E */
> +#endif /* !CONFIG_PPC_E500 */
>   
>   static void __booke_wdt_set(void *data)
>   {

