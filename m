Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944FD4A6D53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245248AbiBBIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:51:35 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiBBIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:51:33 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mz9hF-1mJnRn0Chv-00wFCd for <linux-kernel@vger.kernel.org>; Wed, 02 Feb
 2022 09:51:32 +0100
Received: by mail-wm1-f44.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so3405764wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:51:31 -0800 (PST)
X-Gm-Message-State: AOAM531PAUKjhi8JT2Dbk77ijQpMFP85qdokGTtxIBe8EEe3YzDpJ2zA
        U/mKdh1dA94VVLVqs9+atLIbH1k7J3TGavwHcs4=
X-Google-Smtp-Source: ABdhPJx/q7byDrb6qBNHBKrfU1aIZrWKpLptTkIUIl9CIBEWi0b1+Ba9BJPvDbMTQOLuk/Ccm8XdSUn4TCK7HSGyQU8=
X-Received: by 2002:a05:600c:3005:: with SMTP id j5mr5065166wmh.35.1643791891724;
 Wed, 02 Feb 2022 00:51:31 -0800 (PST)
MIME-Version: 1.0
References: <202202020825.z4o2smGO-lkp@intel.com>
In-Reply-To: <202202020825.z4o2smGO-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Feb 2022 09:51:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kbjzuzMPVCY9DjNnUTXhR80tsnXP1vdAqAoAiPZmLMQ@mail.gmail.com>
Message-ID: <CAK8P3a2kbjzuzMPVCY9DjNnUTXhR80tsnXP1vdAqAoAiPZmLMQ@mail.gmail.com>
Subject: Re: [csky-linux:riscv_compat_v5 20/21] riscv64-linux-ld:
 arch/riscv/kernel/compat_syscall_table.o:undefined reference to `compat_sys_fadvise64_64'
To:     kernel test robot <lkp@intel.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1JiLqlPURs+7cKZG9+8spmohqglZ70uBnuQ4vYW71lzdCcauLn2
 qEjjMYrzeV++xYOpkUpCohThb+SBLhiQb8Przt6ytnEO/Aaq+oOGaC1a86tl/wSdPw7TZu6
 J3zJlshdvrosq8h+6vb396k2eP7lQj5TupFnhIvabw9AyAjLXIjBdspi83imVmp8b6H3PPA
 kraZB4xs+YKAQGLsGcL6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OTNfaD7QyK8=:bKDgvBQUW8DzMS7xi2wwmd
 45xwJ2qwZuDtW8mgHdFR7lcxU/Ni1V1PZoth4HqzE2hkrGasz0hY3Qp34/EmNluFBvOiFuLiD
 657bcVLXIIKyyJW57R5emjG3/DHHv/bQldD7bZ8Y4H0B2iLq6yoLW9DC8n+LS7R0+7Te9ISii
 Juz7H3MAI7DVqQhT7TNI3SHNQHruPRmWf/BU2DUagVwkUHPY5chIYca7r1NQadT55+BKNSUg3
 8AI5IgYYPOGX6Eg899OcikU6JlrzYMajbz5i+H86dkEGrLV6p7mj6JGNfInTXncrXJrV/AvX4
 tHPlSzh/BISXrOtLnQXYTKXEzSif2xvfeWI/jx/OVZlKciDIlkPWGqN2I9C4tCXocQX9gmZ9v
 9IuNd9vNMz5Ph0QLF3XhfTBKTlYvC7+8OzWYr0+fNra7M1hIimxFG5XjFGy1FqrHUcOYGnCZm
 bSvMCLUQ5GvTNCTh6wsh5MLkiYxn5DAAu6nmTIacEWo/2g6FUF+0xipQwT1yd4A3CtPOvB5W0
 zeGgQN7WjEXZBHkZ80pZx7hns8mWcqiXdjIFTSaA2SFlac/LEbROvX/v0+Hc9eHHf1Dn7BRly
 6Ntfno8sZvcj3bNFnYGRvQKZhJKQzN4vOrr+2hlbny7ZmqCSwW5AZwDkDFC3NS0lEg4+uXEhw
 T8ItJnUAAhdQCFLNhpp60dIAJZzWU4u+oARptUYCwTlJkUJYHa+tXcMDYbwRTAffOZbFT2s5q
 /7NH4K7qX4QEyrisbYpjyWwBSqsc2XUzZz4L539HiRKEINzVLHAc3XoFrjXei08bG1q4A9BlJ
 /VixocSfrYvDZMWILhm4LwHqtjXK9uWpnZQehu13bvCJEKEEtg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 1:16 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/c-sky/csky-linux riscv_compat_v5
> head:   471721ad5e81a434eb4c5d84187312fedaf6cf72
> commit: a43cb0b9c0aaa0888a758b2155ef7554a3328aec [20/21] riscv: compat: Add COMPAT Kbuild skeletal support
> config: riscv-randconfig-m031-20220131 (https://download.01.org/0day-ci/archive/20220202/202202020825.z4o2smGO-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/c-sky/csky-linux/commit/a43cb0b9c0aaa0888a758b2155ef7554a3328aec
>         git remote add csky-linux https://github.com/c-sky/csky-linux
>         git fetch --no-tags csky-linux riscv_compat_v5
>         git checkout a43cb0b9c0aaa0888a758b2155ef7554a3328aec
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'

This oneline patch should fix that, but more might be needed if any
other added syscalls
are conditional on kernel config.


        Arnd

--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -278,6 +278,7 @@ COND_SYSCALL(landlock_restrict_self);

 /* mm/fadvise.c */
 COND_SYSCALL(fadvise64_64);
+COND_SYSCALL_COMPAT(fadvise64_64);

 /* mm/, CONFIG_MMU only */
 COND_SYSCALL(swapon);
