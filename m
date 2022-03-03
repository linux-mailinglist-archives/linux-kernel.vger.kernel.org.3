Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF414CB4A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiCCCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCCCDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:03:35 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC5638D93
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:02:48 -0800 (PST)
Received: from localhost.localdomain (unknown [10.20.42.95])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn8_FISBiuqsBAA--.8781S3;
        Thu, 03 Mar 2022 10:02:46 +0800 (CST)
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
 <20220302153433.719caef31bd9e99319c5e6a2@linux-foundation.org>
From:   wangjianxing <wangjianxing@loongson.cn>
Message-ID: <fad38be0-967a-8772-07c8-cc26fa49a251@loongson.cn>
Date:   Thu, 3 Mar 2022 10:02:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20220302153433.719caef31bd9e99319c5e6a2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dxn8_FISBiuqsBAA--.8781S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15WF4kCw1rJFy5Kr45Jrb_yoW8GrWkpr
        n5Jw1Dtr1DJws5Jw4xtrn29rWrCanxKrn7Xry8tFW3JasxXrnIqFykKFZI9Fy7G3y8C3yS
        q3y8Kw4rZa1qqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y
        6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 07:34 AM, Andrew Morton wrote:
> On Tue,  1 Mar 2022 20:38:25 -0500 wangjianxing <wangjianxing@loongson.cn> wrote:
>
>> free a large list of pages maybe cause rcu_sched starved on
>> non-preemptible kernels
>>
>> rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
>> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
>> [...]
>> Call Trace:
>>    free_unref_page_list+0x19c/0x270
>>    release_pages+0x3cc/0x498
>>    tlb_flush_mmu_free+0x44/0x70
>>    zap_pte_range+0x450/0x738
>>    unmap_page_range+0x108/0x240
>>    unmap_vmas+0x74/0xf0
>>    unmap_region+0xb0/0x120
>>    do_munmap+0x264/0x438
>>    vm_munmap+0x58/0xa0
>>    sys_munmap+0x10/0x20
>>    syscall_common+0x24/0x38
> Thanks.
>
> How did this large list of pages come about?
>
> Will people be seeing this message in upstream kernels, or is it
> specific to some caller code which you have added?
>
> Please always include details such as this so that others can determine
> whether the fix should be backported into -stable kernels.
Thanks.

I try to increase the overcommit ratio of cpu to 1:2~1:3 in KVM 
hypervisor, per-vm has the same number of vcpu with host cpu, then setup 
2 or 3 vm.
Run ltpstress test in per vm, both host and guest is non-preemptiable 
kernel, vm dmesg will throw some rcu_sched warning.

ltp version is 20180926, but until now I didn't analysis ltpstress code 
deeply.

