Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DBB4D1694
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbiCHLte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiCHLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:49:32 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CEB2CC98
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNIV1v8vx1ykbBTWCvAwhFV0iLDrvDuuRSWPTyZgxBQRwbVDEtIS1UsJy/93W+z/dCQ9Cih8cZda6kHm786aBFtomXbzl6Mp2ZXOQTzuZdBMtytXYRgta5XS02FDNH7oVHYxtAyGF8Vj962V6BE+BdGc/wjui7i5WcN2evtwpFhmlOO6EBeZun+SAW7CUOOvhyQXMu+Umb1bN5mGPsq1t5Un6Z3yhPKGW6Okr9spFCu94z7UFp6FQRR6kKAsI1Zpx9Mq62s0EiHjo7BY9A1dM1c2S7QehZXuApKBVDI15QB5GzWuyYLVT5xmizVQglMBzAIZYC5lbNCfj2IsBGObVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQiFgMWKwxGctDc2WGaaTakt9HTUMtPeezfHB9cl0R4=;
 b=B4pmBRv51WPAoh6hi7ZTgKAs53KQUPJz5zAiP/+TrenGMXIgNSeMyDsg2D1IMGootaGXlPlYPQfSB7Lx1+pesgbenO+yaPmyGeTVl81vZJwEyiJ9rp2FFERPaBIonhEFzqb1px4CHsJON8YJd0Cd6sNG/M6GeK58gaYvIqO61W0yuVMJISPJwAEOWZHc/y6t+agx/lOB2SMYnYx+UW27n6yyaL5SMCbVAd2azKYSvlaLBMjYk/EpAL3J6/HlvN4B91hMggVKyBajFBGWYdH6AfIGgP/fYoCt155yYzt16RQGOjBma86wGVmFslpL0iaQjPK62hEohZ5Sqi8NLUkuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQiFgMWKwxGctDc2WGaaTakt9HTUMtPeezfHB9cl0R4=;
 b=kH3PGKHAX32NOPZgYr3v+hwBWqJU5pytzHPERcsbtT81JSjWoeQWfxPXN7n6oyjALC96m5TeTpREy2Rg07D5yof3Y+FQ/l3Nx4uWaXcnIIkultHG9urM3MIRLLFjyfBwZuRALPB67OQxIwF8uWP+e8NCMxMc5RfCXGv8oP1iH38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB3747.namprd12.prod.outlook.com (2603:10b6:a03:1ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 11:48:32 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38%5]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 11:48:32 +0000
