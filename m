Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2954CBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiFOOwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiFOOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:52:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666F4926F;
        Wed, 15 Jun 2022 07:52:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDwp3t026591;
        Wed, 15 Jun 2022 14:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yENcLQqJnf7XrZE3JlLVkfYeNhx4El2cvqLfSKn0g44=;
 b=ih3MIZR7EnamveQhgdIA07T+kO9w1j0mHFsvhWJmUxOiYCi52Mqz1GSqtHiQtR3EbaW0
 qhX1jEdekjiJNiu+pIC9Dc8/HUPma6IfxSayGkpJzL02kAzQKrQS+fob4JwMtBAgllTV
 c1P0lwR/XfqqzgNCuqSdyYhkCvVuki5Wx10oS8fLhd4loPbhC6G3rjA02N3m0vycgKzo
 Ukq2yKbv9/y0j6HNPpB61ddnSkCU9uF/q8N0Ngap4xO6cfCLcmrEwEy62hrLhsyOnhwK
 GfApQEIRTM8PgzN2v569LeJG3dxAlgsWbtdMotQuzm613BPb00wcN2geRDybdZx3Mi9P ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2rxba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:52:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FEQ7st023103;
        Wed, 15 Jun 2022 14:52:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25vp62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFUkaMbxAuyO8HiS9bB2Ym6fybRU1cQYxiSgFx2bUc0FJA1oKS65NSHi07Za1vT8PqHxOmTTEnRQsMHAg7e9PtS8cP3Go0q4D0w/EUQA8O3F9Stg1bp6V3LV+0m3rYjobZQCzc9pZx0JtKZEBElVRPbyKa1KHNPfQrOMQg7hj5wpNRNJrSPxvtAv83bss7FWhfbqlmBPaRtqHL+KaKo5KejWOBl2bEf5ZVwmqQ/bGRl80uQkGbWZ2ZVLlFukJsNLgtWNwgEncQw2Jt6uUJGFwwEVBBVPJiMbvD521JZ1nn5RovC5uEcPvhWnrJqHHrZCnHZhHsy/awzt8jZfuvWXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yENcLQqJnf7XrZE3JlLVkfYeNhx4El2cvqLfSKn0g44=;
 b=a1vaVoBjC1dg1aMZQd6qr3QppyhkFHp+PQlvPvIlr4K68CtWI0XchbMGY/T8g2OVRY5Zfoyf2Szx5EJm9jk0LgMlb3aHECZhtBYDjRGWiGkhdyhxurq5jpptiZtvq50hiV5ot/8I5Nl9MVfYJLeMmRwqZ9CAqFSBrFeH1Zm+mztsapM0sM2/MQbESWWnLWu99BfUtr0b2AInTBPKzx+AHZZ/3Y8x2p4eies6O1aJcIR2ik+eKAdfoYl/PcoJp8gAswEDY/hD3D5cwhUZgXdWSfdH1y6jBuhjyxR/uMK8tiUiIkSIqa19c5WQwmVnPGVNQJd1UNjKLyT8T5WD7oE5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yENcLQqJnf7XrZE3JlLVkfYeNhx4El2cvqLfSKn0g44=;
 b=TXWiJmDKvXBYFLi9U+tgcAv81DysD3NHrQ5zAwzyxkRMdo+KNol7PKEPeFygrc8CHbV2AkJblCOAWikGbsFIxVbRcRmae+1zNys9MG5UIBSgo7m3FJk53JRcJypFbQ5cDic399Rcz+yYh4lkqSDqf6JP82BYD3jsN0MBy6zF7Gg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 14:51:57 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b842:a301:806d:231e%9]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 14:51:57 +0000
