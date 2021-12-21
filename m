Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219E47C248
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhLUPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhLUPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:10:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91167C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:10:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso16960258otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7AkeyGWcQviJ0n60hJyYgIZHv+Bt6sAvI9CCdmDx0w=;
        b=stRT3I35InwIZEFEDNY7QqDJFt5ctFIj16Q9wNmdGibavZ+20NSvd24HYsuy9NnXUY
         KHjtQuohU8v0DWuw6ajbcpYZWLxv6XhcxSHsU4xZSunwJizZ7XHJYaOtWYWxn8K7DRVn
         bV+lihdWQwkDG1xzIeDlL089KfH8NVe07ACwpNcIaulHCYq5QWdbWdr3Qx5VhgrNc6dL
         eh0ZcyOl0Z5OUSyqsaF7f2qd6cm7qlnSSJjLjCEu4YxorQy5IA94WHVfkR2dd/BaAStH
         HMIpte70yZWs6GhwSZQMOJRqHlVIjDRtmst7UHmyqapB6zRq/FNTpZKtuVcDd9uojLjb
         294g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7AkeyGWcQviJ0n60hJyYgIZHv+Bt6sAvI9CCdmDx0w=;
        b=E6YxnQ3mrtQznJA8aCwygBL3rOSkE067yBFEEF0Ixb5GyNCq+IefB2RN0XDNUFop1y
         UCcOsdX/iQWEJ9PK6SkPBwdQ41O1yKr3Qzba+FDdZ5XFW51wPQI429z/Gl6fSxjGxEWb
         TJccL2AodqnWeA/6fUPl5/Uh39BqE9IEE0cVb+rX+xpqAx8FoXcNIEmLVT9+r6d3tsYR
         cGM7y6D5lymj/XYraunAQs9+a1MpSBaIZ6iqSOtqJUU6BTOxUMPTXY6WpRKtjRHBcpao
         RVsTpm46rjdcAyhdaSlmoKl4kWr5XBXe02AAcedGgsKlatYhkQ2ewfRy7f3ge1MCDRlc
         6X0Q==
X-Gm-Message-State: AOAM5339tV9iSnE9mEf2ybsftn5eHQIRcfVzWnBw06ayE3+H9RfVzeaU
        yNPIm6LvTzbSMz707WalRkmwi0JJVaw/wRxi4gCBxA==
X-Google-Smtp-Source: ABdhPJxpq5aGizZa/XYVoVZfXXO6nCw4dli3o3hZNYMiJhbqtNdptChknMV4cksbq0qHtZprXkv/DQqtwqQJ19eNjO8=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr2493537otl.329.1640099442682;
 Tue, 21 Dec 2021 07:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20211209144141.GC25654@xsang-OptiPlex-9020> <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com> <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com> <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com> <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic> <20211221143153.GA4676@linux.intel.com>
In-Reply-To: <20211221143153.GA4676@linux.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Dec 2021 16:10:31 +0100
Message-ID: <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085: BUG:kernel_reboot-without-warning_in_boot_stage
 - clang KCOV?
To:     Carel Si <beibei.si@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 15:34, Carel Si <beibei.si@intel.com> wrote:
>
> Hi Boris,
>
> On Fri, Dec 17, 2021 at 08:52:53PM +0800, Borislav Petkov wrote:
> > ---
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 0083464de5e3..79b3d67addcc 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -384,7 +384,7 @@ void native_write_cr0(unsigned long val)
> >  }
> >  EXPORT_SYMBOL(native_write_cr0);
> >
> > -void native_write_cr4(unsigned long val)
> > +void __no_profile native_write_cr4(unsigned long val)
> >  {
> >       unsigned long bits_changed = 0;
> >
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index 75acb6027a87..68d2b7f9a913 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -483,7 +483,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
> >       /* Kill off the identity-map trampoline */
> >       reset_early_page_tables();
> >
> > -     __native_tlb_flush_global(native_read_cr4());
> > +     __native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
> >
> >       clear_bss();

Also double-check the Makefile-based solution: the Makefiles in both
directories already contain various KCOV_INSTRUMENT/K*SAN_SANITIZE :=
n, so perhaps adding GCOV_PROFILE or GCOV_PROFILE_whicheverfile.o := n
may be more appropriate should the functions that should not be
instrumented be a moving target, and prone to breakage again in
future.
