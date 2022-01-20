Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F375494E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiATMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:55:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiATMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:55:52 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxUjv-1mLhTY2loH-00xqkF; Thu, 20 Jan 2022 13:55:49 +0100
Received: by mail-oi1-f179.google.com with SMTP id s127so8754054oig.2;
        Thu, 20 Jan 2022 04:55:48 -0800 (PST)
X-Gm-Message-State: AOAM5319YPSe1THOcSSBjDeAAH3V3HEsqy3bWprGM+/85SEmBRqPI55X
        ze0eFOclK1X/uSRuFvU0dttsz7kIAsgSX0LKlxU=
X-Google-Smtp-Source: ABdhPJydc5loEDqeQgQKrusgbi1aGxD+tZ0GQwF7Qc/YGyFSxdDyRJjWKaddNyUDdWoTK5tk0vBiI2MFsnHozVbpMM8=
X-Received: by 2002:a05:6808:2206:: with SMTP id bd6mr7227920oib.11.1642679565024;
 Thu, 20 Jan 2022 03:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-4-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-4-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 12:52:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UmnjHk8B6hSULiKv3FKoY5BW9=4=ESerQzc+4=LR5Zw@mail.gmail.com>
Message-ID: <CAK8P3a1UmnjHk8B6hSULiKv3FKoY5BW9=4=ESerQzc+4=LR5Zw@mail.gmail.com>
Subject: Re: [PATCH V3 03/17] asm-generic: compat: Cleanup duplicate definitions
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lCsHI9rHfZLXnkV3dfivYMnD6jrOglxU7oaZk08tRFkPrpeG0fc
 HD7q3LqubhJw2M4BBmJJripLWFBc9IHurENJcnEwZ526tnZBiQz0iHHMsU6FpCMMtR3OkoU
 uKH6YpISiZPOs40GV019o9s9mYLGfEeW+lhGwYH77CCiUEflurR3qBPjEZ2pRgwtWVvFV0M
 UZUAaoyTqqojrqECgUMjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wGZ+H9xEMTs=:APK36IfZSJNk4XMXh/6BEq
 2IzkaLQnLBZ6xC8KrVATSsP9mViZvnc5UFujJR7u/XdQiJQOUWmYSeGCkGDsaqXl3mC2Y78aS
 0jZbCGH0n0/she6jobPiP+Imnfpln4WvwW+wribOOzmns5E+3dijimjU9QriLaKYMRY6XNNYJ
 5z/92LzQFwEiXZKr6jTZTflsV/RcfUWo8TQ9Vk5PEnZisCx9fnESSuAellFOF+oQGRkw4BZP2
 dCF0CSRvswuIELQPIaM9VGO8Dd3VTKew1I1Nk3CxVsOAO78lF5P8gsEVkoBKdACFN+6fMTsRR
 nOHKBvm6wl75S24yAYmudmMY2h5L+CO69mvZLzKr16NUrLv0nuOuNcw9PNtQEfZJZ89N3owOK
 7nRp9htE3ceLTRNjtw+qq9qFgBi1UXFhpL7s8XWpO/ZkHH/oowoUGWHFSeIlGRHVe1yymiCRp
 u1ipdpZ+JBWiGznqZQkXhMsHcRtwjjhetwoLdJeEth5UaV/R6WNqocKHemFlr/QMpq+qaGeeS
 zZmu/TQAI5YDNbMQGU5VE5MLmYJQcXdgzQR1hAK3pV5yjd/By9FmNwlOplt2bxbGYpvCD/IWy
 0HUwXZaGyCs41eEm9W3rpvaIwEvO0Nohz0FIMF0dLssQb+p9V9fwZA885lzvL/4ukSUaBlMs7
 OXWioxXPDyhzwvobFot+Jx5CJBJKDXgH9p/zItmvxK0hywgnkAfPUqcqz9HngZYMHOyOANX9Z
 BIIejvL/S6uwGtTbvBR/Jn99I60wf6cIdlgZHsZKveKIYr8lB9LOYC8Z8vN04gnHiuquxIwB4
 62ldoNDHB/HV72vTKBhyeV7B1bVInJ+ftPiTjwwfuL1ou29H+0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  On Thu, Jan 20, 2022 at 8:38 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> There are 7 64bit architectures that support Linux COMPAT mode to
