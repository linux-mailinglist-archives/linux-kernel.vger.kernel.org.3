Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C162453D5E5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350679AbiFDG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiFDG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 02:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B82BFD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E798760ED6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5593BC3411D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654325899;
        bh=x8G+mUeoBcrimrsdX5gIDCQOfLpde+SEK7kNUIOt/xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RdFk8hFjqRe9cpb5xKR0l69rJw9FCisr9fQAKxzbq9HRY3QZ2b/goIw/2+apUb2pW
         mNAxD8eAgEigEISlesSbUs2ZgxxwrNsQFt6FE0hCYfxhJWRaUz3KEM3MqLFJ3St6ke
         4iQnAQM2qvMeuoqCY3YhpwxU+fOjHj+AGhtUJf6OgJRy6bwVwherosL2vhTzf9Vqqp
         x5uBv53fgoGIll5UAJDmJeijjr0Mj23NBS3UnY1+b2QtIrOjKh6khKIru1SqueSo3q
         GmFlTAP7lKMqV6Gfq3T4l1N6wTgBJoOUaSGGsS8K7O4VCSYcLHiwOmSGMfUz7OcONL
         G420uQCz4doXg==
Received: by mail-il1-f169.google.com with SMTP id f12so8856927ilj.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 23:58:19 -0700 (PDT)
X-Gm-Message-State: AOAM532ZnBXSaO1/wO+K45A/a5LVGSy3lq1SsnHiY46raoepS0cgu1Og
        2JDKLkmpigsleTFmnu+8RDH2T9Yp1yLUCM37s/U=
X-Google-Smtp-Source: ABdhPJw5PqTog9Tn54P5B6RQzVcdr5D72/vT7QoJdB7LLmhn0P0S+eWEKir5UX3M0h20o3F/u+9DdeNHzMpHFK/G9xI=
X-Received: by 2002:a05:6e02:1885:b0:2d4:6583:b890 with SMTP id
 o5-20020a056e02188500b002d46583b890mr1912101ilu.297.1654325898405; Fri, 03
 Jun 2022 23:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220604063525.397826-1-Jason@zx2c4.com> <18ffcffb-1335-03ec-ac34-f75264460e13@xen0n.name>
In-Reply-To: <18ffcffb-1335-03ec-ac34-f75264460e13@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 4 Jun 2022 14:58:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6fS2f+3kA2-rY71sPzKxi3HTQuwr6-nx7RwnBE6gdnSw@mail.gmail.com>
Message-ID: <CAAhV-H6fS2f+3kA2-rY71sPzKxi3HTQuwr6-nx7RwnBE6gdnSw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove MIPS comment about cycle counter
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui and Jason,

Thank you very much, this will be applied later in the loongarch-fixes branch.

Huacai

On Sat, Jun 4, 2022 at 2:43 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/4/22 14:35, Jason A. Donenfeld wrote:
> > This comment block was taken originally from the MIPS architecture code,
> > where indeed there are particular assumptions one can make regarding SMP
> > and !SMP and cycle counters. On LoongArch, however, the rdtime family of
> > functions is always available. As Xuerui wrote:
> >
> >      The rdtime family of instructions is in fact guaranteed to be
> >      available on LoongArch; LoongArch's subsets all contain them, even
> >      the 32-bit "Primary" subset intended for university teaching -- they
> >      provide the rdtimeh.w and rdtimel.w pair of instructions that access
> >      the same 64-bit counter.
> >
> > So this commit simply removes the incorrect comment block.
> >
> > Link: https://lore.kernel.org/lkml/e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name/
> > Fixes: b738c106f735 ("LoongArch: Add other common headers")
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >   arch/loongarch/include/asm/timex.h | 7 -------
> >   1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> > index d3ed99a4fdbd..fb41e9e7a222 100644
> > --- a/arch/loongarch/include/asm/timex.h
> > +++ b/arch/loongarch/include/asm/timex.h
> > @@ -12,13 +12,6 @@
> >   #include <asm/cpu.h>
> >   #include <asm/cpu-features.h>
> >
> > -/*
> > - * Standard way to access the cycle counter.
> > - * Currently only used on SMP for scheduling.
> > - *
> > - * We know that all SMP capable CPUs have cycle counters.
> > - */
> > -
> >   typedef unsigned long cycles_t;
> >
> >   #define get_cycles get_cycles
>
> Just as previously discussed. Thanks for the quick fixup!
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
