Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADC5ADCBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiIFBBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIFBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:01:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CFC2F641
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662426073; x=1693962073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s2oyAqe26YzOVeBxmeL56ZzJ/mIKbbZ9rXzAkjzC3QA=;
  b=YpY8+n7JaKzMT+p7mz+TwXsWOazuMwKBVyWbgiTlrc8xTYLjF4gaj9pU
   cPz3nw/RqGgs1PJiyW9HgJ2Ml3refWZe7gAltSLsdcIabMTNgUR98Oj3/
   S7LgBSQE5qOSQotLwhfmYVZaXpTPSUSz7Uyv+srV7s7rwpgR0/CX4EbK5
   gxdhv5KsGnwjZ038NuD1VfhqzM8xOKhn8Y4CdRAZacSQ4vuLSHdbhRlwC
   BqrWa0a20cMrv3IQv0TdWGGbJm4MqLvRRkd0GKoAusC+gZKbW10CsUwqy
   WIacyjoSOvEf4r5BZJ48NFz9OCr8KecDTPplBVMPvirPbqkcxsV4+/HPD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="279484261"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="279484261"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="859083927"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 05 Sep 2022 18:01:12 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 18:01:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 18:01:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 18:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um5EYummhStDyp69NLY2Z/G3ksKpY6ygVLbOvmoc8LYY+M4VixJ1bra5pUQ5iEkif+OekXK7n0PEoBh/hRIAqHIpkj3PnSQzeGICAiOYVK3w6Y851OnokGeEc5/p4j0KgfI7j38nnDSFRkpY/fHt5EQ3d6sJ+qYXymzMUupRJrSAhlaLMewJxHffItU6gZfcKRqpUAdRhH2kzXBqFwremjS2O+w6AMdKoT8iv8nRQJRcEXfCmThQw3blxAufJWChY46S9/l+STe//IY43Kx1H6P/RNH/sH8UWe2aOoLANz/muRyoG+MDqXUk/mxSm9+2H+SBtmZXnRbnAmWAQodUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmjunw2ug/kmAWoeIcBYfrOuk0zjvAkwRP0ijmkJsQ0=;
 b=Nu5+0sOvXKTkUXor0zKHCxKZUPLk+hU7e7vRX8wp7C+/WQHBCyD80hWbquSBZh5mbvJZa74CcLNRhBjCmiS6j6HYyT4UoqRe9XPPfXxi9VkOVuRmX8pu+kdHn1AIcgu+cuZEw1jO5qnk7aUfy5ND939WbUpDfTFESO0bXglrukHjKgL3zWdIFCvFtZXdQnbGN8IfR5oyipUH8BvhlY1n8yPjqJER0jH+rlA4IKS5t6QfHY9GC99m3j/Pc114R4zreWxNx86D6X4RIiOaYIMUnCmYd4kle73AD34U0TFbvhC0EdLx70EinOOtvLmabtBs8nByU3uSH2wdaof7+tn5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BN6PR11MB1810.namprd11.prod.outlook.com (2603:10b6:404:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 01:01:10 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 01:01:09 +0000
Message-ID: <8ab04a74-3635-e902-6d28-df24b5753acc@intel.com>
Date:   Tue, 6 Sep 2022 09:01:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH] mm: Check writable zero page in page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
 <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
 <CA+CK2bCAC4uQr_nrJM=mbP8DSpR7Vz=OGF9q7wufU_i4Wk3GBw@mail.gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <CA+CK2bCAC4uQr_nrJM=mbP8DSpR7Vz=OGF9q7wufU_i4Wk3GBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc60b530-1586-4aba-c405-08da8fa34920
