Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F504E395C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiCVHHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiCVHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:07:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686B4EA16;
        Tue, 22 Mar 2022 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647932753; x=1679468753;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TrO0usC1hjN+ZmysVUdjOjbXP2/tw10pyYuma1PsSvc=;
  b=er00ZKzNoRFBC9LYlXykCzarj7B2nyGxRF5e5zLPUtS3EvbUC6ZeCCWt
   vu8y5iJ7LF/d5GsUee9lhYoZok6It1w6sENMkLC8WIPh2qL2cCrAB9Jt+
   Otr93a22k5JJKfx7//02btFUzhf+R+HbYFLiHwLq0k6EWLl3qMtkbTeBF
   6ugrs6haVzBKa5HvmfGpcDqy/vFT1qtZIe4R/NBKOssjWGL0OIEWfeaZz
   mPTGrcs4vxKmSXxCRxNnlGlFRyzlNZ8Z6Zvoqffc3+BKax4UUOKtD7E32
   Bfy2bCiSR+fdHP86yOddQBdYgRGgVsaq+QmpjgOux2JHlSZ5Dv8JEV1Sc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282576432"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282576432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="515231313"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2022 00:05:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 00:05:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 22 Mar 2022 00:05:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 22 Mar 2022 00:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf2nkYTGE1ggRCzmZ+Gd8Zw7qWM1NWpK+TVGl0z7yoBtAvaFV0tG/CSuzarh0kapQGZYhI4DN0irO+nlzkTEYyN/tEV0ogvuenNfuEmUJv8RL9RApDErHl1IlMpNYvwFIq0L8bYguSAYmu3qCKZKp7ovMXAhP2S8Tp3TC3G4zOe2sDt35vVOP1eFmLnKLuC/kfhVdhwMtVHp7uXUMjKy0mmz0rgp2j3BC35gECUX9SgIs0u8qY7vUqPl5MZZROvmmslUHujCOw+CBhMxTvSPQ34we12seGL/M9AY75AP9bXicBaq8rG4rXH0oG73U+w/bNIOeD9j1liDP2/KZXU5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIUOh2Jg0OJMR5v/QdenVRybSq6mX6K8W2+VdQO0eKY=;
 b=mwMWnCzyUTWc0oXBPAIiGPe9ZlTtlVem4nTGs4gWr4xeMHF8imKNH/eql+r1hIB6fVfPfw9p5IC5c5Pv3vNaGUAdAG5T8PsGbnZ0LSzVZQ7Xiv+yt0zP0ln4tUC63kzWN0d655VexkkiO5W3L2IBVekX9AsNbd/octkkxkAkS6jxMK5KcIiYKpueTMwjDz/G1H+HBw2+8Mfo58Qot3qLVis/OrXfCEKkh1v/DemSYigjd9CFoIP1M3+IuwQ4+Hd79TRrn9Fv7iYNWpmn1ZFfSJ7M45LI3NuBm0VnAyZdxzprg7vNTcFoqqJo2/8ZjydAaSOMghSBNK7Qbj9KuCtI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY4PR1101MB2087.namprd11.prod.outlook.com (2603:10b6:910:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 07:05:45 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 07:05:45 +0000
Message-ID: <aa3ff0f4-d74c-2c84-37c0-0880cabc0dd4@intel.com>
Date:   Tue, 22 Mar 2022 00:05:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-CA
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <ravi.v.shankar@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-2-chang.seok.bae@intel.com>
 <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
 <c6a9632e-cdcb-cf05-183e-a124e9cec0e2@intel.com>
 <4331a0af-2300-ffaa-3e5c-ed15499c213b@intel.com>
 <13346402-7580-d60e-bb88-3172dd60406f@intel.com>
In-Reply-To: <13346402-7580-d60e-bb88-3172dd60406f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4473a5-bc76-496b-b016-08da0bd262d1
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2087:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB208781F68981E66B42341A97D8179@CY4PR1101MB2087.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4vh6avLxMI//lUvi4TEwL0Rkj/4r9vvw9lZJ0cEB6dPK3N0CWAZGvTvXXA9x6AO0Kt75fil6j//nah6pSkyzcyYGLE9yP6+CZwzKnweLIb7FksmS6WD9jb0Lu61Hm5f4QucHs76KMQYFLOXFGwkqJTFWMlH0HsnjjgYMifPmrdthcKNvsseI/fXimO65IrHXXgnrq3hlXGMNTW24lTZJW9d3OSsMdc9K6f3KI6aEG4kZXZcbf9jFwrgoC3TC6r5GZJhzB5plDy7VPwJVfT9mcqu9TmiHcaTk13BqZNDJ4oiY3rpIIMEUsVzg0E6TCwjjfLk5U251Gq3X/3RLCztUT0mrYCgwabOj0Ez23xCmVrSSuFmaXAopGUDRyUdL+CH4mNl43ITvwHpVdyG/6XXiTXZ/DuOGgbj32jNQXH7HYfJujBEDlcCjhoO+qPnqNA0nV2laYpCdv9CGpV29J4XDF2v6dplK0eka/yDext6kT9UVZiCOPhSUAk8H2HGyi/9bIcr599O5XHFUV2LjdNltPwUzycUYifmc3+dluB68ogJpKs1EzUSOnEWwMsb2g9qbZRHjukcXdvYowEOKbFI0xxNsYxXc7KHCOa9fBkHRQV1cRnRx4kOzIiGZiaVuZ0nBAVXQ8DTeeZd0ZdVGV9jCFvYXdrqOifIL9ot6600NgWUBJ37h5QbBDuvLyFH+zEoD0G5rFUkqmrxovbwlVIwcHBVepxtdb4wL7/fPrEizjdpIz9fTFmLeEiEeBs3wOXw91ab2wL7bUBO6Ory57wrUA8K5Ohj7UZUA1HDk+hj01NPF4vGp2txLyTuKcCotFsh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(82960400001)(31696002)(86362001)(38100700002)(966005)(6486002)(5660300002)(8676002)(66556008)(66476007)(66946007)(4326008)(2906002)(83380400001)(107886003)(2616005)(6666004)(6512007)(508600001)(26005)(186003)(6506007)(53546011)(31686004)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVpjOXZndUh6YXhrbGNxclhIL2VGQTZRL1NrRFVieWNHWURWN1RhWHN1Witz?=
 =?utf-8?B?RGVoMFJ5TGs4dDBrbS9vRWhTQjJLVlhucUhaRGNlUGNINjh4d0h5YWt5VmFx?=
 =?utf-8?B?K0l1Nkl6THg1UG8rSXBhQzhOelg5b1JOa0M5Mk92RVA0RVB4RHJuTDNwZXVK?=
 =?utf-8?B?VzU5Zk54YnppZWh3Q1lYa2tWT1lqdTc1R3E1UWZSRmttY1Rjd1ZjRUhWQklR?=
 =?utf-8?B?VzRQbHc0RnJKdGJ4ZllteHUrSGVXaml2a3NQMmV1MDZOSHlwc3RGUFpUTWli?=
 =?utf-8?B?TmxvQ21ocUdFY3gxR0E5NGtBaWtHWU0vbjI1NXpRcW9wNElaNHFmZlBwVlBQ?=
 =?utf-8?B?VnQ3MWIrMEZtOVZ1RFZvQVR0NDhiRXlFVk85MWo2cGExN3ZCOUt5VS9ZNFlq?=
 =?utf-8?B?bFZmV2k4M1dST1A0N3JycllxVGF2SEZEMDhvVWFnai9TSmJSeXIyYklGM2R6?=
 =?utf-8?B?YndpMWw3UXBSZDFVZzhSVkRUc3ByQW5PRWNkYUV0aFBtTmVMV1NjaDRQM05j?=
 =?utf-8?B?dUx1b2RabEVKSnVrZzZIamRrU052YlpuNkZEQXcwalo3NzlaQk80c0J3cy9r?=
 =?utf-8?B?aGlSMnh6bm9EWTQyTUtnSWZEMlM4dk1iVFVSSlM4MVJTWDRoeGcrUEpWalMr?=
 =?utf-8?B?V0NETk1rT3JSaXJidnZmNEZKaWNuTFNKZTE1eEM4YUdUb3lsMVV3RFFIcEMr?=
 =?utf-8?B?OEQwY1RiaURLUXhVa0xKMGFzMDBhUmlHZUhwWlE3UzNHOUJEb1hXNzB3MDJC?=
 =?utf-8?B?TnJCYUJHRmRxZ1U2dGJPbm5LZittbVRSUVZ3Tnc1VHI5NVhyRVpjOHpjTTY5?=
 =?utf-8?B?bGtvS21ZYXUwU1RFd3U0cUczZ0JNaFc2WFUvUU5UQWZZSnJUVlFTRDNJTjVH?=
 =?utf-8?B?UkRmR3pFQTI2R0k0WVVidVpSM3ZMS1hRUXAyWFkxSlB4WlZMR29ZaUVEMXVs?=
 =?utf-8?B?M21KdnNjSjZJdGt6WmRwdDZnTVlsSjJZZzFyWE9rMmhYMkxsbFVudDEzUy9H?=
 =?utf-8?B?Q25wUHR2S1lFVmZrdklSaGZvTHZSdWoxeHI3ajhSd1hsL1llTS9jU2ovdUpF?=
 =?utf-8?B?MEptMytDK09XOWZ6VmJqVFRxS3RBTEZzanlPN1lFNlJEWWFYM056d1FmN3c5?=
 =?utf-8?B?WVhPRTNwK3B0WlhUSUo4UVJzV1dOY2J0SVVVSmpjanY4ak9VUTk5REVxdFBQ?=
 =?utf-8?B?d3ZUS3A4Q3N2dVFtRk9nL1lxeTBKdkpyY1ByYVp1U3lid28raEN4b2htZE5M?=
 =?utf-8?B?N2RNNmRUbk5Ya0hqNHZuM1J1Yk5obllJbDcwVE9iMmZWbk92NGkvQTVoeTEw?=
 =?utf-8?B?dnhrR2hrd1lzeWk5RkNEbG1Hd2JCQXpwRWFIMUdjSy9Sc21CUEtyRHJIbmli?=
 =?utf-8?B?eWFQazFLVkFObldKWG5OdElkc0ZlMHN6cDFiQnIxU2pZQXpSdnYvM3d6dEdz?=
 =?utf-8?B?YWI5OXRuL3A5aUVmY2phTDNxOEFNaG8xK1l4UENiY3hFODRsdXdYTU53RXhn?=
 =?utf-8?B?WHVWTVNEVkdKYmhyTFhITmw1MWFOelR0K3JkMWVHYVcvNGZPak5hcHl0VXVT?=
 =?utf-8?B?RFZta05jOHQ0cis3UWRrRkVlcC9VK0w1KzFFNFJ5UGNEYVBYQUM4Z3lDemhv?=
 =?utf-8?B?WnQ1NDVpaTRybTgyRkNLWkMvcHpEYVpRK3EySzdSb0NEeWF2M09Nek1TZW1S?=
 =?utf-8?B?VzhBODJRRkJldHFSbjYvcGVMK25qWm11RWZ2SmluQUZmdGtRMW1xdnNJUUxn?=
 =?utf-8?B?M1hYaUREZ3UxYUZEM2ZINlBMSkl0Nk9hTVhheVQxeEZ0clpjTDU1MFJ0Qm5T?=
 =?utf-8?B?T0JlOEhtTEVIU0ZVVG1NMTFwUi93OVQ5YlJWQTVUMSthNEpueWNoRzhtRWM1?=
 =?utf-8?B?bDdzcnhOVHo3L2pTNWxlSVk5Q2tVcGllREdNci9YK1NYaWpNM2RvVEtOMTZq?=
 =?utf-8?B?YzQxR2J6NlBuRmRQZEdXeHcrdk1yN3Eva0MyN3NJWmZyMzRmTWIyS1dsbVBV?=
 =?utf-8?B?S2tDNG1LQUN3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4473a5-bc76-496b-b016-08da0bd262d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 07:05:45.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W3uvArPR8usKhir48WM3bJeK3cc12zQkXWoESe1GAtXfnO893fJmy36mzuDMG6Y1je2MLLE18tMH3rpvm3vnAM326UyjvlWHqf+wR4w/SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2087
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 1:00 PM, Chang S. Bae wrote:
> 
> BTW, now I'm suspicious of this JMP as patched at runtime with 
> fpu_state_size_dynamic():

No, this jump was supposed to be replaced with NOP by objtool but it 
didn't as fail to interpret TILERELEASE in this case.

> 
>    22:   eb 01                    jmp    0x25
>    24:   c3                       retq
>    25:   b9 01 00 00 00           mov    $0x1,%ecx
>    2a:*  0f 01 d0                 xgetbv           <-- trapping instruction
> 
> Still, the question is, if so, why it was patched on non-XFD systems. 
> Let me analyze the case a bit further with 0day folks.
> 

Looks like 0day picked an internal branch where the instruction's opcode 
was intentionally removed.

In practice, upstream code should accompany by a complete opcode table.

If it ever happens, a warning follows like this on build:
     arch/x86/kernel/fpu/core.o: warning: objtool: can't decode 
instruction at .text:0x185e

But what actually happened is barely indicated by this message alone. 
This decode failure ends up returning check() immediately [1] so the 
file is entirely skipped from the tool's process.

I came to think of some improvements for this tool:

(1) Add more messages like [2]. This may help users understand what 
happens in this build process.

(2) Move on next byte from the failed offset like [3]. Perhaps, this 
continuation may alleviate the impact. It may misinterpret some bytes 
but I think it will be re-aligned with padding bytes before the next 
function (symbol).

Include Josh Poimboeuf. Appreciate any feedback.

Thanks,
Chang

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/objtool/check.c#n3515

[2]:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c33ec67c4a9..34b60fa33fbe 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3507,27 +3507,27 @@ int check(struct objtool_file *file)
         set_func_state(&func_cfi);

         if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
-               goto out;
+               goto err;

         cfi_hash_add(&init_cfi);
         cfi_hash_add(&func_cfi);

         ret = decode_sections(file);
         if (ret < 0)
-               goto out;
+               goto err;

         warnings += ret;

         if (list_empty(&file->insn_list))
-               goto out;
+               return 0;

         if (vmlinux && !validate_dup) {
                 ret = validate_vmlinux_functions(file);
                 if (ret < 0)
-                       goto out;
+                       goto err;

                 warnings += ret;
-               goto out;
+               return 0;
         }

         if (retpoline) {
@@ -3539,37 +3539,37 @@ int check(struct objtool_file *file)

         ret = validate_functions(file);
         if (ret < 0)
-               goto out;
+               goto err;
         warnings += ret;

         ret = validate_unwind_hints(file, NULL);
         if (ret < 0)
-               goto out;
+               goto err;
         warnings += ret;

         if (!warnings) {
                 ret = validate_reachable_instructions(file);
                 if (ret < 0)
-                       goto out;
+                       goto err;
                 warnings += ret;
         }

         ret = create_static_call_sections(file);
         if (ret < 0)
-               goto out;
+               goto err;
         warnings += ret;

         if (retpoline) {
                 ret = create_retpoline_sites_sections(file);
                 if (ret < 0)
-                       goto out;
+                       goto err;
                 warnings += ret;
         }

         if (mcount) {
                 ret = create_mcount_loc_sections(file);
                 if (ret < 0)
-                       goto out;
+                       goto err;
                 warnings += ret;
         }

@@ -3580,11 +3580,14 @@ int check(struct objtool_file *file)
                 printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
         }

-out:
+       return 0;
+
+err:
         /*
          *  For now, don't fail the kernel build on fatal warnings.These
          *  errors are still fairly common due to the growing matrix of
          *  supported toolchains and their recent pace of change.
          */
+       WARN("check failed - no jump_label instructions were written.");
         return 0;
  }

