Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89554FCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383534AbiFQSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFQSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:09:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283592FFD1;
        Fri, 17 Jun 2022 11:09:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso4848706pjk.0;
        Fri, 17 Jun 2022 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tgmfly3b8RsCM+09sHMOvRi51TPleNfDLVBP+IR80o4=;
        b=ay9bFsglRqYNVZWR/xgf0ZBxNW/e1KnJBCt8vGvD6MmkKwJO4iWnRKl1WWciouT5l4
         Z5EOeER6Cgh90Zk3h/WHpJoxtZXt03kH953xhS3ncguQCdDlV9LQdxvXBOLoia6J7FQ+
         4oZHqLhVFOeXz7hXdLqIXRYPs2LKRpYCdVxM3jFDoK7BY3K2FjPE0SllWIB2iPf7Q3s8
         2bigRP21/WdP2HqQvzccjB3Jm+GGizRzgrZDtvTCKnZ5CqXalIT3HDey91Zhe5btaX4a
         USQF/xiAa0OnObxKJvvNAgVXxC+GQSvn+S5YU2UxJrOs1ViFnmfGP1fZrjyCpZa/wzRc
         z2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tgmfly3b8RsCM+09sHMOvRi51TPleNfDLVBP+IR80o4=;
        b=TJhEFCsjWh4bsv3ZWbJcP1bxTiVo33cOAPkX/nyPT6XkSeTaCYW0LMCHhajcvx8Yki
         zdWH2VvVKC6yep1zelKDf7XzhaCwejGQVB6f5QX1raLu5cLPEhF+Dy9Sg7fv1HiC5p3N
         M906WlR/o6aOKp5Itwn1UqtMi/ttc5j5pMAHaUtVDO4iwtdT5k6ERdPyaBFhx0R7RN+K
         us7QDF3tGh03qfc8blefuMJmUI0YPev9MS/U9m6rPITCJKUK4fD0oQzBGeKT6QqF3BRc
         JTMtXClzwyR0fT6OzxR2S8DIwdpBlAgyeub9uqRxjh0tiRR03q5Xd/vF3WdNe0C6hSp0
         5/SQ==
X-Gm-Message-State: AJIora+NB/zLAbC2xQ4XSdNIY0wirR5VpPXjtUPgPxpiX2lO7SMIArLo
        iim1ooeX9Y/+wKDjkH/n6Z6iQb2THks=
X-Google-Smtp-Source: AGRyM1ti+P9qKyoJ/UjpRGaDFwg2zp0yd+FhWAHT0qYHKiPkJoKTJ3qm71MW43CZ5nj5i22LZBVOSg==
X-Received: by 2002:a17:902:dac7:b0:166:3dfe:f4b8 with SMTP id q7-20020a170902dac700b001663dfef4b8mr10772642plx.55.1655489375482;
        Fri, 17 Jun 2022 11:09:35 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id u123-20020a626081000000b00522d329e36esm4131212pfb.140.2022.06.17.11.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 11:09:33 -0700 (PDT)
Message-ID: <fa35e955-41be-bb4b-d1f0-85acec03e0a0@gmail.com>
Date:   Sat, 18 Jun 2022 03:09:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 4/4] PM / devfreq: Mute warning on governor PROBE_DEFER
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-5-ansuelsmth@gmail.com>
 <8dd8bfa2-0843-269b-2d55-e3cbdbf6a5e1@gmail.com>
 <62a9b027.1c69fb81.5ae2b.4f85@mx.google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <62a9b027.1c69fb81.5ae2b.4f85@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 15. 18:22, Ansuel Smith wrote:
> On Wed, Jun 15, 2022 at 03:56:31PM +0900, Chanwoo Choi wrote:
>> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
>>> Don't print warning when a governor PROBE_DEFER as it's not a real
>>> GOV_START fail.
>>>
>>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 2e2b3b414d67..6a39638ed064 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -931,8 +931,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>>>  						NULL);
>>>  	if (err) {
>>> -		dev_err(dev, "%s: Unable to start governor for the device\n",
>>> -			__func__);
>>> +		dev_err_probe(dev, err,
>>> +			      "%s: Unable to start governor for the device\n",
>>> +			      __func__);
>>>  		goto err_init;
>>>  	}
>>>  	create_sysfs_files(devfreq, devfreq->governor);
>>
>>
>> In order to keep the left-align with above error log
>> when try_then_request_governor() is failed,
>> I recommend to use the tab without space indentation as following:
>>
>> If you have no objection, I'll merge this change.
>>
> 
> Sure, good for me. Anyway I wonder if we can relax the hard limit for 80
> for error print since we now can use 100, but your choice.

My suggestion is not over 80 line. Applied it. 

> 
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 01474daf4548..80a1235ef8fb 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -932,8 +932,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>         err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>>                                                 NULL);
>>         if (err) {
>> -               dev_err(dev, "%s: Unable to start governor for the device\n",
>> -                       __func__);
>> +               dev_err_probe(dev, err,
>> +                       "%s: Unable to start governor for the device\n",
>> +                        __func__);
>>                 goto err_init;
>>         }
>>         create_sysfs_files(devfreq, devfreq->governor);
>>
>>
>>
>>
>>
>> -- 
>> Best Regards,
>> Samsung Electronics
>> Chanwoo Choi
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
