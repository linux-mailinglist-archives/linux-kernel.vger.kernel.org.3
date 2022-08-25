Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613F5A18CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHYSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiHYSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:30:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F633A12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:30:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhc0J023635;
        Thu, 25 Aug 2022 18:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=/O4bPu4e967wC6DGJpY0pjkqx6ZsVeV/zcER5wkfuVw=;
 b=EEEwW6HElmzkLf2CunfZwpEmkRD2Bwfj8EAatZ0bwjLLnJboShyfMMT4ge83yejQbh9w
 jcGITy4XMXrN06+NRFgrtCREfuq9V3Xfa9dEJF2mghbDvgyvBVgbAzr6vd267TDhovLH
 tV12hrfRotVSl0PbQKk1D/NNmA+kiuaXSyV2yhcE9GVHQ6OJz0tL6xQLLv9mte46kFHe
 r8s3ei1d+50zCCZl2sllB4elPAnLtRWf1a7DTh9ZBKFs+QkD009Z/pF59oefuLw9PvjY
 0EQL/gDKeY3d5FKwyxJjZ0lRAe7YhnkiLcUF4L1wqm2uwkyQ+UtibHgLTxFvSkY5lQrq MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww4xm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 18:30:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHdo4W009744;
        Thu, 25 Aug 2022 18:30:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6n8vsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 18:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEXBIyER2Zm1p4u4ivMu6fFCoyWTjm5pgK7RP0QhbMC09zIuomuW7EI26KapbV0eCfgvmTI9k6aFvcxnWzByMufjwilUcnByIPe9MysrnmvcM+ijFtuvO+oHEyJxxEQ+swuYFDzTtcI7gOQ3fgUUppvxM76GYUoxECFbHTkfnG5mE51KM85EmeUzIJb2D2AqxKSeUFFyARvqBnGoUY83VyW8ST5YDgselvkgRm0qDqqi2sFMNXjaMu1LtpcnOkaoZsnpy/yaOI+SpoeSohkqhI+I3g9fBsqxteRE5GeWaTxmQv8SmkyrnwkqGU+jurufGEHsMd8zuoZSOluEVh6UHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O4bPu4e967wC6DGJpY0pjkqx6ZsVeV/zcER5wkfuVw=;
 b=cklux7wSGhaCfKKgkwsaoq/6tRqbSRCCjZfEJLlGzvsPyAFc56US3adUyokFPb3Cefmm6RhLlx1v4zaCp2yYu3aSNG62uwbT7+v9ClViLvYBhptSaW7yie6v4dnrmeowVKjnp+3AQg7xA/RqM5JltIX6cttwe0KgJB5kHCEZoKYsHpa+7ddICe3Wmy9x+oixz4daIVNTLwk+4qdbehXjUeANqdQ1PhnFuoqG5wKuNlRkr+7hOkF/lp8i7/IAHOB5rOIqe/a8ZfmK9rQCtL7Dcq96wKJnRUog4bT5nAK2C3arbW/sZ6kat0fVHfXCpvWjKbPvlpbNIVmoXZBS5hQFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O4bPu4e967wC6DGJpY0pjkqx6ZsVeV/zcER5wkfuVw=;
 b=D/sQ2flz694jM8qdeyonDxRivzaYgCWfNUb2wkvP1FdEgUTdl2Brn2dIL4ZlMXVkLLII+M59u1VMacDUgWkgPJ4lB8mXhpbF4D77drWG0j6D1HsSY7XfP0J8Z8f4imYdEGWDK6RQDPvx73LzQE/lBsXf2ndc0/H6dRmnr/mAkR4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4034.namprd10.prod.outlook.com (2603:10b6:a03:1b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 18:30:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:30:21 +0000
Date:   Thu, 25 Aug 2022 11:30:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <Ywe/u6c0yPMuEcR7@monkey>
References: <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29f1486-a4e4-43e6-62d8-08da86c7de54
X-MS-TrafficTypeDiagnostic: BY5PR10MB4034:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIc30WPK9fB70IR0QYhZTbsl/uzqzK0bmAC4qCVjIwWNrz4ZGg5lFyVb0YcLN8JpBrWVYxnKnRndbLSRRhuIw5J6+B4tKEarEvGSwM4g5GgcJySJo3PxC+qgweWA8PNNBhEGTLvzR3ZMNLJKPW1gWqJMC0Js3dgbwuUaf0ogKVaENhiKlylGx76K5tix8U0hBZ+5upZQvAUEkmyowW0WW4f0GGAEQ7sesD7CKelUDBJT7akpWwOcESHKJ8ir+S8FxXI6GPKWAMVDIOqNrC+/EpsxG7KC9Wl5ZOpRNZYKre+eF4mNC2X1whiHOi0SMAGRWnDEJe9hpuQxwAV/4xH+gj6QWbr1b0yhGuS6bAtAvFG0tPFA4GW3J5gqqUhyECnHD4SZRCUw1kP0om+aNRjzcFQKiRbQjnDfB/MNLcN7QqgvkyVxUkQOOdOdc6H0/4oP7h+ZMFzRRMORvA/sYPZyiykMyuBRoVbZk6E9i6byHiSXQeafugtPtlU5AAZOfCKk9dkja8lgcd2hDE5Srg/Hk9qvrTA1n+y31/bJzOpbPeA6TLoZmjcDak3lBj+kv897sQ7kF5PggyPHAveDikkqUkM/s9pgJWZj27P8tzBgdBxr/H/SRSbtELda0ONHbYpL98hJT2cG3xmSjlK6VFApdpIjPS0v0s8Eh4rv9ZwUsy7+z5NRa3Q3PrvmtAVoefesfbZ1g9PAmdZLxEFY2dkK4Ron7rbvOhOPe1gFsO7JxvNd18SIkFhm+nYryj4szP77tF2jE2wrYsoIQivb67km4OK0Rdqr15+y6Nkif2ZQnfMYIMn5LzqYJMxbPDcECaSE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(83380400001)(8936002)(44832011)(316002)(6916009)(38100700002)(5660300002)(2906002)(33716001)(86362001)(186003)(41300700001)(26005)(6512007)(478600001)(66946007)(53546011)(8676002)(6506007)(66476007)(4326008)(66556008)(6486002)(9686003)(966005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2p5REJUOTdYTFd5cEJVVzRnYVBURCszK3E2NDRRWXhuYTJSRnFiQUR3MWN0?=
 =?utf-8?B?bk00QXZtWnhPUWIrdW1BMHB2NTA2U0EwWXpuVGxmRjFaYkdZeUZEMndydlZz?=
 =?utf-8?B?KzVjbElQZEUzbWtPQzc2djMvZzd5QmMrTi9ONE5LK1k5cTR4RlRBNWFaWmpR?=
 =?utf-8?B?d0laMk05ZkUvblN2M3hNOU5qT0pTMlo2TGJHU1BRczRNYjMreTVYcmlIUi9m?=
 =?utf-8?B?K0JFSDFiTWx6amJSU0pKNlMwamZjU0FaaW1hYlQ2dWR0RExXeDgyaGlxdW81?=
 =?utf-8?B?eTNKTEw3ZjQ4bDlidC9xWDJHVVo4SWlXRmNid3o0OVhUTlkwU1FkVnhTNEZO?=
 =?utf-8?B?bTZ0QTlMTUIzZ0lEd3N2Q29ha21iajE0emVYVnVTN1NiTHQzajN3SUFZcHJZ?=
 =?utf-8?B?UmdBUjB5anZ4R2lMQXY5Skp6SERsd2ROd0FybHpoMlZLYk5hTHQzSlplRTFu?=
 =?utf-8?B?U241bTZKUG9peEdCZkxCa0JUQWowU2wwbGxKQW9lTEx4THZxeUpibEVPSHlr?=
 =?utf-8?B?d3kxd0s5WVV2MmVzTXR4OVBPZmkzY3hlaUtqZTk4cE1KTnVjcDFQQnozTk5t?=
 =?utf-8?B?WmJMVkhzQkEwSXAvRG5pWi9aQnVlcThaNUNVQWFoQTN1Zko4VDg4MjNjTU00?=
 =?utf-8?B?Tk5JTFV4NVNpNzc4aUx5elpKMW5VQnhaeVlMY3JWcFdNV1A2S09qU0pleGVy?=
 =?utf-8?B?a1pGOU4yeTdTNjNqdzZ5MHBWWE5sVzVtV1I1WEg2MzVkdlROeGx6dm9nR2sx?=
 =?utf-8?B?UEFYcUdEUTlMMjN2VlRCOWt5TVdsLzMxNzVXa2ZJWlBKTmpBbWMvSWJob2JW?=
 =?utf-8?B?ZEswNVBzeTV6Z2M3UG10OXNYRTBlcnU4TDd0cDEyWGF5QWR3NDFEaHhhaGZs?=
 =?utf-8?B?b25FSURibUtlV0VVM28xMmhFREFLZExUUW52ai96eEdoMUxOL3pPWjJZeW9S?=
 =?utf-8?B?NDI1WmdDSE5KMDhsbFhMODdBaXpJRSs0aW5Ma2ZDVW41azJSQkFDK3RTcFZy?=
 =?utf-8?B?M053YWVSczdvd1pIZ3QxYUdmMDJ5enZLenJsNHJIMHM3S09XRVZGaDM3RUJL?=
 =?utf-8?B?Z3BoWitYc2hXczVkT2c4SFVyLzVoZFV3U0NwQzU5cWpheDdZbXNXZGxFNzhq?=
 =?utf-8?B?SzBQNmg2REpZS1YxYTRaNGZWTndhQmdXSkxOOWxaRjYwTlhMN0piekpITHEw?=
 =?utf-8?B?ekZYNGZVOTBsdXZ3U2lMekIwU1gxczNiOHExNDRWemIyd3M5bnB1Y2JudllC?=
 =?utf-8?B?WUd4Q096RWZWSEZuanFRdlpSQ0ZoSEJSWDhOS2lWTFN4UStFN09yNjU1cFV1?=
 =?utf-8?B?andTbkRST1lKMXJmWGFwS2JacDczUm85TEF0V1N0S2VmWFVTM3F6K2p1YW5t?=
 =?utf-8?B?NXl2MzRabldXZWFhMFBVa3lmYVBpOVZZWlpqWEtqTEQxNTgvMzVyRDd0T1Q4?=
 =?utf-8?B?S2l3S2FvNUE0NTd5WlVQS3I5bTYxWDc1dTNHZHFrZXhKYVdqS1U2UkVyendS?=
 =?utf-8?B?QjdFNGhhbmpQYmNwaGZ4bnNmdnowTUQ4VFkwZnVCS3Rxai9uQmt3azcra2JC?=
 =?utf-8?B?TVpjN3I0MXpicm5yT3pTM1hMYklCWWdZWFdrVTlrbUpPS1pZKy9EMnRZM2Vv?=
 =?utf-8?B?MUdrbzZpRFZjMEhEeFMxOFFpWHN1amZaVVA0Sm41dGNEcHNWbWg2NkxVeEdH?=
 =?utf-8?B?VEY2cFpvbmVpMXNYdzhRU0FQeGFPSjJuZUhRbTZXbWpZUWcxcjRHRU9DS1Vy?=
 =?utf-8?B?bEt6YmpoYWNyR1g0WXZkUmQ4MkFpbnhsTFVSVmlYZDNHTVMzZDlSNFkvZmpk?=
 =?utf-8?B?V1did1JGY0FaK2ZEdXRtKzFJQmNoSWQ0N1lHZ1hmcUJEZlVuRWM0SkZkamZm?=
 =?utf-8?B?ZlR5Q2NkZDVnblJaRzJUU0FCVXd1NmVrWHluYW5ja1B1RmUwbi9FVDlJY1FJ?=
 =?utf-8?B?b1oraFowU0JUV2hyQkxRencvK2xJTDlkaTB6Y2psYjdQM1FpS0JlM2E3NW5i?=
 =?utf-8?B?WXhYdDRFWkJXb0hRVWU0c09JeXVBQStJSklEQTd0QUFSdjQ1bFBWWkE1NW4w?=
 =?utf-8?B?K2VqNm9aV2psY3h6eGJpRWdTSU9WYjJzNEhXRU1ab3MzbkhlZFE4RnZSQTEz?=
 =?utf-8?B?Z2gvNXZkc3QxenQzNkxYSUxQWWpnSFlUNUM5Zmd1QVFuM3NPTU1VbnN5SmR6?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29f1486-a4e4-43e6-62d8-08da86c7de54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:30:21.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYZOZ7KePZ3P6zH0fCyK/QbpalP42nxcFGsaplLEzRNwg/NCvbRQTIGZqqxafO+m/fffbJpUaU5c+x4MpTwmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250070
X-Proofpoint-GUID: 2bJ-dW5UWSQdHlyrKQ8MG-nJycHxj5ij
X-Proofpoint-ORIG-GUID: 2bJ-dW5UWSQdHlyrKQ8MG-nJycHxj5ij
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/22 09:43, Baolin Wang wrote:
> 
> 
> On 8/25/2022 7:34 AM, Mike Kravetz wrote:
> > On 08/24/22 17:41, Baolin Wang wrote:
> > > 
> > > 
> > > On 8/24/2022 3:31 PM, David Hildenbrand wrote:
> > > > > > > > 
> > > > > > > > IMHO, these follow_huge_xxx() functions are arch-specified at first and
> > > > > > > > were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
> > > > > > > > hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
> > > > > > > > still some arch-specified follow_huge_xxx() definition, for example:
> > > > > > > > ia64: follow_huge_addr
> > > > > > > > powerpc: follow_huge_pd
> > > > > > > > s390: follow_huge_pud
> > > > > > > > 
> > > > > > > > What I mean is that follow_hugetlb_page() is a common and
> > > > > > > > not-arch-specified function, is it suitable to change it to be
> > > > > > > > arch-specified?
> > > > > > > > And thinking more, can we rename follow_hugetlb_page() as
> > > > > > > > hugetlb_page_faultin() and simplify it to only handle the page faults of
> > > > > > > > hugetlb like the faultin_page() for normal page? That means we can make
> > > > > > > > sure only follow_page_mask() can handle hugetlb.
> > > > > > > > 
> > > > > > 
> > > > > > Something like that might work, but you still have two page table walkers
> > > > > > for hugetlb.  I like David's idea (if I understand it correctly) of
> > > > > 
> > > > > What I mean is we may change the hugetlb handling like normal page:
> > > > > 1) use follow_page_mask() to look up a hugetlb firstly.
> > > > > 2) if can not get the hugetlb, then try to page fault by
> > > > > hugetlb_page_faultin().
> > > > > 3) if page fault successed, then retry to find hugetlb by
> > > > > follow_page_mask().
> > > > 
> > > > That implies putting more hugetlbfs special code into generic GUP,
> > > > turning it even more complicated. But of course, it depends on how the
> > > > end result looks like. My gut feeling was that hugetlb is better handled
> > > > in follow_hugetlb_page() separately (just like we do with a lot of other
> > > > page table walkers).
> > > 
> > > OK, fair enough.
> > > 
> > > > > 
> > > > > Just a rough thought, and I need more investigation for my idea and
> > > > > David's idea.
> > > > > 
> > > > > > using follow_hugetlb_page for both cases.  As noted, it will need to be
> > > > > > taught how to not trigger faults in the follow_page_mask case.
> > > > > 
> > > > > Anyway, I also agree we need some cleanup, and firstly I think we should
> > > > > cleanup these arch-specified follow_huge_xxx() on some architectures
> > > > > which are similar with the common ones. I will look into these.
> > > > 
> > > > There was a recent discussion on that, e.g.:
> > > > 
> > > > https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad
> > > 
> > > Thanks.
> > > 
> > > > 
> > > > > 
> > > > > However, considering cleanup may need more investigation and
> > > > > refactoring, now I prefer to make these bug-fix patches of this patchset
> > > > > into mainline firstly, which are suitable to backport to old version to
> > > > > fix potential race issues. Mike and David, how do you think? Could you
> > > > > help to review these patches? Thanks.
> > > > 
> > > > Patch #1 certainly add more special code just to handle another hugetlb
> > > > corner case (CONT pages), and maybe just making it all use
> > > > follow_hugetlb_page() would be even cleaner and less error prone.
> > > > 
> > > > I agree that locking is shaky, but I'm not sure if we really want to
> > > > backport this to stable trees:
> > > > 
> > > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > 
> > > > "It must fix a real bug that bothers people (not a, “This could be a
> > > > problem...” type thing)."
> > > > 
> > > > 
> > > > Do we actually have any instance of this being a real (and not a
> > > > theoretical) problem? If not, I'd rather clean it all up right away.
> > > 
> > > I think this is a real problem (not theoretical), and easy to write some
> > > code to show the issue. For example, suppose thread A is trying to look up a
> > > CONT-PTE size hugetlb page under the lock, however antoher thread B can
> > > migrate the CONT-PTE hugetlb page at the same time, which will cause thread
> > > A to get an incorrect page, if thread A want to do something for this
> > > incorrect page, error occurs.
> > 
> > Is the primary concern the locking?  If so, I am not sure we have an issue.
> 
> Yes.
> 
> > As mentioned in your commit message, current code will use
> > pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> > will either be the mm wide lock or pmd_page lock.  To me, it seems that
> 
> The ALLOC_SPLIT_PTLOCKS can be always true on my machine, that means the
> pte_lockptr() will always use the PTE page lock, however huge_pte_lock()
> will use the mm wide lock.