> run 32bit applications. A lot of definitions are duplicate:
>  - COMPAT_USER_HZ
>  - COMPAT_RLIM_INFINITY
>  - COMPAT_OFF_T_MAX
>  - __compat_uid_t, __compat_uid_t
>  - compat_dev_t
>  - compat_ipc_pid_t
>  - struct compat_flock
>  - struct compat_flock64
>  - struct compat_statfs
>  - struct compat_ipc64_perm, compat_semid64_ds,
>           compat_msqid64_ds, compat_shmid64_ds
>
> Cleanup duplicate definitions and merge them into asm-generic.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

> ---
>  arch/arm64/include/asm/compat.h   | 108 +++-----------------------
>  arch/mips/include/asm/compat.h    |  24 ++----
>  arch/parisc/include/asm/compat.h  |  47 ++----------
>  arch/powerpc/include/asm/compat.h |  47 ++----------
>  arch/s390/include/asm/compat.h    | 109 +++-----------------------
>  arch/sparc/include/asm/compat.h   |  39 ++++------
>  arch/x86/include/asm/compat.h     | 114 +++-------------------------
>  include/asm-generic/compat.h      | 122 ++++++++++++++++++++++++++++++
>  8 files changed, 191 insertions(+), 419 deletions(-)
>
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index eaa6ca062d89..f54f295efae3 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -5,9 +5,18 @@
>  #ifndef __ASM_COMPAT_H
>  #define __ASM_COMPAT_H
>
> +#define COMPAT_RLIM_INFINITY           0xffffffff
...
> +#ifndef COMPAT_RLIM_INFINITY
> +#define COMPAT_RLIM_INFINITY   0x7fffffff
> +#endif

While this is a correct conversion, I think the default should
be 0xffffffff, to match the asm-generic RLIM_INFINITY
definition, with only mips and sparc getting the exception

> -struct compat_flock {
> -       short           l_type;
> -       short           l_whence;
> -       compat_off_t    l_start;
> -       compat_off_t    l_len;
> -       compat_pid_t    l_pid;
> -};
...
> +#ifndef compat_flock
> +struct compat_flock {
> +       compat_short_t  l_type;
> +       compat_short_t  l_whence;
> +       compat_off_t    l_start;
> +       compat_off_t    l_len;
> +       compat_pid_t    l_pid;
> +} __attribute__((packed));
> +#endif

You are adding __attribute__((packed)) here, which I think has
no effect on the layout on the structure on any of the architectures
but it does change the alignment requirements needlessly.

Better leave it without the attribute.

> -struct compat_flock64 {
> -       short           l_type;
> -       short           l_whence;
> -       compat_loff_t   l_start;
> -       compat_loff_t   l_len;
> -       compat_pid_t    l_pid;
> -};
...
> +#ifndef compat_flock64
> +struct compat_flock64 {
> +       compat_short_t  l_type;
> +       compat_short_t  l_whence;
> +       compat_loff_t   l_start;
> +       compat_loff_t   l_len;
> +       compat_pid_t    l_pid;
> +} __attribute__((packed));
> +#endif

This one is different: on all architectures other than x86,
the added packed attribute changes the size of the
structure by removing the four padding bytes at the
end. x86 originally added the attribute here to work around
the weirdness of the x86-32 ABI that aligns 64-bit values
on a 4-byte boundary.

The easiest workaround would be to have x86 keep its
custom definition. A slightly nicer version would drop the
attribute on x86 as well but instead change the compat_loff_t
definition to use compat_s64 instead of s64, giving it the
correct alignment.

