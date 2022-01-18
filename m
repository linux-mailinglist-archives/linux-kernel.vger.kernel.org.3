Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC43491AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353000AbiARDAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbiARCtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:49:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B0C061757
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:40:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so73396361edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6Qv2WKh0hCkWoVHwCGvcaqbsi7gpIChCPsK64rh30M=;
        b=azwTj/cRumZPDXhNC4y3XzIj2U5fMu5ZwhmjXXIFWRk73S9De2kMng227tZPuwVdVB
         ZU+zjybXapusyiwVvDw7Fr6tzV8DXI8il0nOvRF+nY/O36B0JZg0UA2qAzABOKL+HScx
         05yy1gh/5lvXVKzaEaL+dgd9tTAvx+/CVVETjVaxvi5JYgEq06CbHJML9F9OzeNDOq34
         wu6tMbk5hseQ0mB++4YtMhM6XUcjQFwSmrs3XajDdR5xm1gO+H447WUB4fiiD4Nehkl1
         wK236VWl6KGnlOik7Z+SUsBNOnW5oEa7jYU/hX+ijFjwt0Kdk2YMcF4gJkC1SQtUp/QW
         I6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6Qv2WKh0hCkWoVHwCGvcaqbsi7gpIChCPsK64rh30M=;
        b=3K+SDY/N3LF4bS7ZxXuYQ2v/J3VeTyJQwdcNgnI/3lZbWVY4ga1B/bsHi519m0S0W4
         Em+nm1zv5eGGCVaZR5xnz2wC9gduxdiOsrsB7eEiF/WZwwcaqJRRlhhbFjWyvBXStd49
         AkfScnK/A5YihJ2yccOIX+FNl3mQCuXNw5jhnj5IUDEI+5HtuYqY5xhFc4T3eHXv0Vrp
         J+M5DQHDcctkYoy7eTDOIYEEA7HRWRcdppFgHWa9z5XRUS2Wxtk/2QcVxEAW8dXaLK69
         eBATlHSCKuXMhXEQlQ8cUhbgNcRAkjC7BNIQF15PY4Hib9R7gvQ9m5d2JWsZxF9r/uyP
         Jj0A==
X-Gm-Message-State: AOAM531ldftIyTHpFHYsAAVvYhKAkMqPmDp187Ru8cUnipIznA3R2uLk
        14HQMFkZYBc8iidVWzq3BtHCeKlbaPEF7EHp82A=
X-Google-Smtp-Source: ABdhPJwul/yH7lfmy1JEzJ0KnwXHz8q6/QzxbvvONP+nE0jgGPcBx/TT115UGbxek2zkVgIYrLlUgw4/KTKXSf3dnn8=
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr15772344ejc.225.1642473644549;
 Mon, 17 Jan 2022 18:40:44 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
In-Reply-To: <20220117202751.bmwvfsnqxokob6d2@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Tue, 18 Jan 2022 08:10:28 +0530
Message-ID: <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Actually your first patch - the one you mentioned had other issues -
worked perfectly when applied:

scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
do_the_work+0x16f/0x0000000000000194:
do_the_work at <...>/oops_tryv2/oops_tryv2.c:62

The second one still failed in the same manner:

scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000

So, is it possible to fixup issues with the first version?
What are these issues?

Thanks,
Kaiwan.



On Tue, Jan 18, 2022 at 1:57 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jan 17, 2022 at 11:48:39AM -0800, Josh Poimboeuf wrote:
> > On Mon, Jan 17, 2022 at 10:27:14AM +0530, Kaiwan N Billimoria wrote:
> > > Hi there,
> > >
> > > Am researching using the cool faddr2line script to help debug Oops'es
> > > from kernel modules..
> > > I find it works just fine when used against the unstripped vmlinux
> > > with debug symbols.
> > >
> > > My use case is for a kernel module which Oopses, though. Here's my scenario:
> > > I built a module on a custom debug kernel (5.10.60) with most debug
> > > options enabled...
> > > KASLR is enabled by default as well.
> > >
> > > A test kernel module Oopses on my x86_64 guest running this kernel with:
> > > RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]
> > >
> > > So, i try this:
> > >
> > > $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
> > > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > > $
> > >
> > > (It works fine with addr2line though!).
> > > Now I think I've traced the faddr2line script's failure to locate
> > > anything down to this:
> > > ...
> > > done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
> > > fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
> > > print line, "0x"$1 } END {if (found == 1) print     line, end; }')
> > >
> > > The nm output is:
> > > $ nm -n ./oops_tryv2.ko |grep -i do_the_work
> > > 0000000000000000 t do_the_work
> > > $
> > >
> > > nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
> > > with objdump -d on the module).
> > > Am I missing something? Any suggestions as to what I can try, to get
> > > faddr2line working?
> >
> > Hi Kaiwan,
> >
> > Thanks for reporting this issue.  The module text address of 0x0 is not
> > necessarily incorrect, as the address is relative the the module, where
> > all text usually starts at zero.
> >
> > I was able to recreate this problem using a module which only has a
> > single function in .text.  Does this fix it?
>
> Actually, that patch has other problems.  Try this one?
>
> ----
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] scripts/faddr2line: Only look for text symbols when
>  calculating function size
>
> With the following commit:
>
>   efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
>
> ... it was discovered that faddr2line can't just read a function's ELF
> size, because that wouldn't match the kallsyms function size which is
> printed in the stack trace.  The kallsyms size includes any padding
> after the function, whereas the ELF size does not.
>
> So faddr2line has to manually calculate the size of a function similar
> to how kallsyms does.  It does so by starting with a sorted list of
> symbols and subtracting the function address from the subsequent
> symbol's address.
>
> That calculation is broken in the case where the function is the last
> (or only) symbol in the .text section.  The next symbol in the sorted
> list might actually be a data symbol, which can break the function size
> detection:
>
>   $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
>   bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
>
> Similar breakage can occur when reading from a .o file.
>
> Fix it by only looking for text symbols.
>
> Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  scripts/faddr2line | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 6c6439f69a72..2a130134f1e6 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -189,7 +189,7 @@ __faddr2line() {
>
>                 DONE=1
>
> -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> +       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
>  }
>
>  [[ $# -lt 2 ]] && usage
> --
> 2.31.1
>
