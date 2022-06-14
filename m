Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5754AE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351380AbiFNKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355601AbiFNKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:33:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9033C48398
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:33:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E8sDcq019925;
        Tue, 14 Jun 2022 10:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7xILD+n8YxdsU9EGjnQ3P7JhzAeR9FfG24tZCebSsgg=;
 b=HZFBsAEPoJAmnggps3xRTRsFPLCOi7r3HSbfZ2EH97W3HST3+lT3ZSJKfg6snw8v9LNL
 Hz6nW2JqvF1zLhgtfx8l2Kfmjl+8fZsR31u0wXX2YA4GkYEOxtZGqtek6mCtjWE5IcjD
 RoO8I51WGr8Wj58Od4v2NIGVd/sQYzyyAQJRlj3mCsa8LXLZZIIgz5PnpPIfpWGoww4y
 mqT8OylyTfpt2JYnxl+/5aUEG3F0as1g4TdHAQmTgEzA0rlVr8wa8gFJ6FLrlcjb6tR9
 sSVYaTeR3Ba1/YDQoT/JxGHX1M/MExS5h0q3B0nAqAdJyBT9x/CxuL3yku2fUtIyQq1J gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9dch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:33:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EAQLiO024351;
        Tue, 14 Jun 2022 10:33:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq01qpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g81DJs52kHh1/NfpftUwgIa09ZN1r2lqx47IlF0wK++fwcUvpxkHDlxR2xWubuy8cV/lQ+ykfVIx8F5+qKFV5S4mZ1WBhQSAXJ1r9HHMEXtS6GoJ7TyoWyQw44FZjlWdoYnIqGS2Yuws4MYs98L1/7cqKIrSj7+YZnqcEYbFfUhW5vkfghAN3x9c9iEAhw5hF7stv9gh/AZvQoIM9vmeA0tMRFAUXEA4jNfPAAEgHEue6ZEokvqQ29vZfiEDZBxXFWc2LzDdnilz1qOZe60DdJq+n2rzuOqBZ3yme5NeDx+mChcHmue2X1pU/K9/83WeXVtTgDzpF4wupUv0lsmH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xILD+n8YxdsU9EGjnQ3P7JhzAeR9FfG24tZCebSsgg=;
 b=OsWujJfVmluB/c6Ft6hSEwXUbjzU9hWsh1CPIyoCDr2prrHvkL/KPG5ZVMvNmDwNHHqy7/xIyfwVI2ljVneXfG25w7aUUuhuWKu/67wm8Y+PZ0ac5yINlGRHNn8w8CCq2NlJLRHi01FZJb9TNFbmgz15oV3GTDaobD+bI0QUFOWbdMrXdMmC7ft1FoWEBKmxSoLW/lzD06/l6eoXyhjXzKu2luD/7jJ1UIG85BwdWZjW+pbD4ryuWKOvWqjEdgfjDNZzc70njW0mjipSgyY6LWfqqJPN+qz05Qf2zJ409o5ZfFisCButIYxZWiiyb2afhGc1Za0MilZUfl0pBdI6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xILD+n8YxdsU9EGjnQ3P7JhzAeR9FfG24tZCebSsgg=;
 b=EaMkeR/sR+tAYSqIUfmbUl5HAsF/YhitP5EK/3z9JGsbKdBTNnU3S9VVUM2ewvqHIJ9v2Is302zo6mLHO0E3jl4lRaY1DeZQVGy5Bb4oUNY/tYUqTbyGNOaKTLJtN+m28WxCmsGNZv7PXYeGJ/eIYmYSHcnFXM8NYPmoYKV6gNo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 10:33:15 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e%7]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 10:33:15 +0000
