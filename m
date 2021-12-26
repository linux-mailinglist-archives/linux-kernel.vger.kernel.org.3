Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5847F6C3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhLZMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhLZMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:38:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECEC06173E;
        Sun, 26 Dec 2021 04:38:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BCD60DFA;
        Sun, 26 Dec 2021 12:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B6C36AF3;
        Sun, 26 Dec 2021 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522315;
        bh=o76Bq5CH6JQYJurwTN9je+XT2iTobUiIxe/Uui+wias=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=axouHMvAD+06n+Ys1vxkhakSE66du65vKMVR9JaqpQcEGtR+OtBv8OFA4MTuU7Yi5
         Z065lUIWSARqElBcbA7PMKAlRBflNQxflLMrT+KpHTd/rWhpM/jVuFbDATRkmK0D2j
         MJOiavy8zhz+GWNngL1ayVtN4w7GhXufo5I4d4UkxDD6Ek9bUPuPFOB9r2KWhWWQLV
         FWN6eaCconXiFMOjFWoIQyEDTB2wm64+EOR5ehYKGmx/pOorBuA6ombIqUwPWYKAr0
         utR+MhT0cHa6W9+hv60KMrSyosxXOaD4s369R1pFbF3K2hdAWB+jeTNxAHJUkLhd+9
         5+kmD9Silgvjg==
Received: by mail-ua1-f51.google.com with SMTP id v12so10714033uar.7;
        Sun, 26 Dec 2021 04:38:35 -0800 (PST)
X-Gm-Message-State: AOAM533ug4vz6AtRErDgeysyQkMWeC5PhsVgsL/M5mfkO5LbxVDT1HLh
        waIemCDlfO3oaGZ9Rg7axBRxdREIUP9HS/eTyN8=
X-Google-Smtp-Source: ABdhPJxYXL57S/1WWUdbZ3QalfrT+pnzWcLsk0PLFsmPywHotfGGswokAC8FpojTD1DtObuaVVBfBUXqawlVoiBv9qY=
X-Received: by 2002:a67:f94b:: with SMTP id u11mr3298864vsq.51.1640522314246;
 Sun, 26 Dec 2021 04:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com> <20211226162223.795f9417@xhacker>
In-Reply-To: <20211226162223.795f9417@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 26 Dec 2021 20:38:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
Message-ID: <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 4:36 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> On Wed, 22 Dec 2021 20:59:30 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> > > > s390, mips, sparc) have supported COMPAT mode. But they all have
> > > > history issues and can't use standard linux unistd.h. RISC-V would
> > > > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> > > > /unistd.h.
> > > >
> > > > The patchset are based on v5.16-rc6, you can compare rv64-compat32
> > > > v.s. rv32-whole in qemu with following step:
> > >
> > > Looks good overall, see my individual replies for minor comments I had.
> > Thx for the review :)
> >
> > >
> > > I think there is a bigger question to answer though, which is whether this is
> > > actually a useful feature for rv64. In general, there are two reasons for
> > > wanting compat mode:
> > >
> > > a) compatibility with existing binaries and distros
> > >
> > > b) reducing the memory footprint of user space in a memory constrained
> > > environment, either deeply embedded or in a container.
> > >
> > > For the other architectures, a) is clearly the main driver, but equally so
> > > this is not the case on riscv, which does not have any legacy 32-bit
> > > code. Without that, adding compat mode would mainly introduce a
> > > second ABI to a lot of environments that at the moment only need to
> > > support one, and that adds complexity to the implementation and
> > > the extra attack surface of the second syscall ABI when an exploit
> > > may be possible only in compat mode.
> > >
> > > There is still some benefit in b), but it would need to be weighed
> > > against the downsides above. Can you explain in more detail what
> > > use cases you have in mind, and which CPU cores actually support
> > > this mode?
> > The most reason is about b), see our customer's product:
> > https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/
> >
> > So I think all our next generation rv64 cores should support
> > compat-mode. Compare to releasing rv32-full core, rv64 compat-mode is
> > very cheap for our CPU design.
> >
> > You would get the answer when our new generation CPU is announced and it's soon.
> >
>
> What about adding RV64 ILP32 support instead? This don't need HW side
> modifications so can benefit all RV64.
ILP32 is another topic in C Language Data Type Models and it couldn't
replace the standard rv32 ecosystem.
COMPAT is a common framework in Linux (7 arches have been supported),
so let rv64 support COMPAT mode is considerable.

Customers would choose ILP32 / RV32-compat by themself and that
depends on which one has a better ecosystem.

>
> Thanks
>
> > Currently, only qemu supports rv64 compact mode, that is my colleague
> > (LIU Zhi Wei) contributed.
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