[3]:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c33ec67c4a9..1f1515373ca5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -371,7 +371,7 @@ static int decode_instructions(struct objtool_file 
*file)
                     !strcmp(sec->name, ".entry.text"))
                         sec->noinstr = true;

-               for (offset = 0; offset < sec->sh.sh_size; offset += 
insn->len) {
+               for (offset = 0; offset < sec->sh.sh_size;) {
                         insn = malloc(sizeof(*insn));
                         if (!insn) {
                                 WARN("malloc failed");
@@ -389,12 +389,15 @@ static int decode_instructions(struct objtool_file 
*file)
                                                       &insn->len, 
&insn->type,
                                                       &insn->immediate,
                                                       &insn->stack_ops);
-                       if (ret)
-                               goto err;
+                       if (ret) {
+                               offset++;
+                               continue;
+                       }

                         hash_add(file->insn_hash, &insn->hash, 
sec_offset_hash(sec, insn->offset));
                         list_add_tail(&insn->list, &file->insn_list);
                         nr_insns++;
+                       offset += insn->len;
                 }

                 list_for_each_entry(func, &sec->symbol_list, list) {
@@ -416,10 +419,6 @@ static int decode_instructions(struct objtool_file 
*file)
                 printf("nr_insns: %lu\n", nr_insns);

         return 0;
-
-err:
-       free(insn);
-       return ret;
  }
