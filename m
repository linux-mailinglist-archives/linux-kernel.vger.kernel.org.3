Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CEF54C121
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiFOFXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiFOFXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:23:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057D45ADD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:23:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a10so10252068pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1XTpGpbLP2Rfbx5oE6YvEnXck8EpVNE1acwrhRYTBi8=;
        b=AGuVTxIjaj3k53pbeqm9fWysRJAAeTp2x2TE3eJ6jP3M3gR9LVB8p9s+A3fCn0d96R
         lJo3kAQWL/3K5Nl+TWyJxbaDmpIYfPqNbunBIC5Fo9fbJjtRQx40lsWBwI4DE1KoZM34
         3CvZc2OdSc054+AHeonC7gxaOu84rfnXlIvRJn4pCPMGAdUMqJCOBkYX2bxjYkintjcv
         1c3ELWeJwXW4doaXAeVGGd1o6wJoZIJup3MiCcirEnAXuC+lHr4gVVsJTa8CfDKt3Sb8
         U/ftymiuYueRXnXcT+a3/Gz6PuqawsBVkS/2cqy1Tr9NUw4u6OKmxhDWYfPoIjlmN95c
         I6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1XTpGpbLP2Rfbx5oE6YvEnXck8EpVNE1acwrhRYTBi8=;
        b=4bnYhl8RDd2pkmEJmqITAjXcFxL4IKYhkcgYmN4O66dEXhzEr30/bKXxHHE/jzZxkI
         ndCqOEmZbOOiqkRheq6GVAPgBnbASYQoR0NCRlMQr+d7hg9vZlwmZrS7fqzyg+U0udoD
         GzpAoAm5I2Lrc0QvIQQ9Q3bySDucHDxdjNzh4CERyneQywykQjMwnjQRThokhtrQr8QV
         Xm7YrTnksigQlulOQmUzRtACvdYa2cjcaaGNCxxKt73+IpvR6H6AwTfcQuAvsY+UokiO
         VYclPL12upjRoro/w0XWQBn4J4UAHwcDvIu85y7fNzhyj5jYktmRarwyRQ8fxguGXmlA
         KL0w==
X-Gm-Message-State: AJIora8L0h0R+Q6ZQmDTUTyC63PLRlYYON28hpjxCyibiajzU9QI640s
        Tpnm+i2VgGGtiD2Vi9cHYAP0jw==
X-Google-Smtp-Source: AGRyM1v1on/vuL9R+Vkh2fWepoQk1Ag03qfJahaVVz5B0gwP5XLLHldO8dqAZZ+RSyApzzSRkGYW7g==
X-Received: by 2002:a17:90b:3904:b0:1ea:d976:aff7 with SMTP id ob4-20020a17090b390400b001ead976aff7mr620443pjb.4.1655270587963;
        Tue, 14 Jun 2022 22:23:07 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b001635a8f9dfdsm573680plm.26.2022.06.14.22.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 22:23:07 -0700 (PDT)
Message-ID: <dbe19d10-beb1-bbdc-7935-3e1cfa46e3e8@bytedance.com>
Date:   Wed, 15 Jun 2022 13:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw
 error happens
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
 <Yqle3M18fuEJE0qn@localhost.localdomain>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yqle3M18fuEJE0qn@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/22 12:23, Oscar Salvador wrote:
> On Wed, Jun 15, 2022 at 10:00:05AM +0800, zhenwei pi wrote:
>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
>> cleared on a x86 platform once hardware memory corrupts.
>>
>> Unpoisoning a hardware corrupted page puts page back buddy only,
>> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
>> This leads BUG during accessing on the corrupted KPTE.
>>
>> Suggested by David&Naoya, disable unpoison mechanism when a real HW error
>> happens to avoid BUG like this:
>>
>>   Unpoison: Software-unpoisoned page 0x61234
>>   BUG: unable to handle page fault for address: ffff888061234000
>>   #PF: supervisor write access in kernel mode
>>   #PF: error_code(0x0002) - not-present page
>>   PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
>>   Oops: 0002 [#1] PREEMPT SMP NOPTI
>>   CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
>>   RIP: 0010:clear_page_erms+0x7/0x10
>>   Code: ...
>>   RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
>>   RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
>>   RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
>>   RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
>>   R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
>>   R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
>>   FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    <TASK>
>>    prep_new_page+0x151/0x170
>>    get_page_from_freelist+0xca0/0xe20
>>    ? sysvec_apic_timer_interrupt+0xab/0xc0
>>    ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>>    __alloc_pages+0x17e/0x340
>>    __folio_alloc+0x17/0x40
>>    vma_alloc_folio+0x84/0x280
>>    __handle_mm_fault+0x8d4/0xeb0
>>    handle_mm_fault+0xd5/0x2a0
>>    do_user_addr_fault+0x1d0/0x680
>>    ? kvm_read_and_reset_apf_flags+0x3b/0x50
>>    exc_page_fault+0x78/0x170
>>    asm_exc_page_fault+0x27/0x30
>>
>> Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
>> Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
> ...
> ...
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b85661cbdc4a..385b5e99bfc1 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -69,6 +69,8 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>>   
>>   atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>>   
>> +static bool hw_memory_failure;
>> +
>>   static bool __page_handle_poison(struct page *page)
>>   {
>>   	int ret;
>> @@ -1768,6 +1770,9 @@ int memory_failure(unsigned long pfn, int flags)
>>   
>>   	mutex_lock(&mf_mutex);
>>   
>> +	if (!(flags & MF_SW_SIMULATED))
>> +		hw_memory_failure = true;
>> +
>>   	p = pfn_to_online_page(pfn);
>>   	if (!p) {
>>   		res = arch_memory_failure(pfn, flags);
>> @@ -2103,6 +2108,13 @@ int unpoison_memory(unsigned long pfn)
>>   
>>   	mutex_lock(&mf_mutex);
>>   
>> +	if (hw_memory_failure) {
>> +		unpoison_pr_info("Unpoison: Disabled after HW memory failure %#lx\n",
>> +				 pfn, &unpoison_rs);
>> +		ret = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
> 
> If we disable this, I would move this at the beginning of the function.
> We do not really care whether the pfn is valid or getting the head of
> the page, etc.
> So, unless I'm missing something, this should be enough?
> 

Hi,

Because memory_failure() may be called by hardware error randomly, 
hw_memory_failure should be protected by mf_mutex to avoid this case:
int unpoison_memory(unsigned long pfn)
{
     ...
     if (hw_memory_failure) {
     }
     ... --> memory_failure() happens, and mark hw_memory_failure as true
     mutex_lock(&mf_mutex);
}

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 385b5e99bfc1..ece15f07dee7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2100,6 +2100,12 @@ int unpoison_memory(unsigned long pfn)
>          static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>                                          DEFAULT_RATELIMIT_BURST);
>   
> +       if (hw_memory_failure) {
> +                unpoison_pr_info("Unpoison: Disabled after HW memory failure\n",
> +                                 &unpoison_rs);
> +               ret -EOPNOTSUPP;
> +        }
> +
>          if (!pfn_valid(pfn))
>                  return -ENXIO;
>   
> 

-- 
zhenwei pi
