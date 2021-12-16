Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C2477181
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhLPMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhLPMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:18:24 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:18:23 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so38324993ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMN0bMkcunDcDy+M341mc1l60osKidFHY7tRMBK0f1k=;
        b=b66RH8ghRX8hb/IhTL2LuF8+/FtnhSp6N+obCsm4ll+8j/8An/XZLq8CWfqvC5iYIP
         QjPY/ZxDrP0rgrFcurhpklCKSyJrq3UhQwY3MQMVfbXS0GmAogHgO9Ql7fr4ZCcmkYU7
         AE/AtoN0ymk9ge0SkcHVoytKN/3I1FPaHJcNZ8tQF7QbZSEwjJqmKQ+ycgX0/KmUcdzZ
         4Z++iYrc3exCqorE1ndEIocxOqbSMrJ9+WmcMRG53dCRvLV78GxPDphlGP5g8cAt1Ldd
         K8nlA4sA9J5/7KEtSGekHgAfB7l8uSdx5l3ipqP19NLrxgQM7kzuLQqqdCAiyHGqKCoV
         lO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMN0bMkcunDcDy+M341mc1l60osKidFHY7tRMBK0f1k=;
        b=m9RNqT974t2ZFRz9qhKmRC1TFOeD62HrjkqN79INDFS+g8b/t1JA885gkb2uSORNgP
         gluZwmzimtiY+qPEu/CLT/yvAEtJSuFf6oOvelz+mPt0Q/0Z+c0D94urvFv7GQBXqLYf
         PJyEfM67hMxN69MjUSxy+NwNsgkuSEMb0DbUU2SOHrJxEg2Vs2E8l9ZkwkABaBISBBGt
         DxVS34vUHZuphX4mI+oURGflgxBZ5/Kj0pNR27P2o2wGN8m5eb3+lxuAL0MHH5ezCTXL
         GMhbHu/DVK/myRafiR/a7s0gc7ggp8Ak3aL51+rz4SFCMDgmxTNRdCzaHmhrrr4YUcK9
         eS5A==
X-Gm-Message-State: AOAM530B9pNqdorLYPe2FbpOLvALJwJhzNFFQMRgj7Fw4iz5wvNgUjgm
        cqAazdFbalOhcMics7pyA7fsT6o7JrTNtcOCt50=
X-Google-Smtp-Source: ABdhPJwyO1BAbTPdSQn/zNReLBR/Y2J93HMNztDnD+JL/AaAF3F5N7R1S8BXt7UZG63+xBHmmm8ExYY/l0d8K4jAy/8=
X-Received: by 2002:a2e:95cb:: with SMTP id y11mr15281538ljh.461.1639657101015;
 Thu, 16 Dec 2021 04:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20211207124002.59877-1-liuqi115@huawei.com> <20211213183851.GD12405@willie-the-truck>
 <20211214092657.5b9c26b4e3852602eced4fda@kernel.org> <CAAgTQPUKqFn9_ENKbfJkFjT3v9L2NiFAY2xvULEj_6wguqWYNg@mail.gmail.com>
 <5c593351b3704c4490b2b122f6cb9112@hisilicon.com>
