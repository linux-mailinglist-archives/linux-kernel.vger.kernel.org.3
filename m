Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03F547718A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhLPMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:21:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:64265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhLPMV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639657289; x=1671193289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NMLQrOnJ82FEEdOp/CO+NZG7PDj44PANrdqsjALUuGA=;
  b=mOt/djsew1pdGWHbur7gPb5Ld6grJSYwD6V3TiUkVEXECzbN2GYfITBO
   GG6CVXp8VLx5yKhlM13dqjNHafsbzPicP6qh5qmAAEK51dGkF/nHCMT/7
   rGD+BZER5VFlwPN0JqaJ5z6E0JmcFCz+mtCX6VBMTBeYivvGtKrpu694Z
   9ZMLkgaTqnmE0OTNUftvN1f7umPxmqi5bGbKELODNCnQJrw9DT3qwHHrO
   IexQWJMuWjoAD3t2aXc08gbKx2WowJ4oO+F6elqOqJDL98uxm+weoIiHw
   F88IIujGLL44EDz/cxjzZQ1p7CPH0YxVLD+Di4Nu+Wq/cVoB+CYik+2KD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226334929"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226334929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="506256618"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 04:21:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 04:21:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 04:21:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 16 Dec 2021 04:21:28 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 16 Dec 2021 04:21:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcjjIRr+hwgIDOJARj+9JV0/t9DTekNFxQ6mPjEYOx9sgNtRdlkIGWikPBlc45kBkKd+bW4iAQhf/J/SSoU/V5lRq3uXjYt/HUrc5qgbfC/qSqaD3am8YyE7C6n7n1zhYG7gSD5krq02mHCXGXfIie458UGt/nu+b2rENeM1irrIyHeJdTbqw4axOOeajEkjTOlUNo9Oe3bugwImtyEQtHxE75yMMZlczb6bXyI8rEG2VFjpcLtzAKbBMP+pWUadA6cQjJaHozuVKt25v2TIglqy/MgxxcPGLUKlIEN8JmS5rC2Ol2C5XY4bzf+WapU49TNcmtXHNdi97TPTXP9Qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0izeG0ef+E+Jj5ALjjCBAcB38mYECRoOtBP+JH1PUA=;
 b=gHFe63lYqkt/zh16YuI/d1I9SUtkgX6zHxSIKEIwEMQhGZSVQkFUODIsK0tSdRprnuG7QN/2mqsN4FDTU0gjDUWx8Sso2yr+oEceFdYdF9fbkCUgdC101pzPurCqSVmFDWfSz/GV7M0r39qV5JUnpXLESAUnKrNrDR5scQVxMifLR/ktaOLx4l9rwo3I/LUVzR9X3F/RGn/jf1NFzPlzSzrAnP6HZpC3kwdULTyueKOBXFmSlABRm038KWi2LmBX4MsZa+otXd3W9vevmxMnmfMvboNYfI3Q8V4HZBn/dD4qfOKWSJWyeH97eHzAAdAXC91M3NiQQLBTmOa+/DIlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR1101MB2288.namprd11.prod.outlook.com (2603:10b6:301:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 12:21:25 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%5]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 12:21:25 +0000