Message-ID: <fdec491a-5dfd-6c9c-c961-18dcd9d0b3bb@oracle.com>
Date:   Tue, 14 Jun 2022 11:33:10 +0100
Subject: Re: [PATCH] mm: Remove unwanted initialization in
 vmemmap_populate_compound_pages()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20220612182320.160651-1-gautammenghani201@gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20220612182320.160651-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6efb827-9731-4eae-94e4-08da4df14a1b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566FC849D27926FA6472E8DBBAA9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t05lkWuh5LLj1A1JMxtFnjqkHKSDWO1mrNY4o5m9674vPkR+t9imbxUXozE9+6VtTP2jE2TTScgrO0GoBQoK2E020VdQhR2HRbi7rVdP5b1f3TjMjibeczTTwY9V4+5WlYBexLmVqCY8BIN4vdPbn93lUPJLOh9tjO+VdpGrka5VMTNZLrF5UasdT9K1nYfwDhj6l1cb3pPiNwhoDaoMucD+Uip3AFda6T9vEmT9tBZY2jfr1FtTVdfA0MZAFS3o+S32KtnkiHDrTr3xfDRQILaOCIhzwzYM2N1Ad8qjyBFq/zGTRuziHvr+A26IgZH5rFZm0ERjvhwc3EuWatX9K77IlKuBXn1htW2a+Rt0CYQ40WcIsAaPV0NJl/j4upZMJEBDQnlCtOhQl2lKp9OiPBlinR0Gy/LzeymXHZdf/HxM+Ae+sfY1JZP5YvU9Wx/j3+R8gSYR159B2IUnxzmej4PQaJjb7IFMuBjFEfxY+Y7f16gu/nZYKhwRYEUQZqpT8JY8kIILSiMc0GAI8hyJZZiEDpvfZMQkSGOXW6ksu3MRMGsie+ENFwNBPGTENijjj3MAnFlH67zp4aHq/52m5dL8qTupK6uVCTjcUZ+buhwsJo2v9kt6PC9CbC3ntaVRUDzAztXVf4WjlsygLPXjRdj0e3WuXEGXv2tjZRWRab/S0J5svEVLcTx6aUal0wrWcS4Kx+hYfT3iPKvcOPsqRG1G+yad8Pj+dmaBEbq6ffc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(6916009)(36756003)(66946007)(6666004)(6486002)(508600001)(8936002)(31686004)(2616005)(4326008)(186003)(53546011)(5660300002)(6512007)(26005)(31696002)(66556008)(8676002)(66476007)(86362001)(6506007)(83380400001)(2906002)(38100700002)(26123001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW82Q0dnTi95NXhiUG9rT253T0J2YVJTZkVxbUFiM1lpOUlHdmxENHNMVzFZ?=
 =?utf-8?B?QkVOMW1GYW1OaFF3c2ROQXNOQWZrSnpXdG5RL3VYNVJLa3FDMVRtcnlpcVIv?=
 =?utf-8?B?cit3YkNzZHdWdnNta1FyWkNPNDYyVWsrVDhhc083RUZFdUUrUk02L05RZ0pr?=
 =?utf-8?B?YkpUajhFMlRTa3lib1VRUGZnV1dqS1k4bHRtOTQwQ0lBeitCTmdmc2UySkZh?=
 =?utf-8?B?RnJ1YWpqWG5rMXpmWUwxWFZPTnZ2SHNaVkVLRzBzajk5OHFQSVF2K0VTU0Jy?=
 =?utf-8?B?c29QTEVsU0FyOU1DVGNPOVY2ZHhuTWk2VVQvYW1aMVQxcjJHOCtseGcrcjBU?=
 =?utf-8?B?MHV3Qi9tNldQd2FSNktObWszKy9TdytpNStFTWF2d21VcjdvUmJVcmYwRVd5?=
 =?utf-8?B?L0g1d250cW1JVloxMFlFMDdEZ3hsdFhKSEszWlY0Z0ZlVUFPdmVxT0RIQ1Rl?=
 =?utf-8?B?THZuZXBtWVNxVHdNNm1ka3FlRFJrcmNqNE5Ka2g1WEs4SzQrU2FsWHZjS1Fu?=
 =?utf-8?B?YXZQdklXcnZucDRldHdUVXh4N24rbjc5ZTUvZHI1TElyUlN1NVROUm9naHQ5?=
 =?utf-8?B?bjZQMTY2WVhUMldlbTdVeThhaHVoVEU5bmJkVWtKSXhKTGVLWmlEUEpkUE8v?=
 =?utf-8?B?bllDOGg3QnIwbG5ma3BoMHQvaXBGeStTbk0wd2tMcHdXNGZlSXoxNzR1MlFX?=
 =?utf-8?B?anNlZ0hOa0FUalhZQVNCNzBSV3NKL1h0VDMvdGk5NDAwKzJ0QitmbWhnc2Ru?=
 =?utf-8?B?WDN1eUdYMk96R2hZRWFyaElORi9HTmdxaEE0OS9JUzBRcG5SZ2JpR1JrWTA3?=
 =?utf-8?B?TnM2ZGhaSXNyMDdOQzh0bEo3SngrdUViaW56dHhnYVNnMzdITmFuNVdRRUVB?=
 =?utf-8?B?MHVqRHBTMlgvQk5xb0RBTU00QmkyYTVpeWlaU2JmTWMxbFljekhtL1FwVlN5?=
 =?utf-8?B?ZmdmYW1UUjZVeVQ0YjdYbHhrRWdpbjhCZjZlekF3YjZwejdNcTBDdUNVVC9v?=
 =?utf-8?B?SktMZ3B0NlhBaTlXN1Fic2dPN015RDB2c1kwVG5vODBKMCtIb2M4aVB0WnFs?=
 =?utf-8?B?V3FNZGd1QWptTkR1QUlpNU1wUmtKMEYxM2JJN0FoN3hDMVdQV2hWdmNtaWFp?=
 =?utf-8?B?Vllsb0g5aWVwdkduUFNncVRONmZleDhQc1lSbDFxbWlLemF4Q05HSVNpdUtq?=
 =?utf-8?B?R2tLQVpXM3RaK3ZSVHJXcUZHMXN1RjBYcDV2bXI2V2VnaEVJRnE3c2ljZFVU?=
 =?utf-8?B?Q3lnSEZxZEdxbmluM1NIaC9XYUxacm5UUjc3M2MweWhzdE0wUnltOE4wSGF0?=
 =?utf-8?B?QWNDU2Vpd2pHTG4zUGhTblMvUG1GSkRoK2g4T3ZaMU80VEhuWEkvVUtqZWgx?=
 =?utf-8?B?c2hJU2pGbzVhYm5POENOS09iYVBQazFYclpTM08xdUlKS2RVMWhOQjcwYWti?=
 =?utf-8?B?NGp5Rm5oZ01wVUFpc2ZzRU1pR09yWHFyRWJacWJLeEJGcTZDQ2g3N1pVSzU5?=
 =?utf-8?B?Qmw0RnhaVDFpRUFldzE2R1dLNEVSQm0xdWxLZDNkeE5wajRYd3V5QkZMZi9E?=
 =?utf-8?B?eUorRytacFlmQUhSTUQzeUtLNjlJMUZFTUZjQzVBMFJTcXNJeUJQeVRNd0ZX?=
 =?utf-8?B?aHo4Q2ZSNmViaVM5V2Yrb0tiL3VYdUlmQW9oZ0N2TTFZQ3lQbDErRklSYWo4?=
 =?utf-8?B?ZmpGcWtKazNUQTBsdXBHYWc0cmdzdGpsMzlXWEhLL3YveVNYeVJrTFkwN3F4?=
 =?utf-8?B?cENoUCt0T3FyS0JiWUZYejlmZFdtQlpUa08ycm1FSENKWFpxeG9uaDd3M1Bp?=
 =?utf-8?B?ZWVxai96ZDFIUXlQVk40VHlacDRzNHkrUFBObGdidlNSWFdSZkY1QjRnVXFp?=
 =?utf-8?B?Y1Ewc1NUQjVNVVExY0Ntako0d2NST2xJNnR0eEpvcHc4ZTV3cExzVXNNYk1L?=
 =?utf-8?B?ck9RRmFsOXRmOHAxZXdBVUNqdjJsb1BCbytpam5RaFVYTXRIaGZleTUyaUJu?=
 =?utf-8?B?SzF6cE1ObndnREVhdHltYU5DVlhsRDA0WGRQV1lEK2JZSWQ5dEtBc0s2eU5O?=
 =?utf-8?B?SVVWQVp1YnNiSnJoMi8yemJQMWdJTm9MSDl6UEN2eEFzcmNzRWNCVnVQSjBi?=
 =?utf-8?B?V0k1cm9sVng4SUo5TUl0Y1hZNVFWVU0zdlhDK0tFSCtUbnp6M21qRHVxWDFh?=
 =?utf-8?B?dC9pV2ZBdzRvNnpjN1M2cXUzaWpaY3VETmZENC8rRDkvcUNFa1dpajN4UFZD?=
 =?utf-8?B?SytISnh6aFVrb3RHNVI0RVVjSnVrd2Zkdkl1TEk1Tkx4NXJ0UjMyQmJDaU83?=
 =?utf-8?B?dFJ5em51SUI0dmErYnRlZkRYK1pzbk90cGxROS9aVmRnOW8xZXpWTW5JNFl1?=
 =?utf-8?Q?S1xby2Mc4KnTeOKs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6efb827-9731-4eae-94e4-08da4df14a1b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 10:33:15.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2elmRiKcHT3+WqXZrAv3zPqTRDB7vJlQvrSRGaQFgMElUwidFoJtDnuJF9pV+/le72NHserEDOW2oN8e++QEVo9WkMciYmzCK6NTuzaIxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_03:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=904
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140041
X-Proofpoint-ORIG-GUID: p96gfyBQ_KkGZrBemj5w7wkDwHqNcjiU
X-Proofpoint-GUID: p96gfyBQ_KkGZrBemj5w7wkDwHqNcjiU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 19:23, Gautam Menghani wrote:
> Remove unwanted initialization for the variable 'next'. This fixes the
> clang scan warning: Value stored to 'next' during its initialization is 
> never read [deadcode.DeadStores]
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>

Ugh, thanks for catching that:

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  mm/sparse-vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index f4fa61dbbee3..3008aa7859e0 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -737,7 +737,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>  
>  	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
>  	for (addr = start; addr < end; addr += size) {
> -		unsigned long next = addr, last = addr + size;
> +		unsigned long next, last = addr + size;
>  
>  		/* Populate the head page vmemmap page */
>  		pte = vmemmap_populate_address(addr, node, NULL, NULL);
