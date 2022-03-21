Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4F4E263A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiCUMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiCUMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:20:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BD24BED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:19:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r2so16439535iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gviUCZoqMlwAzPxDTeni3/iP7iEP9Odnzm6mNqYWrWE=;
        b=sUINLx6thHdc+ZK8Os4juDGY3FX9AeO5hZVu/WjHFREy1p3ODH3sudnKqkHlbnB7l6
         UO2IiYkkoyKWuTT31JjYaPqvJtA144jGu4cDav2Q+wXfQbPYU5Gx+6uyB6BAR4etAR3Z
         3zG4DBXNSYV1rQBfDL3UrV+GYPjDf4tMlpGovjwSESOqxy5/CtlgY3GhqUpp/OpaIg5f
         rv8uY1at77CC7Mag+vZdnHCVQInAkvwytCiv3igX9p4CK2RSSxss1KzYdOS1OnEiRFPR
         wKqHrqwG9IyZNdLT3X/G0XosymFnKXHWY5p//o+JKPIEGPp8RDmLA4K+fkldDp6S9jpZ
         RpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gviUCZoqMlwAzPxDTeni3/iP7iEP9Odnzm6mNqYWrWE=;
        b=0zQcLcGEa7qLPWpPrgR6PMLoKT7SMO8SH1o7y4GQb92wxIs6bHmKrdW/K5QGb4vNuB
         GuhiwuSb98dNMhUNMnKd4LULKQGNyocQmjfsmk83JxsctfddVUq5LrJWxktZt4UWohZ8
         XAkkmYQgfCmorc60CE9V8Xk+iM/u6Yz7ME596UhNH3quZLpqq2MqTDsuSusu6iwhEYGx
         Uk+kn9ZrjlAPI/CB3WGQrzv/xAfvK8W4IMC0fEq68RZTKBNjHFt43CsCOCkPACSmbexE
         ArqWrfug5Vw004bvrOqIVvID/qwnWcw9RiDT/Wesh+G6zmWAXHRPI0WWdegBr0eS+M1D
         jkog==
X-Gm-Message-State: AOAM530t5/t9hFELWNvuesJdpbl5xdxuJ/1vVjd1OR4ckh9HulLeoXoh
        QIaDCX5G/LbvKqyB8iKo2ZxeCFhfNn8ykQ==
X-Google-Smtp-Source: ABdhPJwnU6BWz11dWizI7zp4dHVLETJ6TbQyIBffJyHl3m3j17tE7tcHexwcX2y3NMCekWPKLLRtlQ==
X-Received: by 2002:a05:6638:1455:b0:319:e467:656b with SMTP id l21-20020a056638145500b00319e467656bmr10518195jad.111.1647865139942;
        Mon, 21 Mar 2022 05:18:59 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w8-20020a056e0213e800b002c8279fb9dfsm1847793ilj.57.2022.03.21.05.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:18:59 -0700 (PDT)
Message-ID: <312061ed-61d6-4e2f-a180-8e8c85573e31@linaro.org>
Date:   Mon, 21 Mar 2022 07:18:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [greybus-dev] Re: [PATCH] staging: greybus: codecs: fix type
 confusion with dedicated list iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Mike Rapport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220319202058.2518847-1-jakobkoschel@gmail.com>
 <20220321084844.GG3293@kadam>
 <23587784-B0EB-4FDD-B5BC-DC1B16404DA7@gmail.com>
 <20220321092132.GI3293@kadam>
 <56102C8D-DBFF-43A5-9641-04577F01AB6D@gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <56102C8D-DBFF-43A5-9641-04577F01AB6D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 4:27 AM, Jakob Koschel wrote:
> 

I just released some messages that were marked as spam.  So
this looks to me like it's already been seen on the list.
I'm not sure why this happens but if it seems like deja vu,
you're not imagining things.  Please know that this could
happen from time to time, but I'll see if I can find out
how to avoid it.

					-Alex

>> On 21. Mar 2022, at 10:21, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> On Mon, Mar 21, 2022 at 10:06:13AM +0100, Jakob Koschel wrote:
>>>
>>>> On 21. Mar 2022, at 09:48, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>
>>>> The subject says that it fixes a bug but it does not.
>>>
>>> Thank you for your review!
>>>
>>> I don't agree that this doesn't fix a bug:
>>>
>>>> +		}
>>>> 	}
>>>> 	if (!data) {
>>>> -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
>>>> -			dai->name, module->name);
>>>
>>> Using 'module' when data == NULL is *guaranteed* to be a type confused
>>> bogus pointer. It fundamentally can never be correct.
>>
>> Ah.  I did not read all the way to the end of the patch.
>>
>> The bugfix needs to be sent as it's own patch.  Just the one liner.  It
>> needs a fixes tag as well.
>>
>> [PATCH] staging: greybus: fix Oops in error message
>>
>> The "module" pointer is invalid here.  It's the list iterator and we
>> exited the loop without finding a valid entry.
>>
>> Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver registration")
>> Signed-off-by: You
>>
>> 	if (!data) {
>> -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
>> -			dai->name, module->name);
>> +		dev_err(dai->dev, "%s DATA connection missing\n",
>> +			dai->name);
>> 		mutex_unlock(&codec->lock);
>>
>> We're happy to apply the other stuff as well, but we don't mix cleanups
>> and bug fixes like that.
> 
> ok great, I'll separate and resubmit both. Thanks!
> 
>>
>> regards,
>> dan carpenter
> 
> 	Jakob
> 
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

