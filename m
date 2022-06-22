Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCC554999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbiFVJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbiFVJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:16:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8144F62E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:16:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso1285298pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r3OCePRAU6CHUwZ+8IsXDeKrnwn43yWY5sOfCn3kLbQ=;
        b=MREgIwFBfb0WS5TmXBjXPd7ZK3Noxsnf+935uTosWx5Jx22OUQColcGy865Hm063oe
         cwN6J+cBlAHICjuvYQ7ediamTkFngNnX9frH+bBpxHjucRY09GrVkDtgE2Sbm26a5TfX
         td8GYKoUAZVO1Zf9f6y4b15+XZK4+C7lBetjNHP4evkWHA0ZurA2kOAsaU63KedHK4vd
         qng3VEr7SFFKJNRrVmssjVA/uYk21hy1YONa5auxJCAhmp4/tm2xeDRS37xiwDLr9fe7
         /p0JoQc+LoqbkuE94P/4wwrgdl80lZEasggpZenF584jLklGUQmcZ/gS1Kg3LXqiL2iE
         Gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r3OCePRAU6CHUwZ+8IsXDeKrnwn43yWY5sOfCn3kLbQ=;
        b=Y/I9bKwRgjj2v6uvDM6i35dh7uc7fL+E7OhG2A5GZOkGTH7IF0F/89UxTDEHaeeRw6
         Iwy5PFl9Zn4+DupcUk/+eJCDDePZdum/1TjwJssEn5RvazYHDJvWTaKtpxUUwWB2naKR
         rgu4zAF8VP9KhUMJtpC1DaeK36HT/92OC2H5VQEkyb9jZtRY4hM9berbLCGF0QhIqwvx
         oUJ1BRvPDipC+s3qxknTReRGr7HhBq2vdW+Y5zU2x5r9Yg9xJBDzPtpXKGfRrU1fF5F0
         nrYYGR0TDiZxHy8pClMqaxTHRunC+Xt6hNE5lzi7UV6iCXOBP2wlLe6rZ0xazXFrr1py
         Qq4w==
X-Gm-Message-State: AJIora+7ukfQDuSRI0+ggTOGjO4DQ06q9kE/657FuH+p2x5HhBn6iQf5
        HlYkbb9wjHSchtoLYw3/wrftmA==
X-Google-Smtp-Source: AGRyM1uoLV75q763zHawCFFTUGGoYyd+3Kfbn5wjvmNM/OR2iTX2AbONQF/vOOv05okzwXQlcYE8Lw==
X-Received: by 2002:a17:90a:428f:b0:1ec:888b:f1d3 with SMTP id p15-20020a17090a428f00b001ec888bf1d3mr25304778pjg.201.1655889403882;
        Wed, 22 Jun 2022 02:16:43 -0700 (PDT)
Received: from [10.4.214.173] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902d64500b001641a68f1c7sm12177873plh.273.2022.06.22.02.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:16:43 -0700 (PDT)
Message-ID: <214db251-827c-715c-54cf-9c0e9bb5fe30@bytedance.com>
Date:   Wed, 22 Jun 2022 17:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v12 12/14] mm: multi-gen LRU: debugfs interface
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220614071650.206064-1-yuzhao@google.com>
 <20220614071650.206064-13-yuzhao@google.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220614071650.206064-13-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 15:16, Yu Zhao wrote:
> Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> reclaim. These techniques are commonly used to optimize job scheduling
> (bin packing) in data centers [1][2].
> 
> Compared with the page table-based approach and the PFN-based
> approach, this lruvec-based approach has the following advantages:
> 1. It offers better choices because it is aware of memcgs, NUMA nodes,
>     shared mappings and unmapped page cache.
> 2. It is more scalable because it is O(nr_hot_pages), whereas the
>     PFN-based approach is O(nr_total_pages).
> 
> Add /sys/kernel/debug/lru_gen_full for debugging.
> 
> [1] https://dl.acm.org/doi/10.1145/3297858.3304053
> [2] https://dl.acm.org/doi/10.1145/3503222.3507731
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>   include/linux/nodemask.h |   1 +
>   mm/vmscan.c              | 412 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 403 insertions(+), 10 deletions(-)
> 

Hi Yu,

