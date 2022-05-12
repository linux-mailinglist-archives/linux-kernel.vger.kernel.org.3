Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18B5257DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359213AbiELWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359206AbiELWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:34:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E71F9A20
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:34:55 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220512223452euoutp01a4c4f4113bf78a7a3e5b795dcdc5c5d6~ufGZ7fCms3252732527euoutp010
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:34:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220512223452euoutp01a4c4f4113bf78a7a3e5b795dcdc5c5d6~ufGZ7fCms3252732527euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652394892;
        bh=sLkxMDQPs6EXbWVxl48t3PGxlsdq8uNENFIAMvFlFds=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HEa4zHS/yubaJCnXBb3SjdatRadSjyjOXM1CNNAHT2cCOTsEWlX+HLZN97UvpffRV
         bAh/c6NadLR3i7YuBlkDNEAjZswA5eTHX30q12UtdCjMLlKcVzucsPDqvEIO0CV4+q
         jsf2Roic/ifbryTqcVfF8eY0XAplvj45hIG2JeyY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220512223451eucas1p1e9e507edeec33876661bbaa5ad121a3d~ufGY-g8ZT0250502505eucas1p1n;
        Thu, 12 May 2022 22:34:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.8F.10260.B8B8D726; Thu, 12
        May 2022 23:34:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638~ufGXzyyeW0867708677eucas1p2c;
        Thu, 12 May 2022 22:34:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220512223450eusmtrp137486ba4a93c43cefe60168460639899~ufGXy8tQ52256022560eusmtrp1-;
        Thu, 12 May 2022 22:34:50 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-fa-627d8b8b7b23
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.2D.09522.A8B8D726; Thu, 12
        May 2022 23:34:50 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220512223449eusmtip1c11fb40e8cbadaaf7d77b931027024c9~ufGW70fET2891028910eusmtip1V;
        Thu, 12 May 2022 22:34:49 +0000 (GMT)
