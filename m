Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C051692C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356453AbiEBBsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiEBBsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:48:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114AEAA;
        Sun,  1 May 2022 18:44:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p12so11290641pfn.0;
        Sun, 01 May 2022 18:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=45/vefmAOs7jyOLkjPvaCzZ3Mr4L7nUL4GQTRp6tqe4=;
        b=joLJdRPQBi9WnNBC6XJUCAuK5cCfVx4A58Ds3gAJK3YPVJ0VF6R7Q94E5R8HFuurci
         VUTurL1ED7uuiJr8/T57CNzj1EWhhmuQWJSkH879W8jKtkoWOxSFJ+7bn+jg85Xatjut
         bhjDkgpYtXFEkdOL5o6rCfw5dfVXSSch6FcplaEoU/5JUxEjNQZlBsz7OLl55xhe0iWq
         SWSupIP1WayZ4InD/e1XRFT2WFmpEH2/C8/5fq868wWyYnDsT1tb529VdkyTRv1Oq/CS
         bcocR+HyglawWtZUqscZx7NWTuDMyTgUEE1zSR5r8ORB/QB9H46m2IyIj2n0RxuScXb1
         2pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=45/vefmAOs7jyOLkjPvaCzZ3Mr4L7nUL4GQTRp6tqe4=;
        b=34ZJRr3M3Im4m1LsahW+CkS0tp+wuNrVqmiU7z5VxQggzEN57qGdgQRna7dm5czwSY
         cdrJXK+/o2vFKrWK7fj5K3pm/ZpGqU/dNXDwEXUwbX2RNNKGwwk1b9uvtpNjMdRINJ9p
         LmI5uDpt9rgH9WrraUvtWV6Kk46ichdkBEZSKliScA6CcUFbDSXJRpvVDZOm1W6n60u7
         8evZMB5aOJ23lfQoLX0VZB6MAcZPn9AXAFVPankgXAgUmHQkMeEHPwY9k0ErpBAfiEdI
         NwPXt+zXWC6Ehwq8D8ZP4yMwNpTTFFEeQEkzH0Sb4Si/4utyQYppP9LW0rW4fRRnuNGK
         3JTw==
X-Gm-Message-State: AOAM532eZu37Q4MtXzNQ1dUKHRtlQbpRCoZgnA4GjFfrW1v23rw2wYoX
        1OCpE5LeZBNODgNPier6yo8=
X-Google-Smtp-Source: ABdhPJzLS9jPlqZ0qOAGE9vCkUweuHxaJ8ewW3XmxdmtO8IuZMAZrTmWYPfOooIsxbv+vFALKRiK5Q==
X-Received: by 2002:a05:6a00:22c4:b0:50d:ed2b:2002 with SMTP id f4-20020a056a0022c400b0050ded2b2002mr2528969pfj.54.1651455880796;
        Sun, 01 May 2022 18:44:40 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78502000000b0050dc7628146sm3433518pfn.32.2022.05.01.18.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 18:44:40 -0700 (PDT)
Message-ID: <e2c14da5-4759-8175-2042-30fba995b883@gmail.com>
Date:   Mon, 2 May 2022 10:44:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Resend: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error
 and Describe details using table
Content-Language: en-US
To:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     akpm <akpm@linux-foundation.org>, baihaowen <baihaowen@meizu.com>,
        seakeel <seakeel@gmail.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        caoyixuan2019 <caoyixuan2019@email.szu.edu.cn>,
        yejiajian2018 <yejiajian2018@email.szu.edu.cn>,
        yuhongf <yuhongf@szu.edu.cn>
References: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
 <ea37d4f9-26e2-272a-01d6-fa7e8c62687e@gmail.com>
 <tencent_640F24F90BA09A5302AA9BD7@qq.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <tencent_640F24F90BA09A5302AA9BD7@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, 30 Apr 2022 18:25:29 +0800,
Shenghong Han wrote:
> The one reply archived at "https://lore.kernel.org/linux-doc/tencent_088763F35CE233FB6C9CEB80@qq.com/"(On 2022/04/30 16:13) is broken-looking. 
> 
> Apologize for that!
> 
> Resend that reply:
> 
> 0) If you have received a similar reply, please refer to the latest reply.
> 
> 1) Accidentally used Chinese Input Method Editor, leaving full-width> symbols during the test, causing the double dashes of "--" changed into
> "long single dash" which should not have occurred.
I don't see any "full-width" symbols in your patch.