X-MS-TrafficTypeDiagnostic: BN6PR11MB1810:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lufhq6d+WvqxkLR196iiAqUnYivD7Eu5cgLD1kPC9RjvrhVNuH2SNVSW3mXZ2OHmYKfhXsKhx/zTzIQuQe/1DJObXin2fNdx2WkuHHy3asg00dirWi8UN5epKtfVpZKyWuqMsnHC2EIW2g2LeioBs28+10O/p5RPCoZch5/PY/g5HvGc5PSJiY1YERd6mMShu8xoxYluBnzjHBQHNVlzWfKOVNHTpXjXccuaqDA0DGm6uUZGJEZSRsO167sBLlB4Z2ATENBYpcaB/VjW20x0n5aYEjWhEnLcs4Js2XofQZxAUQKAEqpg6u0602ih4hWpfFpFUaxA266qilm/LPUqs0pr15KEozEscbYo8hJaaHbtTd1HBAGClcSQQWrzrsayf47eym+rVLLkOTZKB8zCoK4e6Ic1Ph9mi1dMenkY+kxH6tjAa+y+/8dQZh/9iqoa6MyajrXeLdU33EHOiy9yTWyQ2Uk8g2H+IzmgElzOjjebbrWaFmOs/Yn7jITBqZJhplBxQEPLx2d5B+chwkSy0+2ttVfCaa3k3E17g5589cpU0THoL/6BcQmfUQnZicZuaUzz2aoBy8dP1scx1RW/LPAyW3wSqmGMomgUeoDvztwHKfbSInycLpN9QBKUC/LejnrTpBMBa2FZKsiA6nDw45KfjZxAkNsqvCQoKzDPaTUNpXR22NklTHjt3bsexXIWuaiCUeTLsVURAOq2z0YR625nkCGu2SkcPm5/DuNpxL1iwuvDrTImyibBPEGFdBoTOUT23a6CmAQL79m8rTAjpaNxQJJkwyTWO2p3tS0ZNhFbtJML35Ae9KXYenF1olIJWmZLhDNQ/RYBhLhjJck5PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(54906003)(6916009)(6486002)(316002)(966005)(66946007)(66556008)(41300700001)(6666004)(8936002)(5660300002)(66476007)(478600001)(8676002)(186003)(6506007)(53546011)(26005)(2906002)(36756003)(6512007)(2616005)(82960400001)(4326008)(86362001)(31696002)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hTQTdnL3plaXQvR0kwcDUwY3JwOTNGd3c3TFhjNVRNQ0JZOWFhR3dvRjMy?=
 =?utf-8?B?WkRucHBmTmdLNVQ3a01IUFk2WW5qbGFRUmtGQmd4dmI0V1lXRFFpZm02cEc3?=
 =?utf-8?B?K2VKZTdrRmlRdGw5MVdmajlGWGhKOWtDb3JndDdlTCs0bFlZb09tUTMxY3hZ?=
 =?utf-8?B?MmpOd1JrbVFvSmlHdVdyaXRMN09OeWp4cUIzZkdPZEFYNUcvY2U2dkhFRkJh?=
 =?utf-8?B?anVKazhrajdibC9NM09EUlhFM1Q2cGRsMzV1V1J2RUNYRHdwbC9FUDkxM0xi?=
 =?utf-8?B?cE1QNEQycVQ4V3BobUR1TFdYWWYrc3hFZzA5ZEZoZGRCV2w3N0liaTRmV0o1?=
 =?utf-8?B?RGhnb2VuRWVpbnc1USt3Z29udXlnbHNJcVBGaHd4dVhyS3pacUxMeU5SMnpk?=
 =?utf-8?B?cGMyVmRjZUw0UmVEZzcrSG5PS0xZN0UyaHd0QnBOKzh3ekszKy8xOGwxb3NG?=
 =?utf-8?B?SnRwT2VaS2FsdTFjeFhYQWJWWk45VURRckF1aWJuY2RkN3JpVm5ING9aT0pu?=
 =?utf-8?B?RzZhcm1JNzFEQWExMHkrdzF6Ynk2Tlc1bC9yS2tCbTNqazJPS0c0VmI1a2Mw?=
 =?utf-8?B?VlBXRTcvdHFCMlVVcGgxNXBTTmgwTHFZa0lIczlJeElOQnRJa0hKTldJNE1J?=
 =?utf-8?B?WnpVY0s5UzBOTjdPTjU4R2ZsV1hJK0dJWU9jaW5ES1c3eUkrbVVUeDBBd1hj?=
 =?utf-8?B?WFhUeFNjRERhNVZKWFNWOWo1bTFaWkZENXRRRVJlYUtML2xPV0V2SWhGSkQ3?=
 =?utf-8?B?dFRUUHNjOVpWcDdVMGUyYTFRMzhEM1FqVjJyOUJxdUwxWnZ5QWk4NG8rcmlG?=
 =?utf-8?B?N0kzVzVlTVpQMG1HYXA1aE12WisxQm1TV0JvdHhaZW04RmRnQW9LM0NzZWVQ?=
 =?utf-8?B?OE1OcnpTZjFTZGM0THZDZjZSREQvMmlKV0RSMERjb012Q09CQW5mZ2lWSkZt?=
 =?utf-8?B?aFBqcUtEeVVOdENXR1JVSDhoUmpoUTFya2V4WTYxL3pmcTJXTVk1QkthcFpX?=
 =?utf-8?B?SVVPOUpNbWhFOGRCZkdNYUFFSFJTcWdMQ1NZakZjaGkvSWF5TUFxejRpeVRJ?=
 =?utf-8?B?cFBZbUJhWHdtQWorSTgzUk5XS1hQNGpIOExJcEdCQy94azFJWktnYWFUaTNr?=
 =?utf-8?B?cFRzTEZRTXlCdTJUbHFBUUtzSU4rUEFLVjRZMUtUdUY2WWtWTktKNzJZTTJs?=
 =?utf-8?B?TTNOZFJ5czN3bHBzVnlXbk5WblYvZ0VieHJuQUhEVUVySzVEMG1CVXA4dmkr?=
 =?utf-8?B?Y0E4MTY1Y3lNMEE0UFNNb1I0MThRVmlWQ0Q5S2dNRHZ2cG9keksvYTBjZWFQ?=
 =?utf-8?B?TWM2Rmhud2RzcEV2OEd3K3VhTGZ1QXIvaU1Gd1pUMmV4V1lRSnJWTmVmTnlF?=
 =?utf-8?B?N3B5R3JxRVg0dy9mSEZIaWZIRjlRK3U5VktvT0xrRTc2ai81VXVueWpOZUt4?=
 =?utf-8?B?MWNnUVZ2c1R0eEdtRHZBMHFIUURRSjVxaU43QndPOXhWWXhlZzUrUi9reDFV?=
 =?utf-8?B?U1ErOGdvS21wc2lDclRMM2xnTWRDWkFpTjBZQXhncG54dU1vVWpiK241NHRD?=
 =?utf-8?B?NElyZWpsUTR4TC9kSFpuYTdNd3VQT3ZWMDZYQUV1QlJzYWF6Nm5PNkM2ZDZx?=
 =?utf-8?B?d1FNZEVjUytIMnVZQ2xxa0xEMUltcmRpdzRsRC9TdHFwbmN1SzY4cFRVRlNa?=
 =?utf-8?B?UThWMFBta1UrM3hDVDY1TUtwNm51a2NJRW9GS1paVVNnS2w2RUI1YkJoRmIv?=
 =?utf-8?B?QU1yalNOSWIreU9UTUdpa2tUbDJCYjRsL3lHZldReUtkUkJqQ3hXclFtTDR1?=
 =?utf-8?B?S3BBWitXdUViTWJnUkZaMmVERUJJbVFYMlY5SVVieFB4UktYeUwrLzFmdXBu?=
 =?utf-8?B?d1ZjU3dDc0c5bndwM2Z3RWNmaEc5Y0ZDUFBwNEpYaE83cVZ6U002TFgrZFh3?=
 =?utf-8?B?cVVRT1JROG1scGFLamV5Mm5saC8xa1NIR001NkZjdkdhOUI3QktlTzJLbDE4?=
 =?utf-8?B?bUdndnNnSEV4bktjeVoyNUg1SU1DWEkyREFhVjF3aVFUam1KNFFVdmVNM0oz?=
 =?utf-8?B?WEswSzkyY29wWEUxb3hpd0NZamxzK25Wc210ZEtWdi9NdnZoTFlYVytUR1Av?=
 =?utf-8?B?WTMra0JPWWg1QXIvd2gyUnJwV21wSi9kWng1SXVoUU1CTFNLTTZrN3RRUnVO?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc60b530-1586-4aba-c405-08da8fa34920
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 01:01:09.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCoCDfMgXycivWqyyRFqh7pqIL9qdEWzR+Ifv6G71B824eHe/LmCE5GmgFFUqZI9F35nYcNL8lESzaM38uXcWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 8:37 AM, Pasha Tatashin wrote:
> Hi Shaoqin,
> 
> The idea behind page table check is to prevent some types of memory
> corruptions: i.e. prevent false page sharing, and memory leaking
> between address spaces. This is an optional security feature for
> setups where it is more dangerous to leak data than to crash the
> machine. Therefore, when page table check detects illegal page sharing
> it immediately crashes the kernel. I think we can have a
> page_table_check option that would change BUG_ON to WARN_ON() (or to
> WARN_ON_ONCE(), since once corruption is detected I believe it might
> show up many times again)
Hi, Pasha,

