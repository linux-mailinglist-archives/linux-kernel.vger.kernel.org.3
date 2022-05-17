Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5D5297A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiEQDDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEQDDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:03:50 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5160C28990;
        Mon, 16 May 2022 20:03:48 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24H33Ume008206;
        Tue, 17 May 2022 12:03:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24H33Ume008206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652756610;
        bh=JAkv9J2WuVb+Lx66ZtSMZCFFZ6CRvC9YXJPMi8gLvAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zs467IA/8d0EgkXw843SZV3whETHurMAWV39hkNTDRuh8jHD6+VH6Ys8tP8MDhhh2
         +95kerirHD4p0gRzlZUFb+G/Jqr6i2lHDIgY1ra5F8sbWSkLSI3EfEi6L0Tyrr7ktd
         OEm4u9TNJmLKBN/KyqhTvXl63MMOv9IwejCKAx8wQp0Twso9xYLqb3FN+Bwk0RCOP0
         pTZrIPy4avzIExGBP/vs8q3fYoeTZxYBVtkvSpAPpsHWXN9NAGWgMBLUi4S/B1GfJm
         WCopJTj+8zJVTJ9iF8x0xAhtghUAbYIkt785PlmpUJsoTAZkaUsv9y0HOybWIpcTJv
         T3n/N6M4u5Gew==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1086948pjq.2;
        Mon, 16 May 2022 20:03:30 -0700 (PDT)
X-Gm-Message-State: AOAM533O7tHkz/vbcQYbfkcSLqoZy7EfKCqFRFShwKWLde+Edt6k3K+R
        8BhErHJhAnrtMac3PXWwzosHTnYRSWK4o8dP66Y=
X-Google-Smtp-Source: ABdhPJxAkwdSFjR+VPvxBZTeI26pMF/Mqre1No/sgmIzI/68PFLpXw454p1KT+CBzUKgXJlyrcp8r/laMUM3qW6Dqwg=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr20446798plh.99.1652756609881; Mon, 16
 May 2022 20:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220510221333.2770571-1-robh@kernel.org> <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
 <20220517011214.GA3716531-robh@kernel.org>
In-Reply-To: <20220517011214.GA3716531-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 May 2022 12:02:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_59AAEQ8wZzpmi5M4SyGspUGdyFgOqQR689DmpE_RCQ@mail.gmail.com>
Message-ID: <CAK7LNAR_59AAEQ8wZzpmi5M4SyGspUGdyFgOqQR689DmpE_RCQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove example file on dt-extract-example error
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:12 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 11, 2022 at 09:27:00AM +0900, Masahiro Yamada wrote:
> > On Wed, May 11, 2022 at 7:13 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > As 'dt-extract-example' writes the example dts files to stdout, a file
> > > is always created even on an error such as Ctrl-C. The resulting empty
> > > file(s) then cause unexpected errors on subsequent builds. Fix this by
> > > removing the output file on any error.
> > >
> >
> >
> > Did you really set it?
>
> Set what?

Sorry for the typo.   I meant "Did you really see it?"


>
> I'm sure I've gotten empty files which then throw errors on the next
> run.


Hmm, OK.

When you observed this issue, were you using
a pipe to another program?

For example,

  $  make  dt_binding_check  2>&1  |  tee  dt_binding_check.log





> > The target deletion on interrupt is automatic
> > since the following commit:
> >
> >
> >
> > commit 9c2af1c7377a8a6ef86e5cabf80978f3dbbb25c0
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Fri Jul 20 16:46:33 2018 +0900
> >
> >     kbuild: add .DELETE_ON_ERROR special target
>
> You're saying I shouldn't need this change? For some reason I do...
>
> Rob


If .DELETE_ON_ERROR works as the manual [1] explains,

[1] https://www.gnu.org/software/make/manual/make.html#Special-Targets

the deletion of the target is automatic.


Basically, it worked like that, except when Make is piped to another program.

I asked this in GNU Make ML before.

When Make is piped to another program, which is terminated by Ctrl-C,
Make is also killed by SIGPIPE before cleaning up the incomplete targets.



-- 
Best Regards
Masahiro Yamada
