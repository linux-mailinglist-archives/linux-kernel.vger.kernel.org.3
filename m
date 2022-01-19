Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312D4933D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351037AbiASD5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbiASD5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:57:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A34C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 19:57:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 30so4972078edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 19:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eX2rSidx3JW5N0X9VliVxFiFClVAB3F2ewNXtyKaMLg=;
        b=g9cvhh7UJ6fvLJRQQdwedDq9rXLCJdeaivlyqsvtvmZrKzj6Hg9snLImqQDzZ8/qK+
         99BMVJGflkm5kugKHlAotw7mCySBtbOgwvW6q1/vTCIIcZo9EG31wBLLE0AkH5JXQZ3e
         iCWqCfrrLL+HpLUCkZUy7AtiT9pvglbiBtAgEuRr6dLAlkFGYlpWnqKerr0nxE4+Dij9
         zdAZHw7fmpfSMrU+JG7xT76z/SwS5OAnSZx7G2VUpTe7dl79opZWEedjF97wPGKU7Nm7
         O1vc3bEomv7Z+dadPJeAyN3YUhGbAP4ER8vhIoGlBNypPi2Yxjj09FMkUW0HPAfJNUeC
         pF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eX2rSidx3JW5N0X9VliVxFiFClVAB3F2ewNXtyKaMLg=;
        b=aGso5kaFMNG0riVQWg09qkNy08RfCBQ8pc4LCHLTsmD1XK/Z5bZbvKwQjXp1FDnhNR
         gNdMilFdHFQP5gYaMrxfU4KDnN8oZLPxpyVrMn/y1zTDonqsnRekTqP5S7GqunQu5JA6
         dfulOmEsZd4gAP/LAjhsZ07FuyeCKaXSVdW4xHgGu+k88r4a2v+65ISqBDQWyZMx+LoJ
         jsxu4jfcPUfWJoDQ8WRhkRGywTl+y5KVi0gEia+g6m3VzwzPpO/USUTNXGe8M6Mu5gQm
         3cSXyHCB0v4Tv9zuluHqWKev1UWxUYbbowzeN9aiE6M7uUd4mtzZyCsWxeL6ubOduQPt
         QFbQ==
X-Gm-Message-State: AOAM530PVdoHSZKmt9vD0dqV45vZSHn/wLT6crBVcNJ8MQg13OK0RVOV
        E6xl8EBDSfJnL0zjzP+MmGNCt3f2wzDy61W4yZI=
X-Google-Smtp-Source: ABdhPJwi/B2IDd5vyXF0OTdF3sFWpw1nC9ER+V8yGCDluEzAXPOofhEL6WCifZcaeP0/XT7Q2J9E9G9c1jVPnxhE5B0=
X-Received: by 2002:a17:906:f19a:: with SMTP id gs26mr621784ejb.106.1642564654292;
 Tue, 18 Jan 2022 19:57:34 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com> <20220118175239.lqxi2ycgeusk5pxl@treble>
In-Reply-To: <20220118175239.lqxi2ycgeusk5pxl@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Wed, 19 Jan 2022 09:27:18 +0530
Message-ID: <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Jan 18, 2022 at 08:10:28AM +0530, Kaiwan N Billimoria wrote:
> > Hi Josh,
> >
> > Actually your first patch - the one you mentioned had other issues -
> > worked perfectly when applied:
> >
> > scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> > do_the_work+0x16f/0x0000000000000194:
> > do_the_work at <...>/oops_tryv2/oops_tryv2.c:62
> >
> > The second one still failed in the same manner:
> >
> > scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> >
> > So, is it possible to fixup issues with the first version?
> > What are these issues?
>
> The first patch basically reverts the fix in commit efdb4167e676
> ("scripts/faddr2line: Fix "size mismatch" error").  That would be nice
> as it's simpler and more robust, but unfortunately it would cause a lot
> of "size mismatch" errors with vmlinux symbols.

I see... if it comes to it, could there be a workaround where the
script detects a vmlinux image and works in a given manner,
else in this manner for other images - in effect, for modules?

>
> Can you give the output of 'nm -n ./oops_tryv2.ko'?  There must be some
> text symbol immediately after the do_the_work() symbol which is either
> out of order, or part of another section.
>
> Is do_the_work() in the .text section?
Yes...
Here's the output I get:

$ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
0000000000000000 r __func__.24215
0000000000000000 r __param_bug_in_workq
0000000000000000 D __this_module
0000000000000000 r _note_7
0000000000000000 T cleanup_module
0000000000000000 t do_the_work
0000000000000000 t do_the_work.cold
0000000000000000 b gctx
0000000000000000 T init_module
0000000000000000 t try_oops_exit
0000000000000000 t try_oops_init
0000000000000008 b t1
$

BTW, here's the code:
https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2

Thanks,
Kaiwan.

>
> > On Tue, Jan 18, 2022 at 1:57 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Mon, Jan 17, 2022 at 11:48:39AM -0800, Josh Poimboeuf wrote:
> > > > On Mon, Jan 17, 2022 at 10:27:14AM +0530, Kaiwan N Billimoria wrote:
> > > > > Hi there,
> > > > >
> > > > > Am researching using the cool faddr2line script to help debug Oops'es
> > > > > from kernel modules..
> > > > > I find it works just fine when used against the unstripped vmlinux
> > > > > with debug symbols.
> > > > >
> > > > > My use case is for a kernel module which Oopses, though. Here's my scenario:
> > > > > I built a module on a custom debug kernel (5.10.60) with most debug
> > > > > options enabled...
> > > > > KASLR is enabled by default as well.
> > > > >
> > > > > A test kernel module Oopses on my x86_64 guest running this kernel with:
> > > > > RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]
> > > > >
> > > > > So, i try this:
> > > > >
> > > > > $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
> > > > > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > > > > $
> > > > >
> > > > > (It works fine with addr2line though!).
> > > > > Now I think I've traced the faddr2line script's failure to locate
> > > > > anything down to this:
> > > > > ...
> > > > > done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
> > > > > fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
> > > > > print line, "0x"$1 } END {if (found == 1) print     line, end; }')
> > > > >
> > > > > The nm output is:
> > > > > $ nm -n ./oops_tryv2.ko |grep -i do_the_work
> > > > > 0000000000000000 t do_the_work
> > > > > $
> > > > >
> > > > > nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
> > > > > with objdump -d on the module).
> > > > > Am I missing something? Any suggestions as to what I can try, to get
> > > > > faddr2line working?
> > > >
> > > > Hi Kaiwan,
> > > >
> > > > Thanks for reporting this issue.  The module text address of 0x0 is not
> > > > necessarily incorrect, as the address is relative the the module, where
> > > > all text usually starts at zero.
> > > >
> > > > I was able to recreate this problem using a module which only has a
> > > > single function in .text.  Does this fix it?
> > >
> > > Actually, that patch has other problems.  Try this one?
> > >
> > > ----
> > >
> > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Subject: [PATCH] scripts/faddr2line: Only look for text symbols when
> > >  calculating function size
> > >
> > > With the following commit:
> > >
> > >   efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> > >
> > > ... it was discovered that faddr2line can't just read a function's ELF
> > > size, because that wouldn't match the kallsyms function size which is
> > > printed in the stack trace.  The kallsyms size includes any padding
> > > after the function, whereas the ELF size does not.
> > >
> > > So faddr2line has to manually calculate the size of a function similar
> > > to how kallsyms does.  It does so by starting with a sorted list of
> > > symbols and subtracting the function address from the subsequent
> > > symbol's address.
> > >
> > > That calculation is broken in the case where the function is the last
> > > (or only) symbol in the .text section.  The next symbol in the sorted
> > > list might actually be a data symbol, which can break the function size
> > > detection:
> > >
> > >   $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
> > >   bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > >
> > > Similar breakage can occur when reading from a .o file.
> > >
> > > Fix it by only looking for text symbols.
> > >
> > > Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> > > Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > >  scripts/faddr2line | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/faddr2line b/scripts/faddr2line
> > > index 6c6439f69a72..2a130134f1e6 100755
> > > --- a/scripts/faddr2line
> > > +++ b/scripts/faddr2line
> > > @@ -189,7 +189,7 @@ __faddr2line() {
> > >
> > >                 DONE=1
> > >
> > > -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> > > +       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> > >  }
> > >
> > >  [[ $# -lt 2 ]] && usage
> > > --
> > > 2.31.1
> > >
> >
>
> --
> Josh
>