Message-ID: <7ecd0d6a-cbf2-448c-92ef-2adb5184342c@samsung.com>
Date:   Fri, 13 May 2022 00:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Content-Language: en-US
To:     Chanwoo Choi <cwchoi00@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220511093554.17535-3-cw00.choi@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rd3bVJBscbDS22r3/BanH9y3NW
        i2dHtS0mtG5ntji+fwm7xbFfwRbnz29gtzjb9Ibd4vKuOWwWn3uPMFrMOL+PyeLzhseMFrcb
        V7BZdB36y2ZxbeF7VosDFyeyWcxou8zqIOgxu+Eii8flvl4mj52z7rJ7LNhU6rFpVSebR8vJ
        /SwefVtWMXp83iQXwBHFZZOSmpNZllqkb5fAlTHxVmrBT72KnoaMBsZJ6l2MnBwSAiYSlyY3
        sncxcnEICaxglJh79TIzhPOFUaKr/T4jSJWQwGdGiea3aV2MHGAdVybrQISXM0pcaOWBqP/I
        KHH18DWwel4BO4n+Db/BbBYBVYnd1xYzQ8QFJU7OfMICYosKJEm8eXMVLC4sECvxpuE/K4jN
        LCAucevJfCYQW0QgXuLr6dmsIAuYBdYxS/Teeg3WwCZgKNH1tosNxOYUsJboOLyQCaJZXqJ5
        62ywDyQEdnNK3JmymAniTxeJX10LWSFsYYlXx7ewQ9gyEqcn97BAfJYv8XeGMUS4QuLa6zXM
        ELa1xJ1zv9hASpgFNCXW79KHCDtKNDZ8Y4Xo5JO48VYQ4gI+iUnbpjNDhHklOtqEIKrVJGYd
        Xwe38+CFS8wTGJVmIQXKLCTPz0LyyyyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefn
        bmIEJr3T/45/3cG44tVHvUOMTByMhxglOJiVRHhrmmuShHhTEiurUovy44tKc1KLDzFKc7Ao
        ifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAld29a73wkpaXS0pSpfVKEoOyNLVZ+QlysJqaf
        pnz5udVShGPK4R9yZ5jSv6p/v3hgSazny69rvmyKD7yged/laJS87aJ7c8MP9OetvnKbZ2K+
        gtbu/YslHkzRZnUNKjosL73987XE/tcn57yxO+DtaKThdiApvvO/X2thdHJH1HamcAn16D0J
        O34cznt3LdpGwoytXPfx/2/vzcTW1HE2+j/o/MFQI5LPwDjNYmr5kqj7jN0NZxi8Ln6t+/rO
        6dPc5XHc6bYmTcu3LE+5+6NWzKKCzXb7jCjuGcINCZPvv0jInyouwP6z9l1k14wFsvfLYvcc
        Nlu5+FL3yt+9zslMSa8PffGakPi7yfOEeqQSS3FGoqEWc1FxIgBOEJlG6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7pd3bVJBhvaZS22r3/BanH9y3NW
        i2dHtS0mtG5ntji+fwm7xbFfwRbnz29gtzjb9Ibd4vKuOWwWn3uPMFrMOL+PyeLzhseMFrcb
        V7BZdB36y2ZxbeF7VosDFyeyWcxou8zqIOgxu+Eii8flvl4mj52z7rJ7LNhU6rFpVSebR8vJ
        /SwefVtWMXp83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
        mpNZllqkb5eglzHxVmrBT72KnoaMBsZJ6l2MHBwSAiYSVybrdDFycQgJLGWU2LLzFVsXIydQ
        XEbi5LQGVghbWOLPtS42iKL3jBLLJ8xgAUnwCthJ9G/4zQhiswioSuy+tpgZIi4ocXLmExaQ
        BaICSRJHDvODhIUFYiXeNPwHm8ksIC5x68l8JhBbRCBe4ueUPmaQ+cwC65glli46zw6SEBLI
        ltgzvRGsiE3AUKLrbRfYcZwC1hIdhxcyQQwyk+ja2sUIYctLNG+dzTyBUWgWkjNmIdk3C0nL
        LCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG+rZjPzfvYJz36qPeIUYmDsZDjBIc
        zEoivDXNNUlCvCmJlVWpRfnxRaU5qcWHGE2BYTGRWUo0OR+YbPJK4g3NDEwNTcwsDUwtzYyV
        xHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg8dNcLli6XWO2jcPlKu6eviMqexOZ9z9c4cd1/
        clixNMhB8NRZnYVB3sc3ViyL237SNFoz+V74d9WlW+8+UA+acyJt/dJTElk8TyMnKqotUXHd
        U75l3zr9BWlvlnCZHVtXnc+jdVPD7a92Zq+U3K1E4WlbzjIcebOxdM2TJTIC7hum1TRonN3t
        Hcg98aFKoMEPw2Blnuxqe0arlltveDx1El0Wvpp29WHBxoANuoGFj2Ma02K+7g3Ti9td4PW4
        PW3dxLevn8U1qQaHP5INPSPxpWb50S+MLxfqqv9ZfN/qpkh16hc3wcVtnYZactmf1m2LKZ4Z
        M+2x3rWoprtRxW08HSL+q+ZqOEzkmib087YSS3FGoqEWc1FxIgD+wgK1fgMAAA==
X-CMS-MailID: 20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638
References: <20220511093554.17535-1-cw00.choi@samsung.com>
        <20220511093554.17535-3-cw00.choi@samsung.com>
        <CGME20220512223450eucas1p203b702e114dd2cd1bafcfd7d4c80b638@eucas1p2.samsung.com>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 11.05.2022 11:35, Chanwoo Choi wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
>
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure that the
> cache is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
>
> To achieve this, this patch adds support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjust the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
>
> To decide the frequency of the device, the governor does one of the
> following:
> * Derives the optimal devfreq device opp from required-opps property of
>    the parent cpu opp_table.
>
> * Scales the device frequency in proportion to the CPU frequency. So, if
>    the CPUs are running at their max frequency, the device runs at its
>    max frequency. If the CPUs are running at their min frequency, the
>    device runs at its min frequency. It is interpolated for frequencies
>    in between.
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [Chanwoo: Fix conflict with latest code and cleanup code]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

