Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3853D5A1C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiHYWbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbiHYWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:31:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48937B941E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:31:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PLK6rH010804;
        Thu, 25 Aug 2022 22:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=fbhwWulR1PoMcmxiA6Zo8hGhJRC4A60cpSRXl0rLLZo=;
 b=o9HVkSkYIr0q+vFfpL65cKDth5cs7LaB6OtBzyHHzCvLFqWTHwia9CqtyQDooQbptVFa
 zUVImBxF+08KZitP4+xu3Z0N2sQyYSdrmIzVkVWlpSTT5PquX5FR+LXGW3gQ5hGEMbqj
 sqK89qeAI+N4OZq9szXO51dc+9L/nguflPh8653iplRu9xULk8IQZefSdf1LHUW3hn7e
 1tunLj5iTc4/csfthF3KspG8LrfEr1LWt8saMF4QU+55ofOe2oAxE9Co5aL862uFmGtO
 leFnvFWap0vOxawDoXqaWS2xkqYSfotyZxbtA5iDin9xUPKkIT4vsh+pjKv4ZvAT6I0N /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p268r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 22:31:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PJwQJS017822;
        Thu, 25 Aug 2022 22:31:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7cb3ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 22:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsF0ZYxPIN+fRnx5GgN6TV5QaPvnIvF4L23mD+KqXirfvyXYGCbkAJ3ADxw3F+HIW4b5DyHhm6sRtm0Jcnn3mGzBmiWLGnsP0pycJUhgzGNXpPGMQrkdjk//UgWmDzrL6yUHVxKVdftCjXB5HClyN078jCWLKnGbYe3yGnHnVQPN+swWmPiJnyeylN3xxNbwJJ1Kah4ISrwbHSMqt3vxSxZs/W17/BhpT8xnojw8Nuhp6EuvSf7ic/TuMAu0dLi1581/Vre4zGD71ADzkPCEB0hIp6ekFQzysS86VChkYVxdJhDb6vU3UjEnkLbm5nIKezoVrNDWWfBPXcE/HUcijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbhwWulR1PoMcmxiA6Zo8hGhJRC4A60cpSRXl0rLLZo=;
 b=GWKErnwBhgWJNye6TsHH4CvWlnZWf5MGcAQOsd7FOu2MSzq9Y8ub3fJ31GYlp5Qqv/bwXpiRNqR7oMZo38trOZw9+ChMbAJQKlkLrp5D/Va1+g8t2ExjX1Gly72SOrg3DQvlvl6kzRjadRyilBozVP0RJSVlrV7XufuAcdFvGbdP2dM+l5IrJqMLPP5CyUPkakffkrkcwqEXe61GWOhfaT5O1U0eFT2CCIXC+YHh8KOf2YOUZUNj2XGGRS7oni0Y9bcBp+lxlZOq8M861RfMbS2PkMAoZFwu/n/WyXzNyKwfLWFJsMdT8MRH5KhE1u0Eazd2pI+T/N4uhxmyc7VlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbhwWulR1PoMcmxiA6Zo8hGhJRC4A60cpSRXl0rLLZo=;
 b=QklV2//bYjpjr7NqgSwjT9GBv2U3E8bgR0sS0C1P3RbwHO7qfvrTAQqLslZgu00bB0Vm8wWhMY0w/zdp64UkrB/z3LUQBwne0fU7cbB4nS0trfWz0YytrTHTmH6zfXw6iun4stKAoJm8zhX1+tNmudr08YRPBqJOPef0AjOV+l0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2428.namprd10.prod.outlook.com (2603:10b6:5:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 22:31:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 22:31:10 +0000
