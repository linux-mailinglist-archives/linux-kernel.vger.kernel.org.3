Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127B3590BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiHLG2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiHLG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:27:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF481A571B;
        Thu, 11 Aug 2022 23:27:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M3twl24DYz6T5F3;
        Fri, 12 Aug 2022 14:26:15 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
        by APP4 (Coremail) with SMTP id gCh0CgDHGvjZ8vViLWf1AA--.10340S2;
        Fri, 12 Aug 2022 14:27:37 +0800 (CST)
Message-ID: <902a45fe-1117-3f6a-b7b1-9b155e5dd984@huaweicloud.com>
Date:   Fri, 12 Aug 2022 14:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Question: consult patch
To:     Christoph Hellwig <hch@infradead.org>,
        "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
 <YvXo1uCFA57t89Nv@infradead.org>
From:   "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Reply-To: zhangwensheng@huaweicloud.com
In-Reply-To: <YvXo1uCFA57t89Nv@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHGvjZ8vViLWf1AA--.10340S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8Xry7KF4DKF48Aw4xZwb_yoW5Xw15pF
        WrJr13JrW8JF48Gay7Gr17J34UAF1Ut34rJ34xJFyktr1rG3W29r1xWF129F48ur4kJr48
        J3W5Jr40vryUJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUozVbDU
        UUU
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

In CVE list last week, there is a new cve reported in asop 4.14 like below:
Reference link: 
https://lore.kernel.org/all/CAODzB9rgMexvLjE=WuTm+SN8SfUggaZgWG-aBcy6cotppju6mw@mail.gmail.com/T/

---
CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
prevent UAF

CVSS v3 score is not assigned.

AOSP kernel 4.14 contains following 2 patches.
- 69e8f03c5ced3e4e6fb4181f4dac185104e3420b ("mm: backing-dev: Take a
reference to the bdi in use to prevent UAF")
- 80d91b86a199798ee2321a0ab0f09e6e12764678 ("fs: explicitly unregister
per-superblock BDIs")

The first commit 69e8f03("mm: backing-dev: Take a reference to the bdi
in use to prevent UAF") is not merged in the mainline and stable
kernels.
Commit 80d91b8 was merged in 5.16-rc1(commit hash is
0b3ea0926afb8dde70cfab00316ae0a70b93a7cc) which requires commit
c6fd3ac ("mm: export bdi_unregister") that exports symbol of
bdi_unregister().

Fixed status
mainline: [0b3ea0926afb8dde70cfab00316ae0a70b93a7cc]
---

As mentioned above, patch 69e8f03c5ced ("mm: backing-dev: Take a
reference to the bdi in use to prevent UAF") in asop 4.14 can fix
a null dereference problem, form my analysis, may like below:

blk_cleanup_queue
     blk_put_queue
         kobject_put(&q->kobj)
                 blk_release_queue
                     blk_exit_queue
                         bdi_put
                             release_bdi  // bdi -> null
del_gendisk
     bdi_unregister(disk->queue->backing_dev_info) // null -> reference

 From my analysis, In asop 4.14 kernel, in loop_remove function, there is
such a timing that executing "blk_cleanup_queue" first and then 
"del_gendisk".
but because of the refcnt of queue will add by hte line
"WARN_ON_ONCE(!blk_get_queue(disk->queue));" in "device_add_disk", which may
not result in "bdi_put" releasing bdi  in "blk_cleanup_queue".

I'm not sure where the problem is, so I want to ask Lee Jones who sent 
this patch
for clarification.

Thanks!

Wensheng

在 2022/8/12 13:44, Christoph Hellwig 写道:
> On Fri, Aug 12, 2022 at 11:34:59AM +0800, zhangwensheng (E) wrote:
>> Hi Lee ：
>>      I saw your patch because of CVE-2022-20158, the patch like below:
>>
>> ---
>>      mm: backing-dev: Take a reference to the bdi in use to prevent UAF
> I can't see that patch anywhere, and I've not seen an bug report for it.
>
>>      Because of a distinct lack of locking and/or reference taking,
>>      blk_cleanup_queue() puts the final taken reference to the bdi, which
> .. and blk_cleanup_queue also is gone upstream.
>
> What am I missing?
> .

