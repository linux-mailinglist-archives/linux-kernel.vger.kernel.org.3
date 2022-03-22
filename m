Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2EA4E37EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiCVEcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiCVEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:32:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3511C16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:30:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bc27so11781291pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aHNQ24PWiPjii6F5lkM3fKzrkShIeqqIUDEofSLJIto=;
        b=eOPIZw6UeU1k5ngrdt8Ghoc3fF1MCx8GDFYmjZHl1yJJV/CqC9U56k5j1lYfZ4ugl9
         +c3+cfuxLKJDsYidpaWnwLHKP72/0yWOIwU7I+2lkvKltjP2O3zQodOU0XqFmCW/vGg3
         Uhg8VElhMz6JWo1Iib2B3Q5H4Cevqb+Df3leDeGpSgGQsj169if5vaJK1RHJRl+CRNzU
         9uHiPffOaUgl/BJlnTeosGZ9XPzk99F+wuX4W6hf8NA8Y8PK7aLK6iACMgIqPWcPcQq0
         ZSj/fI+8WnwjDKq1esfiBuaLKfH5ipuKupvaIw3ClQ8kv6Ddm9PdrVWrXOsdqMcizAL6
         D56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aHNQ24PWiPjii6F5lkM3fKzrkShIeqqIUDEofSLJIto=;
        b=kVNYwwg7zzisbNr85HNU1fXPbc7cebuJWX/fGyD29Z1eiIiwfy6VBuwxkPccOew247
         d0cLUe3vzCDct+9RcLvpK/ZGnJhew2NgQfQejxfx0A1TOIDPel3yNxUDenCfmTzsqx3w
         M9ScQ/pj0HrrpqdPF3mHR5ML3NaLGm+ENIXvqyhhdpnvk3UnhwMBRPaua9vqCoGjWTxl
         OYqBTqqB4tEWfgk1lddZLujXt3v6aasI7p3e5Xk2k3gniDw7gpCMqvcpxRKnwvjpKp1F
         uorfo1eWG5fnDID0YBJrvNz4O723xv1Oxg7xHT7qpJurgGKzZgZbNgKI61/9idmPrcEv
         GCKg==
X-Gm-Message-State: AOAM533o0YUDtsYlezar7DCSBwpoWd88xwEK0hQJYNso81tdH0Dp6s4h
        KADykU7Q4S1NtAaOZoz+SAk=
X-Google-Smtp-Source: ABdhPJynC+Dxfbf4XOsFfakoXjYdBPUwanv3IemaVPMlWaytEYdm9ih0AbVD33vrWon8J+ZhxuMlQQ==
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id f144-20020a623896000000b004f787dcde5bmr27534389pfa.49.1647923434419;
        Mon, 21 Mar 2022 21:30:34 -0700 (PDT)
Received: from [192.168.225.67] ([157.49.254.255])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004f757a795fesm21071279pfc.219.2022.03.21.21.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 21:30:33 -0700 (PDT)
Message-ID: <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com>
Date:   Tue, 22 Mar 2022 10:00:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220318101440.13887-1-skumark1902@gmail.com>
 <YjRswrHu0JUm9331@kroah.com>
From:   Sathish Kumar <skumark1902@gmail.com>
In-Reply-To: <YjRswrHu0JUm9331@kroah.com>
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

On 18/03/22 4:58 pm, Greg KH wrote:
> On Fri, Mar 18, 2022 at 03:44:40PM +0530, Sathish Kumar wrote:
>> This patch fixes the checkpatch.pl warnings like:
>> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
>> +   u8 blnEnableRxFF0Filter;
>>
>> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
>> ---
>> Changes in v2:
>>      - Remove the "bln" prefix
>> ---
>>   drivers/staging/rtl8712/drv_types.h   | 2 +-
>>   drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>>   drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
>> index a44d04effc8b..4de3aad08242 100644
>> --- a/drivers/staging/rtl8712/drv_types.h
>> +++ b/drivers/staging/rtl8712/drv_types.h
>> @@ -157,7 +157,7 @@ struct _adapter {
>>   	struct iw_statistics iwstats;
>>   	int pid; /*process id from UI*/
>>   	struct work_struct wk_filter_rx_ff0;
>> -	u8 blnEnableRxFF0Filter;
>> +	u8 enable_rx_ff0_filter;
> Shouldn't this be a boolean?
>
>>   	spinlock_t lock_rx_ff0_filter;
>>   	const struct firmware *fw;
>>   	struct usb_interface *pusb_intf;
>> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
>> index acda930722b2..69d3c55ee9e5 100644
>> --- a/drivers/staging/rtl8712/rtl871x_cmd.c
>> +++ b/drivers/staging/rtl8712/rtl871x_cmd.c
>> @@ -202,7 +202,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
>>   	mod_timer(&pmlmepriv->scan_to_timer,
>>   		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
>>   	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
>> -	padapter->blnEnableRxFF0Filter = 0;
>> +	padapter->enable_rx_ff0_filter = 0;
>>   	return _SUCCESS;
>>   }
>>   
>> diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
>> index 90d34cf9d2ff..d58ae5b387d4 100644
>> --- a/drivers/staging/rtl8712/xmit_linux.c
>> +++ b/drivers/staging/rtl8712/xmit_linux.c
>> @@ -102,11 +102,11 @@ void r8712_SetFilter(struct work_struct *work)
>>   	r8712_write8(adapter, 0x117, newvalue);
>>   
>>   	spin_lock_irqsave(&adapter->lock_rx_ff0_filter, irqL);
>> -	adapter->blnEnableRxFF0Filter = 1;
>> +	adapter->enable_rx_ff0_filter = 1;
>>   	spin_unlock_irqrestore(&adapter->lock_rx_ff0_filter, irqL);
>>   	do {
>>   		msleep(100);
>> -	} while (adapter->blnEnableRxFF0Filter == 1);
>> +	} while (adapter->enable_rx_ff0_filter == 1);
> Ah, that's funny.  It's amazing it works at all and that the compiler
> doesn't optimize this away.  This isn't a good pattern to use in kernel
Do you mean the following code is not a good pattern in kernel?
do {
msleep();
} while(condition);
> code.  I know it's not caused by your change here, but perhaps you might
> want to fix this up to work properly?
>
> thanks,
>
> greg k-h

Do i need to replace the above code with some other mechanism?

If yes, please let me know which mechanism i should use? Or what should 
I do here?

Note : I am new to Linux kernel development and looking forward to learn 
and contribute.

Thanks,
Sathish
