Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040124681D1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 02:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383998AbhLDBjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 20:39:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:29104 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237601AbhLDBjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 20:39:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="223956554"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="223956554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="541804611"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2021 17:35:49 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 17:35:48 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 17:35:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 17:35:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 17:35:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L19aL/D7qdAc7sje90eNM8LT7hhCkcltSwdQtZvfgrnXk5rHoYYtkAyFPa35r6LzcKT76NJuFp8F89qwM53lwgwNW5ljWjLTFnms6ztWGqhwDJwO+PCD6+WK15qZYS6L49uAMOw07GiFfW6pwlgp5jhuw71Tb4Ki1xLqiV6A0e5MlW/lx6mnGplYHl8gLe7QS9mFvdjAh3iQs0Dy0bsR7em/h6Cg9mHtoGclhgCOuI+xiNiv1bmgs3oPldmPd8HQfAt1ep/7cQfeDUEug6YrjGckDWlhhQyOYaYWTd5Y8sXe7Y93ucizL23SbKsGzaBrRBLILvet9+zOja/xPllpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9pDwWwMd0UdoJSvMJ5ZvhnESEynDMGMs2u7WIphmjE=;
 b=Q/lLBy1eDnOorx9PmEV7/DVJgwiFi+MW+9pPnX3PHg+1a2P83LeCHsxiiZMf6DybtnxCNCdfw4/7biUV0XgN/+2oY2/0h4lwdF+IuUI3lK1sCi2dos6B3aSlBPYxHrNNZ4IY5YyHwxprUcmugYjBEvAKCMZFPDV/48OV3IQJVHbQORlyLQbb3d/eJs+6Zzy/bcuVXzYa7oN1G1RCVC49s8729tA6bz4Oq8Jxu0V8l4JxGyucznMniektOpU5kNHaey0M8MhoruwFKssO8A7J77kAvPTlyXLciLa3D5U//tlPMdlgC7EPKfBekeCBo5n/KJsD+6KCwR23UmZdE5kXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9pDwWwMd0UdoJSvMJ5ZvhnESEynDMGMs2u7WIphmjE=;
 b=ay8aqnUdrXmD0UcPxYUfr9aTUEj1gu+hwFoje8f/vkcVJzrzUGHEE/y8zlJQXNH3cnytp3PvvEMn6lcZbETdiSTXIFRaLPpEPADIzfkz0jPW0HUcIo9qlM1K3CnE6PWsMKmfroqnBO7TWu3hhTiFFrYaky5ERCUpyuDoB94xzFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sat, 4 Dec
 2021 01:35:45 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Sat, 4 Dec 2021
 01:35:45 +0000
Message-ID: <9306caed-cf01-c6ee-bf65-d9036b718b8c@intel.com>
Date:   Fri, 3 Dec 2021 17:35:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <4960c8f9-72e4-0f40-64e4-4384a76d1e69@kernel.org>
 <fc4a8c94-4e1a-be53-50fe-802f6f985eaa@intel.com>
 <b271bd29-1e7d-a10c-f71b-533938c77a0c@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b271bd29-1e7d-a10c-f71b-533938c77a0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Sat, 4 Dec 2021 01:35:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34909ea7-2273-4eaf-0611-08d9b6c66477
