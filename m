Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0846FD41
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbhLJJFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:05:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42766C061746;
        Fri, 10 Dec 2021 01:02:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso6743468wmh.0;
        Fri, 10 Dec 2021 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MdaIHZ5/pQUfuGiEbbFFG6tuVAMBcF8aqzVNiDnYLAI=;
        b=HVqhMJozw4/HA5ahMts87Vgd5EyYJ0Xg/9CpeIPW28V9VHSU0GrzAFeASscfvCPRUS
         cKBsaqtTl5/tDZg+v7kAoR4u5ovxHSeMNqiRXgPSUP6vT3vLR3lmbuKN7YVIQ5VXVDQo
         PIncURH3wTIjoWe33ZQzxmeaC6KdksmzVa81/b7EDmlxpZjqj3UYIN8AN+Yk9LgE0f+W
         TXVa/619REDJ11tIIYLJElE5bpYlZIGjylgCzFUG/KusQ9JwXLETmLOXzz8zwW6ycrGe
         SH6kF+ynZKkFvJWPla2rft2yQB0DROiOzonQPWeCLdueIQof+/8GigLDO+tcHU7GmJh8
         wMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MdaIHZ5/pQUfuGiEbbFFG6tuVAMBcF8aqzVNiDnYLAI=;
        b=Ze4MAtf961XpS+wMmoQMmCvjjDUbMZErBBQxIGw3rjqMRg+oQ82lRvdRDiTq3U57IU
         5aiYnsfooHKVDy87nDc8DRu7gqtDa+coSfO6dQMpkMdt0H2xj3fQRQwUh3LMsk14tuyG
         LkWKM+RW1yqNGDPZDY8xky2vkqSSi6MbHOUl5gn/TyKXqxBRNAAnvfDozywx3e+GlQUw
         rpYNzb75MsiIuBWP5mN1fNWtLSnZ3G4wlaDP4uKwu9JLCyMVoEXHK+EqnGQu+H28wxka
         10AUyKLaYUjElwts/GLUmSBSPSjeo6rRy9lsAJ/0ZJD52cp9uwGHKdjlmx5gdZTlSyee
         qK7A==
X-Gm-Message-State: AOAM533onuHF85Fm7jueIBBdM24OV9QDmDmv6V8WKU7/sCkzgRWOMj3p
        IAZB1mm77ZwJRuqTZEuxQ6PZOj/8+kDA9UJW+QAMRg==
X-Google-Smtp-Source: ABdhPJxAm9AhRn7Sc1V5eDL7G9+DTtw3mEtlhENMgURGLeNCEojPRJ94fCYOSclt0IH5JJWoIEzOkg==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr14907617wmh.140.1639126936816;
        Fri, 10 Dec 2021 01:02:16 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id m14sm2715410wrp.28.2021.12.10.01.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:02:16 -0800 (PST)
Message-ID: <a51bc835-f707-7ba6-5112-20592bb3ca31@gmail.com>
Date:   Fri, 10 Dec 2021 09:02:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] pwm: atmel: remove redundant initialization of variable
 timeout
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211210002250.639251-1-colin.i.king@gmail.com>
 <20211210074536.lawpsch2i5bwyew7@pengutronix.de>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20211210074536.lawpsch2i5bwyew7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 07:45, Uwe Kleine-König wrote:
> On Fri, Dec 10, 2021 at 12:22:50AM +0000, Colin Ian King wrote:
>> The variable timeout is being initialized with a value that is never
>> read, it is being re-assigned the same value later on. Remove the
>> redundant initialization and keep the latter assignment because it's
>> closer to the use of the variable.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/pwm/pwm-atmel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 98b34ea9f38e..8e00a4286145 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -271,7 +271,7 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			      bool disable_clk)
>>   {
>>   	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>> -	unsigned long timeout = jiffies + 2 * HZ;
>> +	unsigned long timeout;
>>   
>>   	atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Did you spot this by using some static checker? If so, maybe attribute
> it in the commit log?

Just clang.

> 
> Thanks
> Uwe
> 