Thanks for your explanation. That's make sense.

> 
> Pasha
> 
> On Fri, Sep 2, 2022 at 10:13 PM Huang, Shaoqin <shaoqin.huang@intel.com> wrote:
>>
>>
>>
>> On 9/3/2022 7:27 AM, Rick Edgecombe wrote:
>>> The zero page should remain all zero, so that it can be mapped as
>>> read-only for read faults of memory that should be zeroed. If it is ever
>>> mapped writable to userspace, it could become non-zero and so other apps
>>> would unexpectedly get non-zero data. So the zero page should never be
>>> mapped writable to userspace. Check for this condition in
>>> page_table_check_set().
>>>
>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>>
>>> ---
>>>
>>> Hi,
>>>
>>> CONFIG_PAGE_TABLE_CHECK is pretty explicit about what it checks (and
>>> doesn't mention the zero page), but this condition seems to fit with the
>>> general category of "pages mapped wrongly to userspace". I added it
>>> locally to help me debug something. Maybe it's more widely useful >>>
>>>    mm/page_table_check.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
>>> index e2062748791a..665ece0d55d4 100644
>>> --- a/mm/page_table_check.c
>>> +++ b/mm/page_table_check.c
>>> @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>>>        if (!pfn_valid(pfn))
>>>                return;
>>>
>>> +     BUG_ON(is_zero_pfn(pfn) && rw);
>>> +
>>
>> Why we need use BUG_ON() here? Based on [1], we should avoid to use the
>> BUG_ON() due to it will panic the machine.
>>
>> [1]: https://lore.kernel.org/lkml/20220824163100.224449-1-david@redhat.com/
>>
>>>        page = pfn_to_page(pfn);
>>>        page_ext = lookup_page_ext(page);
>>>        anon = PageAnon(page);
>>>
>>> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> 