> -struct compat_statfs {
> -       int             f_type;
> -       int             f_bsize;
> -       int             f_blocks;
> -       int             f_bfree;
> -       int             f_bavail;
> -       int             f_files;
> -       int             f_ffree;
> -       compat_fsid_t   f_fsid;
> -       int             f_namelen;      /* SunOS ignores this field. */
> -       int             f_frsize;
> -       int             f_flags;
> -       int             f_spare[4];
> -};
...
> +#ifndef compat_statfs
> +struct compat_statfs {
> +       compat_uint_t   f_type;
> +       compat_uint_t   f_bsize;
> +       compat_uint_t   f_blocks;
> +       compat_uint_t   f_bfree;
> +       compat_uint_t   f_bavail;
> +       compat_uint_t   f_files;
> +       compat_uint_t   f_ffree;
> +       __kernel_fsid_t f_fsid;
> +       compat_uint_t   f_namelen;
> +       compat_uint_t   f_frsize;
> +       compat_uint_t   f_flags;
> +       compat_uint_t   f_spare[4];
> +} __attribute__((packed));
> +#endif

None of the architectures use the packed attribute at the moment,
so please don't add one here.

Changing compat_fsid_t to __kernel_fsid_t is harmless, but seems
unnecessary.

Changing the signed int to an unsigned int (regardless of notation)
may be a change in behavior. s390 is the only architecture
using unsigned members here at the moment, as of b8668fd0a7e1
("s390/uapi: change struct statfs[64] member types to unsigned
values").
The description of that patch sounds like this was changed to fix
a bug, but I don't see what the actual problem would be in the
put_compat_statfs().

For the moment I'd suggest leaving this with the signed version,
with s390 being another exception next to mips. We can follow-up
with merging s390 into the common definition using either the
signed or unsigned types, but I think that needs to be a separate
patch with a detailed explanation.

 +#ifndef compat_ipc64_perm
> +struct compat_ipc64_perm {
> +       compat_key_t key;
> +       __compat_uid32_t uid;
> +       __compat_gid32_t gid;
> +       __compat_uid32_t cuid;
> +       __compat_gid32_t cgid;
> +       compat_mode_t   mode;
> +       unsigned char   __pad1[4 - sizeof(compat_mode_t)];
> +       compat_ushort_t seq;
> +       compat_ushort_t __pad2;
> +       compat_ulong_t  unused1;
> +       compat_ulong_t  unused2;
> +} __attribute__((packed));
> +
> +struct compat_semid64_ds {
> +       struct compat_ipc64_perm sem_perm;
> +       compat_ulong_t sem_otime;
> +       compat_ulong_t sem_otime_high;
> +       compat_ulong_t sem_ctime;
> +       compat_ulong_t sem_ctime_high;
> +       compat_ulong_t sem_nsems;
> +       compat_ulong_t __unused3;
> +       compat_ulong_t __unused4;
> +} __attribute__((packed));
> +
> +struct compat_msqid64_ds {
> +       struct compat_ipc64_perm msg_perm;
> +       compat_ulong_t msg_stime;
> +       compat_ulong_t msg_stime_high;
> +       compat_ulong_t msg_rtime;
> +       compat_ulong_t msg_rtime_high;
> +       compat_ulong_t msg_ctime;
> +       compat_ulong_t msg_ctime_high;
> +       compat_ulong_t msg_cbytes;
> +       compat_ulong_t msg_qnum;
> +       compat_ulong_t msg_qbytes;
> +       compat_pid_t   msg_lspid;
> +       compat_pid_t   msg_lrpid;
> +       compat_ulong_t __unused4;
> +       compat_ulong_t __unused5;
> +} __attribute__((packed));
> +
> +struct compat_shmid64_ds {
> +       struct compat_ipc64_perm shm_perm;
> +       compat_size_t  shm_segsz;
> +       compat_ulong_t shm_atime;
> +       compat_ulong_t shm_atime_high;
> +       compat_ulong_t shm_dtime;
> +       compat_ulong_t shm_dtime_high;
> +       compat_ulong_t shm_ctime;
> +       compat_ulong_t shm_ctime_high;
> +       compat_pid_t   shm_cpid;
> +       compat_pid_t   shm_lpid;
> +       compat_ulong_t shm_nattch;
> +       compat_ulong_t __unused4;
> +       compat_ulong_t __unused5;
> +} __attribute__((packed));
> +#endif

I checked these in detail, looking at the seven architectures, and your
conversion looks exactly right (I had initially missed the part about
compat_mode_t that you got right).

As with compat_flock, the packed attribute has no impact on the layout
here, but please drop it anyway for consistency.

        Arnd
