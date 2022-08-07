Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8041C58BCC2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiHGTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:41:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEC5E92
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:40:59 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGi6m-1o896Y43og-00Dpxq for <linux-kernel@vger.kernel.org>; Sun, 07 Aug
 2022 21:40:57 +0200
Received: by mail-wr1-f53.google.com with SMTP id z17so8731011wrq.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 12:40:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo22RNdZ42wszkC27qGBo3Sy2cTSMXYo8GfFrM9bG57mREiZFbEa
        lYv1BfE87RIzlR/ItkymIZPgy/rqZ/Bp5/qlqd4=
X-Google-Smtp-Source: AA6agR6hxd+c6uxIaU58pn/ju2/Kpl1hrPDOtejwBjDN9MsDwixXKlT0pf81lWjwhwXW39QULBi5Dg6hl/EgSri8ztI=
X-Received: by 2002:a05:6000:18a2:b0:221:7d32:e6a5 with SMTP id
 b2-20020a05600018a200b002217d32e6a5mr5774325wri.278.1659901256671; Sun, 07
 Aug 2022 12:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220807172839.12359-1-rdunlap@infradead.org>
In-Reply-To: <20220807172839.12359-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 7 Aug 2022 21:40:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0s0y9jbw4EFsLM2-unSNuHfqoVcuq_NuO9fTsjN4cWiQ@mail.gmail.com>
Message-ID: <CAK8P3a0s0y9jbw4EFsLM2-unSNuHfqoVcuq_NuO9fTsjN4cWiQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat: make __ARCH_WANT_COMPAT_FADVISE64_64 conditional
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sskGhZymZLq596VAq0Ls91taS6W+Uy3tGn68M7RgHYbi0zAmyFP
 fye+pU4qbibEqXUIFseBHte2YcQFFJ2LNqD6718Kt6vxXPtbDcm+CsLdtcrGaGsoGEKjSxx
 9mMHzzpBPSe8T+WZ32lZ+twgPq8PBJ14KykzRwIhqc03GTqoJLhUv+Jt3/1D14LLcacPiX7
 vC9dm0mqDrIBEaC47j8mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STyyRf0E044=:I6io82aJ53+HCiiFSbmKne
 noqZOxSoLafajRTfe5tMJNrI5Be/VB1IcI2SM529j61IorWPD0vj5xYNnzql3+0rXZ329h3VA
 vP0eRvNSa6g4hSnyDWe3FLk9ghT2IBg8yZ9YbS+gurZxTjKm2pUeTLeSrWwRMS2uiDmAHBrRm
 8XAtXd8xC+VFSdpEfBKLljxQjdeCkEHVSX8bOXiLdF9RPBQ4sVsILt1gykGixmOr3FPriMhuX
 oVwiMTXVGLTGZpqXlRWcPKCxJkyg/ZWUxhLZkQ0TpPik+55kQapYT1c1CXs9kR7evRvzWJRUy
 VMEbclj1RSiay7Ps8nr4i9w5D63BJYU5WBAogD+2/GRd7Hj/z3LXVcUxDJl897NMM9KO2DhnK
 tjxzhkkJWRKsAKhRB/CPXnd20WZGNyQ953qzPLyoDp2JIuYIhHol/oBkJ0tFZjVYP3qokzOB/
 ZbDANerwK6Q8sxoa4rqWCKk2kDc0siqGKJXTS2Ca+mDJ5+EVKOhgAKnCDh4rvWMDEshCF+/JN
 iYLvE2ftThSRLXp5aTDOMwGLW3thJO5vfdlIuPTQ3hQ0LN6HGZ2Ha5KDtquyLGwAmMQVu4rVw
 kQY1lcVe7TTyMGm8mAr568PM2xGeHqaxkZCIqkSAkVxEdRohBqFtCKImfvfgbvS1mlNbHJ+Nc
 vNbTOkQoHMt0TVj+Aa6jIRYLHnfjxXhCWh+sH/GzXJjpVb6TpsPg0qPd/2W+uu4ZMrrtpygYl
 0NnnKEtkvKYb9Epz1t924jdawNLhBW4z/snAKA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 7:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When CONFIG_ADVISE_SYSCALLS is not set/enabled and CONFIG_COMPAT is
> set/enabled, the riscv compat_syscall_table references
> 'compat_sys_fadvise64_64', which is not defined:
>
> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8):
> undefined reference to `compat_sys_fadvise64_64'
>
> Only set __ARCH_WANT_COMPAT_FADVISE64_64 when CONFIG_ADVISE_SYSCALLS
> is set.
>
> Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/include/asm/unistd.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -18,8 +18,10 @@
>  #define __ARCH_WANT_COMPAT_PWRITE64
>  #define __ARCH_WANT_COMPAT_SYNC_FILE_RANGE
>  #define __ARCH_WANT_COMPAT_READAHEAD
> +#ifdef CONFIG_ADVISE_SYSCALLS
>  #define __ARCH_WANT_COMPAT_FADVISE64_64
>  #endif
> +#endif

I think it's better to add this to kernel/sys_ni.c next to
COND_SYSCALL(fadvise64_64), to make it more consistent
with the other conditionally enabled syscalls.

        Arnd