Message-ID: <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
Date:   Tue, 8 Mar 2022 17:18:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
 <20220308092944.GJ618915@linux.vnet.ibm.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220308092944.GJ618915@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::17)
 To MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a146d765-197a-4cc6-f1c3-08da00f9918a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3747:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3747634E2EA1EC3041EF08F298099@BY5PR12MB3747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hz7GtwQ5aUKUsPQkvOUGCJkvA5km4tfAhyAHvnRr7ge4NZ7Q1iF/TeBL7qhZg2lFDF2dkpjaAF02fE6huMIASLN4aq51RYK8duIXxmHiDv9CtV3pLZhXhau8E1v6VpVAYdS3YOOzK4IjUuDD73/+H6zOsH7g514M6YqWBKmDRzYhEVohS5QPbD5b/uws9XX97sVE5X+lYlldWagiS+FMtuTYP0fQtZi+nFapmm21KGegPKJaZotv0+QQ9rS23G4BUA/AXFp5kyItosSWIkbZrGbVBuvDetuLQ+yzTYklSMjeAQZ64Wc+anYR12w6/Xuq7dyxcflgkuyn5H3gh4rR6V08145HAx1BOPLO4USDb1eCi3zgKRhGDi9U59YhZoYATntU1uiMeS+i+5wF5ghiRG1XXi6TiBPfMUzXwZc8HtJqXjNNbHKy3Duuu0e2bYsHSQNEy62EmC3q1a9Jg2rUGP3dQeO3iTWX6lgwYXwW3vuqoGF/fjMMFOQtjX/9oDkt42HGLVD+URAz918ywcnYVy0FiBsUxQWGP7Gp26qu4P0yZ6pwJX7uWOzDBy/WK6PAzx2Z0XRjRF7vf3f1VL/obt4idRUyytyjg0I3n8AjUzDoxvzeRQ422FgHoc6fzLcZnDq8zaiHiUJWWCZz34Mr1hxkHwaWvNEXjtPXCw3fhDJNqyH2Y4brVeo15jBxSARKi03kdjtTMVO9/agNiA8IUhXNPvEGr9KYOrKh3cVRTlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(36756003)(83380400001)(5660300002)(31686004)(66476007)(66556008)(66946007)(2906002)(4326008)(8936002)(8676002)(7416002)(2616005)(31696002)(6486002)(6916009)(186003)(508600001)(26005)(38100700002)(6512007)(6506007)(6666004)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNiVUxEQzkwT0sxVUlTeWc2L0dOWnpRWFBSNkFqMTYzcnV4NXhTYU5yS3lh?=
 =?utf-8?B?bWljK2VWbzZSNktXS291T3gyOVQ0NGU4aDVCOW53RndmRlpJaTBVcmluTnRC?=
 =?utf-8?B?cW5lZTZvazBvbDlkOXZtV04xMFQyaEY5NDhRQldaUy9keThnQ3YwclBNaGVJ?=
 =?utf-8?B?dnFmM1VqYmdqampDM2RzcGY3Q1ByV0RJL0xzeEFZVzZoSmhTRTBmczc4R215?=
 =?utf-8?B?RUVIS1RYWXd5TnNka3VKV1JvSDljcURzb250eXRFVEtsZ1BkNGJBUlFkK0lv?=
 =?utf-8?B?bGFHN1ZSaWcyUmFlUC9kUmphN0hLYUEza0dKWXdmdHN3dk5jWmdqeWJ2cU5D?=
 =?utf-8?B?VjE3VitSOFdxNWdPQm9uWXZRa00xcUUxUzNYY3NqMFkyejNIS3Z1U3ZjYXRv?=
 =?utf-8?B?RzVrOExkMTFFNWRLRGR5LzBXb2hXVnYzNnA0MUpNRi9uUTJ1L3h4VGV6Yysy?=
 =?utf-8?B?Wk9pSUsrdGNoT0FpaHpVNk9HN3g1VHJKK05Cc3RVQzdURHJXb3NaMjM3UU4w?=
 =?utf-8?B?TS9VZDZ3NTJLUjF5ZUpXTVhwdVhHQTBjMzBjTkw0OEV5VEhqdEVNK3VNVGJ6?=
 =?utf-8?B?Q2JuR0ZTNDhxaCs3eldpMk14MkdoWmZDckhQSFBETzZFcHpYRXgydWRWeFJO?=
 =?utf-8?B?d2FmNkRPL2p3MzFKaW5PNkk2Y3BrSnUzckVBcTN4bHRUVnZBQ3pzbWZjeDJY?=
 =?utf-8?B?UVVYalRkRzZkbWFYVWhDdlFUKzZzUFdGVC9hUnMwRlJqTW9XcFBDL3FjMW93?=
 =?utf-8?B?UWFBQ3RmSU5FakllT3NIUEtod25qUkZWb1g5Rmd4em1lZXU5aTlFeEsxK0x2?=
 =?utf-8?B?bjdpSldnNjFGZDdYWXBUYjNaQWxKU1MvYWdaNWFyNkZ1eUFzcDAzdEI2TUM1?=
 =?utf-8?B?ZmVKRkowUjlGNWYxdGpLTnhVVGx2S1ZsTGtrVGhDM2lLUEJvQkxrSDg0aWNh?=
 =?utf-8?B?ZnFmNFdHLzM3aHZxL0x0QVc1bnRKelQrdGczV2hZbnpRUXExemlOeW1kMmVQ?=
 =?utf-8?B?RHFFdUdrd0ZJc1dPVkp4K1pEYnE5YldCM0RLNDU3SG02N05jWW5maVU1QXdx?=
 =?utf-8?B?TVI4VTQyM0NsVEwyQmRYbEd4cGFsQ1ZYQ05jQ3FrRnV4cGV4RHhhbDJmZVdL?=
 =?utf-8?B?MTdrM3BkelNVd2F3ZFluSWV6cGw5Z0V6SlY4S2pRQWlqM0xiMW9aYWNCZXRw?=
 =?utf-8?B?bkE4b2NMQ3M5WnpZaUo3RUlyMlJDbE15dy9HUDlDTHkyTHFRNmladTk3Z1B2?=
 =?utf-8?B?OXBOZWVrc2U5a1YwOWRkSmJoZ3g2U00yczFaWmV3QnphaldiajdGUUIwUVV0?=
 =?utf-8?B?NEt4T1F3amNaeE1ENkp5bzBqSFhPZU5jSHYrWjFzYkc3TU5nQVpicVdESkZR?=
 =?utf-8?B?cGYrVUZnNzRkanBtVFMrd21Za1B1RmFBUVpsRTgwZS9odVN6TFg2OTRpRVlY?=
 =?utf-8?B?RTR1ODE1WHFpem5vdXFDWHBxd0lLQzBycXhNQ2hvdFpML3J4UDFwVnhkMkYy?=
 =?utf-8?B?VHBkUlRJVUNyWVkwUlRTWEZkQ2Nud0wrZ0pQTUVHajRJdWs1SGJzSDg1NWZo?=
 =?utf-8?B?M29MZFp5QWZ3NzFTaG42d1VmSWtnU0x2WTdMWU1SaXBXTVVUQ3h5Tnk4aEhN?=
 =?utf-8?B?R1hlNUg3b2xreGJtdHhBeFZYUW8vNE1wTk5haHh0S2hoRWpua1dEcTQrTDBJ?=
 =?utf-8?B?eko4K0s1bFJvUjlDRlFESll2ak5TRkFuMWZQZ3p3M1hGQys4Q1BaY2JDeE9R?=
 =?utf-8?B?ZmhmOHJHUktka0V1OU5kRWJENUVzTS9mMDg1bUNLWVM4ajQ2WlluZWV5V21P?=
 =?utf-8?B?T2RxNGFxU01OTVZ4Q2t6aFZ4NzI4RXZsaGFEa0x1dldhR3BpM2NkaGNINFZm?=
 =?utf-8?B?R3U1UCt6WGVQbm44QkxlUlpqTzluejN1YkJFM25pOHdVbmYrYWV6blN0RkZs?=
 =?utf-8?B?V1ZwL3d0WlJzVkMvZVpoQVZneDBuendyajJCSEY2VEdTVk9oV2FQSmJ0ajF0?=
 =?utf-8?B?TXI3WFVUUVNEcCtkejhrU25KNkZ0MkdNSUdWZnJEVlh0c2xRVmlLS1Y0N0k5?=
 =?utf-8?B?cVYxeVpPL3g1NDNxS2dUcVJIWCtiMGR5bFhldllrU2IzQTZLakhzaUNiUndM?=
 =?utf-8?B?dWxqWndvcG91TnVkQ1RzR09wS21tU3RkOWVhLzVwbG1namJiaFl4NXEza2JB?=
 =?utf-8?Q?CAsk5V6ce3BTzwTXFBFam14=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a146d765-197a-4cc6-f1c3-08da00f9918a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 11:48:31.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrQ3quAC568q7LI14LXJTTFan+9q7oqvq614JxPF+E2uSI2lS3k73A63Qwlr/rePM135fYjYfh8rIxlQI/iITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srikar,

