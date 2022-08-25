Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98275A13BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiHYOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiHYOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B8FA570E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:36:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PD8c8V000936;
        Thu, 25 Aug 2022 14:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5v1V1grCfabHwIDrK55HaZFk9/w5nJ7XO9wwAtTSuKI=;
 b=EBswV/ko/uHL2o/8rqIdGmfNvzn32/55kxzujKj78CfgTExVCPNl6Ii6lW57H658Sk38
 lgKy7qM+YuY8sBcsG3S22OQhiCrB6t5yy0RVETxXJBfrVYRqDefGTbnk4Y6CfJAN0hcb
 wC3AfsrrV1bohIAanDSabP5BTyzLnRDE74pzLYgdDfkeZKdywrtah9Chf5fjE74iCaBI
 smnq56Q/oiVm+TzyF18BlfjpJFg3Tyuqralm6VLnYZyZOhz5KLeSovfTbR79q2rFhWZR
 cF3tYbtn8Fz1Yj1LwPkquDZzLJuwuX5RSZs5b+jmOTz26tKChevPPjza8eKvVy4c5sON gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvmdv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 14:35:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PDtAD2028353;
        Thu, 25 Aug 2022 14:35:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4mdjnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 14:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUNg5douHcQPz1YuFc9kQzU0C4rm1Q0rRYQzzuJ+FpcQD2d+g/YW3L1dX4fHoO3H/6tx/EI2GTHaKciqDbvkxrfyjm60Xe2t2bhq3rn6Fma46+BT1aEVBJdpM3nNhMNs81XqJ6rQalaghZkzDH//qhsGBLfb1RtwocbJoUJQdcEpfWhFnUq8R5ooGZWO4xF9irIAXu4bow5uKGeGYF1F8mY1Mbs23HWSPZgQf1HAq+/zmDtiZZU7O/1YpSOzAkKSnDX27/TD/JCqun1S5nPlBnKS3ZUjmc+JwZJmq8x1OclGqUHoLm/erlBjY4wGiDsRDkEj/y0kfxU6rEYzJMofog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v1V1grCfabHwIDrK55HaZFk9/w5nJ7XO9wwAtTSuKI=;
 b=ZSiOdesptkiJEdHxTpi2xX1jEtJJ6n6vK9rAMYmE6cgjEDWP/QtLnqP6s7Qww0AHe8wsk7A7MmrriWrQ9Bp0T2OLMbTNKmgrd1l0Y5XRpNCJiA2USl5upOVGViM1U9I4VPz4aTgzMM/VGW3tsIewZ31cBC+EuUjtP2gkn/1j5Wal2GcxjMUb65fBkWKwU9WWpXerCtHDqlXdGoqXHWvtMPyQInf3mMuKzR9PYmr8aLVl/C5ZzB5hc23t776L0vq2HSNQIxA814Sru0P2u7n/RTT5J4bOR8ZxJlMu5Rz864btEhQzIYHfbirxlpQDCtvVua+iy0bTDK0R37BncudMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v1V1grCfabHwIDrK55HaZFk9/w5nJ7XO9wwAtTSuKI=;
 b=PsglkXL5xxWoZAUuqLYuPsaMrXARpOuSOlFD6ftXzNaCY76ttnd4YM7QVVxqEZ4CTCwldhPTSDOtZBJQTOOGXGnSQjiBCgL58WajgMG/5Pda/5s0Imw7ypZJrO3vE6OXQZJxRXvTckDkP2nBG6f3Pej5LhqtTNgwvTAtHsxLHfI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 14:35:35 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2077:5586:566a:3189]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2077:5586:566a:3189%4]) with mapi id 15.20.5546.021; Thu, 25 Aug 2022
 14:35:35 +0000
