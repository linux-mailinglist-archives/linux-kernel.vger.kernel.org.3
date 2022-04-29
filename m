Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8167C51580E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381441AbiD2WPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381434AbiD2WPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:15:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B43DCA9A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so16874997ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQmy1DozY+MQOT3hFFbQpwCpNXFgxLxF1Kty1xOxQWk=;
        b=NXqbBHZ9VwKIGp+CDR7YbK8pDPAtXozUwHomoZTwJmAZ2M3hstU8pa1vh7vhM4oOf8
         yKlzpf12tt3NEbYWw/M3P2JssWpEIlYCNGtpE20iS30ujXNRHzhWXTR/TS9X+H6QVMqv
         RmFG5RG94XX0N/XsMzpk7hJ8g/y6PNSmuAvfoWguTAm8NZWeh/xflsMvQpd+dKRWmZrL
         bFsRsKO9rJg47tTn2cjJqVWrVuHf81ODE/rxIVKA6yp0cALACqLr1pdjwakTPIH1FrNB
         ZwyPw69sPfUuQVP9+cm4VRXVZoCdkgL6LujmOptTta/Igd85lrUN3OYsWDikeNfwUynu
         lKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQmy1DozY+MQOT3hFFbQpwCpNXFgxLxF1Kty1xOxQWk=;
        b=faPCpvtdeKLLOWpvUXou5fqMUSYfI/XEPdWWPkDEL0MbmRulEujk6P2jTETN39rMej
         jnQxk4bSgDLN2m3XqjdFzUHy9Ut4+BRUNim6zBGBVYOnzm0T/vrqLMKca+1QI/OrNVJW
         IA92bHJnvRZePRbE9ybhoJVYpvWd6oE+Drast5BrvmOb4qvQJGZh00lGwph4ZL3nLfQf
         NQcqOi1Pl2skblUNCSWrXc3rBFyJgJUntMibyuBVmlFQOs7D8YfIDcJMHrHYrxFAXM7e
         6lBCaDTw1x59f+v834nFc66who/RluGdYAhYVH0AwaVxT5hiN3b2VtUCXeeUamumlHkC
         NFnA==
X-Gm-Message-State: AOAM531gXQTRRN1wWtG19RjPfaMWQj/gVqzET9VBjJqQ6TbwXPT/zgl+
        PovvnbCQ/wg3FJyE3bisefWod6/n8JrM1Jf4smDO75qSJeQ=
X-Google-Smtp-Source: ABdhPJxzIJP/0PkOy5+GtHE3C3pGZwvHAQEfBkVhZ6+DOtcVRXUTJB9lIYq49Ni06eLmgj6PImuYp5yRHVO65D+B7j0=
X-Received: by 2002:a25:242:0:b0:648:76ff:88a8 with SMTP id
 63-20020a250242000000b0064876ff88a8mr1646913ybc.603.1651270313696; Fri, 29
 Apr 2022 15:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com>
 <20220429160317.GA71@qian>
In-Reply-To: <20220429160317.GA71@qian>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 30 Apr 2022 03:41:41 +0530
Message-ID: <CA+G9fYui9OuyFbg7SV8D_4ueC_Jc=71ybbhBeif0bczo957Hqg@mail.gmail.com>
Subject: Re: [next] mm: libhugetlbfs: WARNING: at mm/page_alloc.c:5368 __alloc_pages
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chen Wandun <chenwandun@huawei.com>, NeilBrown <neilb@suse.de>,
        joao.m.martins@oracle.com, mawupeng1@huawei.com,
        Wei Yang <richard.weiyang@gmail.com>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 at 21:33, Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Fri, Apr 29, 2022 at 04:50:25PM +0530, Naresh Kamboju wrote:
> > Following kernel warning notices on Linux next-20220427 till date next-20220429
> > on qemu_arm64 and arm64 devices.
> >
> > While testing libhugetlbfs test suite and ltp mm and hugetlb.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Test log:
> > ----------
> > truncate_above_4GB (2M: 64): PASS
> > brk_near_huge (2M: 64): brk_near_huge: malloc.c:2401: sysmalloc:
> > Assertion `(old_top == initial_top (av) && old_size == 0) ||
> > ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) &&
> > ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
> > [   15.685019] audit: type=1701 audit(1651222753.772:25):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 pid=454
> > comm=\"brk_near_huge\"
> > exe=\"/usr/lib/libhugetlbfs/tests/obj64/brk_near_huge\" sig=6 res=1
> > [   15.685629] ------------[ cut here ]------------
> > [   15.685631] WARNING: CPU: 2 PID: 454 at mm/page_alloc.c:5368
>
> Naresh, I am having difficult to reproduce this reliablely. If you have
> spare cycles, do you mind reverting those to see if you can still
> reproduce? I can't seems to find other recent commits more suspicious
> than that series.
>
> 37e73e3b0a9d drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
> d2b9cd2acb2b mm: cma: use pageblock_order as the single alignment
> 7f125582227e mm: page_isolation: enable arbitrary range page isolation.
> fb009b307b21 mm: make alloc_contig_range work at pageblock granularity
> 7c7e18d510f4 mm: page_isolation: check specified range for unmovable pages
> 6a242a94b883 mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
>
> $ git revert --no-edit e389355485b7..37e73e3b0a9d

The reported kernel warning was not solved by reverted above patches.


- Naresh
