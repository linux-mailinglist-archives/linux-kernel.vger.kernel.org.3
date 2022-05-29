Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E725371E7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiE2Rcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiE2Rca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:32:30 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE4E00C;
        Sun, 29 May 2022 10:32:28 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24THW0Ph026763;
        Mon, 30 May 2022 02:32:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24THW0Ph026763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653845521;
        bh=PJmvZYGDP63aMnL4Yd3Xe0U7Djvz59KZkG+0G/8W6lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tY4KV1xAR5/Zpm6597aHezsFqX4emA6FElnJ7lPEGUH+99C3D0mZlEdfD2guuixGt
         NBnKkOZFs5vMmUWJ8/7CNU8qgg+bjgNdELEzI4FWa8geBTIUx02K3UN6nXe/FZQt1s
         omw1lBMUc9gDF85BOdF1ftd6XSEtSNg3W8Fb3OLA+x4KILxyzyxUcrN3T41oakn4b6
         kn0BTgKejUJkPElOvOaPCFIWvk/RbpNFukN8U1W+sCWGs1BBOZAk5LmdQB7hspMdm5
         t8Wm6jHDQul6aEZu7KWDyZpwwyM24nOIJlWnK+58UykmA8EfbVKx5qdl1Ev06CGa9d
         CrHjO8NiH2Kyw==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id f21so8662645pfa.3;
        Sun, 29 May 2022 10:32:00 -0700 (PDT)
X-Gm-Message-State: AOAM530tlS0bv0vc8cS9sHyq+yGn/9jixCMiqOj09fIp4MxYvrHwJt1g
        hIwDlDrA36Ts9Q/HOfBQ3ijpSEeWc6QD1koEJxY=
X-Google-Smtp-Source: ABdhPJzZIrreolgyafL3/q0hGVRVntHJqsJIF/RwU2GjXBIoTcXZL2NWm5F+NsN7BtzDOw1Ku1Rm/1vu7PXASoJHXjE=
X-Received: by 2002:a05:6a00:234b:b0:519:c7c:e58b with SMTP id
 j11-20020a056a00234b00b005190c7ce58bmr19449243pfj.32.1653845519928; Sun, 29
 May 2022 10:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org> <CA+icZUU7zUCD=xrrYLQyKkDMC-Fj-PFcmHbTiPU8ytOpYq8ZDw@mail.gmail.com>
In-Reply-To: <CA+icZUU7zUCD=xrrYLQyKkDMC-Fj-PFcmHbTiPU8ytOpYq8ZDw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 May 2022 02:30:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZE-JE67HGTzy7r7mRv_2Gzv0LWUOoVr82V9iNx4q-4g@mail.gmail.com>
Message-ID: <CAK7LNAQZE-JE67HGTzy7r7mRv_2Gzv0LWUOoVr82V9iNx4q-4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove redundant cleanups in scripts/link-vmlinux.sh
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 11:38 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, May 28, 2022 at 10:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > These are cleaned by the top Makefile.
> >
> > vmlinux.o and .vmlinux.d matches the '*.[aios]' and '.*.d' patterns
> > respectively.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I applied this patchset on top of yesterday's kbuild.git#for-next
> (today's did not fit due to "kbuild: do not try to parse *.cmd files
> for objects provided by compiler").
>
> Might be related to this patchset or not:
>
> $ LC_ALL=C ll .*vmlinux*export*
> -rw-r--r-- 1 dileks dileks 4.2K May 29 15:11 ..vmlinux.export.o.cmd
> -rw-r--r-- 1 dileks dileks 508K May 29 15:11 .vmlinux.export.c
> -rw-r--r-- 1 dileks dileks 2.6M May 29 15:11 .vmlinux.export.o
>
> You see the leading double-dot for ..vmlinux.export.o.cmd - intended or not?

This is intended.

The source file (.vmlinux.export.c) is a dot file.

.*.cmd prepends one more dot.



>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
>
> -Sedat-
>
> > ---
> >
> >  scripts/link-vmlinux.sh | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a7f6196c7e41..844fc0125d72 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -309,8 +309,6 @@ cleanup()
> >         rm -f System.map
> >         rm -f vmlinux
> >         rm -f vmlinux.map
> > -       rm -f vmlinux.o
> > -       rm -f .vmlinux.d
> >         rm -f .vmlinux.objs
> >         rm -f .vmlinux.export.c
> >  }
> > --
> > 2.32.0
> >



-- 
Best Regards
Masahiro Yamada
