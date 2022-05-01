Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F6516560
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbiEAQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350056AbiEAQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:51:10 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF251EC54
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:47:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j9so10008397qkg.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH4qOwNGDJb17bAcOVnL0TYqNKG2R5KuQoEVpVMzt84=;
        b=JV0g7MkXTfTfAs7wd/+QZURzpTUqRkf2mEz04UqQsaqtdmwChz41inM93Okahiagj/
         c/P9idKZCxIJhKcWMwA24j/VdmODbRIXtYwmNzjIny63xfVKlp0jwy4gnenp+h9UMAUP
         3X5tsWm9WyZPmljQ+4uyYJZBBiAVcys36/yPo8b5GEUQBK3RaZF7mmObIg3GvCx6OO/u
         1eY53D/J+cxiB1QOxKmwbc2hukWGwTYuVxgyfpZ0DrKzWLRCnVK1judWhs1n1S6m7hMq
         +ekCbad/Aj6lOCw2G31sY89JHcQibko+ln5lBvrRIFheyZMyOCMvg5+Iymlsq+2elV3I
         rFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH4qOwNGDJb17bAcOVnL0TYqNKG2R5KuQoEVpVMzt84=;
        b=EXFU5V3X2lBRnsZxUyinoz0ZcMzghppxqqHeHHIW+NjlysLBHLGRTkwscF4T0ikVgH
         1xvOBHtEU8CJd9f11DrnzDeDqj8E0FKrSmACnKUaneCAk9KhbHOrbwjlic7BjbEW2+zt
         BjEwv7yu4ZA5TRb3bbd2o5K7ESUWDQQO399bavN8QS8vjcZQORqrMkzi9gNcfcPDl5QE
         7r60fL8SWaprN+/Ahw7Mb9Qk0xSWmFZRCXyqQEKO55BDPQROAop4a498LmDZrRDl1//n
         gMnck5TDdiLOKzZRE1pMQusbqKOQBoBzUyAQsyeiANaCBkmoOjwYlgONZF6m/qiSosvv
         F3kA==
X-Gm-Message-State: AOAM533XKh5zy7Foc2gYMJ6I9bDwQ+38x7icSSpzHmTaa0RKbF7/YREs
        g4Qe6lmIzuc4w1mJgXndBte55SM37CXZIlqDpRc=
X-Google-Smtp-Source: ABdhPJwF/5HrtwsW47qtSSjcRJNyLZ2NHICtLB0YrYacS0hnmIOLGWeGXxDms2Ta/XpR+exZFBegVbVqKQLw/HwBM3k=
X-Received: by 2002:a37:42d3:0:b0:69c:830d:6e51 with SMTP id
 p202-20020a3742d3000000b0069c830d6e51mr6212747qka.302.1651423663386; Sun, 01
 May 2022 09:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X>
In-Reply-To: <Ym2qdHAB6BMMlegB@thelio-3990X>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Sun, 1 May 2022 18:47:32 +0200
Message-ID: <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
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

On Sat, Apr 30, 2022 at 11:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Mauro,
>
> [+ llvm@lists.linux.dev and Nick]
>
> On Fri, Apr 29, 2022 at 07:40:07PM +0200, Mauro Rossi wrote:
> > Hi Andy,
> >
> > I am an hobbyist contributing to android-x86 FOSS project lead by
> > Chih-Huwei Huang (in Cc: for information/alignement)
> >
> > I am performing periodic tests to build kernel for Android 11 based iso image
> > which relies on aosp shipped prebuild clang toolchain (clang version 11.0.2)
> >
> > When building linux 5.18rc4 and also with linux 5.17 x86_64 64bit kernel targets
> > there is a building error in arch/x86/entry
> >
> >   AS      arch/x86/entry/entry_64.o
> > <instantiation>:2:2: error: unknown use of instruction mnemonic
> > without a size suffix
> >  lsl %rax, %rax
> >  ^
> > <instantiation>:1:1: note: while in macro instantiation
> > LOAD_CPU_AND_NODE_SEG_LIMIT %rax
> > ^
> > <instantiation>:2:2: note: while in macro instantiation
> >  GET_PERCPU_BASE %rax
> >  ^
> > /home/utente/r-x86_kernel/kernel/arch/x86/entry/entry_64.S:890:2:
> > note: while in macro instantiation
> >  SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
> >  ^
> > make[3]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:389:
> > arch/x86/entry/entry_64.o] Error 1
> > make[2]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:550:
> > arch/x86/entry] Error 2
> > make[1]: *** [/home/utente/r-x86_kernel/kernel/Makefile:1887: arch/x86] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> >
> > As other interesting info, the building error does not happen when
> > building x86 32bit kernel target and i can build 86_64 64bit kernel
> > target only by setting the LLVM_IAS=0 parameter to disable the
> > internal llvm assembler
>
> This error was fixed in LLVM 11.0.0 final, which was released after
> Android's LLVM 11.0.2:
>
> https://github.com/ClangBuiltLinux/linux/issues/1079
>
> > I wanted to ask you if you could help us, if there could be a way to
> > improve arch/x86/entry/entry_64.S code to be able to complete the
> > build without disabling the llvm internal assembler.
> >
> > I don't know if this building error may be caused by the clang version
> > 11.0.2, but at some point the aosp and android version may hit this
> > same issue,
> > so I wanted to highlight this issue to you to have a competent person feedback,
> > as I am more a "trial and error" guy than a kernel expert
>
> I am open to other opinions but I am not inclined to suggest working
> around this in the kernel for two reasons:
>
> 1. This issue was resolved in the toolchain almost two years ago, so it
>    is not a recent failure.
>
> 2. Android's LLVM 11.0.2 is technically older than the minimum version
>    that the kernel supports (11.0.0), which I would argue means it is
>    unsupported. 11.0.0 final was released on October 12th, 2020 and
>    Android's LLVM 11.0.2 was committed on June 11th, 2020, so you are
>    potentially missing four months worth of fixes:
>
>    https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/431c74471920f3f9b0517692fb69515c023bde41
>
>    Unfortunately, due to the way that LLVM versions work, it is not so
>    easy to check for this but perhaps we should consider trying to
>    handle this, so that others don't continue to trip over old bugs.
>
> Moving to LLVM_IAS=0 is the solution that we went with for clang-10 when
> it was supported after the switch to the integrated assembler by
> default, which I do not think is an unreasonable solution for this
> issue.
>
> Alternatively, you could apply the hack that Nick inserted into Android
> for this issue if upgrading your toolchain or turning off the integrated
> assembler is not possible:
>
> https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
>
> I really do not mean to sound dismissive or rude, I apologize if it
> comes off that way, but we have worked quite hard to avoid inserting
> unnecessary workarounds, as they are ultimately technical debt that can
> be hard to manage over the long term.
>
> Cheers,
> Nathan

Thanks a lot Nathan

It is definitely the clang version 11.0.x which is not updated in aosp
Android 11 production tags

I will use Nick's workaround which works since only lsl %rax, %rax is
currently happening

Many thanks, problem solved
