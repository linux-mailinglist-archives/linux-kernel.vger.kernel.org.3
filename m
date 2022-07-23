Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEB57EB84
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 04:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiGWCPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiGWCPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 22:15:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39F820EE;
        Fri, 22 Jul 2022 19:15:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LqVHZ15GWzKH7q;
        Sat, 23 Jul 2022 10:14:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemnMWdtiwj1WBA--.40945S3;
        Sat, 23 Jul 2022 10:15:41 +0800 (CST)
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
To:     Yu Kuai <yukuai3@huawei.com>, Joe Perches <joe@perches.com>,
        josef@toxicpanda.com, axboe@kernel.dk, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
 <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
 <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
 <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ec031ff1-3936-92ce-b66b-59e3e6a289ab@huaweicloud.com>
Date:   Sat, 23 Jul 2022 10:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemnMWdtiwj1WBA--.40945S3
X-Coremail-Antispam: 1UD129KBjvJXoW7XF17XryDCFyrCw4rCF43Awb_yoW8JrWDpF
        4qya4kCr4vyr45G3WIyw1Skry3t3Z7Jr1ag34UZ3y09a9xCas3Ar17AFnYqrWvvr4kKw12
        9F4Dt3y8AF1rWrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
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

Hi!

在 2022/07/20 19:46, Yu Kuai 写道:
> Hi !
> 
> 在 2022/07/18 22:32, Joe Perches 写道:
>> On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
>>> 在 2022/07/06 17:33, Yu Kuai 写道:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
>>>> to define pr_fmt and use short pr_err() to output error message,
>>>> however, the definition is missed.
>>> friendly ping ...
>> []
>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> []
>>>> @@ -44,6 +44,9 @@
>>>>    #include <linux/nbd-netlink.h>
>>>>    #include <net/genetlink.h>
>>>> +#undef pr_fmt
>>>> +#define pr_fmt(fmt) "nbd: " fmt
>>>> +
>> Typically, this #define is place before all #include lines
>> so there is no need for an #undef

I tried to remove the #undef:

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -44,7 +44,6 @@
  #include <linux/nbd-netlink.h>
  #include <net/genetlink.h>

  #define pr_fmt(fmt) "nbd: " fmt

And then following warning is triggered:

drivers/block/nbd.c:47: warning: "pr_fmt" redefined
    47 | #define pr_fmt(fmt) "nbd: " fmt

It semms that keeping that #undef is the right thing to do.

Thanks,
Kuai
> 
> Thanks for you advice, I'll do that in v2.
> 
> Kuai
> 
> .
> 

