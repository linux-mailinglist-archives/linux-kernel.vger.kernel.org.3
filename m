Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F25A9D76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiIAQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiIAQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:47:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F0792F8;
        Thu,  1 Sep 2022 09:47:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281GgkYp023484;
        Thu, 1 Sep 2022 16:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/qDXmWfBns6ZRpS203Hs32bXyAg6x0v+K8JT63xez/Q=;
 b=rlkvvBz+StarDzek2A6fqsxHg0EG3klizk8JjXjQAfaeU3sBW3UwPhwKw3T7ZHR6wG4Y
 YO1OLJAmxWEFcn/k5dzOK0c9IgIBv/qLXZrsjLyZMGuVHhRJi2UeJNd3oCUc/zgwDuF+
 rAAZoHXqGxCxykhAONf5oCXVAp9U7vjcLF10ZrV1SvHUcVXbsTsk8Q2pcVOipXEgjwNe
 RdaQMMHakhZRxli3qa+XqTPt063zwwscgRspDSRb6gCjKdyvkO8S4j9rwc+yOKv9nbVd
 F8IiHN9WAzzVK5Hb0jufqIQ07r7r+29NyK5vOybVtxADW4QRXZoPWqTnqQHFj+FFEyzR DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a4nnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:47:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281GIPs7036667;
        Thu, 1 Sep 2022 16:47:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarpb93qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLIJ6FC5JRdWcmhDAwlAtw8GAKBkATjhdHi6Q4B/GK1ZrD+0364Zn0Qk/489z+r7jr7vtrxCMLHZur9WkAo2kV25kMXLzWnZBOFIdUDbjAF8G+tMArYc7CZet5M+wn+6l/Z/PCRndkkkmbzYnGiI/DImuTEnL1T69AytqV5ylmV1+LsqyxGyQcbGz/WG5Sc+uVb5ek8gdhA9d/sjun6Wk/EThGway75VIdYdjuSEvX0zf9g09vSSGXHgpkCfsZOqMbAVNMDEgAHChN1J0KYKDjNrxGrs22pbKRcXJ+24uGHt5tCSoZAFOOPGd4MSB2sEf0gNkaSv5OyjRWjOq6A2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qDXmWfBns6ZRpS203Hs32bXyAg6x0v+K8JT63xez/Q=;
 b=FkAcnZPMx87Q8yCHZw2glvDNXg7fG9KPpzVjvQOu3Gn5ASW41Jzplqq6sm3AvTewqGdwyeMi1xg9S+XeNLsJPNOU/knMjWkaUlZCjMc9amYIFLSCZqz9n1Fh5WDbSxxHB8obmw8AG4TfVLDwOsESK0Nd8H9cMkdd/tt7sxGW1LNsjc0B6dhd0xZceHt0nJfkq0PnuxX6j8OzCMhLaSv8EJCjM1wxEI00Ax86jpmZhoOdoV+RG91VAqrVc0gkys8bf7oBIE1HqnsNsUqDiP5u3i+K3IOVlbBuIiv1Xq8UY8D2Uer1bLDa8l0ySRl3quRU2uXHECog/iP4N0VKjuZrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qDXmWfBns6ZRpS203Hs32bXyAg6x0v+K8JT63xez/Q=;
 b=mkUNV6pldKkht2Ne523XtiEAuKTj2QkGQYgtaCFGMbDTrxrbiDGFbdFiaCvJ7nOV0AnoWF8KzD6G0lAodnsnrns65DLPTGxSb3fd0jcClU5QEEV7QoLLeGad5keD3By+MzxiCD1/h2fyZ67Dkb7eC3F0bZb6Wu8exIL1dT2yUpk=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 16:46:59 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 16:46:58 +0000
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
To:     Robin Murphy <robin.murphy@arm.com>, Yu Zhao <yuzhao@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
 <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
 <CAOUHufYHh3B6A8_pAusnW5==r3VhPxy6bOoUHbxe0qvhNGovqA@mail.gmail.com>
 <982a4b95-0ab5-f18e-cbaf-1f503a35ada7@oracle.com>
 <ccacc117-0be8-2cd3-480b-dcbca5485d6f@arm.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9e6d67c6-94f8-5065-3264-02dd6a82888e@oracle.com>
