Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A248AC73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349451AbiAKL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbiAKL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:27:55 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC66C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:27:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id n68so697287ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pipRLOhangQj3JGaPm/GWdwmPLHI1cgvgy+R6CmbyiY=;
        b=IMBUY3QzXIL+I84inZKNOITo6W8RLTchYPtrqrrbTmLeP1TGGS78CmRPuROCXMwtsL
         cO+AGYqpQZy9j6NoeFlkLWYYfptyMDJjGJUZr+gI1RwJymhCTXycvmgIujF4lVL1vnS4
         y8/82NRfHvmM8bGSNDyaNm2MwPcgu5QNF2FK8zG5aTZnCQAfFUWxyMYuCOUh+KUvDymA
         DADTEdiVgL9W6AFPJpcho6/Hm82OfMeZ13aaRpP0jqTX/QxGe9qThiKWvgSd9ONrEBhx
         91JaCFC86gRVM15xVuogxUeDAOctSRvDPPPyF7hR/hX/qcLMMH1h6iuCq45vDLK9tFRY
         uPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pipRLOhangQj3JGaPm/GWdwmPLHI1cgvgy+R6CmbyiY=;
        b=wsea07KfHD+XYspQP6eTkS2ax6uT15YOfY2+kNxCPqidVzlhVPvm7EGN3vHKYYSIJG
         q/zyh0JsDIj4H/aSy6e18+RE/9gPkmPvQEsiJ6K98G8ZUdn6Xgy/tcadgYTsPTBTIxy+
         nQd5eFS3YmyOBosX3Y6V1bR1rcB75MbQLc/zagYorrhgFKTS2nuqQ42Ie4+Ndj5iNvCX
         BeD12Ttprh/dymODDc60pQd4hzBP2Yo9vhh6+zOJzMRLiQEojWXvPhmbHeGBG9GTzrZY
         IuLTlMqcN0f0YRpozlYw5s6sMNWbHxoLf0uZDfEzlzoly2MEGB/4b68Z4brAxLGoXE4L
         E5RA==
X-Gm-Message-State: AOAM530mY1hoFhffsCo/IXtR/o6xWpH3zJ3N2vSp9kyF8rYS5csQ2enz
        jyP8XtthKiqL7AcG0odXhN+x3eZ+5yqlWcB7CvqIGxJ/PGI=
X-Google-Smtp-Source: ABdhPJz6URxdoloQUPhScaAT77mGwx/VTtaUYXw1n73xADDPmrc2UoHxjFLQUbwPJIBnebz3T28oI9HY99A56ayjn2k=
X-Received: by 2002:a25:6991:: with SMTP id e139mr383937ybc.359.1641900474060;
 Tue, 11 Jan 2022 03:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
 <CAKXUXMyepnLO=jLPciG5mWvTxbQGR+1PaeYs1_c+-t3hFAEhNg@mail.gmail.com> <ff6e3942-24e4-25ec-946c-cc6301ebf260@collabora.com>
In-Reply-To: <ff6e3942-24e4-25ec-946c-cc6301ebf260@collabora.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 11 Jan 2022 12:27:42 +0100
Message-ID: <CAKXUXMzkibUyMOZnUv2A7Ksv=E_qYPqjfaio3at-pqG9RYukig@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: warn for p0 patch only if prefix is not b
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:47 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
>
>
> On 11.01.22 12:18, Lukas Bulwahn wrote:
> > Dafna,
> >
> > On Mon, Jan 10, 2022 at 9:06 PM Dafna Hirschfeld
> > <dafna.hirschfeld@collabora.com> wrote:
> >>
> >> It might be that file 'b' happens to exit. In that
> >> case, if the prefix is also 'b' (which is the
> >> common case) we get the falsely warning:
> >>
> >> patch prefix 'b' exists, appears to be a -p0 patch
> >>
> >> So warn only if prefix is not 'b'
> >>
> >
> > The checkpatch script that is maintained here is really only intended
> > for its use in the kernel development. You may use checkpatch anywhere
> > else, but any changes that increase complexity for those other use
> > cases is really difficult to argue for inclusion in the kernel
> > repository. The checkpatch script currently is already large and
> > complex enough and all rules need to be understood as rough
> > heuristics, not as strict rules.
> >
> > So, can you point to a kernel repository where there is actually a
> > file 'b' included? On a quick scan, I could not find a file 'b' in the
> > current trees of the repositories on my machine.
> >
> > I am just letting you know about what I have observed; I do not decide
> > on the inclusion of this patch, though.
>
> Hi, a 'b' file might make it to the source folder as an untracked file.
> This actually happened to me since I was too lazy to give it a meaningful name.
> Then I got this warning and it took me some time to figure out what is the problem.
>

Well, but you run checkpatch.pl on a patch, right? So, you need to add
the file explicitly with git (where you notice adding a file called b,
which probably is really not a good name), you create a git commit
(where that is pointed out again), then create a patch from that
(which you may manually look at again) and then run checkpatch.pl
before you submit it (again, submitting a patch with a file 'b' is
probably a good reason to rethink your submission).

If it helps, you can add some documentation on the PATCH_PREFIX rule
in the checkpatch documentation at
./Documentation/dev-tools/checkpatch.rst. Especially, you can note the
situation you encountered there, e.g., that adding files with explicit
name 'a' or 'b' may make this rule trigger. If that documentation of
the rule is helpful, I will ack that documentation patch and request
inclusion of it.

Lukas

> Thanks,
> Dafna
>
> >
> > Lukas
> >
> >> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> >> ---
> >>   scripts/checkpatch.pl | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >> index 1784921c645d..72263b142e39 100755
> >> --- a/scripts/checkpatch.pl
> >> +++ b/scripts/checkpatch.pl
> >> @@ -2821,7 +2821,7 @@ sub process {
> >>                          $in_commit_log = 0;
> >>
> >>                          $p1_prefix = $1;
> >> -                       if (!$file && $tree && $p1_prefix ne '' &&
> >> +                       if (!$file && $tree && $p1_prefix ne '' && $p1_prefix ne 'b' &&
> >>                              -e "$root/$p1_prefix") {
> >>                                  WARN("PATCH_PREFIX",
> >>                                       "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
> >
> >> --
> >> 2.17.1
> >>