On 3/8/2022 2:59 PM, Srikar Dronamraju wrote:
> [..snip..]
> If I recollect correctly, each stream thread, has its independent data set.
> However if the threads were all to contend for the same resource (memory) or
> a waker/wakee relationships, would we not end up spreading the waker/wakee
> apart?

We only spread tasks based on number of allowed cpus in the domain.
For Stream with 8 threads, where it is beneficial for the threads to
spread across LLCs, user might pin the task as follows:

	numactl -C 0,16,32,48,64,80,96,112 ./stream8

For communicating processes, binding as shown above would
indeed be bad for performance. Instead, user may prefer a
different subset of cpus to pin the process to such as:

	numactl -C 0-7,128-135 ./communicating     # Bind to single LLC

This will ensure the communicating threads are on the same LLC.

>> [..snip..]
>>
>> Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>>
>> 	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>>                tip sched/core           tip sched/core            tip sched/core
>>                  (no pinning)                 +pinning              + this-patch
>> 								       + pinning
>>
>>  Copy:    97699.28 (0.00 pct)     95933.60  (-1.80 pct)    156578.91 (60.26 pct)
>> Scale:   107754.15 (0.00 pct)     91869.88 (-14.74 pct)    149783.25 (39.00 pct)
>>   Add:   126383.29 (0.00 pct)    105730.86 (-16.34 pct)    186493.09 (47.56 pct)
>> Triad:   124896.78 (0.00 pct)    106394.38 (-14.81 pct)    184733.48 (47.90 pct)
>>
> Do we have numbers for the with-your patch - non-pinned case?
Yes, we do.

	           5.17.0-rc1               5.17.0-rc1
               tip sched/core           tip sched/core
                 (no pinning)             + this-patch
                                          (no pinning)

 Copy:   97699.28  (0.00 pct)    106114.59  (8.61 pct)
