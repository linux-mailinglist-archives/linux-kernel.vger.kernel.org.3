Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AED4D1FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbiCHSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbiCHSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:07:00 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6F49914;
        Tue,  8 Mar 2022 10:06:03 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id j2so39506783ybu.0;
        Tue, 08 Mar 2022 10:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPR7/VGPV23k4djwaMrNbwv3yAQLYJoAwhpzcs5Yyug=;
        b=ivSsgRc6k3u4ND9W0XzWm3DvmuHipIzKm0AfwBTkwqTW66N4jhEKqYJZloc7zmZkzD
         xXWI1tG09tGLsXpyCSU4rPHtzgteoj8mlVcQz9VgC0XSx+O1Jh9ptAc7yypM7IUzoZau
         QvaW5QClDtljxy045+fmKQrtr00V2WLheqvcWSnY9ftSxj+OBWHy/X3/BVfFv4UfMsPV
         6mnuPPpFsgj9Q/bZptTuaMTDVujhDKli2U+YXVVUww4N0lTiqNaZDqJMQdWADauJpr9F
         RmAhm5Dlg+wA0ldTwaA8wYHUl6IYZOMSm/4VV9BYNQNPIOhgpPyy1s++UZ/BbYG47qAs
         le6A==
X-Gm-Message-State: AOAM530ce6nfW7AyrSCHxsZZwNLhb4J68dXlc/KwlTtV1PBmzShVFYUe
        uTEyHwqiRquZb8yOeV4siWl7sCJl25B3bAqm/8Q=
X-Google-Smtp-Source: ABdhPJwigo7JBM7noPglHYlHuR7oj7u0a4NOcWUIiDMhwSSasf1J7aZ7/2k+5D/dzpr1ZajSbc2vxcu4tar5e/CJIxw=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr13302933ybk.482.1646762763032; Tue, 08
 Mar 2022 10:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20220302180913.13229-1-ionela.voinescu@arm.com> <20220302180913.13229-2-ionela.voinescu@arm.com>
In-Reply-To: <20220302180913.13229-2-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 19:05:52 +0100
Message-ID: <CAJZ5v0i9iEx56vDwBsxhYcPKcfa2TF9HQqDOGK96Dfpjs3evQA@mail.gmail.com>
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

On Wed, Mar 2, 2022 at 7:10 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
> after CPU performance information and controls were populated from the
> per-cpu _CPC objects.
>
> But these _CPC objects provide information that helps with both CPU
> (u-arch) and frequency invariance. Therefore, change the function name
> to a more generic one, while adding the arch_ prefix, as this function
> is expected to be defined differently by different architectures.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and who's expected to pick this up?

> ---
>  arch/x86/include/asm/topology.h | 2 +-
>  drivers/acpi/cppc_acpi.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 2f0b6be8eaab..5ec70f186775 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -223,7 +223,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
>
>  #if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
>  void init_freq_invariance_cppc(void);
> -#define init_freq_invariance_cppc init_freq_invariance_cppc
> +#define arch_init_invariance_cppc init_freq_invariance_cppc
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 866560cbb082..bfd142ab4e07 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -633,8 +633,8 @@ static bool is_cppc_supported(int revision, int num_ent)
>   *  )
>   */
>
> -#ifndef init_freq_invariance_cppc
> -static inline void init_freq_invariance_cppc(void) { }
> +#ifndef arch_init_invariance_cppc
> +static inline void arch_init_invariance_cppc(void) { }
>  #endif
>
>  /**
> @@ -816,7 +816,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                 goto out_free;
>         }
>
> -       init_freq_invariance_cppc();
> +       arch_init_invariance_cppc();
>
>         kfree(output.pointer);
>         return 0;
> --
> 2.25.1
>