Message-ID: <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
Date:   Thu, 16 Dec 2021 20:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage
Content-Language: en-US
To:     Carel Si <beibei.si@intel.com>, Borislav Petkov <bp@suse.de>
CC:     Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic> <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic> <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic> <20211216115838.GA23522@linux.intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20211216115838.GA23522@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea99549-8e2e-446e-c24b-08d9c08e93b6
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2288:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2288BEFE89465124689D9E44EE779@MWHPR1101MB2288.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTPhjEtOB7dl4vM/0m5uAhCDEJnjb0U5uhMN1oBOZFkAVsWSOL4pVhYbPFm0p+e1lRDZap2FmGReCHeFEDEJ/CLAZGU/xvg34DJifXm5DIF9qbDfNwHS/EAhXD7OnMAumRnxhXMxqsObEESlJX+jCjIO2UW3McvjgHIE0DV5Z4NA/zNXqS1ukPlKnoWR5ImtTICWs9y7IeQ542dkZcj+Zxz/P9+bk91oZrRilV17/lqn+tzemruFSmnstAx13gWy0HMRgopSv3tWhO3OY0t0Cqg6GOimr7wYRL5TdRqqImQi8w7U8I+BIZMxD08dh5S8niUzpjlfPsU0mtFRw9wD2JxySS7cx7G8/CxYnxNqsjMdUvPcdrLPJ+U99+4nkkHbyNm2uDNrtB2VkjfOtxf5diiltbvllbdqMW829mch36HDvTLeakjCWTNRxAaJNbuS6C4098xLV1G43OzN04YgBydn9hrUmdnWGui22IcqE86ml7IHRZ5T4pK+UzrJ+npC9FEWzVwyUou/b0C9ZApy7/YZzOjxUhSVzW0SYgeL9b60710gyS1WraB4TN2uifXcHcKs3ZekYfMqX7z65lBG/oNI4+SwLaG8rcn7gViJr8G4bZ557jQduJf/IV6r6MtXaZgNaZjx2spij3S6YhXOOhwo3ItkLWGoq0kjyImRl4vcSMTB2wG1QmbdnngUdNPQUs4foIrNv4d+NUWcYwyKNk2IX13vYbbQcQjbOtPrFyVb65u1izuVPpEsk5/wAimgV+tMwRenLDCgPGMT/aIvRtAo++3pao9AHSy6FR4EH7CcMsyxg2cjAw9xWMqgEfTF0Py3Mk44O3i7Lyqggk3e1wLA3E7xx/ytg4qd+nfUZI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6512007)(53546011)(110136005)(107886003)(316002)(54906003)(186003)(6666004)(8676002)(83380400001)(26005)(2906002)(8936002)(4326008)(86362001)(36756003)(66556008)(66476007)(508600001)(5660300002)(82960400001)(6486002)(31686004)(66946007)(966005)(2616005)(31696002)(66574015)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STAycmNYQ1NjeHlKZElDNnlSMmNyOG5KMEtHN01UL3VRSUN4bXIwYVRnbm5I?=
 =?utf-8?B?dmtVRXB4VElNVTRFTTNmZmx1YWxmVVdkZFUyOUhiR0Q0ei96SGJwWUVUQzZz?=
 =?utf-8?B?Q1p6c0Rtd2Fjam00SmpvNDRTMVA3OUNBNjFyMENWWkRKV0Y4cy9ITXhKMU1X?=
 =?utf-8?B?UmtqVHRlWUFkbkFHUFdWcW12TU55OE8yYlpsTUhxbWlBaEpFM0RKMkg2MTJ4?=
 =?utf-8?B?a1h4OXVNMXBwcHBCbEt3Rm9zcUxWbWFFQWw4ZnFCUzNQOTRmeFBzd1g0eld3?=
 =?utf-8?B?QWdudXNkRmFFd1k0cytWWlExMGJYQUxyWkxzY3o5by90SUNrOCtGa3Z0TUxm?=
 =?utf-8?B?anhhRVAxRnZRT3cvQi9RSDk5aHM2QXJXbUF2TVU1MlA0bVRwMWNlWW4wRzM0?=
 =?utf-8?B?YmJSNjl1bnBSWTBoZnFOdlRROUJHQ2tENER1Sy9sT0VwQlZuK2dRWFNkeHlG?=
 =?utf-8?B?UmdHS1h0bTNMbjdGS3F1R1R6cno3ZVM0STFLVmJRdEJ1OGFLeVBiQjhOZ0dY?=
 =?utf-8?B?TFVsR2hvbHJKUTkrcy9NNU9EQVlFUS85KzlWVTV0K0UybGVqUHlKV1ZITG1u?=
 =?utf-8?B?alNkdmgwL2xPQzArM296ZWJMVTFrSk5yVFpEZisvbEhsalV4c09MNHpZUlM1?=
 =?utf-8?B?R3BXZ29tS0ZiakE5Z0NtZ0M3V1ByWHI3L09mVW45ZU82TFhBN3ExOXJrcGlx?=
 =?utf-8?B?d3p2RmhyL2RMZFFRVGI4a0FYODE5V01XRCtRTExDYmhhS0wyd3AycDlmWUJ6?=
 =?utf-8?B?eVIybEs2NCtsVFZ1OG56TDFlVVJzOU15YWhVNjl4UG1UbGNoMDl1eUxia2w1?=
 =?utf-8?B?SGh3emZBTEVadUpwKzFJYkRuWk1vK2NXc3FDWDdlRExJTng5TEtXRjhDZEp2?=
 =?utf-8?B?NC9pN01jSCtsam94aUo1MjkzMzRSS08xaTdiUXhKUGZzSFl1MjJsVGNLbmVJ?=
 =?utf-8?B?ZnhlVVlzTlpuT0tnallXN1pkSFYxT3NKZXJsRm5zUUtvODZ5WkRNbUMxTkJx?=
 =?utf-8?B?b0h5dXMzOW1IVHI2djhDK0dBUlJDTmR3MGlpQnlKT2pndVZ2Szg5UVhLajQ5?=
 =?utf-8?B?V3NFQnlPWkVTZ2VxQzZyYkpIdDUxRWhhOCtBaURrSmgyMEhsVlI0WmNlM0Rl?=
 =?utf-8?B?NWRjUWptd1RVNDBKYXZFMzBTQjRLd3lRLzBrREpNWXVHWEFLcU5hV0F1ajh1?=
 =?utf-8?B?eXlDZytmVkFPaFFPdnJONU5qUXVZM2dGZndheldKajZpaEdZc3AzazZMcEly?=
 =?utf-8?B?M01wOWVsc3JReXcyVURjTVhDZEs2emVJY1haZlRrenJHVzFCb3RwZmpIR3Bt?=
 =?utf-8?B?NVNmVmllNFpQWXhTK2lsdmdOSWE4aWRTbkZKRkE5YVhQOHBYQ250SGxzS1V6?=
 =?utf-8?B?NVpRTUx4QVJPR1FDVHhvaEF5S2hkNEc2ekNqaWpxeTR3cjJya0MxRThqcG11?=
 =?utf-8?B?WUExRVFrODQvSldHTzdGR2Z0VDFZOWJIYXhLdFZWN0NWaUVmUTdCa3IzYWNn?=
 =?utf-8?B?QWhpSy9KR3RrbHlidGJpWEpvQXVrZDNjQUJZanp2VzdnUmNvbUsxMXg5OFJq?=
 =?utf-8?B?OGJhQlVuVDNKTFVqWTdoZU9ZaUhWdmJqeUJsZENhaUxURzM5WDF1eFlxYmFw?=
 =?utf-8?B?N282SW1IY013RUhnd3BoZnRMQ1VxUHhlVXJQZnkyVXlXTHU2ZlBuTWE4ZDE1?=
 =?utf-8?B?aGtXT0tmaHl6VXhvT0JLbm1QbWc4YzdSM2FoOENPVXNQbVpjd3Y5Q2hFZ3gx?=
 =?utf-8?B?VFhVcnlueU10OGxLbE1TbmR2OVFmcFFVTndEeXVoRDdJdXBENEJNWHRDa2NZ?=
 =?utf-8?B?ZXNCczdoY0xqUHVwZzNEUGk1ZDE2TUd6UEJ4MUhWU1JkYnJmQWRuMWJCUVpu?=
 =?utf-8?B?em9ab2trM0owTjdpV3BQRnRrNldlRkRFMjI4UG1YUVJ0WE5ONDZMd3dndGJt?=
 =?utf-8?B?Mkl5NE9rd2xKVC9jdU1YRTRXM3JkRys5NE43c2dqcTczV2lFL2JhQm9iUjhi?=
 =?utf-8?B?bTJWVHVxc1ZnVlpiV1dBelFhaTVaWkRDand0VEV6RHZyNHpzRGtlTkpSUUs2?=
 =?utf-8?B?TElkUzFNbGVZNlVVR2pLNlVoSkxtSTQ0ZzJrNlJ5NlV4WVRtUGF0QndBUkdT?=
 =?utf-8?B?S3l2RUtlVStiQnA1amdjcC9QMERNZ3hTeUZ0ODd6cTFXT25zRHl0L2NQVytG?=
 =?utf-8?Q?jfwi/U4J31svE93J71qSIvw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea99549-8e2e-446e-c24b-08d9c08e93b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:21:24.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zaLLpyGY/dwxKRjJ/j4hQeGe3itMVShMN0Dgw8Y99/m4fHt9jwnCEC9YfYNZ86/nBzgJ/pOYnbznxZMaWHRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2288
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/16/2021 7:58 PM, Carel Si wrote:
> Hi Boris,
>=20
> On Thu, Dec 16, 2021 at 11:06:59AM +0100, Borislav Petkov wrote:
>> On Thu, Dec 16, 2021 at 03:04:16PM +0800, Yin Fengwei wrote:
>>> The testing was with Qemu.
>>
>> This is hardly what I asked for.
>>
>>> And we found that the hang is related with clang-14.
>>
>> I saw that already.
>>
>>> The original report showed the kernel is built with clang-14:
>>>         # build kernel
>>> 	cd linux
>>> 	cp config-5.16.0-rc3-00003-gf154f290855b .config
>>> 	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 olddefconfig prepar=
e modules_prepare bzImage modules
>>> 	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D=
<mod-install-dir> modules_install
>>
>> I saw that too.
>>
>>> Looks like KASAN related stub generated by clang-14 (KASAN_SHADOW_OFFSE=
T and asan_report).
>>> This function is early function called before kasan_init.
>>>
>>> Looks like we need to disable KASAN_SANITIZE for arch/x86/kernel/cpu/co=
mmon.c. So clang-14 will
>>> be happy with this kind of early TLB flush? Thanks.
>>
>> Ok, I don't understand: I asked for how exactly to reproduce and whether
>> you can send me your vmlinux you built with your clang-14. What I get is
>> some possible explanation about what might be happening.
>>
>> So what do you expect me to do? Say, "oh, sure, you're right, send me a
>> patch" without even being able to see for myself what the root cause is?
>>
>> What if it is not the kernel's fault but clang-14 is miscompiling crap
>> as in so many other cases?
>>
>> I built clang-14 and built with your .config and it works here fine. So
>> why does yours fail?
>>
>> Or what's the point of all this?

