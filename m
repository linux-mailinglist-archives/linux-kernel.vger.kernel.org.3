Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B239481EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbhL3SEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:04:10 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:45692 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhL3SEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:04:08 -0500
Received: by mail-qv1-f50.google.com with SMTP id a9so22733861qvd.12;
        Thu, 30 Dec 2021 10:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zb/bNA0qFKAH2Qfkb5pd0YZ3K8frAzEWY5gohOYhh2M=;
        b=oJGS1a1MhLM/hFLnEzOPSMptAT1rKTQV/qKhbOA62QRcQf+ZTmQ8Mma7EM9dMmlHv5
         iubT+SVoZnd1NEQ2fPCmBuqGgcMTjtdobjo2PiusvYl12Xr1elvgft7rYMlRaQ64Qq54
         hGknnTSbnkQZ+gTYy1eRXmmeEVKbPpiaM0kbIoDyNceCRfScghBzvXvTmBb+8yQsKSQZ
         Aa3yrCHDELPQ39x0H3mkoAv3XAk8eg99suAjdIGi0fqG0EjDyhCdAWRKW9e3x+vCcObM
         njw8zLje0WE/hBh1kaaNjc7vnRjobt838J4/jEXgnpDieZk9XTSuWdnacY5I76c8J0yI
         Qcjg==
X-Gm-Message-State: AOAM530Z+4UvP+YbxeZI8/sRJIfm68SvpmRBjDxSzVCA8nRuuz7ezfkK
        Q9kmYLmIYNKGqfgAHsuAIzLck8lMsZuAkPmbdiM=
X-Google-Smtp-Source: ABdhPJwZtjAcrRsCHaQwqhPJCAlk5FSKajqZ2AB7Pz3htM+xdhdMuOkGquyP3e38ot4Tt37KBuJoztZvX53AUvzidaw=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr28417662qvd.52.1640887447800;
 Thu, 30 Dec 2021 10:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com> <20211220151438.1196-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20211220151438.1196-3-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 19:03:57 +0100
Message-ID: <CAJZ5v0if855q45KOvCkOGq3DZfx4nsH1yzr5qCEYvZCe1bzASw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware
 Feedback Interface
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Add the CPUID feature bit and the model-specific registers needed to
> identify and configure the Intel Hardware Feedback Interface.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v1:
>   * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)

It would be good to get an ACK from the x86 side for this.

> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/msr-index.h   | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d5b5f2ab87a0..1a31b3ef15f0 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -327,6 +327,7 @@
>  #define X86_FEATURE_HWP_ACT_WINDOW     (14*32+ 9) /* HWP Activity Window */
>  #define X86_FEATURE_HWP_EPP            (14*32+10) /* HWP Energy Perf. Preference */
>  #define X86_FEATURE_HWP_PKG_REQ                (14*32+11) /* HWP Package Level Request */
> +#define X86_FEATURE_HFI                        (14*32+19) /* Hardware Feedback Interface */
>
>  /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
>  #define X86_FEATURE_NPT                        (15*32+ 0) /* Nested Page Table support */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 01e2650b9585..ad958a49b2bb 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -687,12 +687,14 @@
>
>  #define PACKAGE_THERM_STATUS_PROCHOT           (1 << 0)
>  #define PACKAGE_THERM_STATUS_POWER_LIMIT       (1 << 10)
> +#define PACKAGE_THERM_STATUS_HFI_UPDATED       (1 << 26)
>
>  #define MSR_IA32_PACKAGE_THERM_INTERRUPT       0x000001b2
>
>  #define PACKAGE_THERM_INT_HIGH_ENABLE          (1 << 0)
>  #define PACKAGE_THERM_INT_LOW_ENABLE           (1 << 1)
>  #define PACKAGE_THERM_INT_PLN_ENABLE           (1 << 24)
> +#define PACKAGE_THERM_INT_HFI_ENABLE           (1 << 25)
>
>  /* Thermal Thresholds Support */
>  #define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
> @@ -941,4 +943,8 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>
> +/* Hardware Feedback Interface */
> +#define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
> +#define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
> +
>  #endif /* _ASM_X86_MSR_INDEX_H */
> --
> 2.17.1
>
