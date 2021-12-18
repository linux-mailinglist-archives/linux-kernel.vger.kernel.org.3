Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196AE479A84
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhLRLID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:08:03 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16387 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhLRLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:07:57 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AOlG5sq1gkA4btjrHY/bD5cJwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJh28q32AHnzEdDWjXM/yLamf3etBxaNyw900OvcWDndA2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4Ef9WlTdhSMkj/jRHOOsULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?lm7rhc0AMKlLQFVjTzCQGHfH4214b+XdaPqUTbZLwbW9VljGIlpZ1wcpEsZiYS?=
 =?us-ascii?q?AEzP6SKlv51vxxwSnghZPUco+evzX+X9Jb7I1f9W3Dx2e9pDkwsMJ8w4OdsDHx?=
 =?us-ascii?q?Ws/oVNFgldBmNju+y6LG2UO9hgoIkNsaDFJgFu3dh0zjCS+4vR5zZXrvD6dZw2?=
 =?us-ascii?q?DY2m9AIHPDCas5fYj1qBDzEbhtFElQaEpQzmKGvnHaXWyNZsl+Opew0/m3a1iR?=
 =?us-ascii?q?10b7kKt2TfcaFLe1Rn0CFtife+kznDRwAct+S0zyI9jSrnOCntSf6Xp8CUb617?=
 =?us-ascii?q?PhnhHWNyWEJTh4bT122pb++kEHWc9deLUMT0jAjoag76AqgSdyVdwW1vHOerDY?=
 =?us-ascii?q?dXdRKGuE34Q3LzbDbiy6bG3IFCDpMbNgnnNU7STwjyhmCmNaBLSJutraYT27b+?=
 =?us-ascii?q?aqVsS+1JQARLGkLfyhCShEKi+QPCqlbYgnnF4k4Vvfv15urSXegnnaQoTZ4nLs?=
 =?us-ascii?q?Jy8gGy82GEZn8q2rEjvD0osQdv207hl6Y0z4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALt6m16ioC05yZ3Cnhkik4G6kmXBQXt4ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4ra2TdZEgvnXJYVkqKRQdcK+7Sc69qB/nlKKdmLN+AV7AZniDhI?=
 =?us-ascii?q?LLFvAB0WK4+VHd8kTFn4ZgPMxbAstD4bPLbWSTfK7BjzVQGuxQpuW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,216,1635199200"; 
   d="scan'208";a="11710230"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 12:07:55 +0100
Date:   Sat, 18 Dec 2021 12:07:55 +0100 (CET)
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
In-Reply-To: <878rwitdu3.fsf@riseup.net>
Message-ID: <alpine.DEB.2.22.394.2112181138210.3130@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Dec 2021, Francisco Jerez wrote:

> Julia Lawall <julia.lawall@inria.fr> writes:
>
> >> As you can see in intel_pstate.c, min_pstate is initialized on core
> >> platforms from MSR_PLATFORM_INFO[47:40], which is "Maximum Efficiency
> >> Ratio (R/O)".  However that seems to deviate massively from the most
> >> efficient ratio on your system, which may indicate a firmware bug, some
> >> sort of clock gating problem, or an issue with the way that
> >> intel_pstate.c processes this information.
> >
> > I'm not sure to understand the bug part.  min_pstate gives the frequency
> > that I find as the minimum frequency when I look for the specifications of
> > the CPU.  Should one expect that it should be something different?
> >
>
> I'd expect the minimum frequency on your processor specification to
> roughly match the "Maximum Efficiency Ratio (R/O)" value from that MSR,
> since there's little reason to claim your processor can be clocked down
> to a frequency which is inherently inefficient /and/ slower than the
> maximum efficiency ratio -- In fact they both seem to match in your
> system, they're just nowhere close to the frequency which is actually
> most efficient, which smells like a bug, like your processor
> misreporting what the most efficient frequency is, or it deviating from
> the expected one due to your CPU static power consumption being greater
> than it would be expected to be under ideal conditions -- E.g. due to
> some sort of clock gating issue, possibly due to a software bug, or due
> to our scheduling of such workloads with a large amount of lightly
> loaded threads being unnecessarily inefficient which could also be
> preventing most of your CPU cores from ever being clock-gated even
> though your processor may be sitting idle for a large fraction of their
> runtime.

The original mail has results from two different machines: Intel 6130
(skylake) and Intel 5218 (cascade lake).  I have access to another cluster
of 6130s and 5218s.  I can try them.

I tried 5.9 in which I just commented out the schedutil code to make
frequency requests.  I only tested avrora (tiny pauses) and h2 (longer
pauses) and in both case the execution is almost entirely in the turbo
frequencies.

I'm not sure to understand the term "clock-gated".  What C state does that
correspond to?  The turbostat output for one run of avrora is below.

