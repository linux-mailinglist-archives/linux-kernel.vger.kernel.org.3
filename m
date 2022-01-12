Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4524048BE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiALFg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:36:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232195AbiALFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:36:26 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C2pkbe024353;
        Wed, 12 Jan 2022 05:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4pQra9VPsb5+5MXeHj0uOPRIm1I6LaYKmWwauINLYwA=;
 b=ETIdmxlkDEIC1pFugfdKzSDMLORaTNhzXE8LFQFJ2cFdVqiHdjVNW3glLkFsI9cmPmTA
 ivbWeHZ6xSPNFzv0VZ6t+bwZaUSjXR+hL80pKFsAgTIKoL5+YCIgjm0pDvOmpqOEZFvU
 KI2exp6vmQboq4Uzlp/ADKz3s9eGHXE4sSoMbgNG5B5duWQttzhRqAjcgb+vGoMqM1wB
 9LBcqDIRh3qzQsUZSgUPyFRdyH1MoJWHZrBahOnj64CKzQ3UNzuKHmjaCQ9ujeg3AwUb
 av0EPqBQ0f0vag1vyPKqA0ESDrl/vJC158a6SyRwOgnQSfjNeli5g5ae5+mM8v+BxK+1 Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhdw0cqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:36:04 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20C5UflQ026007;
        Wed, 12 Jan 2022 05:36:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhdw0cqqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:36:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20C5WQM2002494;
        Wed, 12 Jan 2022 05:36:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3df289c5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 05:36:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20C5ZwYh47120774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:35:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA2C5A4053;
        Wed, 12 Jan 2022 05:35:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCF6FA4051;
        Wed, 12 Jan 2022 05:35:52 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.87.192])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 05:35:52 +0000 (GMT)
Subject: Re: [PATCH v4 01/48] libperf: Add comments to perf_cpu_map.
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-2-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <7344589b-1e17-ea8f-2d31-2905331fdcb3@linux.ibm.com>
Date:   Wed, 12 Jan 2022 11:05:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105061351.120843-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fs-4WJWdIysz3YAs8I9M3SLsZlQ36xC7
X-Proofpoint-ORIG-GUID: FoTGJ_wG6kgxzZVMoapiq1g472f3unke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 11:43 AM, Ian Rogers wrote:
> A particular observed problem is confusing the index with the CPU value,
> documentation should hopefully reduce this type of problem.
> 

Patch looks good.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/internal/cpumap.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 840d4032587b..4054169c12c5 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -4,9 +4,18 @@
>  
>  #include <linux/refcount.h>
>  
> +/**
> + * A sized, reference counted, sorted array of integers representing CPU
> + * numbers. This is commonly used to capture which CPUs a PMU is associated
> + * with. The indices into the cpumap are frequently used as they avoid having
> + * gaps if CPU numbers were used. For events associated with a pid, rather than
> + * a CPU, a single dummy map with an entry of -1 is used.
> + */
>  struct perf_cpu_map {
>  	refcount_t	refcnt;
> +	/** Length of the map array. */
>  	int		nr;
> +	/** The CPU values. */
>  	int		map[];
>  };
>  
> 
