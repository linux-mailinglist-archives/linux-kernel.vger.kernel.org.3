Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EB480BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhL1Q62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:58:28 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3847 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236452AbhL1Q61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:27 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Agmw6+akjfG0tLtdH22WVwfHo5gyQJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzMDm2JMW2yFa/2NNmbyKt5yao6y9RhSscfUndIxQARt+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?eangrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfQcqOSdfSDv2SCU5wicG5f2+N1lEVssOo8V4OtlKXt?=
 =?us-ascii?q?P7vEFMHYLYwzrr/i/zru2TsFvi94lIc2tO5kQ0ll71zDfDOgvWtbbSqPG/8JG1?=
 =?us-ascii?q?Ts5rsRPG+vOIcsfdTdrKh/HZnVnPloRAro9kf2ui325dCdXwHqLpLA6+GiVzxF?=
 =?us-ascii?q?02aLFNNvTc8aNA8JPkS6womPA4nS8GhQyKtOS03yG/2iqi+uJmjn0MKoWFbul5?=
 =?us-ascii?q?rtpjUeVy2g7FhIbTx24rOO/h0r4XMhQQ2QR+ywhqoAo+UCrR8W7VBq9yFacswI?=
 =?us-ascii?q?RQch4Eus08giBx6PYpQGDCQAsTCNbaZoiucsyRBQw21OJls+vDjtq2JWLSHSW+?=
 =?us-ascii?q?7GI6zyvODQJKnMqYS4CRBECpd75r+kOYrjnJjp4OPfq1ZusQ2i2nWDM/HV4nbg?=
 =?us-ascii?q?Ny9UFzeO98Eyvvt5lnbCRJiZd2+kddjvNAttFWbOY?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/ULs8aBoCty/i7vlHemr55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9HfbyqynDpp4mPFrP6Qr5O0tQ/OxoWpPhfZq0z/cc3WBSB8bAYOCMgg?=
 =?us-ascii?q?WVxe9ZgbcKjweQeRHWx6ptkZ1tdKVzE7TLYGRSh8yS2maFL+o=3D?=
X-IronPort-AV: E=Sophos;i="5.88,242,1635199200"; 
   d="scan'208";a="12832408"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 17:58:24 +0100
Date:   Tue, 28 Dec 2021 17:58:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Francisco Jerez <currojerez@riseup.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
In-Reply-To: <878rwdse9o.fsf@riseup.net>
Message-ID: <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I looked a bit more into why pstate 20 is always using the least energy. I
have just one thread spinning for 10 seconds, I use a fixed value for the
pstate, and I measure the energy usage with turbostat. I tried this on a
2-socket Intel 6130 and a 4-socket Intel 6130.  The experiment runs 40
times.

There seem to be only two levels of CPU energy usage.  On the 2-socket
machine the energy usage is around 600J up to pstate 20 and around 1000J
after that.  On the 4-socket machine it is twice that.

The change in RAM energy usage is similar, eg around 320J for the 2-socket
machine up to pstate 20, and around 460J for higher pstates.

On the 6130, pstate 21 is 2.1GHz, which is the nominal frequency of the
machine.  So it seems that the most efficient thing is to be just below
that.  The reduced execution time with pstate 20 as compared to pstate 10
greatly outweighs any small increase in the energy usage due to changing
the frequency.

Perhaps there is something abnormal in how the machines are configured?

julia