Date:   Thu, 25 Aug 2022 15:31:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Muchun Song <muchun.song@linux.dev>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Message-ID: <Ywf4Kx0isZai48As@monkey>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev>
 <YvQzeUUvBVUYh8cn@monkey>
 <0097C4FB-89B3-4CF5-9F61-D017CFE566BB@linux.dev>
 <28e70b23-daec-d94f-9baf-d99052f8f8a4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e70b23-daec-d94f-9baf-d99052f8f8a4@oracle.com>
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0fe10c-1064-478d-daab-08da86e982c3
X-MS-TrafficTypeDiagnostic: DM6PR10MB2428:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRBmKWD0WS+ZSYmv8ijuCFgV29McbKjgCEJ3Ekdnbz2ZKl/g5jC90NxUnqamZrkn0vG9S+KQkTNueXlb5IAbGkNoOKanPHu0Xe+TsE920ZNbfzb7ObkmmFzCTh0WGXFIJvi6Cc+ILYDhWi8D2bi5A4Z7ZRhsFbfrAylv9XI6Viz6WjEUVCfYhqvTUbwKL5sez0akSmr9ROpqjd8RI02uBZEgmDIedGtqsnW37q+NUOxy2E+A0OqoGcs6+sEPPwHjOFBMY3Vatglg2LNJep7TiiAsgG1pxhCIK/cu8dZUMtPurjDumS4DF+8UdoD6qYA4W2U1axLkdBrX0jbHaVqa3wlQXo0Qo2FSv/DtMutmC+w1iOEDXtPbFbZKz3YT4JJb7NiMrWsw9QcxQ4pEPax8H20IxhBA8t0CW2fpetucz4Hn+oUNU2NELqr2jx+3qV57SqfJWvbNW5yn5c4myiWWc0RoA1lTcoC1s/JxZn2OHXOn+1ximPLEpUcDepjIOx3AX9+NNUPb2q6IPAlcmgZq5e/nXkej8vP24RVVt8DmT1pxRAWsMcMX0fSTjKtVmPh366VFnhAKYvuHvYyVWCejGPj5X7W5gSB05u44a70a2EQQKkLcT5hUk+i+KY3qNxRRw5gG1aNSLG3ShR/e7tFYu9+U6UhTVacMOikEdk7MMrF09bXfZa49CAObCSNvG2eFWv5PU5J4X8mq1M4J5bgm6XlwTK1j7DR7J3tMgROTqk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(346002)(366004)(136003)(396003)(2906002)(66946007)(44832011)(4326008)(8936002)(66556008)(6862004)(8676002)(33716001)(66476007)(966005)(53546011)(5660300002)(6486002)(54906003)(6636002)(6506007)(478600001)(9686003)(41300700001)(26005)(6666004)(316002)(6512007)(86362001)(38100700002)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ltWGdNblgwR09DMVFCaVRBd01YQWZRU3hQRmg4RUJVajBGK1Q3YWtyL1Zi?=
 =?utf-8?B?Q1pwQ1RCWGNOVWlqeHM3eUEzQkNLR3lGR2lSOEVWbXhtbU92Sk5Eem40eTM2?=
 =?utf-8?B?elBqak1seXlZT2NubWRNSzMwMXhRTkN0YWJTK3VxVjBiem8xRUJ3dzRQSGVS?=
 =?utf-8?B?cEppVnM5VklzNHRlVy9ZN3Y5RkY2cUx2c2FXMmtEZ2gvaEZlSzBwK0lMZEt6?=
 =?utf-8?B?RFFQYkEwc21NbmFzMjFBQVhsK3ltMCtRNmxoR1RkbVZNQlkvb0Ewb25CMVBn?=
 =?utf-8?B?RU1NcStvWTZOYnA3K29va0IwckE2b2lTMG5uelg0ejRNWWhOS3FlRy9UOUxr?=
 =?utf-8?B?WGxEZzYyb2krSmI1V2tlSHg5aklwZEtnTmxnRURSZ0xTenduZ1MyZWtYdjIy?=
 =?utf-8?B?djBrMC9QVFhSV1RSNGl4ZDhVcXh3TVZZZEloU05EeEtnQjZndERBdXVCU1Zw?=
 =?utf-8?B?WXo5dHFTRllweVRvTmtTUUdod0dPZE5pYUdsdk96T2RiUEc1WWE5dGdhOVk3?=
 =?utf-8?B?NkxkRExwOURLTTUrQ2lnQUlodjdFR2FKbzRiSGY0UythZmNDM1NiK0s1cmR2?=
 =?utf-8?B?d1V2aWFqamk5VkIycS9iNGpocCszRnZLeUEzbUQ4ODlmQmVpMWVaYytpWXgy?=
 =?utf-8?B?ZGl0Rlg5czVHeVNtdnA2WUswTm9KNFFyaU96QWZpTUI2NkdPZDA1SmVpZUJz?=
 =?utf-8?B?NStVOTljV2thNlB4SUNiZWlRRUtCRzVEQWtrdXVqcDNpbTNQdGVRUTArWW5D?=
 =?utf-8?B?cUZ5dlh2OTcwbm9NME13akNlcHJWTjhJZEpoRDJvdTV3WWQyUTQwcDAwNlRS?=
 =?utf-8?B?ZW1NRHlUYkg5aEtyN2VQVFM4WnEwTWwzam9GL0s0aVcyMFk1L2oxT2RLaDlO?=
 =?utf-8?B?M2xSTGJTdkh6Z3ZJZVBxdVd0WVlQK0o4SWlaQjk2N2ZZQ0JjRVVNdTVaVnJQ?=
 =?utf-8?B?Qk95YjhCU2kyblBTTUgwMTF4c1p0NVU1MEhGM3o2N1dVK3RCUXlIVjFXb0JX?=
 =?utf-8?B?OGdRZkppNE1VSW5IdXhsK3NEZXhiWWlhUk5OZWNvbjBONTNLQXlwTUJMYXNB?=
 =?utf-8?B?TXRlc0lERkFSRy92UklXRFJPdEdCdXVISTZaVHQrRkNONDZwQ0d0NTV5R0Zx?=
 =?utf-8?B?TVIxak5LOTJSRmhSeVlDeGdMRHhWdWtlOVhoeWg4bDB3emRhTi9WTnZiL3lj?=
 =?utf-8?B?UEF6S2Y3S0dqeWM2eWMrZmFMdlFXTGtLZ0p6amdHbEJ4aHV5SURNbkZwUUw5?=
 =?utf-8?B?U052dGEvWS9zKzdvZzVVeWY3aUJza0xlYnJyWU1id0F2TWRhVUJ2MytjemFt?=
 =?utf-8?B?REdDUGNXOVhUQ1ZqVkdNRVpDejh6bHYra1hvanNDeG9vNlZ2TjRNdmNobkR3?=
 =?utf-8?B?aFZuQ2FtUk8vRmVsdE5lbUlUQ2xpZS9OTVRjK3cxVmJMdzZGN1FhZXBVS0xn?=
 =?utf-8?B?NkV0cjBkMVhNS0lzZ1hhbWNqZ2F6UXBrR2ZRRFExOUt2S0w3dWs1ZGk5bGQ5?=
 =?utf-8?B?Qmt6OWhOWmJVVUo3OUFGQ3AvWm5nc1RvZ2NKMC9vUVlpRmVYOUJpUHRqaHgx?=
 =?utf-8?B?bU02NmJqMkY4dlIzN0hrMnVpNG9HNDZmdDJvVi95cHBVQWlmU1JWdlNBYlB2?=
 =?utf-8?B?VWR4RGZ0am1abjFqQXZBM0VFdjJiQWRWSEJiV2lzWDJMSXIvaDBYYVlLdUd6?=
 =?utf-8?B?SHZjbUozSTIxc1ViT1hwRXk3SW8rSUdjV09GcVhYWjlSUmV6MVZnMHpVUjVo?=
 =?utf-8?B?YWp6N3JScFV3amlwRVFTQ2xxcDNIOTlobmpGbnR1bE4veWNjR0NaU3dtUDZV?=
 =?utf-8?B?K1p4MEt5K3drNVRYNXFMR0hONkFCQmlieWROdGtJWmp5NzBDcWVCRmpxWno1?=
 =?utf-8?B?b1ZDeEhRanR1WVMxQ2FMSDU2MVZLRlZNTlB4cUlWZ1ZSVHFURFRPaHdVMzFN?=
 =?utf-8?B?RmFwSS9BTEdXdWtQV1FHQUFwQU9EZEJ5bEpNTnplb2taZ2tkUWF0SFdUc2NC?=
 =?utf-8?B?STFVM2pHMUtjQnZPSXJzaDdqbDNCLzJScjRFWjVZUGt2eXA5VmU0dFB1M0lW?=
 =?utf-8?B?UHo5a2tGb1RTRWdGRUxJR0tUVHh1R1MwVzZHMExkN0dPK1AwR056MTNlSll0?=
 =?utf-8?B?NFBuZW4wQVRwdlpxeERFM3hDdURtTnlvZEcvMjhqa1MvTG1BWkltS1R4WEU3?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0fe10c-1064-478d-daab-08da86e982c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 22:31:10.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4E77xIxsg6Vs9le113pe1aGnCRVaD20HG6BHwDWVVUlwkbGEoz4GbHXNCrx47Di1mqkT0XLB8AfiiUJvJ2ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250086
