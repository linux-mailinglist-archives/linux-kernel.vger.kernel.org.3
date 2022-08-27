Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDA5A3960
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiH0SAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH0SAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:00:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5893E759;
        Sat, 27 Aug 2022 11:00:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u6so5580882eda.12;
        Sat, 27 Aug 2022 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=35c4+qpZ3c/mnDdsvmqY7PyVUwNZT2G1anxf++wtomc=;
        b=MpGj9NOCcs0MUiC5UVbBgEYP7Pk8D1XeoHudjO7GO/wykd1C9HflcupQW4AR4UJpEG
         9KdE6Sq5SK0Lik8hYudjrZIqU2ZvFAL8f4vF2AfklIBFprDxpjWf+hY8ooWKm6FMheDQ
         5cla3fV/CH49kqdQ7hAsjmLpeOa9RRtylyNznZGThlnedlNVh3UTHMKZRuj/r2hi5lEM
         jtLg9Hlf1nlhNZU7WTDaT6/EqvIXAdDWXMSAJBb/ZMZoNMCBAGbQSTwZZuTgYLyHa1in
         FTDrLO8iOA9qq45rNk2i0YJYYGRf0q/kTUZJE8d1favDfB5YiV09Vfw5j56iMQO+XWBR
         FnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=35c4+qpZ3c/mnDdsvmqY7PyVUwNZT2G1anxf++wtomc=;
        b=DR7ISJe9JGLD719rit66KCOjvpAQIUeQUIzNQEHIGoAxEqdZ0iOGrQCy0338FkTw5Q
         cP48neZQlVbXqBqQK9UZogh6JuYyy+K/wE9hqSVPDAgwHOHFt51F4XrUJ9Tzc+B0UOEL
         Z81WM85Dj10IJf/jgRVlLAGFYkqcqcTlwL1DyzYkIqkQsj81UiCa+J+Gx/5fw8arZTcM
         veszdWFTfULCDR9TIb1Q+gzXG+j0+SsgFF3SOTQfpctghEKz/t1DvUCUY1XR4Z6bN6Zk
         fsHzO6rn1H/PgftJXkPkJFz73hbI3lAG2MxtbdkhW9jNpRj2pFYBM/T1kPVnmOoURBFh
         IKWQ==
X-Gm-Message-State: ACgBeo1FGXUaSaewHl+OIgt2w1pvqRAq3Y5DCSrIKNLXszM3mic+RNhL
        rUXn9ADrTpqqsy+I6MdguBA=
X-Google-Smtp-Source: AA6agR5OVWys2umL1veKUwoXDOOo6bNvfIUQ0xLAInKMCUIC/mFbw0RzAcIBNZq5bZVDdd62RYSWBA==
X-Received: by 2002:a05:6402:524a:b0:43d:aa71:33d8 with SMTP id t10-20020a056402524a00b0043daa7133d8mr11141177edd.33.1661623202390;
        Sat, 27 Aug 2022 11:00:02 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id r13-20020aa7d58d000000b00447c89a63f4sm3096870edq.35.2022.08.27.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 11:00:01 -0700 (PDT)
Message-ID: <664df6a1-cb83-4d28-7b2a-9fc69d24e6b8@gmail.com>
Date:   Sat, 27 Aug 2022 20:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] MIPS: BCM77xx: Fix comments typo
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, hauke@hauke-m.de,
        tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220827155306.11757-1-dengshaomin@cdjrlc.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220827155306.11757-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.2022 17:53, Shaomin Deng wrote:
> Delete the unneeded word "that" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>   arch/mips/bcm47xx/prom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 0a63721d0fbf..bcb9c90ea041 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -69,7 +69,7 @@ static __init void prom_init_mem(void)
>   	 * call them at the beginning of the boot.
>   	 *
>   	 * BCM47XX uses 128MB for addressing the ram, if the system contains
> -	 * less that that amount of ram it remaps the ram more often into the
> +	 * less that amount of ram it remaps the ram more often into the
>   	 * available space.
>   	 */

Are you sure you based your work on the latest mips tree? Please double
check that.

Also please read that sentence after your patch. Hint: that extra "that"
wasn't actually a simple duplication.

Finally: this isn't BCM77xx patch as stated in your subject.
