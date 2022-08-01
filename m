Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061FA586D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiHAPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHAPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:01:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5B11C3F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:01:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271E9723031018;
        Mon, 1 Aug 2022 14:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8b6EMUSWkvxMtoiUhMtx05uyLI/22ipMQiT94HqVvJ4=;
 b=qM5rZhSeqJjVrN4x4OHZE6rFMcQfAM866kXB9Xfnd0lj41LrOjjEBu4yflvUgLiUrY3+
 q7tLSPgJEUILiwp1HEygsgh+hfmSM2R61n5Oa4tHY58LMDqkuKP7udkj5xenuunmkmPy
 8KRtoIhmAmKu9d9lVS+5szsvHLCxtL0r/irFByETQTvz2ti71zWpENM8Y6uQUmcopu9/
 G/BDwr7VzvPWTjTRYysT7+0muaj/ZrERN2il13iGKFZfm0AEUxqwYc4okpcwu9b8N/MH
 hRjYEgfLQMsm3++e2VaKJ8oRC4XV3D7/1ElC1T1a/5tWepsqJY2gTWSskRaSC+1h9ERc lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80uxt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 14:59:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271D9qPg001038;
        Mon, 1 Aug 2022 14:59:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57q91m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 14:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTWqRcjdBUPd3/Tp89uEwHpT3LlbJd4nWOTVH1muj8IDdsxDtzsCra53haQbGwN1ej5e/YINp1QsQU1HTVVvsX4r5Bw/uZ5sKzFj6K3aSvqwU0N/Ti12ecLGIHrI9Ppp/T7BJKCUmr9D2xSrBQ3D8pJpiU+TqAMuEIE68zs6wVyckOI4aNupYNYRaAPeKKc63E5lqWc9Q+5VgWeWqRdGWJtAU6ikpHChMh6m1qY4VbTg7fqRPR4IeD71xODgpaZBr+3s5Nni80W+D9nL5Cz4eGqN1q/tD/9jr8+rEWb7c4Ik1ToFOLqmV/r1mbCwT9HOxGCWpgIGNZhS900VoxRsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b6EMUSWkvxMtoiUhMtx05uyLI/22ipMQiT94HqVvJ4=;
 b=VWzXPKT067sJcqJVx0qNeIyvTS8PcqVI6rtKW82zJuUaIt7SOTy4LRSLax8x9LZwIqcFZeIYDykhKJXTiJ409n6KZ1enAonHhdzgzSSk9DUBcdUYZcc9e+OqjI3lOL+sl7L398DQQJCGkKIBuU3xS5Ab56nHPrAkxntMiBY7ZjB3ZTfFWWPWnKaXlZRj6llm6SmZu7aU8Yhla8o7T7Iy97K8cJjcbI3Sx4kIE+RuO0O43LNqBgZc8+qg0j2YiBzy0swEsJpEIJCMoLmfXZizqe2IsY7XOKU1S0TyGeDv0KLVKKqWuqleLlG+ua5wFTNUVMsPtnNZS3picbYWhtixwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b6EMUSWkvxMtoiUhMtx05uyLI/22ipMQiT94HqVvJ4=;
 b=NuoVwzaAcl8/Eyo3VoYaVm2YZd/KqYWI7bE6tPPd1fm2sqd5Wsn7WfdDFoG4BeOwnOpgwOFgga4bQL3fLRdNBK3O4/ZiRsFf4aTFp3Sbl4RBzKrntFLq8uJWLqgOYsf0o9qUjFKxc1DZRBC0acv9jrdSaP3KmThHXNMc8iB2xzw=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 14:59:29 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6c30:fc60:6b2f:3e34]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6c30:fc60:6b2f:3e34%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:59:29 +0000
