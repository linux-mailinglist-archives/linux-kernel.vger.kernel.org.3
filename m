Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57358124D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiGZLtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiGZLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:49:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E441E32DAF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658836156; x=1690372156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6zSvpDgNiqNhBSZO2GAoFZBYL8Iw1RBbfWDIKas5uDw=;
  b=VpTUGwm6944qZiUlGcNH0IJq45Ljv0uspkAeSjFJ69SOUlYVu++SFMHT
   UacaXQv2ymqKAdeJTN50KOUt0mo5j9fVFduFMQRbnLY2do11oe1y2e72q
   nOujGP0n1ggfXmjCVXljGWkcXIUcAsGUGzwfDBYvGss2RUng7z9BkF5gy
   7cUtfKpiWISankoeqF+e833ghnme2my6FdptKcoDPEx+KDsEowwmVFr4E
   OeeAfE2TwYxmzj/iYd9ZPJxfcdcWbYue4JZfgax/xXUits8kfit8PxE4t
   koUSlO5A7+bOKEWOpwYzmNFPIB1HarwaA+HIP/u0FMgIV+nmmAWt8G5Vn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285482504"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285482504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="776281614"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2022 04:49:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 04:49:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 04:49:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 04:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqhD8axR4NLjFRTtee6Vk8qEG4Qo8kRN52pjDgaq6F6U85Pvj7v2FrVfi+bLLEBiVweNljuHVeJBxLycPo9bFPLbRU4rpEdaqWBEmXLzKeLGfOoJUKJxIomCYpWgh7+EUoixEgEkGRItKrUWbtHF3A59hG//2IHTUwo1etF2WCqiX1m+U5pa2e0uz+8v8oPB9gXFJCbZHbR9s2yIXA42Vjx21U7NyeJCd8MDa7oRK2Y3LRSROyNZzfS/PvTmATASmSAiMNs/OkNan9DYYAT5Hx6xZMlhG8bvVR8ifYu0d3F2zDIz79iyFE3wGLQo7Lb5nu/Xclv0Bm2i7AeHVWsuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MCQUFmexN++HBs4CExHdOEFtRDDR9dcHcesISh4Quo=;
 b=EX7dqJEy6XavtDvONUOyfBILoT5wzYM0+puM1ka0i7qF7lZxw7v7GVLDEuhHURfVVJBBm0BC+Hc7NlpwZl1LP2FlhpuaZWk0kzsfHLN4iJNmfO9nHx7dpMeEtidny0q9LxB4K8DMdplpM1CVnBaZjuyub7TYNzS1IXLAO/IIG0HGUTNyRLC945MBqvlget/70ycBdf98UgvrDUMN2Ms7ndusIGWqHrusG7RgCYS8IbQIRBf4QmD0HS7UlU6KgnDsfgtYtsbR4vHf+fcEPMsLJ3YIdPCXcSMpJVTdwt+CpAx2/BzPzafc8Y1LQsrVUrhiL9arlPIqvAW128/oKHD8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BY5PR11MB4021.namprd11.prod.outlook.com (2603:10b6:a03:191::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 11:49:02 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 11:49:02 +0000
Message-ID: <ca3fa9d0-d231-a848-63cf-f9283bfe7b54@intel.com>
Date:   Tue, 26 Jul 2022 19:48:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] mm/slub: extend redzone check to cover all
 allocated kmalloc space
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
References: <20220725112025.22625-1-feng.tang@intel.com>
 <20220725112025.22625-2-feng.tang@intel.com>
 <1b0fa66c-f855-1c00-e024-b2b823b18678@suse.cz>
