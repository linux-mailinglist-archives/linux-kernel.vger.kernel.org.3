Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E557788C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiGQWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQWFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:05:42 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C013EE3F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:05:41 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i14so18050804yba.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPTUmtD0mO4LKrdNJNBcqd3l40tXMwjLHVeP/VIEmwU=;
        b=MCM+6b6RcoWpklzEm4YevE5Ka2BDNSfA381jQ37WspKtLtFaGtYp4Cn9gkUEzqDX8m
         lFGst0so5xX874adBrMNfcUGkyDpwFIRbX5vcYIGz4hyplOPzMbgHNZXXXfC5Gt/Qzst
         wQFIese48HaG1DhH29UOvalnetjuHsZjd6LNXL/Wr1qWbyyBsJra9s1MbmFRbh12+5Ni
         fWQIPolwOATEMGRKEjm/mnv9QZq1xwqovzrvG1CLDXbIvwPVoShcB0ycsCOOIvooum1V
         KDoVs6yKnPJ+s51ym/EoSTCutBm3evgfnXnuoGTGmsOnTgDDMSii3gnsf9T70kxyrq75
         Pzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPTUmtD0mO4LKrdNJNBcqd3l40tXMwjLHVeP/VIEmwU=;
        b=co9aGPSxCMS8YhHK5JW5kswZwsapiKSrTXDuivCaE9kdBdtiMNjvC4VcAB7RlvO2EI
         hHKjbM17KKtIdVMKWcNwAk3PThEk3AKTyleDQ6JwjqZ3mmrttu9IRvrrYcn3R9KUeHay
         HzolQ1ZEM1gzZiWLGYj/BIV0Z0ZyEewVhXcVfMweUoVbBuqO2AqMYWkUN09zM+vbp6vU
         sfaDjjeNhvA1+GT9fNWSfJjS9RuduJF9KsOBoKxsEm5hcaWC9jQzOHXTEc/aTZNgXycP
         p2jPRDaKj1awLiDz5Rc9TXhevAOumEFjoE4bq+DQjFi3+HZbWn5AoWf8cewMbiJyPKen
         25tw==
X-Gm-Message-State: AJIora+ZOgA6/xBG4x+In/zXoQEKS4tbin3V6x/KCUGzcivRE9sWgrhQ
        LwMYESwzzulj+RufIeB2UzTMyBhU81ZYdAbXYQg=
X-Google-Smtp-Source: AGRyM1vatOGsN29IMyMlMqCAZgmigmBQAclp0VpHS4DcJ+4eMm5JYAL3GG92Uq242rPVItViwUScETsgp8LO06POcig=
X-Received: by 2002:a25:6b0f:0:b0:66e:cba3:8f2d with SMTP id
 g15-20020a256b0f000000b0066ecba38f2dmr23277092ybc.183.1658095540746; Sun, 17
 Jul 2022 15:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185514.7d1a2ac9@canb.auug.org.au> <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X> <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
 <YtBEXdrsthFamQs8@dev-arch.thelio-3990X> <CADVatmNOV+jn1WSFo=z4F9KqzYAgxCWr0cxTFL_5myJKFkQNzQ@mail.gmail.com>
 <YtCJeieW4Mz1VfRx@dev-arch.thelio-3990X>
In-Reply-To: <YtCJeieW4Mz1VfRx@dev-arch.thelio-3990X>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 17 Jul 2022 23:05:04 +0100
Message-ID: <CADVatmONHx5KjODAXWjKDs6OayDr2HJQpP6_mR+xSAADX_eByw@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 14
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Jul 14, 2022 at 10:24 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Dropping the next list and Stephen as these issues are likely present on
> mainline as well.
>
> On Thu, Jul 14, 2022 at 07:26:27PM +0100, Sudip Mukherjee wrote:
> > Hi Nathan,
> >
> > On Thu, Jul 14, 2022 at 5:29 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Thu, Jul 14, 2022 at 05:21:32PM +0100, Sudip Mukherjee wrote:
> > > > Hi Nathan,
> > > >
> > > > On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > Hi Sudip,
> > > > >
> > > > > On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > > > > > Hi Stephen,
> > > > > >
> > > > > > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > Changes since 20220713:
> > > > > >
> > > > > > Build failures on next-20220714:
> > > > >
> > > > > <snip>
> > > > >
> >
> > <snip>
> >
> > >
> > > Sure! I am not sure that we have tested mips or powerpc allmodconfig now
> > > that I am thinking about it but we'll certainly take a look at any
> > > issues that come from them and see what we can do.
> >
> > The build errors from powerpc allmodconfig with clang:
>
> Thanks for testing!
>
> > 1)
> > Error: External symbol 'memset' referenced from prom_init.c
>
> Good to know this is not clang specific.

Ok, so clang is also trying to use memset for any array.
Linus suggested adding volatile. ref:
https://lore.kernel.org/lkml/CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com/
for the gcc-12 problem, and with that I can see that clang has worked
as expected and removed memset from struct prom_args. But now memset
is still there for other arrays in prom_init_mem() and others. I think
we will still need a patch for clang, and that will also work when the
gcc-12 bug is fixed.


-- 
Regards
Sudip
