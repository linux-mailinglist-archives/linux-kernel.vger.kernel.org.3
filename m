Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCDA4DD05D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCQVq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:46:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E411A9B2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:45:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d19so7897151pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPOIkmx/1ZEzac6tX87LtTmxD7qv0ZDR17y94CVjDjM=;
        b=PPA8dRi4KI3FwJ1U/1S2LJsZEyxCAqZHA8pGlFu0lhXkTkpwruUj6vS3P/MD4h7Z9Q
         irjoPWQIUZtr1wg3ZfXIk7I4s8Vw/LtWDH9EultQ9EYJwNjUPdXj7Ya9P+2LlSsCko3Y
         XZKsqFy3IRVk3HZx7XNt59NGkxb1MlAj+3XhXng6bAtmwnDFWhDVO/sDNnnYWl+4R1g+
         j0qXbx3o//DiCZcjkQZEHSBxwYc/lMHnUgTL6PweZCYjBImpNvtPFOVr+YBwNAwpEqBW
         0RBNL0R6oO+CdphmVSZLHuhzGjygGU1X2DMvFj516Nd+sgD1Y7xyniu/9KhIM2zz1nnB
         YVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPOIkmx/1ZEzac6tX87LtTmxD7qv0ZDR17y94CVjDjM=;
        b=LgCxUDJukZReZwjcF2yUy6+iqTdkr+7uMEyAf4WA4ZtFO6iRtohbt3nDpo41IvX4sh
         1UWPA6De1XKCtkchhNnTd/rAhngJ98DbPal9gI5HTLXVIP9vuQmoYZcZUAPCaZCr3gG/
         YKgESsbdxnRiYs78GVZw9ytClmSZ5UCvtpneKBleE70FfOvNc6Itjg5DUOGqbvsoRBKC
         Mlc9ZVLcQPQ9LCZ/7SDwWa9K/ND3BqdQA82XzTTOhcO9yO2JnIeljD7VM1DRzHuIcqGB
         etHubLD2BVJ/oILqRneP0AYgG61fa9795cQpVAKSK1Z5xNRA4H+s8FFc2aOrHNHYzc3Q
         rk0g==
X-Gm-Message-State: AOAM530aaSdDNaVfTaKcXhOv+iDjw15gg2fRQB6D0ped+P9z2F/7pAc0
        iMRuTylAhGgEjjjqi3ctDon+p1XEN7L4uH3yOi8H
X-Google-Smtp-Source: ABdhPJxAhlXJfmDyDkQQ+h1lUvIFbNNj5OWZGK6sdNBsVl37VkPAC01npTUgWrIz/K99HNPx06c8cshuGVJoe8+lkwE=
X-Received: by 2002:a05:6a00:1596:b0:4f9:f992:9f69 with SMTP id
 u22-20020a056a00159600b004f9f9929f69mr6437304pfk.7.1647553536437; Thu, 17 Mar
 2022 14:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
 <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
 <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com> <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com>
In-Reply-To: <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 17 Mar 2022 14:45:25 -0700
Message-ID: <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 2:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 17, 2022 at 2:10 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > As a result, we mark pretty much all system instructions as being
> > > memory clobbers, because that actually works.
> >
> > For now.
>
> No. Forever.
>
> If you change the compiler to ignore memory clobbers in inline asms,
> we'll stop using clang again.
>
> This is not some kind of "threat". This is literally just a plain fact.
>
> If you turn your compiler into garbage, we can't use it.
>
> End of discussion.
>
> > > Whether they actually clobber memory or not is immaterial, and is not
> > > why we do it.
> >
> > I understand that. My point is that it's not a guarantee that the
> > compiler won't change in the future.
>
> YES IT DAMN WELL IS.
>
> If I have an inline asm thing, and I tell the compiler "this inline
> asm reads or writes memory in ways you don't understand", and you then
> move externally visible memory operations around it - or move other
> inline asms that do the same thing around it - then your compiler is
> simply not a compiler any more.
>
> IT IS BROKEN  SHIT.
>
> See?
>
> That memory clobber is not a "please mister compiler, can you pretty
> please take this into account".
>
> That memory clobber is a "if you don't take this into account, you are
> now no longer a working compiler, and thank Gods we have
> alternatives".
>
> This is not a "in ten years things can change" kind of issue. This is
> a very fundamental and simple thing.
>
> I don't understand why you can't just admit that.
>
> This is as simple as 2+2 being 4. That's black and white.
>
> There is no "the compiler might optimize it to be 3 at some future date".
>
I'm NOT saying that it WILL change or that it SHOULD change. I'm also
not saying that your concern isn't justified. What I am saying is that
unless you're using a compiler feature that's DEFINED as having a
certain effect, then you are not using that feature correctly,
regardless of how it's acted in the past. And it has the potential to
bite you in the ass sooner or later. We've all seen such things happen
before.

I'm not thick and you don't have to yell about this. We're on the same
page! :-) It would be much much better if there was a feature that was
defined to act in the way you want it to. But I'm not offering one at
the moment or even with the change that started this thread.

-bw
