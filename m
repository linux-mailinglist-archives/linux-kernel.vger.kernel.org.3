Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4257B6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiGTMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiGTMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:49:09 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7093ED74
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:49:08 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id n66so1243777vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV3//eRqac2wAOEj5SLbmZLJEZAGjhuPzKep8VqbrF4=;
        b=sudcFy/I8elWAZwcRFg9JPKh7KVDxwcGnwMq50Uk0FaiivXlfpxo+VgwvAKZDM2YwQ
         vFygix0BUH9+rJrfZm+v+5FrHBGHWgFN7w2m83EGFEH7yX7TBpOSCT15pGY8po+nf5sg
         maO56HJB+IBXh+ith0PK2D5eIfvOkOb6YypAJDs7cxYdr9/oygzFOi3KlwKntczptLd1
         qRdCnUFDwpwznhCVQThpMSPlTLYGsh7O+x1wuiG7utCAgdJ196ShLgqGeB4WdDzz+TkW
         oFEw27Crw+Av2K9NT02ocx6STw/l5/oU6AxWREmM5BwctCQyOG+ss1dNqmCYYMlhlha1
         rOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV3//eRqac2wAOEj5SLbmZLJEZAGjhuPzKep8VqbrF4=;
        b=RnEa2Fn7a8V60IRUUpovYxj7pTfoD4RTxFPKYVJHJfnq6lCJW584lfqlW2ZmRpVeHP
         D/kfYr0K5VG7IQOOo/hpiL+T0lhOfA/DIIjAo70mXwcctZFboRa3XTzQi0Zm+qd7p8Ml
         ltgMFbaVXmWRMV1jJfOrA/WmwF//QHDVFNbMPYXnXRHNfZlmYhxXf9Kv3jzdPf0eygeD
         oAoo+l2f38k9fxIXaniqPYAnuIh96sJzpagTiPOUMZg4kMp8eifwCjD2gPFYZCAoaMoO
         DwFNgIK3143S0EKdzhuLzVJTSYSNk6tT3fU0NxJGwipC6JX9kEQhCQrwkDbgXFnStVW1
         Y9nQ==
X-Gm-Message-State: AJIora+fzT2+stL3jPXrbrkViDfAlHqAC/3MHDnN6WfR6E/y6LMoS97n
        66mlXUyx5F5t8SVrS30YWp41hWdjkNQh2CK4qA9+xQ==
X-Google-Smtp-Source: AGRyM1v+tQ/2kmC75volL9wZOhVPrSEMjcY++VCEHuVmk9HhnDdHTLNbGwDIUONgCNPN3ttZcMoStOsx+WJgqPNsT6o=
X-Received: by 2002:a67:1083:0:b0:34c:61ad:d3e3 with SMTP id
 125-20020a671083000000b0034c61add3e3mr13601631vsq.12.1658321347383; Wed, 20
 Jul 2022 05:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
 <YqyVFsbviKjVGGZ9@worktop.programming.kicks-ass.net> <CABPqkBRRFhPcYL25TX6H7vWN=VKNR2+8e2_sO01Pka_R625Lqw@mail.gmail.com>
