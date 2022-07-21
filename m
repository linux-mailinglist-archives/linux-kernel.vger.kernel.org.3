Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4057C4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGUGxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGUGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:53:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B50545986
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:53:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c22so489550wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u8D2lmtPDSrZBXZD+9/RnnAfd9WFO/t4AVgMmjmxBi8=;
        b=Pph23uUZUcYehG0NGk94vlMEkklaji8qAGPjFsdXd1qbydjDOCuzDNoKyiC6172iue
         7IYwszBVsrdx+jqaevKCCnI8iZBYD5Ukkfw6NZDeAHAI+GThs8JX5UOsM+zhXGqSg4k8
         dDA3g4na3cOkmSkju3nZRsBzE8bKRf1edU1mrSNU9nJkPeEI9h5SbgCTuIH0mSpX6kZE
         /EwfFCXjTcj1pBxwMUhuBk1r63Jp8mxSTqLNEgmrSH4KIetfMiiE9s2Wb/A6cCvsHtBL
         JfP1P78a/Rx/cYH0JQ82I214p+7wa1+FhcyhD6AznLUPU9ykUyDSZ5y/HMe/wLMeVpAJ
         Q7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u8D2lmtPDSrZBXZD+9/RnnAfd9WFO/t4AVgMmjmxBi8=;
        b=w8RsGbz6kRC/oV/EvVTZ3Ye/PLHk4DwhaCC1cDXO19x12EmaxhWgZlkHW1d8maTO77
         mI3Qp03mXGoSRlc+RRL0rrNtNOBjSsNBwVcVt3Lsk0RqOd1A5Uprobn67kHFqTnGed1M
         qIkValXgfRTwpgrC4opCJLUmrJvYQbN3X795SwjMEg79O/xekcIkihF2Ew2MauWl8YsO
         PsLLbZtt9d2OmN3e4NXnp3qK458OY4YBAzNhS3GrPEfys9PRqJw0KGL+US1P/9M2Oi2j
         /n4krUzS1qOT5kAWXH3kUFYBjBFaE/PmJMsAESQT/uPWzw5+hz/PywWVSgl920gcMsG1
         n74Q==
X-Gm-Message-State: AJIora8LhimfKpI7Sh8NikYmFcZDbaP9TIfQTXSpeamAlg492hh6AmVE
        Z2TiN5RjkEvvGm7fxoFD9DGEEsOT8i83mUm4
X-Google-Smtp-Source: AGRyM1skpjCzIQ99s7ju/XygcTxZhpbUTZZiEaqLHtmz1sWeLC9+cMETc03/oWVclo9x6t7XK3XP/A==
X-Received: by 2002:a05:600c:600b:b0:3a3:1176:222d with SMTP id az11-20020a05600c600b00b003a31176222dmr7089059wmb.42.1658386390689;
        Wed, 20 Jul 2022 23:53:10 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b003a2ed2a40e4sm5302592wms.17.2022.07.20.23.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:53:10 -0700 (PDT)
Message-ID: <fe53105e-3891-b11f-b01b-70b123831b88@conchuod.ie>
Date:   Thu, 21 Jul 2022 07:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] microblaze: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>
Cc:     monstr@monstr.eu, linux-kernel@vger.kernel.org
References: <20220721025158.21856-1-slark_xiao@163.com>
 <f55b4d0b-c9b8-e4b8-9a1d-468f6a22128d@conchuod.ie>
 <7591e9f.1f6c.1821f7f7405.Coremail.slark_xiao@163.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <7591e9f.1f6c.1821f7f7405.Coremail.slark_xiao@163.com>
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


Hey Slark,
On the list we reply "inline" rather than at the top of the
quoted email. This makes things easier to follow.
I fixed up your reply, see below ;)

On 21/07/2022 07:43, Slark Xiao wrote:
> 
> At 2022-07-21 14:33:32, "Conor Dooley" <mail@conchuod.ie> wrote:
>>
>> On 21/07/2022 03:51, Slark Xiao wrote:
>>> Fix typo in the comment
>>>
>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>>> ---
>>>    arch/microblaze/kernel/entry.S | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
>>> index b179f8f6d287..8651fe351276 100644
>>> --- a/arch/microblaze/kernel/entry.S
>>> +++ b/arch/microblaze/kernel/entry.S
>>> @@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
>>>    
>>>    
>>>    /* This the initial entry point for a new child thread, with an appropriate
>>> -   stack in place that makes it look the the child is in the middle of an
>>> +   stack in place that makes it look the child is in the middle of an
>>
>> This is /a/ fix, but I don't think it is the right one for this comment.
>> Surely this should be "s/the the/like the/, no?
>
>    Thanks for your reply.
>    Actually  I didn't get your point of 'Surely this should be "s/the the/like the/, no?'.
>    Do you mean this is NOT a TYPO, but like a change which we use 'the/' instead of 'the the/'?

What I meant was that the sentence does not make very much sense, either now
or with your patch applied. I do think that "the the" is a mistake, but to me
the correct fix is replacing it with "like the" rather than "the".
The new sentence would read:
"stack in place that makes it look like the child is in the middle of an"

Oh, also - there's another typo in this line. "an syscall" should be "a syscall".
Thanks,
Conor.

>    
> Thanks!
>>
>>>       syscall.  This function is actually `returned to' from switch_thread
>>>       (copy_thread makes ret_from_fork the return address in each new thread's
>>>       saved context).  */
