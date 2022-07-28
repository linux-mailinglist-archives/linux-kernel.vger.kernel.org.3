Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35878583691
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiG1B4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiG1B4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:56:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497AA4D833
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:56:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n138so464659iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ghVRaKpA3w2oJXBOA2AbjqUBZ9us/Teyabu+e6c3M8w=;
        b=P/LsS62sFa9dYqH9nqR68yKc+0md1rd+9GzxPihHMXLNuy6QceFKGQPFjpi63cN7EE
         D+1Pem5fb3OCJ5CRuxa+I/sIDP2Jrdimp0Ba5wvekG5X9ZyJVOnnUlUu6V7IvxPsclyd
         qiw0iSggJ2uVuimajJekRU6MjFHvN/UlwmlExqM4hs+obx5yLkhSwffnc32fW3JxtuZT
         /Z+oYhCNLcB3qPC33ErlAzxe78sjbWFUISMdmQi0Wn6Xz7SCHKqChU1NiiN6VqWp8S6y
         zshHl5Rft47KXYIpU9ExCioyoXm62vW3d9IDleW+wBfyZKNdr3nyB/bizXcHBRz5vIgv
         b7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ghVRaKpA3w2oJXBOA2AbjqUBZ9us/Teyabu+e6c3M8w=;
        b=KwcLYWAITJ3G+Se+AcHFClSb1ZbkSkTSU3b4f0fRgt6pwJFMxhogFwrpery+oYvyu0
         H9sETT9ibrEUPauV5Gx2pqb6UVcVrtW8wcsJuo26Tg01tUN/C+fXEEeZKC/icNYOpjyX
         7Ui1g33wWUuCNaAbbelLk1GqY7iR82k3TPGpJpKrreKBfFdFOq+5MCo7hbjWfmgWcqeP
         pBFhh0VhGuYT0hBiG981PPbLABQgJgN1/beoyv0V5nhSqBuMyYkwQrvGoE3nEaKJGUig
         dlmC3k2bMYZ6jE3QEG6q+fnoH1EjxbPuThuK6kacmIhp0dNjs2IrqkovsFwJdYPk9OC+
         fSLw==
X-Gm-Message-State: AJIora8nM1zo+EhCR9iKs+tZqxsX2H9k8RqkZFfs8Pf/FFoJ9MmwLgVj
        F8DhR96mIaugZu9sBPiHNwvo8rGmqzsiz0xJVRYEaA==
X-Google-Smtp-Source: AGRyM1vSKzJol69nakS/gv207Uye8H5wbZ232je3cmt5SST4SX3pvujSthz0USXF7QBZ+SB0TA1nk1mXEryMMhnUzbU=
X-Received: by 2002:a05:6602:2b84:b0:67b:d178:38bb with SMTP id
 r4-20020a0566022b8400b0067bd17838bbmr8574838iov.120.1658973363562; Wed, 27
 Jul 2022 18:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <8735epf7j5.fsf@email.froward.int.ebiederm.org> <CABKxMyOwHC9ZhL9Gxt-MVg-sy3d1kqzPviQOH845rers7inX3Q@mail.gmail.com>
In-Reply-To: <CABKxMyOwHC9ZhL9Gxt-MVg-sy3d1kqzPviQOH845rers7inX3Q@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 28 Jul 2022 09:55:52 +0800
Message-ID: <CABKxMyMMghgyVk5S0-uyPp5uBPLdOMAMw7zW6q4vBHb_iJxrow@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/4] faster kexec reboot
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> =E4=BA=8E2022=E5=B9=B47=
=E6=9C=8826=E6=97=A5=E5=91=A8=E4=BA=8C 13:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi
> Eric W. Biederman
> Thank you for your advice and opinion, I am very honored
>
> Eric W. Biederman <ebiederm@xmission.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=BA=8C 01:04=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Albert Huang <huangjie.albert@bytedance.com> writes:
> >
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > In many time-sensitive scenarios, we need a shorter time to restart
> > > the kernel. However, in the current kexec fast restart code, there
> > > are many places in the memory copy operation, verification operation
> > > and decompression operation, which take more time than 500ms. Through
> > > the following patch series. machine_kexec-->start_kernel only takes
> > > 15ms
> >
> > Is this a tiny embedded device you are taking the timings of?
> >
> > How are you handling driver shutdown and restart?  I would expect those
> > to be a larger piece of the puzzle than memory.
>
> There is no way to make the code universal in the time optimization here,
> and various devices need to be customized, but we have some solutions to
> achieve the maintenance and recovery of these devices,
> especially the scanning and initialization of pci devices
>
> >
> > My desktop can do something like 128GiB/s.  Which would suggest that
> > copying 128MiB of kernel+initrd would take perhaps 10ms.  The SHA256
> > implementation may not be tuned so that could be part of the performanc=
e
> > issue.  The SHA256 hash has a reputation for having fast
> > implementations.  I chose SHA256 originally simply because it has more
> > bits so it makes the odds of detecting an error higher.
> >
>
> Yes, sha256 is a better choice, but if there is no memory copy between
> kexec load
> and kexec -e, and this part of the memory is reserved. Don't think
> this part of memory will be changed.
> Especially in virtual machine scenarios
>