From:   Feng Tang <feng.tang@intel.com>
In-Reply-To: <1b0fa66c-f855-1c00-e024-b2b823b18678@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a5c162-7b71-4f9a-a73a-08da6efcd595
X-MS-TrafficTypeDiagnostic: BY5PR11MB4021:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f65r74UyFdIvRrzmr92rAiCJ2I4i0oJv+GWtaJiUhvUpDYXY0k448rm0VDF17Ntme6Pk49HmYCALfEa8TjrFPkh4KlWnRsqNDMOrRv8tJP1dqyLOfWpBGGfSvajqVncMXc2Kpv6+85PgAjZTZBDh/VX55Y09nksYWXtDF4wgCAZgi5OmhE/qAFVulZT2zmGbH1TpuvL7tbRUUDMysC+kQYn1P8zAqItsMYsV/oDOo3bNQPIuZCZs2O3x+dzyZ5FDqyq5ASct9gKTTfgtsAM3TVcJjj6vsnoul4OyNA+PL9R0pccYyobYLWRHioOkwhgr9hbNeBs3bcwZGEEIrueECGWSFCIccEyXills7bDkujjkk3TKLH3GuqDoM3omiDtddDKfTeFMgp0iV/cqH9j98l3JBlM0XnWIz7PXbcOnNJGVFq7QVHH3Kcmj8GycMZHEePELnSkbcV3R7KKULqxSd+NM3uopvBSgnW6nT8072KnZz4LSwRA7pg3BG+VENwrphyWUTW1mdmR335fuv2d3GKp9DgIkNDUAoon6brECC2wEc2aDjPgTitNy/OoWKYG1pg1fG9MXhjEnB6cg4vMn0SdTiXIs+OU/ujP0nRbjhQdulWGj5yl6B7dsx7s/p0fkY5BgT7TuH2UjmzT+5UWXQaPRZF/h1tOtCkBg8FEn4604Z97KceGyPWagMbmsqxsxujQdfuJpwryx8l1LHWOfZFuknkiFcN4hx1hnZKkucWxX81X/W6cAyR4ev1R3XwrVy6X6afNrgQnT385pKAIOo/PZ0Ni39wxuMBHEWoz991akCY29j9yUurEiVMg1WxWD9nzfLBLW2EQE/wDBa/zlGVx/ymotNhbrAZ1Hd3pKOlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(346002)(39860400002)(31696002)(83380400001)(86362001)(478600001)(5660300002)(6486002)(7416002)(186003)(44832011)(316002)(36756003)(110136005)(31686004)(54906003)(8936002)(2616005)(82960400001)(53546011)(26005)(921005)(6512007)(41300700001)(6506007)(2906002)(66946007)(4326008)(38100700002)(66476007)(6666004)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ZicjR4S2VSWi9uRFVIUTVyWG12RkZXQ3hHTFFzZWl6WDJsT0RYdDdUU1JC?=
 =?utf-8?B?ZXBFWGFyU1VxeG9YYXpIbm80SXEzdmM4Mk8zbFF2clMrdmVZc2hvb2FseVI1?=
 =?utf-8?B?OGtUWDNQeVhISGl1Y0hETVZ0U0hqdnF3aVd6YmxPUVp2dytUeEFGdWFnRkhk?=
 =?utf-8?B?MU5LZHcvb0hrM0Z1eUFnNU5vc2V6blp5QXhtSnN5WjZvb1NRRnRkd3dVTG03?=
 =?utf-8?B?TXNZUFdoK2FwU3VXZ0RxQWxPblJFazhYMXprSkxWdkc4TmduNXVpRnhhR2JC?=
 =?utf-8?B?M21seG8zZGhwb1FyVGs1YXpsenNiTUdtbWpQb3l5SDVrWko3L2xGc2NpZGNu?=
 =?utf-8?B?SVRPTjZvVXFwT0x4ZTFPbUNEcHhySkJNZlhJblFXRk9CZGtVK3REeUU1cE9C?=
 =?utf-8?B?Q0Rxc1hlQjZpU3BGdmJIZEtza0d5OG9JRHhobG5lUkZqMVdONDNNazFWUDVL?=
 =?utf-8?B?aWZzcmFDRkltMEdyc3EvNEYxWXhqWnNOTnNWYm13bDZzOEsyc243NlBFYzJF?=
 =?utf-8?B?K0J0U1lqWW00YlZnWGFXcTRZMGVGR3YxZU50MG50Q280eHVyMFgzdzZOZUNu?=
 =?utf-8?B?Q1RrUHFUUjRRQzZxZ2k4L05zN28xYVZGOWlUVEFUVXJEWC8xVTAzbEdqMFQ2?=
 =?utf-8?B?aHp2U3NNTm9tRng2bktUandQR0w5ZGgvTm5Ia0lpOERWVlZsbnZHWnBEYUY0?=
 =?utf-8?B?VGR6SE5nL2R6eGhPdjZRUEhMSXY4QkZ3VkJPc2RNcmZ6TTVZVENobm4yZHg3?=
 =?utf-8?B?Mk1pZ2k2RmgrYWNET3ZjUFdpYUxPWDJ1b3ZuZVlsR2FkOVlTWVEzcnN3aDk5?=
 =?utf-8?B?cVVMNUxUVGhQNG9pVE4wNllEbS9QbXdscXVTTElScTRlOGRocWlLNGpIQkN3?=
 =?utf-8?B?MnlaWFhWZXM5UytBNjFSYnV6alE4N21VakJBUzdvMjM4Y1RiSTVvWkk3RGV5?=
 =?utf-8?B?UFl3NHhhV0JJWllVc0plaVR3Nk5jVVJFR1ZROUF0aHgwTllLZ2xUZlZyaHVy?=
 =?utf-8?B?UFBlcXZ2dGhlazFMdnRYVENlMi9acEtFQjJBOGNidHRzYUJmVDZqQUtmYUhp?=
 =?utf-8?B?Ym1GbnA0V3lzSXJwb05Femo0ZHE2M1d2UVN2cU8wb3ZmdVMra0UvMTUyZ1NY?=
 =?utf-8?B?KzdqWHhPK2xsUFp4K0FBeUhteFBmYzdxNXBpbC95OEg0V1Via3RFWXhZNTFs?=
 =?utf-8?B?d3RFQVBEYjcrcW5GMzRiL1JhdW15U01DTWdNb0xaZDRWb0M4czg4WGFaTSsv?=
 =?utf-8?B?dW1RN0RUTTkxbXdGMHVwMlV5QlpvSUVmRmVHV3RXZmtGdURPcU5sWi96TjZh?=
 =?utf-8?B?L0dySTI3TEhQOWNQZWRXajJzN1hlekE1UDBoZWxwSXZmRmsvQWpQYVhKaHo2?=
 =?utf-8?B?dmtEQjljRU5rMk1idWpQY0YyUEc3WWZlOFpnNEswZUNxcjh1K2lwVVI4aGNZ?=
 =?utf-8?B?bDRuMzV5YnVJNjQwaFBjeU1odkR5NmE1Vlp6Q2RVMUZoMnBJVTh4NXoxSVp5?=
 =?utf-8?B?U3lGYklzcm16Q1hpanY0NGhMclJKM3E2TUZWVWlScmkrb0RJMmdNRzVUcS8y?=
 =?utf-8?B?MklvREhzcHN1ZFd5MElKV2FsZktpWERWUlAzc0dndnl6WHdSUjdCc1RVNE81?=
 =?utf-8?B?K1J1YldUNm12SjkxenFZMW91a3FtaE5ONUxSRlNMWTZvRGJsRDd5MzhJWGVS?=
 =?utf-8?B?UFd0dEdPSXcvdXFTT2ZZZlFQRzQ3UldsbDZTaWtQUTBqWFlpRUpzNmxuQjhw?=
 =?utf-8?B?WHozNzloRmFiK2Y4Y1RIcjNiRkpJdjdxaUt3MXNyZFRIVHdpc1h6dmhPQUtD?=
 =?utf-8?B?aG9vai9WZlIvUHdSWENGbGxpUUlnRmJyV3VRdnFOQXQxT2JlUVZvcUJpRVY5?=
 =?utf-8?B?QnhOZXhuUGFtMkxYdmJENkNieVN0end3dWJ6WkgxS1JmMkJEbnV1M0lhMDRt?=
 =?utf-8?B?YlYvZmxiY1hRTE1FRWNUYVlFT0ZKaGllUFBNcWdOd1hxR3RwRjBER2g0MWps?=
 =?utf-8?B?SVhtNjJrUE9WWStJczAzZVQ1WXJHQis4ZmJJZUQzWWpvMEx3NjduMXBXQ2Qz?=
 =?utf-8?B?NjRUbExXTDZaTTJEZ29HS1Qxbys4Z0Vicko1Z01BeTlIUFVJaFBINWVuRWxm?=
 =?utf-8?Q?lRkTQQPXQ1c5RcJ1nZ3/Qa7el?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a5c162-7b71-4f9a-a73a-08da6efcd595
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 11:49:02.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcwBzuZnf2eQCNRZ7wC861/5voXSkrG+zJVJDsL9pRxezIbLnyW/5Oan+Frh/fcf0Lf9SB1Li6Khp2c/JhQAAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4021
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/26 00:48, Vlastimil Babka wrote:
> On 7/25/22 13:20, Feng Tang wrote:
>> kmalloc will round up the request size to a fixes size (mostly power
>> of 2), so there could be a extra space than what user request, whose
>> size is the actual buffer size minus original request size.
>>
>> To better detect out of bound access or abuse of this space, add
>> redzone sannity check for it.
>>
>> And in current kernel, some kmalloc user already knows the existence
>> of the space and utilize it after calling 'ksize()' to know the real
>> size of the allocated buffer. So we skip the sanity check for objects
>> which have been called with ksize(), as treating them as legitimate
>> users.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>> Hi reviewers,
>>
>> I'm not sure if I should carve out the legitimizing ksize() check
>> and kzalloc() zeroing buffer to separate ones, and just put them
>> together as one patch. pls let me know if you think this should be
>> separated.
> 
> Hm maybe separately and spell out the implications in changelog, in case it
> ever becomes a bisect results. 