In-Reply-To: <5c593351b3704c4490b2b122f6cb9112@hisilicon.com>
From:   Jianhua Liu <jianhua.ljh@gmail.com>
Date:   Thu, 16 Dec 2021 20:18:09 +0800
Message-ID: <CAAgTQPVp7B1u1X3fCar53=b43mkLx3eZt6gP6QkS4o4_vfOscQ@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000f588f05d3426bba"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000f588f05d3426bba
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 15, 2021 at 7:48 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jianhua Liu [mailto:jianhua.ljh@gmail.com]
> > Sent: Wednesday, December 15, 2021 4:56 AM
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Will Deacon <will@kernel.org>; liuqi (BA) <liuqi115@huawei.com>; Catalin
> > Marinas <catalin.marinas@arm.com>; linux-arm-kernel@lists.infradead.org;
> > Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Zengtao (B)
> > <prime.zeng@hisilicon.com>; robin.murphy@arm.com; Linuxarm
> > <linuxarm@huawei.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
> >
> > On Tue, Dec 14, 2021 at 8:27 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Mon, 13 Dec 2021 18:38:52 +0000
> > > Will Deacon <will@kernel.org> wrote:
> > >
> > > > Hi,
> > > >
> > > > [+Janet Liu]
> > > >
> > > > On Tue, Dec 07, 2021 at 08:40:02PM +0800, Qi Liu wrote:
> > > > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > > > instruction is replaced by a branch instruction to trampoline.
> > > > >
> > > > > Performance of optprobe on Hip08 platform is test using kprobe
> > > > > example module[1] to analyze the latency of a kernel function,
> > > > > and here is the result:
> > > > >
> > > > > common kprobe:
> > > > > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > > > > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > > > > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > > > > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > > > > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > > > > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > > > > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > > > > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > > > > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > > > > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > > > >
> > > > > optprobe:
> > > > > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > > > > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > > > > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > > > > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > > > > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > > > > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > > > > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > > > > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > > > > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > > > > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > > > > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > > > >
> > > > > As the result shows, optprobe can greatly reduce the latency. Big
> > > > > latency of common kprobe will significantly impact the real result
> > > > > while doing performance analysis or debugging performance issues
> > > > > in lab, so optprobe is useful in this scenario.
> > > > >
> > > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > > >
> > > > > Note:
> > > > > As branch instruction in Arm64 has a 128M range limitation, optprobe
> > > > > could only used when offset between probe point and trampoline
> > > > > is less than 128M, otherwise kernel will choose common kprobe
> > > > > automaticly.
> > > > >
> > > > > Limitation caused by branch isn't unique to Arm64, but also to
> > > > > x86/arm/powerpc.
> > > > >
> > > > > In fact, Module PLT has been tried to get rid of limiation, but
> > > > > destination of PLT must be a fixed value, and we need to modify
> > > > > the destination (as each optprobe has its own trampoline).
> > > > >
> > > > > As discussed with Masami[2], we can start with core-kernel point
> > > > > (within 128M) as the first step, like other architectures.
> > > > >
> > > > > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
> > mples/kprobes/kretprobe_example.c
> > > > > [2]
> > https://lore.kernel.org/lkml/20211201105001.5164f98ba783e7207df1229c@kerne
> > l.org/
> > > > > ---
> > > > >  arch/arm64/Kconfig                            |   1 +
> > > > >  arch/arm64/include/asm/kprobes.h              |  21 ++
> > > > >  arch/arm64/kernel/probes/Makefile             |   2 +
> > > > >  arch/arm64/kernel/probes/opt_arm64.c          | 199 ++++++++++++++++++
> > > > >  .../arm64/kernel/probes/optprobe_trampoline.S |  97 +++++++++
> > > > >  include/linux/kprobes.h                       |   2 +
> > > > >  kernel/kprobes.c                              |  22 ++
> > > > >  7 files changed, 344 insertions(+)
> > > > >  create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
> > > > >  create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S
> > > >
> > > > I've not looked at these changes in detail, but it looks like there is an
> > > > independent patch from Janet Liu trying to do the same thing:
> > > >
> > > >
> > https://lore.kernel.org/r/1635858706-27320-1-git-send-email-jianhua.ljh@gm
> > ail.com
> > > >
> > >
> > > Thanks for noticing. I missed it.
> > >
> > > > The patch here from Qi Liu looks like it's a bit further along, but it
> > > > would be good for Janet to at least test it out and confirm that it works
> > > > for them.
> > >
> > > Yeah, it's now v5.
> > > But it seems Janet's one also has good points. I would like Janet's sharing
> > > save_all_base_regs macro and the comment about the branch instruction.
> > >
> > > >
> > > > Cheers,
> > > >
> > > > Will
> > > >
> > > > [Kept diff inline for Janet]
> > >
> > > Janet, please feel free to review and test it. It is important that you confirm
> > > this can work with your envionment too.
> > > I will review your KPROBE_ON_FTRACE patch.
> > >
> > I have tested these patch on UNISOC s9863a platform before sending.
> >
> > The test case from:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
> > mples/kprobes/
> >
> > And I do the following change for kprobe_example.c before testing:
> > 1. delete function handler_post,
> >    kprobe_init does "kp.post_handler = handler_post; --->
> > p.post_handler = NULL;"
> > 2. handler_pre calls dump_stack.
> >
> > Thanks for  the review.
>
> Hello, Jianhua. I guess Will and Masami meant you may
> test liuqi's optprobe patch on your hardware and make
> sure it can work. At the same time, Masami will also
> take care of your approach.
>
> Thanks
> Barry
>

Thanks for your explanation. I have left UNISOC,  today I have asked
old colleage to help this test.

Thanks
Jianhua

--0000000000000f588f05d3426bba
Content-Type: image/gif; name="cleardot.gif"
Content-Disposition: attachment; filename="cleardot.gif"
Content-Transfer-Encoding: base64
Content-ID: <f_kx8xd5y80>
X-Attachment-Id: f_kx8xd5y80

R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==
--0000000000000f588f05d3426bba--
