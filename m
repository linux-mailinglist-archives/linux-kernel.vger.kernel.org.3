Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705358C7BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiHHLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiHHLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:42:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968413E1C;
        Mon,  8 Aug 2022 04:42:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm17so8521404pjb.3;
        Mon, 08 Aug 2022 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=CAXKPBRSJJZxpgL9F9euR0RzRYxIEFUL7AVsfCxiNjo=;
        b=ZbcB/evA4vMyAmaWpXUugtaUUwaR6AfnVy1iOdCqFQUawXBJ5H84pN+tdAlDUALx1M
         ygtK6alLmDc8jXUlOlpsiznL9UpWmggLuXmkhBk5jlIBKiN38y0v4TcspciIfNle+7JR
         yJiHosnFFaVlglGGzdfcvfBascHG5WxT7zG/QkqMlEz2O/o1ekdvbHk2zNEiTAFese/v
         7aWeMEr8RXCiMWez3FoQI62lqLl39Bqq9/O2tOM+ScL//D9ck4Kc5CDtzay+ehx1VVXe
         WTdFsEwHv/5fLa1aFxTPHMNWajkVTwddkceVQ6dfZSKEoRbz70gU3ZwwWtk59RTQEy/P
         1rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=CAXKPBRSJJZxpgL9F9euR0RzRYxIEFUL7AVsfCxiNjo=;
        b=faXsI8FMY2EbyDcU9vxkC6UrImiWppDBSDLgbSN7QW3SI6JG1py3YBSiPafZsRkL7M
         L1J3Z72zE0sTzTX/rBZy/SGHOi8w3FgTsMhSD71ANgwL7dMA5wGTbXN+QqSPJVPeLkWJ
         BpSObRvl8LAex7eWTv6tQ9BY9zlhK5fBEINpdj1msIae9bT/0lUZVtcPMFYDY0qldJeO
         5OK532rqRsX5IcBrJjf/cRZrLKrmfmtgsht9ldvPTfdHERZnALwsUz7gI61aDnKaDp2Q
         VO6nQBCqWwpVlWpocf28w7jOjmVrCd6LHiUMTO0kKv2gQzHcbyOMG+gkOM7Zg+2sgCKS
         oUKw==
X-Gm-Message-State: ACgBeo3Rqn0nedUrguN8rjXkVpsev2mOLSuWjLbnuQ7LAX6AgQzl+nv+
        GAz3wgkHWGyl7xyEiQcmHQo=
X-Google-Smtp-Source: AA6agR461YZz+qq+U8tX/kImBoQQOfYiOnTotTXC/c3cOqNmIIQJ8Rw5xMSDVfbSNxNzTFHU92Xdsw==
X-Received: by 2002:a17:903:1103:b0:16c:9a6e:d54 with SMTP id n3-20020a170903110300b0016c9a6e0d54mr18040260plh.131.1659958950485;
        Mon, 08 Aug 2022 04:42:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b0016d9b101413sm8434265plb.200.2022.08.08.04.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:42:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6bcb786f-1aa0-2fd6-50eb-e1db8ce70ebe@roeck-us.net>
Date:   Mon, 8 Aug 2022 04:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20220806081524.5636461a@endymion.delvare>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: wdat_wdt: Set the min and max timeout values
 properly
In-Reply-To: <20220806081524.5636461a@endymion.delvare>
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

On 8/5/22 23:15, Jean Delvare wrote:
> The wdat_wdt driver is misusing the min_hw_heartbeat_ms field. This
> field should only be used when the hardware watchdog device should not
> be pinged more frequently than a specific period. The ACPI WDAT
> "Minimum Count" field, on the other hand, specifies the minimum
> timeout value that can be set. This corresponds to the min_timeout
> field in Linux's watchdog infrastructure.
> 
> Setting min_hw_heartbeat_ms instead can cause pings to the hardware
> to be delayed when there is no reason for that, eventually leading to
> unexpected firing of the watchdog timer (and thus unexpected reboot).
> 
> I'm also changing max_hw_heartbeat_ms to max_timeout for symmetry,
> although the use of this one isn't fundamentally wrong, but there is
> also no reason to enable the software-driven ping mechanism for the
> wdat_wdt driver.
> 

I dislike this part because it changes behavior and is unrelated to
the problem at hand, but I assume Mike knows the actual hardware limits
and understands the implications (ie that there is indeed no need to
enable the software-driven ping mechanism).

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Reviewed-by! Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
>   * Fix a stupid typo which broke the build. Apparently I shouldn't be
>     sending out patches after midnight, sorry.
> 
>   drivers/watchdog/wdat_wdt.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-5.18.orig/drivers/watchdog/wdat_wdt.c	2022-07-27 07:32:33.336928967 +0200
> +++ linux-5.18/drivers/watchdog/wdat_wdt.c	2022-08-06 08:09:49.235935543 +0200
> @@ -342,8 +342,8 @@ static int wdat_wdt_probe(struct platfor
>   		return -EINVAL;
>   
>   	wdat->period = tbl->timer_period;
> -	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
> -	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
> +	wdat->wdd.min_timeout = DIV_ROUND_UP(wdat->period * tbl->min_count, 1000);
> +	wdat->wdd.max_timeout = wdat->period * tbl->max_count / 1000;
>   	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>   	wdat->wdd.info = &wdat_wdt_info;
>   	wdat->wdd.ops = &wdat_wdt_ops;
> @@ -450,8 +450,8 @@ static int wdat_wdt_probe(struct platfor
>   	 * watchdog properly after it has opened the device. In some cases
>   	 * the BIOS default is too short and causes immediate reboot.
>   	 */
> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +	if (timeout < wdat->wdd.min_timeout ||
> +	    timeout > wdat->wdd.max_timeout) {
>   		dev_warn(dev, "Invalid timeout %d given, using %d\n",
>   			 timeout, WDAT_DEFAULT_TIMEOUT);
>   		timeout = WDAT_DEFAULT_TIMEOUT;
> 
> 

