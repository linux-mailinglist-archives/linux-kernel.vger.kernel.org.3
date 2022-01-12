Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0816B48BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349294AbiALFam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:30:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232195AbiALFal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:30:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C53dgg025743;
        Wed, 12 Jan 2022 05:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8nEmyHp9GXz1TOhMwINYuwkNKhYwXtaCSLwvFo/JQxo=;
 b=kmSSZw/U9hgNEB66zL7hOL72XikDxU5zj9dIPnmcjZRJD8E6e/B+EY0gELgsuse5lD5S
 dFubo3NzJCZOPemU1Jo3XJQ1Hco57I6SWMX4sr1aH8+IoF3cMOUSw33hYnCw3P/16iwJ
 0Co5pxFJ3DgLJXD7qz77wb+Cfdl7FZdkGDjnKDm1HlLxiW3HY2nAFZsKR6qz6nBp3EXY
 hVCseEFGEf2snO4XGFKEuYqcqY0QX6Jt6QUVJAzaoDYNKyc4LPU0bmV87IhJ1WecEfC7
 b5dFwyDzIvLSWuYfUInWOmEFEbJo8Hb46Y1rFPqnlH4oq24yo3DY7LK2xmoA+jymr0kI Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhdw0cmyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:30:22 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20C58864013544;
        Wed, 12 Jan 2022 05:30:21 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhdw0cmy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:30:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20C5JPSv012633;
        Wed, 12 Jan 2022 05:30:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3df289m4xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:30:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20C5UHYm44368294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:30:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C81DA4055;
        Wed, 12 Jan 2022 05:30:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBD50A4053;
        Wed, 12 Jan 2022 05:30:15 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.87.192])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 05:30:15 +0000 (GMT)
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220106091921.3fa617bc@canb.auug.org.au>
 <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
 <20220112084553.2aa71f08@canb.auug.org.au> <Yd3+M+efH6bTEpP9@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <e45867ca-1dfe-4979-59dd-cc201ecef4c6@linux.ibm.com>
Date:   Wed, 12 Jan 2022 11:00:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Yd3+M+efH6bTEpP9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BnBdtqPtuzGtAV2vyQ4ea6eMq_66h3O6
X-Proofpoint-ORIG-GUID: CiNxIruNn5MyGH18YnbRc-UwtBG1W5xA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 3:31 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 12, 2022 at 08:45:53AM +1100, Stephen Rothwell escreveu:
>> Hi all,
>>
>> On Fri, 7 Jan 2022 14:28:37 +0530 kajoljain <kjain@linux.ibm.com> wrote:
>>>
>>> On 1/6/22 3:49 AM, Stephen Rothwell wrote:
>>>>
>>>> After merging the perf tree, today's linux-next build (powerpc
>>>> ppc64_defconfig) failed like this:
>>>>
>>>> In file included from include/linux/perf_event.h:17,
>>>>                  from arch/powerpc/perf/isa207-common.h:12,
>>>>                  from arch/powerpc/perf/isa207-common.c:9:
>>>> arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
>>>> include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>>>>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>>>>       |           ^~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>>>>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>>>>       |                    ^~~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>>>>   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>>>>       |                                                   ^
>>>> include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifier is reported only once for each function it appears in
>>>>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>>>>       |           ^~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>>>>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>>>>       |                    ^~~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>>>>   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>>>>       |                                                   ^
>>>> include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>>>>  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>>>>       |           ^~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>>>>   273 | #define P(a, b)    PERF_MEM_S(a, b)
>>>>       |                    ^~~~~~~~~~
>>>> arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro 'P'
>>>>   244 |     ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
>>>>       |                                                   ^
>>>>
>>>> Caused by commit
>>>>
>>>>   af2b24f228a0 ("perf powerpc: Add data source encodings for power10 platform")
>>>>
>>>> It looks like patch 1/4 of this series is missing ...  
>>>
>>> Hi Stephen,
>>>      Yes you are right, original patch series contain 4 patches, where
>>> 1/4 patch contain kernel side changes for the same. Hence we are getting
>>> this error, as that patch is missing in the Arnaldo tree.
>>>
>>> Link to the patchset: https://lkml.org/lkml/2021/12/6/143
>>>
>>> That kernel side patch is taken by Michael Ellermen via powerpc git.
>>>
>>> Link to the patchset on powerpc/next:
>>>
>>> [1/4] perf: Add new macros for mem_hops field
>>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=cb1c4aba055f928ffae0c868e8dfe08eeab302e7
>>>
>>>
>>> [3/4] powerpc/perf: Add encodings to represent data based on newer
>>> composite PERF_MEM_LVLNUM* fields
>>>  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=4a20ee106154ac1765dea97932faad29f0ba57fc
>>>
>>> [4/4] powerpc/perf: Add data source encodings for power10 platform
>>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=6ed05a8efda56e5be11081954929421de19cce88
>>>
>>> Thanks,
>>> Kajol Jain
>>>
>>>>
>>>> I have used the perf tree from next-20220105 for today.
>>>>   
>>
>> I am still getting this build failure.
> 
> Yeah, this patch shouldn't have been merged thru the perf _tools_ tree,
> my bad, it should have gone thru Michael PPC kernel tree.
> 
> It was a single series mixing up tools/ with kernel bits, I thought I
> had picked just the tools part but made a mistake.
> 
> This should get resolved when the rest of the kernel bits go via
> Michael's powerpc tree, right?
> 
> - Arnaldo

Yes Arnaldo,
      Michael already pulled kernel and power side patches for that
patchset. Only patch 2 of that patchset had tools side changes i.e;

[PATCH 2/4]tools/perf: Add new macros for mem_hops field
Link to the patch: https://lkml.org/lkml/2021/12/6/145

So, we will not get this error once kernel side changes are in via
Michael's powerpc tree.

Thanks,
Kajol Jain
> 
