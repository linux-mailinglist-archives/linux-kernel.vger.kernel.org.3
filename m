Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578746259D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhK2WlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhK2WkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:40:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8FC047CC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:31:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b40so47080694lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cNMSwt45ock9pSAjkXBM1gUWmDWeBPaQRr1gZTZ0gI=;
        b=Is26+2qi06IhBeX6mUmRAomd6VgRCRKKQEkHS/ElA8ydGNoR3lIDA0vLJqdmMMwIsz
         VHwNDGTPz1lEon4iVKImIQZ3rVE+KecLBIY4sHTSFYfiI7MVlgWIlYFpnHfD2O+5IOqX
         oaTmAiEXdKL4ZK56UuLk7bl/wP1+PzqVenx1m2edYaqq636bJjmxLXB6a+veiwKWiEdZ
         fMd7ZXDe+R7pkUL7V0UVbd1S3zZeIgmjRX7ve2BG+l67WhSOjZ0yeBwy6JzO/ZG72TUX
         6tXA5Uv7gzT2CaxdF44j6IiNqpvQp+NqFk58+O4MoIfRT8rZCB7BxNlYCMyWLftQaMAb
         RShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cNMSwt45ock9pSAjkXBM1gUWmDWeBPaQRr1gZTZ0gI=;
        b=Smc0RnRfVrTIxnHprpzfOxP6YCDHET5rDHJqra8QXzwM13sJvcQbjNTH/IbDKODmVQ
         Mp1mfqBpzahmNH5DHlyAD4Tn3iSfPeNSEpwQov2tdm+B6ls12WHLXzsekMSkoAKy4JxZ
         8CYD9jURbRnLpZMfyu+ihrIQyg83k/kdSfmBP5SM/HZJVWWOhMUxslZA/ErbfrYHYr3m
         r9uRE089oV92kfJYlFMijx2dvHsNJe49hNZkElEqlsjwg2I1+6B6f6Ic7zT0ibQrgPD2
         gEd3e2sHSqN/TLYbkONvYWVRuBX95smr0xCsWXOy7vczfJbNCUSKLeMUJnMNDyQr3EwK
         8muA==
X-Gm-Message-State: AOAM5303N0a+4NY8DrmPJRpz/yGDeyrV9wFxSBdml0Zu9pUCCkTKppGU
        nid8r543JI0urpa7ONq9oAXjkju/3l0r+HeOfWoLjw==
X-Google-Smtp-Source: ABdhPJz6dTs7OIKfCj9AdUmQMX4Sqh7ZuZ9v3AsgeE+6RyGPUJnSXVhzX8RTGetchysB6Qz1lZmbh9+C1lZNlb2Cm80=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr50143383lfe.489.1638210659100;
 Mon, 29 Nov 2021 10:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20211129165803.470795-1-nathan@kernel.org>
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Nov 2021 10:30:48 -0800
Message-ID: <CAKwvOdn9o+5TfauYr+ZDngTZEDxVRQka1T3vOEoE=ByFg=n5=w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 9:01 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This patch series raises the minimum supported version of LLVM to
> 11.0.0.
>
> Patch #1 outlines the issue, goes over the potential impact of the
> change, and does the actual bump. Subsequent patches clean up the
> various checks that are always true after the bump.
>
> I have marked this revision as RFC to give various parties the option to
> comment on this bump before it is done, namely KernelCI and Linaro's
> LKFT, who are still testing clang-10. I have added some other folks to
> CC that I know are testing with clang to see if this impacts them in any
> way (as I would like to impact as few people as possible) but as far as
> I am aware, most other CIs and developers are testing closer to tip of
> tree. If that is not true, scream so that we can see what can be done
> about that. If I missed anyone who is actively testing with clang,
> please key them in and I will make sure to include them in future
> revisions (if any are needed).
>
> It probably makes sense for this series to live in -mm.

Series looks good to me. Thanks for the patch, and cleanups!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Nathan Chancellor (6):
>   Documentation: Raise the minimum supported version of LLVM to 11.0.0
>   mm, slab: Remove compiler check in __kmalloc_index
>   arch/Kconfig: Remove CLANG_VERSION check in HAS_LTO_CLANG
>   Revert "ARM: 9070/1: Make UNWINDER_ARM depend on ld.bfd or ld.lld
>     11.0.0+"
>   gcov: Remove compiler version check
>   init/Kconfig: Drop linker version check for LD_ORPHAN_WARN
>
>  Documentation/process/changes.rst | 2 +-
>  arch/Kconfig                      | 3 +--
>  arch/arm/Kconfig.debug            | 2 --
>  include/linux/slab.h              | 3 +--
>  init/Kconfig                      | 1 -
>  kernel/gcov/Kconfig               | 1 -
>  scripts/min-tool-version.sh       | 2 +-
>  7 files changed, 4 insertions(+), 10 deletions(-)
>
>
> base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
> --
> 2.34.1
>
>


-- 
Thanks,
~Nick Desaulniers