Message-ID: <28e70b23-daec-d94f-9baf-d99052f8f8a4@oracle.com>
Date:   Thu, 25 Aug 2022 15:35:22 +0100
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev> <YvQzeUUvBVUYh8cn@monkey>
 <0097C4FB-89B3-4CF5-9F61-D017CFE566BB@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0097C4FB-89B3-4CF5-9F61-D017CFE566BB@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a88fc2-da14-4149-658f-08da86a71209
X-MS-TrafficTypeDiagnostic: DS7PR10MB4958:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DX/QO7L/UCZKJI8w90Go/7eMbwj6gmPEVaGEZETQR8M3Bx2YRwxMoTj1GOkr4lBsDOCSdw1BMLBCs01x47trHD5WYR5vnOPlQJMOFBy9v+dl3RCGOXMUfF22k5zNDVVba5VBZFhSXVmmcThUR+sRN0EbdRL8ICZ4j0nAs17ZuZkJ4BMo777Hy9L7LbgxB062uZ89HPEZPM+q53Qhfk1OfO1403eFI3W3UsLulG8sdAjkWNUD7EEG0soO5GHqTCmOTrbZAA2aucla7IKzpgY20CWaqXAAkRWrDFkejfTEgk6KuFWcua7fRrRwQ1Cvt2JMb0UEQ8SWQxIF2sHmisFWnADfruaXW0xsPQ84Esp/+u6BxoOsv9trjPMP9GUPf8dFjF2EI/jxeS9jc4yPNMOmgrwr6zTWRF/3zf0RDy8LbsdcvnqfHU9ToS87rK6OpEk69qT2zL7pay+3bgoLlZaX9zwvG8wl8MHmCwkl0xmz94moOvLcs4LIrv88B0z0qd0n600Hb8ZkFNlZeG3oIltzo56CSAd8i/KcP/duJs8C5Uo8YHdSOxDGbYRSgraYrC7dEAnOwRTaF/kMLFslHwcZ/3U6a30Q8pGGK6kqMyPtzMIu1eBf7UO8ZkTneV+JaGtWVhzFYxAz872zedhm4f0aHtZl9m9wFAjz0klX8YDr1k10e0xPUCUiebDyWgSsRuurEkgzUQSpFIFuL3bbwjAGXistYs6ZEyHWf8bQaBCtzasFGLjnGyrLu+GoKpEVBfd0Xjq/85hq2ZfVB007Uw3yDlLmh60Nsb1rlTNEffbdCn91FaUj91g8H/pTVJeAbAEcjcaHqjnwDmDsN3kYcL7hOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(366004)(136003)(316002)(966005)(6486002)(2616005)(8676002)(8936002)(66556008)(66946007)(4326008)(38100700002)(478600001)(66476007)(6506007)(31696002)(86362001)(53546011)(2906002)(6666004)(83380400001)(6512007)(26005)(186003)(36756003)(5660300002)(110136005)(6636002)(54906003)(31686004)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZGWGNQa0h0UUZvcUcvQURKNitHdll4aEhjNEZyMmRJcmF2bWc1U293TFdk?=
 =?utf-8?B?Q3hPMGdKcGF1SzlIcE5GQ1VXejlndUVHRi9aNTdBSy9NNVd6YTRUK2xZMDEz?=
 =?utf-8?B?cEVINTRkRkU4enVIUUdPMlFKUi9DQW5tVVVtdi9URTQ1MDlpUkNaK1dJYlNG?=
 =?utf-8?B?bVJHWlNNQnlaRDQ0WlE1NElDdXdzc2FINlRRaWw3V0NJQ0dRT1lKNXdhQXlT?=
 =?utf-8?B?M2REVzRIS0VHcUsxdlBnL0wzcWtFdnh2VmxrK04xM0tqVWNkbzMzZFo5ZVVr?=
 =?utf-8?B?RUtmanZXS2NkOEFYa20vMVZJTW5vZThRVHhvTVVCeTEyVDlDVUNwY1FjcG5u?=
 =?utf-8?B?VWNTeEMyVUpuajY1eEJYL0VrK3dtdEZpTjN3Q3ZqTjZQK1Joei9Gci82ODRz?=
 =?utf-8?B?OFFKU0o0NmlkdnpvbXgxZFljQ3pzNTE0bEhxeVNQbU5DaDdPN1pWWjV2OENj?=
 =?utf-8?B?UE43by96Z0RLNmhicHlJZkdQZllvdDhLWXRwWkRmc000QlZGQ3RWSFV6cHJS?=
 =?utf-8?B?TG1sOEJzWHpiQXhiUXAvVXloaE9qbUY1MzJCdEd0ekNWREsvZXJ3YURzNEQv?=
 =?utf-8?B?TUxzakNld0VuVXM5S1VDQzB4V1d5c3paY25KK1QvQ3p3ZWt4Rzc0aG9KL0Rt?=
 =?utf-8?B?aFJZTDdINysrU1BpNVA2S2lzdEx4aUszYUh5YXE0cHBIODdZZ1BVRjdiaVlD?=
 =?utf-8?B?clFNMS91N1o1YjB5UkQvSmMweGdXM0llaFJTTzR4T2U3TW1zYjducktrMUdz?=
 =?utf-8?B?QmR3T1AwS3Vhc3hLVmRVYk5wSEVnbzVYTHZpVWc1NmF2UTMyNkU3OWhZNU0w?=
 =?utf-8?B?MW9BN3lnUFJUQ1NIT0VkYXpTOFlIVVhJSkpqaTVyU0lWbGx1enJOYnlJUm8v?=
 =?utf-8?B?N1J5VjkzbnovVGhEU2Y5NDFHaXRaVHVKMEtTVjFMbFFBcEVxSmZDUWIzdHpZ?=
 =?utf-8?B?Yy9MSlJGK2wzbHl3Zk1sWS9RZndMNUlrSnQ0cDFiSlk3OG43SmF2TU40OXVZ?=
 =?utf-8?B?OWZlUHpDVFBYZU1iT3pZREpkZ1ByVXlRR0RSeFdmV0dENEZ2cytPUnpYTnlD?=
 =?utf-8?B?MTFSMXB5RldtTXkwSjR5bnpwajQrblppV3dyZVJDQXVZbm5QSVc4YTBRek1z?=
 =?utf-8?B?bGE5V0w1YUtsMUhHVmRYMDdXYk9PR1BPN29oV3Foc1ROZTZCcWd0TlJJMWs5?=
 =?utf-8?B?dWV2WXJ1UVNmMjB4S0pIMHc3ZUs4cVJ2bGpvU2M3bmg0NG1QVlJYSFZ4cERL?=
 =?utf-8?B?RGRYR1AveVdrR3RpSVJFWEdHOUlmdERCMm9GblIzcEwwelhzVDdiOG1CSFls?=
 =?utf-8?B?RXVjUUNJYTcyRi9XdXJpUG5UR3FWeW90SjR6cDNwRWZ6UnNCNnhwaDQ5TDB2?=
 =?utf-8?B?TDkvME5HTFE4aHltNHBidnZWY3NxOFF5YWpITlZOQjZCeXhFd0hFdnlLcC9y?=
 =?utf-8?B?cUxmTFgySXJTTmZCVWUzRGFNUHZnY2Q3VTJBYnpQNjgwRWYyOGJhTFpQc0pT?=
 =?utf-8?B?VTFUaTd0SHR6WC8ySFhOVlNXYURQM2g5ZjJFcWRUOUl5aUl1MUplQlpYd1dY?=
 =?utf-8?B?M2tYUFpaTWZmaWcyY1A1NFgxbmFVbVpEWjRYQzg2S0lPOUxnRGdyMEwrN3c2?=
 =?utf-8?B?WGZSZHBraGg2a2VuMkl4K1JLSnpvalNidCt3NFZFKzFLRzlzUWtxS2w2MDQ3?=
 =?utf-8?B?RFJlL1p3bW81cExxWG1adXZrbFZ6ZXByUDFSV0tIQ3NRbHZCOFFQYnphSXk0?=
 =?utf-8?B?WCsybGN1WWM1dHErM0M1TTd4emkyYUlQVFN6bk5XWFoxVDE2N2tnblFVaGtq?=
 =?utf-8?B?OG5zUm5UZWg0SmRESlN1VjVkVlYyemlpVkp4NEM5TlU4YUMxREd0VGRSQ0tE?=
 =?utf-8?B?N2VsK3Iva3ZkWlZieU1Sc2xtbW5BaGRTS2s1d1hiR2F4ZlpPU1lDb3dWbUh5?=
 =?utf-8?B?dGJXSFpnNXltbDRoUjhYTXlOOTdEZEV1Q2tKTFQrNXMzaktkaDJlZHJhZ09R?=
 =?utf-8?B?Wk9oMFE2OS9MN09QSFowdzJoMjZjVm1rVzBWandIanNwQlk5Y28wMHoxZFZC?=
 =?utf-8?B?clh2YVJYMEU1TXR0alpCVHd6aHMveXArVTl0cEpyMitQSy9DK3h1aUNuVzc2?=
 =?utf-8?B?Qk5nblM1OVN2VVRxL2tJSG1vYXA4TDNKdWpZRDZHcWFGb3pudlR4Vy8ydndw?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a88fc2-da14-4149-658f-08da86a71209
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:35:34.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAFB64Atltzl4FeR3NGWYYEzzw/0Pr4s4C1yIOTlLSEkLMWL05MokzivJxCcvlqq+iwKlDKvD/pqmGaxkkJm6LdzqF2KBD+pSmYvhAD556Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250054
X-Proofpoint-ORIG-GUID: AObDEwugmyHa66LAopIT4pVA_D2kS1Yq
X-Proofpoint-GUID: AObDEwugmyHa66LAopIT4pVA_D2kS1Yq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 06:36, Muchun Song wrote:
>> On Aug 11, 2022, at 06:38, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 08/10/22 14:20, Muchun Song wrote:
>>>> On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>> When creating hugetlb pages, the hugetlb code must first allocate
>>>> contiguous pages from a low level allocator such as buddy, cma or
>>>> memblock.  The pages returned from these low level allocators are
>>>> ref counted.  This creates potential issues with other code taking
>>>> speculative references on these pages before they can be transformed to
>>>> a hugetlb page.  This issue has been addressed with methods and code
>>>> such as that provided in [1].
>>>>
>>>> Recent discussions about vmemmap freeing [2] have indicated that it
>>>> would be beneficial to freeze all sub pages, including the head page
>>>> of pages returned from low level allocators before converting to a
>>>> hugetlb page.  This helps avoid races if want to replace the page
>>>> containing vmemmap for the head page.
>>>>
>>>> There have been proposals to change at least the buddy allocator to
>>>> return frozen pages as described at [3].  If such a change is made, it
>>>> can be employed by the hugetlb code.  However, as mentioned above
>>>> hugetlb uses several low level allocators so each would need to be
>>>> modified to return frozen pages.  For now, we can manually freeze the
>>>> returned pages.  This is done in two places:
>>>> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>>>>  We freeze the head page, retrying once in the VERY rare case where
>>>>  there may be an inflated ref count.
>>>> 2) prep_compound_gigantic_page, for gigantic pages the current code
>>>>  freezes all pages except the head page.  New code will simply freeze
>>>>  the head page as well.
>>>>
>>>> In a few other places, code checks for inflated ref counts on newly
>>>> allocated hugetlb pages.  With the modifications to freeze after
>>>> allocating, this code can be removed.
>>>>
>>>> After hugetlb pages are freshly allocated, they are often added to the
>>>> hugetlb free lists.  Since these pages were previously ref counted, this
>>>> was done via put_page() which would end up calling the hugetlb
>>>> destructor: free_huge_page.  With changes to freeze pages, we simply
>>>> call free_huge_page directly to add the pages to the free list.
>>>>
>>>> In a few other places, freshly allocated hugetlb pages were immediately
>>>> put into use, and the expectation was they were already ref counted.  In
>>>> these cases, we must manually ref count the page.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
>>>> [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
>>>> [3] https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.org/
>>>>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> ---
>>>> mm/hugetlb.c | 97 +++++++++++++++++++---------------------------------
>>>> 1 file changed, 35 insertions(+), 62 deletions(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 28516881a1b2..6b90d85d545b 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1769,13 +1769,12 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>>>> {
>>>> 	int i, j;
>>>> 	int nr_pages = 1 << order;
>>>> -	struct page *p = page + 1;
>>>> +	struct page *p = page;
>>>>
>>>> 	/* we rely on prep_new_huge_page to set the destructor */
>>>> 	set_compound_order(page, order);
>>>> -	__ClearPageReserved(page);
>>>> 	__SetPageHead(page);
>>>> -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>>> +	for (i = 0; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>>> 		/*
>>>> 		 * For gigantic hugepages allocated through bootmem at
>>>> 		 * boot, it's safer to be consistent with the not-gigantic
>>>> @@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>>>> 		} else {
>>>> 			VM_BUG_ON_PAGE(page_count(p), p);
>>>> 		}
>>>> -		set_compound_head(p, page);
>>>> +		if (i != 0)
>>>> +			set_compound_head(p, page);
>>>> 	}
>>>> 	atomic_set(compound_mapcount_ptr(page), -1);
>>>> 	atomic_set(compound_pincount_ptr(page), 0);
>>>> @@ -1918,6 +1918,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>>>> 	int order = huge_page_order(h);
>>>> 	struct page *page;
>>>> 	bool alloc_try_hard = true;
>>>> +	bool retry = true;
>>>>
>>>> 	/*
>>>> 	 * By default we always try hard to allocate the page with
>>>> @@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>>>> 		gfp_mask |= __GFP_RETRY_MAYFAIL;
>>>> 	if (nid == NUMA_NO_NODE)
>>>> 		nid = numa_mem_id();
>>>> +retry:
>>>> 	page = __alloc_pages(gfp_mask, order, nid, nmask);
>>>> +
>>>> +	/* Freeze head page */
>>>> +	if (!page_ref_freeze(page, 1)) {
>>>
>>> Hi Mike,
>>>
>>> I saw Mattew has introduced a new helper alloc_frozen_pages() in thread [1] to allocate a
>>> frozen page. Then we do not need to handle an unexpected refcount case, which
>>> should be easy. Is there any consideration why we do not choose alloc_frozen_pages()?
>>
>> I asked Matthew about these efforts before creating this patch.  At the
>> time, there were issues with the first version of his patch series and
>> he wasn't sure when he would get around to looking into those issues.
>>
>> I then decided to proceed with manually freezing pages after allocation.
>> The thought was that alloc_frozen_pages() could be added when it became
>> available.  The 'downstream changes' to deal with pages that have zero
>> ref count should remain the same.  IMO, these downstream changes are the
>> more important parts of this patch.
>>
>> Shortly after sending this patch, Matthew took another look at his
>> series and discovered the source of issues.  He then sent this v2
>> series.  Matthew will correct me if this is not accurate.
> 
> Thanks Mike, it is really clear to me.
> 
>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead.org/T/#u
>>>
>>
>> I am happy to wait until Matthew's series moves forward, and then use
>> the new interface.
> 
> I agree. Let’s wait together.

Maybe this is a bit of bad suggestion, but considering that the enterity of kernels
supporting hugetlb vmemmap optimization are using the old interface (the new one isn't yet
settled it seems?) would it be better to go with something this patch, and then have a
second patch (simpler one) that just switches to the new interface?

	Joao
