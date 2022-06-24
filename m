Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B910855927F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiFXFrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXFrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:47:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B269A9E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:47:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so2453043ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=abZ/yTYs0ZwLRlsQiZNgXIB/kfxOpHs4jVotD4dmbgw=;
        b=gZIdoDgHmaxSVYNIVrQhhqeqMbOFxuBGIGTazSY1poz6u4oFVnujKzefwOPJYJuOqk
         YIKizMhO+vYAGoJcn+m4og7xvq2rjrHnPYfOkmuQvSuLxSI8RDssKaKscuYBPTCn1zTe
         43UjG42vDRIRWJQYRVDsobPy3vi65PU/TE2nHw7qEh3QvQUDprom1hkSY8OtgNY1U4F0
         9i8AGAF2HBs+YS9OQZdhNul8m2KKEzSPQ7Ypdam1LnSMPhhBDvINtxWAympsCVR5TEBS
         BCBA3LKQaKf14XQp59dw6Y/VyQ3t98e4bjOg2FA1KT9F3dqQ5F4X+/kgbXVm/AJVQ9vW
         6Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=abZ/yTYs0ZwLRlsQiZNgXIB/kfxOpHs4jVotD4dmbgw=;
        b=S4doQslaQlLEF1aHvVNsXxRVULlXnBUY/wMnAMpuQ54vvtKMGzcgzjvr11U/+xn7zU
         c9ZgnDGSSSN/DDsmqpYVOY6+OikC2QGJgk6NFIWQowVSiO0G6s9zF14ybHDV6xd7Ai/w
         mh4xzmofkw+6epzhIo2bBr6bnCCVJlxeM5FN+CQhRUOIzU1iqrVFd5VbLclwcI5Jy1ER
         b+iNCo5L2z1Z7TU7/tSMCuiiBbcp/c1gONLdQRXDDOp112TAbomIMeTDWoad87ETwJAe
         uGaf+KQKm+8QyyDvGS9qpZ+FiNYpnhocPLFtkGoIh9XW5K6r7TCLHdU4BCwrUgerY6ON
         20RQ==
X-Gm-Message-State: AJIora/huhZC93Z/yCXtjcyEfp+k0fFwxgMR4WUc1elQ5aTugjvJSjua
        tUfWEmb61N0vQ+ZoUcRQ5LkhD7N0jow=
X-Google-Smtp-Source: AGRyM1tzgdT7WzRgqABYFO31+RZTzcofzQVtDoQev2UpD1fM2a6nTQiKyGPjZDvNGjZikqWSnDI2AA==
X-Received: by 2002:a17:906:3c07:b0:718:e1a7:b834 with SMTP id h7-20020a1709063c0700b00718e1a7b834mr11467688ejg.635.1656049633376;
        Thu, 23 Jun 2022 22:47:13 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6903:8f42:a6e8:b267:63e? (p200300c78f2e69038f42a6e8b267063e.dip0.t-ipconnect.de. [2003:c7:8f2e:6903:8f42:a6e8:b267:63e])
        by smtp.gmail.com with ESMTPSA id jz27-20020a17090775fb00b006fecf74395bsm544100ejc.8.2022.06.23.22.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 22:47:13 -0700 (PDT)
Message-ID: <4e0d3b62-ceb4-5848-446f-6552ab16f852@gmail.com>
Date:   Fri, 24 Jun 2022 07:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Greg KH <greg@kroah.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com> <YrQ2Izg1b399yJou@kroah.com>
 <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 05:34, Chang Yu wrote:
> On Thu, Jun 23, 2022 at 11:45:07AM +0200, Greg KH wrote:
>> On Wed, Jun 22, 2022 at 10:14:04PM -0700, Chang Yu wrote:
>>> Combine two nested if statements into a single one
>>>
>>> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
>>> ---
>>> Changes in v2:
>>> Added a pair of parentheses to make operator precedence explicit.
>>>
>>>   drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
>>> index 6564e82ddd66..020bc212532f 100644
>>> --- a/drivers/staging/r8188eu/core/rtw_recv.c
>>> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
>>> @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>>>   
>>>   	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>>>   
>>> -	if (padapter) {
>>> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
>>> -				precvpriv->free_recvframe_cnt++;
>>> -	}
>>> +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
>>> +		precvpriv->free_recvframe_cnt++;
>>>   
>>>   	spin_unlock_bh(&pfree_recv_queue->lock);
>>>   
>>> -- 
>>> 2.36.1
>>>
>>>
>>
>> Hi,
>>
>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>> a patch that has triggered this response.  He used to manually respond
>> to these common problems, but in order to save his sanity (he kept
>> writing the same thing over and over, yet to different people), I was
>> created.  Hopefully you will not take offence and will fix the problem
>> in your patch and resubmit it so that it can be accepted into the Linux
>> kernel tree.
>>
>> You are receiving this message because of the following common error(s)
>> as indicated below:
>>
>> - You did not specify a description of why the patch is needed, or
>>    possibly, any description at all, in the email body.  Please read the
>>    section entitled "The canonical patch format" in the kernel file,
>>    Documentation/SubmittingPatches for what is needed in order to
>>    properly describe the change.
>>
>> - You did not write a descriptive Subject: for the patch, allowing Greg,
>>    and everyone else, to know what this patch is all about.  Please read
>>    the section entitled "The canonical patch format" in the kernel file,
>>    Documentation/SubmittingPatches for what a proper Subject: line should
>>    look like.
>>
>> If you wish to discuss this problem further, or you have questions about
>> how to resolve this issue, please feel free to respond to this email and
>> Greg will reply once he has dug out from the pending patches received
>> from other developers.
>>
>> thanks,
>>
>> greg k-h's patch email bot
> 
> I'm not entirely sure how to fix this. I checked the original patch
> again and the subject and the body looks OK to me. I'm still a newbie so
> I might have missed a couple of things. It would be greatly appreciated
> if someone could point out what's missing.
> 

description:
You wrote what you did in the description. Even when the why can be 
likely answered as well it is not sufficient for Greg K-H.

I propose something like:
Combine two nested if statements into a single one to increase readability.

Or

Combine two nested if statements into a single one to shorten code.

subject:
I am guessing. The subject could may be remain but I think it is to 
general. Please consider that we can have multiple of this subjects what 
is not good. How to know which patch is which?

I propose something like:
staging: r8188eu: combine nested if statements in function xxxx

Or

staging: r8188eu: combine nested if statements in file xxxx


But consider that the patches that were accepted do also have a not so 
specific subject. The description was very clear about the "why". There 
the reason was always checkpatch.

Bye Philipp








