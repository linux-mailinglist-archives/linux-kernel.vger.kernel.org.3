Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124BB5A1443
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiHYOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiHYOjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:39:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD8B8A6F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:38:42 -0700 (PDT)
Received: from mail-ej1-f54.google.com ([209.85.218.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjSHa-1pAlMA0fT0-00ktgm for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022
 16:38:40 +0200
Received: by mail-ej1-f54.google.com with SMTP id lx1so3531893ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:38:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ELLj5lfWfm1SrRqOPcAiydjBOzCOhaC9UihKq1O3F9JKhs+Ti
        ZLMcn9zXQkvaI70A0/i3oZMub8Jx5uI3f3TlvcU=
X-Google-Smtp-Source: AA6agR51v/FeIcSJfSqlFkB+AtvglMLd5zOUyHojI8I/eQyoItC8NHpfXs4b9QXagWqWJVvpw6ReFMJBqvV8ZcPzLrw=
X-Received: by 2002:a17:907:1c27:b0:73d:ce49:6dd7 with SMTP id
 nc39-20020a1709071c2700b0073dce496dd7mr2455549ejc.470.1661438319816; Thu, 25
 Aug 2022 07:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220822194310.31796-1-rdunlap@infradead.org>
In-Reply-To: <20220822194310.31796-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Aug 2022 16:38:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3G2GBaPaVsQo9mJfqq7ba9mzDWQp=wjxzqd5X0Zm+qwA@mail.gmail.com>
Message-ID: <CAK8P3a3G2GBaPaVsQo9mJfqq7ba9mzDWQp=wjxzqd5X0Zm+qwA@mail.gmail.com>
Subject: Re: [RFC PATCH] compat: update linux/compat.h and kernel/sys_ni.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vVJ2ZO6mSMejXGmcoHHljpjBAPldtw424AJoqadx7Nuy33Mrsbw
 vGU4Djl7HQ8SoJ77mlsMISbT4YuP47E/hP9mik4oJ8Vc+eaH57Z157LBrcBX+FzzGjP2FRA
 6IPk1ytwil8InC4F55fsovgrEhags5lAo9rQLMSPk5IJPWdl1jdX3LX7aSY9lLajY+GO71H
 Jn8zRTlRWA0y6PTBQN78Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1gL5huOFOc=:o5ihwEqjsVrFUbNyhVqT4v
 xqRA884dH4lDf9pRDGdUQw+cjaJnFCbeTyeJqhuFt9Tyw2xCIt3YAPO8uor0CMbcDzpsC3/sl
 0gB1G3DG+KIJR+wnWLeSp7MsWvxZLEr+zyby0j5CjdKkhJBGEOjVbamRtIGTJG/knAtjQa9eb
 y5UFmTd2KzXW51YgAA9iszMYqyazi8UmyyLBkKs2PlWnP1VgeypHuW4UokDLG6Y8KiENJ1Oqr
 0VzaNUJBl8/ChGAOtW2YV4RL2KHdERQRIiyCiZOUCfCovq+7Kr5Be50NA71TRpamgx5yOB4bY
 v9Wfj5aX+jp7wNCdBwIOMH3yVRKS9B+MhjthXx+ik+pcrBJ15RtUex8T5meEetQlij2Vslz/w
 sMT1GdQ3I6G8uQLf2PbgVueN869rhTfDmFdkmu8+Vjg00N2bVG8R44H1hptw7jH3tBoAJd6uQ
 BB80+UKIG3m8CwYdbrYKSXYxUeFTV0xtlNVyQ5o4+cM7fltCRXPz05qNDC2YjRhskzwC/2F9c
 5U5WtnPuStGnQzDkAYNDiiff3vAAhSg+Jr8CfVLYX2wLHHCQje8DvCLS0DNs/2+t4S13mr5+c
 vilmYk77ObPMRaYhc4LVahiT72+gpkxAb+rPzX+E6MDR2D9aTA45FQ3iHLxL5pQsAPBObsLE7
 n7Z1DjQVzbGcgD9cU8jXNmrFE6MKTRU1VjfnKtBgjBA/yh+NNifcPQ04bY1KJP18x80PAy1BB
 CkeA0vihstNlTF7cNhuumoCLoo/gaTRoYjVrltyhqYHQZB3FGnTbZLN1g4RZt0hYzVYW+Ka4v
 dmBIIro4TH1Qtbp4/k4WgpDa/MUqhV35s6YtXuG8/0+bzl78ObxKvwJHSz/CUg4Um9jxP5hLY
 YFwntT8+ZYeKfvULvFbQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 9:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:

>   * Deprecated system calls which are still defined in
> @@ -910,19 +901,13 @@ asmlinkage long compat_sys_old_select(st
> -#ifdef CONFIG_COMPAT_OLD_SIGACTION
> +struct compat_old_sigaction;
>  asmlinkage long compat_sys_sigaction(int sig,
>                                     const struct compat_old_sigaction __user *act,
>                                     struct compat_old_sigaction __user *oact);
> -#endif

All the removed #ifdef look good to me here, and I checked that there
are no conflicting prototypes for the ones you change.

For COND_SYSCALL_COMPAT(), I think they should not be part of
this patch, and only added for specific optional calls that would cause
a link failure.

> @@ -94,6 +94,9 @@ COND_SYSCALL(flock);
>  /* fs/nfsctl.c */
>
>  /* fs/open.c */
> +COND_SYSCALL_COMPAT(truncate64);
> +COND_SYSCALL_COMPAT(ftruncate64);
> +COND_SYSCALL_COMPAT(fallocate);

COND_SYSCALL_COMPAT() doesn't really make sense for non-optional syscalls
like these: if an architecture neither sets __ARCH_WANT_COMPAT_FALLOCATE
nor provides its own implementation, then a link failure is the
appropriate output, hiding it with a COND_SYSCALL_COMPAT() just turns that
into a runtime failure that is harder to analyse.

>  /* fs/read_write.c */
> +COND_SYSCALL_COMPAT(preadv64);
> +COND_SYSCALL_COMPAT(pwritev64);
> +COND_SYSCALL_COMPAT(pread64);
> +COND_SYSCALL_COMPAT(pwrite64);

These are specific to x32, and we don't want to ever add them to another
architecture, so they should not get a COND_SYSCALL_COMPAT()
either.

> @@ -118,6 +125,7 @@ COND_SYSCALL_COMPAT(signalfd4);
>  /* fs/sync.c */
> +COND_SYSCALL_COMPAT(sync_file_range);
....
> +COND_SYSCALL_COMPAT(readahead);

Same as above, but these have an additional angle to them, as
there are conflicting prototypes and implementations:

arch/sparc/kernel/systbls.h:long compat_sys_sync_file_range(unsigned int fd,
arch/sparc/kernel/systbls.h-                       unsigned off_high,
unsigned off_low,
arch/sparc/kernel/systbls.h-                       unsigned nb_high,
unsigned nb_low,
include/linux/compat.h:asmlinkage long compat_sys_sync_file_range(int
fd, compat_arg_u64(pos),
include/linux/compat.h-
compat_arg_u64(nbytes), unsigned int flags);

The current code works fine, but if you still want to improve this,
it would be great to convert the architecture specific helpers
to be shared with the common ones. For those that have non-matching
prototypes like

include/linux/compat.h:asmlinkage long compat_sys_pwrite64(unsigned
int fd, const char __user *buf, size_t count,
include/linux/compat.h-                             compat_arg_u64(pos));
arch/powerpc/include/asm/syscalls.h:compat_ssize_t
compat_sys_pwrite64(unsigned int fd, const char __user *ubuf,
compat_size_t count,
arch/powerpc/include/asm/syscalls.h-                               u32
reg6, u32 pos1, u32 pos2);

that have an extra argument in them, I would instead suggest renaming
the nonstandard ones.

       Arnd
