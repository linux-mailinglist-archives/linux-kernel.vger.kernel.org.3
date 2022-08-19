Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA041599977
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiHSKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiHSKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:03:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614ACDE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660903392; x=1692439392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MUsXbitOkHFffX+iTgH4P7AwWFgozD3f57Wa4Pc7oZE=;
  b=RoU47Bont5yNY2pWM5Ev7iJBIY/b8c9OmNh+91FDcC6B1pPisHYqqzZr
   0v/qf3v0GjFW+04Fcm1sGTZPL3+LOtW8v+3kAlNzAJqEsEBIQTDwR4vtg
   EBL6+G54CVgJaaUs3Ed/pdIfaF6SRtvAqNmsW6X/9QFu8GKcH5PqeuRz+
   036OIIKyeBDgmePTpHPnZwTNXjcuUrML2dSCNcju0gSDquYZt4KYX5Ile
   j+GLpk75HgME5IL3gvXv0Ea9MSZY+4PrDBUOq/6fHnhp7YrDC/6omsA+C
   PTkl00nP/L8sdbQ2CkWzbec3C295nzY1jRk4T4OEbTUtaTGPnz3KvW/i7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="273374240"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="273374240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 03:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="637223815"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2022 03:03:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 03:03:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 03:03:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 03:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFovxFc6HKsYPUcgrevzpfjZL70Xq6o6xTNB7XOJGRA1sfdAmfyA4rkCj8z4T/bNVWDh2b4vzRQygt8qFpXVurdqiGHV23yndUhYSLiFEnGcwTwrzO33DSowA2CvqczhKzGQfHBzaV//2e4nFYtksXaqzqbrxLVj+Icenz6ZF+pUtvjk34g5MI5r8/WQmF22Jy9jMV3aNcNFSgXUKyZlBfa2IRupw/ek5GPgBDEdf3f4dU8SeXvjUGnYyC78XlKqGSSnbzcOC0oNqTFocoet4UyJwN0btLfkJxJJjPNdk11CzLDeRYTTUiBon9kg4n5GQYO+KGxVBxeW2zz8yFQavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7iSezm41YiESKekt8FU2hGfZxGLpwsW1MBpgZhWzIU=;
 b=MtdQO64y1YWBeXcYuuY5moBAkpYVSUV95bkuK5LzJ4dcjo7pzwwYrBu5KT4PsGBqm0pwyTGd1i1AJ3jjoxeT4lmUITwg6HZA2lafxmMzbOzR9c2IJExqxvPKcDo7YDaO24ELWtSPJL1An2EQk0Wslehq5QNkOZjMIQF+UEhX5QyLQAKhlN7MqSYJbXhVfAKhmGtBrqdOBTWdl2brihWZmMeQEOzIJg3kowIDyLd8EmiaH98+L9MdJ9otRmizMkIgsJ/esNT0R7xwWap5/8gDeIA0yoGCqVEXtFmsoStiaSByzEi0wAz6JUB9HHqZp49gEy1cIlOz4iC9qfRWPcmzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB3692.namprd11.prod.outlook.com (2603:10b6:5:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 19 Aug
 2022 10:03:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 10:03:08 +0000
Message-ID: <a5ea923d-4fe2-d7bb-ca26-2446d6858837@intel.com>
Date:   Fri, 19 Aug 2022 18:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <CAC=cRTN=vbrgOsH7PNNMV+Coyabp=H_XF99MUL00kfET=K-32w@mail.gmail.com>
 <578084e8-bdc3-6e4e-f390-4202a8bc7c1d@huawei.com>
 <Yv8+bxiZ8+Rw+wu3@ziqianlu-Dell-Optiplex7000>
 <31718e40-51e9-c14d-f7f5-526ba26d0db8@huawei.com>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <31718e40-51e9-c14d-f7f5-526ba26d0db8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234cce58-a3e0-412a-cd83-08da81ca0466
X-MS-TrafficTypeDiagnostic: DM6PR11MB3692:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QNAWV4bLJLccjlsc1Tf+r/2kFSxQawC8Be6EsFYf+i5WSGWm1Mg0h45Vgoqlf3wkPUGpTlOOOKKwAq3mRN8N7jJOUtwOysUwrKAW4gd47MfckwwriD5QEngbGqRxqXcvzkFNICzBQfmG1VjYxl5s3QpYb+essGxu+lAQ64kh4rB8oYA47JZGE0XnEB2xzCq67E7lqJNWU2zQNJSn1bAdE29QrgO6BFrsMfwQPuyRXhwSwOGAIqeTaUrFovc/in2DlpocXvfkNaOsuvJipv28OV1eG3MiCz2EMwhih0qyLoVLjtMa7AaD0zu/My9rFSh5C2mDtu5aJJZSJ/pzr5SfhGkQJagYIMMlnOYvipTvh0yRshz3lRWoZA/uOTwqorI+QZLwJUjfN/LAQCpOHBPyjX3w39nlRWDVZ/79IrvMTOfxpFAvRpe6rIMFw64w813W4QBha++wwJjXaY6rrcyxhgLnE4rP+M3OFY6XeBkEBcngS5mzyRXMUSeRsETt+EViQMLWk3bM5mSQ34QbxuHOQkOn8Y4jgo3aB10iKXaW+G+IRNBz+3/Dd3/DGuqkkU8wSdhkqxsr5Haw/AGJ10Lk6pq19kiY1Aos78bJcIbhQvMbx64veuwBfRKvK787rvalzhOk25a6AzwO+SGtnVW5u3b2egaDwbNcZArJXSVXFCc8SpfoxQC7oWo/jUohQtbikNVdVJ1+wQshIe8V6ipWb0El/wl/OgmEJnD9d2Xcve/i8uhakduVKcJy3mMAU2p+aQ/UryViFPF7HgV16J+yj2hqTYtaTVm2ycVER0TGAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(5660300002)(6486002)(36756003)(41300700001)(6666004)(44832011)(4326008)(66946007)(66476007)(8676002)(316002)(31686004)(2616005)(26005)(54906003)(53546011)(6512007)(6506007)(66556008)(8936002)(110136005)(478600001)(31696002)(82960400001)(38100700002)(107886003)(186003)(86362001)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmlma20rTVdxUVpDclk2Z1l5Wkh1bnRzNWgrNk1CRkxPSm5YdS9jWlJIMlVl?=
 =?utf-8?B?bHFMU0l3SE50N0R2V0tRckNRQkZMMnZRaFI5Yk5UUDJiV0lST0MxeExTWW41?=
 =?utf-8?B?NndTdzRvWWtUMy9OcGJCL1Z1d3M3Z25MczVETW1HTjFCOEc5RWg0RXdpSHdx?=
 =?utf-8?B?Q0R5QVlwbjZKYTVrbkluYi9MSG9XQnFFbVl6OFBBSTl6UCt5UWNxWHE1U05a?=
 =?utf-8?B?OE5haGlrcFdUSVhXR3pPdGxpTDlzOEtxL0tzRWhiOHkyL21jTGRwNUQ1NDBy?=
 =?utf-8?B?aFNGS0F5SlBYUWMvckgyNUFVMEMxTkIwVStCL3RRZzBIM3l4TnJzTVpjcGhv?=
 =?utf-8?B?TTlYUzN4ZTNrWHNKMk5VRDNVeGl2cHhmNW5WN3RsNC91RGV2WnBCOFk5MzFX?=
 =?utf-8?B?UjVBMnkzdkUweE9NR1NRemlacHVjeGJ3MVhXZUh4VGJ3UFVKMDIzUXBFdkw5?=
 =?utf-8?B?OTBEcmtEYmx4UVlWamhHZDFaOGN4c1RSK09STHgxZk9vMTBLZWxTR1ExVVBi?=
 =?utf-8?B?d1NWMzNJYUc3cjdNMitsRFNhN3p6SXN1cDZ1dHVsblZXdm1ubllQMDNFVmJV?=
 =?utf-8?B?enh2WGlhWWxRaWFyT2ZWS2R0cUp3V3YwcDBkdFVVZHNrckFYNG5yQ3dVN1FY?=
 =?utf-8?B?cjh3bjJmR0d5bGYveGl3MG1Rb1p3Z3d2b2NVRTFqUEp5OVNhc1laRmpyWmFj?=
 =?utf-8?B?WWZ3Y2NkaVFVc0hTNEcrM0ZvQk9JVWNoVWVPQkcxM2J0R3BHMjBiT3FWeTFh?=
 =?utf-8?B?UHVwRzY3R3NjRUVwMnVhSTVIL1NIZUZ6bWJKVUk2alNvVzhTOElPYkp3VUxO?=
 =?utf-8?B?YzAybzA1aU9EdTB2Ukxnd1MvTTdxdzFEc05nK1I0d1FzVVNsZTdhQ21IcFFZ?=
 =?utf-8?B?V09GS1k4S2ZvdHJZdk5sZ0xwSHFmMGkybVRLa0hFVjJseVFobDZ1TVBBeTJS?=
 =?utf-8?B?eEUwbGQ1TEM2WXJObXNFQk1kSk1wcy8raUd4VUVIQ3l0L1ZFVGpvVTRwR0Y5?=
 =?utf-8?B?OXIrVGlrZDErcTg5Y3RWOTAxU0czdHkyOGRKQy8zOU9kRXE2RnNEQW5IK1U1?=
 =?utf-8?B?MjNnd2hsUEU3dWdER2thN295eUhVRHlkaGVYSTZDaDh2T3FhMVVNU0Z3R3J2?=
 =?utf-8?B?TjZtU0FaajgxVWtOT3ptMjk0ZnFDK1lQTzFLRFVGVm5VcVJQYjhEWGdzeUdM?=
 =?utf-8?B?aEQvU0F3K0pqUFhtbHB3czZUeE91VnIxbEtub0trU2ZsTUlqRm1kdnU1YVBr?=
 =?utf-8?B?SGZtdWlYTHdSNGxEUko2dnE1M3ZPQlBpbUxhQ0pKQ0hHR3JwMUV5bk9jVU9V?=
 =?utf-8?B?Tk02V0FRS2svUDAyczkzbVdpc0Z4RGVLVGdiditJcmxPV3FKMzhUWnRDVkNk?=
 =?utf-8?B?NkZnYkZMS1lCSThYV1FrcHBrOXM3MHRwYU1wTEk1YUR3dWU2YW95ZmZYVUZx?=
 =?utf-8?B?QnpOallMUVN3dkgwZzB2VklzaXVxVlJ4MWlWazloNjcxaU9qK2tsN3Q5dU4w?=
 =?utf-8?B?RHZmUUQ1QUYrQlRUTlNJYnN2ZlJXeGxYeVorK0pjMFRrNW1jOGJvanh5VmpC?=
 =?utf-8?B?dDJQQ2NtSHBoZ0xSclRYZEFrOGlsS3RGUkxNV1gyN3R6K1B2YzRnZkRHYmxz?=
 =?utf-8?B?ZDhRWE4vREtoUlgxYzIxREMxbFJXeG8yS3paRE1wWW5rYksvcUVzZC85UU5t?=
 =?utf-8?B?M0c5WE9BR29xMmhlckttK0VrcTZVbTZPcm5JRzRZaGgxVzdiUUlDNHpKb1Iz?=
 =?utf-8?B?Y0dyMCs0V0pFKzRnUnoySE9IUTBQdUVFS3VBYy93SiszVkk3L1Z5a1p2L0Yw?=
 =?utf-8?B?TWxuU2RHQk9McGFrNytIQ1doU1hkSzB2YmhJdTFRNGZVbit5NGdSMVhRRW91?=
 =?utf-8?B?dmFwRmxYdHJkZ240NlhmZzhnSUdLUWl6RnBtUXR4NUUyUTgxT25UY1JpZ3pC?=
 =?utf-8?B?WG5sZFE5L3lNTmwwaTlITGwzWDU3Mlpsc0dTZ1h1R2ZhWUFlUzh6NzJ0emxD?=
 =?utf-8?B?cVZEZDc1R2U1dnJvbE9nRnRad3BYY2haeitYay9rWGo1WjVvMjhtZGVETjVE?=
 =?utf-8?B?VlI2bUpEaVYrbnNQWnozRmN3bFM5L3RhQ0V3eDZSNjNuUzI1Mjk2VU5BeVRt?=
 =?utf-8?Q?JKY8D//JVE6Q+gj96S1jMVwog?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 234cce58-a3e0-412a-cd83-08da81ca0466
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 10:03:08.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jjw77ftHqwMavoHoW1cFcEjBetP2L4GaO6rljat3r38D5izZ9LDFZMtuS6x4gjLjv0mjtXUFyCPWGabOBKZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3692
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 5:53 PM, Liu Shixin wrote:
> 
> 
> On 2022/8/19 15:40, Aaron Lu wrote:
>> On Tue, Aug 16, 2022 at 05:24:07PM +0800, Kefeng Wang wrote:
>>> On 2022/8/16 16:48, huang ying wrote:
>>>> On Tue, Aug 16, 2022 at 4:38 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>> From: Liu Shixin <liushixin2@huawei.com>
>>>>>
>>>>> The page on pcplist could be used, but not counted into memory free or
>>>>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>>>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>>>> significant decrease in the display of free memory, with a large number
>>>>> of cpus and nodes, the number of pages in the percpu list can be very
>>>>> large, so it is better to let user to know the pcp count.
>>>> Can you show some data?
>>> 80M+ with 72cpus/2node
>>>
>> 80M+ for a 2 node system doesn't sound like a significant number.
>>
>>>> Another choice is to count PCP free pages in MemFree.  Is that OK for
>>>> your use case too?
>>> Yes, the user will make policy according to MemFree, we think count PCP free
>>> pages
>>>
>>> in MemFree is better, but don't know whether it is right way.
>>>
>> Is there a real problem where user makes a sub-optimal policy due to the
>> not accounted 80M+ free memory?
> I need to explain that 80M+ is the increased after patch d8a759b57035. Actually in my test,
> the pcplist is about 114M after system startup, and in high load scenarios, the pcplist memory
> can reach 300M+.
> The downstream has sensed the memory change after the kernel is updated, which has an
> actual impact on them. That's why I sent this patch to ask if should count this
> part of memory.
> 
>> Counting PCP pages as free seems natural, since they are indeed free
>> pages. One concern is, there might be much more calls of
>> __mod_zone_freepage_state() if you do free page counting for PCP pages,
>> not sure if that would hurt performance. Also, you will need to
>> differentiate in __free_one_page() whether counting for free pages are
>> still needed since some pages are freed through PCP(and thus already
>> counted) while some are not.
> I prefer to add this part of memory into free only when calculating MemFree and
> MemAvailable, without modifying other statistics to avoid directly hurt performance
> or cause other performance problems. How about this way?
>

That sounds workable to me.

Thanks,
Aaron

>> BTW, since commit b92ca18e8ca59("mm/page_alloc: disassociate the pcp->high
>> from pcp->batch"), pcp size is no longer associated with batch size. Is
>> it that you are testing on an older kernel?
> I met the problem on stable-5.10. I think this patch can't fix the problem I met. Futher,
> this series of patch make pcp->high to be greater. So the problem becomes even more
> acute in mainline.
> 
> Thanks,
>>
>> Thanks,
>> Aaron
>>
>>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>>   drivers/base/node.c | 14 +++++++++++++-
>>>>>   fs/proc/meminfo.c   |  9 +++++++++
>>>>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>>> index eb0f43784c2b..846864e45db6 100644
>>>>> --- a/drivers/base/node.c
>>>>> +++ b/drivers/base/node.c
>>>>> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>>          struct sysinfo i;
>>>>>          unsigned long sreclaimable, sunreclaimable;
>>>>>          unsigned long swapcached = 0;
>>>>> +       unsigned long free_pcp = 0;
>>>>> +       struct zone *zone;
>>>>> +       int cpu;
>>>>>
>>>>>          si_meminfo_node(&i, nid);
>>>>>          sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>>>>> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>>   #ifdef CONFIG_SWAP
>>>>>          swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>>>>>   #endif
>>>>> +       for_each_populated_zone(zone) {
>>>>> +               if (zone_to_nid(zone) != nid)
>>>>> +                       continue;
>>>>> +               for_each_online_cpu(cpu)
>>>>> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>>>> +       }
>>>>> +
>>>>>          len = sysfs_emit_at(buf, len,
>>>>>                              "Node %d MemTotal:       %8lu kB\n"
>>>>>                              "Node %d MemFree:        %8lu kB\n"
>>>>> +                           "Node %d PcpFree:        %8lu kB\n"
>>>>>                              "Node %d MemUsed:        %8lu kB\n"
>>>>>                              "Node %d SwapCached:     %8lu kB\n"
>>>>>                              "Node %d Active:         %8lu kB\n"
>>>>> @@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>>>>>                              "Node %d Mlocked:        %8lu kB\n",
>>>>>                              nid, K(i.totalram),
>>>>>                              nid, K(i.freeram),
>>>>> -                           nid, K(i.totalram - i.freeram),
>>>>> +                           nid, K(free_pcp),
>>>>> +                           nid, K(i.totalram - i.freeram - free_pcp),
>>>>>                              nid, K(swapcached),
>>>>>                              nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
>>>>>                                     node_page_state(pgdat, NR_ACTIVE_FILE)),
>>>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>>>> index 6e89f0e2fd20..672c784dfc8a 100644
>>>>> --- a/fs/proc/meminfo.c
>>>>> +++ b/fs/proc/meminfo.c
>>>>> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>>          unsigned long pages[NR_LRU_LISTS];
>>>>>          unsigned long sreclaimable, sunreclaim;
>>>>>          int lru;
>>>>> +       unsigned long free_pcp = 0;
>>>>> +       struct zone *zone;
>>>>> +       int cpu;
>>>>>
>>>>>          si_meminfo(&i);
>>>>>          si_swapinfo(&i);
>>>>> @@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>>          sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
>>>>>          sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
>>>>>
>>>>> +       for_each_populated_zone(zone) {
>>>>> +               for_each_online_cpu(cpu)
>>>>> +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
>>>>> +       }
>>>>> +
>>>>>          show_val_kb(m, "MemTotal:       ", i.totalram);
>>>>>          show_val_kb(m, "MemFree:        ", i.freeram);
>>>>> +       show_val_kb(m, "PcpFree:        ", free_pcp);
>>>>>          show_val_kb(m, "MemAvailable:   ", available);
>>>>>          show_val_kb(m, "Buffers:        ", i.bufferram);
>>>>>          show_val_kb(m, "Cached:         ", cached);
>>>>> --
>>>>> 2.35.3
>>>>>
>>>>>
>>>> .
>> .
>>
> 
