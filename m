Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE824DCBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiCQQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCQQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:54:08 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A21217956
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:52:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2e5a8a8c1cdso56528167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ls5p6VA534Iw1IExTs/u1d7nC2HX+uKuD3TTQdakQZ8=;
        b=kxUOCJ/fJRZJGrt9ZKe0pYGGy98fNm2IIaEqQPugg5M4QHB5mp6gI566pfVXEUKcQZ
         TFowxqYFTpQ3SX9MFnyxvlEbSacpeM7JFyAX2EuQe3DvTYOiSvjT1V8TVYJW4QIrKZPc
         5MLt2TGnVGftiJLRK/MusjrLz0LvNZp1D+7ULggI5mDZr/AE/MPtiXYuHdcP3i1vF7C0
         57rmkqKGKGvkbNzUXlZrij2YmqzbiifaFndxFwhVFh1pyIFx+OAXLpcjFg3s2trEYyY6
         rQABZnd4oocMuXAoyWZ5JT5qVjnZM9wQySVkzCzT6iNzKJ/2Chi5NShHQIJitvdUwm/v
         7PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ls5p6VA534Iw1IExTs/u1d7nC2HX+uKuD3TTQdakQZ8=;
        b=VFjBm9r0rZC/M7nTwDDelg4CfanH2I7hiTBsZTQed+Q+Qp9+5YI8cMuMA9/MfEJdbj
         RT9k4ch1hMS2+dVh8E85HBBEYOK0wB8ZkUMyZP732d4ilTy/kqgb7ozGts0vHm3MOUHE
         jDi5t3Mo6g9idJgpVI1c/tTrEQ15pTF8yHZ12q9+2Mus7N3+B0f1FX4reW46DLLx8/cb
         qTCgM5EJYMqD+9xIyfOcGq3m+qm0zNPsQCfH6xTD9GFKb/2YNxNwLBMkswj3jvFRiQbC
         aA1XYMqkSpqU6cFU/m3YWbUYzO2jxBO1ErLh3VuqQfjS1Ge7C2x4kXwrhidJbHwWKg8R
         Z8hQ==
X-Gm-Message-State: AOAM531fHtO57tp9Z46j7XjTWN/0m4ocuyznNPJa8PxDBoP/M7duMZS5
        zXstDZMU8RyLDPUWdU11UqVTk+z5BneMGrrhPzMYNQ==
X-Google-Smtp-Source: ABdhPJyDhLx5hwxyuHdfJnu1PbpQVZuTWpjjxs0CJpSL2oGPPgsLlmH5a4/t1+HNk9SzW7doeSB1ljUM2nZIw5wwE8U=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr7120428ywf.418.1647535970257; Thu, 17
 Mar 2022 09:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220317080504.GC735@xsang-OptiPlex-9020>
In-Reply-To: <20220317080504.GC735@xsang-OptiPlex-9020>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 18 Mar 2022 00:50:58 +0800
Message-ID: <CAMZfGtUg8ApCyyCUNC6MC344aH2nNwWvp1U+F0dRcnf0hAOXxQ@mail.gmail.com>
Subject: Re: [mm] f886cdb769: kernel_BUG_at_include/linux/swapops.h
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:05 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: f886cdb76920131b030ffae13e752d8d0ff440f0 ("mm: pvmw: add support for walking devmap pages")
> url: https://github.com/0day-ci/linux/commits/Petr-Mladek/kthread-Make-it-clear-that-kthread_create_on_node-might-be-terminated-by-any-fatal-signal/20220315-182614
>
> in testcase: will-it-scale
> version: will-it-scale-x86_64-a34a85c-1_20220312
> with following parameters:
>
>         nr_task: 100%
>         mode: process
>         test: lock1
>         cpufreq_governor: performance
>         ucode: 0x2006c0a
>
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
>
> on test machine: 104 threads 2 sockets Skylake with 192G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>

Thanks for your report. I knew the reason. Because pmd_devmap() is
only reliable when pmd_present() returns true and  pmd_devmap() could
returns tue for pmd swap entry.  I should test pmd_present() before
pmd_devmap().  Will be fixed in the next version.

Thanks.
