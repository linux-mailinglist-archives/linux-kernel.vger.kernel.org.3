Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC146986B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhLFOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:20:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343490AbhLFOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:19:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Dr5YL014260;
        Mon, 6 Dec 2021 14:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=ks9/Z+hEHrZQibjyJ+Qq84WFQMYZw+5alOuj1RBthMA=;
 b=n6nBQoTIAQKn7o20lBIpmPoP55XSaRjzsV1GW+qiZtjZqjPZbgzucrdxoJfjCY/yfRe5
 IV1OQdshsNDM11Cchz9NJGm8x8TDCYEEdzrwQzJJQ4nZNYSvo3P5dUT8jdcr6aeIyrOb
 Lwa48UJs2EO9BQ5xTI18i3bCN5/62t3yh4RUCE+viJX7I3Ee0lohhXlGf6kh+n95lf//
 Eg8a5k624/m+9h5kwEvIgXTnOpzlMEIvQ0IGBAJmNq5B9/byy33v2ck8xVhZkGnDixU9
 YqMWAZERCBmWFM/MHaYbw9TLXf1L9G78JclZ3qU3Z5gwcD2Alm6e57kbygjX1myrta1o Tw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csksn8he7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:16:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6ED3h4014387;
        Mon, 6 Dec 2021 14:16:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3cqyyadrm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:16:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6EGDKe28901860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 14:16:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B1D642042;
        Mon,  6 Dec 2021 14:16:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68DE442045;
        Mon,  6 Dec 2021 14:16:10 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.77.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 14:16:09 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
Date:   Mon, 6 Dec 2021 19:46:05 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD96B8AC-CC0D-4DB2-A918-5905EC68F984@linux.vnet.ibm.com>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <CF175681-8101-43D1-ABDB-449E644BE986@fb.com>
To:     Song Liu <songliubraving@fb.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2GJbS9WqtjvU1RROgZXhPHsML4Ka2XvW
X-Proofpoint-GUID: 2GJbS9WqtjvU1RROgZXhPHsML4Ka2XvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 04-Dec-2021, at 1:02 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Dec 3, 2021, at 5:10 AM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>>=20
>> Hi Song,
>>=20
>> 	So I'm changing all my containers to build with BUILD_BPF_SKEL=3D1=

>> to then make this the default, so far older containers fail either
>> because the clang available is too old, so I've added a =
NO_BUILD_BPF_SKEL=3D1
>> env var to disable that in those containers and then there is this =
other
>> case where clang is recent enough but:
>>=20
>>   util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared =
identifier 'BPF_F_PRESERVE_ELEMS'
>>           __uint(map_flags, BPF_F_PRESERVE_ELEMS);
>>=20
>> Because the system's /usr/include/linux/bpf.h doesn't have that
>> BPF_F_PRESERVE_ELEMS enum entry.
>>=20
>> These are enums to make them available via BTF, but then I can't use
>> the:
>>=20
>> #ifdef BPF_F_PRESERVE_ELEMS
>> #define BPF_F_PRESERVE_ELEMS (1U << 11)
>> #endif
>>=20
>> approach.
>>=20
>> But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
>>=20
>> $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
>> 	BPF_F_PRESERVE_ELEMS	=3D (1U << 11),
>> $
>>=20
>> so we need to switch to using it somehow, this way we can build in =
more
>> systems and make bperf and other BPF enabled features.
>>=20
>> =46rom a quick look I couldn't find where to add
>> $(sourcedir)/tools/include/uapi/ to the include path used to build
>> util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a =
look?
>>=20
>> Thanks,
>>=20
>> - Arnaldo
>=20
> I think the following should fix it
>=20
> Thanks,
> Song
>=20

Hi,

Encountered this error while building perf with BUILD_BPF_SKEL.

util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared =
identifier 'BPF_F_PRESERVE_ELEMS'
        __uint(map_flags, BPF_F_PRESERVE_ELEMS);

And verified this patch fixes this issue.

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira=20
>=20
> diff --git i/tools/perf/util/bpf_skel/bperf_follower.bpf.c =
w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index b8fa3cb2da230..4a6acfde14937 100644
> --- i/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "bperf.h"
> diff --git i/tools/perf/util/bpf_skel/bperf_leader.bpf.c =
w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> index 4f70d1459e86c..40d962b058634 100644
> --- i/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "bperf.h"
> diff --git i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c =
w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> index ab12b4c4ece21..97037d3b3d9fa 100644
> --- i/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> +++ w/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -1,6 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2020 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>=20
>=20

