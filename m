Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F847C87D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhLUU6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhLUU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:58:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89A6C061574;
        Tue, 21 Dec 2021 12:58:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j21so52078edt.9;
        Tue, 21 Dec 2021 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lZWV4JsmHiz3iWhVX2mba69dCvhyd5hfpxjg0TGxohc=;
        b=nC2G9M3lJy52x91DXQEqYZqFy/ZgacnDvk7O/mFnNbajuIqcH1tA8QkS+TzMUEb/7U
         dsXtZd/ys9uzwr1x5Xs1uzo5OSq+TCb31CDP1ln2XXdwI5goMm93G1MJpM28SaXQXlLH
         5YwUdhChkjMSBuKZvicKXcvWOU3WzfwIO3QP39E9fMxuSDZrAPKhfb3EJ4SVa8/sY6FN
         jckNixg99Qmmg6h3Yl7cLxzbsT+h/GwJp+MlJwpCBrqnb5ajGEjswY1n6/nPp+bZs4Ze
         Yv6dj9rX0ni+r9ek5cu2XjgFzQAALIdTPvYYnxrJ5HnOZywxk5s8gShuYtVly0V3HhcW
         KV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lZWV4JsmHiz3iWhVX2mba69dCvhyd5hfpxjg0TGxohc=;
        b=Jp6MungW+BrDIPV/ETWq1jHLKrqDMPYfDMf8hLa5woCzGndKRsmINoQIhkAoyf4H4V
         oZdPOHS48IDeG43BqYLekxe9SaUxejh4JvTkrPcGCwj0/DTtaT+KZtxrfAsrMh65c0St
         uetASjnbEPcZNvdSS3j19PzbmPBwaLFUE3HnguVpZdlmiBb1yvG+x3/p/u6Br9Edqy+T
         DcC9Hwam7y8V7J6s4m2Y5X2dzQV46mli2UmuXyfTVIO6NcAOeFxjpRUKwhYCelnEK8ie
         +rXvuDB2N7KjGeY5WA7lWkGZRND2HLmghAX7qHdLDsPtEstjQHl0qqLFIk7DqgkKhb1w
         H5mw==
X-Gm-Message-State: AOAM530sIii96Nwcwr090WF8BvKWjHd9FekWyUiwpuyz99Qlgxs223Wa
        80yjye4BCGx/q4nS4zsPtjI=
X-Google-Smtp-Source: ABdhPJw3lNRXPxKjZNENBDnkJ2dj2erIwSj1Uu0pHCU7uiB+bOWqYGV5hliTLot6kFhy5d+Ob1r1Ig==
X-Received: by 2002:a17:907:94c9:: with SMTP id dn9mr76900ejc.298.1640120295346;
        Tue, 21 Dec 2021 12:58:15 -0800 (PST)
Received: from [192.168.0.182] ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id y13sm4924675edq.77.2021.12.21.12.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 12:58:14 -0800 (PST)
Message-ID: <2db260e8-29f1-c967-d143-fecbd924a082@gmail.com>
Date:   Tue, 21 Dec 2021 22:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/8] hwmon: (adt7410) Pass name to core driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221201113.752827-1-demonsingur@gmail.com>
 <c5effd54-df4d-c7aa-47a2-f7fdcee5354a@roeck-us.net>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <c5effd54-df4d-c7aa-47a2-f7fdcee5354a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/21 22:47, Guenter Roeck wrote:
> On 12/21/21 12:11 PM, Cosmin Tanislav wrote:
>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
>> It will later be used to register hwmon device using
>> hwmon_device_register_with_info.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   drivers/hwmon/adt7410.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
>> index 973db057427b..ef4b5af865e9 100644
>> --- a/drivers/hwmon/adt7410.c
>> +++ b/drivers/hwmon/adt7410.c
>> @@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
>>               I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>>           return -ENODEV;
>> -    return adt7x10_probe(&client->dev, NULL, client->irq, 
>> &adt7410_i2c_ops);
>> +    return adt7x10_probe(&client->dev, client->name, client->irq, 
>> &adt7410_i2c_ops);
>>   }
>>   static int adt7410_i2c_remove(struct i2c_client *client)
>>
> 
> This series looks very similar to the previous series, yet there is
> no change log, and it again claims to be v1 of a patch series. Either
> explain why this series is so different to the similar looking patch
> series starting with "hwmon: adt7x10: store bus_dev in private data",
> that it doesn't deserve to be called v2, or provide change logs and
> version your series.
> 
> If you expect me to figure out what changed, sorry, that is not how
> it works. I won't even look at this series.
> 
> Guenter

I'm sorry, I was in a rush to push the new patchset and I mistyped the
format-patch command and then I also forgot to add a cover letter.
I'll send the proper patches in a few.
