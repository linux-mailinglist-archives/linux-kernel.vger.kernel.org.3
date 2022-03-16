Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0984DA95F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbiCPEi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCPEi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:38:27 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74624266C;
        Tue, 15 Mar 2022 21:37:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5a8a8c1cdso1838677b3.3;
        Tue, 15 Mar 2022 21:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WrOaftrOYXhOc8YRNKza9k7ilsLRkietfu0L6H5bl4=;
        b=C2CYA9fviRP0AT73Jnb2hEul6HIY3WPFjgBUBz27XF+MA6snyAYu7mVZFm601W/Fb5
         d1Ba7RLOe3JDSV+T76EI17RD1ai+gYoZ2AmBDbCyfI1LcUqInbumzruwWyoraqoH4B9Q
         skr8N0rW6u3lxu5t3eKJL69Y+DJSf3G6MydDh1bpwNpThhUTT/s7a38s+gd7TsexXMoX
         p+hxsOxBvSgB8ttXCn7EBkRs3zO2kdttdBN2tNH4cKgqU2AwxEcyV8MrpFOfW8sl3fK1
         j5G8WEFkjuH5QVC/qQKAel0a8ig5Pibzsdrn4YEc0JS6LgTeHUrNZFVpM2A0woVg0nxb
         IhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WrOaftrOYXhOc8YRNKza9k7ilsLRkietfu0L6H5bl4=;
        b=wCEliKmtVrMpajS6UWyNLdZGj3INVYySVECtAgupavBB1D1IOUNs62KMwYHNyqOphp
         5fa+TkkB576Q1/tbZk3jc/fcngiGy1hiqu00MB+NWrAvBpby8sUaWzxWGJuNmhdokoYh
         Sv9JGdIzmB8g+CewIozZG/BmJLthJjGibjlLHO7Cz0fYDtz7/AgK+fwceBU7HjMBWYow
         bo4z6xeM8QJYGn+c6yq+JPw28qwXfL0FnJGco2aLXmUJ/OMXaucOv0QNmaBcrRROJ/Bl
         Yh+v+FGPgvs+8sFfiQLM//ur59h67mtMLfPg0fdEcsC6BjcGvUOOtPC0G/HKZybxCvt8
         NTNg==
X-Gm-Message-State: AOAM533yAAERGzDdruYcA5Ev6g1rQk0zujpR06adAxhkpT0hmvgtCO/m
        S1dEDOdghcq9rftOBTxypyZMy03XzjzaeSnNQaY=
X-Google-Smtp-Source: ABdhPJzvgD+wHokx0xa4G2qEhzbL2XNtG+pgg7JGz3GWzvma7u084w4kmXuS2TOk90fkpr9DMno6LJhsSzbDB/a7ATI=
X-Received: by 2002:a81:a0d6:0:b0:2dc:3bce:140c with SMTP id
 x205-20020a81a0d6000000b002dc3bce140cmr30347262ywg.190.1647405432620; Tue, 15
 Mar 2022 21:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
 <20220314233812.9011-1-21cnbao@gmail.com> <CAOUHufa9eY44QadfGTzsxa2=hEvqwahXd7Canck5Gt-N6c4UKA@mail.gmail.com>
 <CAGsJ_4zvj5rmz7DkW-kJx+jmUT9G8muLJ9De--NZma9ey0Oavw@mail.gmail.com>
 <CAGsJ_4zZc0oFSmBKAN77vm7VstQH=ieaQ0cfyvcMi3OQRrEpSg@mail.gmail.com> <CAOUHufau34de-FmdBxNHpWWUUuN4DxT1fci9aX8Uc+RAfVXwXw@mail.gmail.com>
In-Reply-To: <CAOUHufau34de-FmdBxNHpWWUUuN4DxT1fci9aX8Uc+RAfVXwXw@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 16 Mar 2022 17:37:01 +1300
Message-ID: <CAGsJ_4waTOj=zzC+gZAVMW5SQ_b9UWcXjKv3oj57s-YysTQmPw@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Michael Larabel <Michael@michaellarabel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Carr <d@chaos-reins.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 3:47 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Mar 15, 2022 at 4:29 AM Barry Song <21cnbao@gmail.com> wrote:
>
> <snipped>
>
> > > I guess the main cause of the regression for the previous sequence
> > > with 16 entries is that the ebizzy has a new allocated copy in
> > > search_mem(), which is mapped and used only once in each loop.
> > > and the temp copy can push out those hot chunks.
> > >
> > > Anyway, I understand it is a trade-off between warmly embracing new
> > > pages and holding old pages tightly. Real user cases from phone, server,
> > > desktop will be judging this better.
>
> Thanks for all the details. I looked into them today and found no
> regressions when running with your original program.
>
> After I explain why, I hope you'd be convinced that using programs
> like this one is not a good way to measure things :)
>

Yep. I agree ebizzy might not be a good one to measure things.
I chose it only because Kim's patchset which moved anon pages
to inactive at the first detected access  was using it. Before kim's
patchset, anon pages were placed in the active list from the first
beginning:
https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/

in ebizzy, there is a used-once allocated memory in each
search_mem(). I guess that is why Kim's patchset chose
it.

