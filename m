Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D550AB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442461AbiDUWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384054AbiDUWaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:30:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E394AE11;
        Thu, 21 Apr 2022 15:27:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so6847260plo.0;
        Thu, 21 Apr 2022 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9wUFSDdd2+1DNFR59TfjyNNqQk5r/GH/A03vywauoc=;
        b=OF8JsT7VhIsEVkmqS1JOOf5Ukmr0PRzU3NNhBi4XV2pcEhLXU0c5p1w7WeBRNF1Jqs
         n07Wi9LapJOiEngjYo2sKneMhknNjKzcXksWmk+4OZHNJnSUxgYYlMXWhM6sm3KKm3BP
         8UteeE0izC2/b5kGCC/yhHQINe0sZ5C2c2/F20QTCLeVLNMDvGPpse4qUx1b09cehAAR
         ss+ZavBgK63zQsbuu93gFde6Y/FMLjTlnj4I/4VePmPdZp0qy18lb6Rb0yExuV5hQuuW
         nvRAKR2XHEyYYTt7zBBdj2BRDL+RKV5QMn3hqsAzHtApHJ+xjwPSk6ODp7EKREaxYtea
         l0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9wUFSDdd2+1DNFR59TfjyNNqQk5r/GH/A03vywauoc=;
        b=QZitqx1L5lBGmEnYWwmqXMPCF7LkHGqBAVINY2geNhlNy5HAJ0IbusrN3MAklF8bzN
         5AvPO9FZKRb4bAQeIzX8FUF5OZZJGJbuiOFXz9oFAavIliyNlmsFirTa64Cfln8Xxvkq
         r0C0ZSEC/hUnb78PJ2xoynfIGYBM/HWfvx7+ivp6LUY4zsWs0BgMoqY9+6bcM9U7Yr8B
         UuMOsqYCff1FK6wYCQv1G+ThKCg6ijJ4InKqKuKudZUVkCPAL7xCTSlN/V0WfJgnFdOq
         qZoSiRNFxWu+9RKjPaDQBtQ9OP/+ggOfuc3llGpiH65yBxDbBElnIlBgF7tMMlHnk3CI
         dGXg==
X-Gm-Message-State: AOAM532CZZ6Q3WtHr3+WgocjnC3eRvcI3g+XSI7jLsGvXZX4huL6tIAS
        IwrTMNVrabdte9+A/3ghDqCKq0OrdUYQTlfP/BE=
X-Google-Smtp-Source: ABdhPJxk+9AIKydOzg7DDXuOseBL3eV56i0dbHPQUdgjbp7Sm5O0tIy6XcQo+trh09bapKiIoSuIj6QwCihbzBHFpAo=
X-Received: by 2002:a17:90b:4c8f:b0:1d2:90e4:26ef with SMTP id
 my15-20020a17090b4c8f00b001d290e426efmr12522620pjb.120.1650580030358; Thu, 21
 Apr 2022 15:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net> <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
 <bf3273120d8d48a79357f229c5890576@overdrivepizza.com> <20220421074920.GK2731@worktop.programming.kicks-ass.net>
 <643dac8c3ccb0720b4a8e67a472b08de@overdrivepizza.com> <CAMe9rOqG5iAbYm_h3KsUeiToGPAs5SZ3SuWUn+_P-5Ax37=f1A@mail.gmail.com>
 <20220421221110.nq3e2vje7uvuu5dd@google.com>
In-Reply-To: <20220421221110.nq3e2vje7uvuu5dd@google.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 21 Apr 2022 15:26:34 -0700
Message-ID: <CAMe9rOoHxJixg40r-3mnYeC-GQYj1gqwY9S_iMCdgc-DaajzCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
To:     Fangrui Song <maskray@google.com>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
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