Message-ID: <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
Date:   Mon, 1 Aug 2022 07:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com> <YufUj4klPKmKNj26@gmail.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <YufUj4klPKmKNj26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163e9419-6c2d-450a-9198-08da73ce6ef6
X-MS-TrafficTypeDiagnostic: CH2PR10MB4245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkkVDtiiOO4dbTsS5FilLIVBlJg8Nk/sTcj+qXRaM6KJN9uogIk6Gx/oYF4QZHpKFPTjycu23leOzExVCIZsu2wQLOfAy+gVEAvNcz5oZwRwM4mExfa1p6NS5fTbSlb7zYbxfn7YZuMP6RRBjjQ6axCJEs7RpaooaZkR26kGkglLDI2gpreSf7js41A1dgaDZ0h0qCyLdDP1p+YiVcM4Is9PkbWAPEvmhk8RkgNyeeIAysdcCKj9fvqDhXFSFcgoBj4gqgE6YNf1JMe2ZrMOkjAyrkn4g5nUET4IA6vMhEced//Kc8PR8fUYKBAWDHXvsl0w01rNS3ULo7ZBPTvbiYm7HsjSLwVyFjbbBzGdYzbExO7i4toFTZL0xXX1I6xmIJau1bWFKeEezsay/R0Y2RY+tzsqI9Nzj1V5oaz99QGARHksA+y990bN8YoXqKsy7MclzkunNxKZeeZlv5YP/oFJHARfuYygxLdmaMJfcBFEEvDIddm7VC3B1aUxtEe6G6VknVbdRMZYX813y9Vo2mBxGvR4nrrtj6X+C6duPVZbtzgOlC2unkU67P2SGS8ANzxg5ZguQwNMXgpkFVupULcGd4T45G+/x59JGJJTcnS2ppqI5tUzMGadeXjJXk5jLllHOTvWlPoLfJA14SP0cVkU/GkDvphCOfa10zMUugoN5caKMzXM5tCQrQ40hnH+g42gDDYrl+hFbE0cHHnZV1aKN3fPPN5gber1fbLfI5PB0eBEkbATjZVzpAg0nAFO2+cI0jpAUQjO9sC/Fq3fZC+vJ5tDKiNxGVX6hpsp7bOm5TFTe1mOt00iO8D2zI3kE9ty9RRcAf17mAWOh1NpXhezRVy7aCU4ga3yZWNjOXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(136003)(39860400002)(6506007)(53546011)(52116002)(6666004)(86362001)(2906002)(6512007)(41300700001)(2616005)(38100700002)(31696002)(186003)(83380400001)(44832011)(8936002)(66476007)(7416002)(66946007)(66556008)(4326008)(478600001)(110136005)(6486002)(966005)(316002)(31686004)(8676002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlLOVdLQjJmM2xUVHpnbkpNZEV1MkhEZVVQRUQ0dnJ5N2JHYUpzY2x6ZXFM?=
 =?utf-8?B?UnlmMjIzMDNYaFZaUkFkQ1hpeFVDTlNWeEV5SExvZGpnWld4eFE0aTUyZ3dR?=
 =?utf-8?B?WUYweXVoNXZFbDVsQ2RhM1h2TlBUdjczd3JPSlMxOU5zQTJDSUhERyt6TlVH?=
 =?utf-8?B?UHFrVUJONlpFM1pCWTBJL3NpVzM4dThZQUw4WkJtUmFhMSt0MkVlS1VWSlhB?=
 =?utf-8?B?TGVvQnlUNXNGRkZUK1hGUVNoQUtMb3ZsV1FydmdCVWFCVmhHSStiVGxCeHcz?=
 =?utf-8?B?TDNUeEFsczFQWkMwcGtkVDBlUzJvOUd4ek52UzhjZENWamZRa255WW9tQkp2?=
 =?utf-8?B?a1V3ZmF5Mk4zdk1NVjc0VW1qMXVxbWhOZ0ZlZThZNWNrUkFaeFpDWHVnMFN5?=
 =?utf-8?B?cHRiR1pROFdlVWJoSERaVnZCdmpvcElwSml5cVUyeDMzSGxUM0JOeGFmS3A2?=
 =?utf-8?B?MEJNRndjZXVweU1KTloxL1dNbE5PUGJ1dmRoRW45WWJqWHVtb2ljb0FOYmRp?=
 =?utf-8?B?ZEk0bS9LU1VPS2RGK2V6RXlmelExZWVDc3VnelQxczdmNi9VaUFJRzRNTTc3?=
 =?utf-8?B?eW8wbk9TUWhnNzVTRFpBOUtYcGU3RGh4cWd6SlIwbHVtckludDcwdXcyektj?=
 =?utf-8?B?SXZtZURpRmtpM2ZSZU5JQnRtVC9JRVI5cUFqak5DdmFOWDByMTNIMGgydGJN?=
 =?utf-8?B?emRzUlJ0djB1QXpyRTBhNWRXZytzaUl0bGJmdkVxVlgzczZPSkE5eUdBZ3Iy?=
 =?utf-8?B?VHU0bmh4cnVtdy9tbVZIL0g3eEx3V1VLYlpJcXZaNmUvMlNOZWJUMlRDRDRy?=
 =?utf-8?B?Wll5ZWhiWmV3a2hUak1YSnhYUDZRZ3UwZXVMY01Jc0Rka2NUbG00Mmh2NGVF?=
 =?utf-8?B?NWlZc29RMGxZMFk2bWxwVTM3UHRQaklORUI1YjlOR285bzdYMktVem5YWGcz?=
 =?utf-8?B?OVo0ZVRqSll1aHJaMVNhUktHTlpjSCt5Ti9KcVJudm9QT0NPZWt2KzlNV3Jv?=
 =?utf-8?B?aHlqNTV1NkkyS3h6ZHZBVmpRQnNta3JjdWl2ZkhubWMzUzZLbVgvdi82ZkFU?=
 =?utf-8?B?WmNEM01GbWozbGtBUVNpZURuTnR1a3NuUThSRWxPMW1HVHo0TlJ6U1JscDMz?=
 =?utf-8?B?c1FxZ3NnSmRUbC9KT3dWQ29KanhtTUJqRENYRUdVMkxNd0NCU3p0aVRkNDB0?=
 =?utf-8?B?cVR4MGVTUWVZTzBoMjJuRHVKL2wyWW1vQXNRTkRCWXozS2lGZTRzK3pyYzdE?=
 =?utf-8?B?ZktscVBLM1ordlRVeGdDWXo1UWlyYVNkWUkwbjlzZ3Nxa2hlYVVyamJZOHJE?=
 =?utf-8?B?T3V2bXVPdHpEdjM1d2JJVytRTGN6aXAwQUlDSHdQaVVpMlMrelB5S3V5bUlk?=
 =?utf-8?B?Rzk3UGdqVktDK1l3MXRwUmZEMzl6cEhUTmUwendlSkcwYWozUjdCT0hMVGFW?=
 =?utf-8?B?T01ZanJLbEp4K0FTa0RBd1F3WkhLL3UxRWNCNTZvaFg3VHRNUU9qcGdFOC83?=
 =?utf-8?B?OG5wSjFuVnI4WnNHVUsyWE5BSlhFZnNVbWlOMFUvN2hkaXdnUmg0WW5zc2hm?=
 =?utf-8?B?WUhKVGcvWUZJVDN5OWdOR3dVSFZOZ0NkZmZUTXIvcCsvNEt1bDROd2lNWmdH?=
 =?utf-8?B?cVRNWlpyZEliTU4rUUx2WmxWV1AveHZwNFZuZE8zeEZyYUNvdUFOWktVdDI0?=
 =?utf-8?B?VENkUW5SWmc3LzBRZC9DK2haQ05hdGk3WTRna1NJTm8vaTBhanI0b2NlTEpO?=
 =?utf-8?B?YWJYYmY4ZnlFUkxmazAwSFA2Y21PVHdPbzhKcXgxb2ZrejlYT05rTFNlblVI?=
 =?utf-8?B?R21takJRUlR6RTBrS2pjK3lROTBwaWdwZ1pXMmlIdksvN3pHYlFhWUlvQm1s?=
 =?utf-8?B?VW81U2NFLzNiTmRzdGFKUFFtQVQ4RncxdlEyRzk3d2QzUVlweEZXM0p3NWQ2?=
 =?utf-8?B?b2JLWVJOeW52ZkdmeU8xL0pIZ1VFODA3Mzd4U05TRHJERTNkeUdCL0FscTZh?=
 =?utf-8?B?bWIybWx5Njc5WVJ1bDZ5WllOVGlQc3d2Q1NtNm83eXg3QlU2Rm1CL1FtbXZI?=
 =?utf-8?B?ODNEc3lzNzNuS2k5aENJakZMdktoTXBjdUE2aHlIM1pXUmJaWS94Yk95WW5H?=
 =?utf-8?B?eE1LNVMrRUw0VzdqcExmY1dTRGRDc3E3bU1hUzlvVnV6UWtkNVhwSjJGNTN3?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163e9419-6c2d-450a-9198-08da73ce6ef6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 14:59:29.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmOHs82Jw784krNcx9/34IoHHFZyDCXk7Kc8HMwo1f8YjaRozyx2PMr545pb9Hsf0NAx6s6b+clAyzE5osZzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010076
