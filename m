Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7248745E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiAGI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:58:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346266AbiAGI6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:58:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2078blLG013296;
        Fri, 7 Jan 2022 08:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oXCQfd4G/iTC0kL7PG2TR72N4GH+CGqN1sK2PO5maA4=;
 b=D+5P/ZGSyoi3qPYSV5EyGzW0qKo6ryygTzox/7qVNKhSLB1lrykaGTT0JoJOwFjIr6Pn
 OEjhEK2cN6QUuu/Y4jssOKdiS6t2/rajM/Jl2Ml06QNj7ldHkYteunRjf9mGGPsgLsCX
 xE2IEcGhrgxZqKuWCRIFrc5AlAObIn+/ON9uAVrAz6Q33NiR+zMfF//NjuL7gw4l3nWS
 6YO01Re/4JbeoaGU9ViUW2/HU0RrhK7DMA4B/POH5HBhQg0asjiOiu0j45Uq6+1dTgxU
 TZv96eciIPkOsnjKSjEV5BUz1qKE8i4mVFKFIm6PV1agU2Weex2nKm768tPQdszwWx8k sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3de4x350m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 08:58:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2078nE1P020440;
        Fri, 7 Jan 2022 08:58:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3de4x350kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 08:58:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2078qEpg027940;
        Fri, 7 Jan 2022 08:58:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3de5gfvgt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 08:58:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2078wevl28246344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jan 2022 08:58:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00BD0A4066;
        Fri,  7 Jan 2022 08:58:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0738A405C;
        Fri,  7 Jan 2022 08:58:38 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.61.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jan 2022 08:58:38 +0000 (GMT)
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220106091921.3fa617bc@canb.auug.org.au>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
Date:   Fri, 7 Jan 2022 14:28:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220106091921.3fa617bc@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GoUI2xrrQd_i_kr9YxZgHF4IHXHPjdbS
X-Proofpoint-GUID: hE6zumqYfke5FYWDYh6Ygh00xlRsjP2J
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_03,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/22 3:49 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from include/linux/perf_event.h:17,
>                  from arch/powerpc/perf/isa207-common.h:12,
>                  from arch/powerpc/perf/isa207-common.c:9:
> arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
> include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>       |           ^~~~~~~~~
> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>       |                    ^~~~~~~~~~
> arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>       |                                                   ^
> include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifier is reported only once for each function it appears in
>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>       |           ^~~~~~~~~
> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>       |                    ^~~~~~~~~~
> arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>       |                                                   ^
> include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>       |           ^~~~~~~~~
> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>       |                    ^~~~~~~~~~
> arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro 'P'
>   244 |     ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
>       |                                                   ^
> 
> Caused by commit
> 
>   af2b24f228a0 ("perf powerpc: Add data source encodings for power10 platform")
> 
> It looks like patch 1/4 of this series is missing ...

Hi Stephen,
     Yes you are right, original patch series contain 4 patches, where
1/4 patch contain kernel side changes for the same. Hence we are getting
this error, as that patch is missing in the Arnaldo tree.

Link to the patchset: https://lkml.org/lkml/2021/12/6/143

That kernel side patch is taken by Michael Ellermen via powerpc git.

Link to the patchset on powerpc/next:

[1/4] perf: Add new macros for mem_hops field
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=cb1c4aba055f928ffae0c868e8dfe08eeab302e7


[3/4] powerpc/perf: Add encodings to represent data based on newer
composite PERF_MEM_LVLNUM* fields
 https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=4a20ee106154ac1765dea97932faad29f0ba57fc

[4/4] powerpc/perf: Add data source encodings for power10 platform
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=6ed05a8efda56e5be11081954929421de19cce88

Thanks,
Kajol Jain

> 
> I have used the perf tree from next-20220105 for today.
> 
