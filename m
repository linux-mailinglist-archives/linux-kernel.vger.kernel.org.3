Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCF58493B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiG2BHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:07:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9704BD1A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:07:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lv8Rj6y3pzjXXh;
        Fri, 29 Jul 2022 09:04:17 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 09:07:13 +0800
Subject: Re: [PATCH 2/6] hugetlb_cgroup: remove unneeded header file
To:     Mina Almasry <almasrymina@google.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220728121949.20985-1-linmiaohe@huawei.com>
 <20220728121949.20985-3-linmiaohe@huawei.com>
 <CAHS8izNM8aPdus_EVygtug+8b6CUNozz_se+mpqRe7SUZEcOwQ@mail.gmail.com>
 <CAHS8izML04ujw1+1622JPQjKH0RHt0zHSEQvbLXZaZ1edfF=bQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <23841f02-2611-6945-868f-f8f15c325219@huawei.com>
Date:   Fri, 29 Jul 2022 09:07:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izML04ujw1+1622JPQjKH0RHt0zHSEQvbLXZaZ1edfF=bQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/29 2:02, Mina Almasry wrote:
> On Thu, Jul 28, 2022 at 10:45 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>> The header file slab.h is unneeded now. Remove it.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Acked-by: Mina Almasry <almasrymina@google.com>
>>
> 
> Actually, sorry, but this file calls kzalloc_node() which comes from
> linux/slab.h, no? Can we keep the include then? slab.h is probably
> included by other include files but for clarity it's better that
> hugetlb_cgroup.c to include slab.h if it is calling functions declared
> there.

I have browsed the code to verify it but I still missed kzalloc_node in this file.
Will drop this patch. Many thanks for your review.

> 
>>> ---
>>>  mm/hugetlb_cgroup.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>>> index d16eb00c947d..99e9a367e1e5 100644
>>> --- a/mm/hugetlb_cgroup.c
>>> +++ b/mm/hugetlb_cgroup.c
>>> @@ -19,7 +19,6 @@
>>>
>>>  #include <linux/cgroup.h>
>>>  #include <linux/page_counter.h>
>>> -#include <linux/slab.h>
>>>  #include <linux/hugetlb.h>
>>>  #include <linux/hugetlb_cgroup.h>
>>>
>>> --
>>> 2.23.0
>>>
> .
> 