julia

78.062895 sec
Package	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	C1	C1E	C6	POLL%	C1%	C1E%	C6%	CPU%c1	CPU%c6	CoreTmp	PkgTmp	Pkg%pc2	Pkg%pc6	Pkg_J	RAM_J	PKG_%	RAM_%
-	-	-	31	2.95	1065	2096	156134	0	1971	155458	2956270	657130	0.00	0.20	4.78	92.26	14.75	82.31	40	41	45.14	0.04	4747.52	2509.05	0.00	0.00
0	0	0	13	1.15	1132	2095	11360	0	0	2	39	19209	0.00	0.00	0.01	99.01	8.02	90.83	39	41	90.24	0.04	2266.04	1346.09	0.00	0.00
0	0	32	1	0.09	1001	2095	37	0	0	0	0	42	0.00	0.00	0.00	100.00	9.08
0	1	4	0	0.04	1000	2095	57	0	0	0	1	133	0.00	0.00	0.00	99.96	0.08	99.88	38
0	1	36	0	0.00	1000	2095	35	0	0	0	0	40	0.00	0.00	0.00	100.00	0.12
0	2	8	0	0.03	1000	2095	64	0	0	0	1	124	0.00	0.00	0.00	99.97	0.08	99.89	38
0	2	40	0	0.00	1000	2095	36	0	0	0	0	40	0.00	0.00	0.00	100.00	0.10
0	3	12	0	0.00	1000	2095	42	0	0	0	0	71	0.00	0.00	0.00	100.00	0.14	99.86	38
0	3	44	1	0.09	1000	2095	63	0	0	0	0	65	0.00	0.00	0.00	99.91	0.05
0	4	14	0	0.00	1010	2095	38	0	0	0	1	41	0.00	0.00	0.00	100.00	0.04	99.96	39
0	4	46	0	0.00	1011	2095	36	0	0	0	1	41	0.00	0.00	0.00	100.00	0.04
0	5	10	0	0.01	1084	2095	39	0	0	0	0	58	0.00	0.00	0.00	99.99	0.04	99.95	38
0	5	42	0	0.00	1114	2095	35	0	0	0	0	39	0.00	0.00	0.00	100.00	0.05
0	6	6	0	0.03	1005	2095	89	0	0	0	1	116	0.00	0.00	0.00	99.97	0.07	99.90	39
0	6	38	0	0.00	1000	2095	38	0	0	0	0	41	0.00	0.00	0.00	100.00	0.10
0	7	2	0	0.05	1001	2095	59	0	0	0	1	133	0.00	0.00	0.00	99.95	0.09	99.86	40
0	7	34	0	0.00	1000	2095	39	0	0	0	0	65	0.00	0.00	0.00	100.00	0.13
0	8	16	0	0.00	1000	2095	43	0	0	0	0	47	0.00	0.00	0.00	100.00	0.04	99.96	38
0	8	48	0	0.00	1000	2095	37	0	0	0	0	41	0.00	0.00	0.00	100.00	0.04
0	9	20	0	0.00	1000	2095	33	0	0	0	0	37	0.00	0.00	0.00	100.00	0.03	99.97	38
0	9	52	0	0.00	1000	2095	33	0	0	0	0	36	0.00	0.00	0.00	100.00	0.03
0	10	24	0	0.00	1000	2095	36	0	0	0	1	40	0.00	0.00	0.00	100.00	0.03	99.96	39
0	10	56	0	0.00	1000	2095	37	0	0	0	1	38	0.00	0.00	0.00	100.00	0.03
0	11	28	0	0.00	1002	2095	35	0	0	0	1	37	0.00	0.00	0.00	100.00	0.03	99.97	38
0	11	60	0	0.00	1004	2095	34	0	0	0	0	36	0.00	0.00	0.00	100.00	0.03
0	12	30	0	0.00	1001	2095	35	0	0	0	0	40	0.00	0.00	0.00	100.00	0.11	99.88	38
0	12	62	0	0.01	1000	2095	197	0	0	0	0	197	0.00	0.00	0.00	99.99	0.10
0	13	26	0	0.00	1000	2095	37	0	0	0	0	41	0.00	0.00	0.00	100.00	0.03	99.97	39
0	13	58	0	0.00	1000	2095	38	0	0	0	0	40	0.00	0.00	0.00	100.00	0.03
0	14	22	0	0.01	1000	2095	149	0	1	2	0	142	0.00	0.01	0.00	99.99	0.07	99.92	39
0	14	54	0	0.00	1000	2095	35	0	0	0	0	38	0.00	0.00	0.00	100.00	0.07
0	15	18	0	0.00	1000	2095	33	0	0	0	0	36	0.00	0.00	0.00	100.00	0.03	99.97	39
0	15	50	0	0.00	1000	2095	34	0	0	0	0	38	0.00	0.00	0.00	100.00	0.03
1	0	1	32	3.23	1008	2095	2385	0	31	3190	45025	10144	0.00	0.28	4.68	91.99	11.21	85.56	32	35	0.04	0.04	2481.49	1162.96	0.00	0.00
1	0	33	9	0.63	1404	2095	12206	0	5	162	2480	10283	0.00	0.04	0.75	98.64	13.81
1	1	5	1	0.07	1384	2095	236	0	0	38	24	314	0.00	0.09	0.06	99.77	4.66	95.27	33
1	1	37	81	3.93	2060	2095	1254	0	5	40	59	683	0.00	0.01	0.02	96.05	0.80
1	2	9	37	3.46	1067	2095	2396	0	29	2256	55406	11731	0.00	0.17	6.02	90.54	54.10	42.44	31
1	2	41	151	14.51	1042	2095	10447	0	135	10494	248077	42327	0.01	0.87	26.57	58.84	43.05
1	3	13	110	10.47	1053	2095	7120	0	120	9218	168938	33884	0.01	0.77	16.63	72.68	42.58	46.95	32
1	3	45	69	6.76	1021	2095	4730	0	66	5598	115410	23447	0.00	0.44	12.06	81.12	46.29
1	4	15	112	10.64	1056	2095	7204	0	116	8831	171423	37754	0.01	0.70	17.56	71.67	28.01	61.35	33
1	4	47	18	1.80	1006	2095	1771	0	13	915	29315	6564	0.00	0.07	3.20	95.03	36.85
1	5	11	63	5.96	1065	2095	4090	0	58	6449	99015	18955	0.00	0.45	10.27	83.64	31.24	62.80	31
1	5	43	72	7.11	1016	2095	4794	0	73	6203	115361	26494	0.00	0.48	11.79	81.02	30.09
1	6	7	35	3.39	1022	2095	2328	0	45	3377	52721	13759	0.00	0.27	5.10	91.43	25.84	70.77	32
1	6	39	67	6.09	1096	2095	4483	0	52	3696	94964	19366	0.00	0.30	10.32	83.61	23.14
1	7	3	1	0.06	1395	2095	91	0	0	0	1	167	0.00	0.00	0.00	99.95	25.36	74.58	35
1	7	35	83	8.16	1024	2095	5785	0	100	7398	134640	27428	0.00	0.56	13.39	78.34	17.26
1	8	17	46	4.49	1016	2095	3229	0	52	3048	74914	16010	0.00	0.27	8.29	87.19	29.71	65.80	33
1	8	49	64	6.12	1052	2095	4210	0	89	5782	100570	21463	0.00	0.42	10.63	83.17	28.08
1	9	21	73	7.02	1036	2095	4917	0	64	5786	109887	21939	0.00	0.55	11.61	81.18	22.10	70.88	33
1	9	53	64	6.33	1012	2095	4074	0	69	5957	97596	20580	0.00	0.51	9.78	83.74	22.79
1	10	25	26	2.58	1013	2095	1825	0	22	2124	42630	8627	0.00	0.17	4.17	93.24	53.91	43.52	33
1	10	57	159	15.59	1022	2095	10951	0	175	14237	256828	56810	0.01	1.10	26.00	58.16	40.89
1	11	29	112	10.54	1065	2095	7462	0	126	9548	179206	39821	0.01	0.85	18.49	70.71	29.46	60.00	31
1	11	61	29	2.89	1011	2095	2002	0	24	2468	45558	10288	0.00	0.20	4.71	92.36	37.11
1	12	31	37	3.66	1011	2095	2596	0	79	3161	61027	13292	0.00	0.24	6.48	89.79	23.75	72.59	32
1	12	63	56	5.08	1107	2095	3789	0	62	4777	79133	17089	0.00	0.41	7.91	86.86	22.31
1	13	27	12	1.14	1045	2095	1477	0	16	888	18744	3250	0.00	0.06	2.18	96.70	21.23	77.64	32
1	13	59	60	5.81	1038	2095	5230	0	60	4936	87225	21402	0.00	0.41	8.95	85.14	16.55
1	14	23	28	2.75	1024	2095	2008	0	20	1839	47417	9177	0.00	0.13	5.08	92.21	34.18	63.07	32
1	14	55	106	9.58	1105	2095	6292	0	89	7182	141379	31354	0.00	0.63	14.45	75.81	27.36
1	15	19	118	11.65	1012	2095	7872	0	121	10014	193186	40448	0.01	0.80	19.53	68.68	37.53	50.82	32
1	15	51	59	5.58	1059	2095	3967	0	54	5842	88063	21138	0.00	0.39	9.12	85.23	43.60
