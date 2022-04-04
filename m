Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F307D4F131B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357842AbiDDKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357896AbiDDKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:30:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CD5580;
        Mon,  4 Apr 2022 03:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99365B812A4;
        Mon,  4 Apr 2022 10:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9F0C3411D;
        Mon,  4 Apr 2022 10:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649068121;
        bh=zwUK1d+i5RXTJlC+Adlf8bRHaBsi5j9oBLcZmbARNm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u4dSFjGSpxeBVGAvXWQzGvUL6K7TQjhSHgVk8lztuwj8tcx4m1KBz3SgHZNKdBNCq
         RkPWMP1i4E2I1HAkxFNP8aRfSKsf2wfPKMHTKAyvUsbrkkei9VwBYTKIdiRZp/QKfV
         QRnbhPz6AmERszYevwrQ7zuVac/siEyzDl/jtvNO4QZXm4ZynlJ+u6GirFFyNzbC6E
         y6RXT139lJZzdpOF/JXOmP1nRDdiHthJmaxrP1Mph8nM91pNKJGel+VrnTlNlEOg9B
         jnKmDShWDNYasHR/roiRPvu/cfsWxAkSQmukax8snjwlwLmIz+lSMmKmgDc/Rzi2Oc
         RGKb5W7HLx8BQ==
Received: by mail-vs1-f43.google.com with SMTP id u207so8711625vsu.10;
        Mon, 04 Apr 2022 03:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM533XOEKIuvxRAgs2IDtV4/WXJFEREENeeJLt0IxT+AxY73Ye5rGW
        ldgZZRMo7X5BsOmRWBcj1noWeSUcdyT7yqPoqXY=
X-Google-Smtp-Source: ABdhPJx6e/VYOA2WWRLC+sB4i7fzBVJ1DvExFTqsC4UIP3lN3bWU9HoW+rJb6BZz/2iFzWa6yDJhtpd1cSTN4vx0DrM=
X-Received: by 2002:a67:efc3:0:b0:325:4fcf:60bf with SMTP id
 s3-20020a67efc3000000b003254fcf60bfmr6380956vsp.51.1649068120257; Mon, 04 Apr
 2022 03:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu_ZHOeOPDiwzXGL6Re8aFYW3K+JSL2Dozw=VHwaUFxyQ@mail.gmail.com>
In-Reply-To: <CA+G9fYu_ZHOeOPDiwzXGL6Re8aFYW3K+JSL2Dozw=VHwaUFxyQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 4 Apr 2022 18:28:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS_uhdujc_9+mrqKi=41eyURtffqrd067zo7ew3s4-dwQ@mail.gmail.com>
Message-ID: <CAJF2gTS_uhdujc_9+mrqKi=41eyURtffqrd067zo7ew3s4-dwQ@mail.gmail.com>
Subject: Re: [next] riscv: Linux next-20220404 riscv defconfig builds failed.
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It caused by:

commit 03248addadf1a5ef0a03cbcd5ec905b49adb9658
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Wed Feb 9 12:20:45 2022 -0600

    resume_user_mode: Move to resume_user_mode.h

    Move set_notify_resume and tracehook_notify_resume into resume_user_mode.h.
    While doing that rename tracehook_notify_resume to resume_user_mode_work.

    Update all of the places that included tracehook.h for these functions to
    include resume_user_mode.h instead.

    Update all of the callers of tracehook_notify_resume to call
    resume_user_mode_work.

    Reviewed-by: Kees Cook <keescook@chromium.org>
    Link: https://lkml.kernel.org/r/20220309162454.123006-12-ebiederm@xmission.com
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

I would solve it.

On Mon, Apr 4, 2022 at 5:58 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux next-20220404 riscv defconfig builds failed.
>
> Regressions found on riscv:
>    - riscv-riscv-clang-14-defconfig
>    - riscv-riscv-gcc-10-defconfig
>    - riscv-riscv-clang-13-defconfig
>    - riscv-riscv-clang-12-defconfig
>    - riscv-riscv-clang-11-defconfig
>    - riscv-riscv-gcc-11-defconfig
>    - riscv-riscv-gcc-8-defconfig
>    - riscv-riscv-gcc-9-defconfig
>    - riscv-riscv-clang-nightly-defconfig
>
>
> arch/riscv/kernel/compat_signal.c:7:10: fatal error:
> linux/tracehook.h: No such file or directory
>   7 | #include <linux/tracehook.h>
>     |          ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:289:
> arch/riscv/kernel/compat_signal.o] Error 1
>
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> metadata:
>     git_describe: next-20220404
>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>     git_sha: 696206280c5e5c028caf9fd259999cb72b1f6127
>     kconfig: defconfig
>     target_arch: riscv
>     toolchain: gcc-11
>
> steps to reproduce:
>   # To install tuxmake on your system globally:
>   # sudo pip3 install -U tuxmake
>   #
>
>   tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
> --kconfig defconfig
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
>
> [1]  https://builds.tuxbuild.com/27JdBBUbSHIhFJ9Wsq3Z6ssitb6/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
