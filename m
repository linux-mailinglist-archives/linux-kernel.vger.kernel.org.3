Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6592450A45D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390179AbiDUPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390111AbiDUPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:39:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9277746B3E;
        Thu, 21 Apr 2022 08:36:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l127so5344252pfl.6;
        Thu, 21 Apr 2022 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iVAF+dysJ3aNNdChixgCrp4ZaHT4B+NU4qyVjoP3k8=;
        b=lfFr5lUxMj45ncT3S8KkUv728QhnZKVX4/X81kOCf/tuzHbceSeYzzVdiDIKvFtQhe
         RNLXhCP8RDEfoMzqKwEBxAHCqfq2L2aMKvIHIJJp4jGqQ+5OtsPvafVqMogTs0CJokQs
         PeQwbCuq0VuepeKu5C3jy5ZmG2gV7fHH67QsmlGtMg0ktnGWlRak/q4788O0jDrrQG7b
         9jBb75+ehXgTprparmez5yxUEEJKT1IJwkWl/4M4pXJEc2en9cJBLfV4zB54EEPGqjYS
         e8DGix07bOHyDVDx3PSYUqDsXg8PxO5IGBVhZaJAhDY/DKrv2E8pLF817dV3G5V6kOZJ
         guIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iVAF+dysJ3aNNdChixgCrp4ZaHT4B+NU4qyVjoP3k8=;
        b=uY8i0v1ifwbwgXPSkHoOlEhbdnbHLCtJO0efo2MzIWQKNZG26w+B8g+j07QTJ+b62E
         ILyBaAQgJjkvHR0b6920lt4CZPvb3GbeIBjpym5zkgw2eT4iTX6GzV4UZFq+LVkpgN+4
         6TW5mQ+GXAs+j9xbKbrcUDFFOYJrR6HwPh5/djVzoPSFytLpjsmFAajjtfrTsesFdb5t
         OiqLKpZchIZHdmfIkr0ZawGT3GLSU3qDgNwDo8fsiwfIa6zBGsCuM9nQliozXGAiSS+5
         JciorlGd2LBzigDKsiZh/p0KX7bnyPLVtRMXfk8T4VRf+UXhhf+ggjJMslZNbk7sWjNP
         PrGA==
X-Gm-Message-State: AOAM532x/r55wD65qTuYTIlSl5LXPVF5UrbatlV1qiA7GzTEKVI9mddJ
        TfqE57HwEfcIoU+gM7SyXQOuYV47ViLZLRGbl5xgj6UlDM4=
X-Google-Smtp-Source: ABdhPJxgMmtW8wfP8Q+5T8G7gcFEq1ycsN3h2ockYlkBMlbT1lVWgl8dw49gLuzK/N6AFfQtCjFT3Yu+KO4z5Gg4yEg=
X-Received: by 2002:a63:9253:0:b0:3aa:55f3:346d with SMTP id
 s19-20020a639253000000b003aa55f3346dmr58543pgn.210.1650555375637; Thu, 21 Apr
 2022 08:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net> <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
 <bf3273120d8d48a79357f229c5890576@overdrivepizza.com> <20220421074920.GK2731@worktop.programming.kicks-ass.net>
 <643dac8c3ccb0720b4a8e67a472b08de@overdrivepizza.com>
In-Reply-To: <643dac8c3ccb0720b4a8e67a472b08de@overdrivepizza.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 21 Apr 2022 08:35:39 -0700
Message-ID: <CAMe9rOqG5iAbYm_h3KsUeiToGPAs5SZ3SuWUn+_P-5Ax37=f1A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Fangrui Song <maskray@google.com>,
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

On Thu, Apr 21, 2022 at 8:23 AM Joao Moreira <joao@overdrivepizza.com> wrote:
>
> On 2022-04-21 00:49, Peter Zijlstra wrote:
> > On Wed, Apr 20, 2022 at 03:40:41PM -0700, Joao Moreira wrote:
> >> > >
> >> > > If FineIBT needs it, I could reconsider.  But I think there's a strong
> >> > > case to be made that the linker should be doing that instead.
> >> >
> >> > That sounds reasonable to me (and reminds me of linker relaxation).
> >> > Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
> >> > determine how feasible this would be? I assume code outside the kernel
> >> > might enjoy such an optimization, too.  When that's the case, then it
> >> > probably makes more sense to "upstream" such "optimizations" from the
> >> > kernel-specific objtool into the toolchains.
> >>
> >> Alright, these are the greenlights I was hoping for.
> >>
> >> I went quickly into this with HJ and he mentioned that it should be
> >> doable
> >> in the linker, and that he has a patch for it in gcc (for local
> >> function,
> >> from what I could see):
> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
> >>
> >> If @Fangrui is fine with it, I would like to try implementing this
> >> myself in
> >> lld (I'm still learning a lot about lld and having an actual problem
> >> to
> >> solve is the kind of fuel I need). Should take me a while, but I think
> >> this
> >> is not urgent, right? I can also go ahead and replicate HJ's gcc patch
> >> into
> >> clang, so we can also handle the local functions within the compiler
> >> (I
> >> think this makes a lot of sense).
> >>
> >> Once we have these in, I'll revisit FineIBT and extend the features to
> >> handle the FineIBT instrumentation. Hopefully we'll be released from
> >> needing
> >> objtool (famous last words?!).
> >>
> >> This sounds like a plan, but I'm ofc open to suggestions or different
> >> ideas/plans.
> >
> > So trivially the plan sounds like: compiler fixes STB_LOCAL because it
> > has the scope, and the linker fixes everything else. However, that
> > seems
> > to assume that !STB_LOCAL will have ENDBR.
> >
> > This latter isn't true; for one there's __attribute__((nocf_check))
> > that
> > can be used to suppress ENDBR generation on a function.
> >
> > Alternatively the linker will need to 'read' the function to determine
> > if it has ENDBR, or we need to augment the ELF format such that we can
> > tell from that.
> >
> > So what exactly is the plan?
>
> I ran into too many broken dreams by trying to infer the presence of
> ENDBRs just by the symbol locality/linkage... not only because of the
> attribute, but also because of ancient assembly.
>
> So, my first thought was to use something similar to the
> __patchable_function_entries section
> (https://man7.org/linux/man-pages/man1/gcc.1.html), where we would have
> a section to mark all the placed ENDBR. But then it occurred to me that
> if we follow that road we'll miss the ENDBR placed in assembly unless we
> mark it manually, so I started thinking that reading the target
> instructions from the ELF object could be a more simplified approach,
> although a little more treacherous.
>
> I didn't decide yet what to try first -- any thoughts?
>
> @Fangrui's and @HJ's thoughts about this could be gold.

You can't assume ENDBR existence just by symbol visibility.
Compiler knows if there is an ENDBR at function entry since
it is generated by compiler.   Otherwise, you need to check
the first 4 bytes at function entry,

-- 
H.J.
