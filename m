Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357F24834FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiACQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:42:11 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26045
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbiACQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:42:10 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ab9WNrqmLRWATAXpgbqCKzBbo5gyXJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzYAmjdMXD2Bb6uLZDTzKdska4yy/RgCvsCGnNExSAVl+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuCmULe?=
 =?us-ascii?q?cYXgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfQboOOXfiLXXcu7iheun2HX6+9nAkg7OaUb9/xxDGU?=
 =?us-ascii?q?I8uYXQBgGcwqZgOC72r+pYvNtnck+NI/tMZ93kmp6zDfYE/89B4jKRanQ+MFR0?=
 =?us-ascii?q?D4YgsFIAOaYZswFZD4pZxPFCzVLN1EdIJEzhuGlgj/4aTIwgEyUv6cs4y7Q0Ql?=
 =?us-ascii?q?4ypDpMdzcYNvMQt9a9m6cp2Tb7yHhBzkEO9GFjzmI6HShgqnIhyyTcIYTEqCos?=
 =?us-ascii?q?/1nmluewkQNBxAME1i2u/+0jgi5Qd03A0kV/CUphbI/+EyiUp/2WBjQiGaJohM?=
 =?us-ascii?q?GSfJRFeMg4Q2Aw6aS5ByWbkAGUyRALtgrsMs3bSYn2l+Ag5XiAjkHmKOUT3mQ8?=
 =?us-ascii?q?KvSoi6zJTQSMUcGZCkNVwxD5MPsyLzfJDqnos1LSfHuyISvQHeuk3ba8W4kiqt?=
 =?us-ascii?q?VlsARkaO24Tj6b/uXjsChZmYICs//DwpJNj9EWbM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGTlRT6nMEW3gu1ahhBdwY1l1gdLpDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzuiWetN98YhsdcJW7WZVoIkmskKKdg7NwAV7KZmCPhI?=
 =?us-ascii?q?LrFvAA0WKI+VPd8kPFmtK1mZ0QEZRWOZnASWJ3isv3+2CDfuoIytPvys+Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,258,1635199200"; 
   d="scan'208";a="1504872"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 17:41:53 +0100
Date:   Mon, 3 Jan 2022 17:41:51 +0100 (CET)
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
In-Reply-To: <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2201031741290.3020@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net> <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com> <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Can you please run the 32 spinning threads workload (ie. on one
> > > package) and with P-state locked to 10 and then to 20 under turbostat
> > > and send me the turbostat output for both runs?
> >
> > Attached.
> >
> > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
> > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
>
> Well, in  both cases there is only 1 CPU running and it is running at
> 1 GHz (ie. P-state 10) all the time as far as I can say.

Indeed.  I'll check on that.

julia