> 
> 2) In the current document, the "STANDARD FORMAT SPECIFIERS" table
> does not correctly use the format of the rst document, so in the
> website https://www.kernel.org/doc/html/latest/vm/page_owner.html,
Now that the web page catches up v5.18-rc5, how does it look to
you?

"the current document" is always changing, so it doesn't mean
anything...

> it does not look good. Therefore, the "STANDARD FORMAT SPECIFIERS"
> has been adjusted using the format of the rst table. *This* is the
> main purpose.
> 
> 3) In version 1 before(On 2022/04/30 1:19), the sentence look> like:"Table 1 xxx(some explaination)." and "Table 2 xxx(some
> explaination).", in these 2 "long" sentences, using "." instead of
> ":".Honestly, complex sentence is unnecessary. When I tried to
> modify the sentence, I ignore the strict distinction between "."
> and ":".In short, This modification is unnecessary.
OK.

> 4) Apologize again for the troubles that my clumsy behaviors have> caused.
Looks like you have still a lot to improve...

Akira

> 
> Thanks, 
> 
> Shenghong Han
>  
> ------------------ Original ------------------
> From:  "Akira Yokosawa"<akiyks@gmail.com>;
> Date:  Sat, Apr 30, 2022 02:40 PM
> To:  "Shenghong Han"<hanshenghong2019@email.szu.edu.cn>; "Jonathan Corbet"<corbet@lwn.net>;
> Cc:  "akpm"<akpm@linux-foundation.org>; "baihaowen"<baihaowen@meizu.com>; "seakeel"<seakeel@gmail.com>; "linux-doc"<linux-doc@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; "caoyixuan2019"<caoyixuan2019@email.szu.edu.cn>; "yejiajian2018"<yejiajian2018@email.szu.edu.cn>; "yuhongf"<yuhongf@szu.edu.cn>;
> Subject:  Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and Describe details using table
>  
> On 2022/04/30 3:19,
> Shenghong Han wrote:
>> Some syntax errors exist in "page_owner.rst". Thanks to Akira Yokosawa and
>> Haowen Bai for tips to help improve the documentation.
>>
>> We try to fix them. Hope that the Documentation is showed as we expect.
>>
>> Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
>> Fixes: edc93abbcc6d ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")
>>
>> ---
>> Thanks Jonathan's suggestion.
>>
>> This fix is a simpler than before.
>> And yes, It has built in my machine.
>>
>> Best,
>>
>> Shenghong Han
>> ---
>> ---
>>  Documentation/vm/page_owner.rst | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
>> index 25622c715..0ecb4a739 100644
>> --- a/Documentation/vm/page_owner.rst
>> +++ b/Documentation/vm/page_owner.rst
>> @@ -171,11 +171,12 @@ Usage
>>
>>  STANDARD FORMAT SPECIFIERS
>>  ==========================
>> -::
>>
>> -For --sort option:
>> +1) For --sort option.
>>
>> + ==== ========== ===========
>>  KEY LONG DESCRIPTION
>> + ==== ========== ===========
>>  p pid process ID
>>  tg tgid thread group ID
>>  n name task command name
>> @@ -183,14 +184,18 @@ For --sort option:
>>  T txt full text of block
>>  ft free_ts timestamp of the page when it was released
>>  at alloc_ts timestamp of the page when it was allocated
>> -        ator            allocator       memory allocator for pages
>> + ator allocator memory allocator for pages
>> + ==== ========== ===========
>>
>> -For --curl option:
>> +2) For --curl option.
>>
>> + ==== ========== ===========
>>  KEY LONG DESCRIPTION
>> + ==== ========== ===========
>>  p pid process ID
>>  tg tgid thread group ID
>>  n name task command name
>>  f free whether the page has been released or not
>>  st stacktrace stack trace of the page allocation
>> -        ator            allocator       memory allocator for pages
>> + ator allocator memory allocator for pages
>> + ==== ========== ===========
> 
> So, I have actually tested this.
> 
> Are you OK with the look of
> 
>   1) For --sort option.
> 
> and
> 
>   2) For --curl option.
> 
> in generated HTML or PDF docs?
> 
> In literal blocks, you would see double dashes of "--".
> Now they are converted to so-called endash, which is a single dash
> slightly longer than a normal hyphen.  It looks confusing to me.
> 
> To remedy this, you need inline literal markers of
> 
>   1) For ``--sort`` option.
> 
> and
> 
>   2) For ``--curl`` option.
> 
> 
> By the way, this patch changes ":" to "." at the end of them.
> Are they intentional changes?  If so, why?
> 
>         Thanks, Akira
