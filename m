Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2733A486B58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiAFUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:43:15 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:31129 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAFUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:43:14 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AbZvM1KPbd/+/7GPvrR20lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVa93Tom12cCmjQZUT/Xbq7eMDP3etl2YYi/oEwE78TVm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM9n9BDpC79SMmjfjQGOKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0AES3EhbPQYkFPACT3l2SCJ9GXdaXrqwutnFwcuNIsU4PtpCG1?=
 =?us-ascii?q?H3fgZLi0dKBGFm++yhrm8T4FEjdk5Ns7pMZkSqFl6zCrUEO5gR53fK43Q7NFR0?=
 =?us-ascii?q?TMYhc1UG/vaIc0DZlJHaBnGaTVMN00RBZZ4m/2n7lHhcidVs1LTprcy6nL7yA1?=
 =?us-ascii?q?32aLqdt3PdbSiQcRTg1bdvmfu4Wv0GFcZOcaZxD7D9Wij7sfLnCXmSMcRGae++?=
 =?us-ascii?q?/pCnlKe3CoQBQcQWF/9puO24ma7WtRQLGQO9yYupLR0/0uuJvHlUgG1umysvxg?=
 =?us-ascii?q?SQdNcHuQ2rgaXxcL84RuDBy4AQzpFafQ8ucM2TCBs3ViM9/v3BDpkvbuJD32A9?=
 =?us-ascii?q?6uIqi+aPSkTJHUFIygeQmM4D3PLyG0opkuQFZA6Svfz0I2zSWy22T2U6jMwnfM?=
 =?us-ascii?q?VgNJj6klyxnif6xrEm3QDZl9dCt3rY1+Y?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2+TO7a+zKkcN+MigXfZuk+C7I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY+TiX2ra6TdZggviMc9gx/ZJhQo7290cC7KBvhHPVOjbX5U43CYOCfgg?=
 =?us-ascii?q?uVEL0=3D?=
X-IronPort-AV: E=Sophos;i="5.88,267,1635199200"; 
   d="scan'208";a="14087916"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:43:13 +0100
Date:   Thu, 6 Jan 2022 21:43:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Francisco Jerez <currojerez@riseup.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <1b2be990d5c31f62d9ce33aa2eb2530708d5607a.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2201062141290.3098@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>  <alpine.DEB.2.22.394.2112291012030.24929@hadrien>  <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>  <alpine.DEB.2.22.394.2112301840360.15550@hadrien> 
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>  <alpine.DEB.2.22.394.2112301919240.15550@hadrien>  <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>  <alpine.DEB.2.22.394.2112301942360.15550@hadrien> 
 <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>  <alpine.DEB.2.22.394.2201031922110.3020@hadrien>  <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>  <alpine.DEB.2.22.394.2201032110590.3020@hadrien> 
 <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>  <alpine.DEB.2.22.394.2201041643520.3020@hadrien>  <CAJZ5v0i9Rh0Cm3Mbu3N8w6UmgJEnmThk4znWVcp9qeroabjsNw@mail.gmail.com>  <alpine.DEB.2.22.394.2201052107280.48852@hadrien>  <87a6g9rbje.fsf@riseup.net>
  <alpine.DEB.2.22.394.2201062044340.3098@hadrien> <1b2be990d5c31f62d9ce33aa2eb2530708d5607a.camel@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > All the turbostat output and graphs I have sent recently were just
> > for
> > continuous spinning:
> >
> > for(;;);
> >
> > Now I am trying running for the percentage of the time corresponding
> > to
> > 10 / P for pstate P (ie 0.5 of the time for pstate 20), and then
> > sleeping,
> > to see whether one can just add the sleeping power consumption of the
> > machine to compute the efficiency as Rafael suggested.
> >
> Before doing comparison try freezing uncore.
>
> wrmsr -a 0x620 0x0808
>
> to Freeze uncore at 800MHz. Any other value is fine.

Thanks for the suggestion.  What is the impact of this?

julia
