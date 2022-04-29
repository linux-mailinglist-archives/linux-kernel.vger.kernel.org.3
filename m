Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E656C5141B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiD2FOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbiD2FOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:14:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156714006;
        Thu, 28 Apr 2022 22:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJXGe9MDJijwnX7yML7UWoAbCUVtLbBmspJUZBev3LtOrgKReSMpPVR/yQ16Tnrb4zeauUDen6RabatGXbFKvjaV1az4c5ueJ+Qh07mAqUQpy2vISaPIBOqw+yLOaQ4Zj6gFa7HL3wIavPaXfOiZCjTZFFjLWhkH36YW5Y++pmXioSn1/9v4xZDoTjEw/uy3vhaUc34KxvSStB321KFCRb6Htkz+p964wFeQAghwYqwsbqeq3zG9X25Yx7TLC5WcWcFjszJMwZdSw3+lvaWDvaEl8aCpKdyni2PbJFkTNsMp5UY8x0adrxnYSudl/OPv5WYpqV7oj37SGmuHglh0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHyjmv6EmE/QTAvmeEyXrOh4NqTSariZbbI0t5FQLx8=;
 b=MMsvYlctWgO+Z9HxcfVQ5n1QDYZSezfd6acWD8PyIhVtjBsWQ8PD/WWcqvgb1a+49LeHKNRMk/wPD0RyjzDzkJFfWwReeypRdN01pmyoz43Ug/jYmaL+Ova/bp9rJuOxaVN6GbC7r798Hk3ecKRrI7yP2VM92bi2Nwl5aHgTJqIOIxnZS+hRXZcxhFjKBGSR3XYzqiTV63Cy6n5GGkmn9NnAMh9ovaWO3QVVOPTvGaxil3XByqnK/lifs0fbF6JT9AeGE1ySaQtpU2DvFX2C3L5tr41zo+6Tjr6/mL3LQPM4ec4E+qzXPKq0N1c+RBTlUOQFsj62nCAAnb66/uEdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHyjmv6EmE/QTAvmeEyXrOh4NqTSariZbbI0t5FQLx8=;
 b=AS0fZD/hlW4qz2aWtVLAO+S8VwOZWVAC7YxktfeisAOaxoU35omx7RwdRvgBWXguXgK/CyhPz2qobuKqKs5NWRjnEEkqf7pvXr6VTi3L99KpxQ34E9mvR67vUkEqu1PaE/1Tdse7jbmPz4o2MSFZclGAmaHIrEIYtu4NZj1gGSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by SN1PR12MB2527.namprd12.prod.outlook.com
 (2603:10b6:802:23::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 05:10:54 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0%10]) with mapi id 15.20.5206.013; Fri, 29 Apr
 2022 05:10:54 +0000
Message-ID: <3f799406-25f0-3105-250b-dfc68cac263f@amd.com>
Date:   Fri, 29 Apr 2022 10:40:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <6bb3a6de79afbdb1ebc1b804fb8c2002c00cbaee.1651058600.git.sandipan.das@amd.com>
 <5c227ef8-72d2-9254-f061-128974a6dc7d@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <5c227ef8-72d2-9254-f061-128974a6dc7d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25dc7eea-d5f7-45e6-44a6-08da299ea2ae
