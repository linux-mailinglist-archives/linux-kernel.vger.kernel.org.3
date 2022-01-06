Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9A485EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbiAFCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:23:03 -0500
Received: from mail-dm6nam08on2062.outbound.protection.outlook.com ([40.107.102.62]:19297
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344720AbiAFCWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:22:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhKvN+icbNxeyUI73SNlSqyoHzAGLgB+qV3nnqTq+x6RArZ1GbaJrIr697YJ7V2g1AountMrRNOCoNQSiydAml0I536D+eJOhkSqhsR7f6y9FYmQVgaTVpk8TR3T9LiSIVk6JfRq4B60h2KW6Ztduo4vqXbvnbnyL2O0Oj5A9VH/+6VHXIBpzE3Mb1UHW4FzKQcPb/e5mSDU1FHp4ucjmM5c/F6HAYiaZsjAhEyINXD3SX18sHxieablyn9PlUR97qnlaQBp7YlUjKJjaAlyKA4gS/dlTCjnpRDbmg1uV7w9PehUX2C/HWvxEwoc0Bs0Mtfu27b57ReRsLMk85pqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmbmGIjTJUmRjGsrWiWguw+bksq4c153X61Q/VCGpic=;
 b=Dk/d637nCsPhcVNt61CCitF9X3aI87SmUglgKVqSoibOE2q9f+14YZUYKDpTKHhuACFfCcDW3OahY2T+zLCP+wAPcRpnbZPOtybMBGmrkzIKdsh3OwNSYQeLha6yNo/3VPTOs0t884EiqpjtqhKAVtVDsRJZvIfYOu0m3C0sYeOfYdMMqiLlef3k8MmxLrl32kyAJZ7pxceMIOfGbj1lvx+vEU4BkQFq5EBMfJyEZNBzaLO1ilNnoe5zjr5QNo1drJRJJ2Quyb++uB7FSazDGsoJHvSh5mqsYbIlyjSyUGLqsNq8SEYeeJSb/VPZjDU+hkitFgG9o7wf+jsUxIwmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmbmGIjTJUmRjGsrWiWguw+bksq4c153X61Q/VCGpic=;
 b=yOhBnaHwC6eTASWNQbNZpL0KEZ5yUZ/rl5bTv3ZrOToxthw0YHVSbuet+k9aDCifF8ByMHk5t2suWXFiMOrCKqvh8bXYNO8RcMbcUuOgjkptDCzclsiP7sL+O9qx6Lx38hT+6dMKrpfgFl9Ka/up3OoS88lNjJOUmZIZGg84hjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Thu, 6 Jan 2022 02:22:28 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 02:22:28 +0000
Date:   Thu, 6 Jan 2022 10:22:08 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 5 (cpufreq/amd-pstate)
Message-ID: <YdZSUHl2iD2bo4p0@amd.com>
References: <20220105191239.26498b30@canb.auug.org.au>
 <20e286d4-25d7-fb6e-31a1-4349c805aae3@infradead.org>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20e286d4-25d7-fb6e-31a1-4349c805aae3@infradead.org>
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d663a913-7ea0-4eff-6086-08d9d0bb62b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB308307E68FE861C31A4F2D01EC4C9@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZzJEE9L+lMqzuz9o5Ud0kA2jnFrfgDFb8W9sVYP3iqF8vZVPBbqHemfAoLh8ekn/ZIqU4jKMymeWIOu6wISZgucwQahgqe2U4CUz7V9BfVCr6OYqOyr+EpNqkmNLXsM69whpp78GwcGRGRfCxKBYUTsx5XVgXAWV1oW3vjDT13qnRjR1tD8Iia0MjQjuGGEBGhZSGzzR/Aqn5OdaeqE/wov4YKvQhJOPUrnFk1IjvCAz1D/BKKlZ7quWKuZzNxQyL6pT5IOE8ooKRtPEIHbsDxJZlSIoy/HImBN/8UmGgFzB4/kFpeufeu9YRdD9A1sePfP/9dEx+Sfnzzty7LwQB5XeYNk9Al662g1qLncfj4mhJfk7w8fmdGleHAqYq+8HRVqVYlfYVZ6G642I+wDvmHmaRLE6wVelTwIWvGv1LCMMOGu01jtQI2bKW35pHSyGCb99McscDLAN1SKndAaOnDKNcQ3s8yQXT+whO6YtwgH0cOtWi8+ZsbbpLAHfmUoxsefZzK2NBFt7A6f2/2OETIhJAmq1WMqBd3ccLYUSBjYvPU/ShnUphR7lWjoNA5X4xBbvylXRrcykrT9wcE/4shQwexZ60j9H73QdXAYfieOismOgMTY8+DQ0KAsNOB3GW147EciMPeLNvqQpSA4yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6486002)(66556008)(2906002)(38100700002)(8676002)(66476007)(4326008)(8936002)(66946007)(54906003)(6666004)(6916009)(36756003)(6506007)(53546011)(316002)(5660300002)(86362001)(2616005)(6512007)(83380400001)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?MEJxR2M0VEJLeVlsMjRXVTJEMm5mQS9WRkpOMFhmNXI4N2tpN1NEV2gwdU1a?=
 =?gb2312?B?L004MXVKbEh6bW55Qmk3QzI1b1lCc1dLa21uMDI1bGdobFJqemNpaWpKSUZt?=
 =?gb2312?B?TFFBeWRWTnc0VUI2VmsvcFZnd2FsZDgwUWFDR3I4RDFlZ2NEcGhmM1NsZ0d5?=
 =?gb2312?B?a0lMSmFFMjFqbGk5bCtwcEtWTmlVY0xyQUdhZGp4OU05WFBBZEVSRzNHclRH?=
 =?gb2312?B?NlJYdEM0MUc3Y2NGeWdvR1gvemdqdzJHVnFSZE5KWkxSdXBSN2wwd3hscnhW?=
 =?gb2312?B?S1oxTmt2ekpBbEFZL3RQVGd4K1lEdUpqZG03c2krQmwyVkRaOWlIeWVlSmF0?=
 =?gb2312?B?d1RZdFhtMVdqYTdiYWY3UHJ6ZVV5TGt0bDR5c0JwcmlvanJlR05qUWF5RU9n?=
 =?gb2312?B?d2NKdFFvY2Fnd2FnKzkveEU0eHh1ZFl4cUhyVzhVVExsZ2J3NS9LNGpWZXNh?=
 =?gb2312?B?ZGlhWjBsNjZmNHhrWVcrSzgweU9WaWJCeEpwR21nOFR2M3RjdUFuL2t2Zm1y?=
 =?gb2312?B?b0R1WGlyL3hyYzFyZXAwM0M2c1RWZ2pmenlTTGNmaTZ2YTZkeU1jbE04c3pH?=
 =?gb2312?B?WHhEUnBvOHkwK0tQUld2RHdOdGd3aElFQ2Rrbm1xc1h5cVN6KzFPc2U0YmJz?=
 =?gb2312?B?bVlEbXFScFpVOHpIejhYMm5NWEcwZkc0aUdtWEZiRFhYcmRhYjJqMWVDNUhB?=
 =?gb2312?B?LzBhZTBKNU5kOXl1MWNHWGRWMDBjdEx2bnk1TE45RHRSK3ByYWJER0NrZ252?=
 =?gb2312?B?OElsUC8xZVJXZzBpN3lZdmdzVEJpMnJSdkdNbXdITmFvWVBQZmFDbjQ0eWFq?=
 =?gb2312?B?RzZBdGwvZ29mb21QOWxSbXlkcGQ0MEN3NzJENWxGTi9Nb2NvQXA2b3dKcnZU?=
 =?gb2312?B?TzJsVStvOFFBODZ5TGdtOER1YVUvU1ExMDVvWWh6UmlUZEgzc2VBVndybXUy?=
 =?gb2312?B?UGZIS2lLMkpuVklDdXI4T3RYOC9MMGo4Q3A4c3hQcmFDb1JvaUZYL3plUExC?=
 =?gb2312?B?VEFram56VU96U2RQNUFWV0IxNS9TVS9IOVgwTi8zQ2JDQVM0NnR6RG9oR0Jw?=
 =?gb2312?B?WlFlRTUwK0NaeXVSQjFHSTRabm1lYnpmTFNvdVFMcWJ5N3ZkWXVPWFBRK3dD?=
 =?gb2312?B?NG1uR2YwNjJxZ1FabGIyeU5xZnduUU9DanlvSFlHR2F5d2M3UjVtakNLbXlx?=
 =?gb2312?B?T0krQS9HL0w0ckdCZ2R5WEhwQktIWTNZeDc4T1hWbTJrR3ZSWTRmTDJyeWU2?=
 =?gb2312?B?RVBaeTlSeVN5WmlsU3psdWI3RWVaU3JXVXBBTjdzbmRuOEo0UEJXWkQwWGo0?=
 =?gb2312?B?QkpvdTR6MFJWWU1ONFo0QW5QSDRCcCtNK2dmSWpvMmFjSGNKZS9nNXkyZ3ox?=
 =?gb2312?B?TW9mZTkzNGZJN01Wd3JoK2dFd3JkNGVEWU1pMGQ1NnY2ZDkrdkQyc2V6azI1?=
 =?gb2312?B?TGFaVmdsSG9WczVlcmRxejdPbkYwbWtXZmtJL0M3elNWNTFLU0g2bHdHQ2l3?=
 =?gb2312?B?VEZZMStVSm90cWZvSVNrbnhnUjFjaHNpTVNKSnFkM2lWRDF6eTJGQUw2UE9K?=
 =?gb2312?B?WE5rVEJIbHlLUkdjRm5QdkFYd0R5RmEyU1N6QTl6L2tmQWNYREE1SU5PL05a?=
 =?gb2312?B?NC9xSldpM29jWkhVN1QwVEVidUtBUXJJZ0szL2FpMTRqQmIxQWgzZXBZRnN4?=
 =?gb2312?B?bzV4VkJDRmlxTlJ6MEV6MWhIUEg4c0ZyOEI3TWhQZERURVVScXFaWGN3Um02?=
 =?gb2312?B?R2RDSEpKTk44ZUx2L0o3K1lEU3hjMVR2RFowMjB6bk1jc2hNUm1XUnIxd3l1?=
 =?gb2312?B?WDREYnJVb3o5dDY0WUZOQXVGdGdkODJKUTVjZkw5ejBxZjM5bWROOE9XUmN5?=
 =?gb2312?B?aDh3cTU5cUg3V1JYRTgvcEFIYmEzMVIzZndKdW95aUhFdG9LN2hlbkoyV0E1?=
 =?gb2312?B?VUkyNlVocWYzQjZhZWFRbjBoRm95MDJpNDFhTGxPbVhaVTY5SUg5RlQ3cjN6?=
 =?gb2312?B?dzljYWxjSXRrMlF2bkd4dVdhTkF3aGJnRU5NYytGeTc2UW56cENwUTFqOUFN?=
 =?gb2312?B?WTB2YmsrOWRSNllhVmJkaFFITjA0ZitKTGFSQmVHNjhLN0NraXFQTGV5QVBn?=
 =?gb2312?B?NDlMWC9IREpRRituUDlPclRaTmxnWXJiS3B1TmdvYmxGSjE2UVJoNkk3VlNE?=
 =?gb2312?Q?/qCePLU4M9bGOFWsDnK2qBE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d663a913-7ea0-4eff-6086-08d9d0bb62b2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 02:22:28.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiUdGZAT/KgvDYXPm1sJb81jfmvweuTP74BI/o4ChhUnK0Y7ZKvEssImQbewWBCxudMEU8+kwNRrmJd3YBB8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:19:14AM +0800, Randy Dunlap wrote:
