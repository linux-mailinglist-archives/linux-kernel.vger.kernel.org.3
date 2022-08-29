Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02C5A4726
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiH2K3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiH2K3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:29:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054D283
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:29:44 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3378303138bso183763037b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1UgMDodqKRBaEBEHWcE9DSlrGdrStbBVEiwW2ZUzz2s=;
        b=dK8ya6DukvKQUrXEWSpVF9llclw8PI6g3cJH0m7T3X/DwsxUj0+qVfBTkZxXLw0ul4
         ZW06i5Y1Pq0kVMom3eGD1sec10knJGan7jkT968BCBGIhc5dneR8WXe7gYXxtitybbB1
         J7uKbDih5Uem99N7Y8S87acgRAjxfYfx3RZsF6USx1gmtXWQluEzQyMQ16jBjxSSaWCw
         9oPDoaCRIcrBBczTy9wSJiMBd4C/RGeE0d3xQwb49G0oz2nr89+onQQUyRSSFtnKPPMh
         qV6UTPs/lt8Yn1rKD6sQtkBWykbW3J1Vrge5Snhi1Muz37gVGp9YnwNGjUVHn8riPnXj
         i16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1UgMDodqKRBaEBEHWcE9DSlrGdrStbBVEiwW2ZUzz2s=;
        b=EZSl19+CXJ5UoNXVmWfn5pwcUZcU48+ixYdq/p5zqJDUSjPvtAXeTFsXNrt6KFjeuy
         WPwwAZbJpMtvmJ/Q2rJOLaLmJAGyUYxxbM+7QPyoyzP/2+Iq3Z7ZNBe7uhFrrVXHXcrB
         4/a7K9G8fdJfd7Sq1uaeViOY89WVbk51JqJY2fBbL1ztzV3f724/bgEOGNrPZE3GOCfb
         AbkOw7MsvwxrAfq82/UDZZs7274dKhInyWEtJNu9UNZ/C5t06WY11ZhrmVMuoi92zUpM
         r8nuJ/QBZIxrMNZsS40Qo503L+O0GeLKOpYDR5hx9K17hhZ/QIJIx4YuPmYiO/5EA60u
         RMBQ==
X-Gm-Message-State: ACgBeo3eB56OnFd5MhXN7EuhaGqu+u+4ZjrEbc3qzLxG9hi1KSBbALQh
        E0gc9Kr99MVpXuvZyrjRAkIYTOfm3CSzPA3YB9Sf1YA2wM4=
X-Google-Smtp-Source: AA6agR7qYl58uspYvYVcrd4twcZFSvJfDb89dVftNjQCTaRPMQLfY0kip89WMfaxTd5BRoRKF5wEAnf6riLO2sIgiAg=
X-Received: by 2002:a81:7882:0:b0:339:802b:b4c0 with SMTP id
 t124-20020a817882000000b00339802bb4c0mr9473374ywc.488.1661768983953; Mon, 29
 Aug 2022 03:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
In-Reply-To: <CAHk-=whaiqzB6a_daUpvGyDg-cvkXKwwfjwPKV4HQRcci+8BeA@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 29 Aug 2022 11:29:08 +0100
Message-ID: <CADVatmNfM9rTNRi0GVFJt+HcxQ1+_qqYv01d7krtXVoHLSdqYA@mail.gmail.com>
Subject: Re: Linux 6.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 12:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So as some people already noticed, last week was an anniversary week -
> 31 years since the original Linux development announcement. How time
> flies.
>
> But this is not that kind of historic email - it's just the regular
> weekly RC release announcement, and things look pretty normal. We've
> got various fixes all over the tree, in all the usual places: drivers
> (networking, fbdev, drm), architectures (a bit of everythinig: x86,
> loongarch, arm64, parisc, s390 and RISC-V), filesystems (mostly btrfs
> and cifs, minor things elsewhere), and core kernel code (networking,
> vm, vfs and cgroup).
>
> And some tooling support (perf and selftests).
>
> We've got a few known issues brewing, but nothing that looks all that
> scary. Knock wood.
>
> Please give it a go,

No new failures in my tests. But among the one I reported, these two
are still in -rc3.

1. csky and mips allmodconfig fails with gcc-12
Reported at https://lore.kernel.org/lkml/YvY4xdZEWAPosFdJ@debian/
Fix at https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=b840304fb46cdf7012722f456bce06f151b3e81b

2. x86_64 allmodconfig fails with clang
Reported at https://lore.kernel.org/lkml/YuwRyQYPCb1FD+mr@debian/
No fix in linux-next yet.


-- 
Regards
Sudip