In-Reply-To: <CABPqkBRRFhPcYL25TX6H7vWN=VKNR2+8e2_sO01Pka_R625Lqw@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 20 Jul 2022 15:48:56 +0300
Message-ID: <CABPqkBSsTEGdBEqDgBXYAKWh1UpvUDYSXRpDD1KSm+JWV2eAUw@mail.gmail.com>
Subject: Re: [RFC] pr_warn_once() issue in x86 MSR extable code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 8:51 PM Stephane Eranian <eranian@google.com> wrote:
>
> Hi Peter,
>
> Thanks for taking a quick look at this.
> I am currently OOO and I cannot test this proposed patch.
> I am okay with your suggestion.
>
> Thanks.
>
> On Fri, Jun 17, 2022 at 4:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jun 17, 2022 at 02:08:52PM +0300, Stephane Eranian wrote:
> > > Hi,
> > >
> > > Some changes to the way invalid MSR accesses are reported by the kernel is
> > > causing some problems with messages printed on the console.
> > >
> > > We have seen several cases of ex_handler_msr() printing invalid MSR
> > > accesses once but
> > > the callstack multiple times causing confusion on the console.
> > >
> > > The last time the exception MSR code was modified (5.16) by PeterZ was:
> > >
> > >   d52a7344bdfa x86/msr: Remove .fixup usage:
> > >
> > >   if (!safe && wrmsr &&  pr_warn_once("unchecked MSR access error: ..."))
> > >                show_stack_regs(regs);
> > >
> > > Note that this code pattern was also present, though in a different
> > > form, before this commit.
> > >
> > > The problem here is that another earlier commit (5.13):
> > >
> > > a358f40600b3 once: implement DO_ONCE_LITE for non-fast-path "do once"
> > > functionality
> > >
> > > Modifies all the pr_*_once() calls to always return true claiming that
> > > no caller is ever
> > > checking the return value of the functions.
> > >
> > > This is why we are seeing the callstack printed without the associated
> > > printk() msg.
> > >
> > > I believe that having the pr_*_once() functions return true the first
> > > time they are called
> > > is useful especially when extra information, such as callstack, must
> > > be printed to help
> > > track the origin of the problem.
> > >
> > > The exception handling code seems to be the only place where the
> > > return value is checked
> > > for pr_warn_once(). A minimal change would be to create another
> > > version of that function
> > > that calls DO_ONCE() instead of DO_ONCE_LITE(), e.g., pr_warn_once_return().
> > >
> > > I can post a patch to that effect if we all agree on the approach.
> > >
> > > Thanks.
> >
> > How about something like this?
> >
> > diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> > index dba2197c05c3..331310c29349 100644
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -94,16 +94,18 @@ static bool ex_handler_copy(const struct exception_table_entry *fixup,
> >  static bool ex_handler_msr(const struct exception_table_entry *fixup,
> >                            struct pt_regs *regs, bool wrmsr, bool safe, int reg)
> >  {
> > -       if (!safe && wrmsr &&
> > -           pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
> > -                        (unsigned int)regs->cx, (unsigned int)regs->dx,
> > -                        (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
> > +       if (__ONCE_LITE_IF(!safe && wrmsr)) {
> > +               pr_warn("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
> > +                       (unsigned int)regs->cx, (unsigned int)regs->dx,
> > +                       (unsigned int)regs->ax,  regs->ip, (void *)regs->ip);
> >                 show_stack_regs(regs);
> > +       }
> >
> > -       if (!safe && !wrmsr &&
> > -           pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
> > -                        (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
> > +       if (__ONCE_LITE_IF(!safe && !wrmsr)) {
> > +               pr_warn("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
> > +                       (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
> >                 show_stack_regs(regs);
> > +       }
> >
> >         if (!wrmsr) {
> >                 /* Pretend that the read succeeded and returned 0. */
> > diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
> > index 861e606b820f..63c3bbcef694 100644
> > --- a/include/linux/once_lite.h
> > +++ b/include/linux/once_lite.h
> > @@ -9,15 +9,27 @@
> >   */
> >  #define DO_ONCE_LITE(func, ...)                                                \
> >         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
> > -#define DO_ONCE_LITE_IF(condition, func, ...)                          \
> > +
> > +#define __ONCE_LITE_IF(condition)                                      \
> >         ({                                                              \
> >                 static bool __section(".data.once") __already_done;     \
> > -               bool __ret_do_once = !!(condition);                     \
> > +               bool __ret_cond = !!(condition);                        \
> > +               bool __ret_once = false;                                \
> >                                                                         \
> >                 if (unlikely(__ret_do_once && !__already_done)) {       \

You need to replace __ret_do_once with __ret_cond above and then it
compiles and works.
I have tested with a kernel module that reads and writes to an illegal MSR:

unchecked MSR access error: RDMSR from 0x1234567 at rIP:
0xffffffffc00ec138 (rdpmc_intel+0x28/0x21d0 [rdpmc_test])
Call Trace:
<TASK>
  rdpmc_bench_store+0x53/0x80 [rdpmc_test]
  kobj_attr_store+0xf/0x20
  sysfs_kf_write+0x34/0x50
  kernfs_fop_write_iter+0xfa/0x180
  vfs_write+0x334/0x3d0
  ksys_write+0x71/0xe0
  __x64_sys_write+0x1b/0x20
  do_syscall_64+0x44/0xa0
  ? exc_page_fault+0x6e/0x110
  entry_SYSCALL_64_after_hwframe+0x63/0xcd


Tested-by: Stephane Eranian <eranian@google.com>

>
> >                         __already_done = true;                          \
> > -                       func(__VA_ARGS__);                              \
> > +                       __ret_once = true;                              \
> >                 }                                                       \
> > +               unlikely(__ret_once);                                   \
> > +       })
> > +
> > +#define DO_ONCE_LITE_IF(condition, func, ...)                          \
> > +       ({                                                              \
> > +               bool __ret_do_once = !!(condition);                     \
> > +                                                                       \
> > +               if (__ONCE_LITE_IF(__ret_do_once))                      \
> > +                       func(__VA_ARGS__);                              \
> > +                                                                       \
> >                 unlikely(__ret_do_once);                                \
> >         })
> >
