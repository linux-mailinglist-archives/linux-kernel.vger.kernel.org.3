Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01894D666F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbiCKQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiCKQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:36:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975861BA17B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647016554; x=1678552554;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KJkehE3F0WxxxG6fjwWeXWnSqCMm/Tes2QeW39sNvfg=;
  b=RL4K8CjylwUJz5X5N+67z6Ir48XUlqMdqG6iAF3NXR8l2k5kUPOgaTFG
   prd1I9gkn332IKhNzgN2kc0IrNPXPEp2nv2nCVgLei48uDQtMzGGF37Ei
   lcudewxqO4SFkzhC3vGzaXPwJPCIVEFG8JfK/xhSRqze7O7IhmtTlUKKf
   wkazEw+vjzogNZZC8Sne5LSmSQL1Jo0GLwVKMmuA8N/HQBiWTtw26Vr9L
   6xXCxcPU+9/EPQ+shSs7oPJpdQMqICYvQLvlAj4Nq6gDJBM45BAManIrT
   +DaSWp2hPEPFDa5J2ECEwQYfZ3GWVvMFSPv6YrC7CMBrfms8b44N7x28c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280350015"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="280350015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="579337604"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 08:35:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 08:35:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 08:35:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 08:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/K5nilnrrFuSqw7ndYBrv/3PX9a2LmDsk0NGmuT8R5uN5GSk3VYcfF7qPy698tpmkYWytupTxPRgzXVMAl1ydld+aQ5a6/ZGp0spe3z7lvNbcpn0xhOq7D3RrzNy0T3xjGgbiBcCMHFQS0tkDA8xL2ZyV6/XtJijxg0MTFxJKeRl70iNap0YtpoPxq3B/Rre7oae82MUPIM1NAJWd0071Coa5gDY3Z82mfikBvIo5d5uryr9FP5HZPfcAtEIRD5FtvuMYu3/3eVRDpAAVwMH/QIsS+aZ9cJ37CqjnLKfMrQt0/Wq6lrDlwENIVPD5OPmHN+iEDDelLbivJYlnDCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM5NP4kON0tbR5Gk+jzqqnkGNFTYTwkTpcdb2nrBqDs=;
 b=V2gZ3o+kLkVR5VKfpcRiRRYNoowF9X1STqm3PHWAGoXM1SZ/K9DEcAyL+MFXS/+i6iOhdDp7gr+IMTWTSwrZ1M79FwrDEsNPMqBKIXfxyPYDlnEyPLMjL8vQGrJ+OWrdrs6u/lnBX2v0zAdAtWyjBSCmTsTZpJ8RpuOIzVvNCmYupwL6ZrbHbmctA6VCi2zPu2lkkHBHseUN/cZECzM6GUqEFVl/rRye09VzaIIBplltmiCtSAv+vD9OLjpAvsO2wjbAvHltc9fRABkPwpI7iAACuFWS24TvsQT74dpoVOL6L4sDczr8cqzKHR1L7nlitEq+iyzMsgkBeIM+H41BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 16:35:51 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::dda5:a04:f265:68ad%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 16:35:51 +0000
Message-ID: <14cceb7c-f5f7-ee8e-18aa-4884ef212eb0@intel.com>
Date:   Fri, 11 Mar 2022 17:35:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in
 arch_freq_prepare_all()
