Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB17596767
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiHQCXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHQCXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:23:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4549A3E758;
        Tue, 16 Aug 2022 19:23:41 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmslUfxizwQDAA--.3916S3;
        Wed, 17 Aug 2022 10:23:34 +0800 (CST)
Message-ID: <325e126b-14e7-79fa-1348-53d71fd98728@loongson.cn>
Date:   Wed, 17 Aug 2022 10:23:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] docs: scheduler: Update new path for the sysctl knobs
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     alexs@kernel.org, corbet@lwn.net, peterz@infradead.org,
        Tang Yizhou <yizhou.tang@shopee.com>
References: <20220816121907.841-1-lukasz.luba@arm.com>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20220816121907.841-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmslUfxizwQDAA--.3916S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1fGr1kGrWDCw45JFykGrg_yoW5JFWDpa
        4qgr4xA3ZrAr90kw18Cw1rGFWrWFW7C3y3Gr1qk3W8WFyvqaySyr1Ut3y3WF4qqry0yFW5
        XFZag343Zw1jvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU8xWrJUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/16 20:19, Lukasz Luba 写道:
> Add missing update for the documentation bit of some scheduler knob.
> The knobs have been moved to /debug/sched/ location (with adjusted names).
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Tested-by: Yanteng Si <siyanteng@loongson.cn>


CC Yizhou


Thanks,

Yanteng

> ---
>   Documentation/scheduler/sched-design-CFS.rst                    | 2 +-
>   Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
> index 59b2d1fb4dc4..03db55504515 100644
> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -94,7 +94,7 @@ other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
>   way the previous scheduler had, and has no heuristics whatsoever.  There is
>   only one central tunable (you have to switch on CONFIG_SCHED_DEBUG):
>   
> -   /proc/sys/kernel/sched_min_granularity_ns
> +   /sys/kernel/debug/sched/min_granularity_ns
>   
>   which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
>   "server" (i.e., good batching) workloads.  It defaults to a setting suitable
> diff --git a/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst b/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
> index 26b0f36f793d..3076402406c4 100644
> --- a/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
> +++ b/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
> @@ -80,7 +80,7 @@ p->se.vruntime。一旦p->se.vruntime变得足够大，其它的任务将成为
>   CFS使用纳秒粒度的计时，不依赖于任何jiffies或HZ的细节。因此CFS并不像之前的调度器那样
>   有“时间片”的概念，也没有任何启发式的设计。唯一可调的参数（你需要打开CONFIG_SCHED_DEBUG）是：
>   
> -   /proc/sys/kernel/sched_min_granularity_ns
> +   /sys/kernel/debug/sched/min_granularity_ns
>   
>   它可以用来将调度器从“桌面”模式（也就是低时延）调节为“服务器”（也就是高批处理）模式。
>   它的默认设置是适合桌面的工作负载。SCHED_BATCH也被CFS调度器模块处理。

