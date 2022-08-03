Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BBC5892D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiHCTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHCTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:38:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6B165AF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:38:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273JJQLO009067;
        Wed, 3 Aug 2022 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qpOrT4O4TJC+V73VX6Ds5PDME5VCCAfNhTvE+vOPIZI=;
 b=Xi1e3478oY3S8XISawS2lnv4XqvEkppD1LEk8nj6dyRO97K+FAHR3m11iCZxPy2NxEG5
 BG21a6z/rlTVkznIWBOr+oipBvnnOtQfgWkzKmuDg+uGHv1M2sztHCG18gCHG7tt0Hnq
 jP0fVCtkUSB9jOwl2KFbtk+38hWNSBb20CSP+dtJerFfQfFvuqhULWZjJCVXGle7+DCx
 rqZ/QkMd8LMe6FHVRIboBpTc4BV++BRfngQ/nfly5Cho5058Gd0cjX3X2/fIyZSoM8Kk
 9NllDpV0sdh96gDRM3/6t1TY7/uxkyPlsW4OpjcMzjM0k5wKUSttdZosp7b2iTBWMDmx Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8sb1us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 19:38:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273HqnTr006773;
        Wed, 3 Aug 2022 19:38:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33bwcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 19:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+WysDJfY/axeq6JSVkicGlWyJAQGqBFxcUmbnIJRH9ZvVTbBxdQ6djy8hQkJdB0TF/EqY4FKNnNCO1MZ65y0rqzAfbAaJv2/c+VPZgKqhQZFXwimnp8oiCvY9/kFPwm3MlO9idtHHbpS1kBNVMV5+MiEoKy//Dxi5s6k7iztLeavITauOW00zUXeP6AYkU1D0xMsHdJl1rufgsuv94jmArdaKscCsnRNQlRANvctpIa9EWD2oi2rCSP1jIBTyPAIIQk/nFA8rhjFpjZuWlFv84uorV6rBx0O+B8CrcNGUpe0o2oSX/o9UjnRj1dtmyRALrM4bOFhFGCCskvrYpYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpOrT4O4TJC+V73VX6Ds5PDME5VCCAfNhTvE+vOPIZI=;
 b=jQ58F8AHtDRzOYzD88gYmNIhgo+tqRAmYwcwUM4aJR5mHz5n/kk4nDhfVIXBbsXuB42qxed903u7gWaZ25Hzl9hMKr6tk4CA2qw9EVPebgqs7lw0LEcU5pDxDumepOcMa7DAwokqP/ZY0eL8BGG5N7eYRL5eXB8kPRDhGIBtr/KzAik/Cc3goErsYydtSPPczXe1TJSzlIin+iu80FM8NJUVKiS8Gl4F3Y1XeYE2BT5MrNCXUpDHUed1pN59rt8bcsRstKUyrj1wFZREcJdBsZd+BTmAECf1V3+8mfty7tEIg3BT1p6E3vZs0ozAnmXa8c8npCfRMwJByO2KRG055Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpOrT4O4TJC+V73VX6Ds5PDME5VCCAfNhTvE+vOPIZI=;
 b=gHO9/FmKGLjcMi2hazwCfdlIQgC5xbcXK0pyTvAfg1NZ6HaYMrjLaAdHkej6TzEQt+esmL3DITLQTRcyA7sUws5VqA8Rtpia/km9hfuGhDl03/tXAgwyAViijEG19GV3Jrl0cM4gdJzMFJhVz1dj8wOwrf1ewu5cnd5LrCmfj8c=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 19:38:03 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::78c8:f892:1f1b:ae7a]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::78c8:f892:1f1b:ae7a%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 19:38:02 +0000
Message-ID: <a9d666ae-0aa4-d79e-aac2-02573577b530@oracle.com>
Date:   Wed, 3 Aug 2022 12:37:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com> <YufUj4klPKmKNj26@gmail.com>
 <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
 <Yuo9Y4KvQQvvLC/r@gmail.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <Yuo9Y4KvQQvvLC/r@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:806:27::17) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa7d054-12d2-4c4c-4aae-08da7587adf5