Yes, the different calling context/path to the locking code will cause a
different lock to be used.  I thought of the AFTER sending the above.

> 
> > either would provide correct synchronization for CONT-PTE entries.  Am I
> > missing something or misreading the code?
> > 
> > I started looking at code cleanup suggested by David.  Here is a quick
> > patch (not tested and likely containing errors) to see if this is a step
> > in the right direction.
> > 
> > I like it because we get rid of/combine all those follow_huge_p*d
> > routines.
> 
> Great, this looks straight forward to me (some nits as below).
> David, how do you think?
> 

I will continue to refine this based on suggestions from you and David.

> > +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > +				unsigned long address, unsigned int flags)
> > +{
> > +	struct hstate *h = hstate_vma(vma);
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	unsigned long haddr = address & huge_page_mask(h);
> > +	struct page *page = NULL;
> > +	spinlock_t *ptl;
> > +	pte_t *pte, entry;
> > +
> > +	/*
> > +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> > +	 * follow_hugetlb_page().
> > +	 */
> > +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> > +		return NULL;
> > +
> > +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> > +	if (!pte)
> > +		return NULL;
> > +
> > +retry:
> > +	ptl = huge_pte_lock(h, mm, pte);
> > +	entry = huge_ptep_get(pte);
> > +	if (pte_present(entry)) {
> > +		page = pte_page(entry);
> 
> Should follow previous logic?
> page = pte_page(entry) + ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> 

Yes, this needs to be PAGE aligned, not HUGETLB_PAGE aligned.
-- 
Mike Kravetz

> > +		/*
> > +		 * try_grab_page() should always succeed here, because we hold
> > +		 * the ptl lock and have verified pte_present().
> > +		 */
> > +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> > +			page = NULL;
> > +			goto out;
> > +		}
> > +	} else {
