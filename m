Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3447F6BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhLZM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhLZM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:27:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B2EC06173E;
        Sun, 26 Dec 2021 04:27:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FFF9B80D8A;
        Sun, 26 Dec 2021 12:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40912C36AEC;
        Sun, 26 Dec 2021 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640521619;
        bh=Gt+sKS/vnEa5FGvBJkvK92fBrjRRtbp7Elv7vtB9T6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O5ND8GZTzP37FqqW8YI2l78OPV1MEBsFN5w9qPpRnexGo+9xYaa1HFPkTv5Vsu5Gg
         ZPf9GHibAO3s/vFsmfwbLMgOVy4raObDtyaVspfPGUFDdzdBI8p1mCQpOg1EHdERyy
         Hj93UzgNK+XoMK1vH+ZdB63xCnx1w7FgAW/X2m8ta/2yDh6iE/q2igFWuioe2jKu2S
         ssSpUFwimZsymCnoWbPXh/BZIR5H8KjBH5KCmIZAmAEZ4QU+EWtYl1yLJQARHRQOoy
         cKltW5PrVUKXlhzuOwnQupQOwbbSnDJ5l5dOkmuXbai247xsv39sFiSx2v/Po9Ft3Z
         7MtB4KDlYriWA==
Received: by mail-ua1-f48.google.com with SMTP id o63so22555842uao.5;
        Sun, 26 Dec 2021 04:26:59 -0800 (PST)
X-Gm-Message-State: AOAM530ITy8JNqKr249NlCL6l3KhVu6XkueVOot74II/TZmsWmg/9Ih1
        w4SYpVGQIeccIEzomgBvsGn2UeJUj0+REPR4XJo=
X-Google-Smtp-Source: ABdhPJwhAjMl5vuVSY+e1MSrYZHNtN97FcWsuy4jm06VIDX71OU9nlYSpTUdTc6ASHpq06SMtAZBcytU0piDmRlLNi8=
X-Received: by 2002:a67:f2c6:: with SMTP id a6mr3560309vsn.59.1640521618234;
 Sun, 26 Dec 2021 04:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20211225045430.2868608-1-guoren@kernel.org> <20211225045430.2868608-6-guoren@kernel.org>
 <YcdGC4ZNejSgZgRG@osiris>
In-Reply-To: <YcdGC4ZNejSgZgRG@osiris>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 26 Dec 2021 20:26:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSD-cUFzXLP4pdgkmZB=e54-uROvOFYUJDOP1ofX6_uzw@mail.gmail.com>
Message-ID: <CAJF2gTSD-cUFzXLP4pdgkmZB=e54-uROvOFYUJDOP1ofX6_uzw@mail.gmail.com>
Subject: Re: [PATCH V2 5/8] sched: s390: Remove unused TASK_SIZE_OF
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.or, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 12:26 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Sat, Dec 25, 2021 at 12:54:27PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This macro isn't used in Linux sched, now. Delete in
> > include/linux/sched.h and arch's include/asm.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/include/asm/processor.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> I could pick this up for s390, however sender (From: field) of this patch
> series does not match From: and Signed-off-by: fields above.
Thx.

>
> In general I don't pick up such patches, since this doesn't match the
> "Developer's Certificate of Origin" requirements.
> -> Documentation/process/submitting-patches.rst
I've updated .mailmap with:

Guo Ren <guoren@kernel.org> <guoren@linux.alibaba.com>
Guo Ren <guoren@kernel.org> <ren_guo@c-sky.com>

------

If you are still concerned, how about:

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
