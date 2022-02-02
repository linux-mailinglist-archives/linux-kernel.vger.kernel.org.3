Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835EC4A6F98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiBBLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBBLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:08:11 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F9C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:08:11 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z18so7915607ilp.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvwP2pq0A69XLEtJRHQeT2K6fCrFL3jZAy9726cRZ/o=;
        b=hkqcAskloSPcrI90jAiwlBCksVcgOjKlFwsucBqi2eYnoWM21moZyBpPgJZ2Xrm0Hd
         pHAJYXSQZIBL8mbYzQFC59iVtLwvbHwLCgjJkw2aYGLyCF+AtQF7qcLxUvcPhU6i68hU
         gYg0UVCo/wSNJrPZJr0TQh3Qlu6UwG2vGdV9uh8q22V2i6+O3tWLV9l7bpszGXrzzovf
         VIxz33W0z2qTWPHNQDb1AMIDAqW+k1i+EyfL6Axy0eeh5oSMXA5T0eMJlGDXB2rPOIHQ
         Q1Kn7C5pwmn/LatVJ9WCYsGLFluu6my88RVOd0QFA5llO69NciKTYbwEpxySXt7ODtRA
         W8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvwP2pq0A69XLEtJRHQeT2K6fCrFL3jZAy9726cRZ/o=;
        b=GVq7CG33e/73sLF4s5AGDsIPE06efbcblIw5IF9Awhavc33LgeJ6PA9cXij3G526Aq
         wQexMnl8A7b/3mqLlBi1rkmyYQ4Frx1sFzitvXMIwXLjeTuPvb1EfIZWrNVraf2/+bGp
         z5df6ir/EBd7dp84hZe5+cfJmmWNhTFAdSDlBLHYkzPlP8oOYAt0/aTkNPC8GUzsdN1p
         2EAziVSrQltG3mRS3ZnNqH1RSAMoWy4tMs/wdIAlJUQUSWtt9k7w1KBXs0SPaG6kqC0N
         Wd+xyMtzzcvuKZLXJ334rISJrgj2yWuGaxEAR7d3/zTZDdt5sBBK0k88JmqRY+m9ieYd
         Bjxw==
X-Gm-Message-State: AOAM532Yosf04nSKWjdqd4lkCQuUUezB0frBlVihH9P4mwBvJQcmzzTp
        ZqaVkbR/1drM/oUidKFLMorPeSZ24StvCCAuozMkwnWtmR29tg==
X-Google-Smtp-Source: ABdhPJxvcnLnLL44YJGu9Hx6EDcJ3di6PMIRblKZuakSdFXT0QwOZsAXIX4XpbxJvvDNsWPbd6t+//aY4zx6dFeQpLw=
X-Received: by 2002:a05:6e02:1a4f:: with SMTP id u15mr6037825ilv.245.1643800090714;
 Wed, 02 Feb 2022 03:08:10 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com>
In-Reply-To: <00000000000038779505d5d8b372@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 2 Feb 2022 12:07:59 +0100
Message-ID: <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>, palmer@dabbelt.com,
        alexandre.ghiti@canonical.com
Cc:     syzbot <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has already not been able to fuzz its RISC-V instance for 97
days now because the compiled kernel cannot boot. I bisected the issue
to the following commit:

commit 54c5639d8f507ebefa814f574cb6f763033a72a5
Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri Oct 29 06:59:27 2021 +0200

    riscv: Fix asan-stack clang build

Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
enabled. In the previous message syzbot mentions
"riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
Binutils for Debian) 2.35.2", but the issue also reproduces finely on
a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
For convenience, I also duplicate the .config file from the bot's
message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d

Can someone with KASAN and RISC-V expertise please take a look?

--
Best Regards,
Aleksandr


On Tue, Jan 18, 2022 at 11:26 AM syzbot
<syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f6f7fbb89bf8 riscv: dts: sifive unmatched: Link the tmp451..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=1095f85bb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> dashboard link: https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000038779505d5d8b372%40google.com.
