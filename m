Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9900480C28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhL1Rq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:46:27 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3249 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236060AbhL1Rq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:46:26 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AS8eb8qzl9Uya3v+3S5d6t+cexyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDt03z0FnGUdWW6CPP3eNjf9fNtyPYrk80NUvZ6Dz9dnHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9YtANkVEmjfvRH+CmWLa?=
 =?us-ascii?q?eUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Nkr/3aEwHRNY+PyDe1zwIC+772EEE/3Npuko4HKN0hUN/iSiNntk3zNxSvJi0Y?=
 =?us-ascii?q?QYvJKzF3uoHO/VdO3gkbfYbpu+ZSZS4mYnJp6HcSFP2yvtnAUUePoAC/OtzR2Z?=
 =?us-ascii?q?U+pQwLDkSZxSHr/C3xbihQ69tgN4iJY/lJus3sWx61zbbAOwrU7jZQr7H+Mce2?=
 =?us-ascii?q?jos7uhVB/fYZtQQcnx3ZRLMeQBRM1seIJY/mvq4wHj5bzBc7lmSoMIf52XVxiR?=
 =?us-ascii?q?y3aLrPd6TfcaFLe1Ln1yVvWKA/Hn8CwsyMN2ZwCCCtHW2iYfnmSL9RZJXDLiQ6?=
 =?us-ascii?q?PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dcJlYS9y4Gs6c/7gqoQ8P7Uhn+p2SL1jY?=
 =?us-ascii?q?ZWtxfFMUg5Q2Nw7aS6AGcbkAcQyJMcs4Otck4XzUm21aF2dTzClRHsqCPSDSZ+?=
 =?us-ascii?q?7OQrBuoNCQVJHNEbigBJSMb4t/orYcvyB3ST8p/F7KditzzECv3hTeQo0ADax8?=
 =?us-ascii?q?75SIQ//zkphae2Wvq+MiPHlNz/AjJGHmr9EV/aZLNWmBh0nCDhd4oEWpTZgDpU?=
 =?us-ascii?q?KA4pvWj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ay+3NO6zngRVpGkycx/UqKrPwEr1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uEvBw8vrEoB1173LJYUkqKRYdcLy7VJVoOEmslqKdgrNxAV7BZniDhI?=
 =?us-ascii?q?LyFvAB0WKK+VSJJ8SUzIBgPMlbHJSWWOebMXFKyfvl4BSkH81l6vmrmZrY4Nvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,242,1635199200"; 
   d="scan'208";a="12835686"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:46:26 +0100
Date:   Tue, 28 Dec 2021 18:46:25 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Francisco Jerez <currojerez@riseup.net>,
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
In-Reply-To: <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:

> On Tue, Dec 28, 2021 at 5:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > I looked a bit more into why pstate 20 is always using the least energy. I
> > have just one thread spinning for 10 seconds, I use a fixed value for the
> > pstate, and I measure the energy usage with turbostat.
>
> How exactly do you fix the pstate?

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e7af18857371..19440b15454c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -400,7 +402,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;

 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), sg_cpu->max);
+				   sysctl_sched_fixedfreq, sg_cpu->max);

 	sg_cpu->sg_policy->last_freq_update_time = time;
 }

------------------------------

sysctl_sched_fixedfreq is a variable that I added to sysfs.


>
> > I tried this on a
> > 2-socket Intel 6130 and a 4-socket Intel 6130.  The experiment runs 40
> > times.
> >
> > There seem to be only two levels of CPU energy usage.  On the 2-socket
> > machine the energy usage is around 600J up to pstate 20 and around 1000J
> > after that.  On the 4-socket machine it is twice that.
>
> These are the package power numbers from turbostat, aren't they?

Yes.

julia