Content-Language: en-US
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>
References: <20220311011715.2440601-1-eric.dumazet@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220311011715.2440601-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274c89bf-2093-4038-a3d8-08da037d3492
X-MS-TrafficTypeDiagnostic: DM8PR11MB5736:EE_
X-Microsoft-Antispam-PRVS: <DM8PR11MB5736053E8511C5A29F693B17CB0C9@DM8PR11MB5736.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxhFKSTLX1hSC31C8TpsH9T1l9hd0qGQXjHeIXRalSYP+8In6ngYj40Hq5o3OeH+ZPltHge8IgT3g5iLLgG7oTlhnVJLwGlz+aDmQV9l1/hm2PY2sVVaVk1obdByBQX8MGLEqI1j30xk2+Iuoa3KAJ5HFy5Bxvr7QUaaAWIkId0ifvnh5x7mN1jHlEXfpw6SciixcKc8EK//drclOk/y35eSkDJQSAQhoSPX48zHYGx5I/PbCTcmXIaa9FBvB7etaA8Bw/ZjvGiSgoOuntNfIa86joUJmyGPSjeohz1wZHj2hwrKX+tb3bbaUP+JDZfwQ9HUe/HqOAzyRiw+5+U1hAVMyLqfNTvUtCSfYTKQHH5TyXm47Ttj5GSQJEJxmQHcZ9I++GT98Mo/EL64BrXp9ck0NQqBZDE6Iq9NOwFoP3vCe8t2lPK4L47Q1iKovoZ3PLA8NqC1Ff6bFMk2b6Yr1z0RHg5OWX4oYOcivftOkZ+QHBuUPHCOFnQy8iCUHuIlU5W+mRmEZUUMWR90TDAnLfEwL3QBiJRzBvO8hz+lcpz5WVFQAyo+so94sv2uDahRNcekErenayoKLug1KVFAHAzHYMBa4XUIKcf6kZx53ssYtU6ZGD+GH1S6DjHwqRR73ADRqCT7qj+4exP662348ER2uQHeRPp0ipkwa7w8RaQpKbsoveDU+I5MTQPNAxtGD8ghR0RRIqHQ3773EddEgzrI7rerTgp5SQMyq9XPN2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(316002)(83380400001)(26005)(82960400001)(6486002)(186003)(2906002)(110136005)(54906003)(508600001)(6512007)(86362001)(31696002)(2616005)(36916002)(6506007)(6666004)(36756003)(31686004)(4326008)(66476007)(8676002)(66946007)(66556008)(8936002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RGUnpmTjF4UWhwL2NBajRhOS9BU1NoeE5OWlIwdFkvY0diYVlrek40dXpt?=
 =?utf-8?B?TXlXWUU2QWxiQktrMVA2Mm5HTkorL0pyOGsvc3E0V3BsdnpOZTZ1amw2cUt6?=
 =?utf-8?B?clFydS9zRlIrMUo2cTAvKzNDVS96QVN3dC9tZEsraWlFVzhJdDl1Z1FhT1RT?=
 =?utf-8?B?YzFIcjJ3NWRvZnJyWTkrT1NxMW5TdCt3MjVRaEJjTE9EdEkwNi9PWk1sUzRs?=
 =?utf-8?B?RXJPUElpd0srbHJLb2syMmFDV3FGclAvR3d0WnlmVjROb2dCcG5Cenh3a2lY?=
 =?utf-8?B?U0JqQm1CSW0wN1kwVUlnRUZoeUdIUTBia0hWSjlOY2kxM2Q5bFIzalhLVUJG?=
 =?utf-8?B?NGhaSC9vRWluV2J2dGYraVFyaXZQeDN1enh6RGpBNVlIYkFvR3BXK0RpL1gr?=
 =?utf-8?B?SHBKaEs4UVVYTUxLWWxvZ0J6REYvOGxSRFhEQnBDeXU0MmdvcGtaZ3MwaXpF?=
 =?utf-8?B?YnZ1L24zS0s3TTNJRzd3akw5KzJQNHl5eUl4dkxTQ0E0djIwOXFFSndoUzhS?=
 =?utf-8?B?RUg3S2NQL1VZTldpRUl1Q2swME5JT3BiRkZ5MnNuMllQaWcrc3V1SExoRFVr?=
 =?utf-8?B?RnQyT3FjK05SRUN2N2dPY0lOaERsUTIva2NwaWpVS3RqeFBWZEFUK2NlbkZU?=
 =?utf-8?B?dHRtYzZnMkhpS1hDNWxQNTRpMlJUMFQ5UzhTbkFJNm9zMUE1ZzJvZjVUZXFs?=
 =?utf-8?B?UG1IdXorU0RwVExkTjR6Z3dsVFljR3dJSUdBcHFlYUoybGMrU0ZEcDBrTGRh?=
 =?utf-8?B?b3I2eGUzbG0yT1B6VXh1QjBDMisyeHk0UmJoemR1N0F5Mkg3a1Y0VWw4TjZZ?=
 =?utf-8?B?eHNldC9JUm5GMHFieGpYdE1tMnk0dThtdFlxLzgrOWNUY2tUMjAwYVlJdGJU?=
 =?utf-8?B?Z2htS21BVk4rVjVTeTRnQ3FibDM0VFVnNTdWSXdBbzNKS284T0U1SjY2dU1h?=
 =?utf-8?B?K2cxMmNXS083OEhUTnBDRXE2cEgvSkt5dC9TWG5xRFYxNlV4TzZOVCt5VFE2?=
 =?utf-8?B?clpSRTArNWhsaC9rd1Jza0hMQUxIY1Y2S1psVncrVTE0VjdmUzVhWk9TbTdW?=
 =?utf-8?B?K3FxYWFZNUFlUEx6dWJwaWdxMVJBNVRLekJudXlTNy9IVG5aUEFyL0FPQnRH?=
 =?utf-8?B?TVE3SldFbVN2elEybUp3RWhMTzZTOTViVUZBd3FVUSt0OVZtUlRJZmlxTnBG?=
 =?utf-8?B?Yjc1ZWlRZVNrOHhDNlpvZk5CN2h5NE9vMzM5THk2eUNkZk5iakczUmJWWFBn?=
 =?utf-8?B?dEJUbDZMdEJOTlJhbTlGVUpLT1FGbXJ0YjFuVGhQQ3paTCs0Zm8wN2l2azVM?=
 =?utf-8?B?cGFna2ZmUjhLMFRxa1UwQnJKY3NwNFMwcUZKR2ZtOUFZQXMrbHppQmM2WHBO?=
 =?utf-8?B?YUFzbm1BVVFTVmVxZ0JJRTF4L2tqejBkdGlNdU4vMVcybnVkNjZndEl2MGpR?=
 =?utf-8?B?S2ZSZ3IyZFNuQm9TRkVrTEVKdHE3VkdCckdxNnRiQjlBWVNyTzBZL21XU3dC?=
 =?utf-8?B?VnVhQVp1NnhzdCs0N2ZWUHN0K1NUeDFPc0U1TVprVUtOcTBJRVVjZFNKNExk?=
 =?utf-8?B?VUhYWmlMNTlRenBCVDI1MjZDVC9NV0t2LzJhSGMvNHo0VzFxOGRqQ3FQQWNu?=
 =?utf-8?B?dXdxVEVOMzVuZVM2OFRoWEIxd0VrSmJkT1pKYUg1ampxNVlseTNOdDFZc1JQ?=
 =?utf-8?B?eEoremRYL3UxRnJrdXZSd3N1UjBUaXJIR3MrRk1wTi8vbklzTG82NlUzdlZO?=
 =?utf-8?B?dDJRKzUvbktNRlUxeWR3Z3VMcTJDbkFLU2Z2MlpwRFBXT2FaOVVHZWdZbDkz?=
 =?utf-8?B?MUxkWlBOQ09veWhnRllrODVrSWVrWU5icTliQjRoR1ZGZFpOYU9JbUQxaFFB?=
 =?utf-8?B?Vyt2a0I1RnpOSjZ6MktjQ2drV2hKNWpITE9peXpUcjE0bTlzMzNERUx6d0lS?=
 =?utf-8?B?K1QzUFhNVHpXdHdNTG40NDM4K2xrOGJUWmhWOGZYOEo0dnVHTHhNOGFISVR0?=
 =?utf-8?B?S0cvOU9rOXJ3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 274c89bf-2093-4038-a3d8-08da037d3492
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:35:51.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnEo9M0kdhy1abx5n5WVjkNhBYSciwfVzNGoGtmVQU1wxo055F2rJ1FYvGZQkfFYt28tNHP/2x7ZRuOn0rLBoyi+hSs14JKoQvXq/xEdb/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2022 2:17 AM, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
>
> Opening /proc/cpuinfo can have a big latency on hosts with many cpus,
> mostly because it is essentially doing:
>
>     for_each_online_cpu(cpu)
>      smp_call_function_single(cpu, aperfmperf_snapshot_khz, ...)
>
> smp_call_function_single() is reusing a common csd, meaning that
> each invocation needs to wait for completion of the prior one.
>
> Paul recent patches have lowered number of cpus receiving the IPI,
> but there are still cases where the latency of the above loop can
> reach 10 ms, then an extra msleep(10) is performed, for a total of 20ms.
>
> Using smp_call_function_many() allows for full parallelism,
> and latency is down to ~80 usec, on a host with 256 cpus.