> Problems:
> 1) Given the 2.5GB configuration and a sequence of cold/hot chunks, I
> assume your program tries to simulate a handful of apps running on a
> phone.  A short repeating sequence is closer to sequential access than
> to real user behaviors, as I suggested last time. You could check out
> how something similar is done here [1].
> 2) Under the same assumption (phone), C programs are very different
> from Android apps in terms of runtime memory behaviors, e.g., JVM GC
> [2].
> 3) Assuming you are interested in the runtime memory behavior of C/C++
> programs, your program is still not very representative. All C/C++
> programs I'm familiar with choose to link against TCmalloc, jemalloc
> or implement their own allocators. GNU libc, IMO, has a small market
> share nowadays.
> 4) TCmalloc/jemalloc are not only optimized for multithreading, they
> are also THP aware. THP is very important when benchmarking page
> reclaim, e.g., two similarly warm THPs can comprise 511+1 or 1+511 of
> warm+cold 4K pages. The LRU algorithm that chooses more of the former
> is at the disadvantage. Unless it's recommended by the applications
> you are trying to benchmark, THP should be disabled. (Android
> generally doesn't use THP.)
> 5) Swap devices are also important. Zram should NOT be used unless you
> know your benchmark doesn't generate incompressible data. The LRU
> algorithm that chooses more incompressible pages is at disadvantage.
>

Thanks for all the information above. very useful.

> Here is my result: on the same Snapdragon 7c + 2.5GB RAM + 1.5GB
> ramdisk swap, with your original program compiled against libc malloc
> and TCMalloc, to 32-bit and 64-bit binaries:

I noticed an important difference is that you are using ramdisk, so there
is no cost on "i/o". I assume compression/decompression is the i/o cost to
zRAM.

>
> # cat /sys/kernel/mm/lru_gen/enabled
> 0x0003
> # cat /sys/kernel/mm/transparent_hugepage/enabled
> always madvise [never]
>
> # modprobe brd rd_nr=1 rd_size=1572864
> # if=/dev/zero of=/dev/ram0 bs=1M
> # mkswap /dev/ram0
> # swapoff -a
> # swapon /dev/ram0
>
> # ldd test_absl_32
>         linux-vdso.so.1 (0xf6e7f000)
>         libabsl_malloc.so.2103.0.1 =>
> /usr/lib/libabsl_malloc.so.2103.0.1 (0xf6e23000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xf6dff000)
>         libc.so.6 => /lib/libc.so.6 (0xf6d07000)
>         /lib/ld-linux-armhf.so.3 (0x09df0000)
>         libabsl_base.so.2103.0.1 => /usr/lib/libabsl_base.so.2103.0.1
> (0xf6ce5000)
>         libabsl_raw_logging.so.2103.0.1 =>
> /usr/lib/libabsl_raw_logging.so.2103.0.1 (0xf6cc4000)
>         libabsl_spinlock_wait.so.2103.0.1 =>
> /usr/lib/libabsl_spinlock_wait.so.2103.0.1 (0xf6ca3000)
>         libc++.so.1 => /usr/lib/libc++.so.1 (0xf6c04000)
>         libc++abi.so.1 => /usr/lib/libc++abi.so.1 (0xf6bcd000)
> # file test_absl_64
> test_absl_64: ELF 64-bit LSB executable, ARM aarch64, version 1
> (SYSV), statically linked
> # ldd test_gnu_32
>         linux-vdso.so.1 (0xeabef000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xeab92000)
>         libc.so.6 => /lib/libc.so.6 (0xeaa9a000)
>         /lib/ld-linux-armhf.so.3 (0x05690000)
> # file test_gnu_64
> test_gnu_64: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV),
> statically linked
>
> ### baseline 5.17-rc8
>
> # perf record ./test_gnu_64 -t 4 -s $((200*1024*1024)) -S 6000000
> 10 records/s
> real 59.00 s
> user 39.83 s
> sys  174.18 s
>
>     18.51%  [.] memcpy
>     15.98%  [k] __pi_clear_page
>      5.59%  [k] rmqueue_pcplist
>      5.19%  [k] do_raw_spin_lock
>      5.09%  [k] memmove
>      4.60%  [k] _raw_spin_unlock_irq
>      3.62%  [k] _raw_spin_unlock_irqrestore
>      3.61%  [k] free_unref_page_list
>      3.29%  [k] zap_pte_range
>      2.53%  [k] local_daif_restore
>      2.50%  [k] down_read_trylock
>      1.41%  [k] handle_mm_fault
>      1.32%  [k] do_anonymous_page
>      1.31%  [k] up_read
>      1.03%  [k] free_swap_cache
>
> ### MGLRU v9
>
> # perf record ./test_gnu_64 -t 4 -s $((200*1024*1024)) -S 6000000
> 11 records/s
> real 57.00 s
> user 39.39 s
>
>     19.36%  [.] memcpy
>     16.50%  [k] __pi_clear_page
>      6.21%  [k] memmove
>      5.57%  [k] rmqueue_pcplist
>      5.07%  [k] do_raw_spin_lock
>      4.96%  [k] _raw_spin_unlock_irqrestore
>      4.25%  [k] free_unref_page_list
>      3.80%  [k] zap_pte_range
>      3.69%  [k] _raw_spin_unlock_irq
>      2.71%  [k] local_daif_restore
>      2.10%  [k] down_read_trylock
>      1.50%  [k] handle_mm_fault
>      1.29%  [k] do_anonymous_page
>      1.17%  [k] free_swap_cache
>      1.08%  [k] up_read
>

I think your result is right. but if you take a look at the number of
major faults, will you find mglru have more page faults?
i ask this question because i can see mglru even wins with lower
hit ratio in the previous report I sent.

> [1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/+/refs/heads/main/src/chromiumos/tast/local/memory/mempressure/mempressure.go
> [2] https://developer.android.com/topic/performance/memory-overview

Thanks
Barry