OK, will separate them.

> Zeroing only up to orig_size for __GFP_ZERO
> can potentially break some code(but arguably one that was already broken).
> I wonder if there's a user of ksize() that allocates with __GFP_ZERO and
> then expects the whole be zeroed out :/

I don't think it's valid expectation either. I grepped ksize() and
there are only a few users of ksize(). For ksize() + __GFPZERO case,
I did a quick kernel boot test and haven't caught any real cases.

>> Thanks,
>> Feng
>>
>>   mm/slab.c |  8 ++++----
>>   mm/slab.h |  9 +++++++--
>>   mm/slub.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>>   3 files changed, 57 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index f8cd00f4ba13..9501510c3940 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -3236,7 +3236,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>>   	init = slab_want_init_on_alloc(flags, cachep);
>>   
>>   out_hooks:
>> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
>> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init, 0);
>>   	return ptr;
>>   }
>>   
>> @@ -3299,7 +3299,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>>   	init = slab_want_init_on_alloc(flags, cachep);
>>   
>>   out:
>> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
>> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
>>   	return objp;
>>   }
>>   
>> @@ -3546,13 +3546,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>   	 * Done outside of the IRQ disabled section.
>>   	 */
>>   	slab_post_alloc_hook(s, objcg, flags, size, p,
>> -				slab_want_init_on_alloc(flags, s));
>> +				slab_want_init_on_alloc(flags, s), 0);
>>   	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>>   	return size;
>>   error:
>>   	local_irq_enable();
>>   	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
>> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
>> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>>   	__kmem_cache_free_bulk(s, i, p);
>>   	return 0;
>>   }
>> diff --git a/mm/slab.h b/mm/slab.h
>> index db9fb5c8dae7..806822c78d24 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -733,12 +733,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>>   
>>   static inline void slab_post_alloc_hook(struct kmem_cache *s,
>>   					struct obj_cgroup *objcg, gfp_t flags,
>> -					size_t size, void **p, bool init)
>> +					size_t size, void **p, bool init,
>> +					unsigned int orig_size)
>>   {
>>   	size_t i;
>>   
>>   	flags &= gfp_allowed_mask;
>>   
>> +	/* If original request size(kmalloc) is not set, use object_size */
>> +	if (!orig_size)
>> +		orig_size = s->object_size;
>> +
>>   	/*
>>   	 * As memory initialization might be integrated into KASAN,
>>   	 * kasan_slab_alloc and initialization memset must be
>> @@ -749,7 +754,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>>   	for (i = 0; i < size; i++) {
>>   		p[i] = kasan_slab_alloc(s, p[i], flags, init);
>>   		if (p[i] && init && !kasan_has_integrated_init())
>> -			memset(p[i], 0, s->object_size);
>> +			memset(p[i], 0, orig_size);
>>   		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>>   					 s->flags, flags);
>>   	}
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 9763a38bc4f0..8f3314f0725d 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -193,8 +193,8 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
>>   
>>   static inline bool slub_debug_orig_size(struct kmem_cache *s)
>>   {
>> -	return (s->flags & SLAB_KMALLOC &&
>> -			kmem_cache_debug_flags(s, SLAB_STORE_USER));
>> +	return (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
>> +			(s->flags & SLAB_KMALLOC));
> 
> Hm now I see why patch 1/2 is done the way it is. But I think it's
> legitimate to keep only storing orig_size with SLAB_STORE_USER. If only
> SLAB_RED_ZONE is specified, then no orig_size is stored and the redzone
> check will be as imprecise (assuming full kmalloc cache size) as it was before.

OK, will change.

Thanks,
Feng

>>   }
>>   
>>   void *fixup_red_left(struct kmem_cache *s, void *p)
>> @@ -838,6 +838,11 @@ static inline void set_orig_size(struct kmem_cache *s,
>>   	*(unsigned int *)p = orig_size;
>>   }
>>   
>> +static inline void skip_orig_size_check(struct kmem_cache *s, const void *object)
>> +{
>> +	set_orig_size(s, (void *)object, s->object_size);
>> +}
>> +
>>   static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>>   {
>>   	void *p = kasan_reset_tag(object);
>> @@ -970,13 +975,28 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>>   static void init_object(struct kmem_cache *s, void *object, u8 val)
>>   {
>>   	u8 *p = kasan_reset_tag(object);
>> +	unsigned int orig_size = s->object_size;
>>   
>>   	if (s->flags & SLAB_RED_ZONE)
>>   		memset(p - s->red_left_pad, val, s->red_left_pad);
>>   
>> +	if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
>> +		unsigned int zone_start;
>> +
>> +		orig_size = get_orig_size(s, object);
>> +		zone_start = orig_size;
>> +
>> +		if (!freeptr_outside_object(s))
>> +			zone_start = max_t(unsigned int, orig_size, s->offset + sizeof(void *));
>> +
>> +		/* Redzone the allocated by kmalloc but unused space */
>> +		if (zone_start < s->object_size)
>> +			memset(p + zone_start, val, s->object_size - zone_start);
>> +	}
>> +
>>   	if (s->flags & __OBJECT_POISON) {
>> -		memset(p, POISON_FREE, s->object_size - 1);
>> -		p[s->object_size - 1] = POISON_END;
>> +		memset(p, POISON_FREE, orig_size - 1);
>> +		p[orig_size - 1] = POISON_END;
>>   	}
>>   
>>   	if (s->flags & SLAB_RED_ZONE)
>> @@ -1122,6 +1142,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>>   {
>>   	u8 *p = object;
>>   	u8 *endobject = object + s->object_size;
>> +	unsigned int orig_size;
>>   
>>   	if (s->flags & SLAB_RED_ZONE) {
>>   		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
>> @@ -1139,6 +1160,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>>   		}
>>   	}
>>   
>> +	if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
>> +		orig_size = get_orig_size(s, object);
>> +
>> +		if (!freeptr_outside_object(s))
>> +			orig_size = max_t(unsigned int, orig_size,
>> +						s->offset + sizeof(void *));
>> +		if (s->object_size > orig_size  &&
>> +			!check_bytes_and_report(s, slab, object,
>> +				"kmalloc unused part", p + orig_size,
>> +				val, s->object_size - orig_size)) {
>> +			return 0;
>> +		}
>> +	}
>> +
>>   	if (s->flags & SLAB_POISON) {
>>   		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
>>   			(!check_bytes_and_report(s, slab, p, "Poison", p,
>> @@ -3287,7 +3322,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>>   	init = slab_want_init_on_alloc(gfpflags, s);
>>   
>>   out:
>> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
>> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>>   
>>   	return object;
>>   }
>> @@ -3802,11 +3837,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>   	 * Done outside of the IRQ disabled fastpath loop.
>>   	 */
>>   	slab_post_alloc_hook(s, objcg, flags, size, p,
>> -				slab_want_init_on_alloc(flags, s));
>> +				slab_want_init_on_alloc(flags, s), 0);
>>   	return i;
>>   error:
>>   	slub_put_cpu_ptr(s->cpu_slab);
>> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
>> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>>   	__kmem_cache_free_bulk(s, i, p);
>>   	return 0;
>>   }
>> @@ -4611,6 +4646,10 @@ size_t __ksize(const void *object)
>>   	if (unlikely(!folio_test_slab(folio)))
>>   		return folio_size(folio);
>>   
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
>> +#endif
>> +
>>   	return slab_ksize(folio_slab(folio)->slab_cache);
>>   }
>>   EXPORT_SYMBOL(__ksize);
> 
