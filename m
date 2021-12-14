Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD253474C02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbhLNTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhLNTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:34:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B8C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:34:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b40so38801649lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dl2iT6KtwkArkWpu4TKpHkB1JYhlOVD8tWdR0g05Kik=;
        b=ppKZVIYvSpHjo+S2FtMLfGCT1I/ZcNCGwrapDzcSKGQvI4rKcQa0J3HiBvYWct64CD
         pjJxC2A5GGIxtuI/+BHqvQDcriFwbZztXOMPp3MvVd3gHNvd0oHBMO7HVdUeOBxcJw0T
         BKn7/jfDTdSCqZDbdFsFltz2qwevOfG8J+uTWrMrp/KFm0laB3vp3sDJWbU7By9Y1123
         L2rGLHEHna2RLGvyyKF/A3e4fMb0SYuY2N9t1gonIGgR5w2gIF8ztTKWmZ+NnBqOBH/v
         QUjOk2f2Y/i+6tG3gDpCIesZZlRr2+Ls9pYOr+/V4nynrMLFa43/AtZfEGHzbUvZqQ9R
         oCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dl2iT6KtwkArkWpu4TKpHkB1JYhlOVD8tWdR0g05Kik=;
        b=wB+Kdc3iRWb1aemHV3vGjEDaBfCSBaI0EvHiZbAGt7JtVH+x0CexgY3MXQxY0pwyxl
         21CWj7HSS7lJ7YykFR1v6exFD7A5HCgIEfX9rsmeqPc71WwBdSdqOTIAh1KEryn3ZhH0
         8kGQn6gJjHmBckSn/Ma/RezDYL9xJP0RKjHkb3M7dLMJrksftSELJeAwC+s7zFQrjDZG
         olEk/nuCsyMzmZ7ID7dIi0oj5sD0KPKu0QMHGrGZWATNW190brG5yZVTtrMwuyu0ipKI
         QgWc7oAo86ruGVstVV3vl9H6RxTaW57Mfwj88jlmEH2CsilwJO08xRhDUH4FjpZnSyMn
         Oysg==
X-Gm-Message-State: AOAM531Bm5jGHHxN8PGzFNEcIoTebcQD8+UNTfIiTCOBYJP+A5MvoEZt
        xl2KhgVRlUWQZ/pVmYI7mMF8OLdD7oKfomuWcF3hlw==
X-Google-Smtp-Source: ABdhPJxES0U3idmv8VA0GlFgs82CWHx9tfDuuFcdaU4FVcajgtSxXmkub8oZvbsWID90bY6FKcFoxfIjHFuD4Kgut+E=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr6541968lfe.489.1639510453554;
 Tue, 14 Dec 2021 11:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20211213224914.1501303-1-paul@crapouillou.net>
In-Reply-To: <20211213224914.1501303-1-paul@crapouillou.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Dec 2021 11:34:02 -0800
Message-ID: <CAKwvOdn=7iYyOg8+wikOK-6Xogf9Z6wdmkJEacYV_S1MpZ-YDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] MIPS: Add support for LTO
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>, list@opendingux.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:49 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> With this set of patches, it becomes possible to build a LTO'd kernel
> with LLVM/Clang on MIPS.

Paul,
Overall, nice work pursuing this and working through all the related
issues; thanks for the series!

We should clarify whether this is LTO_CLANG_THIN or LTO_CLANG_FULL.
Getting support for either would be nice, but for each architecture
has had its own distinct challenges.

>
> This was tested on a Ingenic JZ4770 based system. It requires the
> linking step of the vmlinuz.bin to be done with binutils' LD instead of
> LLVM's ld.lld [1], but the vmlinuz ELF itself can be completely built
> with LLVM.

eh, this patch set sounds incomplete then; Can we wait to resolve
https://github.com/ClangBuiltLinux/linux/issues/1333 BEFORE this
series?  Hacking up arch/mips/boot/compressed/Makefile to force a
different linker is not something we should encourage.

>
> Strangely, the LTO'd kernel is bigger in size (3.6 MiB vs. 3.1 MiB
> without LTO), which might be completely normal and I just have wrong
> expectations.

Are you building with CC_OPTIMIZE_FOR_SIZE or CC_OPTIMIZE_FOR_SIZE?
LTO != LD_DEAD_CODE_DATA_ELIMINATION

>
> Cheers,
> -Paul
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1333
>
> Paul Cercueil (3):
>   MIPS: boot/compressed: Disable abicalls
>   MIPS: boot/compressed: Build without LTO
>   MIPS: Add support for LTO
>
>  arch/mips/Kconfig                  | 1 +
>  arch/mips/boot/compressed/Makefile | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
