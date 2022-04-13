Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C334FEDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiDMDuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiDMDuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:50:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046C1B798
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:48:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ec0bb4b715so8935477b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZqgQXxBgWU0mvFoVSH2bn5fANhNNX+WKD7Wa2BWca8=;
        b=qhUymfZ9qnz+gcjlM20Ake0P5AmB8Nejcb61XoOe411V45Ek0HgHfDiMsGeuHCGOzI
         OFiiMnHacvaTLcClkD9M0QvgQcSowuiTMj4D3YVa4iwBW6vZw/Zpjc0YIxApmQyNtXl5
         FnXCA8JSPqJrqIk2wJWU23SHq/vQJQpXy5nrLBS8S6BEBGdzneE5RPaej6nAQuWBIhsS
         I9mbJCwvapcdfKC3H9n9NHN3843M2HlQI4TAphtio3Y88XD4jOWZk3aW8gKRxlH00Ras
         4tJ5SQA1c0Kqfpr/Q05mE5SEyFfLIvC2+nVNA9fKGhPAYzY01CKmmQK/Byw6y6alSlsp
         9txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZqgQXxBgWU0mvFoVSH2bn5fANhNNX+WKD7Wa2BWca8=;
        b=y+xhpvCQ4ghmfUULFOtEU6S6dEJvmCnMDlsbIsbUIogyUkzpaso+YZliwiH9+ieGe7
         m2TjRC0pQaUL77YgwtQD4c8ngbmLlFRl5o4pE+SGXi3plBBkyOAdhrsgF3n8P2Yfj6W0
         UyQBN3K+igOgmAr+kI23Naa30F1c38FUL5qZNaBuZV3zMM0FgC1Snbdu8ZytWhiyVgzb
         DkU68J56R/ii8WeFZjBRfyqaygZNJYpBN7gqVOPymlPSNjQGRWOfw3jRLTs07ZOAvKWW
         wi61PD3CtufIM6qzQQPNmX673Bc2eAIUP0RWL4R8zJ3eDviU/hZxOknz/8L4OfPUbvPE
         bvug==
X-Gm-Message-State: AOAM5317Z+Ln4qopmlP5hUEOJqoF9VssGRqnVVOnKPHgW3yyuLG+DXex
        99LmP+rds2J4skDXKfO12qbyUZ1LOntbdDFgLdE=
X-Google-Smtp-Source: ABdhPJwT2u2/ZosYYT5NMzWxD53yjBDaGvHtC9GLUG1Iq3s4KB8fbW4f6BYFP0YUjkKjug6Tttd+WQraMuRsfIg2IWc=
X-Received: by 2002:a81:1a49:0:b0:2eb:f4cd:b3f1 with SMTP id
 a70-20020a811a49000000b002ebf4cdb3f1mr16634235ywa.231.1649821712980; Tue, 12
 Apr 2022 20:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220412121541.4595-1-jiangshanlai@gmail.com> <20220412121541.4595-4-jiangshanlai@gmail.com>
 <YlV+B8faRD2lDoO3@zn.tnic> <CAJhGHyAsPZAeXUoOa5LJ5bxuMOWzg=cvYNYPVT9kpBM7Tsf3xA@mail.gmail.com>
 <YlWNIj198mKM3hMG@zn.tnic>
In-Reply-To: <YlWNIj198mKM3hMG@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 13 Apr 2022 11:48:21 +0800
Message-ID: <CAJhGHyC7KUj=s+w+isBewdL7iyUyEm4h++rWRoz2zBc0zAD2gw@mail.gmail.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Tue, Apr 12, 2022 at 10:31 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 12, 2022 at 09:52:44PM +0800, Lai Jiangshan wrote:
> > The mapped size for the text is always 2M when the kernel is booted
> > since it is 2M-aligned.  So I don't think the size is a concern.
>
> This is not how this argumentation works: you add 0.01% size increase
> here, 0.01% slowdown there and it all soon adds up into a bloated
> kernel. Besides, nowadays the kernel runs a lot as a guest and guest
> kernel size does matter.

I agree with you.

I meant the real .entry.text size is unchanged.  No matter what
the complied .entry.text size is, 5.5k before the patch, or 8.2k
after the patch, the size of .entry.text in the kernel is always 2M.

But the overall size is enlarged which is a concern.

>
> So no, just because you want to turn error_entry() into C code and for
> that you'll add some bloat doesn't justify it in my book. All changes to
> core code need to be absolutely needed and justifiable.
>
> > For example, a heavy page fault and IPI or timer at the same time.
> > I'm not sure if it is a real case.
>
> I wouldn't be surprised if it shows in some perf profiles.
>
> > I'm Okay with asm_error_entry().  And also we can use an ASM function
> > containing PUSH_AND_CLEAR_REGS only.
>
> Just do the necessary and minimal thing - this is core code and in asm
> for that matter, so be conservative pls. This is not some random driver.
>

I will follow your instructions and add an extra ASM function.

And maybe add this to the changelog:

A function call is added for every interrupt or exception, but it
is a low-level asm function call and actually, only a "call" and a
"ret" instructions are added.  It will enable error_entry() to be
C code that can use inlined sync_regs() and save a C function call
which will reduce more instructions in return.

I'm also waiting for reviews for other patches and I'm not going to
send this new code too soon since I don't want to send a new revision
with only this patch updated.

Thanks
Lai
