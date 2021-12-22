Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9047D637
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbhLVSFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:05:53 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39743 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhLVSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:05:51 -0500
Received: by mail-qk1-f172.google.com with SMTP id 69so3100235qkd.6;
        Wed, 22 Dec 2021 10:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf5aXPoDAE/jO+Ix3AJanCNaQUNSY1ijxTeKGh4Dwj8=;
        b=NnQ/3eSpkQ0kEHYNXFHrFGqPAj2b1gEs+n+Sh6LAuNQcmwUVujSzsN9uYpyLsdsfxO
         ZBV+i0f7bapvTxDVyvDKuu+3JIqOV6VJA80zaJPOZuRacPEBA411jfw/OoYPAKsyISqb
         LHbEiViDFjDyV2SmvEJKSfP3UWlKaI3ZOg+uSVvDscRVtw5p/FvUCR3+GwFY/GCgqMxj
         w5YZrYqhq2YhPWatmApmKnlKGcaJ45s/nwA6Lur4F3b0vuYG2JaLDj2Ha2Qye6s8EpKE
         jksodBppqFagbRtiiyyE8Erirw+7Ld/gj4eO2bT4ymTKe3U2na8euCGQrzKjICt+HiVk
         G44A==
X-Gm-Message-State: AOAM5338mp5ryKu+KUuSni5U2BshQlKwvn1GqAUQRSAKZwKGETkAJTP6
        tQGgam80XUL22KYHfb7iCWyTmx4KldpsG7yZc+E=
X-Google-Smtp-Source: ABdhPJxfTli9xvKRiKrxKAotvByqu494ew7/JecFpwV4DxThjSnnC0kkG6jK/t/8mb4L410nnerUW02iqxOOOFVdO58=
X-Received: by 2002:a05:620a:706:: with SMTP id 6mr2880466qkc.374.1640196350918;
 Wed, 22 Dec 2021 10:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20211219163528.1023186-1-ray.huang@amd.com> <20211219163528.1023186-3-ray.huang@amd.com>
 <YcH2hYJN9+NudhH4@zn.tnic> <YcJulhgWUj6kmQEw@amd.com>
In-Reply-To: <YcJulhgWUj6kmQEw@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Dec 2021 19:05:40 +0100
Message-ID: <CAJZ5v0gA+FNh9EQWm0urtzFLgvzuakGydmKXG1pqakqrmDg18w@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] x86/msr: add AMD CPPC MSR definitions
To:     Huang Rui <ray.huang@amd.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:17 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Hi Boris,
>
> On Tue, Dec 21, 2021 at 11:45:09PM +0800, Borislav Petkov wrote:
> > On Mon, Dec 20, 2021 at 12:35:16AM +0800, Huang Rui wrote:
> >
> > Capitalize subject's first letter:
> >  [x86/msr: add AMD CPPC MSR definitions]
> >  [x86/msr: Add AMD CPPC MSR definitions]
>
> Thank you for the reply! Updated.
>
> >
> > > AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> > > registers to manage the performance hints. So add the MSR register macro
> > > here.
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > > index 01e2650b9585..e7945ef6a8df 100644
> > > --- a/arch/x86/include/asm/msr-index.h
> > > +++ b/arch/x86/include/asm/msr-index.h
> > > @@ -486,6 +486,23 @@
> > >
> > >  #define MSR_AMD64_VIRT_SPEC_CTRL   0xc001011f
> > >
> > > +/* AMD Collaborative Processor Performance Control MSRs */
> > > +#define MSR_AMD_CPPC_CAP1          0xc00102b0
> > > +#define MSR_AMD_CPPC_ENABLE                0xc00102b1
> > > +#define MSR_AMD_CPPC_CAP2          0xc00102b2
> > > +#define MSR_AMD_CPPC_REQ           0xc00102b3
> > > +#define MSR_AMD_CPPC_STATUS                0xc00102b4
> > > +
> > > +#define CAP1_LOWEST_PERF(x)        (((x) >> 0) & 0xff)
> > > +#define CAP1_LOWNONLIN_PERF(x)     (((x) >> 8) & 0xff)
> > > +#define CAP1_NOMINAL_PERF(x)       (((x) >> 16) & 0xff)
> > > +#define CAP1_HIGHEST_PERF(x)       (((x) >> 24) & 0xff)
> > > +
> > > +#define REQ_MAX_PERF(x)            (((x) & 0xff) << 0)
> > > +#define REQ_MIN_PERF(x)            (((x) & 0xff) << 8)
> > > +#define REQ_DES_PERF(x)            (((x) & 0xff) << 16)
> > > +#define REQ_ENERGY_PERF_PREF(x)    (((x) & 0xff) << 24)
> >
> > All those bitfield names are too generic - they should at least be
> > prefixed with "CPPC_"
> >
> > If an Intel CPPC set of MSRs appears too, then the prefix should be
> > "AMD_CPPC_" and so on.
> >
>
> The similar function in Intel names HWP (Hardware P-State), and related MSR
> registers names as "HWP_" as the prefixes like below:
>
> /* IA32_HWP_CAPABILITIES */
> #define HWP_HIGHEST_PERF(x)             (((x) >> 0) & 0xff)
> #define HWP_GUARANTEED_PERF(x)          (((x) >> 8) & 0xff)
> #define HWP_MOSTEFFICIENT_PERF(x)       (((x) >> 16) & 0xff)
> #define HWP_LOWEST_PERF(x)              (((x) >> 24) & 0xff)
>
> Hi Rafael,
>
> Can we use the "CPPC_" as the prefixes for AMD CPPC MSR bitfield name?

Well, what about using "AMD_CPPC_" instead of "REQ_" in these names?
The names of the analogous Intel macros start with "HWP_" which
basically stands for "INTEL_CPPC_".
