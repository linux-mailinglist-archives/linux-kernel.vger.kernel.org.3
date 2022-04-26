Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA150FC21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349608AbiDZLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349604AbiDZLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:46:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B913C490;
        Tue, 26 Apr 2022 04:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P66AuvajrujR/MQotw+1ymhZv3x8JRuDFimdJ4G47AdgyRlFSu2HyxE0C3NY0/ZoA3pbmIDrijgUYTjQWtan8L0QHisjk5Gtkx/KLWJTPrXdauEghLwhpsVH1AAyeKPTI+gmmulJMcb7gcv4rqZ9UEWcaQ/XELHJ9xEkaODTNweDFwdBfkbropu1y7cEKOz6kqSjJCfFeDZrkrIvcJvLIYHjsaGKguEDIquHtfn0gr0Icxm32j4eJtVb+VqX2hRTm0SlnZgSqeVLHgOa7NooiZLJ2q9yKoHnBPpK0Qc4IlmatjIdLojVNEC7H1VMZZqh75VUcfQGMgMuBhC31AEDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3d6U8hLC8JBh4W/SMG/72osSR8J+9mWFjLs02HrwPk=;
 b=XjFFy1ifsUKAM3PS+ojFHboMFTQ+H2+evJbiVkUzjlHuFQWxjUqGTFklZpfpa9RvCpjqDUWy7oidhP20XbRrwQCnK3MLXtBuUe9qeYdckBIApAsY6DtAUYlNoitYq7tlPaMv7IZAS/adrfTga2jhmjAfjXOohU1jJUvRG4KnnmMLfnCu8TpMDM/bavo6yamSglZNT3+gzUDqeAJvZqfND5+LdEOPC6Nmonxi2zb5AAyKyrgHkiBifZAnczrWsv3X4ZFnjjtEN5reS2xkLpfpAK2gFnMn7idrsE8FCKRmA7TsVztVr5vSlBvQ8eLubFjPs6xBaexG97XGpVsUZWCZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3d6U8hLC8JBh4W/SMG/72osSR8J+9mWFjLs02HrwPk=;
 b=Fe9xPRNqYnAsWT/rD0juIn3tH+sv+G7FjT6gEDhPN3jj/REj1CvLyy5M92Z9aSuh1UUgbV88Bq7KQbEBSsyoOJt+6GsVP7SHLsZlRK8kmcFB+9jDYq/r5vpqTT02cP1qIowlR5qN85TfQ+WPlEVdf3++dcFpndJe7NWUFK9by5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 11:43:34 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:43:34 +0000