Scale:   107754.15 (0.00 pct)    106814.48 (-0.87 pct)
  Add:   126383.29 (0.00 pct)    125323.78 (-0.83 pct)
Triad:   124896.78 (0.00 pct)    123622.62 (-1.02 pct)

These are the results on the same dual socket 2 x 64C/128T machine

Following are the output of the tracepoint sched_wakeup_new for stream with
8 threads without any pinning:

- 5.17-rc1 tip/sched/core (no pinning)

stream-4570    [025] d..2.   115.786096: sched_wakeup_new: comm=stream pid=4572 prio=120 target_cpu=048  (LLC: 6)
stream-4570    [025] d..2.   115.786160: sched_wakeup_new: comm=stream pid=4573 prio=120 target_cpu=175  (LLC: 5)
stream-4570    [025] d..2.   115.786221: sched_wakeup_new: comm=stream pid=4574 prio=120 target_cpu=000  (LLC: 0)
stream-4570    [025] d..2.   115.786271: sched_wakeup_new: comm=stream pid=4575 prio=120 target_cpu=145  (LLC: 2)
stream-4570    [025] d..2.   115.786329: sched_wakeup_new: comm=stream pid=4576 prio=120 target_cpu=138  (LLC: 1)
stream-4570    [025] d..2.   115.786375: sched_wakeup_new: comm=stream pid=4577 prio=120 target_cpu=059  (LLC: 7)
stream-4570    [025] d..2.   115.786415: sched_wakeup_new: comm=stream pid=4578 prio=120 target_cpu=036  (LLC: 4)

- 5.17-rc1 tip/sched/core + this-patch (no pinning)

