Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D40477A77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhLPRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:23:35 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:46757 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbhLPRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:23:34 -0500
Received: by mail-oo1-f49.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso7104886ood.13;
        Thu, 16 Dec 2021 09:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vKc+5ynUW/RqMivEfMUNCzsckin4rmupLQy56q5oCo=;
        b=2oFKaArKECzfaaHcUIJUGeDGZURVCCK4oFtGhLWYmY4xUl1awyxqrFb5Z6/jwbkSEs
         2/7oPd1ptWno22Fc1zvbsDE0KqxIk2KDCDklCVdtlReUH8EhUsLwy42oHsPtvh8l8fRB
         SuHSafbKt2HgiWmlrdf6qYxWaj527qp/wdzgTmaP3SD2C0Oakxt47cs4J5ybVGcRCeHG
         eGPwmh8/T2MpLJyd6HKCc1m/Yn6EmF/tjYhvnMgnM9NQNq3YXedFU6/HdNtX8Mx7SL4E
         pufSoZC3qy6PHewa3mBWNrft/a6+b5VLLEeM6eg56NKK0uv2wBGp2o2cBovyQhBxEKX/
         U82w==
X-Gm-Message-State: AOAM532oGUO5PNl2nsVRVmRuNkpN6NkyRNiWVNGI1wdFp3vPkW0MrHGT
        7KnpFiUDZdhCDh8LR2oJW8hfWZJHNI0QwGaNHVI=
X-Google-Smtp-Source: ABdhPJwDVaUcCbXoxitPK9nB9bQUTuneJ9vgXaxyawtLvYgD2LMUSkV9lRaN0tRCXrfQiVmVDG/Wq7DJe0bQi2zsE6s=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr11828209ooj.0.1639675413880;
 Thu, 16 Dec 2021 09:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-3-ray.huang@amd.com>
In-Reply-To: <20211130123641.1449041-3-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 18:23:22 +0100
Message-ID: <CAJZ5v0i_nE_LnpgkeFLscoR5fGtzCxrV8Zdon7y=Kod_SuFqtw@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] x86/msr: add AMD CPPC MSR definitions
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
>
> AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> registers to manage the performance hints. So add the MSR register macro
> here.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

I guess I can take this one if there are no objections from the x86
maintainers, but it would be nice to receive an ACK from one of them.

> ---
>  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 01e2650b9585..e7945ef6a8df 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -486,6 +486,23 @@
>
>  #define MSR_AMD64_VIRT_SPEC_CTRL       0xc001011f
>
> +/* AMD Collaborative Processor Performance Control MSRs */
> +#define MSR_AMD_CPPC_CAP1              0xc00102b0
> +#define MSR_AMD_CPPC_ENABLE            0xc00102b1
> +#define MSR_AMD_CPPC_CAP2              0xc00102b2
> +#define MSR_AMD_CPPC_REQ               0xc00102b3
> +#define MSR_AMD_CPPC_STATUS            0xc00102b4
> +
> +#define CAP1_LOWEST_PERF(x)    (((x) >> 0) & 0xff)
> +#define CAP1_LOWNONLIN_PERF(x) (((x) >> 8) & 0xff)
> +#define CAP1_NOMINAL_PERF(x)   (((x) >> 16) & 0xff)
> +#define CAP1_HIGHEST_PERF(x)   (((x) >> 24) & 0xff)
> +
> +#define REQ_MAX_PERF(x)                (((x) & 0xff) << 0)
> +#define REQ_MIN_PERF(x)                (((x) & 0xff) << 8)
> +#define REQ_DES_PERF(x)                (((x) & 0xff) << 16)
> +#define REQ_ENERGY_PERF_PREF(x)        (((x) & 0xff) << 24)
> +
>  /* Fam 17h MSRs */
>  #define MSR_F17H_IRPERF                        0xc00000e9
>
> --
> 2.25.1
>