hi  Eric :

Do you know why this sha256 check is put here? I feel that it is
better to put it in the system call of kexec -e.
If the verification is not passed, the second kernel will not be
started, and some prompt information will be
printed at the same time, which seems to be better than when the
second kernel is started.
Doing the verification operation will be more friendly, and it can
also reduce downtime.

BR
albert.

> >
> > If all you care about is booting a kernel as fast as possible it make
> > make sense to have a large reserved region of memory like we have for
> > the kexec on panic kernel.  If that really makes sense I recommend
> > adding a second kernel command line option and a reserving second regio=
n
> > of reserved memory.  That makes telling if the are any conflicts simple=
.
> >
>
> I initially implemented re-adding a parameter and region, but I
> figured out later
> that it doesn't really make sense and would waste extra memory.
>
> >
> > I am having a hard time seeing how anyone else would want these options=
.
> > Losing megabytes of memory simply because you might reboot using kexec
> > seems like the wrong side of a trade-off.
>
> Reuse the memory reserved by the crash kernel? Why does it increase
> memory consumption?
>
> >
> > The CONFIG_KEXEC_PURGATORY_SKIP_SIG option is very misnamed.  It is not
> > signature verification that is happening it is a hash verification.
> > There are not encrypted bits at play.  Instead there is a check to
> > ensure that the kernel has not been corrupted by in-flight DMA that som=
e
> > driver forgot to shut down.
> >
> Thanks for pointing that out.
> but Even if the data is detected to have been changed, there is
> currently no way to recover it.
> I don't have a good understanding of this place yet. maybe for security r=
easons=EF=BC=9F
>
>
> > So you are building a version of kexec that if something goes wrong it
> > could very easily eat your data, or otherwise do some very bad things
> > that are absolutely non-trivial to debug.
> >
> > That the decision to skip the sha256 hash that prevents corruption is
> > happening at compile time, instead of at run-time, will guarantee the
> > option is simply not available on any general purpose kernel
> > configuration.  Given how dangerous it is to skip the hash verification
> > it is probably not a bad thing overall, but it is most definitely
> > something that will make maintenance more difficult.
> >
>
> Maybe parameters will be a better choice. What do you think ?
>
> >
> > If done well I don't see why anyone would mind a uncompressed kernel
> > but I don't see what the advantage of what you are doing is over using
> > vmlinux is the build directory.  It isn't a bzImage but it is the
> > uncompressed kernel.
> >
>
>
> > As I proof of concept I think what you are doing goes a way to showing
> > that things can be improved.  My overall sense is that improving things
> > the way you are proposing does not help the general case and simply add=
s
> > to the maintenance burden.
>
> I don't think so. The kernel startup time of some lightweight virtual
> machines maybe
> 100-200ms (start_kernel->init). But this kexec->start_kernel took more
> than 500ms.
> This is still valuable, and the overall code size is also very small.
>
> > Eric
> >
> > >
> > > How to measure time:
> > >
> > > c code:
> > > uint64_t current_cycles(void)
> > > {
> > >     uint32_t low, high;
> > >     asm volatile("rdtsc" : "=3Da"(low), "=3Dd"(high));
> > >     return ((uint64_t)low) | ((uint64_t)high << 32);
> > > }
> > > assembly code:
> > >        pushq %rax
> > >        pushq %rdx
> > >        rdtsc
> > >        mov   %eax,%eax
> > >        shl   $0x20,%rdx
> > >        or    %rax,%rdx
> > >        movq  %rdx,0x840(%r14)
> > >        popq  %rdx
> > >        popq  %rax
> > > the timestamp may store in boot_params or kexec control page, so we c=
an
> > > get the all timestamp after kernel boot up.
> > >
> > > huangjie.albert (4):
> > >   kexec: reuse crash kernel reserved memory for normal kexec
> > >   kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
> > >   x86: Support the uncompressed kernel to speed up booting
> > >   x86: boot: avoid memory copy if kernel is uncompressed
> > >
> > >  arch/x86/Kconfig                   | 10 +++++++++
> > >  arch/x86/boot/compressed/Makefile  |  5 ++++-
> > >  arch/x86/boot/compressed/head_64.S |  8 +++++--
> > >  arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++---=
--
> > >  arch/x86/purgatory/purgatory.c     |  7 ++++++
> > >  include/linux/kexec.h              |  9 ++++----
> > >  include/uapi/linux/kexec.h         |  2 ++
> > >  kernel/kexec.c                     | 19 +++++++++++++++-
> > >  kernel/kexec_core.c                | 16 ++++++++------
> > >  kernel/kexec_file.c                | 20 +++++++++++++++--
> > >  scripts/Makefile.lib               |  5 +++++
> > >  11 files changed, 114 insertions(+), 22 deletions(-)
