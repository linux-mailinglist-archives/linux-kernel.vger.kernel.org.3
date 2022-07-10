Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036B56CC5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJCUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:20:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157D248E2;
        Sat,  9 Jul 2022 19:20:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 70so2152840pfx.1;
        Sat, 09 Jul 2022 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wX3dLYovPqvcyaF+fwNCYWsC056jAjNyoNmTlmS8iW0=;
        b=Fl5FCM+pGOAju0nqPaLwlLQRU3DgIn2U3VjWbrKUgfZNasnd8+3wJB2GSCasxbzHPt
         BgqW0HYecXPR9ONL1bsDWWH8qEffILRvUoodJ6fmVcQsoQGKMcz0GMsn7FRsS/nSDbEC
         nhI18OgpQbarufSB4YvZra8eU6tNyjhk4Ojy7eOnZgCpQWVdbSz2WkJfVcnXCtv7gdka
         P2AdeBN7TOhBoHLuuL6WYycvPAoThV6sDmtdpPO+de00As4TgQp7ibrDfdZFLawcmwO1
         Jbvls1bojQ586hbBCkJqccW2lXmiD9bNvasjdFtaEkvQRfeYYEwjA61jOKIUNAulWS0p
         sbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wX3dLYovPqvcyaF+fwNCYWsC056jAjNyoNmTlmS8iW0=;
        b=xrEgNk+v7f8Jkl8Td3qTDMMsu81uDIl+TTE8UetRwx6BefbbjTum9VcFxh0Vw/9p6C
         qrYIWcqqPd6HHt3Dv2Sp7SMKBP1gwIUBEiPq4QXFd+FsgqJSwlXSWycIhekpnCXf/U+t
         EmuB/14vC+PIUxJVSo8FSHrg4dzJKzyNhCqGcKABXglVlXhVQu1sX1pysDVd9qkC2Cbg
         WeqTdHAmjzzBfMSUDX8oY04gEiu5EOA0Pp9G7tl9M56fK2XYNeA5EMAdL5Geu/fHmuhC
         XtTMkCXCDDwrCgRMF0PHy2LmN/Dup6FC9vzRPOvW2XsRimaPTSXdLRzwiNeM9B5FSipC
         AfIA==
X-Gm-Message-State: AJIora+iEqmwuGfA33oQxdINzzt8kTlN+auDv3anI0a5U/a9ziI8U8H1
        0jLGK5f/AGbBfdlG+rGwbSo=
X-Google-Smtp-Source: AGRyM1v4U8y46pN2FJKMAahBzHzOqEiA1OvGWb+6E+WV/4gA21PixpT9UD1eGmwQQVQbgyJDxcphRA==
X-Received: by 2002:a63:ec03:0:b0:40d:e79d:e22e with SMTP id j3-20020a63ec03000000b0040de79de22emr10315114pgh.53.1657419615561;
        Sat, 09 Jul 2022 19:20:15 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016405375132sm1965706plb.25.2022.07.09.19.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 19:20:14 -0700 (PDT)
Message-ID: <f88e270d-4552-0e30-53ef-e6803fbe3afb@gmail.com>
Date:   Sun, 10 Jul 2022 09:20:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 13/14] mm: multi-gen LRU: admin guide
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
References: <20220706220022.968789-1-yuzhao@google.com>
 <20220706220022.968789-14-yuzhao@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220706220022.968789-14-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 05:00, Yu Zhao wrote:
> Add an admin guide.
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
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  Documentation/admin-guide/mm/multigen_lru.rst | 156 ++++++++++++++++++
>  mm/Kconfig                                    |   3 +-
>  mm/vmscan.c                                   |   4 +
>  4 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
> 
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index c21b5823f126..2cf5bae62036 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -32,6 +32,7 @@ the Linux memory management.
>     idle_page_tracking
>     ksm
>     memory-hotplug
> +   multigen_lru
>     nommu-mmap
>     numa_memory_policy
>     numaperf
> diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
> new file mode 100644
> index 000000000000..6355f2b5019d
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/multigen_lru.rst
> @@ -0,0 +1,156 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Multi-Gen LRU
> +=============
> +The multi-gen LRU is an alternative LRU implementation that optimizes
> +page reclaim and improves performance under memory pressure. Page
> +reclaim decides the kernel's caching policy and ability to overcommit
> +memory. It directly impacts the kswapd CPU usage and RAM efficiency.
> +
> +Quick start
> +===========
> +Build the kernel with the following configurations.
> +
> +* ``CONFIG_LRU_GEN=y``
> +* ``CONFIG_LRU_GEN_ENABLED=y``
> +
> +All set!
> +
> +Runtime options
> +===============
> +``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
> +following subsections.
> +
> +Kill switch
> +-----------
> +``enabled`` accepts different values to enable or disable the
> +following components. Its default value depends on
> +``CONFIG_LRU_GEN_ENABLED``. All the components should be enabled
> +unless some of them have unforeseen side effects. Writing to
> +``enabled`` has no effect when a component is not supported by the
> +hardware, and valid values will be accepted even when the main switch
> +is off.
> +
> +====== ===============================================================
> +Values Components
> +====== ===============================================================
> +0x0001 The main switch for the multi-gen LRU.
> +0x0002 Clearing the accessed bit in leaf page table entries in large
> +       batches, when MMU sets it (e.g., on x86). This behavior can
> +       theoretically worsen lock contention (mmap_lock). If it is
> +       disabled, the multi-gen LRU will suffer a minor performance
> +       degradation for workloads that contiguously map hot pages,
> +       whose accessed bits can be otherwise cleared by fewer larger
> +       batches.
> +0x0004 Clearing the accessed bit in non-leaf page table entries as
> +       well, when MMU sets it (e.g., on x86). This behavior was not
> +       verified on x86 varieties other than Intel and AMD. If it is
> +       disabled, the multi-gen LRU will suffer a negligible
> +       performance degradation.
> +[yYnN] Apply to all the components above.
> +====== ===============================================================
> +
> +E.g.,
> +::

