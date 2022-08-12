Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E43590CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiHLHjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiHLHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:39:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B72A61C8;
        Fri, 12 Aug 2022 00:39:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M3wWH1M2WzlBss;
        Fri, 12 Aug 2022 15:37:47 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
        by APP2 (Coremail) with SMTP id Syh0CgAnX7uQA_ZiXtz+AA--.19929S2;
        Fri, 12 Aug 2022 15:38:57 +0800 (CST)
Message-ID: <f179ff36-e511-1bad-078f-71b8b19d404e@huaweicloud.com>
Date:   Fri, 12 Aug 2022 15:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: zhangwensheng@huaweicloud.com
Subject: Re: Question: consult patch
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Lee Jones <lee@kernel.org>
References: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
 <YvXo1uCFA57t89Nv@infradead.org>
 <902a45fe-1117-3f6a-b7b1-9b155e5dd984@huaweicloud.com>
 <YvYAmmaJgvydex4p@google.com>
From:   "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
In-Reply-To: <YvYAmmaJgvydex4p@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnX7uQA_ZiXtz+AA--.19929S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWkZF4DAF4fKFyxXFW8JFb_yoWrJFyxpF
        WrtF13ArW8Jr48Gay7Jr1UJa4jyw12q34rJr93JFykXw1Ygw1S9F4xWr1j9F1UCrWkJr48
        tF15JrsFv34UAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

I'm sorry I didn't fully understand you. did you mean the CVE
was caused by a commit which was applied to an internal kernel
version?  What commitment can be displayed? and I know that
mainline do not have the problem because of some code refactoring,
But are there any problems with some other stable branches?

thank you very much!
Wensheng

在 2022/8/12 15:26, Lee Jones 写道:
> On Fri, 12 Aug 2022, zhangwensheng (E) wrote:
>
>> Hi
>>
>> In CVE list last week, there is a new cve reported in asop 4.14 like below:
>> Reference link: https://lore.kernel.org/all/CAODzB9rgMexvLjE=WuTm+SN8SfUggaZgWG-aBcy6cotppju6mw@mail.gmail.com/T/
>>
>> ---
>> CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
>> prevent UAF
>>
>> CVSS v3 score is not assigned.
>>
>> AOSP kernel 4.14 contains following 2 patches.
>> - 69e8f03c5ced3e4e6fb4181f4dac185104e3420b ("mm: backing-dev: Take a
>> reference to the bdi in use to prevent UAF")
>> - 80d91b86a199798ee2321a0ab0f09e6e12764678 ("fs: explicitly unregister
>> per-superblock BDIs")
>>
>> The first commit 69e8f03("mm: backing-dev: Take a reference to the bdi
>> in use to prevent UAF") is not merged in the mainline and stable
>> kernels.
>> Commit 80d91b8 was merged in 5.16-rc1(commit hash is
>> 0b3ea0926afb8dde70cfab00316ae0a70b93a7cc) which requires commit
>> c6fd3ac ("mm: export bdi_unregister") that exports symbol of
>> bdi_unregister().
>>
>> Fixed status
>> mainline: [0b3ea0926afb8dde70cfab00316ae0a70b93a7cc]
>> ---
>>
>> As mentioned above, patch 69e8f03c5ced ("mm: backing-dev: Take a
>> reference to the bdi in use to prevent UAF") in asop 4.14 can fix
>> a null dereference problem, form my analysis, may like below:
>>
>> blk_cleanup_queue
>>      blk_put_queue
>>          kobject_put(&q->kobj)
>>                  blk_release_queue
>>                      blk_exit_queue
>>                          bdi_put
>>                              release_bdi  // bdi -> null
>> del_gendisk
>>      bdi_unregister(disk->queue->backing_dev_info) // null -> reference
>>
>>  From my analysis, In asop 4.14 kernel, in loop_remove function, there is
>> such a timing that executing "blk_cleanup_queue" first and then
>> "del_gendisk".
>> but because of the refcnt of queue will add by hte line
>> "WARN_ON_ONCE(!blk_get_queue(disk->queue));" in "device_add_disk", which may
>> not result in "bdi_put" releasing bdi  in "blk_cleanup_queue".
>>
>> I'm not sure where the problem is, so I want to ask Lee Jones who sent this
>> patch
>> for clarification.
>>
>> Thanks!
>>
>> Wensheng
>>
>> 在 2022/8/12 13:44, Christoph Hellwig 写道:
>>> On Fri, Aug 12, 2022 at 11:34:59AM +0800, zhangwensheng (E) wrote:
>>>> Hi Lee ：
>>>>       I saw your patch because of CVE-2022-20158, the patch like below:
>>>>
>>>> ---
>>>>       mm: backing-dev: Take a reference to the bdi in use to prevent UAF
>>> I can't see that patch anywhere, and I've not seen an bug report for it.
>>>
>>>>       Because of a distinct lack of locking and/or reference taking,
>>>>       blk_cleanup_queue() puts the final taken reference to the bdi, which
>>> .. and blk_cleanup_queue also is gone upstream.
>>>
>>> What am I missing?
> The issue reported in the aforementioned CVE was caused by a commit
> which was applied to an internal, device specific repository.  One
> that has never existed in Mainline.  I failed to reproduce the KASAN
> report in any upstream or stable tree without the offending patch
> applied.  The issue was fixed in all affected internal trees.
>