X-MS-TrafficTypeDiagnostic: SN1PR12MB2527:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25271F851FB4FF646B7826838BFC9@SN1PR12MB2527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkrG1JL9dCkVISmdtZw+1tUvl0Nn39ySPJazt8TVVNPAZYY9W0dVDYFs5aIe6TI1KZ6WWvR3mlPei+GwcjebOsfjUO/U+GdjP9vnaUl3ETUOhgKNJmG+WsvBKKX3e1BOGudxjF2qwYcCnAR2AiT6zmeNxceJI4bEkX4idrbetIQQCioxWfPeIj6tuifLLLchJfeuvZw1tGRr07aCZMGjGuzH+TTdBUEuZYsEZJnT9/WEHIwC6Z06gQrN74AoZY15f5BrS4szDbzP9wqQaCpCtKGV26KkB+9Lu5tyeHfdAPdrOw/wrCSkvXDiSEawQEFOkQCLCuHVkdY4dSrlOFRT/48fBrwLUd1sqIxhkNUKw3M7TXvufq8A8a6ckDZqsecEoO4JZmCuzmMI93SGcYCarK/ITP4/jICYxgom2t+yfINKdEdciaack3sKEQnkEAES3Vg0v6EpNPSMTOpei7HU4o17y6ygTL/HTFP9p98feuBIE+LD2vUTdBmZbOy2l1nrbL8RagI1DCtSpqoTs3ViE9/W/TW5S3webm/rk4ftq9eCZxQGPLB7FJP4jJ6lsvBeSU4KksGLph5Sf46ehy48hgcfElQyoTO42NpoQZ+nG9P/nEJHGi23MWbm4mbZTfbfsIyNNCA/BPkv4MGTAnco6DgfM/WxbrgNWTfwef2v1Sgn49BFBl1Nm4r8GiFgFbARldl+79vWp7G0NK1tuk5Mo6tBqzvA9HcyOmJJ/2jsb2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(316002)(31686004)(31696002)(86362001)(6506007)(26005)(6512007)(4326008)(38100700002)(6666004)(53546011)(66476007)(66556008)(6916009)(8676002)(66946007)(36756003)(5660300002)(6486002)(2616005)(186003)(44832011)(4744005)(7416002)(8936002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STh2S0VObTNwdTYxU1VnQ2VCRFd0QWZCWU9nYXY2WEhFU3VkTnpaelUwcHJ3?=
 =?utf-8?B?SHZRdERqdVFhMmc3NFRQc1dTUjRHYVhSZld6YjhaYnRyZ1EyU1pKMlBCcm53?=
 =?utf-8?B?bDJXUWJDUXdsK0pEc2FQOTZtOS8wajU1bUlHMWVsdE91dHZPRmRCWG90bWxT?=
 =?utf-8?B?TWNzOW9mT1BtNXFRZ3dTRVJxLzNKaWp4dzFYODlDZTVSWHJIT3g4S3N1N3lE?=
 =?utf-8?B?Qk85cWRWZ01TeGhuSVVJRWlvYm5VMnhzVUo1KysvRVJDQkpwNEVjTzJLVFpv?=
 =?utf-8?B?dmJqYVJXYnBmeWV2V0k4QVFWK0YyV3JEaER6MUNoZkh1eVV3VHFkZDFQVXFX?=
 =?utf-8?B?VitmamNwem43OFg4WC85U29JUlU4VEJVc3IvS1hoRTliUkhhMTBxWllDSWJZ?=
 =?utf-8?B?UWVScFBaUnlPMDdkUUpRazF6L3c5RmVqTDhENFBlZFJLMXlUbUk4TjJ0dUlp?=
 =?utf-8?B?aHZ2WGF5QSs2TTZ5YzFTblFGU2Y4M21pYlBuTmJWMDVpcUFHcXUwVnE5TGRT?=
 =?utf-8?B?VXBKTFNNcFdZNXNmREtpTFdZalpYNngwOVA4UnpuVEVQbVZiemxVMHRyQ0xF?=
 =?utf-8?B?Q1FvbmUzYzJFSk5scmtncjhrY2Z5eDFTbkVEeDRuV20yUENiOFNiTHZvdGFR?=
 =?utf-8?B?Mk9leE5yM0c5SVEvcWZUSHZHZWxZcmw2aDc0WXBtUnlEYzJla1FOUm9Jektr?=
 =?utf-8?B?SzJjTWZyeWN1WjJTazB4K3BoMDVuNVhIMFhzTnRuQ2NKZThIOHJDK1F2SXdh?=
 =?utf-8?B?aWNSSkN5bmEwUmNSdUU5VW83MDYvNFlVYU1RK3FLOGlYQjllK2lDNWJmd0k0?=
 =?utf-8?B?NnZOZU1OUXlzNkZMdFNpWlY4SEFiN0w4OFV2bEx6dVpsZW81Uk5oM2J2Wm1D?=
 =?utf-8?B?ZHNHbnBBSGtjT1RRVFBaUGFIVm1abUNsSGEzUllUbjc3dUFLajF0VzB4T2g3?=
 =?utf-8?B?a25hVDd3Q3ZjYUVNUU5jZ1VaZ01KTDF6cTZZY1RNNFVCY1Jaa3BTMmFzZS84?=
 =?utf-8?B?alJoMUZnaEdsc21OUEZseEMzVU51bXBsdEhWMklZS3EyRTd1Z3Era3VZTklu?=
 =?utf-8?B?M1FWMTBjUjdNQmkxeHdic2V0ZVI0UkF0TWhSN3ZBVS9xckRVMHVobitnd2g4?=
 =?utf-8?B?OUM0bktzS0t0M3lTSW5YT041NnJGaS9OeTB0b2c2L2tSYzFZbDRTT1MzeHpa?=
 =?utf-8?B?eUEzdzNOL3BoN2FlVVF1S3JZQUZsNnN1RmkvMHBnL090RjhEcTZzL3dFYjU2?=
 =?utf-8?B?bjFWVm5qUlljajVyMlppWk42VGFtNGkvaFZZZmlGTEtBOCtPREZaRUF5Um41?=
 =?utf-8?B?ekJIeXJYNjdxOHVLR3ZQRkhsQXVGU3RSTEJIRFBDTEdmbVVldmJOa1ZuZ2VW?=
 =?utf-8?B?bXZ1c3laU0ZSbk9ESE5ZbW1DUzBrWUtqZXp4MmhscjRyNHl5elNKUjJTUVBj?=
 =?utf-8?B?bUIvWnJlYkx1Q0N2WUVyd3M5THlRUDlxR3RpSmtvU25VUG96V2gxRUtONXA0?=
 =?utf-8?B?RFlVSlVnNkVBT21aRVIwaWIxc3Z6L3pqRTV4M2NwZ29TYUNYMk5pU0NGTkZt?=
 =?utf-8?B?ektNdmxFRkpOZEwzalh0U3hreWpRVVlOcnZHcllvaUF4WngxY2Y5V0NGMDNS?=
 =?utf-8?B?M0pUUzQzcjFBNndGN3VvWThENS91S1RoVEpIOTMvcjJPQmlkaDFmbWh1ZEZr?=
 =?utf-8?B?RnBoUnpPZS9DOXdmK1VKU0djczVDUFNGcW9ZWWNvVlRuYXp0ZXpDazk1cVVM?=
 =?utf-8?B?RjhrTzJRU0IrVTY5Z0EvVWl3em1USkxQL0JjT0FmSWtPVG85bWJDRHBGbGtM?=
 =?utf-8?B?c0pPTmFhR0JGL2htWUN2d05HRjdTSVN4UCtpWDMyMHcrRlYrZzZaWTliRTdk?=
 =?utf-8?B?UG9BUmtPUnlibHE5YXZyY3BhWndNSDdKR09CK2d4YlBJWG9mOVFPclhKV3c2?=
 =?utf-8?B?Y1RlVjdCWlZHMjBOb2gwYmNNRWdwSTdvWHl0NVg5YmFXL3loRFp6aXAraGN5?=
 =?utf-8?B?dUJVY3RuMjU0UjJJRm5nc2NDU3dMeFpESmJBTVVhNCtLcXBTeHBPZ0gzS0VK?=
 =?utf-8?B?M3hXWTBaQ1hCeXJvNVNvU2lLTW1GRWY5SGN2L3g3SDU3WG1aRkFqUk9FVWRV?=
 =?utf-8?B?NFUzaWhqcDFoSXVFMWN6TUxwbjZlOEJ0QUFmTUtCZS9seUFXM0p2T05Ia2JN?=
 =?utf-8?B?S01iOGF3MFNSQ3V4U1kyYUVvS1ZlZC9ZZlJPWDBwVTFxOUU3UzNFeGpkcHE0?=
 =?utf-8?B?OXl5d2hqOXRmbWg1cjREZTR1UkJER2Nmd3I0S29JelBKd3RJV1FzdkswRTl6?=
 =?utf-8?B?NFBEa3JDVHh5VXRMNzZSdThUTHlKOHh4THdtZ0NPdUFJbERnc1M2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dc7eea-d5f7-45e6-44a6-08da299ea2ae
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 05:10:54.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69PVVXFUI3q5MWJdd/mpkp5uk+zG/m37ohKgeGUdgTdaq5p+iZ29nO540QhFtI9zSpVJEY0YZRMOTnhQMUV/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/28/2022 7:10 PM, Like Xu wrote:
> On 27/4/2022 7:31 pm, Sandipan Das wrote:
>> +static inline void amd_pmu_ack_global_status(u64 status)
>> +{
>> +    /*
>> +     * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
> 
> If wrmsrl PerfCntrGlobalStatus, remain silent or report #GP ?
> 

This is a read-only MSR and writes are silently ignored.

>> +     * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
>> +     * clears the same bit in PerfCntrGlobalStatus
>> +     */
>> +
>> +    /* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
>> +    status &= amd_pmu_global_cntr_mask;
>> +    wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
> 
> If rdmsrl PerfCntrGlobalStatusClr, does it return 0 or the value of PerfCntrGlobalStatus ?
> 

This is a write-only MSR and reads are undefined.

The "Field Access Type" section from the AMD Processor Programming
Reference (PPR) has these details.


- Sandipan