> 
> 
> On 1/5/22 00:12, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20220104:
> > 
> > The pm tree lost its build failure.
> > 
> 
> on i386 and x86_64:
> # CONFIG_ACPI is not set
> 
> In file included from ../drivers/cpufreq/amd-pstate.c:40:0:
> ../include/acpi/processor.h:226:2: error: unknown type name ¡®phys_cpuid_t¡¯
>   phys_cpuid_t phys_id; /* CPU hardware ID such as APIC ID for x86 */
>   ^~~~~~~~~~~~
> ../include/acpi/processor.h:355:1: error: unknown type name ¡®phys_cpuid_t¡¯; did you mean ¡®phys_addr_t¡¯?
>  phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
>  ^~~~~~~~~~~~
>  phys_addr_t
>   CC      drivers/rtc/rtc-rv3029c2.o
> ../include/acpi/processor.h:356:1: error: unknown type name ¡®phys_cpuid_t¡¯; did you mean ¡®phys_addr_t¡¯?
>  phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
>  ^~~~~~~~~~~~
>  phys_addr_t
> ../include/acpi/processor.h:357:20: error: unknown type name ¡®phys_cpuid_t¡¯; did you mean ¡®phys_addr_t¡¯?
>  int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
>                     ^~~~~~~~~~~~
>                     phys_addr_t
> 

Thanks to report this, let me take a look.

Ray