I had concern that our report is an invalid report because you can't reprod=
uce
it in your side. If that's the case, it could waste more your time. That's =
why
I did check and shared what I got. I am very sorry if I did it wrong.


If you don't want to use lkp tool to reproduce the issue, following command
could be used as well:

Use Qemu command so only kernel image need be downloaded:
qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G -s -S -kernel=
 vmlinuz-5.16.0-rc3-00003-gf154f290855b -nographic -append "console=3DttyS0=
 earlyprintk=3DttyS0,115200"
to reproduce it.



Regards
Yin, Fengwei



>>
>> I mean, if you cannot send me what I ask for, you can say so. Then I can
>> ignore this whole report altogether and waste my time somewhere else.
>=20
> We have uploaded vmlinuz, modules.cgz, config as well as other related fi=
le to:
> https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randconfig-a013=
-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/
>=20
> Machine types can refer to:
> https://zerobin.net/?e107cf7b56495d80#MQLh14wUT9Osv1tWCwiQx/okkAN48Nq+drV=
PE0PiNPw=3D
>=20
> If there's any other msg needed, pls feel free to propose, thanks.
>=20
> Below are our full steps to reproduce the issue:
>=20
> # download lkp-tests
> $ git clone https://github.com/intel/lkp-tests.git
>=20
> $ cd lkp-tests/
>=20
> # download vmlinuz
> $ wget https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randconf=
ig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/vmlinuz-=
5.16.0-rc3-00003-gf154f290855b
>=20
> # dowmload modules.cgz
> $ wget https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-randconf=
ig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/modules.=
cgz
>=20
> # download job-script which is attached
>=20
> # run lkp qemu
> lkp-tests$ sudo bin/lkp qemu -k vmlinuz-5.16.0-rc3-00003-gf154f290855b -m=
 modules.cgz job-script