Date:   Thu, 1 Sep 2022 09:46:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <ccacc117-0be8-2cd3-480b-dcbca5485d6f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::34) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe2d6c7-afd9-4d65-1637-08da8c3995eb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5088:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISbki37gqWVAAOZzAaksTxTp7S4DPQxiRm+Qs9SKUxklJbFwMI2Cd5PCyc9/VzZhp9cbObUnuuBuxvNp2tPxQ7QMXCCMRt0A9cRBz+V2X+FOHeIMfginndzxabV20wiVOyc5YyIcIUcq/FvRJIPczlHExM2wlczhYzKGFfi1LsxInoVHAyyA35H7p49XhWuza4s/YASLH32hprpiiQjHrCdEZMzffW3767blWWGnrT3ObQFovH/UafogLTV7d67dSS1FxVCH61ESdqmn4P1Sbce5KCc4Qqbc10OuYI7I2VU2hOwMmbnIi/jY/GOtWhVne30iPifRlx3+pR6pqXWYDhPfN7cX7GOGVAFPtafTpRxdGph80P3lYU8rBptd9tLmWaWLDFu+KzPoPXPA7zZ1PfPm3jrycNlbMCmbUlYzERxJJaBgpuw2b1TU4nzPK+Eg/hmNAEiMRcYEym+SPU3YvYfm8RmCyqJwcFrzdGBS0FunEnpEukt+FYjeTXVmR+KIJ4YeF1Vzd61tQcf7dKTIz7hunyIQ/4sxotyaT9VuijoF+81K3VU8buIBe7FA3Mbo1yTl6nQM31FPBt4kSUb6yYqncfR6OA0So7i6eAghLUJUmi6JbNdgbAG00EgjUt4vZDIYkJ4ecKMxu3hU7lOS6mQ2w1+My/hqIurDWsUjJAsmbpVrt1QC+uayfgVuYH7ZSomyJF/d3RKPTUK6zMWcps9atD5QqK66yfcnSnixctHm4g5hfONpy037RcWw9iS9YlhirvD2AtdnGR9NVw1P3iSByMO0kPcH4XWg4GZkkoScSf/lq08a24Pe20l4zYko8F8to7r3akVNdKHaM5fKHoVBqd6XU7lsCFevuyanyiCBT2tCv69akwZOwNjMUsYeoKALQmTZNnRthefc6BE6EzqJ/ofKmCBdaB5BJOg+oxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(376002)(396003)(2616005)(31696002)(86362001)(186003)(6666004)(107886003)(8936002)(44832011)(5660300002)(41300700001)(6512007)(53546011)(2906002)(6506007)(38100700002)(83380400001)(54906003)(36756003)(478600001)(6486002)(31686004)(66946007)(66556008)(316002)(66476007)(966005)(8676002)(4326008)(110136005)(160913001)(15963001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWQzQVZaeVpUUXFSS3phM3RYMzFOQVhJa2lyaVFOWFRSY1Z6T0FJY1RlbEpt?=
 =?utf-8?B?d0oyYUpldC8rV0NPRlNsN3UzVHArbUZZaVZFaGk1NXJDZGlXeFlLc0hYdGpx?=
 =?utf-8?B?dVlpVyt6NVhZZWpsRkxieVltcDM3VCtxM24wcERnWnRDZkFNbmdQWEkwd1NL?=
 =?utf-8?B?VmpPaVVaN0xrSkMrV2J0VmwxaE1yREFmK1pEcm1ZT1h0V2R4M2lnd0d4OW05?=
 =?utf-8?B?WFg0MVpyaHAxUUNTSzZUb0c3dHpzQWdKNDNaUW5kTllNU00rZERZV2FPZ0gy?=
 =?utf-8?B?SDhsMEE0dml5aUJlSldFNkJjb2RtQWpsT2R1bWZFdkhzSk5QemZDMFFNODYy?=
 =?utf-8?B?Y096ZGVpWnZ6NU55MG92a05sN3BJalRKVTFDQ3dYcDZTVzBqSEphWEFQUGhT?=
 =?utf-8?B?TVRldFdOWjJrZGdwNEZEU2dGeFV5MHZReG01WmRqZXpML2VHbUl3Wjd2cmJj?=
 =?utf-8?B?YkFVQmowV2xpYVpNTUtWVkZwTGxHRTJYVUZNaEozUUIwZGJ4UU54M2xhZERH?=
 =?utf-8?B?U0JFWVJ3eWEycFhZU21PaTYzSmttWmp4eXhYRlc1Ly9hb0VNb1BaZ1hCaUln?=
 =?utf-8?B?OU1BTldZOEcrQU1yeUg4MUQrSlBPUHlZdEJiZjJPaE1ZWVgzS1dXdWRPR013?=
 =?utf-8?B?bEpKYnVXVWd2S01vV29rVTNqUnZlbklYclZmVVZjOHFoN3JuMzlGWlJVWGZw?=
 =?utf-8?B?bjU0cGJ4K3lPNEIvRHFhaXlMRXF6Y2cvYUF3THlwZFFrMXM2TzJqN2xINXJS?=
 =?utf-8?B?SXNtZUo0cCtsMWxXUUdsNElKdmh4NWllLzR4Mnd3UDF3d3BVdFprWWZib3px?=
 =?utf-8?B?ZUhKUXFDTjgzOTRPYU9yMGhKS3drUlZYeDEwRlRVSWVaT29MWGFQVm9LazRm?=
 =?utf-8?B?bXdWV1hjdkN1a3Z3YVlrbHQveHN2QjltV0xmaGE5bWUvNG1Ic0RWa3Uzd2Q0?=
 =?utf-8?B?RUQ4ZmNIMWJIVS9uaEdVbWp1Qk9oa2VDK2J4OG9CM1NudGgzaVhnQ1NKbEFr?=
 =?utf-8?B?OTROKzNuRmVBdHFOUHN5ZkdXM3RrN2g3N0Z2K0h1Q3k5U1o3NFc3bG1vZlZC?=
 =?utf-8?B?R1RJMDZpcUlxY3Qxc1BZNHN3bGJ6WVFGKzRVKzZYOUNiUmcwVHlPSEhwenMr?=
 =?utf-8?B?YnErR0VxamxUdnFQZmIxaSt1MGUrN1JiZURaUFhRaG1kZXl2ZzhFYW10NERV?=
 =?utf-8?B?S1NkeUV5dmRRbXIxc3kvZTM4TlUzVHhJOTV4LzQ2ZmhiOE5oL21tZ3BmRW9a?=
 =?utf-8?B?b0d5bHVuNGJjTFE2Qys4MHcxZWJDRnZobjM5YjM0Y05JRDNyaUZoblRoalZU?=
 =?utf-8?B?MFdFMzZsWDhEU2VwYjFybHZ1czNBbnplQjB5dWl6SjA1OXRqeVZaSzlSQ3Fk?=
 =?utf-8?B?cENKWUdGaklOeHorZmw0cGdjOWJ1OUpaV01rankyTitBSU1IMVh5UHIwS3NQ?=
 =?utf-8?B?S3MrZzVFYXZIQk1yM0NKeU1JZHVOVk9PakhqWnl4V0FxNU55LzVYU3BVMXhX?=
 =?utf-8?B?cW55YzVoaTJib3pKcjk2RE9oZHg5Zng3TDZxN3laV2x0alFPNm9oc3pQVm5H?=
 =?utf-8?B?ZXBBK0RJdTdUMHpzY0w5cis5UU1pOS9mOWUxeVNjR3dYdlJ5TzIyb2d2QzZY?=
 =?utf-8?B?RHc1Y09nNmxqSURmTjg3TExva29STEtoM0FEdG0xNDdxUWJuR2FPM1B1Nldl?=
 =?utf-8?B?U2NnRFA2Sys4YWR1Znp2eXFTWjlxSy85ajJvRkNETllnb3pWUEdZcm4xRnRK?=
 =?utf-8?B?anh0cEFOOUIvRkZLemJYNWpEUG1IWWwvK1p5MWlHZ000WkRHbWJJRXBDOGJE?=
 =?utf-8?B?bjlqM25lVEtuc1ZRK2NxaGV5MzJNb0FjTmVLM05CSG1YSkc1ZlFMeVphcG9m?=
 =?utf-8?B?eUgvV0pqT1hFZENlWTIxRlY3bGJxSmliMlJPbFVOcktnL0ZndE82MU5zd3Qz?=
 =?utf-8?B?TGI1RzV1c1hQbDZXaGpBM1pSUktjaDdLaE1HWHBXZ2JmK0tjNGxtQ2JpK2JF?=
 =?utf-8?B?WnM2NmpoNWVrckZEb04xVCt0RFk4Q0c5OW9VeE42S2E4UXU0aXVsWldvU21L?=
 =?utf-8?B?eUZ1ODQxQlNCdCt5aklKZHhNZE5MOVIvYTF3UmF3NE91WEZVZW45K0RtTWYw?=
 =?utf-8?B?QUhOM0MvWjBFSG8zVURYNElLbkU5UVJaMzJEcXNzQUVmK2lLc0pncHVscHFX?=
 =?utf-8?Q?6Qmhmz1ejijh/M/GDK/k+KU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe2d6c7-afd9-4d65-1637-08da8c3995eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:46:58.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaZpLN8na1UzyLN6xqTwXSPgNulWi7Ra1j3NJXGXJ/IY6KhuRVzeP6LQDCaHAUzEbEisBC8yimsBGPCuYHhwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010074
X-Proofpoint-ORIG-GUID: hqbJiRMFNmbxPFDHcVunqgBNcIJZQt1R
X-Proofpoint-GUID: hqbJiRMFNmbxPFDHcVunqgBNcIJZQt1R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 9/1/22 5:24 AM, Robin Murphy wrote:
> On 2022-09-01 03:18, Dongli Zhang wrote:
>> Hi Yu,
>>
>> On 8/31/22 5:24 PM, Yu Zhao wrote:
>>> On Wed, Aug 31, 2022 at 4:20 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>>
>>>> Hi Yu,
>>>>
>>>> As we discussed in the past, the swiotlb panic on purpose
>>>
>>> We should not panic() at all, especially on a platform that has been
>>> working well since at least 4.14.
>>>
>>> Did you check out this link I previously shared with you?
>>> https://urldefense.com/v3/__https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld*pnerc4J2Ag990WwAA@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!PXzSLurBv7VqxI1451TV4zO3_-BYj4grk-HYBsXzSnA6nZcXaBzdsQ-rF2DAqlICSRPMt-efYv_Uu2A2CQ$
>>>
>>
>> Thanks for sharing! I used to read that in the past. To be honest I am still
>> confused on when to use BUG/panic and when to not, as I still see many usage in
>> some patches.
>>
>> Just about swiotlb, it may panic in many cases during boot, e.g.,:
>>
>> https://urldefense.com/v3/__https://bugs.launchpad.net/ubuntu/*source/linux/*bug/1955655__;Kys!!ACWV5N9M2RV99hQ!MO4S9r0PisrW6Z-kZqUitAMbuGNMX6aceQd5VApqXllP6f1jaPCyL9x50um7chsn2uGL_pNqdBzTjZK5GebeKrI$ 
> 
> 
> That's really a different thing, but frankly that panic is also bogus anyway -
> there is no good reason to have different behaviour for failing to allocate a
> buffer slot because the buffer is full vs. failing to allocate a buffer slot
> because there is no buffer. If we can fail gracefully some of the time we should
> fail gracefully all of the time. Yes, there's a slight difference in that one

Thank you very much for the feedback!

Currently the swiotlb remap logic is more gracefully to handle failure, to
re-try with smaller nslabs (line 352), but will still panic at the end if the
value is reduced to smaller than IO_TLB_MIN_SLABS.

 337 retry:
 338         bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 339         if (flags & SWIOTLB_ANY)
 340                 tlb = memblock_alloc(bytes, PAGE_SIZE);
 341         else
 342                 tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 343         if (!tlb) {
 344                 pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
 345                         __func__, bytes);
 346                 return;
 347         }
 348
 349         if (remap && remap(tlb, nslabs) < 0) {
 350                 memblock_free(tlb, PAGE_ALIGN(bytes));
 351
 352                 nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
 353                 if (nslabs < IO_TLB_MIN_SLABS)
 354                         panic("%s: Failed to remap %zu bytes\n",
 355                               __func__, bytes);
 356                 goto retry;
 357         }

