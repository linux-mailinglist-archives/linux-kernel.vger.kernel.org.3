Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5054A18F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiFMVe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiFMVet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:34:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC819F;
        Mon, 13 Jun 2022 14:34:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdP1j004110;
        Mon, 13 Jun 2022 21:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=76sJkiQ+eXS+iDvCs3N9lOi3Vqf+QhVgwV4j2X/tUdE=;
 b=tsa8HteOuqfO6fT6M3gk0oXNoB5NbZW7RjYJh1qGGEDTEu1o6mK3FIKVHC6dq1ZWO3Oz
 cf2I2liFdkxMq3eL0fKD9iDBS0dSJUZ0yZap2s8KX+NHoVPh7JhrgClkpdBmhSh76PKP
 RczlUxjZZLduQNP46GsvkqKxby79lt6VWWr9hgnXnQHv2XJhePJ7h6uF0MaO/NV+Ri82
 Bz3Mqq/nUztEhBBAy6ACO7bzXaSFGLuKRaj6bfnniv/CMVQ0CSeQqUztEQuE4HUoKD/M
 qqJkJkC00n3j6z573w3xXAqYZSZZsaNMRwCsdEd5KH9Dg4gwg3HsbidWi+5uPlCrgHGR jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2m99c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:34:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DLXvuL024861;
        Mon, 13 Jun 2022 21:34:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpd8x80kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 21:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWRn4SMi64dxeXIL7MqajUpQjIJgs29AdStFNkQmpZU7f2gVGiEqJEiXy4mc9MulQFjlDorNXez00ctz3KXTc63sQAn+OnVzspcT35wqUsUcEz0ULwrcYjvPZv79Jdx8OV1hB4b3vOM3SwNlPTV0bElG825+lqsZLmdzFJjOJic+VR/sFruTrHJYi9hSe9irQNQMFT9A+6dIdeARFXEKZALz7d9GGvaTygnoso0oIocvpzdNp3e80HS8ni2NTTtTGZG6xEZCWHso7D2RvFxlBIddYmAPxuy5cONobSU9IIuXu4D6prIcHQwrwLjPZlYHRz7mZpfogM4yM1+qoTHs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76sJkiQ+eXS+iDvCs3N9lOi3Vqf+QhVgwV4j2X/tUdE=;
 b=Fi3j7LsGfiheNLYp5pG9Oqb2Vt918XVdRZSqZpcHZLXSmZ4fulzzWhe5N/hKFHxkZFjRUxFFrDBh9kO2WU8yu9w34hghdg19TUKqASZu6HZ7kQgKe7015zUR8Owu3pyQqapvhLMto0jKPKmBNmhjumWxaMtP0FnGmEsLjUwvns+d9AtJfHwuDdKf881CUtFs5M3elrF9leXBg8iX6BsyejYEk7HBRe1Lz7Ibm0gAQqfKT56iDkd/siGhy9KO5HIwRNONtbrY8ZMScsbuSvY8T5LDHc5q2ULyH6KpUL1bQWkxghDFiCg0UfwYJ/nGbZIHaqYxOYVmWu9wz5+SB7tE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76sJkiQ+eXS+iDvCs3N9lOi3Vqf+QhVgwV4j2X/tUdE=;
 b=hnLPk5FL6T/wC1OGiIrSTdQjOW66mO2dnNsMZySbViopWHEJTHohpu3m26o4SlpwuYYsTf1rnUdlLjADzW5CtrsGRH71Y71cIU9tWReEAveGuuqM/06GVqrC1bkxnPixU20ySV1KaOHLqihdoM7Ze+QRXoitzDGi/F9GzqzNGUM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 21:34:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 21:34:41 +0000
Date:   Mon, 13 Jun 2022 14:34:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: move vmemmap code related to
 HugeTLB to hugetlb_vmemmap.c