stream-4537    [191] d..2.   115.926113: sched_wakeup_new: comm=stream pid=4539 prio=120 target_cpu=162  (LLC: 4)
stream-4537    [191] d..2.   115.926181: sched_wakeup_new: comm=stream pid=4540 prio=120 target_cpu=000  (LLC: 0)
stream-4537    [191] d..2.   115.926235: sched_wakeup_new: comm=stream pid=4541 prio=120 target_cpu=144  (LLC: 2)
stream-4537    [191] d..2.   115.926284: sched_wakeup_new: comm=stream pid=4542 prio=120 target_cpu=025  (LLC: 3)
stream-4537    [191] d..2.   115.926332: sched_wakeup_new: comm=stream pid=4543 prio=120 target_cpu=048  (LLC: 6)
stream-4537    [191] d..2.   115.926376: sched_wakeup_new: comm=stream pid=4544 prio=120 target_cpu=137  (LLC: 1)
stream-4537    [191] d..2.   115.926436: sched_wakeup_new: comm=stream pid=4545 prio=120 target_cpu=041  (LLC: 5)

All the threads remain in the same socket as imb_numa_nr in NPS1 mode
is 8 but each thread gets a separate LLC.
> I would assume they would be the same as 1st column since your change
> affects only pinned case. But I am wondering if this problem happens in the
> unpinned case or not?

We see nearly identical result in unpinned cases - with and
without this patch.

> Also Stream on powerpc seems to have some variation in results, did we take
> a mean of runs, or is it just results of just one run?
The results posted is the mean of 10 runs.
>> Pinning currently hurts the performance compared to unbound case on
>> tip/sched/core. With the addition of this patch, we are able to
>> outperform tip/sched/core by a good margin with pinning.
>>
>> Following are the results from running 16 Stream threads with and
>> without pinning on a dual socket Skylake Machine (2 x 24C/48T):
>>
>> Pinning is done using: numactl -C 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ./stream16
>>
>> 	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>>                tip sched/core           tip sched/core            tip sched/core
>>                  (no pinning)                 +pinning              + this-patch
>> 								       + pinning
>>
>>  Copy:   126620.67 (0.00 pct)     141062.10 (11.40 pct)    147615.44 (16.58 pct)
>> Scale:   91313.51 (0.00 pct)      112879.61 (23.61 pct)    122591.28 (34.25 pct)
>>   Add:   102035.43 (0.00 pct)     125889.98 (23.37 pct)    138179.01 (35.42 pct)
>> Triad:   102281.91 (0.00 pct)     123743.48 (20.98 pct)    138940.41 (35.84 pct)
>>
>> In case of Skylake machine, with single LLC per socket, we see good
>> improvement brought about by pinning which is further benefited by
>> this patch.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>> ---
>> Changelog v5-->v6:
>>  -  Move the cpumask variable declaration to the block it is
>>     used in.
>>  -  Collect tags from v5.
>> Changelog v4-->v5:
>>  -  Only perform cpumask operations if nr_cpus_allowed is not
>>     equal to num_online_cpus based on Mel's suggestion.
>> ---
>>  kernel/sched/fair.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 16874e112fe6..6cc90d76250f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9183,6 +9183,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>
>>  	case group_has_spare:
>>  		if (sd->flags & SD_NUMA) {
>> +			int imb;
>>  #ifdef CONFIG_NUMA_BALANCING
>>  			int idlest_cpu;
>>  			/*
>> @@ -9200,10 +9201,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>  			 * Otherwise, keep the task close to the wakeup source
>>  			 * and improve locality if the number of running tasks
>>  			 * would remain below threshold where an imbalance is
>> -			 * allowed. If there is a real need of migration,
>> -			 * periodic load balance will take care of it.
>> +			 * allowed while accounting for the possibility the
>> +			 * task is pinned to a subset of CPUs. If there is a
>> +			 * real need of migration, periodic load balance will
>> +			 * take care of it.
>>  			 */
>> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
>> +			imb = sd->imb_numa_nr;
>> +			if (p->nr_cpus_allowed != num_online_cpus()) {
> Again, repeating, is the problem only happening in the pinned case?
Yes. We've tested stream with 8 and 16 stream threads on a Zen3 system
with 16 LLCs and in both cases, with unbound runs, we've seen each
Stream thread get a separate LLC and we didn't observe any stacking.
--
Thanks and Regards,
Prateek
