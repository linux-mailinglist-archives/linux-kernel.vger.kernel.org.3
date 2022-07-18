Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39F157845C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiGRNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiGRNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:52:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F627FC6;
        Mon, 18 Jul 2022 06:52:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lmk011gYyzKHsC;
        Mon, 18 Jul 2022 21:51:29 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemmfZdVijUahAw--.40633S3;
        Mon, 18 Jul 2022 21:52:32 +0800 (CST)
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
To:     Yu Kuai <yukuai1@huaweicloud.com>, josef@toxicpanda.com,
        axboe@kernel.dk, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
Date:   Mon, 18 Jul 2022 21:52:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemmfZdVijUahAw--.40633S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWDtrykuF4kJr43GFyrtFb_yoW3Kwb_C3
        s7Zw4xXws3Wr92kr4jyF13ZryFyw4rXrnYqrnIgrZxXFy7ZayxA3Z2ya95Gr47Ga1vq3Z3
        Aa1qvrsrC3WfXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/07/06 17:33, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> to define pr_fmt and use short pr_err() to output error message,
> however, the definition is missed.

friendly ping ...
> 
> Fixes: 1243172d5894 ("nbd: use pr_err to output error message")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/block/nbd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 07f3c139a3d7..94a1602adab5 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -44,6 +44,9 @@
>   #include <linux/nbd-netlink.h>
>   #include <net/genetlink.h>
>   
> +#undef pr_fmt
> +#define pr_fmt(fmt) "nbd: " fmt
> +
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/nbd.h>
>   
> 

