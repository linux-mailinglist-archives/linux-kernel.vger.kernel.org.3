Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB748F388
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiAOAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:42:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:32077 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbiAOAmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642207334; x=1673743334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4kOORz1WpQ2zNmaTIK4YQmvY2LMujC89V2+RbkojcSo=;
  b=MYX98mSGLF+cXGycrbQDy9zHkS6C5lbmzQHaZdbDKT5fMhR+DRtt3f+E
   DbsKkwss9IFo7wVi5ILEidaVTfusPssWxagn4pCr/h+YxX/WTLtnsvUYJ
   pl7RWTScoKvR7k7wftGlPl91usC3v5BeFMrntms44JDnqyBUErNUc+WXq
   RyXqGOUe4OP9HlojfLFYASSlDOgZUTfCn1vLe2V7hLL0+PWkYhKNA7o4L
   As9/0lZBRkrqxakOoH3Luz9q7vEAfDhJTt29yUwSBI5xqSItAOTQbhOLk
   laabOl8TO3z3+ORdN9RnM+Rk+LRkcAl1cpnatoMYBf2jYDvwdVusE9f2G
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244559052"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244559052"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="559664103"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2022 16:42:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 16:42:12 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 16:42:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 16:42:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 16:42:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeJXjc6QMdZXVKCbomZE/QArQJpI1gtpc/XgoUsRj54a/wW8vxovBMSXypdMKee9lTirje2Yrv20wsIz165myE8oXt4ffo/VkNwEYV1SDlwvawsT5ADULyUOuQ0wkqqIgcD5Q0jS1IuojIep6izw//dzL03PC/hk6a5LBkYfbYvxL/0Oy9U8Q2y+nA6N52GrRxR3+s/l+u/FN12p+uAX1rfGhUwzfBDKsMB2eJ3bq4QYqh3zChoXjZTQVuabGhWhIoGWuuT2CYo/oEJAcBk7YIih+SnQrZGfgHq88Z/xYI6sJc2stkx4oKtPokfkxUN6EXauE8Bkyk8mndL7VGcd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwXNnaGzN5Q1Qs6bykmuwWkutEAydaSrMg+kNDAMzDE=;
 b=DeOkgqNs3Lha8NFCJ0aIevNsA4mXFKN5+i5K0hA+8ExarAmc4U+HHyhL54STGQc21rD0l14rwNi2pfnfc4VR6+lU0nr1m5tC+PHaWVv7ZJ3+qD15WevRULHe98BTOJI0dFNWbgfJrltmJS0mX1BOFdBCfNnNS0NgpyXLNHNEp3S28q5qJWwDVI4NpGO7CO1Uh+V0ogH8k00iW1CCZOds7pmPfHxok+sQ/7m5hHAayRlhMlCJLiDVeK+b2teAlMODF3P99kufUhTqRtU+yDuQF2mMdIHiv6KIVrNoZo+vcUd2wjkmuP9xr0+CrXOKeraooiA4Tpqm6gjVv3jQDGArrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB3068.namprd11.prod.outlook.com (2603:10b6:5:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 00:42:05 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 00:42:04 +0000
Message-ID: <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
Date:   Fri, 14 Jan 2022 16:41:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com> <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com> <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com> <YeIU6e6wetrifn+b@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YeIU6e6wetrifn+b@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:300:103::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75d4a5a4-03c7-49d6-eaac-08d9d7bfda01
X-MS-TrafficTypeDiagnostic: DM6PR11MB3068:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3068ABEDC63AA7080D011254F8559@DM6PR11MB3068.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8Rppa7Vzo9OuaTkp1K4OQIG8990gAYQgTz5Nw1OwkXg5ARC9gn3uHEezaysX1aWy7WIhgpHFiS/hn3ckQvJLRMONnIq0NPqUeP4p/pKbAn0QnkplSc9HRjXzVBqqmxJIsGphKHeiEGIm//u06vV+Z4CcyG72pd5wX2GCBWSo1FfeOsgEqVk3JetvwoKG/5OlCtmwfhJh+ludH9NZlOy5MFSfQXOw8GHWUA1QB+A5zF43t+w9CmryG+vA/4s3S0LR+So9XaeEbvWWiluqaMtkWKCjGVRXCp8a08zLVpud26jAMDxKh5BqzguxmKjjdQQUFXMYXObBx+LQ00L93SMetEaTOkOE3sLe//i2JKiJuVFYnDu6rPCHrc+OzP8jRXAxFaVEM4DimJ3Hg6iB4qfdZKJVUjmyk8ln6mz43CIpPl+5zkNgwpSONe+gXOT9f5TTZUyg6qYZwYCSVP3CFTMVJw/tiC1RmfbyzjQqeQDmntj/C6xT2ZFBL26fjkYGpJRqkhsGyrJOr6W96L0u9M01NjuRKmjSIy5J2Ew1KhDLaHnnO+mdzOsNDmAMFmRu9El/hIfIGjqpFfylemKN9qIoG9c68T07Cd+3+uxMZ+pqEOe6rpDAjMAhx73bYE+8+xfrtSlj1LvlfoiCpgawPd4+FX31M6wmlxZGyPhNNPh7OgMoJPG2F1OdkPT93XAQs/0hZ6zti5HL/O0xCBDsKxzU272hriWOyN7ctt00vgdrXQ75JG6CWMFOXeiHEsMr3Cl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(316002)(31696002)(6916009)(66476007)(66556008)(36756003)(8676002)(54906003)(66946007)(44832011)(2906002)(82960400001)(86362001)(31686004)(186003)(508600001)(38100700002)(6486002)(6512007)(6666004)(7416002)(53546011)(26005)(6506007)(2616005)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2M5MFBZRHgzb1RjMkNYU1BtRVVnampmRVNuelR1ODBLeFBLUG5zeFNrN1JK?=
 =?utf-8?B?cXNNWC95RkhFeVZtZjBLS2Z6KzdwMkRCMUgweW5UMy9Yb3p6ZElVYkJDNGRK?=
 =?utf-8?B?bnRyaldtaUZ5aDhUQytTSmNGQ3BLRU5xek13V05KaEpTMFkyaDdwc3BTSEZq?=
 =?utf-8?B?b3dwNzh0N2hEQlV6bWtVbFZPWHgwY3hQV2RreWVHNzA2bmxXYWdrNDhydFgx?=
 =?utf-8?B?aTQ5L3VPcmZ6M3ExU0JQNzF1N3J1L3Izc3RnMnBrem51blVJaTFBeFB2bEQw?=
 =?utf-8?B?b015TGsxTTI4dDJnckdmOFB2TFZhVWtFalFrUEZTSlQrMzRrUUZjWmhkSUtB?=
 =?utf-8?B?SkhJbUFLTTExcWkvNkEwS0FTZGpJSkpYSnUzWlN5OFQ5R3F5ekdQY2JyczZi?=
 =?utf-8?B?YVAwMlp3S0lld2xhVGIzSTJCV21QUm8rYmN5QmRqTHdTaTNVNEE3bUZ5Qyts?=
 =?utf-8?B?SDJ3VW9IQ0R5Q1RGRTBkRlE3eUxuU2JaYjVLYnhHdktYTGZyRFVyOUJMalBi?=
 =?utf-8?B?RTRMcUJ4ZkVCd0c0WStLZWVNVm14MEk5TDMzY2FmeGNIeWM3aUExcmdoei91?=
 =?utf-8?B?cWI2YklXZ2F6VjdURVdwOTNCRGhET2xvU0Z3SUJMSkErckRqUzNuQkQ0RlAw?=
 =?utf-8?B?TmVFbTV1VnNzOFZ3ejZFRVRTMXcxNUdRc2t2TUJBS1hIcHcvc21uNzJtcFE4?=
 =?utf-8?B?VHdXYURaTGl0clRmR0xYM3Q4NWNqQm90T2YrSHYxWmhNbXRHdVpYRmtOeFpO?=
 =?utf-8?B?djVLYXp6eDZEa1lCTVBLRTc1aHJCOVQzU0pLSU1TTG1ZNk8xaC9xNjkxaEw0?=
 =?utf-8?B?TVNzVlZ0U0U5dFRRUWtJWXNNK0QrU01jMnJIRENQVS8rL0xWRkRvQ0tMSEwz?=
 =?utf-8?B?MTNxbDJZRXNOcGFGL0N2eTlEWDFHNTNwb0pUbmVqeGZiY3Z0WlpPQXMrRmUy?=
 =?utf-8?B?UGp5c0FPUk1JYTR2NS9QUFN6b1ZQSWI0djN3UnVXWU9YamJZRkVZNE83VG5k?=
 =?utf-8?B?V1M1QjJJWi9KRmdvdktmdnVMZXlxNmhYN3psRzlYMWJCOHVhd0FVS0pwNlBM?=
 =?utf-8?B?OWYzNGJmZ2o3L2FqTm1rczUyOHV6TWxaZXcra1RUUWFxdzZoUkR1WHNqSGhW?=
 =?utf-8?B?QU5YN0pSbGF6ZmRjTkNzcHNvYWZNYjBnYUN4NEx0Z25RaEMwM1hhd0hxK2lZ?=
 =?utf-8?B?ZzVvNFRleHk2dDFKRWpoWVhHZjhOb0wwM2NUbEc5YWxndG0reWd3WU5tK3M3?=
 =?utf-8?B?a2ZKTUdFYzVmMjRHRDloZlJXM2ZGZUZXNkxpM0lOMFptQk1NVlhyODZ4OXNQ?=
 =?utf-8?B?bmdIQlpQTjhuSUNUeXBzRS9DeG8wZ2lLakxJWG85OG5aR3hFSHFuUXZJS0cx?=
 =?utf-8?B?dFVvYXNlRnMvaUpaRXdra3VXL0s4b2JvUi9venllSHVmajluYzdYMXY3bGl1?=
 =?utf-8?B?Ykh0Vi9INEV5eTZDQmprQ3pFSW9PNVFxb3hhQnhOQ3dDYmw2ekNYVm9abDBi?=
 =?utf-8?B?TlJpVlVFRkdJU1htd0F4WHhSaVhFdTJRQmM2aFlHT2pBSy82S0VZZFdCZzI5?=
 =?utf-8?B?ZFZyRjhFVm9JcGNRSHA1VUlFWTFGdXVGRmdPSjBaSVdLNmh4bjRxeXJLV1Bm?=
 =?utf-8?B?ZGZOc1FTSUxaRDNENFdqU21VNXFxd0lrNTdHMEcwVVBMaVJjejl4cmZpSkJz?=
 =?utf-8?B?V0gxTno3a0xyUXUwUTFabkF1akJWOXljNTR1a3lSaEt3VUlXaDNMWnB1cmx2?=
 =?utf-8?B?NWhQZXRFemhtTTMrd1N6L3BSYlA1aWpuYTYzT3lnOVNSc0drS2NpRG5qNGla?=
 =?utf-8?B?aFdvRHhUaE5GQzIxOGFWbkFPaGNiR2hpTSswQ29BNXZSSUZTUDFMTDBlSS9X?=
 =?utf-8?B?MFR5TndUclF3cTRaT2RNTjRTWDRvdnBaN1RsdzVDN1lXbVZROHAxNmNJY1pB?=
 =?utf-8?B?MjhqTnR2aHI5dFhqRFp3YU1XejhQdXdzdXJ5QXFZV1BrcG5kcE41V3dlclYz?=
 =?utf-8?B?VjFaMFUrcjQ0VU1ZQkJ5am0vOXhVNnIxbXVSWHdCLzcwTmFCSjgrVHZONDFl?=
 =?utf-8?B?dUg1d2NWTDlvcnBwUHFNVDhTbG9taWpsWEZweUQyeWNNQ0c4YzRrNTBGdUtP?=
 =?utf-8?B?N0NrbWhGY0xHbjNyWmxqdy9Ldm1JTS9IRm83L1dRa1BESm1sQmhzdXRscHJr?=
 =?utf-8?B?VUhaeWJyNFlpL0tMaUZlZWFXU24vRktiTFVwZTZrSEkxTXVyakljYktYaFZj?=
 =?utf-8?Q?iZWzcJEDSSWvu5JkW6Ovs0Vvc88pxg63Hkv+qiHt2c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4a5a4-03c7-49d6-eaac-08d9d7bfda01
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 00:42:04.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixRNOUcLKztsQW49h4We9AX+sEaSom1IOQYiYOGcsNcp4kpgytCFMzjoX4jxB8QI1gETdscXFYsDiGpJv3gC9KbUTiB6/q8tRWKLMwAMcXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3068
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
>>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>
>>> How enclave can check a page range that EPCM has the expected permissions?
>>
>> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
>> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
>> time the enclave provides the expected permissions and that will fail
>> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
> 
> This is a very valid point but that does make the introspection possible
> only at the time of EACCEPT.
> 
> It does not give tools for enclave to make sure that EMODPR-ETRACK dance
> was ever exercised.

Could you please elaborate? EACCEPT is available to the enclave as a tool
and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).

Here is the relevant snippet from the SDM from the section where it
describes EACCEPT:

IF (Tracking not correct)
    THEN
        RFLAGS.ZF := 1;
        RAX := SGX_NOT_TRACKED;
        GOTO DONE;
FI;

Reinette