Message-ID: <YqetbhnddbAzTnHJ@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613063512.17540-5-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:320:31::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df992e79-67ef-4174-90d0-08da4d84862c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4797:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB479790DD433CE0C42FC0FD59E2AB9@SJ0PR10MB4797.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JALwMFUieVi9loGD40ph+wIseidvjuVTnlAA5/MxBJsasmW3V7Bj6M6JPSZA03JuGcxME3kh+5UDQqhzT6B0cwIR69kT/uNVJJoXRvueQAl3V8awEuW0gWpryuaCuDPWwf3ue0OfShqBJROmxFR+Y7+aIXOVlFPEU3M3AfnPag3IIDQFbtWQHZEgKyifXldadR3XcpK8yhefMELqUAL0XYpOjV93JvJgxs2689IuHO7KGToL88gzM+3QKy2ZX64F/qNn4sAJ0sy6OcxjyHxA1LZmZByKz5ggz3wnTrY7EGNHEKw4ld9oMZJZxg5F8tX19WKxTaAkYI5yJHOaKUAS1eToxfJyeVw/Sy287xCGMV8tTI9SaIDQHIBXGhcMin9LVBR4EuqV9sBSc0RvFqHIRC9RtK9GJsQvjRl+8WaARlCd/ohHjzex55/RAnr8os4KD5OjsE46xHGJWdYSxbrxQHhrrqCYQ8v8LpVdzDWjR9nIKWUFb3ACp9ydKG2pqWYhvS/3RRvKJrg+NWaRGGBNIxtLIiQZcaIHSJ1zWKHQkXpBM6d4wD8OGx/YNtdh8QEBabwIzC9DkKtjU31q8ANHlyeRwuVaTbbtTT8Zs9G2rkVD1CVi6ammHYoGu5XICL2+osQhbVaZ1rhTAiQDwKJQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8936002)(44832011)(2906002)(4744005)(5660300002)(66556008)(66476007)(66946007)(4326008)(83380400001)(8676002)(316002)(6916009)(6486002)(6666004)(508600001)(6506007)(86362001)(186003)(6512007)(38100700002)(26005)(33716001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1plbTJkOER4a09QL3pOR2dEcEFqOGY5c1VrRkZmMDB1TmtQYjRJMXdQVTRI?=
 =?utf-8?B?STJaNUFLd3cxR3V0dC9Fbmp2TVhDSTRXNUdBc0c4ZFd1RnlERVl3dTcySlc4?=
 =?utf-8?B?Q2ZNMXZ1SmQ4K0VReVdhYjNsRHBhb3pud2pVVjNnbE02aEZQbnhjbmFiQU9I?=
 =?utf-8?B?bWs1UEVGeEJINW5sZG13RGcrcE5QSWQreGp4cTVEcExsclNPQ2NIdENRdXJN?=
 =?utf-8?B?bHVUZFFaREhHQWJnd3lIQXdQeHBiZjQvOFM2eExwaU1sV1NQNkV4NEVoUzNh?=
 =?utf-8?B?WkxLVlZ1eXZOMVlZUkF2RnlKM2RlRTlIQXBzL0pybk4zQ0tWQzYvazEyTHJE?=
 =?utf-8?B?U3NENTR6Y2J4d0tFVVJXcE5BNVhmOEppUWVlMzNhNkY1Z0EwV254ZkNBQXdY?=
 =?utf-8?B?Zm5uRi9zY1hyRHN3bHY1U2wzTXEvQ0xFcGU5cmFqMHVnU3FwU2N2cms2SEF0?=
 =?utf-8?B?dlZvWnZUejZjQk9JRlB6R1JhZXM2TG9vTGx6aE1FQlFvYlBPcGdWdGVnaTN2?=
 =?utf-8?B?UEVjWDYwYXVlSm84QnIzckFCdUJhN0E2ZjVSdWQvSzg0VlhKN0h3ZlJWM1pi?=
 =?utf-8?B?V0IzOWZra1huZTNsQVhqT3loQjJUdENtUmp2OVVWdE52TG1kUkp3dVBLYkNT?=
 =?utf-8?B?OFZtSDY3bXhpMU1Iak9BWVlEbHh0YmpMWG5Ud0oxMlhSTUhWdjR1WWUxMUNq?=
 =?utf-8?B?c2Y5NkNtWnFrdktYYVJYbU53YmNIZWxzZ2o1NURiYWVkQWVNakQ1ME5LYXpz?=
 =?utf-8?B?aGZqSngvbE9SWldYcDY0SkpLQWFBTFJsc0R4UUcrWE1KMW5aZzlhcFpUVm9D?=
 =?utf-8?B?eDd3cDlYTHd3WjRpQmxWMTRzeEhCOU1aVFl1K2lLamRGeFJuZk5jaklRRUEw?=
 =?utf-8?B?SUdtc25GV2lIN20wSkN4K0t1cjRYOTJmV29oQmF0dmJLc0tTTmd5K2lMTEhz?=
 =?utf-8?B?YzNHUzlhYzNUQ0Fldm5uZGsvUXlHcWZsbzl4T28yL3paNFRsVEtIZ0Rwd29w?=
 =?utf-8?B?RUdXL3RiZzNUWWorMTZMUUNrcGpKOGs1Mzd3U3FoTkpKVWN1ak5JZG5weXFD?=
 =?utf-8?B?NUw1Q25LT3R0YTRKRTFsK3lTbklTOVc2SnREekc2cDZ0aVZXQ01nNEowSGF2?=
 =?utf-8?B?bHpSQmVyR1JORHBqd0dOZENMeWlPTjNWNk5wU0xmNCtXWTJ6UFBiSGpjUlhV?=
 =?utf-8?B?NUYvYmhScWZXdXRkcmxBMXlLeVQxS1ZqMFFFRFNmRVhjM1R6N21RUU1GY2Mw?=
 =?utf-8?B?T2ZOcnZ2M3FQdG9PVFIzcjZ0UEhkejY5d0Z1S0dZdWRuSllvc1VMS0k4WXJZ?=
 =?utf-8?B?NGJZUFo4UjEvMi85aTlPbkQ5bytqK0puNnVzME03NzdCMk4ybU5Dc1BiUWRu?=
 =?utf-8?B?UWZGRmtwU09KeU9aUE05bThTRkU1eENMMk14T3h4RWViOWRVTWNkWVlOYzVH?=
 =?utf-8?B?d0liN0U3c1AvYW5zTk8xQWt0VGF5eWZoQmd6MzFuRkp2ajJkRUhUT3FyMFMy?=
 =?utf-8?B?ajFSVkdoSHRZNFN0SmJPcmo3cisyTnJ3K0psZXF3bUFzTTcxZVZ0MEd3Y1ZG?=
 =?utf-8?B?cWU1cFE2QjlJYlJJR05Eb29wdkVnU2JkWHRvTVJmb3BFM3hPYkF4ZUR5MEVR?=
 =?utf-8?B?Tmc0dlQ1NlkwVDdGUkFZQW5XOEZTeURiNVc1ZHA2cHd5QXFsQUlVMkdZenlK?=
 =?utf-8?B?Y1Z6RytsZEo1YVNoVHYvcGIybG5aSHI2THFtQUhhbEd3ckxDd2g4SFFabUZm?=
 =?utf-8?B?U2hNYUNENkRnMzkzTXlBUHRsdUxsaXJHWlA4SW52emNLQldMN0hsRVk5d016?=
 =?utf-8?B?Y00ramlQd0ZLR1VxQlg1eU16SGJJTHZuUTZPcVdSNjdtRGFsb1J5Q0ZRbWdu?=
 =?utf-8?B?VjlwLzlQbnpvZmtiZ1UzT1E3Qmt6YXNKUVpIMTUrNXVncExsR0ViL1cwTjlk?=
 =?utf-8?B?c3F4WEZXSktwV1N1TWZyaFpINmVRT3AranhwTzhZcGthV1d3MmszU2E0RDE4?=
 =?utf-8?B?U0VqZE5BQkFwRmRXNVR2ZkFKekh4bkl4YUR4WTY3QU83RHFTSFBPLzVkTW85?=
 =?utf-8?B?Mk9SR0drenBVMVRmSkRhUFFLTWFIaVQvSDdheHltWXV2QS8zdER5V0svMU5t?=
 =?utf-8?B?WmR1SnVTTmlPVHNWR1AydDVVWGY3WVBGSFVsQWVkK3UyckxOTld4S3QrUHNi?=
 =?utf-8?B?ZHpMUDR3UE9oUHU0dXl1UGk0TWFiSlJuTUliWnkzWGphTHA2K1pZdGora3FR?=
 =?utf-8?B?dlFFSWVUdGJXV3NybTU0dE1XcU50S0FnMVg1QWJ2UnJRcjg4QjU3VU0rcWo5?=
 =?utf-8?B?MzdTZFR2WGM0RzhNNHpYRGc3YUlWaDVxQW4wU1F5ZFhkNXQ5YWpEdzZRNExO?=
 =?utf-8?Q?4ekOsCauQnJWuBl0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df992e79-67ef-4174-90d0-08da4d84862c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 21:34:40.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uo6FjCgHAjDQ9gJDrNGmXSuBF5y9nWWKC7syDILEVrmUR3+sGbOi8ZD17/2+Baw/kADYvGBKq+03alh/aTbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130084
X-Proofpoint-GUID: bIx0dCKh5lYBFYALPAjl4HV-8q9LJUlv
X-Proofpoint-ORIG-GUID: bIx0dCKh5lYBFYALPAjl4HV-8q9LJUlv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:10PM +0800”, Muchun Song wrote:
> When I first introduced vmemmap manipulation functions related to HugeTLB,
> I thought those functions may be reused by other modules (e.g. using
> similar approach to optimize vmemmap pages, unfortunately, the DAX used the
> same approach but does not use those functions).  After two years, we didn't
> see any other users.  So move those functions to hugetlb_vmemmap.c.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h   |   7 -
>  mm/hugetlb_vmemmap.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/sparse-vmemmap.c  | 391 ---------------------------------------------------
>  3 files changed, 390 insertions(+), 399 deletions(-)

Code movement without any functional change.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
