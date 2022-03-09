Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76674D366E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiCIRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiCIRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:11:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B212DFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:04:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso2996957wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndx32WBmfBxuvJH6NgXVPP6Qai1KeFznS/MWmU68F2k=;
        b=YQjVRwGsmDyttSMWRArNfLF0dqeQKY8E/07xyYcuzGr0kpyfDmH8G4dbdGdwdlBwnP
         zX1OtOneZOfWA5I7yR+egmuSJ2jHhH7Ut7NmOVk1XPYZi0TADjvFf5B5DFIvdUkNY62P
         +cvUl3a7OfQRD0oBDWHHEUNpZ7y2RxB1g2F8aRdKdvN5tt4jdIZjz2wzUoM1Xdj+uEwz
         4YWWV1fNTpxtUqI9nbSpNzW55JCP6aUHS8hIbhGRLCdSUpYypgBjKrYzBB4AnrJV5Wj8
         Cxpn/g7Z6EZckp3ywXFFKd8kS5wEwjqPOsYOOYEeBNo2wik/g+SdAai+Er3kQuhh/VAp
         xKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndx32WBmfBxuvJH6NgXVPP6Qai1KeFznS/MWmU68F2k=;
        b=6Bk+ccegWlQCINtBFIEKQzIgyhSauZlsTN30QNnu9d+7LGuzI36dI0/USLWH21wJKN
         bRaJQf4h77Jl20NRW8OY+Xc04gq69RH+XZw5GuCTzONqwcG0mJf7sGLOvM35joi7HvFB
         iTlBUYFe7JeoS1l/JoEPhe97knQvilrSula6uKHRIuAopxrLEpAyUulHyJhCP+f9t4ur
         7nQQDH2CeFEUk4mKZ4HjosNpGzoQTDXVLuvX1tV5v66cOaoEd9yGFEOgK0UfT9xGjBKf
         1ziiiFWco7wkL98TNsd1u1KUwj7fg1zyEXi0Wp5AXiLjGUl0aKe0WRm+VYY0etrL/tHD
         VI5Q==
X-Gm-Message-State: AOAM532nQFu5EoXUgas/KMnlGcGhFciEqyrKgyojunQk8rfO5VN1fByl
        dNvaiD6PLkN1gdRtXlUHTjwTHUKPpZUiMhokygWStA==
X-Google-Smtp-Source: ABdhPJy5alfRTJ16ow1R2qoghwtdNe1YLO1P7U2E+EplB8YB4Kg4kWeP+53DYGC1dkaYhZktOY9T6zkHogbJiFNWhcI=
X-Received: by 2002:a7b:c057:0:b0:37b:ebad:c9c8 with SMTP id
 u23-20020a7bc057000000b0037bebadc9c8mr8419395wmc.61.1646845453376; Wed, 09
 Mar 2022 09:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
 <20220307184935.1704614-2-kaleshsingh@google.com> <CAE-0n52LmVRkrSNN=eJf+TYYnmesVjFv99nnetYvRWshm82rOg@mail.gmail.com>
 <CAC_TJvc6LYp95BXQc0DSBBBAZpYpixa+NyHKMLFWsBADD5Ubhg@mail.gmail.com> <Yija5cY6j/B25Psw@google.com>
In-Reply-To: <Yija5cY6j/B25Psw@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 9 Mar 2022 09:04:01 -0800
Message-ID: <CAC_TJvc9o5OJ-aSLkDOu8h3jnuHvBQZnh8pRFbHxunVWUyhHzA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
To:     Quentin Perret <qperret@google.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 8:50 AM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 08 Mar 2022 at 15:09:18 (-0800), Kalesh Singh wrote:
> > On Tue, Mar 8, 2022 at 12:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > It looks odd to use an error pointer casted to unsigned long to return
> > > from an address allocation function. Why not pass a pointer for base
> > > like the function was written before and return an int from this
> > > function with 0 for success and negative error value?Otherwise some
> > > sort of define should made like DMA_MAPPING_ERROR and that can be used
> > > to indicate to the caller that the allocation failed, or a simple zero
> > > may work?
> >
> > I wanted to keep consistent between the pkvm and traditional nvhe
> > code. I will refactor both *alloc_private_va_range() functions to take
> > a pointer and return an int error if that's preferred. There would
> > still be a case of this kind of cast in
> > __pkvm_create_private_mapping() which does return an unsigned long
> > address or ERR_PTR(...). It looks like it was made to return the
> > address to facilitate use as a hypercall (@Quentin CMIW).
>
> Yep, passing everything by value was much easier to cross the EL1/EL2
> boundary as that avoids having the hypervisor map kernel memory and all
> that fun. But Stephen's point is fair, so no objection from to keep this
> little dance confined to the hypercall wrapper and make the function
> signature nicer and easier to use for the rest of the code.

Thanks for clarifying Quentin. That sounds good to me.

- Kalesh

>
> Cheers,
> Quentin
