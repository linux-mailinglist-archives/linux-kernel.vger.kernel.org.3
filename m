Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09F57B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiGTLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiGTLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:46:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6C72BF8;
        Wed, 20 Jul 2022 04:46:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Lnv5x3ZGpzKCsY;
        Wed, 20 Jul 2022 19:45:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgAHamkm69diMo_sAw--.2462S3;
        Wed, 20 Jul 2022 19:46:46 +0800 (CST)
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
To:     Joe Perches <joe@perches.com>, josef@toxicpanda.com,
        axboe@kernel.dk, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
 <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
 <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
Date:   Wed, 20 Jul 2022 19:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAHamkm69diMo_sAw--.2462S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur15WF4UCw13WFyUur43trb_yoW3Xwc_uw
        nF9ws7CwnrGFyIyrsFyFW3ZrZIyw48Jr93Xr1a9rnxCa4kXay7AF17A395Gw4DGw4ktFn5
        Cw1qgr13Jw4rWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGYL9UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

在 2022/07/18 22:32, Joe Perches 写道:
> On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
>> 在 2022/07/06 17:33, Yu Kuai 写道:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
>>> to define pr_fmt and use short pr_err() to output error message,
>>> however, the definition is missed.
>> friendly ping ...
> []
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> []
>>> @@ -44,6 +44,9 @@
>>>    #include <linux/nbd-netlink.h>
>>>    #include <net/genetlink.h>
>>>    
>>> +#undef pr_fmt
>>> +#define pr_fmt(fmt) "nbd: " fmt
>>> +
> Typically, this #define is place before all #include lines
> so there is no need for an #undef

Thanks for you advice, I'll do that in v2.

Kuai

