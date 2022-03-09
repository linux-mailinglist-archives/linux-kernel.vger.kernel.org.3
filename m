Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F794D2C07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiCIJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiCIJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:31:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D54A516EA98;
        Wed,  9 Mar 2022 01:30:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DBC1650;
        Wed,  9 Mar 2022 01:30:34 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BF583FA20;
        Wed,  9 Mar 2022 01:30:33 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:30:32 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH v3 1/3] x86, ACPI: rename init_freq_invariance_cppc to
 arch_init_invariance_cppc
Message-ID: <YihzuD9G8IV4/P7m@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-2-ionela.voinescu@arm.com>
 <CAJZ5v0i9iEx56vDwBsxhYcPKcfa2TF9HQqDOGK96Dfpjs3evQA@mail.gmail.com>
 <CAJZ5v0jke695COCAkYNOzOcqF7yPPP5p-YPv+E8rOP=qqoVf9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jke695COCAkYNOzOcqF7yPPP5p-YPv+E8rOP=qqoVf9g@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 Mar 2022 at 19:22:10 (+0100), Rafael J. Wysocki wrote:
> On Tue, Mar 8, 2022 at 7:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Mar 2, 2022 at 7:10 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
> > > after CPU performance information and controls were populated from the
> > > per-cpu _CPC objects.
> > >
> > > But these _CPC objects provide information that helps with both CPU
> > > (u-arch) and frequency invariance. Therefore, change the function name
> > > to a more generic one, while adding the arch_ prefix, as this function
> > > is expected to be defined differently by different architectures.
> > >
> > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> That said it will conflict with this series from Rui:
> 
> https://lore.kernel.org/linux-acpi/20220214101450.356047-1-ray.huang@amd.com/
> 
> applied by me a while ago.
> 
> Maybe consider rebasing when this gets to linux-next ->

Will do that!

> 
> > and who's expected to pick this up?
> 
> -> and then I guess I can pick it up if everybody agrees.

Many thanks, Rafael!

> 
> > > ---
> > >  arch/x86/include/asm/topology.h | 2 +-
> > >  drivers/acpi/cppc_acpi.c        | 6 +++---
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > > index 2f0b6be8eaab..5ec70f186775 100644
> > > --- a/arch/x86/include/asm/topology.h
> > > +++ b/arch/x86/include/asm/topology.h
> > > @@ -223,7 +223,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
> > >
> > >  #if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
> > >  void init_freq_invariance_cppc(void);
> > > -#define init_freq_invariance_cppc init_freq_invariance_cppc
> > > +#define arch_init_invariance_cppc init_freq_invariance_cppc
> > >  #endif
> > >
> > >  #endif /* _ASM_X86_TOPOLOGY_H */
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > index 866560cbb082..bfd142ab4e07 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -633,8 +633,8 @@ static bool is_cppc_supported(int revision, int num_ent)
> > >   *  )
> > >   */
> > >
> > > -#ifndef init_freq_invariance_cppc
> > > -static inline void init_freq_invariance_cppc(void) { }
> > > +#ifndef arch_init_invariance_cppc
> > > +static inline void arch_init_invariance_cppc(void) { }
> > >  #endif
> > >
> > >  /**
> > > @@ -816,7 +816,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> > >                 goto out_free;
> > >         }
> > >
> > > -       init_freq_invariance_cppc();
> > > +       arch_init_invariance_cppc();
> > >
> > >         kfree(output.pointer);
> > >         return 0;
> > > --
> > > 2.25.1
> > >
