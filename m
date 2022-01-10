Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3622C4897DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiAJLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:46:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbiAJLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:44:47 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6srB-1mIELs0cE3-018Ljf; Mon, 10 Jan 2022 12:44:43 +0100
Received: by mail-wm1-f41.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso7100925wme.1;
        Mon, 10 Jan 2022 03:44:42 -0800 (PST)
X-Gm-Message-State: AOAM533rbW8I/zhbzzufvc7FVVKccYs2HyUks/Txze1jfZ/j7XE332Xm
        Bk2YP3WYRRlkZiX6t5B/nD4R+yzhVNZCNnGIh7U=
X-Google-Smtp-Source: ABdhPJxOkVX5X/eP4ROAMmqEcBQO9QsPU/GNla4UTfIaHqTpDouNC4IkJVmWSHu8Rit8nW/iWcW7PE1EcM2YzrteSLk=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr738103wmk.98.1641815082604;
 Mon, 10 Jan 2022 03:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-3-guoren@kernel.org>
In-Reply-To: <20211228143958.3409187-3-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Jan 2022 12:44:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3RALe7ihmhZ-5jucrH_0CZm3VyPaVfT-nC-96=1pKTcQ@mail.gmail.com>
Message-ID: <CAK8P3a3RALe7ihmhZ-5jucrH_0CZm3VyPaVfT-nC-96=1pKTcQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/17] fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
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
X-Provags-ID: V03:K1:QcdpajMVdqePgdZs3xa0JNoXkGWZsqEGyIW4ADogHwcH7sEw3sc
 B6Sdrms+G3BiHqA+1duROp8eIXF5HRkaiSYuyQ8n5o0Tgy8/Z2VI2ZYq5WzkvDflqkuWZA2
 WXt7FJmbO0Sfj8IuxngKGVl+wMGrGDmXYiYvIF29XIJaKk2wqtDfl6T5Vm0ldkRjsZpCzoy
 09PG46k5SIvkQ+r5Cx6lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/alrCxvyf30=:xd+QVZb4vLhBhl9WqKJCsl
 KHyain12c7ZXDs+xxhVJ+ZuondJEPviA2Y9XjboF+Z0SYK2zuSK0ZA5oJ92FGKocjul5mkzrR
 P/NWIWw6ni0hXK8zFOFyfYR+4wbaGshot7xigWvapHBvnYwfjAMOke7+RdruEkPBhpW78hBVJ
 KcVcLkxrryggCdZIgoGKQrkyf50Htvd3umV0Isp+dYG5FGVLT5IXuGneRgiSXWGi5FeMRm2F9
 kuXwcLCyqKaWsMrE5WRNgvFdpBZwUMC2G2T1GKKrvhts1DZy8+oRqOTxklOE+MdE3velfyPUP
 MpQ+0cMzifobCG3NMduXl0dPXH1v8jEaU0AvX9uHHncsNP7NmqIuK+xDHQvjpXq6JXM3k1fnC
 Ep30dBWoGgD8iKKzN5ycaWMDV7wfVp9YwCCpLuUFYi/zWEQLy0gRWW9F9EMX3BoV4Sj2af6Fo
 tR0qEibZ6OmWHwzN0Uh2OfYCggNGj65XGIS0GoALdHsXvMXCY5punoRClJ16yNFYaz25j0JrU
 RtUXH5jvSwX8XoF/6ak+ShK/KPPzynO21x/vz84ZY3NbAA8I3MmTFBtvZbLE5K0HJX0gwUBH5
 PLJfHSSPltQ+4PNDWwqC6RUN0XEu/z4e+zYp29euQJzlKHroZoX9pD+2jJK2aI9s/tgWEIVOL
 2M66X8/3aSIKUmPfjF9oPoxnt4/X8V0KLkpuD3ViTZ/Z6OB3cNvtYLE6FAeAsHvC3axoZiUgk
 lsoKgitUGmAQkUjOue1ahu05yVml8G7orsz4294vomAvNIbJYSY6y3OqdW77Ul9Aagq9MEueG
 OrMvJ+pbN1Vl5uRFvAoHGnYk9GfLRHnr1rGVlDVvAU1dhr+VqA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> RISC-V doesn't neeed compat_stat, so using __ARCH_WANT_COMPAT_STAT
> to exclude unnecessary SYSCALL functions.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