X-Proofpoint-ORIG-GUID: e56DPpuci75lcq8dDYnzMPPGbE_bqBgY
X-Proofpoint-GUID: e56DPpuci75lcq8dDYnzMPPGbE_bqBgY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 15:35, Joao Martins wrote:
> On 8/12/22 06:36, Muchun Song wrote:
> >> On Aug 11, 2022, at 06:38, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 08/10/22 14:20, Muchun Song wrote:
> >>>> On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> wrote:
<snip>
> >>>> There have been proposals to change at least the buddy allocator to
> >>>> return frozen pages as described at [3].  If such a change is made, it
> >>>> can be employed by the hugetlb code.  However, as mentioned above
> >>>> hugetlb uses several low level allocators so each would need to be
> >>>> modified to return frozen pages.  For now, we can manually freeze the
> >>>> returned pages.  This is done in two places:
> >>>> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
> >>>>  We freeze the head page, retrying once in the VERY rare case where
> >>>>  there may be an inflated ref count.
> >>>> 2) prep_compound_gigantic_page, for gigantic pages the current code
> >>>>  freezes all pages except the head page.  New code will simply freeze
> >>>>  the head page as well.
<snip>
> >>>> 	/*
> >>>> 	 * By default we always try hard to allocate the page with
> >>>> @@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
> >>>> 		gfp_mask |= __GFP_RETRY_MAYFAIL;
> >>>> 	if (nid == NUMA_NO_NODE)
> >>>> 		nid = numa_mem_id();
> >>>> +retry:
> >>>> 	page = __alloc_pages(gfp_mask, order, nid, nmask);
> >>>> +
> >>>> +	/* Freeze head page */
> >>>> +	if (!page_ref_freeze(page, 1)) {
> >>>
> >>> Hi Mike,
> >>>
> >>> I saw Mattew has introduced a new helper alloc_frozen_pages() in thread [1] to allocate a
> >>> frozen page. Then we do not need to handle an unexpected refcount case, which
> >>> should be easy. Is there any consideration why we do not choose alloc_frozen_pages()?
> >>
> >> I asked Matthew about these efforts before creating this patch.  At the
> >> time, there were issues with the first version of his patch series and
> >> he wasn't sure when he would get around to looking into those issues.
> >>
> >> I then decided to proceed with manually freezing pages after allocation.
> >> The thought was that alloc_frozen_pages() could be added when it became
> >> available.  The 'downstream changes' to deal with pages that have zero
> >> ref count should remain the same.  IMO, these downstream changes are the
> >> more important parts of this patch.
> >>
> >> Shortly after sending this patch, Matthew took another look at his
> >> series and discovered the source of issues.  He then sent this v2
> >> series.  Matthew will correct me if this is not accurate.
> > 
> > Thanks Mike, it is really clear to me.
> > 
> >>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead.org/T/#u
> >>>
> >>
> >> I am happy to wait until Matthew's series moves forward, and then use
> >> the new interface.
> > 
> > I agree. Let’s wait together.
> 
> Maybe this is a bit of bad suggestion, but considering that the enterity of kernels
> supporting hugetlb vmemmap optimization are using the old interface (the new one isn't yet
> settled it seems?) would it be better to go with something this patch, and then have a
> second patch (simpler one) that just switches to the new interface?
> 

My thoughts.
Right now, the earliest any of this code would be merged is in 6.1.  If
the alloc_frozen_pages interface gors into 6.1, then it would make sense
to just make this patch/change use it.  If not, we can manually freeze as
done here, and switch when alloc_frozen_pages becomes available.  In either
case, this could/should go into 6.1.

We still have a bit of time to see if alloc_frozen_pages will make 6.1.
Ideally, we would wait and see.  Ideally, I (we) would help with Matthew's
series.  However, I am a bit concerned that we may forget about pushing this
forward and miss the window.  And, since Joao's optimization depends on this,
that would miss the window as well.

Matthew, any thoughts on the likelihood of alloc_frozen_pages going into 6.1?
-- 
Mike Kravetz
