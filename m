Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656647D2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbhLVNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhLVNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:06:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD029C061574;
        Wed, 22 Dec 2021 05:06:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49AC461A88;
        Wed, 22 Dec 2021 13:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED43C36AEF;
        Wed, 22 Dec 2021 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640178409;
        bh=+Bphm/tiPEFDYNkambYOvXEj7vwizPLJU5NueAxpGbU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jTXhOqo97ggpdKdhYZ0zO3hadSNcDpkK8jqvVEQOd2EOusUvNPlO8UFb1cUEYXQ03
         wMypA+fWhX+CK21LnEBBg59okmpcazUWC4q0J6TEKwPOIlQAp7+JwhZs/tvmwr/YK6
         7D/FtbUewcVF9B4b0piIOlOYIG8FVuLnwzIrSkAhdRyhb1Y0RZT+TcG6WzkoE42062
         Nk4LUDLrlKMrw71mLbqkyAZ3V6fR6K80WIyksz1/PIHDi1XqHdCzWVNuJVENJ1mV00
         Zd1uk1CfPBl+lVoe+IDPzGVb4DsVxVgbKixNyyPHRkw8dd1mDgYMvM5fP82ClysgHS
         yrnxpKbim7G/w==
Received: by mail-ua1-f53.google.com with SMTP id i6so4042386uae.6;
        Wed, 22 Dec 2021 05:06:49 -0800 (PST)
X-Gm-Message-State: AOAM533npzXvWfGdxm4hBevaM3xIzBU0fPZ+gV/W0Rw1SIso7ca0zjAR
        d7ZQfqAO+Glx5G6tgxdRV6IlpkWn5OuDEhuDvOQ=
X-Google-Smtp-Source: ABdhPJyDkkqn4EX2hxcOREHl7ssuLgmpk5Qt11X/aLujji1sgU4cXkTBKmYGzlUZVU2QcCBFU9wGQL/zH2P4rpz0fQk=
X-Received: by 2002:a05:6102:a83:: with SMTP id n3mr1059249vsg.2.1640178408618;
 Wed, 22 Dec 2021 05:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
 <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com> <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
In-Reply-To: <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 21:06:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQEp0hEousuEyp5cPCa5Remb_8HMZ-BXZ393_z7hbne7g@mail.gmail.com>
Message-ID: <CAJF2gTQEp0hEousuEyp5cPCa5Remb_8HMZ-BXZ393_z7hbne7g@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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

On Wed, Dec 22, 2021 at 8:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 22, 2021 at 12:34 PM Guo Ren <guoren@kernel.org> wrote:
> > On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > > If the intention is to keep them in sync, maybe use a fragment for 32-bit
> > > mode, like powerpc or mips do.
> >
> > Some people are familiar with "make rv32_defconfig". There has a
> > 32-bit.config fragment config in arch/riscv/configs/.
> >
> > I've tested with:
> >
> > make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu-
> > EXTRA_CFLAGS+=-g O=../build-rv32/ defconfig 32-bit.config
> >
> > The above is tested Okay, do you mean we should delete rv32_defconfig?
> > I think it's another topic, I just want them the same in "compat"
> > patchset.
>
> I think what you can do is to add rv32_defconfig as a target in
> arch/riscv/Makefile the same way as rv32_randconfig, and then
> delete the other file, that will keep the existing process working
> for any existing users.
Good idea, I would try.

>
> Given that there are no specific rv32 SoC implementations supported
> by the kernel today (other than SOC_VIRT), the number of users
> would be close to zero anyway.
I really agree with you, but we still need the rv32 user mode
ecosystem for memory footprint.

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
