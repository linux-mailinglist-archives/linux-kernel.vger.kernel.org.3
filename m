Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD257B56F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiGTL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiGTL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:29:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AE72BFE;
        Wed, 20 Jul 2022 04:29:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LntjN51RFzKFR8;
        Wed, 20 Jul 2022 19:27:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD3_9P35tdirQrsAw--.10258S3;
        Wed, 20 Jul 2022 19:28:56 +0800 (CST)
Subject: Re: [PATCH] block: remove unnecessary type castings
To:     Paolo VALENTE <paolo.valente@unimore.it>,
        Yu Zhe <yuzhe@nfschina.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com
References: <20220706053529.15952-1-yuzhe@nfschina.com>
 <F4182887-F9F8-4527-B575-02D6BF56D4C4@unimore.it>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0cf959c5-ce17-4fbe-3498-661b01dfd49a@huaweicloud.com>
Date:   Wed, 20 Jul 2022 19:28:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F4182887-F9F8-4527-B575-02D6BF56D4C4@unimore.it>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3_9P35tdirQrsAw--.10258S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrykWr1DGr1fWw1DCryDZFb_yoW8KFW8pa
        4UW3W5CF47trs3WFW8t3Wjvr9aqwnakry7K3Wv9a4Yyr9rCr1IqFs0vF1FkF9Y9F43Cr4f
        Zr1jgry5Zrsaq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/07/20 19:19, Paolo VALENTE Ð´µÀ:
> 
> 
>> Il giorno 6 lug 2022, alle ore 07:35, Yu Zhe <yuzhe@nfschina.com> ha scritto:
>>
>> remove unnecessary void* type castings.
>>
> 
> Thanks for improving BFQ code. Which commit made these casts unnecessary?
> 
> Paolo
Hi!

I already posted a similar patch:

https://lore.kernel.org/all/20220528095958.270455-5-yukuai3@huawei.com/

It's waiting for the concurrent sync io patchset.

Thanks,
Kuai
> 
> 
>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
>> ---
>> block/bfq-wf2q.c   | 6 +++---
>> block/blk-iocost.c | 2 +-
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index f8eb340381cf..2a666b100bcb 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -474,7 +474,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> 	sd = entity->sched_data;
>> 	bfqg = container_of(sd, struct bfq_group, sched_data);
>> -	bfqd = (struct bfq_data *)bfqg->bfqd;
>> +	bfqd = bfqg->bfqd;
>> #endif
>> 	if (bfqq)
>> 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
>> @@ -573,7 +573,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> 	sd = entity->sched_data;
>> 	bfqg = container_of(sd, struct bfq_group, sched_data);
>> -	bfqd = (struct bfq_data *)bfqg->bfqd;
>> +	bfqd = bfqg->bfqd;
>> #endif
>> 	if (bfqq)
>> 		list_del(&bfqq->bfqq_list);
>> @@ -719,7 +719,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
>> 		else {
>> 			sd = entity->my_sched_data;
>> 			bfqg = container_of(sd, struct bfq_group, sched_data);
>> -			bfqd = (struct bfq_data *)bfqg->bfqd;
>> +			bfqd = bfqg->bfqd;
>> 		}
>> #endif
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 33a11ba971ea..117181a69b7a 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1430,7 +1430,7 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
>> 			int flags, void *key)
>> {
>> 	struct iocg_wait *wait = container_of(wq_entry, struct iocg_wait, wait);
>> -	struct iocg_wake_ctx *ctx = (struct iocg_wake_ctx *)key;
>> +	struct iocg_wake_ctx *ctx = key;
>> 	u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
>>
>> 	ctx->vbudget -= cost;
>> -- 
>> 2.11.0
>>
> 
> .
> 

