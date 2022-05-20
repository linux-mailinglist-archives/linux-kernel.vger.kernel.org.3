Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E352E35B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiETDtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245387AbiETDtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:49:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435D146431;
        Thu, 19 May 2022 20:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4lJ1r425Pbf5/45fqCsXBDqOg1TDSSixq8hNkLDj+rG4sMP/k9u1QJhAdHHdS8sziD6bLbM29ciujgJowpbkHOSwOENOibPzdM0bu/WOU99hTexBavEOApQU+n/MzRih1tIgSIwPKIqueTk3cSmcjSIeUOejZgXrOxdfOm4SPXFpehZT/MeqZc28dF5HuUfYcg5venY1LMeX07A2d00tXz3b3FVpIVLp7hzc551eRbtqeEzyVyzBYPhb1ZWC0yJDCp/tGvSYCNI3xzuSme7CisCe4bPtLaMqqk3qkDj2gXbxumR7DuPGvNKl8REW2DskVUNKM5gfF6xqnmXXcUhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUQMGPSVw/iXGqXUxtKGmsCUvxZMkCvv8CW941olpw0=;
 b=FkREtMQvyRHfhP8Y3DG4VS4RQDoWzevQGzelF6rtfKk7e972w/XIH+yXIFE57g9yfuUqN6CJs0e/MtM4Ljtoub3H+HgX5Im+FdFBXeEwlnFqY3UUd6pOL6A/SqoPAgCNQJBvvw/BvM7P7mNweHdrAi7RzC7dfTffAJkoBz060rn7fNUHJsbHsiUQqdJN6xA7Yr89VvOD0tyV7tqBG85C9cEZyg6BPVMwI3VsQO0+hak4+o2NEaDu6SFXLvgtj1zeqXK911OZqtIPXnLdgEmUBhO/GkNO8uZOLj8uv1n4fgttQJ0rpytCan5i2VR8Dcj4tqw6AXBztWDiaN1uhYGBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUQMGPSVw/iXGqXUxtKGmsCUvxZMkCvv8CW941olpw0=;
 b=Lh2FGomlX32IuhR/DAnqerbx49EUHsGYvV6qzl8plKHLAYuVV/bmIddwhu4au1pXaiSlQOkVnadP7jkOg3gxS86Zj1lu32GbR+iwU/unY2YorTiGkeeLkscEo/jtIhZLFGY5LIZAyGfT3sMG5uUo1zJx9bQRB3HuEV9AeU0v02Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 03:49:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Fri, 20 May 2022
 03:49:47 +0000
Message-ID: <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
Date:   Fri, 20 May 2022 09:19:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
 <20220519054355.477-3-ravi.bangoria@amd.com>
 <CAP-5=fXiZj+EBqmg89faK0pZD-Af3V1fHWMOkds1oKoaz+ucFA@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXiZj+EBqmg89faK0pZD-Af3V1fHWMOkds1oKoaz+ucFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::26) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98604357-1c6e-41a6-f6c5-08da3a13c853