X-Proofpoint-ORIG-GUID: FgQiMOgqN8MI12y3iBt5CikG2POlJO8G
X-Proofpoint-GUID: FgQiMOgqN8MI12y3iBt5CikG2POlJO8G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/22 06:26, Ingo Molnar wrote:
> * K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
>> Hello Libo and Peter,
>>
>> tl;dr
>>
>> - We observed a major regression with tbench when testing the latest tip
>>    sched/core at:
>>    commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
>>    Reason for the regression are the fewer affine wakeups that leaves the
>>    client farther away from the data it needs to consume next primed in the
>>    waker's LLC.
>>    Such regressions can be expected from tasks that use sockets to communicate
>>    significant amount of data especially on system with multiple LLCs.
>>
>> - Other benchmarks have a comparable behavior to the tip at previous commit
>>    commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
>>    into core tree when update cookie"
>>
>> I'll leave more details below.
> Mel Gorman also warned about this negative side-effect in:
>
>     Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
>     Date: Fri, 15 Jul 2022 11:07:38 +0100
>     Message-ID: <20220715100738.GD3493@suse.de>
>
>     https://urldefense.com/v3/__https://lore.kernel.org/all/20220715100738.GD3493@suse.de/__;!!ACWV5N9M2RV99hQ!PQsIeuK0UwII-A0xS-B3plepNniNeyw14OJowT1cYL-tnuN99MkWfg9C8P60tVFFrnxj0NEanUmEkA$
?? Mel was talking about a completely different thing, I brought up a 
different patch that I wanted to revert and Mel thought it would hurt 
other workloads which don't benefit from pulling but
as you can see, tbench somehow benefits from it, at least according to 
one metric from one workload.

Libo
> I've reverted this commit (14b3f2d9ee8df3b) for the time being from
> tip:sched/core.
>
> Thanks for the heads-up!
>
> Thanks,
>
> 	Ingo

