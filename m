Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66324F21CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiDEDw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiDEDwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:52:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED482AC75
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:50:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d138so12811630ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeIlPBykaaoOQQ8YagbDwarHCQQ/nrdr/5DasCXPXhU=;
        b=wneh0BiXc+5llZgked4jWuiU/DBGvp91kCAV1p0+Bk/v0mKdq3eNhoPxFpl4Qr6JNz
         I2BPx4rs+GpJLmuw0bVzUjLJQmXtkYyVVyTS/+c9WHWC9IwZM5nkJ7+BTsFdriHTFSJr
         lTBju3CN3ktZXrYOAMvEv4QwM/t+Es5VVfI6r4dfcNnrBJCcCJHJToHHCjsBYgrNJUwg
         Mrgh27PPtbfCYjkuHgr1wJvJFaTd8eDgNGRqhTs3Ct/Dn91bINafMkD+cpT3JnIT924q
         6WemLZYZIET3loPw/ZsP/scr1vVwajweZs82K5JS/dh4C3/pXOmny1DoKiFETFZq2uk7
         ZYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeIlPBykaaoOQQ8YagbDwarHCQQ/nrdr/5DasCXPXhU=;
        b=rA0CuFHrk0NJX536jaJnR4ujtQO/BknbXX/F18bXdiQqANfU/J+4UDWtCs7GV5FSPj
         JRyjp1S1UCbJMVNnBP/BqIIq3Ix/xjQ6WtEyxyBHwYebeS6uQH+J6/w5yOVIY2uGXMDp
         CBtVLSP1MLAT638KbWrvIL2N+gS0aklFkplMYBqAELs+Dp1GQQQVDz3DPqe1jNGLEX7h
         j/q2RG9cSvPxfiW/PRJv5urGWrCmh19nBmj/pSsEtCq3xTVoHbm1CnCswWeawas/awKU
         cLHkmFWtjRXgzl9U7tBH6GE1a/Rssd3gX5c2+89JqlbJP3yAlTqlgQApfkUT9cFrNawF
         NcYQ==
X-Gm-Message-State: AOAM532oyciYK6I1jxLKdn3KqUtit3zpco3dCh1l3/HZg+KKZNeUfzcM
        axHXVKXZW/v2NEZLWPrr9aoZgRmCQEOhouMv6jdiOQ==
X-Google-Smtp-Source: ABdhPJxmMeHW15bgG0AdZv0n4c1UsCDtlJM8yR802ncfdpyZCmnbtjP0omm3Qf8pNGZwxVi040NP5n/ADpHNAHIw6GE=
X-Received: by 2002:a25:cc92:0:b0:63d:b330:e8a4 with SMTP id
 l140-20020a25cc92000000b0063db330e8a4mr1120705ybf.427.1649130604963; Mon, 04
 Apr 2022 20:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com> <dd980687-a1ef-f4b5-bb29-da14f89c087e@arm.com>
 <CAMZfGtX5NXudeAsYKU8mDtPn0+bw_3FhCsAW0PMBTqTTkp-fQQ@mail.gmail.com> <ac9d171b-9995-13a8-8359-12291c835bec@arm.com>
In-Reply-To: <ac9d171b-9995-13a8-8359-12291c835bec@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Apr 2022 11:49:29 +0800
Message-ID: <CAMZfGtWT0TWj_FCp-=WBO10urzoYNr4z7HDnhUC87h+0xn7=2w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:34 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 4/4/22 17:31, Muchun Song wrote:
> > On Mon, Apr 4, 2022 at 5:25 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Hello Muchun,
> >>
> >> On 3/31/22 12:26, Muchun Song wrote:
> >>> The feature of minimizing overhead of struct page associated with each
> >>> HugeTLB page aims to free its vmemmap pages (used as struct page) to
> >>> save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> >>
> >> Enabling this feature saves us around 1.4/1.6 % memory but looking from
> >> other way around, unavailability of vmemmap backing pages (~1.4GB) when
> >> freeing up a corresponding HugeTLB page, could prevent ~1TB memory from
> >> being used as normal page form (requiring their own struct pages), thus
> >> forcing the HugeTLB page to remain as such ? Is not this problematic ?
> >>
> >> These additional 1TB memory in normal pages, from a HugeTLB dissolution
> >> could have eased the system's memory pressure without this feature being
> >> enabled.
> >
> > You are right. If the system is already under heavy memory pressure, it could
> > prevent the user from freeing HugeTLB pages to the buddy allocator. If the
> > HugeTLB page are allocated from non-movable zone, this scenario may be
> > not problematic since once a HugeTLB page is freed, then the system will
>
> But how can even the first HugeTLB page be freed without vmemmmap which is
> throttled due to lack of sufficient memory ?

It's unfortunate, we're deadlocked and will have to try again later :-(

>
> > have memory to be allocated to be used as vmemmap pages, subsequent
> > freeing of HugeTLB pages may be getting easier.  However, if the HUgeTLB
> > pages are allocated from the movable zone, then the thing becomes terrible,
> > which is documented in Documentation/admin-guide/mm/memory-hotplug.rst.
> >
> > So there is a cmdline "hugetlb_free_vmemmap" to control if enabling this
> > feature.  The user should enable/disable this depending on their workload.
>
> Should there also be a sysfs interface for this knob as well ? Perhaps the
> system usage might change on the way, without requiring a reboot.

Yep.  I'm working on this [1] and will cc you in the next version.

[1] https://lore.kernel.org/all/20220330153745.20465-1-songmuchun@bytedance.com/

Thanks.