X-MS-TrafficTypeDiagnostic: MN2PR12MB2989:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29890112237204E041C95AE0E0D39@MN2PR12MB2989.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgniAox86SSrnqPSBWDZb18n5QKLqPQVBE2Mg4dPpof+5phhiPtQrD703FfcPUXM1Q3qHhz+q/vL2i28rb8tfuKnfwcLJRFwkLoqMuGV8ZmpT2dxQaJ3RUqYmDKzbJFxkiAqbSHxmDkZ7ePeTnrdXkyrJCC7KCmBhONgBKFBw1L2disKRpe3rr46YLknQI649aniMe3hYRjts1kZ6h4/kD9hSO0xQeanPlgTvyLly6ol5kDXz/6nGCdbBthRnCdjUwWdgsAZ5ZdyeR8G1zNcFLjuAO7I9ls8y20qGG82RjyJJZSBE955wtJv+IRcSAD9JqeO/a77cl7Nn7mXR2c1+FUqED+Yul26XEbfisK1CcEsBqsETbP3/3TxoQ6UebDUXZ1WeUUCxNfy1Mm1fni6dc89LYd19gIulw61i3dDCf2WMs4xEO9X2PjZNY9RwrpU7XQ265pgM3VBYYFK50FsFb0jX/T3XkcL/yUi03YOgSmpmwuxZiVvmgs7Y7mDUPIgi9dUl0vTy+bEVX6902IRcSe9DL1k0mN5JTnE6Jsy49hFKndu4U2KYYcRK/fa7hQEhdbME1XLbNekiic+a8TSjLfPY4oES4vjFpeWxasPATbVoAehJg8S+72sRcPCZEmftfCocayauJDbWEBRnIEkZVXHiWeArdUjmfUv5opcCHARDLNag377lwfBxcnhTGRthJYxowYwugPIQp/nCiy9PlIClBSey3WnynB7FWz9tqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(31696002)(6512007)(38100700002)(6506007)(86362001)(53546011)(83380400001)(8676002)(4326008)(66476007)(66946007)(66556008)(186003)(36756003)(316002)(6916009)(508600001)(2616005)(2906002)(7416002)(8936002)(44832011)(31686004)(5660300002)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpkVy8yU20vTWdXaE81b3VZWVpFd1UrTmM3SVJHdG51TFV3R0RUZGR0VVlR?=
 =?utf-8?B?bWdtejNpNE9VZEs0a0VqME84akREcWJrdlVnWURVb0x5NFRYZEt1a05sTlpY?=
 =?utf-8?B?UENZZEVnNGo4RitOOTYxTUdzNS9oNmJDQ0wzc3YxbEVoRTl0SGk3b29WZ1VP?=
 =?utf-8?B?MVhLZnJ3VktJMmpVSUFKQnBpVHhSNDB5VjhnWTd5Ri9wUWxMNUpUYnduVDRK?=
 =?utf-8?B?WjloaDhyQ1IrVmlSc3NEd0twckNYWGlKYVkvM0RjRlZ2dFBza2RqMW80Z09L?=
 =?utf-8?B?dUxCQWUxRXRtdm9BN1lSM0RXMHZ4aXduZU9wd3B5d25SbFNGSmMzRHJFNkRO?=
 =?utf-8?B?K1hUV2dsQ3EwSldia1IyYzR3MTVjNmppMUx6YmdYbVR3cU9oZTZES1QyM1JV?=
 =?utf-8?B?WVBZVUJQbEdxaHpWaHF5WnhVS0tFTHBFeUdJVnJId2hRcUYxUlA5cDRkSWJo?=
 =?utf-8?B?NHVGbXJVUVRFRzJwd3ZlQTV0VnhyQllXTzFzQWswWFAxalJjODRaOXBraE1n?=
 =?utf-8?B?dFl5Z2lWUWdkOTJWQ0VvTEZJQWFhS2ovNWhmUS9rWklHKy9RQnM3bVcvZ2FD?=
 =?utf-8?B?Wm1xeHlKbmZWY0loUkdIMCtqVFlTTmhCMnp4aWNkanZYRWlDWEYrUm1hTXVB?=
 =?utf-8?B?a0dnUGdPT2tUZkVHSkkyRGs5Q2hLWEh6RzVCTkNzUCtjclhXVjI2TkVRcnNC?=
 =?utf-8?B?QitLN3NsZTFKOFRocU04UHVqdTNoaGN3R1lIVEhrUnAwcUlhVTlqTGNKUVNL?=
 =?utf-8?B?K3EyRkJPR1ViYVpDbUtKR0p3QW53SnZnWlFLTHBMTTY2Qk82SDRib1dVaUhC?=
 =?utf-8?B?ZEFmUFhYL0Z6aGxRVE5LZk9nYlVLRDZBd2MxeGtzK3J1SEROTjNCM2FZeUht?=
 =?utf-8?B?d2drWXViOWtCMThNRTM4S3VkUWxyOGtUZmozQldhQ3VVeU1nVmF4OGJjeUlL?=
 =?utf-8?B?b2Y4MkNEQmhEcm05TStPTEd4K0RCYlRDeTMwQkxZeEdmZU9WOUpIaS9idUlV?=
 =?utf-8?B?RkNvYkZsUEZIN3hNQW9jemtVWW93VGU4Mkp5OTMxdkJCZURkUlFWNzUwOGRZ?=
 =?utf-8?B?SjNFVEg2Mm9OTUJkckQxaHZscm9WT3R6bEUrdVlYZUpjWTF4YlE0eGttZ0pu?=
 =?utf-8?B?MklxalYyY3B4YnMxU05lWDVkd2JReTdLaUlMOW1jcG8rcndqSHVmZXpxUGNo?=
 =?utf-8?B?Vkc4TCtLSGFldU9FRlRWd203REVPL25rWVhoekQ2U2s0RjQzbitxa2hpZld6?=
 =?utf-8?B?UkFZZ2Y0Si9MZDlaODRJNlhHVzd0WUdUV1pvZFBicXJBdktXOHJXMnBEVHV3?=
 =?utf-8?B?SWFZMndRRHZPYzVrT2ZTL2NUQVZhNTk5TFYvRTdLR29FWTFtTEVEeUZEWUFw?=
 =?utf-8?B?THNRYnpvZ1pwR2tmSm9Sa29LQXgvTFZLdE5ETmJmRzVEQUZwaVNUaHFFL29T?=
 =?utf-8?B?bUxOamFNMlQ1SnBIVEx0MWZucUxyNWkzY3NwSE0yS01pMGt0dWd0WmJ3ZzNV?=
 =?utf-8?B?d0UrNTNpS2NvVjN1WkFOU2R2c01hZnptSnB2cWpKTkx3QkxVNDFVZGdoVUFQ?=
 =?utf-8?B?cHFaeVN6dnE0WFpGcE1PUUU2L2pqRXFaVDVZNm10QXE1b3NlZ2xqaW5LWVBQ?=
 =?utf-8?B?eGVIVExsZ0dlcUl6STZlaGhuTW9KZS9paHNrblZtRXIrMEZmUVN5UWVCZnpS?=
 =?utf-8?B?Ty9EUUtTZGVGMHVqOEdlSnJXZVI3N1R6dVRMREhWRkVrdUZjL054Z3RGMHdp?=
 =?utf-8?B?QXQzS01oMGkzbFVaWXdrMXdPeWxzQ3cxRkIzMGtRT00zbFkzRk4vZFJiaUpL?=
 =?utf-8?B?aUQ5MUxxc3ZXd2NBQUpxaW5kRlc3VjhjbWd5SDVjNDJ5VEFWUWtVUDh1N1ZN?=
 =?utf-8?B?OHJ3ZnRYelJVaWRQUkFVWDBrdzlxMGNIczRJUlYrMUZqczMxUzVnK3I1bC85?=
 =?utf-8?B?NXk4eWRWWVdlajBvRm9TZDVNdlpsTDFZOEU1UnF4c2xxMElaVG9meE9HMGhN?=
 =?utf-8?B?aUhXVHY0bkg0cE9GTjNSaksveWxZWGl0NEFiemp5S0JKbEZFb2NWNmVTd1Fq?=
 =?utf-8?B?ZHNlWURRMmlFUzhXeFFZMnQ5dC9VQXBjVGx6TzljRUsrci91eDhxcVRabE96?=
 =?utf-8?B?TG9sSUxDZTdJS0F3b1ZoVXp5cXpFcjFHcEtDUHVoVmtNQkxoKzlmbHFid2ZY?=
 =?utf-8?B?MkNXOFI2R1dZV0thTWhjS0lqc0dBaC9lS3ExcHlaNGFWWENDRDNlTWpNaEE1?=
 =?utf-8?B?Tmxmb2M1UHhOWWMrazlzaC8wLzFrS2RwVDFZNEx5K3JiUmRMcE5BM1VYaGNI?=
 =?utf-8?B?Rk83OGZDMFRobzVoL1Z2SHRtelhpQVpFT09vQTRmYkx2ZmxCdkttQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98604357-1c6e-41a6-f6c5-08da3a13c853
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:49:47.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoEAS3Q5dYSC1o5eAmM/ciCeYMUVR3IzO4wXlM6zFljLVSlHEEXFadJm+dMdeAM7LYv7rQAJnkHuzyw9/DKMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 20-May-22 3:57 AM, Ian Rogers wrote:
> On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Pmus advertise their capabilities via sysfs attribute files but
>> perf tool currently parses only core(cpu) pmu capabilities. Add
>> support for parsing non-cpu pmu capabilities.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  .../Documentation/perf.data-file-format.txt   |  18 ++
>>  tools/perf/util/env.c                         |  48 +++++
>>  tools/perf/util/env.h                         |  11 +
>>  tools/perf/util/header.c                      | 198 ++++++++++++++++++
>>  tools/perf/util/header.h                      |   1 +
>>  tools/perf/util/pmu.c                         |  15 +-
>>  tools/perf/util/pmu.h                         |   2 +
>>  7 files changed, 289 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index f56d0e0fbff6..7f8341db9134 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -435,6 +435,24 @@ struct {
>>         } [nr_pmu];
>>  };
>>
>> +       HEADER_PMU_CAPS = 32,
>> +
>> +       List of pmu capabilities (except cpu pmu which is already
>> +       covered by HEADER_CPU_PMU_CAPS)
> 
> Sorry for the ignorance, is this currently broken for hybrid then?
> Will hybrid have a HEADER_CPU_PMU_CAPS? Presumably this varies between
> ARM's big.little and Alderlake.

It's covered by HEADER_HYBRID_CPU_PMU_CAPS, but that too covers only
cpu pmu. I think I should update the above comment to:

	List of pmu capabilities (except cpu pmu which is already
	covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)

>> +
>> +struct {
>> +       u32 nr_pmus;
>> +       struct {
>> +               u32 core_type;  /* For hybrid topology */
> 
> Could this be pmu_type as presumably we can have capabilities on any
> kind of PMU?

Not sure I follow that question but let me just put my thoughts here.

{core_type, pmu_name} is the unique key here. Considering a hypothetical
scenario: A system has two types of cores P-core and E-core. Certain pmu
inside P-core has some capabilities which are missing in the identical
pmu belonging to E-core. The header will look something like:

struct {
	.nr_pmus = 2,
	[0] = struct {
		.core_type = 0, /* P-core */
		.pmu_name = xyz_pmu,
		.nr_caps = 2,
		[0] = { .name = cap1, .value = value1 },
		[1] = { .name = cap2, .value = value2 },
	},
	[1] = struct {
		.core_type = 1; /* E-core */
		.pmu_name = xyz_pmu;
		.nr_caps = 1;
		[0] = { .name = cap1, .value = value1 };
	},
};

Does that answer your question?

Thanks for the review,
Ravi
