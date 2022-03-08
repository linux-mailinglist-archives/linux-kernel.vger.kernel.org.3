Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998174D2028
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349624AbiCHSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349693AbiCHSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:23:18 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9C56C36;
        Tue,  8 Mar 2022 10:22:21 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id h126so39522918ybc.1;
        Tue, 08 Mar 2022 10:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4zBgpd1vO4K4whJ0aeFp8vuGgyaQ1r84w8kmZDLrWQ=;
        b=OcmUHXBE2t8jVn84FdYwcmOC88NQcIz9fUwGJNKpNgI/X43B1r6ic/loOWFl7/xpbZ
         zkDkjzih/SQ/SzTeq1toEh7qkoCidRO5096O4b3ETISZDVHr8VudsudwKXUccxRwzgaO
         Jg7k5pQwHa1DTxcOJJ9Il4CdI6fUX5wieLv4lm96DOznTavPA3+r8dDThsgFkFLEyG+L
         Kz3nzQ7UMwWn1wlmpiAIHQzSESuYxznW4tRd9dUMidN/SXNhpajjxo0pAYKyISbeCfhu
         sxfCCrKvGqQ+DuSNXi5i49ufwQOCYvjj+ASrBDOOxyxeJtEbvj0YyI9D5HTmdw2yAEWV
         X5Kw==
X-Gm-Message-State: AOAM532YP8jrrB0PYCtlVXoiggtLNijZCaGzpb4ZiSY3Hon0+UUSCArb
        qxHLKz8cW6uDfZpjS49U+vnY/J3MtRVO6q4QZTM=
X-Google-Smtp-Source: ABdhPJw8WvgR1d8fGliP0Hx/KH59qQWjUW31hRHcVvyNr+gwzPILUBi/nJBPQBjppnPcek+knhp7lRjHs9KvkiUykZM=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr12845470yba.633.1646763741101; Tue, 08
 Mar 2022 10:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-2-ionela.voinescu@arm.com> <CAJZ5v0i9iEx56vDwBsxhYcPKcfa2TF9HQqDOGK96Dfpjs3evQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9iEx56vDwBsxhYcPKcfa2TF9HQqDOGK96Dfpjs3evQA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 19:22:10 +0100
Message-ID: <CAJZ5v0jke695COCAkYNOzOcqF7yPPP5p-YPv+E8rOP=qqoVf9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] x86, ACPI: rename init_freq_invariance_cppc to arch_init_invariance_cppc
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 7:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 2, 2022 at 7:10 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
> > after CPU performance information and controls were populated from the
> > per-cpu _CPC objects.
> >
> > But these _CPC objects provide information that helps with both CPU
> > (u-arch) and frequency invariance. Therefore, change the function name
> > to a more generic one, while adding the arch_ prefix, as this function
> > is expected to be defined differently by different architectures.
> >
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

That said it will conflict with this series from Rui:

https://lore.kernel.org/linux-acpi/20220214101450.356047-1-ray.huang@amd.com/

applied by me a while ago.

Maybe consider rebasing when this gets to linux-next ->

> and who's expected to pick this up?

-> and then I guess I can pick it up if everybody agrees.

> > ---
> >  arch/x86/include/asm/topology.h | 2 +-
> >  drivers/acpi/cppc_acpi.c        | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > index 2f0b6be8eaab..5ec70f186775 100644
> > --- a/arch/x86/include/asm/topology.h
> > +++ b/arch/x86/include/asm/topology.h
> > @@ -223,7 +223,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
> >
> >  #if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
> >  void init_freq_invariance_cppc(void);
> > -#define init_freq_invariance_cppc init_freq_invariance_cppc
> > +#define arch_init_invariance_cppc init_freq_invariance_cppc
> >  #endif
> >
> >  #endif /* _ASM_X86_TOPOLOGY_H */
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 866560cbb082..bfd142ab4e07 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -633,8 +633,8 @@ static bool is_cppc_supported(int revision, int num_ent)
> >   *  )
> >   */
> >
> > -#ifndef init_freq_invariance_cppc
> > -static inline void init_freq_invariance_cppc(void) { }
> > +#ifndef arch_init_invariance_cppc
> > +static inline void arch_init_invariance_cppc(void) { }
> >  #endif
> >
> >  /**
> > @@ -816,7 +816,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >                 goto out_free;
> >         }
> >
> > -       init_freq_invariance_cppc();
> > +       arch_init_invariance_cppc();
> >
> >         kfree(output.pointer);
> >         return 0;
> > --
> > 2.25.1
> >
