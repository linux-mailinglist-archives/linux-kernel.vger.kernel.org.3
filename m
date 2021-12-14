Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D384473EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhLNIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:50:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhLNIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:50:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE7RMvO008810;
        Tue, 14 Dec 2021 08:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=BcpJ/UpqeJxNIiveNXiVlQEre/+90wWr4F5MRPHXDJY=;
 b=Ky5uk5Y6zntkdzwrpA5FLrpyAUgyNFuOxlMkaY8ptVdoW89pG1HmK7NnbhqEcRUJFsA+
 Aq9Ygw1DMkrY5aD88V9hO8yr1WTniXs8y8lztIgAPPdJsxTO21BfgTr8FaX0mHTKIk+W
 8iL/rqhxPgA+Fvhrl6DTSuXjr8eolUgKu+g2DvYALYxWcphSxqVjAHA9TlvBvs5k1gM1
 rJP8YnQ432BgK1Ofiv3mDPQiw/R5HD7JNb36AOEDZ00LsqYcxrI9SQ68x+sQc+tVIDMv
 9WRmsugZLP5cWKGrRf0GXkX7/j1D3m8AmuiTnIKqpjFaFoTosANmtdWGxwbXCYTqLTiL Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r959qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:50:44 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BE8d3SV009362;
        Tue, 14 Dec 2021 08:50:44 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r959pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:50:43 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BE8mImx010315;
        Tue, 14 Dec 2021 08:50:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3cvkma3a2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:50:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BE8ocVW23331222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 08:50:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B27D11C05C;
        Tue, 14 Dec 2021 08:50:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D58D11C050;
        Tue, 14 Dec 2021 08:50:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.58.61])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Dec 2021 08:50:31 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 0/3] Support register names of all architectures
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20211207180653.1147374-1-german.gomez@arm.com>
Date:   Tue, 14 Dec 2021 14:20:26 +0530
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAC4AC1D-A305-42E2-B22F-8B64B0968841@linux.vnet.ibm.com>
References: <20211207180653.1147374-1-german.gomez@arm.com>
To:     German Gomez <german.gomez@arm.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4pYMR2650eenVfoF_xsIo28t9GtHCBeW
X-Proofpoint-ORIG-GUID: -TQEdgAQJkuIRqdFhVg5trriuFWzZKJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_03,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 07-Dec-2021, at 11:36 PM, German Gomez <german.gomez@arm.com> =
wrote:
>=20
> The following changeset applies some corrections to the way system
> registers are processed and presented when reading perf.data files =
using
> the various perf tools.
>=20
> The commit message from [3/3] shows how register names aren't =
correctly
> presented when performing x-arch analysis of perf.data files =
(recording
> in one arch, then reading the file from a different arch).
>=20
>  - [PATCH 1/3] Fixes a potential out-of-bounds access when reading the
>    values of the registers in the perf.data file.
>  - [PATCH 2/3] Fixes an issue of ARM and ARM64 registers having the
>    same enum name.
>  - [PATCH 3/3] Refactors the function "perf_reg_name" declared in the
>   "tools/perf/util/perf_regs.h" header, in order to support every =
arch.
>=20
> Thanks,
> German

Looks good to me. Tested this patchset in powerpc by capturing regs in =
powerpc and doing
perf report to read the data from x86.

Reviewed-and-Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> --
> Changes since v1
>=20
>  - Added "Reported-by" tags.
>  - Removed [PATCH 2/4] because it's not needed (suggested by Athira
>    Rajeev).
>  - Removed [PATCH 3/4] which created additional header files with the
>    register names of every arch.
>  - Introduced [PATCH 2/3] to deal with ARM and ARM64 registers having =
the
>    same enum name across "/tools/perf/".
>  - Reworked the refactor of "perf_reg_name" function (now implemented =
in
>    perf_regs.c, rather than in the header file) in [PATCH 3/3].
>=20
> German Gomez (3):
>  perf tools: Prevent out-of-bounds access to registers
>  perf tools: Rename perf_event_arm_regs for ARM64 registers
>  perf tools: Support register names from all archs
>=20
> tools/perf/arch/arm/include/perf_regs.h       |  42 --
> tools/perf/arch/arm64/include/perf_regs.h     |  78 +-
> tools/perf/arch/csky/include/perf_regs.h      |  82 ---
> tools/perf/arch/mips/include/perf_regs.h      |  69 --
> tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
> tools/perf/arch/riscv/include/perf_regs.h     |  74 --
> tools/perf/arch/s390/include/perf_regs.h      |  78 --
> tools/perf/arch/x86/include/perf_regs.h       |  82 ---
> tools/perf/builtin-script.c                   |  18 +-
> tools/perf/util/event.h                       |   5 +-
> tools/perf/util/libunwind/arm64.c             |   2 +
> tools/perf/util/perf_regs.c                   | 671 +++++++++++++++++-
> tools/perf/util/perf_regs.h                   |  10 +-
> .../scripting-engines/trace-event-python.c    |  10 +-
> tools/perf/util/session.c                     |  25 +-
> 15 files changed, 709 insertions(+), 603 deletions(-)
>=20
> --=20
> 2.25.1
>=20

