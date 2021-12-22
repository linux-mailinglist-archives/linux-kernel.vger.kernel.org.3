Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124D747D17A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbhLVMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:07:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321EC061574;
        Wed, 22 Dec 2021 04:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4373B81C0F;
        Wed, 22 Dec 2021 12:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1BC36AEF;
        Wed, 22 Dec 2021 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640174827;
        bh=+wqXN0WBIIDqmYLgad4enZJ2Q7SP/1omJsy3ZSi/9sQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgJBC2cmzC9ZDUPKM6OeTvPlm0kpzUupY5nnoF0GpYUQXfS3Aj0YPjqxHrKtExyhR
         Kv3JoqgSULLvap/lDwP/Cbt8P6hB6dmJBD0x5I4PFJUUVlfmSksd6FNRRlxQw90wsZ
         bO9Kf5f/3fraeTe4698bzDeG28PRNet9rdyINQAQFzUN/P5L0XO8wjIXAZB9m8f/Sy
         DAG9Vxy1fg5xIT8iODXBDoIfFd2MVRlOt3pSUGixzUAu/hpzHKTozKUeTD0Cnp5Jrj
         ktKcQC4HBaPk3xdXFPBECnw2bQb2Cb0p8Vcdff/7fnt9643HExwc8iW/9ITp9eCMhI
         64UBiTMWNQidQ==
Received: by mail-ua1-f47.google.com with SMTP id y23so3713526uay.7;
        Wed, 22 Dec 2021 04:07:07 -0800 (PST)
X-Gm-Message-State: AOAM533WBNcj8hLjuREmBRwv6gFH8PhTU/z4/1A2L5tw0pjpCH/lJptH
        +F2ksDSOy85WuuQ7+654r68NCfBwmNCFmDXgsg0=
X-Google-Smtp-Source: ABdhPJxGX4KrZs2TnGR1gSjUu92pDva4Xdm8isb3ATByYY/kfaTFVcqSn5kqos02FM+dXr9lRhbSDFcRUucnDxIKpsQ=
X-Received: by 2002:a67:e244:: with SMTP id w4mr788901vse.51.1640174826756;
 Wed, 22 Dec 2021 04:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-9-guoren@kernel.org>
 <CAK8P3a0-ZOwoC_Ft+TiKAXdETcqU5XPS+9DZGkA+bB73SNCCbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0-ZOwoC_Ft+TiKAXdETcqU5XPS+9DZGkA+bB73SNCCbQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 20:06:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ=Yo98-S12D9CbVXPJsAKpLu1NhJAVB3yu+J9thz6CUg@mail.gmail.com>
Message-ID: <CAJF2gTQ=Yo98-S12D9CbVXPJsAKpLu1NhJAVB3yu+J9thz6CUg@mail.gmail.com>
Subject: Re: [PATCH 08/13] riscv: compat: Add COMPAT Kbuild skeletal support
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

On Wed, Dec 22, 2021 at 2:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > +
> > +config SYSVIPC_COMPAT
> > +       def_bool y
> > +       depends on COMPAT && SYSVIPC
>
> Can this be moved to init/Kconfig next to SYSVIPC?

I would try another patchset, to see other architecture guys' advice.

$ grep SYSVIPC_COMPAT arch -r
arch/x86/Kconfig:config SYSVIPC_COMPAT
arch/parisc/Kconfig:config SYSVIPC_COMPAT
arch/powerpc/Kconfig:config SYSVIPC_COMPAT
arch/arm64/Kconfig:config SYSVIPC_COMPAT
arch/riscv/Kconfig:config SYSVIPC_COMPAT
arch/s390/Kconfig:config SYSVIPC_COMPAT
arch/mips/Kconfig:config SYSVIPC_COMPAT
arch/mips/Kconfig:      select SYSVIPC_COMPAT if SYSVIPC
arch/mips/Kconfig:      select SYSVIPC_COMPAT if SYSVIPC
arch/sparc/Kconfig:config SYSVIPC_COMPAT

>
> > +
> > +COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
> > +{
> > +       return 0;
> > +}
>
> This confused me a bit while reviewing, would it make sense to reorder the
> patches to add the three missing functions first instead of adding the
> dummy and then replacing it?
Okay, I would try in the next version. Make the compile at last.

>
>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
