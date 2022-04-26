Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C050F95B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbiDZJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346374AbiDZJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:50:24 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE951706A;
        Tue, 26 Apr 2022 02:06:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e93bbb54f9so6043151fac.12;
        Tue, 26 Apr 2022 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/8CJOcRMC/+Ze1ZomK+op5ZEpKGog23MseqwIaYFo1c=;
        b=nryeHUFEZKulCcBcUOlXnS9PRdgCz8nY/r6qFM3lvdR/khKmteFDmqMYo0YRGR/qoh
         oNokFOYezRISj+Ww+jNHUamzArIQ6MUeY4xOX9l+33Z1jVXmrV+tXm7nsvPPEicewG/j
         mcTf6LoZOGHiDP/vfsw9tm/gYNFtdpBOgDalZ9P5RiZDR0TJFhhDzv7rwCxgappT20ff
         4KQUR7ssNjO4ZclrE3GhdLKZe95B8Sp8X0zqvRyak+SmIEM/aEHHaaab2cWSqIy9Tywi
         hq1zkM3r/otGGwmdw9RefTGBzcU7GAXbyxVX00b6czU3isx2i8ktDzBjqiog0/iivtqh
         xx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/8CJOcRMC/+Ze1ZomK+op5ZEpKGog23MseqwIaYFo1c=;
        b=NDoMYrZD1v40ReG5HBJirSZuVKyqIgqaRJ5ThthuWd4sfu44vM8i1WNhKAOvWneDJ2
         xdqF0dRuibhG8wk1v3L8DfmY8qkfjleL0jYps8IBn1ZQ/13zNnqqryjYRelK8iMolJXP
         qU/60361zndFfyCN2GwqTeufKV8WY02jKUXtHQ2ARNzvsMmu6DRADbhFglDPoQBmTo+X
         6NpUK49M7SgPdmRaPzSlZgRFU+0tKa3W3MxQ9tGUfTQvadDT7W9ilUMxPsaV5J/uYiva
         JrsDkiQWF84QQOLKacdtcezOMVhhc6IwPeDTwc69y76v9DNFlRiCHbVSwGRLDTZiUWnh
         3lNQ==
X-Gm-Message-State: AOAM530rxXfyY89cpHv2wBCaB8j8NVkvyTKTPnhdExFa7FaEblBxDoYH
        OFA7IT28kEOkFrmUEDTXtbY=
X-Google-Smtp-Source: ABdhPJwE3hRrAEh6mxcivfgynEZ4NGSZKT8P5mB6bQ3UKr53yHSIJebFG2KZbi6RfqqZ/lNiAu1P0A==
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id u1-20020a056870420100b000e647c4e104mr12514254oac.257.1650963988050;
        Tue, 26 Apr 2022 02:06:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2-20020a056870d30200b000e92295f8acsm614215oag.2.2022.04.26.02.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 02:06:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7300d2b7-ab2d-ddae-199a-335bec9c5db2@roeck-us.net>
Date:   Tue, 26 Apr 2022 02:06:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org,
        tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650962589-1992-1-git-send-email-liuxp11@chinatelecom.cn>
 <f07ef9bd-2a1d-6aec-a490-4c419ca0daab@roeck-us.net>
In-Reply-To: <f07ef9bd-2a1d-6aec-a490-4c419ca0daab@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 02:00, Guenter Roeck wrote:
> On 4/26/22 01:43, Liu Xinpeng wrote:
>> Context: If max_hw_heartbeat_ms is provided, the configured maximum timeout
> 
> I am quite sure I asked you to drop "Context: " and to change "existed" in
> the subject to "existing".
> 


Also, I asked you to separate the iTCO patch from the wdat series, not this one.
Why did you send this patch not as part of the other patches for the same driver ?

Guenter

> Guenter
> 
>> is not limited by it. The limit check in this driver therefore doesn't make
>> much sense. Similar, the watchdog core ensures that minimum timeout limits
>> are met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid()
>> makes more sense because it takes this into account.
>>
>> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
>> ---
>>   drivers/watchdog/wdat_wdt.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
>> index 195c8c004b69..9db01d165310 100644
>> --- a/drivers/watchdog/wdat_wdt.c
>> +++ b/drivers/watchdog/wdat_wdt.c
>> @@ -55,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>>            __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>   #define WDAT_DEFAULT_TIMEOUT    30
>> +#define WDAT_MIN_TIMEOUT     1
>>   static int timeout = WDAT_DEFAULT_TIMEOUT;
>>   module_param(timeout, int, 0);
>> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>>       wdat->period = tbl->timer_period;
>>       wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>>       wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
>> +    wdat->wdd.min_timeout = WDAT_MIN_TIMEOUT;
>>       wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>>       wdat->wdd.info = &wdat_wdt_info;
>>       wdat->wdd.ops = &wdat_wdt_ops;
>> @@ -450,8 +452,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>>        * watchdog properly after it has opened the device. In some cases
>>        * the BIOS default is too short and causes immediate reboot.
>>        */
>> -    if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
>> -        timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
>> +    if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
>>           dev_warn(dev, "Invalid timeout %d given, using %d\n",
>>                timeout, WDAT_DEFAULT_TIMEOUT);
>>           timeout = WDAT_DEFAULT_TIMEOUT;
> 

