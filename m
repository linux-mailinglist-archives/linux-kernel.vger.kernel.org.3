Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E148690A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiAFRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:47:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:61381 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242338AbiAFRqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641491205; x=1673027205;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6tSZn5szUQdzH16PI5zqtDLUUSqbDDGBaqhGdv7rrKE=;
  b=GvBrCPeE/lpJ80BTmqusaEssyN6g07xJQ0F6cmxyeLpaVe5lZgSBXpwR
   PNzzTxuaelM9fsz+/eQ5fQ2Lw0ZBdMY/iSJfXocM7NrjWMW50XuMZ+eUP
   NUHuwx59Bf6YI5LmYpww1PVj+Smnl/MEolu8ihPqIaqjbNKjq08hzDkE/
   rAjWXAnfN0gTuQX8ecltPlYbsbC57egYqHShJGURWyZiNU3DNxZdn11WI
   egvluAd0qxzTzt6JieuaKApGbtlxywlh6ki5U4xO6XTKgPesO3rP0Ouqe
   Q/C48x+SGFYXh9nnY4PW12emED809vS82mWLKOuydhlCOcOYj697Mbb0u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329046261"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="329046261"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="618411107"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2022 09:46:43 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:43 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 09:46:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3ozgmidRitq7TXZrDr5PCw0Gv9Bt2D4TXNndfbDHhw3VpvwpIVTCHQekKjFFGp/pVRJ/HI0+f2HLu4BWSHFBlvvCQYv2lp2jPoE6weRTOPgXwWF7rdV9r665LXXa3oe5/Y3B80dnXJyPkAhp5FoXHvd2NBj7sbvf9zUMsrJWz2kQqLoUwpL4GhuDHVIpD5DxEq0/622eRKG9xJFHQF4T9yrvaMoiEcfU8jnUB5c9oE2Ja6OgK1uBiKA20sOftisTVgF1ek2yM5VH/Kx9QRDNNZnDVo0p+MraBf2KheY+aHhsRehuIFiYvIiDanl7hb+c+847Y7FzzgvVgQgHWfucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fA5s96jgJ+pu1PrmCj3SqxLoYNXSf8/qiCOXjuAvaI=;
 b=dqz89bPm0tZiSpDPPKAfBHXRLaYaUszrTfQSjYQq2QnsSvoKZlX5/NtsY+BtPAx6Ep2CwpGtAc31kzYBEYT6gHH9qmuWYMRmucLJvqVyhmeBb6UkiuaEeO1gVWIAoUa9DnNkCGydKbqkw0osw6vQZeU5GTRGW4YPAKoFi04rnRn4PL4YdYligBufDuszxW4myc0dubKyswCH4YKmWZLfpivwEozP7BxnrFgi0U0AIxGdlv/Cdq68PgKj4dAii37kQvh9YIMV8K0Eq2o+NW6czzXx51haLzhca1fddNnUO0b4+A3FZu1mep4dBlRxrOlUX5pl+1AfTp4JUNQVWjFMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2178.namprd11.prod.outlook.com (2603:10b6:405:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 17:46:40 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 17:46:39 +0000
Message-ID: <cf654da2-00b3-0c3c-57ad-bb669e60de92@intel.com>
Date:   Thu, 6 Jan 2022 09:46:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
 <Yavy5JTYAkdZjnK2@iki.fi> <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
 <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
 <192e252a-653f-2221-73dd-99894c134a37@intel.com> <YcsleU6ExUbpN51r@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YcsleU6ExUbpN51r@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:300:16::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109e0499-658f-4e1c-dff5-08d9d13c7e39
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2178:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB21789651EB77B4947FCE01AFF84C9@BN6PR1101MB2178.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LyDWJfG/l1Mn7qatPrqXB1svkDsYVEEOQyrIUigyh0hKQY8kz7ngQwGudM55ZlyHkmf/Rk4ntNEGiVzYBD5Hfd2EROuVg4WtbDxKCx3MOU3xoMSYrXrzrFxTNHE6La8/4NUkL/ghLraPaF5DfVOly060MQLHolxrDflXy8WEKubyKqmZnVxeRx/IKkkKTESy+O2VBmPl2c8KXDGkfZVvOSU7zCBtrged6rcaTxDaxwWgoZX5y0NJGFcpGg+U6qDGTq359qgk36cpTqStTOOiQxKZvvwkT0XGo0GjtzYkNAXn31AcWRwTiWkgQPl9ltLqtzirkTwWaYNR7EFvrap6Uy5TKUBq9+fqSDEop2MAZECcFmEKXC4R5+zqrPWGWJqAWm+crJl4gi09TikC8i+8vkqqV6zuPudnCSKaCJd+lEnsfAuRFctjAa65A61PJ44uJDlTV3VWzrcs/TGLcRSIdNgR6VjOf0jWqSMMYGkDWuNPVOAQ/+dX8Zgn7TLYwZ9pH8yL62gnAu3OOPvX46YDriJTGHvo/AQFMR1CA/ncaMVyAgUJlKAqxaBiONMm5lf0AjjoQLvi+7KMmNKArW9Tgd8ODexBbvpuwfdAh59oOOy5HgjOve4bH76ybdrbe22NlciG73RCtmFPYHZ9nDh+hJqx35hz86bZ1X4IjLm2/hqsRhPro4EqPgvsboWQYeNQbwSqkr/Hk7Rse0ETky8lPmTNbNL3m5pr0Gcd7dmAew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(316002)(5660300002)(8936002)(82960400001)(83380400001)(6486002)(53546011)(26005)(508600001)(44832011)(186003)(7416002)(6506007)(8676002)(66946007)(6512007)(31696002)(6916009)(2906002)(31686004)(86362001)(36756003)(2616005)(4326008)(6666004)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHk1YldCWUNmREdMbFFLTHlPZFZzMkFEUmk1bEczYVhHdTNiR21zV2xiZ1JN?=
 =?utf-8?B?cHY3K1p3S0FiZ0V3dmFDb2xYVEo0blVFODl1SEl5bnhNM3BpcGd4WldUNjlG?=
 =?utf-8?B?RkwxbmhDZmcya2ZDaU5RTC84ZGUxTWVZenBJZGVDbUx0U2hQenY4ZlFlZXRv?=
 =?utf-8?B?U3d0UkpqMUEzNVE0UE95SDJ0djBrR0xQUTdLV1hpUXRVQkQ4T09CUjcxZjBP?=
 =?utf-8?B?dGM2SGxkRThMQmh3a3NUQmk2S1ZmU010YWNkZkRsS2x5UDdWVTdudlZNaFNF?=
 =?utf-8?B?ZllGa21lbW1YQjVIVHBmWkNZZTMvdXZ6Ym1qS2NDQURzS0ZqSlBveWkwOW1F?=
 =?utf-8?B?ZExDQURYV3NPOUUwL2Zzd3FKSlNsU2o5Y2FDc3VMaUM4bGhQVzg0NjVSRE9p?=
 =?utf-8?B?WHB6aEhjSnBUK203Uyt3aHhIQ0drS3RaMVV2eG5KbVViUE9kcTMveUZzQ2RD?=
 =?utf-8?B?WWwxMWk2MjdmeE41NnNrVi90Wkkvei91OHVDQTZhOWh0WjlNbDZVMlFva0x2?=
 =?utf-8?B?cGlkOTJLQVJyNW1sb2FETUJGS08vclFKU2N1c3AwZGYzYUt0WkNHZXEzTWVL?=
 =?utf-8?B?SHFtSjUvNkgwQ1lHLy9LdG5EM2FCb2pjMk82NXRWMHNrYUlIUkQ5ajZpUEtN?=
 =?utf-8?B?RVVuSWZSZktrRnh2UngzYTlFeVQzSW10bzQvSkwwM292S0srSDZjWHhudWZw?=
 =?utf-8?B?NUpRdkpSN08zdDJ4NndYU1RSMUdGSGNkQWZIOU12VUZBTnRYVkp5SFQxL2Fy?=
 =?utf-8?B?ekFaenRYaExYQVB1VEp6eGJrcjlDZWhBZWQ3RnhFUjFabHJ0cGZvZ3FuV1Fq?=
 =?utf-8?B?bTlMVWxaa2FyNHZockxhbFVta2JJUmFxaUJlM2YyQ2pCMEg2dTFiaG0rd0N6?=
 =?utf-8?B?RWJrRTlGRHM3WGJINDZIeUtMWW5FekRrVDRrV3E2NURGNFhjdUJic1M2Sk85?=
 =?utf-8?B?dUlkVFhwZDE5TnFPNmlRZlVIeWoraDEwWERVeDRXOVNieFF3NkkrNG1RSEVm?=
 =?utf-8?B?RUs0cTFveW03SG5SeGFuOHB0anVsY243YVN3MTVVUm9CcXR3QUNPYkVKcFc4?=
 =?utf-8?B?MzR5cWlOejViY2J4MEV0NVVtdjBWRlhlZEtNcjZSYXNnZldzcHM4ZFBqMS8v?=
 =?utf-8?B?SkNrSTRMWW5NWVBZMlA1dHU0MnRYb1BLS2hMVlpBZlViZm9NMmJacEpOMFZ5?=
 =?utf-8?B?YWoyOXZ0cEdSSEpQQ3FpT0w0WU4wQ1lraXNDSkgvU3VQbng5dGdkaEtaeGFJ?=
 =?utf-8?B?c2c0ODBlYkIzVTJRdzRMSGZhWm4weWJ0aFZlQ0hZdHJaczBZKzRTa1h3b0E3?=
 =?utf-8?B?QmVsbU5wZHk0OStaMXJkbHlxZHI2MFNxWHd2WGpac1M5dTd1QjgwTWF3Z2JP?=
 =?utf-8?B?SGJzVXZaTWxDb3pBWlNWblV6ZS9uNFRuUGlYbjZYZG1hMDYrTFNyUnlXeVM4?=
 =?utf-8?B?S1pkVmF4Yjd3VGI3UHlLU0plU3RzTW1TSDI1OVBleVU1M3NDU2xFK0NIS0E3?=
 =?utf-8?B?cmErc2k3SFZBZGZHRk4zVmI5VS9tNHBjeUpGbmZrazljeHJpSkJGQWdqeXZi?=
 =?utf-8?B?YTNBZVBBdFpBbTNIcXcyZUtsOU9NMUI3dkRxTnFEZEc2clNsVUs5QXV5WTEy?=
 =?utf-8?B?M0RYMDUxWmUrZkphTEl4bXNwNzF2ejRxVFl3QUVPc1dzT1FNV1c5L2JSSDZX?=
 =?utf-8?B?MzgydVJrSU9OOVVYVHhBc0tHdkRnMlExRU9PK2tvNENieGtNc3l3TlZtdXRs?=
 =?utf-8?B?bE8zdWpUTXgvc1pXTHNnZVBqdW85TFJaajNFSW9XYko0eVBlY1ZVNHJyTUx6?=
 =?utf-8?B?cFBrN0RzUHR1aXhNY3FLMzM3R25YQXdYR2ppNnNEbVBzeUx1cUxpZ3lyRTNm?=
 =?utf-8?B?NEhVTCswT1V3SG8yNzhWSzZUekEyM1hkY1hXc2FINkoxMDVyd3RITXcwK2J0?=
 =?utf-8?B?ZU5Ed3ZiK1cxQ3Y1TUdLYWpucWc2U25RMkFudDRTSEpCUGdqRUgzT0IrdTll?=
 =?utf-8?B?bEZpY3d2RnBZeGZ2aEowWjlJWlhwMTFHTWJOSlM2MGhzNHhoUTF4clhjR2tq?=
 =?utf-8?B?aTZZQUpHZHoxa08zZ0daeEVaOHdLM3FyL1d4YnVNWE5KejVvVXZOUnFDTG0r?=
 =?utf-8?B?QlZQV0hwWkNmVlhqN1VDN3V0UURDK3ArNnVWT2U3ZGxwVFE1VmxIL3JNOFBO?=
 =?utf-8?B?NzZWL2RzaFE0QlRHK3ZXWlpBM3hlaS9UZWd0TmFvZkxBUUxjSTNpVXNNelRS?=
 =?utf-8?B?ZDNlYlJSUzZoRS8xbDV2blo3MFZBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e0499-658f-4e1c-dff5-08d9d13c7e39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:46:39.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GI90sjdxglNDwfbZQ63Uq7N3lhvGqEdA7SEjK3fv6JeyfHHwqLK+GjctuyUQAYtf2mgWAPvPU04lfi/pNyUWz7JKoGUl206kEp1PGdX5Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2178
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/28/2021 6:55 AM, Jarkko Sakkinen wrote:
> On Mon, Dec 13, 2021 at 02:11:26PM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/10/2021 11:52 PM, Jarkko Sakkinen wrote:
>>> On Mon, 2021-12-06 at 13:30 -0800, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
>>>>> On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
>>>>>> The SGX reclaimer removes page table entries pointing to pages that are
>>>>>> moved to swap. SGX2 enables changes to pages belonging to an initialized
>>>>>> enclave, for example changing page permissions. Supporting SGX2 requires
>>>>>> this ability to remove page table entries that is available in the
>>>>>> SGX reclaimer code.
>>>>>
>>>>> Missing: why SGX2 requirest this?
>>>>
>>>> The above paragraph states that SGX2 needs to remove page table entries
>>>> because it modifies page permissions. Could you please elaborate what is
>>>> missing?
>>>
>>> It does not say why SGX2 requires an ability to remove page table entries.
>>
>> Are you saying that modification of EPCM page permissions is not a reason to
>> remove page table entries pointing to those pages?
> 
> So you have:
> 
> "Supporting SGX2 requires this ability to remove page table entries that is
> available in the SGX reclaimer code"
> 
> Just write down where you need this ability (briefly).

Will do. I will expand the current permission changing text and also add the need
for this ability when regular pages are changed to TCS pages. TCS pages may not
be accessed by enclave code so when a regular page becomes a TCS page any page
table entries pointing to it should be removed.

Reinette