This patch landed in today's linux next-20220512 as commit 2ab415d4e4e6 
("PM / devfreq: Add cpu based scaling support to passive governor").

It triggers the following NULL pointer dereference on Exynos based boards:

exynos-bus: new bus device registered: soc:bus-leftbus (100000 KHz ~ 
200000 KHz)
exynos-bus: new bus device registered: soc:bus-rightbus (100000 KHz ~ 
200000 KHz)
exynos-bus: new bus device registered: soc:bus-display (160000 KHz ~ 
200000 KHz)
exynos-bus: new bus device registered: soc:bus-fsys (100000 KHz ~ 134000 
KHz)
exynos-bus: new bus device registered: soc:bus-peri ( 50000 KHz ~ 100000 
KHz)
exynos-bus: new bus device registered: soc:bus-mfc (100000 KHz ~ 200000 KHz)
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
[0000003c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 3 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc6-next-20220512 #5014
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: devfreq_wq devfreq_monitor
PC is at __mutex_lock+0x48/0x948
LR is at lock_is_held_type+0x104/0x1a4
pc : [<c0b93098>]    lr : [<c0b8f2ec>]    psr: 60000053
sp : f0889dc0  ip : 600000d3  fp : c1dca624
r10: c1dca44c  r9 : 00000000  r8 : c1984104
r7 : c1d7f000  r6 : 00000000  r5 : 00000001  r4 : 00000008
r3 : 00000000  r2 : 00000000  r1 : 2de44000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: NULL pointer
Register r7 information: slab task_struct start c1d7f000 pointer offset 0
Register r8 information: non-slab/vmalloc memory
Register r9 information: NULL pointer
Register r10 information: slab kmalloc-2k start c1dca000 pointer offset 
1100 size 2048
Register r11 information: slab kmalloc-2k start c1dca000 pointer offset 
1572 size 2048
Register r12 information: non-paged memory
Process kworker/u8:0 (pid: 8, stack limit = 0x(ptrval))
Stack: (0xf0889dc0 to 0xf088a000)
...
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from devfreq_passive_notifier_call+0x24/0x90
  devfreq_passive_notifier_call from srcu_notifier_call_chain+0x98/0x114
  srcu_notifier_call_chain from devfreq_set_target+0x6c/0x304
  devfreq_set_target from devfreq_update_target+0x98/0xe8
  devfreq_update_target from devfreq_monitor+0x28/0x1c0
  devfreq_monitor from process_one_work+0x288/0x774
  process_one_work from worker_thread+0x44/0x504
  worker_thread from kthread+0xf4/0x128
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0889fb0 to 0xf0889ff8)
...
---[ end trace 0000000000000000 ]---

The issue is caused by the lack of setting devfreq_passive_data->this 
pointer in devfreq_passive_register_notifier. However, after adding:

@@ -395,6 +395,9 @@ static int devfreq_passive_register_notifier(struct 
devfreq *devfreq)
         if (!parent)
                 return -EPROBE_DEFER;

+       if (!p_data->this)
+               p_data->this = devfreq;
+
         nb->notifier_call = devfreq_passive_notifier_call;
         return devfreq_register_notifier(parent, nb, 
DEVFREQ_TRANSITION_NOTIFIER);
  }

the NULL pointer dereference is gone, but I see the following warnings 
on Odroid U3 board, which were not present before this patch:

devfreq soc:bus-acp: failed to update devfreq using passive governor
devfreq soc:bus-c2c: failed to update devfreq using passive governor
devfreq soc:bus-acp: failed to update devfreq using passive governor
devfreq soc:bus-c2c: failed to update devfreq using passive governor


> ---
>   drivers/devfreq/governor.h         |  22 +++
>   drivers/devfreq/governor_passive.c | 297 +++++++++++++++++++++++++++--
>   include/linux/devfreq.h            |  17 +-
>   3 files changed, 322 insertions(+), 14 deletions(-)

 > ...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