> +static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
> +				 size_t len, loff_t *pos)
> +{
> +	void *buf;
> +	char *cur, *next;
> +	unsigned int flags;
> +	struct blk_plug plug;
> +	int err = -EINVAL;
> +	struct scan_control sc = {
> +		.may_writepage = true,
> +		.may_unmap = true,
> +		.may_swap = true,
> +		.reclaim_idx = MAX_NR_ZONES - 1,
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +
> +	buf = kvmalloc(len + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buf, src, len)) {
> +		kvfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	if (!set_mm_walk(NULL)) {

The current->reclaim_state will be dereferenced in set_mm_walk(), so
calling set_mm_walk() before set_task_reclaim_state(current,
&sc.reclaim_state) will cause panic:

[ 1861.154916] BUG: kernel NULL pointer dereference, address: 
0000000000000008
[ 1861.155720] #PF: supervisor read access in kernel mode
[ 1861.156263] #PF: error_code(0x0000) - not-present page
[ 1861.156805] PGD 0 P4D 0
[ 1861.157107] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1861.157560] CPU: 5 PID: 1017 Comm: bash Not tainted 5.19.0-rc2+ #244
[ 1861.158227] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.14.0-0-g14
[ 1861.159419] RIP: 0010:set_mm_walk+0x15/0x60
[ 1861.159878] Code: e8 30 5f 01 00 48 c7 43 70 00 00 00 00 5b c3 31 f6 
eb e2 66 90 0f 1f f
[ 1861.161806] RSP: 0018:ffffc90006dd3d58 EFLAGS: 00010246
[ 1861.162356] RAX: 0000000000000000 RBX: 00005582747a70b0 RCX: 
0000000000000000
[ 1861.163109] RDX: ffff88810a198000 RSI: 00005582747a70c1 RDI: 
0000000000000000
[ 1861.163855] RBP: ffff888104f4e400 R08: 0000000000000000 R09: 
ffff888100042400
[ 1861.164597] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff888685896fc0
[ 1861.165334] R13: 00005582747a70b0 R14: ffff888103ef2e40 R15: 
0000000000000011
[ 1861.166083] FS:  00007f843df57740(0000) GS:ffff888666b40000(0000) 
knlGS:0000000000000000
[ 1861.166921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1861.167527] CR2: 0000000000000008 CR3: 0000000684e7e000 CR4: 
00000000000006e0
[ 1861.168272] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1861.169020] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1861.169867] Call Trace:
[ 1861.170159]  <TASK>
[ 1861.170396]  lru_gen_seq_write+0xbf/0x600
[ 1861.170837]  ? _raw_spin_unlock+0x15/0x30
[ 1861.171272]  ? wp_page_reuse+0x5f/0x70
[ 1861.171678]  ? do_wp_page+0xda/0x3e0
[ 1861.172063]  ? __handle_mm_fault+0x92f/0xeb0
[ 1861.172529]  full_proxy_write+0x4d/0x70
[ 1861.172941]  vfs_write+0xb8/0x2a0
[ 1861.173302]  ksys_write+0x59/0xd0
[ 1861.173667]  do_syscall_64+0x34/0x80
[ 1861.174055]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

> +		kvfree(buf);
> +		return -ENOMEM;
> +	}
> +
> +	set_task_reclaim_state(current, &sc.reclaim_state);
> +	flags = memalloc_noreclaim_save();
> +	blk_start_plug(&plug);
> +
> +	next = buf;
> +	next[len] = '\0';
> +
> +	while ((cur = strsep(&next, ",;\n"))) {
> +		int n;
> +		int end;
> +		char cmd;
> +		unsigned int memcg_id;
> +		unsigned int nid;
> +		unsigned long seq;
> +		unsigned int swappiness = -1;
> +		unsigned long opt = -1;
> +
> +		cur = skip_spaces(cur);
> +		if (!*cur)
> +			continue;
> +
> +		n = sscanf(cur, "%c %u %u %lu %n %u %n %lu %n", &cmd, &memcg_id, &nid,
> +			   &seq, &end, &swappiness, &end, &opt, &end);
> +		if (n < 4 || cur[end]) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		err = run_cmd(cmd, memcg_id, nid, seq, &sc, swappiness, opt);
> +		if (err)
> +			break;
> +	}
> +
> +	blk_finish_plug(&plug);
> +	memalloc_noreclaim_restore(flags);
> +	set_task_reclaim_state(current, NULL);
> +
> +	clear_mm_walk();

Ditto, we can't call clear_mm_walk() after 
set_task_reclaim_state(current, NULL).

Maybe it can be modified as follows:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2422edc786eb..552e6ae5243e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5569,12 +5569,12 @@ static ssize_t lru_gen_seq_write(struct file 
*file, const char __user *src,
                 return -EFAULT;
         }

+       set_task_reclaim_state(current, &sc.reclaim_state);
         if (!set_mm_walk(NULL)) {
                 kvfree(buf);
                 return -ENOMEM;
         }

-       set_task_reclaim_state(current, &sc.reclaim_state);
         flags = memalloc_noreclaim_save();
         blk_start_plug(&plug);

@@ -5609,9 +5609,9 @@ static ssize_t lru_gen_seq_write(struct file 
*file, const char __user *src,

         blk_finish_plug(&plug);
         memalloc_noreclaim_restore(flags);
+       clear_mm_walk();
         set_task_reclaim_state(current, NULL);

-       clear_mm_walk();
         kvfree(buf);

         return err ? : len;

Thanks,
Qi

> +	kvfree(buf);
> +
> +	return err ? : len;
> +}
> +


-- 
Thanks,
Qi