X-MS-TrafficTypeDiagnostic: CH0PR10MB5179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FfNQuPG4BKeZCBT5S23+6DK2JPjYLNDUywqdyva8bxgL79vbSr9eyj9yg2gb4IcuT+63T7/SHbV1q9GSIThq4k86ZKQtxD9O/iFsTK28tCB6QVVgOn4uWDiasFhOl9aecH/H5j9R8l0w8c/+hBRMqMr7JhmYAqNsgdQWbrZzM4fCBRRMMt55mQG24gPHXtzPvRIOU1NM+Fdp1FKACJPw68kadMHy2QDXQzP+fzZofZdvPWNgYDOrRea1fjTOLACAb1ThfDpYpZRJXXGH1gaQEzB/5vIQcRvW3qTNNDg3PO69Sc8Zi1CpLHdJWR9MG6vykUaL7gaIAwTF5wDyk6n2ufJvhco74LotK88jxPEz9pA/PdPGplwdYylFscHvyZSS8hNm2mw2xx/QTzv9wLkCCPD5ag5ImlbwDLm7MdVgd7eGTgBUo9kcvDV2Gmr1ipbafdZFAK4DltILjhg+to0wyrEqMy/RNSbZfZ8tpA5gQ8N4OZhWRQjFN+U8vVLN9JPExX6wcD8eKscuvqdRbzZsPsWm1oc5PxD4zB7VlUdrUM3dThgg8BrDkBARJUXUYj4YuOf1kJ1pWTcUZuiYHKtPOYAt80xnuiBG05EZpPIurtb4ewu/ipfC38XxHFD+Cf3y4uEiCNPUyose1A0wkV4vfRUJnFy0zzRgnSFBKp2ns+dy7ohZhNaMLcc2pi6yYc6iSs61mPiWHXlpA+YtaE/zOn506zxu0BHQCxP+rygkqb0odOu6LduYq9Jko5WBA44AB28tuxhUKMkwHeCujUXwM4oZVLABTnazylbuWAb2iu9F0wmW8TKl6t4sk/62aC4UtcS80ICUV4rIc3ZFYGRfXExngL9Cbzn75L5C1E+Vhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(39860400002)(396003)(6666004)(966005)(5660300002)(7416002)(86362001)(31686004)(6486002)(4326008)(66946007)(316002)(66476007)(31696002)(66556008)(6916009)(8936002)(6512007)(186003)(8676002)(2616005)(53546011)(36756003)(41300700001)(38100700002)(44832011)(52116002)(2906002)(83380400001)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BXRytDdExtVmY1clhpUExKSmgwYnJUR1NKUXR6RHJndm9pcm9ubjlmanJq?=
 =?utf-8?B?ald2K0JkRmJUTlJ2VjQ3QlVMOEJmZzBQVUxnbTB0TzQ5S09TYk9jUU41aXFK?=
 =?utf-8?B?OEtxYnhldlRFdllZRWNFbDNCTXNKVklTdzdNaWFvaFI4RCtVV0RYRFFyZEU2?=
 =?utf-8?B?UVFaN0lUZTFCZVpiY3pTa0ZDV0RiMTMvdStFUHlIMzRQR1RDR3dmemhPc1NU?=
 =?utf-8?B?aDNXNlArYWtzM1BZVVBVN25yNGFmbW4xRWY2YnprUXNad3JrN0pobXpBRHkw?=
 =?utf-8?B?M01obXVsM2JiQitsUTlTY1h4R1pwVzY1bVYzeDhKWW80Tk4rNVkvNE4rYlBi?=
 =?utf-8?B?NFR1Ly9YbVRlMnByYzV3dmdzTmVUUlc2RUZnMENYQkhHa0UydExBbnplS0t5?=
 =?utf-8?B?ZTQvR2JjVlZ6THd6Zzl6ODV6dWM1aG5FT2h3UnEydXBTaVpWNzFveXBNSG9i?=
 =?utf-8?B?d1E2UG5tZVlSVXZSbzE3bHh2a1EzdzJVbmZxRGxBVHJhc1hYLzhRcXg0NSta?=
 =?utf-8?B?K1NjQUoxemtTRDRVc21XelJiTi9CbDRZNFE4bGZuZEFoVnlLbVcyZENKeVJt?=
 =?utf-8?B?WUFXUjVuakN6SDQ1ZnlCZEVpSDVRc0laeTJoL0JrcTlickxSbVN2V0tTYUw5?=
 =?utf-8?B?YkJmcE5hdGhvWnM3RTV3MnpWY1ZvUTN0ZGZhQUZJSzFsakpWQWlDZ1QzNE9l?=
 =?utf-8?B?Z1hUejF4NS9TNzlISkxEdndNRGhXSXpPUm9mUy9wTnBrb1Nub0dCaXdpeTB6?=
 =?utf-8?B?dlhGdzY0L2N4dGQyWkhLRG53MGQ2N3g1NzEzNjZEMnkvNzZQWWY3a3Q3ejNM?=
 =?utf-8?B?bGRNaytPYmJFMUhXaHlOajFxdERvOG5rVlRBRTk2V2gybXFWRWJFZHF6cmZ2?=
 =?utf-8?B?cFZIdEM5U1JVYThZS2xMUzhkbUc3M1FFeWNhK2k4d2tPM0NTYzE5WFFXcHlv?=
 =?utf-8?B?MXU3N2xRMWFFdnkzd3Y0dEpkNTBoemZXR2dZK2lsZTVBTy9WeTA2U2FWVmpM?=
 =?utf-8?B?bnE4OC9ocnBVZ2N2VDQrd0RwZ1pLT1lqRytGL0hOa25PTnJNRWxjQlkwRFMy?=
 =?utf-8?B?dkxvT0M3TU9TSURmWVBOSTNZZ2ZwNTdReXREU3o1bVAwOE9JS2YwWUdVa0dX?=
 =?utf-8?B?NU4zUG1RSDhaRnJYTk5XS0w3SkFVaWplMVVpNlBqOG1BYmxVbDB2REVDTy9h?=
 =?utf-8?B?aGVtVjhGQ0lBdG9vVlowaGJNR2ZFL3ZHaXJFNk0zeUNncjNCUUNPbVliclAr?=
 =?utf-8?B?U0lUMGpHendCYWd1M1VyOEl2aDdid1Frb29aUUVXWUdBV2o0NUJMbGd1aDRT?=
 =?utf-8?B?ZVZGUmpHZzRGcUhIb2t2UVdQb3loR2NMLzB2SXJoTFIxeElJVmlJOGg0WlNT?=
 =?utf-8?B?TWQ5R2hST1dyZGJ3ZEhZMnQ5ZnA5bEZpczN0VWJnbmpxOU0rNG9TS2lIaEpm?=
 =?utf-8?B?QU1jYTdNUnIxTFdPVm03Z2NTL204Yk90aVVLK3hESWNqVEZXdmF5Kzg2SzZj?=
 =?utf-8?B?Uko0YXBRMEdBNHBRdEZEb2JjSFBvaXRVWjYyc0RScVVZRXZHT1ZYbm1FdWZK?=
 =?utf-8?B?MVdkT05EaUJxTTg1VklXR0RXVHJ4eDRJTTlyd0tvK01QT2NYQUhILzA3VGRp?=
 =?utf-8?B?K2dyeWUvWjZ0clJyNzZvcGlSR0VReUZGZE5YYTJxR3EwVUZKN054cS9hWHVP?=
 =?utf-8?B?ZnRZNThtd3B5eGsvT1laQnNYK0VTQjRkY1dENUUyaTlJcTNGVm1lblMwNFVz?=
 =?utf-8?B?c1crSGtYdW96UlhXUVp6QlBWMXNERmljVzNwVkFHblNneTAvTzlESVF6SlFQ?=
 =?utf-8?B?dUNyYlVQeCtzVUMxc3dad1ZkQ3VWWGVUc2I1VGovb0JtNFNBaVpZcGtpRENp?=
 =?utf-8?B?S2FMRVN3d2RhdVBXZ0dEN0JPS0tBdkRSUzBTMWtUTk9PY21LV3NIa3AvSkRn?=
 =?utf-8?B?WTlnd0xIVDNNUGlmcU5wb05yYjdIVG9CNURZUTNKSWZ1V1MrL0JGTWFqK0FE?=
 =?utf-8?B?Mm5mMTZjaVBTWFl4Nm91amQwcjlNTCtTMXkrcnRLMDVKTytrNTdWUlNHTzlF?=
 =?utf-8?B?anhBemRXQ3JlOEJ6djlkZ3ZwVWJqbmdMdmZGUUpDWTBMVnVjajNZZlZpejdv?=
 =?utf-8?B?UFVtdmt2TGVia0dFTEdGelVaWW14RVRGUDYyaTY2ZEgxUHlqQ2VWL1lEU0F5?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa7d054-12d2-4c4c-4aae-08da7587adf5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 19:38:02.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mzVG16lmMavYJbawniR8CxVwtlYhNS5397k7h1GLIU11m0Wa+hgXZND2wg21vhOlkNCWlTJGSTVP8Td3uZrCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030082
