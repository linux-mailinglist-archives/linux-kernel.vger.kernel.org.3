Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DCA53723A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiE2SrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2SrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:47:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BC27CE1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:47:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u18so2330109plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoKC3V/XTP0oNzDn2rYTyXnJc5QmXgd18Z7w67R+avg=;
        b=TMGIQtDS6b29nEVWAGi06Y+LsNlm/dbSDkJ5DqJWftYbraKmb4lHqCA9GONOpCaag0
         mfdTQ7/H8pLrYNwKmZ+OE1PAvg2Rg6Wma+gshILHWs+vienmn9Z5wxcPv2R/cMFnqw4T
         EfCJP//4F3o+CvS3f1qRMoj5BRIj/cKKsMcW2cEgXuEqlDyvk7o8jw+v7idf6WiyMsXg
         jUk5lJmUFV73bykoMidSR3i9gOplo+kVqpSyIcU2KLMXcW7ivhyNL5jQKP/52Brouzqm
         F3kEnSsIUhhyXocovlVYMtZkUD2BatyKJhJnr0GdE5zSNVaY/2tVeKiDCuPpuzLyt3dV
         yr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoKC3V/XTP0oNzDn2rYTyXnJc5QmXgd18Z7w67R+avg=;
        b=uSY2AsOrhQno+2mKlUtLyqNzIVIFjSW+3EksHvBPc7RA0VU8a1f3kpahe8q3VHm7AY
         I+Y+Ij4t8HHR0AekZd8bqz45aN6vSs6ynqRa566jUrZibzDy0Om+mKapvesBGvxCjE3S
         k29wqGH3EkNI1FslR9WBeZD+6o1BZo+tKuzi83BVgWMAxMloNGZu4q2npuy764WaPoBk
         yjL25J5L/FsyE2UA+mZBwWfLpqNaDU4qeaqnE3RqiLw3Ad7DzBcwdr6ASzor7mRaQlIk
         W9p3sSyC2vnIbF35bAcuA4P7vlRN1yE9AYF8DnYYLqyB6HemyIBmhAiMKfVAsGbX1rSy
         P93Q==
X-Gm-Message-State: AOAM532a87ioYRpQ1Dt5BPSAdc5XYZgA7+rxcp1Te/NPOaFOxnD6QhlQ
        vcbGGImeSWNhinBjuN1rKDzQaFCEXgcn5zpqJkw=
X-Google-Smtp-Source: ABdhPJwkrxXtBPptHzvY2Byi0n3TEUCyb7fWT+AksI4A0Fqaj1qWrjbNgt0Sq/7Yja1wr05rnGf9l1oPKG/U6vKGmTs=
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id
 m20-20020a17090a7f9400b001cb1853da1bmr19236794pjl.14.1653850025969; Sun, 29
 May 2022 11:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com> <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X>
In-Reply-To: <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Sun, 29 May 2022 20:46:54 +0200
Message-ID: <CAEQFVGbmHAQ=zxMTr4cmb9oeCarwZgyhiJnnL-Lrwmjatuaa2Q@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     luto@kernel.org, Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 2:07 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, May 07, 2022 at 02:19:00PM +0200, Mauro Rossi wrote:
> > > > Alternatively, you could apply the hack that Nick inserted into Android
> > > > for this issue if upgrading your toolchain or turning off the integrated
> > > > assembler is not possible:
> > > >
> > > > https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
> > > >
> > > > I really do not mean to sound dismissive or rude, I apologize if it
> > > > comes off that way, but we have worked quite hard to avoid inserting
> > > > unnecessary workarounds, as they are ultimately technical debt that can
> > > > be hard to manage over the long term.
> > > >
> > > > Cheers,
> > > > Nathan
> > >
> > > Thanks a lot Nathan
> > >
> > > It is definitely the clang version 11.0.x which is not updated in aosp
> > > Android 11 production tags
> > >
> > > I will use Nick's workaround which works since only lsl %rax, %rax is
> > > currently happening
> > >
> > > Many thanks, problem solved
> >
> > Hello,
> > I'm back again because I was assuming that Nick's workaround was working ok,
> > but I have found that ARCH=x86_64 i.e. 64bit built kernel is causing
> > an immediate hard reboot at initrd execution,
> > just after hitting [ENTER] at grub/efi menu.
>
> It looks like there was a follow up fix for that workaround, maybe that
> resolves this issue as well?
>
> https://android.googlesource.com/kernel/common/+/cc7f7a84191f5defc2ea4633eeea4acb4486b549
>
> > ARCh=x86 i.e. 32bit kernel binary is not affected, but is Nick's
> > workaround targeting 32 bit kernel builds?
>
> No, the file that the build error originates from (entry_64.S) is only
> built on x86_64.
>
> > How do aosp android-mailine kernels avoid this instantaneous hard reboot issue?
>
> That hack was reverted once the toolchain was upgraded:
>
> https://android.googlesource.com/kernel/common/+/ff0216d09fd31802537f2d1702ec2f3e9be73aa3
> https://android.googlesource.com/kernel/common/+/3c2c8d8f7f2639e319212d10cb8df5bd13098dae
>
> Cheers,
> Nathan

Hello,

sorry i still have the issue when building with hack "ANDROID: x86:
entry: work around LLVM_IAS=1 bug in LSL"
I'd just like to understand why I get instant reboot in 64bit kernel
built with LLVM_IAS=1

I searched for the places where #include "calling.h" is used

utente@utente-3TB:~/r-x86_kernel/kernel$ grep -r \#include\ \"calling
arch/x86/entry/thunk_64.S:#include "calling.h"
arch/x86/entry/entry_32.S:#include "calling.h"
arch/x86/entry/entry_64_compat.S:#include "calling.h"
arch/x86/entry/entry_64.S:#include "calling.h"

Probably the hardcoding done in the hack is impacting some other asm
target built in 64 bit kernel and causes a wrong X86 instruction , is
there a way to refine the #if defto avoid that problem while still
building with LLVM_IAS=1 ?

Thanks for the info
Mauro
