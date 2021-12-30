Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812C0481F26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhL3SU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:20:59 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18261
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233228AbhL3SU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:20:58 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A4xYr+K30IRHhY3Lit/bD5cVwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJgWwrhmBUmmJNCzrQb6mOYTbye9tya4nk8k4Eu5+Bxtc2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4Ef9WlTdhSMkj/jRHOGkULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?lm7rhc0AMKlLQFVjTzCQGHfH4214b+XdaPqUTbZLwbW9VljGIlpZ1wcpEsZiYS?=
 =?us-ascii?q?AEzP6SKlv51vxxwSnshZfEap9crJlD666R/1XbuaXLiyvhqJEI7J4sV/qBwG24?=
 =?us-ascii?q?m3fcFMioKbB2ZivCe2rOgR/R0wMIuMKHDJ5kevHB+xCqfFf8gTYreXazG7Pdc3?=
 =?us-ascii?q?TEtloZPG+rTY4wSbj8HRBDNZRdnOVoNDp862uCyiRHXbTxCpUmV46kq5mHJ5Ah?=
 =?us-ascii?q?w1rH3N5zSYNPibcFUmFuI43rD13r2DwtcN9GFzzeBtHW2iYfnmSL9RZJXF7Ci8?=
 =?us-ascii?q?PNuqEOcy3ZVCxAMU1a/5/6jhSaWXtNZJEs84CciraEuskesS7HVRxCkrWSWlh8?=
 =?us-ascii?q?aVcBZH+Az5EeK0KW8ywSEHGlCSjNFbN0OrsI6RTU2kFSOmrvBGz1pu7CTVTSS6?=
 =?us-ascii?q?7aIsTSuESwUK2YYYmkDVwRt3jVJiOnflTqWEY0lSfTsyIOlX2GthSqHsm4lia9?=
 =?us-ascii?q?Vi8MXv5hXNGvv21qEzqUlhCZvjukPYl+Y0w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aih3VWKP06LnfF8BcTsajsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfU7SKelfqyV9sjzkCWUtN9zYgBEpTnjAsm9qBrnnPZICMsqTNSftWLd1l?=
 =?us-ascii?q?dAQrsP0WKv+UyDJwTOst8Y76tmfqRkYeecMXFxh6/BjzWFLw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635199200"; 
   d="scan'208";a="1270447"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:20:47 +0100
Date:   Thu, 30 Dec 2021 19:20:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112301919240.15550@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net> <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2021, Rafael J. Wysocki wrote:

> On Thu, Dec 30, 2021 at 6:54 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > > > The effect is the same.  But that approach is indeed simpler than patching
> > > > the kernel.
> > >
> > > It is also applicable when intel_pstate runs in the active mode.
> > >
> > > As for the results that you have reported, it looks like the package
> > > power on these systems is dominated by package voltage and going from
> > > P-state 20 to P-state 21 causes that voltage to increase significantly
> > > (the observed RAM energy usage pattern is consistent with that).  This
> > > means that running at P-states above 20 is only really justified if
> > > there is a strict performance requirement that can't be met otherwise.
> > >
> > > Can you please check what value is there in the base_frequency sysfs
> > > attribute under cpuX/cpufreq/?
> >
> > 2100000, which should be pstate 21
> >
> > >
> > > I'm guessing that the package voltage level for P-states 10 and 20 is
> > > the same, so the power difference between them is not significant
> > > relative to the difference between P-state 20 and 21 and if increasing
> > > the P-state causes some extra idle time to appear in the workload
> > > (even though there is not enough of it to prevent to overall
> > > utilization from increasing), then the overall power draw when running
> > > at P-state 10 may be greater that for P-state 20.
> >
> > My impression is that the package voltage level for P-states 10 to 20 is
> > high enough that increasing the frequency has little impact.  But the code
> > runs twice as fast, which reduces the execution time a lot, saving energy.
> >
> > My first experiment had only one running thread.  I also tried running 32
> > spinning threads for 10 seconds, ie using up one package and leaving the
> > other idle.  In this case, instead of staying around 600J for pstates
> > 10-20, the pstate rises from 743 to 946.  But there is still a gap between
> > 20 and 21, with 21 being 1392J.
> >
> > > You can check if there is any C-state residency difference between
> > > these two cases by running the workload under turbostat in each of
> > > them.
> >
> > The C1 and C6 cases (CPU%c1 and CPU%c6) are about the same between 20 and
> > 21, whether with 1 thread or with 32 thread.
>
> I meant to compare P-state 10 and P-state 20.
>
> 20 and 21 are really close as far as the performance is concerned, so
> I wouldn't expect to see any significant C-state residency difference
> between them.

There's also no difference between 10 and 20.  This seems normal, because
the same cores are either fully used or fully idle in both cases.  The
idle ones are almost always in C6.

julia
