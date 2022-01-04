Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B474484531
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiADPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:49:11 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62141
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230352AbiADPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:49:09 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AYUT76KpX7Pi54w4vrSRUHGaGhKteBmIOZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjZLDG7QP/yMYzbyc4t3O4rnpE4AvZLRx9FgTQBkpHthQiMRo?=
 =?us-ascii?q?6IpJ/zJdxaqZ3v6wu7rFR88sZ1GMrEsFC2FJ5Pljk/F3oPJ8D8shclkepKmULS?=
 =?us-ascii?q?eYnkpGVc+IMscoUkLd9AR09cAbeeRU1vlVePa+6UzCXf9s9JGGjp8B5Gr9HuDi?=
 =?us-ascii?q?M/PVAYw5TTSUxzkUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E/+wwvsjNj+?=
 =?us-ascii?q?luu6TnkwiQrfeJwmDjBK6WYDy314c9mpriP99baVHAatUo2zhc9RZyshJtJX2T?=
 =?us-ascii?q?Q42N6nIsOUbSRhRVS9kVUFD0OaZeSjh75b7I0ruNiGEL+9VJFs/M4QV/s50DHt?=
 =?us-ascii?q?I+PheLyoCBjiImvisx7C2UOR+rt4iN8T2JMUZt20I5SrDDPAnX5nYBb3D49NCw?=
 =?us-ascii?q?Sk5islmGffYetpfaDxzYRCGaBpKUn8TBZQ0tOSlnH/yd3tfsl39jbQ2+WXIzEp?=
 =?us-ascii?q?yzb3kKvLRe9qDX8ITmVyXzkrC/mLkElQCMfSBxjeftHGhnOnCmWX8Qo16PLm58?=
 =?us-ascii?q?ON6xV6e3GoeDDUIWlah5/q0kEizX5RYMUN80i8vq6c13FamQtn0Q1uzp3vslgY?=
 =?us-ascii?q?RR9dKAcU77g+Xw6bZ6grfAXILJhZDdcYn8ss7QTgr/kWEk9PgGXpkt7j9YWyc8?=
 =?us-ascii?q?LyZqy/0NjUUMXMFeQcATA0M+d6lp5s85i8j5P4L/LWd14KuX2iqmnbU/G5u2vM?=
 =?us-ascii?q?JgNBNzKuhu1bKn1qRSlHyZlZdzm3qsqiNt2uVvLKYWrE=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEiMVIqq3h3H7HEkOOnPxhSoaV5oLeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo7vxG88516faZslwssTIb6LK90dC7L080rKQV3WBzB8bAYOCFgh?=
 =?us-ascii?q?rPEGgK1+KLqAEIcBeTygcy78pdmudFebjN5PVB/KLHyRj9OewJhPOA9Lmshe/Y?=
 =?us-ascii?q?xXsodwd3cKtthj0YNu/eKDwQeDV7?=
X-IronPort-AV: E=Sophos;i="5.88,261,1635199200"; 
   d="scan'208";a="1608662"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:49:07 +0100
Date:   Tue, 4 Jan 2022 16:49:06 +0100 (CET)
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
In-Reply-To: <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2201041643520.3020@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com> <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
 <alpine.DEB.2.22.394.2201031922110.3020@hadrien> <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com> <alpine.DEB.2.22.394.2201032110590.3020@hadrien> <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the whole experiment again on an Intel w2155 (one socket, 10
physical cores, pstates 12, 33, and 45).

For the CPU there is a small jump a between 32 and 33 - less than for the
6130.

For the RAM, there is a big jump between 21 and 22.

Combining them leaves a big jump between 21 and 22.

It seems that the definition of efficient is that there is no more cost
for the computation than the cost of simply having the machine doing any
computation at all.  It doesn't take into account the time and energy
required to do some actual amount of work.

julia
