Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F56495411
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiATSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:20:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:37658 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346560AbiATSUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642702809; x=1674238809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6oWTXwKrstYaJriUMnchmzt/ZGxPQxqy161MQX6w4Y0=;
  b=iN3MaujRnX1XBpNXChku1zJBzj0YPILi7HM2f0ThIZ5kJWFW0J23XHlx
   YEVFvx15+oxovk9Wkl8Ifm/xW+aShPlMFabOPJy54eFugERiV2xT8HO5H
   Q8dGpPo4uAg+FIyANjHoSOeO5Lo5LvDM12P4Rgt3GbbJ0y9Q81+dd69Wh
   uxlRCMb5FROnDsymveDBUvh4J3lIiyv+MPMffoI/Meo/jlqN2jkH8YtOh
   3eSpND+vQ1DyT3+Q5l3LU6IZfsmbe0F0wtCOhSSoUN1mithEXAjRo2ZeY
   aq0yCr/dUzKMLPsLyc69UUgAi4QnCOJcwHQ2l/ulTviH68wWwyaLl3IqB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245376808"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="245376808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 10:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="694316392"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2022 10:20:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 10:20:07 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 10:20:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 20 Jan 2022 10:20:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 20 Jan 2022 10:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7Zk5L5TLMDsUfX7xO4hGACB6oUnPXwkwiN0OgymnTnZ1gor3OW01IkIZP+iZ1oSoM5ooXvWpki0vTdaZiRMe56Txw7CuofDbpNLdmtLzyYz0zFjn/yEHn2NtPrWzPJH2XIrHc6rmA9irdYh8uceNuJCgnoxPKAR2xBtliZR3NvfmlkXoXoFzb00CvlVBV2ZU0kzLFSf+/l/q8OBZVnH+gVbPv5TiwIlrXj9Q1SNliO+hkRxdt7lZh8P6Zfv3yWWoLG3N0sqeXG9W70wxdxotQUkmPNv/EFZF3my1pofa4CBipWYBdROBk58EDaWQBRTGt7d4SC3lPfyBIKVN41mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9T21JVoCUhsqX6hfOV0LMDnHMmkmy3jq9R2ZTQEoFs=;
 b=XgN1MQLtEs5qbGiS/BTwMEZ/0Fz6i3dRzyfMJouK4iYr6VTULyJPidYtVMPKNuDyxpRjIY+eagvHyKGIFA5/KsV/j6MEh0WgMNZqJsqfCkSGj5i6V4TFsyrN+RZ36CIwB9ckWxaQ/PRBk5sqFT7TsSJnAhvk6526nPLWEabHBN5ZDa2kyNIq3dZQ0UXvZfbDBzaWeq5z1QZGIb+sHyGxiT2wGdyzbz9PgvnzCQHsbfZsk6WEfAfnDuyyVPM6H+NoNmGN4Wnr84Y2rjP81wzORBPbVcw0wZYA8M8ElAqp/TIz7gE2XhKGwgnfB50yLSRT39gwhkxj+J90pOFWizN4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1265.namprd11.prod.outlook.com (2603:10b6:404:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 18:20:05 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 18:20:05 +0000
Message-ID: <8ac3fc3e-9d90-48cf-d84e-40f9cbddd9ac@intel.com>
Date:   Thu, 20 Jan 2022 10:20:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V2] x86/sgx: Add poison handling to reclaimer
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <tony.luck@intel.com>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com>
 <3bfe66204ee84a0bbccaf7cd20af0d8300fb9f26.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3bfe66204ee84a0bbccaf7cd20af0d8300fb9f26.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16b0ebd7-0715-4620-162a-08d9dc417b6c