> case has a chance of succeeding if retried in future while the other definitely
> doesn't, but it's not SWIOTLB's place to decide that the entire system is
> terminally unusable just because some device can't make a DMA mapping.
Currently the swiotlb panic at line 735 on purpose if swiotlb initialization is
failed, but when any DMA requires a swiotlb mapped slot.

 724 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 725                 size_t mapping_size, size_t alloc_size,
 726                 unsigned int alloc_align_mask, enum dma_data_direction dir,
 727                 unsigned long attrs)
 728 {
 729         struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 730         unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 731         unsigned int i;
 732         int index;
 733         phys_addr_t tlb_addr;
 734
 735         if (!mem || !mem->nslabs)
 736                 panic("Can not allocate SWIOTLB buffer earlier and can't
now provide you with the DMA bounce buffer");

I agree it is a very interesting point whether it is a good idea to leave the
decision to swiotlb for a panic. One thing to take care is the driver should
gracefully handle the error returned by swiotlb. Otherwise, there may be IO hang
(e.g., hung_task) instead of an IO failure.

> 
> Similarly for the other panics at init time, which seem to have originated from
> a mechanical refactoring of the memblock API with the expectation of preserving
> the existing behaviour at the time. Those have then just been moved around
> without anyone thinking to question why they're there, and if memblock *does*
> now return usable error information, why don't we start handling that error
> properly like we do in other init paths?
> 
> Really there is no reason to panic anywhere in SWIOTLB. This is old code, things
> have moved on over the last 20 years, and we can and should do much better. I'll
> add this to my list of things to look at for cleanup once I find a bit of free
> time, unless anyone else fancies taking it on.

Thank you very much for the feedback. Looking forward to how this can be improved!

Dongli Zhang