X-MS-TrafficTypeDiagnostic: BN0PR11MB5744:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN0PR11MB57443616DD1CBBE3D06664E6F86B9@BN0PR11MB5744.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STFvbMySLubXJnDRKUH5Mn0BZ1jKpMU89eu5aJ/nw6pkgVrajfFC3BgiDBy4a/5FMeAbMTIKWCuhfdoEDtoA9OBunJoRLSkkd0uyUS5trrfmof13/NISjCsw6ght6ykEfViBlPPToOXjRktKkXHgXie+F2n4X53lBqfQqtUaPqV7kFeWo4b1Zv4q/+dpA1vT2HdOfCUNbgygtSJFBlEKmo1s4BG1SowSg74s/GXVBmXHNddLwjKZoIsFRLGjBFUM07W1iJaK8bjZmcxOT1croikf0sy0TQu/aqkTpBKiAd+Go1sqE14nUoNw6+SanGVfKh+BcjZb4jh9DU1uGexbuJl3Bf9/HbU6/YaOndk6EXCbyprEgavlIykB1ayGhq45iF38OrSpYrMI/ciw5BCOiG8AJGQIgk24O+GVB1UakI/jSBhwf3BWU5Eo4b1+7Pe8B3WWjUchFtjrkqo5NJ5lCpFunZwwrUJw6QwSOnTXKATjUf7hHyAf07CKa1q1jqSmbRqt4LwtQS/bHexMhFVQgixatwiqauym8REOnuXBJlu64yvONkYUGp9WaclbuMmSCHlqOciVlZDUvG6BhqFFBEAuOuOqtPAqpX7tcDUb5OUiXG0rfr3665ndlhxY4AzbOF8nR/LuguY1n+LniYwsThGKj56MeSjzDfSx+evOb64rmRU0WyDvRfdUhlpcPOmZnZ6NIR0dNGpefeD8MN+ihSKY1pXFsvxQKF8SiVFiDeMuqnQIgyNEE9nKsw36q7rf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66946007)(4326008)(31686004)(16576012)(5660300002)(66556008)(956004)(2616005)(66476007)(316002)(82960400001)(36756003)(6486002)(186003)(38100700002)(53546011)(8936002)(26005)(31696002)(44832011)(8676002)(86362001)(83380400001)(7416002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNPRTlqUG9RNHNTQ3hScTRRQkJicll4QUZsOUlzcFNnT005Ymc4UmhqYzk3?=
 =?utf-8?B?TkJkeU9Jd3dHQ3FqM2IyYlF1aEgzVTgwMU9WWmlFT3NGWTFNcWRWdVh4cUE2?=
 =?utf-8?B?OGQ3MysrWEp3Q0pHZXJnWHdFdlZFSS9DVlYxejErbFU1ZG9UYVJPaU01QjB6?=
 =?utf-8?B?aXJCdW4yZWFEZUtLVmJYcXEwdG9LV1ZvdEFGNTRGaVcydWFDTzh5d1VtQ2Qy?=
 =?utf-8?B?ZkN6a3o2eC9OSUZuK3FNcDdBdWtDT3dTTGdaM0ZMNlAzK2dIeHhQbDdSSEcw?=
 =?utf-8?B?M0ZTZlRSbURzdkFTNHlZcUd4eUtlRjdjL3FDVHc3R1lLdWVrdU16a0VERDJs?=
 =?utf-8?B?ZmtkNnpxVHlrQ3dZSUUzOEs1NDlEcmhGZU5NNkpGbmVJY3VEcXZ2MmhjZ2xS?=
 =?utf-8?B?ZEo4aDNuYWwzYWtFZVhaUVZtQ3RVVDNYbGFFMFVXTXludDlXRS9jT2RxNTkz?=
 =?utf-8?B?d2tUQnh1VERTSG80b1NZbUR5RWNmQVY5Rnl1TE5FQVhJcEJ1dDdHbXI0eE5Y?=
 =?utf-8?B?Wk1KYXdONnhaMTZPWHV5NXRaRG1CaDQrMmtRa1lDR0tBd2lIaVYwRGY3YXFO?=
 =?utf-8?B?SERJMmVVVXVRU2Y3UmhjUkZQbk9uWGhYMHg4R2s1NmVPU2lGL2x2cFRiMy9i?=
 =?utf-8?B?ZmlxbTl2SXplcmwvNW0yTkpOLzA5djZZUkx6SDlKNFAyUHJ3QnEwU3Z2N2lu?=
 =?utf-8?B?T2JzbnZkMmI2eDU0OUpxTnlvL2RqcnQ3YXA1VkZMZUZoY3dXQklWcnp5Ui84?=
 =?utf-8?B?RVhTTlUrbVk3anFvaGhSRTJXSElPSU1GZVp6VnZmSFc0UENOelR5MlN0dUVW?=
 =?utf-8?B?bm1pTGFMZ2RZNzllS0xmblJPck04eTYvQ2VVdk5Tc3FZNEZuV0hRSGg4ajcy?=
 =?utf-8?B?RlZHRzJVWUh5eVhTUU1hK2t2ck1jSVpocHh4Q1I3SGNRTU90T082ZkZ0WG4w?=
 =?utf-8?B?aHBicGJBTWNVM2ZINWVjYTgyNXNSdDFvTkc5QWdXWWE5YjhBZzhMM1h1Q3Jn?=
 =?utf-8?B?cmJ1aE43cFd5K3RZMmlneHkrdTdPdGVqTUtJQ0J5WFV4WWNaT2Zsa01ZTHkv?=
 =?utf-8?B?em1JZDlFYS9BT3dxM0lXU082bkxFVGY2LzJMRllHSmp1YU5VTHZEaWtrMjA4?=
 =?utf-8?B?QzVCckVsMGp3SmlrSXA2UGF3SndrWExDK0VZYUNZOXd4NDcwZjVPMjVVcml2?=
 =?utf-8?B?cVk1cTkwT1JuNUwzckEvb0VGeFBHZ3JOWVIwSk9hVU1xSmYyamIyYXlvQXln?=
 =?utf-8?B?SHBMd0ZCRXdTUW54TU5HT3Z0cTUyTVVwaWp5L3g1TEh0YUpKZDlydVMwN3Fs?=
 =?utf-8?B?QWxsTklsVVQrRzRXdHpsWm9GNGNTMTUvSjZrSzlnS1gyM1ZrMFBiQkhTalZI?=
 =?utf-8?B?a1BPU1Nxc3FBb1VQaGs2RW14aTBEK0NEdFlUSGs3VkJTTWxsRURKSFc5R2ZE?=
 =?utf-8?B?TC8xUm55Kys3RWtDb3pKY0JxS2lZVjcxdi84U082QmZMd3pDeUxZWmJLb2Vx?=
 =?utf-8?B?MStsTlZwSkp3TCtmRlF2UlBodk4rTGJrM0F5TVlIZ1B4Qm85WGRsNTdxS2sz?=
 =?utf-8?B?TjZKQm56U21qOXZQMHViRFBMWTV6K2hrUFhuRVVpMytoR2hmcEFIYnZkT2R5?=
 =?utf-8?B?TGpuOUxrNEFKN0Y4S3oxNmhzd0dBbFF0eEg0R3VmRWdSQjhGNXRubys2MDJr?=
 =?utf-8?B?dVJWb3dKMm1icGJReTM1MndDTWVzK2NVZHVZSkhkeU9hZWhQMHZnWjZIL0NO?=
 =?utf-8?B?SzBaUFJtbjNCSFZNZHpPdGtTeGk3MjhaVFk4L0VrM25DQ3BINUcxenhoMXd6?=
 =?utf-8?B?V0Jrd3JDckIrUEMrSjBkSnZTZy96VUE1SHNvMkx4L2VxTFIwckNBODM4V2hr?=
 =?utf-8?B?Nm1nTWZLR081eUJPMUdENXJ3Z1JpaVg2SWNrUWZjYjVuMHNRTDJESCs1YStD?=
 =?utf-8?B?REIzVE43VjhqdDVkWHA3NlBRWFkxbXA0WEl0UU1pVXphZFJqRFl1QjRJZ2lV?=
 =?utf-8?B?YTc5ZGloRmkvY2RhSmJ1VG5scHhONnFTQmdFVVB0RjliT2tLUGtzUW1Nemk1?=
 =?utf-8?B?MWY1bm5iSyt5VWdySXhxbkhjWWZvWm54L2NqWkcwaHhsNFN1QkVDbG1kMW1h?=
 =?utf-8?B?WUlJeG83dENtNTNsREVUSk9MczlCZWh1eG8xelJSKzAzWWRUZzZRTnR6dzh3?=
 =?utf-8?B?NVE2QW5EZmVibnVhc2pMK2hYU2hpNEZIVjhUV200RU96MmlwcU5KTDNFa1Zq?=
 =?utf-8?Q?r5QJb21k/Cn6lqFIODQmCmUxsWIDZyA4vUNjC0OYSI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34909ea7-2273-4eaf-0611-08d9b6c66477
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 01:35:45.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV+k8ZntjPA1lrm+OBIvNB6AA2z6iZFHcBWgN8UAkvFxyJp2JTXKb/LQ5Es8o9pytJxNfoWl2f2zCayVnxD+pm7vsS98UgzJSJOg1yY7RKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5744
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/3/2021 4:42 PM, Andy Lutomirski wrote:
> On 12/3/21 14:34, Reinette Chatre wrote:
>> On 12/3/2021 11:38 AM, Andy Lutomirski wrote:
>>> On 12/1/21 11:23, Reinette Chatre wrote:
>>>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>>>> created with permissions that support all usages of the pages, from the
>>>> time the enclave is initialized until it is unloaded. For example,
>>>> pages used by a JIT compiler or when code needs to otherwise be
>>>> relocated need to always have RWX permissions.
>>>>
>>>> SGX2 includes two functions that can be used to modify the enclave page
>>>> permissions of regular enclave pages within an initialized enclave.
>>>> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
>>>> permissions while ENCLU[EMODPE] is run from within the enclave to
>>>> extend enclave page permissions.
>>>>
>>>> Enclave page permission changes need to be approached with care and
>>>> for this reason this initial support is to allow enclave page
>>>> permission changes _only_ if the new permissions are the same or
>>>> more restrictive that the permissions originally vetted at the time the
>>>> pages were added to the enclave. Support for extending enclave page
>>>> permissions beyond what was originally vetted is deferred.
>>>>
>>>
>>> I may well be missing something, but off the top of my head, 
>>> literally the only reason that EMODPR needs CPL0 (i.e. ENCLS) is that 
>>> it requires a TLB flush IPI to take effect.  (Score one for AMD for 
>>> being having superior hardware in this regard.)
>>
>> My understanding also is that it is the need for TLB flush that 
>> require the privilege but I am trying to get more information here.
>>
>>>
>>> Given that, I don't see any reason for the EMODPR operation to be 
>>> treated as security sensitive -- it just needs to be implemented 
>>> correctly.  I don't even see why the host should (or even can!) do 
>>> any useful tracking of the EPCM state.
>>
>> The OS needs to know the EPCM permissions to be able to install the 
>> appropriate PTEs. If the enclave chooses to change the enclave page 
>> permissions from within the enclave then user space needs to let the 
>> OS know via the SGX_IOC_PAGE_MODP ioctl to ensure that the OS can 
>> install correct PTEs in support of the permission change.
>>
>>
>>> (But I am confused about one thing: to the extent an enclave actually 
>>> needs EMODPR, is there anything in the hardware or anything that the 
>>> enclave can do short of actually poking the page from all threads and 
>>> confirming that a fault occurs to make sure the OS actually flushed 
>>> the TLB?  ISTM a malicious host could attack an enclave by omitting 
>>> the TLB flush and then exploiting an enclave but that would have been 
>>> mitigated if the flush occurred.)
>>
>> When enclave page permissions are restricted it requires the enclave 
>> to accept the new permissions from within the enclave by running 
>> ENCLU[EACCEPT]. This instruction requires that (it will fail 
>> otherwise) the OS completed an ENCLS[ETRACK] on the affected page - 
>> essentially ENCLU[EACCEPT] can only succeed if no cached 
>> linear-to-physical address mappings are present. The ETRACK flow is 
>> elaborate and I attempted to document it in patch 06/25. Essentially, 
>> SGX hardware flushes all cached linear-to-physical mappings when an 
>> enclave is exited and with ETRACK it can be ensured that all threads 
>> that were in an enclave at the time the tracking started (in this case 
>> after ENCLS[EMODPR]), have exited.
>>
> 
> Does the enclave do something before asking for the ioctl to put the 
> page in a state where the tracking is armed?  I read the SDM, but I 
> probably read the wrong part of the SDM, and I may have missed this.

No, when restricting permissions the enclave does not do anything 
special to the page before calling the ioctl.

The (non enclave) userspace calls the SGX_IOC_PAGE_MODP ioctl that will 
call ENCLS[EMODPR] to restrict the permissions as well as the 
ENCLS[ETRACK] to start the tracking before sending all CPUs that may be 
accessing the enclave an IPI. The enclave then runs ENCLU[EACCEPT] to 
accept the permission changes and this would fail if the host attempted 
to omit the TLB flush.

You can see an example of EPCM permission changes from user space 
perspective in the form of a selftest found in the patch that follows 
this one.

Reinette