Message-ID: <41e2d762-2c0d-b13b-d6da-6e0e0e858a84@oracle.com>
Date:   Wed, 15 Jun 2022 15:51:51 +0100
From:   Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, david@redhat.com
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
Content-Language: en-US
In-Reply-To: <20220613063512.17540-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::30) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e7dae37-f893-44d2-cd6f-08da4ede9869
X-MS-TrafficTypeDiagnostic: PH7PR10MB6131:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB61313E813227EA65B18373F0BBAD9@PH7PR10MB6131.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D1PQ5XpKRW0uRNuWauRfiiyyjW5R4efRjQiZzU5VyuBH6KDpPoLBq/3QJUrNzi2sXXSLU6ixkIvW16v/rGCbN5TNmIDx8gU62+6JPZ+HITlctdO6dMhYLU0T2qzlDqM4qz3C1vGWikMVzDaQd9CT9PYz4yr8E9wy0IwqP74O/ilU8jm9/gkWyqwvXDBVmktI15dwfDz8k5pHIZWdVHY+jLp/P5vxPrL3DCTCd9jCGVlBxgqXk9bhjsR6BzC3jWWD8MAUvDUjbWaP9gTIo8aMTBJC58HGbP0C5ZCjV9CXmOfZ36HRQ9rvZuIiMbWIeK1A5JAL50AnovbhvJn3P18UTLkJr1BRyQfAweHrZUJeEt7fga8r2+AquwbFS0PK89uuk6Mkmu0EGQ5AS2n8lfivLMmyUVRnSZIrlqfi1wO7ZGD5ugL4D6wNTM/kFbWD1R61JPfIaN/61PZu8WS5aABm32ye+X8k+xRDm7gmvun0tEcO/UeIbgJTtCttHEXb3b9IrYIJvsml9irfShf/cmfPadhaExQ0uiRog9BDuNwv3LeCg5zEO3KRIWu5dcgtTxQlM+WBz9R8wjmFdUu0ZEW8q9nMUwq5j6Yo2grpzkzL9CTb/NFKmyVp7PLrruKTeORE4EqnjgcZHpverDdeN8VEscDO5nZSJSQplv5e/pSchpUFGIrA7ANyiQy1CSKhxRGD006f9utFlbN0wJXYZ5E4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6636002)(8676002)(2616005)(8936002)(31696002)(66946007)(508600001)(6666004)(316002)(4326008)(86362001)(66556008)(66476007)(26005)(53546011)(6512007)(6506007)(2906002)(36756003)(38100700002)(4744005)(5660300002)(6486002)(31686004)(186003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2l3b2pyRE1QUzBBVC92Y0FkU3lMWDVGalZOb3Y2aXVpR0ZkN2lyZXZnZlJx?=
 =?utf-8?B?c1k1UmZQcXgyaHJaWTcxREJCTjY2OVViL0I2VHdnQ09SOGQ5WWxvYWl6eVRm?=
 =?utf-8?B?eHhPVkovL2tXaFlsc2M5UDZObW1BTWxoOGZTZHRUUTZuM2xCenlDQ0RBYU1R?=
 =?utf-8?B?akRSUkJYZWJuN3R1ZWNCenBOZXlVMURPZEhMeVlBdnZ2Z0dVUE9wejVYa3JE?=
 =?utf-8?B?UFlvSVlMRnJ1M2c0dXJUZnovczIyVjkyYVdsYUJCc1JKTDhiNUxNQzVZR0w0?=
 =?utf-8?B?SWl0RmppT1gvVFZoR0tMakFiZ3Y5N0ZqMlNWdnhkVHFaejYyeW1CdWY1cnVK?=
 =?utf-8?B?NzVHdVh5eUFMU0xvbXkzUDBqMzZ5MmN1aHZjVW1VTWF3Q1pNSXpRVWRTK0RE?=
 =?utf-8?B?UjZlWE1aNmxrcm0wV3h4d0hZbFBsMVpOdTA0dXY1c2RSMXFnVVJpejlINXNa?=
 =?utf-8?B?UUUzM29kRmVUc2JHdHcrZHVMR2RraGlhMEhJZ2s1OE9IS2U0YXFZOHIrL09U?=
 =?utf-8?B?bktkdVJ4andrL1hhT2UyRnBhT0RHWGF6OHYxcTdOVThLdG9pdzEwQjJFNExR?=
 =?utf-8?B?SHNLZEVRR2Q1TTBZazRHVVBSSlcwYjVKVml4dXpyZnhVOVZRMUU4QWpRUEwy?=
 =?utf-8?B?SnFhS2lmSDYxQlpDbDJuc0s0WDRpbmFjUHJ1VnkrRzRtK2VpK1hjWlhGYXE0?=
 =?utf-8?B?bEFGdXJ4K2Y0STZyU01tTk9Dc2NDRXlCOE9lUFhoaGNqMTJuRzVoWEg4Tk9V?=
 =?utf-8?B?eG9SaFJMbUhOcUJvMXhLOWd0T0tIRDE4cVJNeW1uOWk3anRoc1RxOFRMRUFO?=
 =?utf-8?B?MzREWURXTnAvbUxoditodkhjS0ppSWkwSU9PVjBLTXU5Z2d2eStVUFlJalg1?=
 =?utf-8?B?OXZYbUxUb1k2Rk1RUytMenlPUVZkOEd5QXBZa1RGcU9nTUZKLzljejduL200?=
 =?utf-8?B?T1FRRXNITjJMQ1NGdGxyUWdicVV0L3Fpa3lHWTFNMHZ6dkIrcnRZWmJZOUtW?=
 =?utf-8?B?UnA5QjV6eEI4YTcxeVdaaFdSS3NvakJOclVlaUtTQjMyZE16S25iTWl1emZi?=
 =?utf-8?B?QUlEaXhpQ3NxTUFUaUlJeFg1WExJMm00aTI5dHQ4aDdSVXJnTFI3Zlk2MGZo?=
 =?utf-8?B?SWhyenlWc3pPb08rWHRlQndCTm9ibHFEb2wyMDFGVElHZWlhYXcxdWpMZjhI?=
 =?utf-8?B?WWhIUDZURk1XcXYxMFBtSE5mS2pSQm8yT2tvVkkxdVNEQTZHaWNPTUhSNm9m?=
 =?utf-8?B?SjlVbnFZelM3eFJZeXRVdE9abkZoY1dzdVNtd2ZSWnFwZkFQZ21HVG5XaURZ?=
 =?utf-8?B?cGFhd1NteWoycWwzWmVSQk81MmtIT0dxeDdLd1ZhSENCT045YTNMNk9OZldW?=
 =?utf-8?B?NDV2MjkwN3kvcmp4V0R2ZlRMSUo0ejRQaDN2ZjhIbjRqRXBKeWNmcFkyS2lE?=
 =?utf-8?B?Y1hNc1JUbGdBVzdvREpBSHpxRjBMZ09FaVVuYW1nSUdPS0ZQSnpZQUtVYlRo?=
 =?utf-8?B?SnZGYjZuN29LVm1NaHoyU1FVUHdoN0xCRlRLRFJNNzNhT0JDWWtORDFoZ2dv?=
 =?utf-8?B?YThMdFUxMnluWlFZQllzRXhtdUZPanNRRHJSeGdSS1M0ZWtKVVZ0RmFTQlZB?=
 =?utf-8?B?MGhwVUdBaXZmSmlnSjhhZVI3bnN6WTQwclRzTHB4dmJqeHpGR0hac1ZxYjJ2?=
 =?utf-8?B?YW9ZOGwxVHJIck1Ia0hRcEFHZkxxaC9EL1lqNXBvbzZKaUlSTFdubjVxTk1i?=
 =?utf-8?B?UExCZEpEZWtYalo3MXJQY0EvZHpISnlDZmRiZE81U1hIL3JRRW5vNFRBcmMy?=
 =?utf-8?B?Q2lLSGNNY1hOajNmaEFad3FqQ1YwWVR2QnZZY0xXVzdwbEdLRmVuUXQrdVQ1?=
 =?utf-8?B?aUxTdEcxbWlEYWMrZThVNU9MRnNGNkNrYzluLzlxd2V3bklIR2NvOEpjRW5q?=
 =?utf-8?B?c0VPU0JpU0xHWS8rbHpibCtqOXN3ais3TVVPWCsxY3lqSkhnVmNOUmJ6WnRw?=
 =?utf-8?B?ZGFoNFJOYkVUT0tJTE9Va05PdUprYi8yU0haN1pPbk5pK2I4UnhNeHJlVkZm?=
 =?utf-8?B?Rm4wSjk5R3hUTFJnWm1xTzdvRzA4MklvK0gra0RDUkc5NzBET2NTSnduVDVy?=
 =?utf-8?B?bGxkVEZKV3hSSC90NDVLV2FkTDRtWnE2bjNubTBxOTRvSWI0NWNQZU9MZ0p0?=
 =?utf-8?B?akdDWjlDUEdKMnlreUpZY3RlaWcvYVhSYjZTTEpjSzRxTzhUVlhmWEdUOGRM?=
 =?utf-8?B?K0NhL0h0VjRicUNUZWFYUUVuZkxsSFZ0bmdRUTVOQUN0c29SOU1rdHdwbVdp?=
 =?utf-8?B?a0FyN2xJUzlrRFR0K3Z0YVZFWkxPQ2o4djNuV1BGQ0R6MUlHNjQ5enM3SkNX?=
 =?utf-8?Q?OhG5DVVnkLAz9ZJg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7dae37-f893-44d2-cd6f-08da4ede9869
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 14:51:57.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YeW+UpBmZz99PpDHyU9gj7PgKBAblbZmVrNPmipWjlR4ByCrP9o+4nGljRIPlIvN7PcnwIcrGkZNu1OPqwrx3ZoKelc3G9OHFU5cBS0+NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=793 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150057
X-Proofpoint-GUID: l8LolC2LKvvSoS2pThErlw8FmvM-TLDR
X-Proofpoint-ORIG-GUID: l8LolC2LKvvSoS2pThErlw8FmvM-TLDR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 07:35, Muchun Song wrote:
> It it inconvenient to mention the feature of optimizing vmemmap pages associated
> with HugeTLB pages when communicating with others since there is no specific or
> abbreviated name for it when it is first introduced.  Let us give it a name HVO
> (HugeTLB Vmemmap Optimization) from now.
> 

Just thought I would throw this suggestion, even though I am probably too late.

I find the term "vmemmap deduplication" more self-explanatory (at least for me)
to refer to your technique ,and similarly s/optimize/dedup. Or vmemmap tail page
deduplication (too verbose maybe) because really that's what this optimization is all
about. OTOH it would slightly deviate from what maybe established now
in hugetlb code.
