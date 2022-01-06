Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0903B486CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiAFV6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:58:34 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:6406 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244452AbiAFV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:58:33 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A4pmjAa7dpiWGzQaQOcLcDQxRtCnGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0jAEn2UWWmGCafeDZWvzKNxyati0oE8Hu5XRxoRhTwQ5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOixxZVA/fvQHOCkUba?=
 =?us-ascii?q?aYnoZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk577e0EQQ7PUVeSMoioLHfbyxEEY/2prjf1T2Pk0MC+7jx2LgtRwwZNJvIO5T?=
 =?us-ascii?q?QMBP6vWme1bXQMw/yRWZPEeqeGefCjXXcu7iheun2HX6+50DUc3I4QDvP5+B21?=
 =?us-ascii?q?U6OIRJDklahGFmvLwwbSnR+0qjcMmROHgIZkFvXNt1zzLJewnWp3eW+PM6MMw9?=
 =?us-ascii?q?C05iMlDGd7datAfZD4paw7PCzVLN1EdIJEzhuGlgj/4aTIwgEyUv6cs4y7Q0Ql?=
 =?us-ascii?q?4ypDpMdzcYNvMQt9a9m6cp2Tb7yHhBzkEO9GFjzmI6HShgqnIhyyTcIYTEqCos?=
 =?us-ascii?q?/1nmluewkQNBxAME1i2u/+0jgi5Qd03A0kV/CUphbI/+EyiUp/2WBjQiGaJohM?=
 =?us-ascii?q?GSfJRFeMg4Q2Aw6aS5ByWbkAGUyRALtgrsMs3bSYn2l+Ag5XiAjkHmKOUT3mQ8?=
 =?us-ascii?q?KvSoi6zJTQSMUcGZCkNVwxD5MPsyLzfJDqnos1LSfHuyISvQHeuk3ba8W4kiqt?=
 =?us-ascii?q?VlsARkaO24Tj6b/uXjsChZmYICs//BwpJNj9EWbM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Apm75iqrGaGOg290oRao8Q90aV5oseYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG885x6faZslwssTQb+OxoW5PwJE80l6QU3WB5B97LYOClgh?=
 =?us-ascii?q?rKEGgI1+XfKlPbdxEWutQtt5tIQuxOTOf9ClV3lq/BjTWQGdxI+ra6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,267,1635199200"; 
   d="scan'208";a="14096158"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 22:58:32 +0100
Date:   Thu, 6 Jan 2022 22:58:31 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
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
In-Reply-To: <a14c639df462ead1cca4da20203eb1283f4d6cb5.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2201062258090.3098@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>   <alpine.DEB.2.22.394.2112291012030.24929@hadrien>   <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>   <alpine.DEB.2.22.394.2112301840360.15550@hadrien>  
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>   <alpine.DEB.2.22.394.2112301919240.15550@hadrien>   <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>   <alpine.DEB.2.22.394.2112301942360.15550@hadrien>  
 <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>   <alpine.DEB.2.22.394.2201031922110.3020@hadrien>   <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>   <alpine.DEB.2.22.394.2201032110590.3020@hadrien>  
 <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>   <alpine.DEB.2.22.394.2201041643520.3020@hadrien>   <CAJZ5v0i9Rh0Cm3Mbu3N8w6UmgJEnmThk4znWVcp9qeroabjsNw@mail.gmail.com>   <alpine.DEB.2.22.394.2201052107280.48852@hadrien>  
 <87a6g9rbje.fsf@riseup.net>  <alpine.DEB.2.22.394.2201062044340.3098@hadrien>  <1b2be990d5c31f62d9ce33aa2eb2530708d5607a.camel@linux.intel.com>  <alpine.DEB.2.22.394.2201062141290.3098@hadrien>
 <a14c639df462ead1cca4da20203eb1283f4d6cb5.camel@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-486851-1641506311=:3098"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-486851-1641506311=:3098
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 6 Jan 2022, srinivas pandruvada wrote:

> On Thu, 2022-01-06 at 21:43 +0100, Julia Lawall wrote:
> > > > All the turbostat output and graphs I have sent recently were
> > > > just
> > > > for
> > > > continuous spinning:
> > > >
> > > > for(;;);
> > > >
> > > > Now I am trying running for the percentage of the time
> > > > corresponding
> > > > to
> > > > 10 / P for pstate P (ie 0.5 of the time for pstate 20), and then
> > > > sleeping,
> > > > to see whether one can just add the sleeping power consumption of
> > > > the
> > > > machine to compute the efficiency as Rafael suggested.
> > > >
> > > Before doing comparison try freezing uncore.
> > >
> > > wrmsr -a 0x620 0x0808
> > >
> > > to Freeze uncore at 800MHz. Any other value is fine.
> >
> > Thanks for the suggestion.  What is the impact of this?
> Uncore scales based on its own heuristics based in P-state change and
> works in package scope. So to actually see the effect of P-state change
> on energy you can remove variability of uncore power.

OK, thanks.  I will try both options.

julia
--8323329-486851-1641506311=:3098--