X-MS-TrafficTypeDiagnostic: BN6PR11MB1265:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB12655B3C58EC22993F99E39AF85A9@BN6PR11MB1265.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdwzctoV7yoNq/S9tmhZ8LhEGvJNs5t0vbbZkbaaf7qulu5NiXpN7OUf8ONxgsHhhEBtRgRgnTthNFQNfZFRxLqAj7sc49nPlXFAHwduACbMrvxkbwraxLQTTpuKI7xnJnsHHEIZDqUKuMBP+gEOSyPZ5R2el4lThrzdD7YTAmSAUmkxrux5Bf+t8GfhNCTF3xy6DYTgqwUiLfzcK6L9G5YX1fF+QHSzs5TwABxMvfJzOdrMfUkailNy5EM9hOrsuqA5Yv7QlkvuJIUthkU3lsNSbzehJIDcWbYL5k9pcmw4doaHpszhPS0Ovx+jL8ACQXo2VqCxZh37Ib1ksZX9MnUwTQFMedDntlsR1WxX1xhunwF5Oh1qrBuXlGk8+AUN9UdoUzpBpsddYCfLVQky7rtCBm2H7umh8NcyoaI0cFyPNITdmCHeFiTr1VSHSNS/aVbLuI7mpJR/Hv/l4nItO4gAatyZ4hWmN+gUoi8EDKIZ/eg9Gs/J/nD7wLZPYK8asz70DseNwwm0SdI+jJsh9EhccTVxVCtoh+m0gdnj3dhDCQvsY0RBNgSCD4GEGsM1d92zc9uVmoGhfn0HwBNaQhREBNa8+ihU12jdRR2tAOXjgXuLZ2u8bn2K1k2cPpXw5LGaZKqGN9chbXz3KjA429uPYtjbJPSrR3wi1/X0PgsMdEx1IY5TPbIWz7pBEYVK5TU1X+vNDfytnwzuIlhEGgHzxI5vKCIyc+7JcO6lA0D25m3mooDbyYpD4ybS8P2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(316002)(6506007)(6486002)(4326008)(186003)(26005)(38100700002)(6666004)(8676002)(8936002)(31686004)(2616005)(53546011)(508600001)(66476007)(6512007)(31696002)(66946007)(86362001)(83380400001)(82960400001)(44832011)(66556008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFlaTA3ZjRrRDdIUUF5cG5GQzZ0NFgvTG9wOUZSVnVmWVhoR3REVldjL1BX?=
 =?utf-8?B?NENqa3BZK3BzMmtEbU50TTA3UzVvL3h4NlJJN2RHQXhHaTc0VHViRTlvUUll?=
 =?utf-8?B?UFdPaTdSejRUV2IvTDdZb3VDK3RKb3A0MWpYUkVhaVhHU2FIM2NnQnE3amNX?=
 =?utf-8?B?bFh1eDFrejRnSVpvWFhWNDk1Tkg1emRJUUh1MWV5VDNNL08zZHZIK0l5Sjdh?=
 =?utf-8?B?bmZ4L3R5eVJpRWt1RHZaSFNlRUpDaHk5YkVHZ3B2VU5wdWFiZm94Z3Btdkhm?=
 =?utf-8?B?REJKMVNKSnJZL3VkR3RrbWNZTnVyOCt0RXkvcS8zUEQyMkpzMlZ1emVDdHJw?=
 =?utf-8?B?RUtLbnJOZUJWYzg0V2phSGIySHVaL2V2YTcrK1pjWGdzdDFFaDZWL01NWURm?=
 =?utf-8?B?RU1lNTZzWEF2aE9NR2p0K1NQb0F5RHJ1bE5RZGROMTJZdk1hdUVXa29RVXNS?=
 =?utf-8?B?MVNsOVJLWUI5VExWd05iMWU0d21TQUI0aHlTWWpSV3dha1NxWFl3VDcvNGtX?=
 =?utf-8?B?ekdheTd4b3ZqMFBxYXk2YmF2S1dKQ2x1YnFld1VTZVg2T0lqWU9qc3hETEFv?=
 =?utf-8?B?MXVhQkxLWkM1K0doQjJrOFdrMmJBQ2VMbDN2eEc2MEZQZmtKd1hpLzM5K0Q2?=
 =?utf-8?B?UXREM0ZDRUY4R0RXei8rdm1GMXF5MHViUWJGUmx4TGtURGIrV0tUQmx0cElj?=
 =?utf-8?B?LzdLZVJiTGdOLys0alEvTzFTVldCOFBXSzNET0Z4SFAraVVNcW04WWtMK3Fh?=
 =?utf-8?B?YjVtRXlrY0pwaWpDUmdKTTNMLzdGRFA3SitrNllocjQyQUMzTGpwUmVpWFh5?=
 =?utf-8?B?N3lxTTd6V0l3ZTBCbnY1Q0tjNkRnNFJpVERBUXlleVk5czNYRnhSY251SUgr?=
 =?utf-8?B?RHluVHpCdWtDK0w3ZnVrYzd3UlBnK2pMQ0kvNVBxeFI1dWxxeFVVNXNRZDNL?=
 =?utf-8?B?UFdkclBsZTlQYS9CNFU5SU4rV3psUUFSYmVZcG9QNkF4bHdGZ0s5bHNSVkkr?=
 =?utf-8?B?aFRIVWVoaDJoWFgzWDhjR0FqSm5PTXltRE5ZdXVTQ3JMQTM1akZIdkVIUk4x?=
 =?utf-8?B?OFhtT3dacXViNmowWi91ekJPMmxTRHZmS3F4dk8vWDcwQ0R1cjFWQkoya2JO?=
 =?utf-8?B?Wm12NjErZkVETWR2NG5ybVVKcFQ5U3d4TDlTdWVjK2JEK0Nkc2Y5SEhsaFFK?=
 =?utf-8?B?Rm1pSEE1T3ZHUW5EamoxdG9qcElBME9CNCt0ZG5Ub0dRV0ZSc1JCWlJZUWhH?=
 =?utf-8?B?N3I3bkZUVUd2bFNHZmFCdHc2WDFsQlYvN0MrSUVCNHFndDNVTGFySXk0c2Rh?=
 =?utf-8?B?OEUreDRPQ1M5UmFneU9pbjk5SVRESHdLNzEyRUx5a2xoeXJiWUVxT043YmRm?=
 =?utf-8?B?Sk5ZZkIxSjczai9QLzhRWmVhQThiMFo5UlJ2Z2wvcFAyYytUaXlRdjNjUzRT?=
 =?utf-8?B?UFF4dEJRNzdsWWk1K1Y0UzY0U3YrcEZRQlR2K3V3Ujk3WVJkRjJlY1ZMTmQ0?=
 =?utf-8?B?cGZSeGI4OHF6cUE3WHZLV3E3QktLbml6UWdSQldFQnZSWVNXbnoxV1VDeWNi?=
 =?utf-8?B?N3VseWFjQTkrdTZFdnN5NGwxVTNCQ3g1MG5oL0tMOU9paXpSZTJIKzgvcXF5?=
 =?utf-8?B?M0w3T3dvT3QyeFZEQXR4c0s0cUJHMXFLcitGbWI3UGdPYnB1d2xvQTE0QkNZ?=
 =?utf-8?B?UHl3UitudnhTR1ErOU10RWNtVW5peEZQY21FYzhaRU1IamJEeTFSUjZUZ2g5?=
 =?utf-8?B?clJMSkVXajRDOHVMZ3AxR3V6WHI2b0MxQi9ZWDJiUjJKK1p6UVQ4VGdiTVFN?=
 =?utf-8?B?NlhiWDllbDgyWSszb2FvbXFXeXBCK004SnNpRExhbStic3VsSG5PY2RwM0U0?=
 =?utf-8?B?VTluR2x2MUliOElIa3l6aUpSN256b1VpbndtL1FONlhwUXRPbHRkaUN5SG16?=
 =?utf-8?B?NVpsNmw4QkcvQjczQXQrOWxXUlhZZ0VYUFRFaDlYbURIR04zKzNiaEc0MjVH?=
 =?utf-8?B?ZUhLVlJldHl1THNTMyt6N2ZIbkJKVXVQY1lzT2NaV2tEWHpMZ0VuK2dCNE5B?=
 =?utf-8?B?MkkwRTlwQ1hwejN6Q1ZZaWx5SWdwelZpVTRqS3JFWjhCMzRVay9BYW1kK0Zo?=
 =?utf-8?B?TFc3SituRnN6VjBQaGdiVE5ZTy9NTjdxMlo2Y2UzVEF4L21nMXpEZmpxK0Yr?=
 =?utf-8?B?dU82UG15LzNNbEs5UnRBcm0xdFpHRVl2MDY5WmNud0YzeHBBSFl0cHY5Yzcx?=
 =?utf-8?Q?9ZC3EWX7497xB7hNWznYENYGSBqFA6CLTB8Zp7rDJg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b0ebd7-0715-4620-162a-08d9dc417b6c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 18:20:05.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irmwpRHgBZzHlKQLZHIdHWjgoS+y12/U4kSOtdx63e0rCPBXquBqoNhX+P22JdlPs4qxuuL7ypynYDi8wI+IDBK7E6IF1+AIh3mj2jYKwjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1265
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/20/2022 5:09 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-01-19 at 14:23 -0800, Reinette Chatre wrote:
>> The SGX reclaimer code lacks page poison handling in its main
>> free path. This can lead to avoidable machine checks if a
>> poisoned page is freed and reallocated instead of being
>> isolated.
>>
>> A troublesome scenario is:
>>  1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
>>  2. arch_memory_failure() is eventually called
>>  3. (SGX) page->poison set to 1
>>  4. Page is reclaimed
>>  5. Page added to normal free lists by sgx_reclaim_pages()
>>     ^ This is the bug (poison pages should be isolated on the
>>     sgx_poison_page_list instead)
>>  6. Page is reallocated by some innocent enclave, a second
>> (synchronous)
>>     in-kernel #MC is induced, probably during EADD instruction.
>>     ^ This is the fallout from the bug
>>
>> (6) is unfortunate and can be avoided by replacing the open coded
>> enclave page freeing code in the reclaimer with sgx_free_epc_page()
>> to obtain support for poison page handling that includes placing the
>> poisoned page on the correct list.
>>
>> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark
>> free pages")
>> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and
>> free pages")
> 
> Same comment as for the first version: remove the first fixes tag.
> 

For completeness I'll duplicate my response also:

The commit you refer to, commit d6d261bded8a ("x86/sgx: Add new
sgx_epc_page flag bit to mark free pages", introduced a new page flag bit
(SGX_EPC_PAGE_IS_FREE) that should be set when an EPC page is freed. The
commit also sets the bit in sgx_free_epc_page() when an EPC page is freed.
The commit should also have set that bit when the EPC page is freed in the
reclaimer, which contains an open coded version of sgx_free_epc_page(),
but it did not. This fix adds the snippet that was omitted from that
commit.

Reinette