Message-ID: <debc3ad7-221e-c615-435e-0ddced9c6276@amd.com>
Date:   Tue, 26 Apr 2022 17:13:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/6] perf/tool/amd/ibs: Warn about sampling period skew
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-4-ravi.bangoria@amd.com>
 <YmfE6wIA1Dbet1nX@rric.localdomain>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YmfE6wIA1Dbet1nX@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce68d2e9-cb7c-448a-18e9-08da2779fe97
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB401217BFF633C4A8B0F35D08E0FB9@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HpFAkXGEZbnbFi2f6RehuL0fE9WuQdQ/I/3sNegP0q3ypsFER3dGVgYAd+vkhQ4P1LYqKg8ebtxRVMUcBb8X85r9YFeW2rlAGebUe9YMpzuxP2AWhv1YRdnK/j/o329/7MTNPd5ne6HwUthn2R50AtWbDFMbCtv2mIkHNhm8zYT/riYTuBtTOyOOM6k6bSAu7n6gMkNfgXCN5dw9iegZaVXyf/goGsr2bxo5yJ6E89THFfV7AqT9cURNR1LKZXfVJRtL/pWp5LbS6HdCNSPgaGK4SSlffn1t65cXLgSNwePCZcvC9MroCS4qmQBpdbaKVZF070/1ERcDaGXPxnF5srnWj9b7/pdh0wLG89asEbaWZlwEBmQCUodbwO5igqvq7Td2xv/zJ9GhGQGCB+qrBxS9VrdU2HZsDHj7Exq/4ymtVEd8OAzmbRjFUZMIf/AfFYE6Eg1Aj24wcujrP5KDxJ9geIjL29ldnVqGHF/drOiPzVdbjcEo7PMtzm3Arv2pWZDzd6B/2emH5vtdlJfAHt9WzvZQjAc8oYIBLC9M4MMqCSHyUqe8lXP083c+F1nT+9QdAaHYf4Vyx/OPCsOpII17F+DU4JXdaJCrzpUwW4vwJR21BkZHRU2qWg4qZeVHMYiNlExSPtVxEBJV04UiEIsbv7JMQB7MCrtXVj6MldZDOq7bDNZXX+wGN8OlJZ933bgaFJJb16kg46F32p52jwHZPTfdN1KdQ13Ct7aO0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(31696002)(508600001)(6506007)(6512007)(6666004)(86362001)(6636002)(186003)(53546011)(36756003)(31686004)(7416002)(44832011)(8936002)(4326008)(6862004)(38100700002)(5660300002)(2906002)(8676002)(66556008)(66476007)(66946007)(26005)(316002)(37006003)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlcyZHVnTlRiaFR2a1VYdnFHcWw4d1M5WStyUXkxdFF3cXpSRmtMVDNQRUxy?=
 =?utf-8?B?VHFUZGZ2ZXU3cUMrWVFyVlZVUWRWT0k3WGo5QS9ZM293aGZJRTh0cC9Ld044?=
 =?utf-8?B?SDlQc0xUa3lTRzNIVXVxY0NWbkpmalZyOVpzdXNqZTRUeU10WjVud3NJOWpO?=
 =?utf-8?B?ZWRMVzBVdkJULzRIUEJRN290dEtmS1J0T1psemZDWFNnaUJ4SC9OZU02VnZY?=
 =?utf-8?B?WWxpR2wrSzRXckNHbFdVaUZMYnduaFlZTkw3eDdNcVA0TTVwUTJGSG9ibGMz?=
 =?utf-8?B?OExrcnd2b1JaRmdETU1pSWlaRHI0dDRMSS9yZXFvRzZ5YllFTUl5MXR2dEp1?=
 =?utf-8?B?WkExOUN4SldwWktlbkQ3aCtMZWF6UWY2SkN3bnMvaWdtbkdXNmhTbDJDVktN?=
 =?utf-8?B?YnpBS2JSbTZKMGowOWNTY0daVmNKTVhRSlUvQjFsVGVNamQzL1p0RnhPbFVJ?=
 =?utf-8?B?bnUzUFdzVldZNWlLTlo2elYwbkNSMzQ5Vk8yTmttTTh0SlQ3K1J3dWtWWEJV?=
 =?utf-8?B?ZEVMQ3lJVXNxQzdNcmwwcGtjTmxoLzJhTVM3dDgyWkFtbjFyM3NZSHpGSnhT?=
 =?utf-8?B?Sk9PeXYvRE5MV1dUN1lBMWdsYkFIMDFmWVBJVjI5YWtaQ3dxSUlQUjdNVzlR?=
 =?utf-8?B?dE5wS1RCNklkelJWMExuWkgzTEVSWThNRzZOOXorYVNJN3pwT0VKc0pWMGhz?=
 =?utf-8?B?dHB2SVpxRlhxd3RKMnVvTnVMVnFVQ2hQWjlHeUNGOFE1b2JOejBrMnVJUFFO?=
 =?utf-8?B?UmM1Rmw5LzMrVmZidXZyYW1tNmpudTR6cWlIbkRhTzIzUXR1UFQ0MnZXY1gr?=
 =?utf-8?B?cDhtME5aVXM1T3ljaUNJTWdJdDIrRlBOMU9VQWdSYkxHT3FlL1Y2MGJVdjFI?=
 =?utf-8?B?TU5KcDc4OXkva05rVzBkWjFEbmh0Q21sSkgxVnpVdVFFM1dySlFaSFRCTkFk?=
 =?utf-8?B?QkRielJ6M25acnVwMFNoM1Q3c0gxUzJVR1M2azZMenFRblBIQVZESjVlL0g5?=
 =?utf-8?B?WFVydDc3NzlnT2tjK0dud3JYc3llbzFncFd3Tllua1VYamZBQWlFVVRMQk9l?=
 =?utf-8?B?SWdvMUJPNGdFTkNka3pISE5mdWtPNHhVMFlTZDl2VFRBWnc4MHlWTUdJOXVs?=
 =?utf-8?B?TTc3Q1FreXo3M1NnNlNkb2JwRHJZdjFsc2xrY0hLLzZpbXVWSlJqMXY0NTg3?=
 =?utf-8?B?ZnBVdE00dWFhZUdPOGlndlhXSXJvcndHSjd0SkpWOFloWmJoTnFOSkNxZEQz?=
 =?utf-8?B?TEtRcDZ2cXRaaktESC9oMDRHR1A5RjZWcENTRGNQS1JjSWNqai85NlJCVUV0?=
 =?utf-8?B?WkJCRzMvT3JHU3dDZGhyK2xTZXBDUDloNjg5V0R4dWN6cFQ1TnJJVnRpTmtY?=
 =?utf-8?B?L3V5MUlRMWZFbzh6MTlzYzRwaG9jM1BwTDl6Z01iZ3E0NUZ1Qm9lTFVWK2Nz?=
 =?utf-8?B?WVdkWExFOWJqK1d5azduR2tSZkY5U3pBTy9aeC9zcm8zRy9Pa1BicEtMTXlw?=
 =?utf-8?B?Y3FDMnNwWElyeHA5RDRSbThBOE9aWVhoYUpWYjdrN081dXh4eDRQTktrMThR?=
 =?utf-8?B?aUxsUi9WdWlmODhMSHFmWFRwcUUzRFV0NDdZd1dSUHJ3VDBCeVIyNmpFZkhV?=
 =?utf-8?B?S3lPbk1aQXZSMzI5RkFKd25uR0d1NnRDWlRvbU1JVjRtRlJoNy9yWG5SZEMy?=
 =?utf-8?B?RTRwcFZpa2NMNzl4YUtpUEF3ZjB5NVpHWUdmYmJYS2x2Y0hpeWZJUHRBRGJB?=
 =?utf-8?B?VmxNTm5qdFFxbWtibDRDQUo3aEJ5S0x4MXVtbTFNMjFXNkgxRENBdkJsQjVq?=
 =?utf-8?B?ZzF4d00zUHZqY2hOSFVqdWtUalg4STdOelBQTWJwUkxHYThpOE1qQnhxQ1lO?=
 =?utf-8?B?aHJLdlN2YSthRDExU0NTZHhZVVRpaEJYUEFUOEQyNXl6bk9wbDVvMU1iVVdZ?=
 =?utf-8?B?QTRxa1BNVmhVOTJGaUREbGtrVDBlUXI0NjM0czM4bUtEYTJRSnJVMjNOTW1T?=
 =?utf-8?B?dDBMRlF4d1FlYXNaR2lvUHVOcmgyZHg3NGJ2ODNHMXlBbncvcUs4QTFNMGlj?=
 =?utf-8?B?Z0Vad0pXejlrYWY0aGxzbDNWSXlpNGF4RFFFNnpsRVdEdHNiMVZteXVEZlRn?=
 =?utf-8?B?SkFzWGVwWDRpRlovdHJwNVA4WHV6bjhhZmdYbFA0d1A3VlZRZHVXakJYRWha?=
 =?utf-8?B?Ym1GTXlWMFpieWJFYXBqcktsbTJIQXRjVnA5VjR5dSs0OU9Cako3ZUc5OXFa?=
 =?utf-8?B?MXBXaTFQMHltQlRWM0VhU09lZkMvYThCTzRJU0d1OGU5dEhnQmphdXk5Wlgw?=
 =?utf-8?B?SUMxTWI4Q0ZTd2FkdVhodm9aYUFSdWlhMkNxbW54Ky9DREFxSGY4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce68d2e9-cb7c-448a-18e9-08da2779fe97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:43:34.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpoBRymOrc4yjX4BzxkrLO09hAsei9zc6leKENOnI4lTuzzy8ht7shVcU07Hvvl0e5hvAo6VIMidOF81JU3nKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 3:39 PM, Robert Richter wrote:
> On 25.04.22 10:13:20, Ravi Bangoria wrote:
> 
>> @@ -29,3 +31,32 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>>  
>>  	free(env.cpuid);
>>  }
>> +
>> +void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr)
> 
> Have an 'ibs_' string in the name?

No, this is not ibs specific. Any arch can define it's own version.

> 
>> +{
>> +	struct perf_env *env = evsel__env(evsel);
>> +	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
>> +	struct perf_pmu *ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
>> +	struct perf_pmu *ibs_op_pmu = perf_pmu__find("ibs_op");
>> +	static int warned_once;
>> +
>> +	if (warned_once || !perf_env__cpuid(env) || !env->cpuid ||
>> +	    !strstarts(env->cpuid, "AuthenticAMD") || !evsel_pmu)
>> +		return;
>> +
>> +	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
>> +		if (attr->config & (1ULL << 59)) {
>> +			pr_warning(
>> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
>> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
>> +			warned_once = 1;
>> +		}
>> +	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
>> +		if (attr->config & (1ULL << 16)) {
>> +			pr_warning(
>> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
>> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
> 
> Avoid duplicate code. You could move it to the end of the function and
> early return if the config bit is not set.

Sure.

Thanks,
Ravi
