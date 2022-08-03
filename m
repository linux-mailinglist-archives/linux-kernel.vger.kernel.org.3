Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B3588BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiHCMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiHCMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:00:25 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F433647C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:00:24 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10e6bdbe218so20476490fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k85+BXyXynjZ9LSZSXWsf3MQl+dSKBggc5agia098P8=;
        b=nzSIftlCZzp3NnHVf+zVO4P2cvt7R0Vb/+9SeBIE7ot8a+Nn1akpwSxc0WDrMCtXJj
         JI5Wvvp+C4dq0ctrpVggyBfSTZZqK31vKg71HccE6605WiBxHVM90sRcfC70eZ3BX3tx
         +l0MbhSURmo/uGc5YeluJ0GfF7ZLnENFCj4b5CDk6HGCwFaIbvZchvnH8T2Uie1ofxi2
         /thywAWJTxoq2RFTyHHmKE64nNI1hQ1qHCsKlxrW7jZMK7SYi/HRKTz3Q0HL7EskMRdD
         UxGDPfOCsSx6BmDytaLpr2kpbuMHCKO1oxcGBvASzy2Sx/za5WF9eT9zGKEfClt7QINY
         M7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k85+BXyXynjZ9LSZSXWsf3MQl+dSKBggc5agia098P8=;
        b=s6MMfaT1qVihDIYIGsSIblRXLTdWqZI5yAlNuo6jm/cMU2hInzBighsnCUnlLsMhOw
         ciinqI+cPvrjSWyA0RHOjYWQxr5D7qJgRfGCZkz/SrwNCP9qw4SkHbwEDgK7rLl2bIA+
         lKekiv6/lC3DQUwfguaie4vx513kSGY5jCMkC4eFeTQo//rNBmqecix9sGSNR4rL7TNc
         p8yHR1chZdKTxE67nb8nl0oXaHnOThsa2kCh/PYsZPaFxAvgj3HD+f5ZjoZMxEGtIl20
         IiBcn84D8fkvUq31uR0EQsCa+Ueptnpf+7CIqCPXIl6seRAmsfmtJDjK+5RP5114L5hQ
         s5HQ==
X-Gm-Message-State: ACgBeo2YfTO0qhA9FtovEzh9F56TRCYzHTQFf9Hla4xHlV/9Z5L4grfs
        sFl//iSYmbZ5ykERFrBJgnu6dbd7XxeOEg==
X-Google-Smtp-Source: AA6agR4OJE3JEX4SdirNZxWAXw9IAgX/r+aRoG9wImJGaaaVzzAwEAFHvKjOXWZNXgjW9YZTnbEifA==
X-Received: by 2002:a05:6870:a1aa:b0:10d:a546:8aa3 with SMTP id a42-20020a056870a1aa00b0010da5468aa3mr1727370oaf.287.1659528023546;
        Wed, 03 Aug 2022 05:00:23 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g8-20020a9d6208000000b0061cbd18bd18sm4078207otj.45.2022.08.03.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 05:00:22 -0700 (PDT)
Message-ID: <81d363ba-82ef-d556-2d77-083e3b2d9d02@linaro.org>
Date:   Wed, 3 Aug 2022 07:00:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [greybus-dev] Re: [PATCH linux-next] staging: greybus:using the
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
 <YuoWCSQCnNU3DrUL@kroah.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <YuoWCSQCnNU3DrUL@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 1:30 AM, Greg KH wrote:
> On Wed, Aug 03, 2022 at 06:22:58AM +0000, cgel.zte@gmail.com wrote:
>> From: ye xingchen <ye.xingchen@zte.com.cn>
>>
>> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
>> and pm_runtime_put_noidle.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by:  <ye.xingchen@zte.com.cn>
>> ---
>>   drivers/greybus/core.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
>> index e546c6431877..b9063e86534b 100644
>> --- a/drivers/greybus/core.c
>> +++ b/drivers/greybus/core.c
>> @@ -174,9 +174,8 @@ static int greybus_probe(struct device *dev)
>>   	if (!id)
>>   		return -ENODEV;
>>   
>> -	retval = pm_runtime_get_sync(&bundle->intf->dev);
>> +	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
>>   	if (retval < 0) {
>> -		pm_runtime_put_noidle(&bundle->intf->dev);
>>   		return retval;
>>   	}
>>   
>> -- 
>> 2.25.1
> 
> Now this is just being silly.  Consider all future emails also dropped.


No Greg, please don't do this, or please undo this.

This happened because the original poster was not a subscriber to the
greybus-dev mailing list.  Such messages get held until someone (me)
releases them after picking them out from the mostly spam that is
caught and held.  I have been trying to do that daily lately but
it's still not enough to avoid this happening.

You were on the original addressee list.  So you got the message
immediately.  But the mailing list filter held it and sent it
again when I released it yesterday.  This is why you saw it the
second time.

Ye Xingchen had nothing to do with your receiving the message twice.

					-Alex

> greg k-h
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

