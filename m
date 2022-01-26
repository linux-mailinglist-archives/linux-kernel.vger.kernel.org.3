Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2D49D00E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiAZQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiAZQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:52:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84222C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:52:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so40261874ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i/cewqiBPhgkuI8D1aLTVSHMkBkFIKiYWGIrALTIQw8=;
        b=Dov5nrM9/KLZtrXiV53vNft1FCFjFYCmaXoJPwgHEIHRS3aPskNweG+XHCSJrd5wjA
         pxz1l6SZeHBaekyvuQ+7Hir6Eo7QfmaaT1AW2UAuq4m5OPKiswG8ElIw5xcCIoaRC1EW
         AGfuaiNkbEXSMYrxVApcYVmqSehwZSSmKy+YyRmIumgEylSEDH/jfl65OO8HFS+s11x1
         O7ZIu4sxnPBe/Ue7wtnzddisX4uPkOAGUTW3clvvHMiySWFDLw3efFh6Ab7RwPvhD60S
         L40JgZh/8fa9FH/nxS1Fzil/Giwg+S1APvywjf6OjR60JVDZii6SlsYU8u7uCcJU+PY2
         lN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i/cewqiBPhgkuI8D1aLTVSHMkBkFIKiYWGIrALTIQw8=;
        b=J7bCniJTB/vRyDYwMgLoNaoYRQboJrrEqTeNYt0Pjpe4ooDd3NzMQ6EncFRRPRGmXq
         trXetIGdOzRCZQV1S966lCgQiE8wzxA+hn8bQHB+rrjsVu4nEzjbk4YAzO0eyFVEA1Of
         qL/t9T7c9w/zBzn3s4Ds7IuhXWdnaSpXuUPxJkryuF/SExr2DJLfkCmzJ7LlloMVsDwJ
         NTHx+we0knFhhopZUOpCJfsYze1AGRS0V7Nt3ylQ2ZIBrLBJDhyl2brv4dejrZsbs521
         Bmlx7JACGsc6M7ebJJbkd1Cj007BihZ6W1wMlaFxqX/v1WqFVoiUJ7bgPmOOlUay0GhN
         5PqA==
X-Gm-Message-State: AOAM5311mSPgJFJxCvmnerRISki6O7hJRSETKXx/efQXiLHVckFZQxtn
        KxK+hg/YAj6Zvmjbe6jTid9yCA==
X-Google-Smtp-Source: ABdhPJyyHj/grgwQPPzI6SSqvRRnCKrg3s/+QV+gG8arCHAw+uvJfcex/YmzrOsXBstdoqywOCK9Mw==
X-Received: by 2002:a17:907:82a6:: with SMTP id mr38mr15149191ejc.769.1643215941954;
        Wed, 26 Jan 2022 08:52:21 -0800 (PST)
Received: from ?IPV6:2003:d9:9705:5400:a005:76bd:8988:8139? (p200300d997055400a00576bd89888139.dip0.t-ipconnect.de. [2003:d9:9705:5400:a005:76bd:8988:8139])
        by smtp.googlemail.com with ESMTPSA id w24sm2652802edu.97.2022.01.26.08.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 08:52:21 -0800 (PST)
Message-ID: <7de781c8-f71f-35e2-a335-f9b13de691db@colorfullife.com>
Date:   Wed, 26 Jan 2022 17:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] To fix the below failure of handling page fault caused by
 the invalid input from user.
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dongyang Wang <dongyang.wang@windriver.com>
Cc:     christian.brauner@ubuntu.com, ebiederm@xmission.com,
        legion@kernel.org, varad.gautam@suse.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20220118091952.37001-1-dongyang.wang@windriver.com>
 <20220125184239.4d97c00569b3051e714c56d3@linux-foundation.org>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220125184239.4d97c00569b3051e714c56d3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongyang,

On 1/26/22 03:42, Andrew Morton wrote:
> On Tue, 18 Jan 2022 17:19:52 +0800 Dongyang Wang <dongyang.wang@windriver.com> wrote:
>
>> [786058.308965] Unable to handle kernel paging request at virtual address 01000004
>> [786058.316286] pgd = 38a99693
>> [786058.319080] [01000004] *pgd=07800003, *pmd=00000000
>> [786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>> [786058.324100] CPU:  PID: Comm:  Tainted: G         C
>> [786058.324102] Hardware name:
>> [786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
>> [786058.324120] LR is at store_msg+0xc0/0xe8
>> [786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
>> [786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
>> [786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
>> [786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
>> [786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
>> [786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
>> [786058.324145] Process  (pid: , stack limit = 0x25018bdf)

Why is process and pid: empty? Is this some kind of kernel process calling?


>> [786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
>> [786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
>> [786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
>> [786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
>> [786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
>> [786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
>> [786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
>> [786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
>> [786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>> [786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>> [786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
>> [786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)
>> [786058.324211] [<c0871d04>] (store_msg) from [<c087abd4>] (do_mq_timedreceive+0x29c/0x484)
>> [786058.324218] [<c087abd4>] (do_mq_timedreceive) from [<c087b474>] (sys_mq_timedreceive+0x88/0xbc)
>> [786058.324226] [<c087b474>] (sys_mq_timedreceive) from [<c06011dc>] (__sys_trace_return+0x0/0x10)
>> [786058.324229] Exception stack(0xc3503fa8 to 0xc3503ff0)
>> [786058.324233] 3fa0:                   b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>> [786058.324236] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>> [786058.324239] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6
>> [786058.324247] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
>> [786058.601808] ---[ end trace 0000000000000002 ]---
>>
>> ...
>>
> Please describe the circumstances under which this occurs.
>
> Please also describe how your proposed patch fixes this.
>
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -1211,6 +1211,12 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>   		goto out_fput;
>>   	}
>>   
>> +	/* checks if buffer is invalid */
>> +	if ((unsigned long) u_msg_ptr < PAGE_SIZE) {
>> +		ret = -EINVAL;
>> +		goto out_fput;
>> +	}
>> +

I do not think that this will solve the problem: u_msg_ptr is user 
controlled.

If < PAGE_SIZE causes issues, then 2^32-1, or PAGE_SIZE+1 will cause 
issues as well.

What is the kernel version where you have observed the issue?

>>   	/*
>>   	 * msg_insert really wants us to have a valid, spare node struct so
>>   	 * it doesn't have to kmalloc a GFP_ATOMIC allocation, but it will
>> @@ -1262,6 +1268,10 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>   			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
>>   			ret = -EFAULT;
>>   		}
>> +
>> +		if (msg_len < ret)
>> +			ret = -EMSGSIZE;
>> +

Why this change?

EMSGSIZE means right now: wrong parameters, no message removed from the 
queue.

But: in the line you modify, a message was already removed from the 
queue. Thus I would not consider EMSGSIZE as appropriate.

>>   		free_msg(msg_ptr);
>>   	}
>>   out_fput:
>> -- 
>> 2.26.1