X-Proofpoint-GUID: _d2-MiOHUQlO2C8q45y71qIXDwMUKFJj
X-Proofpoint-ORIG-GUID: _d2-MiOHUQlO2C8q45y71qIXDwMUKFJj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/22 02:18, Ingo Molnar wrote:
> * Libo Chen <libo.chen@oracle.com> wrote:
>
>>
>> On 8/1/22 06:26, Ingo Molnar wrote:
>>> * K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>>
>>>> Hello Libo and Peter,
>>>>
>>>> tl;dr
>>>>
>>>> - We observed a major regression with tbench when testing the latest tip
>>>>     sched/core at:
>>>>     commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
>>>>     Reason for the regression are the fewer affine wakeups that leaves the
>>>>     client farther away from the data it needs to consume next primed in the
>>>>     waker's LLC.
>>>>     Such regressions can be expected from tasks that use sockets to communicate
>>>>     significant amount of data especially on system with multiple LLCs.
>>>>
>>>> - Other benchmarks have a comparable behavior to the tip at previous commit
>>>>     commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
>>>>     into core tree when update cookie"
>>>>
>>>> I'll leave more details below.
>>> Mel Gorman also warned about this negative side-effect in:
>>>
>>>      Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
>>>      Date: Fri, 15 Jul 2022 11:07:38 +0100
>>>      Message-ID: <20220715100738.GD3493@suse.de>
>>>
>>>      https://urldefense.com/v3/__https://lore.kernel.org/all/20220715100738.GD3493@suse.de/__;!!ACWV5N9M2RV99hQ!PQsIeuK0UwII-A0xS-B3plepNniNeyw14OJowT1cYL-tnuN99MkWfg9C8P60tVFFrnxj0NEanUmEkA$
>> ?? Mel was talking about a completely different thing, I brought up a
>> different patch that I wanted to revert and Mel thought it would hurt other
>> workloads which don't benefit from pulling but
>> as you can see, tbench somehow benefits from it, at least according to one
>> metric from one workload.
> Yeah - but nevertheless the discussion with Mel was open-ended AFAICS, and
> the 'major tbench regression' report by K Prateek Nayak above still stands
> and needs to be investigated/understood, right?
Oh yes, I have no issue with holding the patch back until the regression 
is fully understood. I was just a little confused on your reference to 
Mel's comments. Anyway, I will post my investigation soon.


Libo
> Thanks,
>
> 	Ingo