On Thu, Apr 21, 2022 at 3:11 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-04-21, H.J. Lu wrote:
> >On Thu, Apr 21, 2022 at 8:23 AM Joao Moreira <joao@overdrivepizza.com> wrote:
> >>
> >> On 2022-04-21 00:49, Peter Zijlstra wrote:
> >> > On Wed, Apr 20, 2022 at 03:40:41PM -0700, Joao Moreira wrote:
> >> >> > >
> >> >> > > If FineIBT needs it, I could reconsider.  But I think there's a strong
> >> >> > > case to be made that the linker should be doing that instead.
> >> >> >
> >> >> > That sounds reasonable to me (and reminds me of linker relaxation).
> >> >> > Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
> >> >> > determine how feasible this would be? I assume code outside the kernel
> >> >> > might enjoy such an optimization, too.  When that's the case, then it
> >> >> > probably makes more sense to "upstream" such "optimizations" from the
> >> >> > kernel-specific objtool into the toolchains.
> >> >>
> >> >> Alright, these are the greenlights I was hoping for.
> >> >>
> >> >> I went quickly into this with HJ and he mentioned that it should be
> >> >> doable
> >> >> in the linker, and that he has a patch for it in gcc (for local
> >> >> function,
> >> >> from what I could see):
> >> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
> >> >>
> >> >> If @Fangrui is fine with it, I would like to try implementing this
> >> >> myself in
> >> >> lld (I'm still learning a lot about lld and having an actual problem
> >> >> to
> >> >> solve is the kind of fuel I need). Should take me a while, but I think
> >> >> this
> >> >> is not urgent, right? I can also go ahead and replicate HJ's gcc patch
> >> >> into
> >> >> clang, so we can also handle the local functions within the compiler
> >> >> (I
> >> >> think this makes a lot of sense).
> >> >>
> >> >> Once we have these in, I'll revisit FineIBT and extend the features to
> >> >> handle the FineIBT instrumentation. Hopefully we'll be released from
> >> >> needing
> >> >> objtool (famous last words?!).
> >> >>
> >> >> This sounds like a plan, but I'm ofc open to suggestions or different
> >> >> ideas/plans.
>
> Thanks for looping me in! (I mean: this is discussed beforehand, instead
> of GCC/GNU ld taking some steps and pushing LLVM toolchain to follow
> suite..)
> Though I think I may not have the full context here...
>
> I can see that you have a request to skip the endbr instruction
> (and potentially more instructions for FineIBT).
>
> The GCC patch https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
> achieves it. A linker implementation will handle more cases.
> This is somewhat similar to PowerPC64's global entry vs local entry.
> The linker can redirect a branch instruction to the local entry in some
> conditions. My concern is that inspecting the section content goes too far
> and breaks the spirit of ELF relocation resolving. The proper way is to use
> a symbol attribute (e.g. st_other).
>
> st_other bits are scarce, so any use needs to be prudent.

On the other hand, linker inspection doesn't require changes in object files.
It is much more user friendly.   X86-64 psABI already allows linker optimization
based on contents at relocation sites.   This goes one step further to contents
at relocation targets.

> >> > So trivially the plan sounds like: compiler fixes STB_LOCAL because it
> >> > has the scope, and the linker fixes everything else. However, that
> >> > seems
> >> > to assume that !STB_LOCAL will have ENDBR.
> >> >
> >> > This latter isn't true; for one there's __attribute__((nocf_check))
> >> > that
> >> > can be used to suppress ENDBR generation on a function.
> >> >
> >> > Alternatively the linker will need to 'read' the function to determine
> >> > if it has ENDBR, or we need to augment the ELF format such that we can
> >> > tell from that.
> >> >
> >> > So what exactly is the plan?
> >>
> >> I ran into too many broken dreams by trying to infer the presence of
> >> ENDBRs just by the symbol locality/linkage... not only because of the
> >> attribute, but also because of ancient assembly.
> >>
> >> So, my first thought was to use something similar to the
> >> __patchable_function_entries section
> >> (https://man7.org/linux/man-pages/man1/gcc.1.html), where we would have
> >> a section to mark all the placed ENDBR. But then it occurred to me that
> >> if we follow that road we'll miss the ENDBR placed in assembly unless we
> >> mark it manually, so I started thinking that reading the target
> >> instructions from the ELF object could be a more simplified approach,
> >> although a little more treacherous.
> >>
> >> I didn't decide yet what to try first -- any thoughts?
> >>
> >> @Fangrui's and @HJ's thoughts about this could be gold.
> >
> >You can't assume ENDBR existence just by symbol visibility.
> >Compiler knows if there is an ENDBR at function entry since
> >it is generated by compiler.   Otherwise, you need to check
> >the first 4 bytes at function entry,
> >
> >--
> >H.J.



-- 
H.J.