>=20
> ~/lkp-tests/pkg/lkp-src ~/lkp-tests
> x86_64
> =3D=3D> Making package: lkp-src 0-1 (Thu 16 Dec 2021 07:26:22 PM CST)
> =3D=3D> Checking runtime dependencies...
> =3D=3D> Checking buildtime dependencies...
> =3D=3D> WARNING: Using existing $srcdir/ tree
> =3D=3D> Removing existing $pkgdir/ directory...
> =3D=3D> Starting build()...
> make: Entering directory '/home/carel/lkp-tests/bin/event'
> klcc  -D_FORTIFY_SOURCE=3D2  -c -o wakeup.o wakeup.c
> klcc  -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup wakeup=
.o
> rm -f wakeup.o
> strip wakeup
> make: Leaving directory '/home/carel/lkp-tests/bin/event'
> =3D=3D> Entering fakeroot environment...
> x86_64
> =3D=3D> Starting package()...
> =3D=3D> Creating package "lkp-src"...
> 103987 blocks
> renamed '/home/carel/.lkp/cache/lkp-x86_64.cgz.tmp' -> '/home/carel/.lkp/=
cache/lkp-x86_64.cgz'
> =3D=3D> Leaving fakeroot environment.
> =3D=3D> Finished making: lkp-src 0-1 (Thu 16 Dec 2021 07:26:24 PM CST)
> ~/lkp-tests
> 12 blocks
> result_root: /home/carel/.lkp//result/boot/1/vm-snb/debian-10.4-x86_64-20=
200603.cgz/x86_64-randconfig-a013-20211207/clang-14/f154f290855b070cc94dd44=
ad253c0ef8a9337bb/0
> downloading initrds ...
> use local modules: /home/carel/.lkp/cache/modules.cgz
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tp://0day.sh.intel.com:80/~lkp/osimage/debian/debian-10.4-x86_64-20200603.c=
gz -N -P /home/carel/.lkp/cache/osimage/debian
> 440459 blocks
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tp://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/run-ipconfig_20200608.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debian=
-10.4-x86_64-20200603.cgz
> 1773 blocks
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tp://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/lkp_20210707.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debian-10.4-x86=
_64-20200603.cgz
> 2321 blocks
> /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encoding=3DUTF-8 ht=
tp://0day.sh.intel.com:80/~lkp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/rsync-rootfs_20200608.cgz -N -P /home/carel/.lkp/cache/osimage/deps/debian=
-10.4-x86_64-20200603.cgz
> 6856 blocks
> exec command: qemu-system-x86_64 -enable-kvm -fsdev local,id=3Dtest_dev,p=
ath=3D/home/carel/.lkp//result/boot/1/vm-snb/debian-10.4-x86_64-20200603.cg=
z/x86_64-randconfig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef=
8a9337bb/0,security_model=3Dnone -device virtio-9p-pci,fsdev=3Dtest_dev,mou=
nt_tag=3D9p/virtfs_mount -kernel vmlinuz-5.16.0-rc3-00003-gf154f290855b -ap=
pend root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/vm-snb-192/boot-=
1-debian-10.4-x86_64-20200603.cgz-f154f290855b070cc94dd44ad253c0ef8a9337bb-=
20211208-23538-lnvkeg-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-a013=
-20211207 branch=3Dtip/x86/mm commit=3Df154f290855b070cc94dd44ad253c0ef8a93=
37bb BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-a013-20211207/clang-14/f154f=
290855b070cc94dd44ad253c0ef8a9337bb/vmlinuz-5.16.0-rc3-00003-gf154f290855b =
vmalloc=3D128M initramfs_async=3D0 page_owner=3Don max_uptime=3D600 RESULT_=
ROOT=3D/result/boot/1/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randcon=
fig-a013-20211207/clang-14/f154f290855b070cc94dd44ad253c0ef8a9337bb/3 LKP_L=
OCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initrd /home/carel/.lkp=
/cache/final_initrd -smp 2 -m 3144M -no-reboot -watchdog i6300esb -rtc base=
=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -display no=
ne -monitor null -serial stdio
> early console in setup code
> early console in extract_kernel
> input_data: 0x0000000006ffc2e0
> input_len: 0x000000000260cb2b
> output: 0x0000000001000000
> output_len: 0x00000000079e7da4
> kernel_total_size: 0x0000000008a2c000
> needed_size: 0x0000000008c00000
> trampoline_32bit: 0x000000000009d000
> Physical KASLR using RDTSC...
> Virtual KASLR using RDTSC...
>=20
> Decompressing Linux... Parsing ELF... Performing relocations... done.
> Booting the kernel.
>=20
>>
>> --=20
>> Regards/Gruss,
>>     Boris.
>>
>> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG N=C3=
=BCrnberg
