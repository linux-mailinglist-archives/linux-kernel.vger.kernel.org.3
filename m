Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746249B037
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457887AbiAYJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455880AbiAYJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:07:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE6C0604E4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:52:32 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z5so4682752plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6BUBIXxwk4JS7jq5Yl7ItB5kjOCwOltRASPAnQYIJw=;
        b=isin369zUSC40ktqW1doEJCXWOEH1OU5ukhknSdIN4RWE4rkPLugFGrL4HYjTnuK9p
         Y8jFQpCuI/ESuhyEQhI9LBentgNgik6941Y2a0pJ2mPikrhj6FYXExGQATyUT68+1HHe
         iNxyCvMdyw+C6J5lP5q4tKtmBJVLcad6GMqokKtHlzsva6c/phxQkw6HCaXwT0PDvtD5
         T4T3R+T4mNGjUkhXriMwlsTj0TSmjoj3gG0bspRcezdlrC4b1kuCSQmWYneNBET3mm7+
         FRw0WmyHpjKPEFqEtftPkDOIAs5kcF9vaSFfQFoNKMD0hCWUUnMfpxLaeUQPwQjUcYeM
         mcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6BUBIXxwk4JS7jq5Yl7ItB5kjOCwOltRASPAnQYIJw=;
        b=WqUX4Mv9tiXyiNOVyfhmzR78mftIoBPzjYV4JBQkzBRYh1boSHPcey3YwqIUI4Ob/b
         CuI/k6jrEg/xa4Oz+kCjz5R3Rj4GwYelrxQBYZwjcW8oLcK1pKvylgd/br8hyroQotQT
         1SLv8hNOy8OE4i2UkYGX3eWzmV8RVoxp0NhhXZ+XalAO6jvRh+hDoahYM2CA8EGMls2v
         x/dfMxPDaT/rfuCFy8XUipCJf3gUwGBahh7VG9hpofOryI45nvlMJaiRLpShLtwvT8H0
         fzZeaKhJQ8NOzyzceMeAkM0b8a+IckkusCYrfSsNA6X048CFEl2hrHOTEVb3ZOmnLg2m
         N2cA==
X-Gm-Message-State: AOAM531286/ZSv4zylOLVSU2nAQnQvItKX7tykx4Ul7rsahhs3WX5wLz
        Wgvy6wpP95wRzU7X4C0CAHnZZlZEHeSd3jla/NAXdQ==
X-Google-Smtp-Source: ABdhPJyJCDBExRKo1Z2uaO9BO1hoBiSILCxHvfufTUddE7i5PKusvobUkxXsUsTI4l9zR+XhF8mPIQT697Ywp8srQVA=
X-Received: by 2002:a17:90b:1881:: with SMTP id mn1mr2400939pjb.236.1643100751744;
 Tue, 25 Jan 2022 00:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20220123195239.509528-1-ayushranjan@google.com> <Ye7gykcvjig7aPNM@google.com>
In-Reply-To: <Ye7gykcvjig7aPNM@google.com>
From:   Ayush Ranjan <ayushranjan@google.com>
Date:   Tue, 25 Jan 2022 00:51:55 -0800
Message-ID: <CALqkrRUVVEiM9HxOCffVVDczxBr7yGCw4r0vdH1W0K0B4+h6iQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add additional EPT bit definitions
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        Andrei Vagin <avagin@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Pratt <mpratt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abandoning this patch.

On Mon, Jan 24, 2022 at 9:24 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sun, Jan 23, 2022, Ayush Ranjan wrote:
> > From: Michael Pratt <mpratt@google.com>
> >
> > Used in gvisor for EPT support.
>
> As you may have surmised from the other patch, the changelogs from patches carried
> in our internal kernels rarely meet the criteria for acceptance upstream.  E.g. this
> doesn't provide sufficient justification since there's obviously no in-kernel gvisor
> that's consuming this.
>
> Submitting patches that we carry internally is perfectly ok, but there needs to be
> sufficient justfication, and the patch needs to follow the rules laid out by
> Documentation/process/submitting-patches.rst.
>
> > Tested: Builds cleanly
> > Signed-off-by: Ayush Ranjan <ayushranjan@google.com>
> > Signed-off-by: Michael Pratt <mpratt@google.com>
> > ---
> >  arch/x86/include/asm/vmx.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > index 0ffaa3156a4e..c77ad687cdf7 100644
> > --- a/arch/x86/include/asm/vmx.h
> > +++ b/arch/x86/include/asm/vmx.h
> > @@ -496,7 +496,9 @@ enum vmcs_field {
> >  #define VMX_EPT_WRITABLE_MASK                        0x2ull
> >  #define VMX_EPT_EXECUTABLE_MASK                      0x4ull
> >  #define VMX_EPT_IPAT_BIT                     (1ull << 6)
> > -#define VMX_EPT_ACCESS_BIT                   (1ull << 8)
> > +#define VMX_EPT_PSE_BIT                              (1ull << 7)
>
> I'm not a fan of "PSE", it's unnecessarily terse and "PSE" has different meaning
> in IA32 paging.  VMX_EPT_PAGE_SIZE_BIT would be choice.
>
> As for justification, something that has been mentioned once or thrice is the lack
> of build-time assertions that the PT_* bits in mmu.h that are reused for EPT entries
> do indeed match the EPT definitions.  I can throw together a patch/series to add
> that and do the below cleanup.
>
> > +#define VMX_EPT_ACCESS_SHIFT                 8
>
> I'd prefer we don't define the "shifts" for EPT (or PTE) bits, they really shouldn't
> be used as doing things like test_and_clear_bit() via a shift value can generate
> unnecessary lock instructions.  arch/x86/kvm/mmu.h could use a bit of spring cleaning
> in this regard.
>
> > +#define VMX_EPT_ACCESS_BIT                   (1ull << VMX_EPT_ACCESS_SHIFT)
> >  #define VMX_EPT_DIRTY_BIT                    (1ull << 9)
> >  #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
> >                                                VMX_EPT_WRITABLE_MASK |       \
> > --
> > 2.35.0.rc0.227.g00780c9af4-goog
> >
