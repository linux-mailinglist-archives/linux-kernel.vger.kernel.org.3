Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01544F8C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiDHB6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiDHB6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:58:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C15AC045
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:56:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l36so12655801ybj.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btW7cj9LP2yRjSmuqealKT3fO/g7JheEjmBSucek/ec=;
        b=AQPW9DPnRRcbsm6/XKk7gHUcL7Px5oDuZx61veNcBATmJmmwKyoJH5LyXsPv9ICFh3
         sJdtGPXQQWmpguM81NJX+NUYG2YXxKvq53rOd+9DQjTcx8rNcUKW7W9RmWibUHqv5HoW
         MfBhjx71GfbE53PxCo0PhBonHx0vy2QJiPiQe4wHzjxtoX7eBwUydsUNJYww6i8qSeIV
         Xmj2gkDoUaAIuP0n2UzxJQHd9YoHNNGA0a78aqhFJyC9uIF9WuWlafbJZZ48iBkuEZEr
         5fEoTVuYyePsdZ8ZaOjdykGXQ4Qr3q61jDYcIGigGtI+DXrMOKuYGUu2T3Nk8f95Zc8y
         P1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btW7cj9LP2yRjSmuqealKT3fO/g7JheEjmBSucek/ec=;
        b=f5E4eoPia9kVfDkc11+LwVXBRCohedtI7TR34LR1VMGF5tVAtuV8+HTAt6kg144C26
         nLvGBoOslA7hXz/UaanzXjsdvwGtKUjlpcEB+3zfSoNmnTyhUoLi/eSqgW8U2loq46Ls
         ootFFV5HOfg72IeYE3DC7wJl614yA/t/tVBb/QAUvlXqoLyMI53O3PP7ccLgnfV1NdN/
         LiP6kJuFOUdK6mkkA4o64yryPPGJYaaTQhoS52lyXjIHkVlrSi7w92PBdJQuv6a2V6IV
         65O4wYj3Ew7C/cUiDBqzz+LXVn7oZfkJDAo22BHGCJ3Mxi+445wl1udcvSU9SZ3NQOnw
         Cq/A==
X-Gm-Message-State: AOAM530cAgvWdey/UYXKnhnIuEis+mDJ1VER8tuULIy+wX6shP+Sz1wN
        fBDo4k+rDjNfLBqW8TczKYxTHH7TWnsDANjPQ8M=
X-Google-Smtp-Source: ABdhPJzPghcJNvBj0ALlgMb0UMZUaGGsSkzMQ0xjJzvWYvHPDWIZ/emLqBVMZrQl8y6jATDiXFiPLi4eccdTdVOns3A=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr13151269ybg.352.1649382998700; Thu, 07
 Apr 2022 18:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com> <Yk3jVrXoVpxuR0Mp@zn.tnic>
 <CAJhGHyBFbtyUs-nf0+gWm2a3hiS5BxZ3jk=sbGNw-4ShB8AtzQ@mail.gmail.com>
 <Yk6fQfgo975pW3t0@zn.tnic> <Yk7kwzIv2YA+aO7y@zn.tnic>
In-Reply-To: <Yk7kwzIv2YA+aO7y@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 8 Apr 2022 09:56:26 +0800
Message-ID: <CAJhGHyByXaeaYqq54EY6YoNwf4DrupCXeZmtdi9ViYwmDx2ffQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
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

On Thu, Apr 7, 2022 at 9:19 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 07, 2022 at 10:22:25AM +0200, Borislav Petkov wrote:
> > Maybe there was a reason it was done this way:
>
> Ok, I went and singlestepped this code so that I can see what's going
> on.

[....]

>
> So your commit message should have been as simple as:
>
> "Always stash the address error_entry() is going to return to, in %r12
> and get rid of the void *error_entry_ret; slot in struct bad_iret_stack
> which was supposed to account for it and pt_regs pushed on the stack.
>
> After this, both functions can work on a struct pt_regs pointer
> directly."

Thank you for elaborating on the details and I will use this changelog.

Thanks
Lai

>
> In any case, I don't see why amluto would do this so this looks like a
> sensible cleanup to do.
>