In this case, it would be better to say "For example".

> +
> +    echo y >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0007
> +    echo 5 >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0005
> +
> +Thrashing prevention
> +--------------------
> +Personal computers are more sensitive to thrashing because it can
> +cause janks (lags when rendering UI) and negatively impact user
> +experience. The multi-gen LRU offers thrashing prevention to the
> +majority of laptop and desktop users who do not have ``oomd``.
> +
> +Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
> +``N`` milliseconds from getting evicted. The OOM killer is triggered
> +if this working set cannot be kept in memory. In other words, this
> +option works as an adjustable pressure relief valve, and when open, it
> +terminates applications that are hopefully not being used.
> +
> +Based on the average human detectable lag (~100ms), ``N=1000`` usually
> +eliminates intolerable janks due to thrashing. Larger values like
> +``N=3000`` make janks less noticeable at the risk of premature OOM
> +kills.
> +
> +The default value ``0`` means disabled.
> +
> +Experimental features
> +=====================
> +``/sys/kernel/debug/lru_gen`` accepts commands described in the
> +following subsections. Multiple command lines are supported, so does
> +concatenation with delimiters ``,`` and ``;``.
> +
> +``/sys/kernel/debug/lru_gen_full`` provides additional stats for
> +debugging. ``CONFIG_LRU_GEN_STATS=y`` keeps historical stats from
> +evicted generations in this file.
> +
> +Working set estimation
> +----------------------
> +Working set estimation measures how much memory an application needs
> +in a given time interval, and it is usually done with little impact on
> +the performance of the application. E.g., data centers want to
> +optimize job scheduling (bin packing) to improve memory utilizations.
> +When a new job comes in, the job scheduler needs to find out whether
> +each server it manages can allocate a certain amount of memory for
> +this new job before it can pick a candidate. To do so, the job
> +scheduler needs to estimate the working sets of the existing jobs.
> +
> +When it is read, ``lru_gen`` returns a histogram of numbers of pages
> +accessed over different time intervals for each memcg and node.
> +``MAX_NR_GENS`` decides the number of bins for each histogram. The
> +histograms are noncumulative.
> +::
> +
> +    memcg  memcg_id  memcg_path
> +       node  node_id
> +           min_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +           ...
> +           max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +
> +Each bin contains an estimated number of pages that have been accessed
> +within ``age_in_ms``. E.g., ``min_gen_nr`` contains the coldest pages
> +and ``max_gen_nr`` contains the hottest pages, since ``age_in_ms`` of
> +the former is the largest and that of the latter is the smallest.
> +
> +Users can write ``+ memcg_id node_id max_gen_nr
> +[can_swap [force_scan]]`` to ``lru_gen`` to create a new generation
> +``max_gen_nr+1``. ``can_swap`` defaults to the swap setting and, if it
> +is set to ``1``, it forces the scan of anon pages when swap is off,
> +and vice versa. ``force_scan`` defaults to ``1`` and, if it is set to
> +``0``, it employs heuristics to reduce the overhead, which is likely
> +to reduce the coverage as well.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen`` at a
> +certain time interval to create new generations, and it ranks the
> +servers it manages based on the sizes of their cold pages defined by
> +this time interval.
> +
> +Proactive reclaim
> +-----------------
> +Proactive reclaim induces page reclaim when there is no memory
> +pressure. It usually targets cold pages only. E.g., when a new job
> +comes in, the job scheduler wants to proactively reclaim cold pages on
> +the server it selected to improve the chance of successfully landing
> +this new job.
> +
> +Users can write ``- memcg_id node_id min_gen_nr [swappiness
> +[nr_to_reclaim]]`` to ``lru_gen`` to evict generations less than or
> +equal to ``min_gen_nr``. Note that ``min_gen_nr`` should be less than
> +``max_gen_nr-1`` as ``max_gen_nr`` and ``max_gen_nr-1`` are not fully
> +aged and therefore cannot be evicted. ``swappiness`` overrides the
> +default value in ``/proc/sys/vm/swappiness``. ``nr_to_reclaim`` limits
> +the number of pages to evict.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen``
> +before it tries to land a new job on a server. If it fails to
> +materialize enough cold pages because of the overestimation, it
> +retries on the next server according to the ranking result obtained
> +from the working set estimation step. This less forceful approach
> +limits the impacts on the existing jobs.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0c2ef0af0036..a0f7b6e66410 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1137,7 +1137,8 @@ config LRU_GEN
>  	# make sure folio->flags has enough spare bits
>  	depends on 64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP
>  	help
> -	  A high performance LRU implementation to overcommit memory.
> +	  A high performance LRU implementation to overcommit memory. See
> +	  Documentation/admin-guide/mm/multigen_lru.rst for details.
>  
>  config LRU_GEN_ENABLED
>  	bool "Enable by default"
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fbcd298adca7..7096ff7836db 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5209,6 +5209,7 @@ static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *attr, c
>  	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
>  			     const char *buf, size_t len)
>  {
> @@ -5242,6 +5243,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>  	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
>  			     const char *buf, size_t len)
>  {
> @@ -5389,6 +5391,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
>  	seq_putc(m, '\n');
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static int lru_gen_seq_show(struct seq_file *m, void *v)
>  {
>  	unsigned long seq;
> @@ -5547,6 +5550,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
>  	return err;
>  }
>  
> +/* see Documentation/admin-guide/mm/multigen_lru.rst for details */
>  static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>  				 size_t len, loff_t *pos)
>  {

Otherwise looks good (no new warnings).

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