This looks reasonable to me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or if you want me to pick it up, please resend the patch with a CC to 
linux-pm@vger.kernel.org.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>   arch/x86/kernel/cpu/aperfmperf.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index 22911deacb6e441ad60ddb57190ef3772afb3cf0..a305310ceb44784a0ad9be7c196061d98fa1adbc 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -67,7 +67,8 @@ static void aperfmperf_snapshot_khz(void *dummy)
>   	atomic_set_release(&s->scfpending, 0);
>   }
>   
> -static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
> +static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait,
> +				    struct cpumask *mask)
>   {
>   	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
>   	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> @@ -76,9 +77,13 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
>   	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
>   		return true;
>   
> -	if (!atomic_xchg(&s->scfpending, 1) || wait)
> -		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
> -
> +	if (!atomic_xchg(&s->scfpending, 1) || wait) {
> +		if (mask)
> +			__cpumask_set_cpu(cpu, mask);
> +		else
> +			smp_call_function_single(cpu, aperfmperf_snapshot_khz,
> +						 NULL, wait);
> +	}
>   	/* Return false if the previous iteration was too long ago. */
>   	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
>   }
> @@ -97,13 +102,14 @@ unsigned int aperfmperf_get_khz(int cpu)
>   	if (rcu_is_idle_cpu(cpu))
>   		return 0; /* Idle CPUs are completely uninteresting. */
>   
> -	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
> +	aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL);
>   	return per_cpu(samples.khz, cpu);
>   }
>   
>   void arch_freq_prepare_all(void)
>   {
>   	ktime_t now = ktime_get();
> +	cpumask_var_t mask;
>   	bool wait = false;
>   	int cpu;
>   
> @@ -113,17 +119,25 @@ void arch_freq_prepare_all(void)
>   	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
>   		return;
>   
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> +		return;
> +
> +	cpus_read_lock();
>   	for_each_online_cpu(cpu) {
>   		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
>   			continue;
>   		if (rcu_is_idle_cpu(cpu))
>   			continue; /* Idle CPUs are completely uninteresting. */
> -		if (!aperfmperf_snapshot_cpu(cpu, now, false))
> +		if (!aperfmperf_snapshot_cpu(cpu, now, false, mask))
>   			wait = true;
>   	}
>   
> -	if (wait)
> -		msleep(APERFMPERF_REFRESH_DELAY_MS);
> +	preempt_disable();
> +	smp_call_function_many(mask, aperfmperf_snapshot_khz, NULL, wait);
> +	preempt_enable();
> +	cpus_read_unlock();
> +
> +	free_cpumask_var(mask);
>   }
>   
>   unsigned int arch_freq_get_on_cpu(int cpu)
> @@ -139,7 +153,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>   	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
>   		return 0;
>   
> -	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
> +	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL))
>   		return per_cpu(samples.khz, cpu);
>   
>   	msleep(APERFMPERF_REFRESH_DELAY_MS);


