Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993150AA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441818AbiDUVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441808AbiDUVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:14:01 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE848E74;
        Thu, 21 Apr 2022 14:11:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q129so6956913oif.4;
        Thu, 21 Apr 2022 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=/AjoEgVDf2mTXrsJP1xowmDCmt1M0qlbGrVPHYyW9vY=;
        b=Qz0EREb/7rYwjbq7qPELalcO+7Niw+0QNqjUercWwpP8vdxBc07BfD/w1Jj9U7fLJW
         y5nPGfPM8jKAR19BfnGjk1cw9YTDCjIa7LArOvyKcX2OsmLTglimJmPMU+PhwPo4C0XH
         aDYmy96PCwM5v1rqWq80MFAuVUVDZJuBUcAAD77X8fJNbYSefVSpc8Xx7ZhQRtMowDaY
         mH8dT559y7Tbdw0ZTjGpz2ov2XlaA+umTwpvueUV9PsdbdO7rpAVknflviVdoIJj5Ide
         xfbMISy9MXdiPAklSbbpPAXNz6rIyJtB+5DgqqGTPhJ50enLZVw2EjR/c7W4Q++lWUWA
         RcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=/AjoEgVDf2mTXrsJP1xowmDCmt1M0qlbGrVPHYyW9vY=;
        b=dmup+z2gfdKMJ+Ok0YPhcflp8QEahJ/eCWI5MRmYmYzUBG6SJzEzqc+gMBSDBp/H4A
         /Twb9n+pkSzLlkLjjEQ2Hp/gI23Nt7qUer4zTQxLhpzLbyhXs+0Ohge9Z+8rgEsQz7hr
         u3xEfdyVcTUiK5BVzHtCUcqBXnkiGm3MzFp8KgA+v2uV3G7VIeAkA1gUIkfUu9HJJV+3
         3qNXiiw9hJ28P2/6RpyOPHR2dyTJsUPSxS4uvqjEgnep70cxna9mEjBVqK9J60+5CsXV
         Xp1QOTcEFCUJHPZ1nwq2cDwF6GBYFCJ/+xv4TFjK59Oic51Ov03ixx5aa85jsL+opnm/
         92Xg==
X-Gm-Message-State: AOAM531MQoesxO5u7QXJHoE9gwTs5tPeHXrngvQcjod7eFqJU+L9uc/T
        4c5Fbdw/qlxNoidf2zTTLNpRCZbLuQs=
X-Google-Smtp-Source: ABdhPJzIQCNHN5ni6FK2weLFRCyEQFnDGCu+BUpMpYpgO5uYpeBtY99+wov6R1HAIV9ycvnshusFhA==
X-Received: by 2002:a05:6808:f01:b0:323:b27f:e795 with SMTP id m1-20020a0568080f0100b00323b27fe795mr165573oiw.264.1650575469760;
        Thu, 21 Apr 2022 14:11:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fz13-20020a056870ed8d00b000e593f1f26fsm22366oab.18.2022.04.21.14.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 14:11:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bcb94cc7-b693-b6e5-6adb-d555ad4f543d@roeck-us.net>
Date:   Thu, 21 Apr 2022 14:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650550938-24608-1-git-send-email-liuxp11@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Watchdog: Checking timeout invalid if hardware heartbeat
 range is configured
In-Reply-To: <1650550938-24608-1-git-send-email-liuxp11@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 07:22, Liu Xinpeng wrote:
> The timeout should be invalid when it is out of the hardware
> timeout range.
> 
> ACPI watchdog: Using watchdog_timeout_invalid to check parameter
> timeout invalid
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> ---
>   drivers/watchdog/wdat_wdt.c |  3 +--
>   include/linux/watchdog.h    | 17 ++++++++++++-----
>   2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 195c8c004b69..d166d33ce7ae 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -450,8 +450,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>   	 * watchdog properly after it has opened the device. In some cases
>   	 * the BIOS default is too short and causes immediate reboot.
>   	 */
> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
>   		dev_warn(dev, "Invalid timeout %d given, using %d\n",
>   			 timeout, WDAT_DEFAULT_TIMEOUT);
>   		timeout = WDAT_DEFAULT_TIMEOUT;
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 99660197a36c..e82daeef0b26 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -167,6 +167,15 @@ static inline void watchdog_stop_ping_on_suspend(struct watchdog_device *wdd)
>   /* Use the following function to check if a timeout value is invalid */
>   static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
>   {
> +	/*
> +	 * If a maximum/minimum hardware timeout is configured,
> +	 * the timeout is invalid when it is out of the range.
> +	 */
> +	if (wdd->max_hw_heartbeat_ms)
> +		return t * 1000 > wdd->max_hw_heartbeat_ms;
> +	if (wdd->min_hw_heartbeat_ms)
> +		return t * 1000 < wdd->min_hw_heartbeat_ms;
> +

I have no idea what problem you are trying to solve, but this is
completely wrong: It defeats the purpose of having separate minimum
and maximum HW timeouts and configured timeout values. The watchdog
core takes care of those situations.

NACK.

Guenter

>   	/*
>   	 * The timeout is invalid if
>   	 * - the requested value is larger than UINT_MAX / 1000
> @@ -174,13 +183,11 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>   	 * or
>   	 * - the requested value is smaller than the configured minimum timeout,
>   	 * or
> -	 * - a maximum hardware timeout is not configured, a maximum timeout
> -	 *   is configured, and the requested value is larger than the
> -	 *   configured maximum timeout.
> +	 * - maximum timeout is configured, and the requested value is larger than
> +	 * the configured maximum timeout.
>   	 */
>   	return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
> -		(!wdd->max_hw_heartbeat_ms && wdd->max_timeout &&
> -		 t > wdd->max_timeout);
> +		(wdd->max_timeout && t > wdd->max_timeout);
>   }
>   
>   /* Use the following function to check if a pretimeout value is invalid */

