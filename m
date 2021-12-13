Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C0247379E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhLMWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:34:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:43679 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241318AbhLMWeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639434876; x=1670970876;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QCtI/j477KqUhYeJUHzUQypPMSl6I5fzKGk6poXXkxo=;
  b=mnLFkMbhQ6FfFTmFa12FtoWzfI1gP1WZ3yF9gZJ5I0+q4nratGyC2KEX
   /cQAbJjYqWzUKcfIFmEdb4XQWhiRhVc8IN4/OQyO2QUdp8mOiTl78TqMM
   oqsif8qDX/lOVwg2djHFSlxNz/lTs7Jh25/Mb7VM/NQxi3d8c4HuP6u5A
   mCEgiDghN1SJpHbGX4kATPkKNE+LQTyX/fm5l/HTMdS59d4W0rA251dky
   MwbAn+au9Vxgcfv0jzvWPOSz0XDqzuYEp8c66T5laoFZe0/cxunT47lbC
   +ZbFqrmtya3PnpDwRw0hidgTYudJmbyljtjzQ2CQGQH9G03mu62kWILfh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237581049"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="237581049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="518915352"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 13 Dec 2021 14:34:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:34:15 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:34:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:34:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfNUnMKWqIMD8s+fLYkovybx5fKFr+GRACRAJTASxCXLcfxbAMF+aQExNzxNu9h9MkQtM6qYggt1jpkQBKpjLAz3Em0y5/zKQTHPFjqiFvrK9+cHNDesgvTDua1gNt4mzdrKBYbN/+QoWVbY+a1J1sw1HLvEETxAqhtQNQMWi4cNx4CISkfSbefWmS2lNel40XnpA/JKZYOmfjn2c2m1UFLn1kY0U+9c+K4x8QR1Le9RrvVyjbIu+iW0dUuuAFIISqOms3YklEgYiMGj6v7jO/NHais+LQRMjfDxbnxCzDogMyBxLvJK34BX5GPJOXhDpzRJN+2tTGcmQM2VH0niWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBw+pDyIIUVQ0J/48E0Go9+gjdSTEueiQr/kyW/wxXM=;
 b=KwCiacCBH/SEsd8PwKZCAfdHDcjrfRqcG1uCz+yvAaEhJUrMtaw6tOZ0AN60vIrjqHBS39dcnmYw1IGg6GkOqc9PZyJQLUpQFyWZLcZxWglFmy5d4urhM77EU3nUEnGOMSdQ/8wRXcG+pNlvgoDq5O6PzNAPQvtr9RVaC/r5vyRNzF14NWbPu7cGB0fhfTAKhUfOs8iRHA2tkWTWVg+6ot5ZhZyAo9iFVkc60indctxfmP/R0I7z2oDDBVC39bD168fpUWZ5er14Fwe3NiR2/azNb6UGpPeUb4eXQI3rDPLMfR7faFTMbguwdO3n7goGs/xq257Z5zOFM58b5K11Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBw+pDyIIUVQ0J/48E0Go9+gjdSTEueiQr/kyW/wxXM=;
 b=yzXKZIGZmdrAvuvVaBHTPkr0pZEFo8dM/LVA+grYznGr9bEMiIZyurcBHZg+yYkzLSlb5n3vc9x6F+1gyXZoy3tkn3963gJy7KLhAZ40XmpBR3mEwrdJ80XMv9wRlPPU9+EBeR5AdTCNehRWqJxCSgQUp3jTpxos6T1hBb3cg3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1905.namprd11.prod.outlook.com (2603:10b6:404:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:34:10 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:34:10 +0000
Message-ID: <c091ee8b-04a8-9165-00c1-835bb520e240@intel.com>
Date:   Mon, 13 Dec 2021 14:34:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
 <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
 <ea7708f6-a4c7-9f00-3c69-39cae0c7ac86@intel.com>
 <67993dd0-827e-5f08-d853-4fb0273adb5f@kernel.org>
 <855ab0ac-1e9b-dd3b-63ec-d15d0f0fda77@intel.com>
In-Reply-To: <855ab0ac-1e9b-dd3b-63ec-d15d0f0fda77@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:300:d4::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b2564e-5c52-4cef-f868-08d9be88ae32
X-MS-TrafficTypeDiagnostic: BN6PR11MB1905:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB19051AEAE8CAC25675B923CCF8749@BN6PR11MB1905.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlSqsZCtDEBYzGp+yFZCaUX+rxDJCZ+G90NWO9ZkYHlBv4dCnXq/O+QpAyxzeTcXjbnWrj40YEWwg/V6uuuDnAm+qr3pCRTnmF3IJZ8X+F2shxJRZXpUj4pPdPN5WiE/4vG2pP3M4/iXrkpBZGa+5VjcR1BbNrBgsQUedutn8mb6ocYC0PEqg4pyqF0Ech01cVeenrppc/QC8nHEbsMa6l5fNayO38j6caVua0EVfO+Q3uYIlOJn0RHF/pWftYa85hmfD9Vf0nawdmXI9wKhAAhfzXHGJepqnNpNiHYmQv8olmyxaX+vuzmV2q0gFceWCGCM1z/IGV9L3hgWtE6KIxd2qdo0p8ew6uI0WwCBxIM/8mWrjAiZqVW9xPPSACLWHQ3yvR+OO2ZpiG5H3cqEUd5FzWcVyEigfbcQuO/7dFHFKsA0rYRAsPB2o69w4/l6agNGc5ZN83UJzfnR9eNSpVy4FUSJ5/8i5S7kbY0mNKrCHkRF7bsnDboOUkkzaTfhAUXUW7tFEEqCmv2w9bUjwQIcWillIU2Aql/aGYlFlXzTX9jMdkjW3kO7DkZWwUpLyBjdFZFkOJtHRyzoebmgAAuMHGfGiBuR1qCn+YUQVoR+R9CsrQ7HV39FbHJw/ZYJZImmPpHy+SuJ4EwQwbtV2HUSjwXyjpFNZ3iB0mZ/M9q34uZJXPQskUQ28h1qG93Asyw9y5sV4A6ytaZ31tM32fBTsYo3blhAJhjE9EUYFOtUoxmZfOPXpjENtEn71gtZza0FGYVbNjridBaqS9rm5uIDMDNZqh2SxPMEj/6YSQlBnXA8xasHQM+iZ/DBqYxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(82960400001)(86362001)(2906002)(8936002)(31696002)(26005)(6666004)(44832011)(83380400001)(6486002)(186003)(2616005)(6506007)(66946007)(66556008)(8676002)(66476007)(4326008)(53546011)(316002)(966005)(31686004)(6512007)(7416002)(5660300002)(38100700002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdDdlcrN0tqRWJsSFYxV2xIV3pZOURjalRVcUZ3R2pQTGwyTTJUOUJHckZq?=
 =?utf-8?B?cDhXYk9zQjZsRE9TanNjUUplNzBpM2FuWFdqaEJYekxDejJTSlFuZ2Y5UHlw?=
 =?utf-8?B?NGVycENqbEh1bHd2VllrVmFUcHhDZHNNSUcxZFlQcTNyMTBOU1VCRklobVVq?=
 =?utf-8?B?dU9mcmgrN2ttMDBaZTBRMEpqVktUY2owSE1JeVJZM2dmUjhNbVp3dWxpOHpu?=
 =?utf-8?B?QjhMVkVQSHVLRHp2aG84d0RTeFJIdzlEQWxPWFAvWEw0ZnNwR3VnRTBCYU5M?=
 =?utf-8?B?UTBCaitCa0xSYkFIUTZWZktReWVsdzRaWWVMQ0xzNzQvUUJ6YTBIY3cwelpz?=
 =?utf-8?B?NmhTdUJ5dCtyWW1GZDhyV25YYzB2SVRmZEdoZWNjVVdBN3M0M25GMVVXV2Ew?=
 =?utf-8?B?dk12ajRRM2lGY01XNU1VNE5WT00vZjNKTTQ2cEpvb2F4T3pCejZmQjFqK25U?=
 =?utf-8?B?cDRNVy9SQytLM1BXK2VOU2Yyem1rbHMvQ2FWc1RsS0x4ZEs2ZzNqWkJLRkEv?=
 =?utf-8?B?alJTZDU4SmZJOURzVWUzdTRidDQza1A5TTd4K0V0L2lXYlQrZGtiSndQRGF6?=
 =?utf-8?B?NnBKMTltRmFCMVQ4SnV3bXFQaFFDSE1HUHNQYUtlZ0psK1dpRS8yU0JyNHpy?=
 =?utf-8?B?TE5nQ1orc0U5TGdFdUozSkxDSGpndHllSXFLQTQwVXFwR0J5SVl1RnZHaUFw?=
 =?utf-8?B?NlJ5U0kzSDNLeWxtYVorcU1LcXZoS2lScTBFam81QzY2SG8rM1hoL2FXNEg5?=
 =?utf-8?B?ZXNKTFUwZGZwOElRRWpXVlVHZHB4c044SHZ0UnVEanhjNFRTQXNwSDE2OXVt?=
 =?utf-8?B?MkM2WHNjTmhITXRkTWdzbGVpa0ljWHJ6a3ZUN29McGR4ZE9TdmQ4K0ltRm5L?=
 =?utf-8?B?dkxCdnNxVlc2ZXJuV25RL1BQS21RU0NJYmUrWVJNTGhibjdraDV3OFEwNmJY?=
 =?utf-8?B?SjNUS0NvcnQ1OWo1YmFRYUp3d1ZvYXpiQS9xNlRSeE9vaEFJaHE2c3dwZUE4?=
 =?utf-8?B?OWdHVXU3TmlRUjIxSVhDRW9zdkkzVEM4bUpCOFI0QWNIbkJhYkMvK3RibWU1?=
 =?utf-8?B?dTR3REttd0dhVGdjOHlUd2h4Y0UzSnZCWE9FeTQ3NVJta1l6K3RmYU94TUxi?=
 =?utf-8?B?ZStQc1Z0WW5SU1NHMkZxK0FKaU9PWllVdkFwcVdDdkFjTTBHbVMvY2lYdUVF?=
 =?utf-8?B?UHVkcTlqTjFvdTA4NVF4OHNoaXE4ZW43dm5xTktrRjVESGpaR2xoVVpaNXhD?=
 =?utf-8?B?V2tzVnV4bGlvRDJQOWd4YllsTlVIWmM3SWR3SzFpQVZhb095SThWOVE2R00w?=
 =?utf-8?B?dm5PblBNTUlUdnBVcEFpOTV2cHhUemF2K3RCMCthaG1BeklUYzdrazUvcEti?=
 =?utf-8?B?MmFWLzdZLzNoWXJxSkpwb2o4VlBEc0F5b1NZV3NLOWkxbXBWM254VFFrZXY3?=
 =?utf-8?B?UnlZTDNueTYrUTZXQUVJektBc0xmY2tCRmMwSWNybG5VSnRUU2E5blo3bXhp?=
 =?utf-8?B?enlGYmdJRHR5OVp2b3RCcUlxSFV4MnBrM0hPY1VSaTdneG1hWDRYNys4aWUz?=
 =?utf-8?B?TzFZNEFDZDVtaDlHNGh1dUswbTllZ3ZORUJ6ZWZtbFgzeno5Mlk4T0ZFQ2p1?=
 =?utf-8?B?Qk9aZkk1Z3JVR0FIUXQ4M2xPUGs2d3YvRHlabU9XRldoa0djYkJLd0YrM0xj?=
 =?utf-8?B?b3dXdDduOExHQndvajdZbXVmNkZETGducDJtR3RKOUYycWJDYm1tTjhRTS80?=
 =?utf-8?B?MXZkV0NMN1pxSU5VVnBsRkxaREp5ZDlKM0l2aTdwdDluTkl3N1lNRzJiU2pw?=
 =?utf-8?B?SnlORUIxcElxaE4yd2xxb3RRbmdBLytzMWFWRTZtK2dsSllYY1Y3cVowTEtW?=
 =?utf-8?B?Wk5DazZFNVRtLzRqZmdQTiszbVdMdS9PMWRmOGVyc3pGMVd6NDl3VXVaV3FQ?=
 =?utf-8?B?Ly8yL3c4WlB2N2JMMVJRUSt5UkRUeUNFWFpUSUtIaHg0Q29oZGdKWXd2WjNq?=
 =?utf-8?B?NXR6aFQ1VXlsQVpzbWUwWFYzUmhQbW1JSzE4VmdqMlNCVmFBazZKelMycjFq?=
 =?utf-8?B?TUdpWnRSbjU5RGtQbTV3Y05xNjA5dXlwa1ZrN3F0anMyNVpONVRoRVlxL3dQ?=
 =?utf-8?B?V3BHQ21pN29pRDhiRTljejVEVzFLQUlWUmpWRytSU2hHZW96L2lhZ1FVYVpV?=
 =?utf-8?B?enltK1Jac1d2Zk1RaFZMc2FNWkZoUG1IcExwUXBxMjV0dFc1azFiZE9GN1Vq?=
 =?utf-8?Q?DsEVwZHtUeuMExV0KCT5EoGokxttziLvJ7ER/FKCdk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b2564e-5c52-4cef-f868-08d9be88ae32
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:34:09.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dB1yko1tDzxbh2DsbLZBFP83f7fZetjBbCFsbBq4QB6LBQmJwFXTy/WnjMjoII68Uz7/12dNO4EH53clcu+JNwxrs3erC1egMOkLrGfrW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I would like to check in if you had some time to digest my responses 
with a few high level questions below ...

On 12/4/2021 3:55 PM, Reinette Chatre wrote:
> On 12/4/2021 9:56 AM, Andy Lutomirski wrote:
>> On 12/3/21 17:14, Reinette Chatre wrote:
>>> On 12/3/2021 4:38 PM, Andy Lutomirski wrote:
>>>> On 12/3/21 14:12, Reinette Chatre wrote:
>>>>> On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
>>>>>> On 12/1/21 11:23, Reinette Chatre wrote:
>>>>>>> Enclave creators declare their paging permission intent at the time
>>>>>>> the pages are added to the enclave. These paging permissions are
>>>>>>> vetted when pages are added to the enclave and stashed off
>>>>>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>>>>>> enclave PTEs.
>>>>>>>
>>>>>>
>>>>>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to 
>>>>>> change the EPCM permission bits however it likes with no oversight 
>>>>>> from the kernel.   So we end up with a whole bunch of permission 
>>>>>> masks:
>>>>>
>>>>> Before jumping to the permission masks I would like to step back 
>>>>> and just confirm the context. We need to consider the following 
>>>>> three permissions:
>>>>>
>>>>> EPCM permissions: the enclave page permissions maintained in the 
>>>>> SGX hardware. The OS is constrained here in that it cannot query 
>>>>> the current EPCM permissions. Even so, the OS needs to ensure PTEs 
>>>>> are installed appropriately (we do not want a RW PTE for a 
>>>>> read-only enclave page)
>>>>
>>>> Why not?  What's wrong with an RW PTE for a read-only enclave page?
>>>>
>>>> If you convince me that this is actually important, then I'll read 
>>>> all the stuff below.
>>>
>>> Perhaps it is my misunderstanding/misinterpretation of the current 
>>> implementation? From what I understand the current requirement, as 
>>> enforced in the current mmap(), mprotect() as well as fault() hooks, 
>>> is that mappings are required to have identical or weaker permission 
>>> than the enclave permission.
>>
>> The current implementation does require that, but for a perhaps 
>> counterintuitive reason.  If a SELinux-restricted (or similarly 
>> restricted) process that is *not* permitted to do JIT-like things 
>> loads an enclave, it's entirely okay for it to initialize RW enclave 
>> pages however it likes and it's entirely okay for it to initialize RX 
>> (or XO if that ever becomes a thing) enclave pages from appropriately 
>> files on disk.  But it's not okay for it to create RWX enclave pages 
>> or to initialize RX enclave pages from untrusted application memory. [0]
>>
>> So we have a half-baked implementation right now: the permission to 
>> execute a page is decided based on secinfo (max permissions) when the 
>> enclave is set up, and it's enforced at the PTE level.  The PTE 
>> enforcement is because, on SGX2 hardware, the enclave can do EMODPE 
>> and bypass any supposed restrictions in the EPCM.
>>
>> The only coupling between EPCM and PTE here is that the max_perm is 
>> initialized together with EPCM, but it didn't have to be that way.
>>
>> An SGX2 implementation needs to be more fully baked, because in a 
>> dynamic environment enclaves need to be able to use EMODPE and 
>> actually end up with permissions that exceed the initial secinfo 
>> permissions.  So 
> 
> Could you please elaborate why this is a requirement? In this 
> implementation the secinfo of a page added before enclave initialization 
> (via SGX_IOC_ENCLAVE_ADD_PAGES) would indicate the maximum permissions 
> it may have during its lifetime. Pages needing to be writable and 
> executable during their lifetime can be created with RWX secinfo and 
> during the enclave runtime the pages could obtain all combinations of 
> permissions: RWX, R, RW, RX. A page added with RW secinfo may have R or 
> RW permissions during its lifetime but never RX or RWX.
> 
> So far our inquiries on whether this is acceptable has been positive and 
> is also what Dave attempted to put a spotlight on in:
> https://lore.kernel.org/lkml/94d8d631-5345-66c4-52a3-941e52500f84@intel.com/ 
> 
> 
> This above is specific to pages added before enclave initialization. In 
> this implementation pages added after enclave initialization, those 
> needing the ENCLS[EAUG] SGX2 instruction, are added with max permissions 
> of RW so could only have R or RW permissions during their lifetime. This 
> is an understood limitation and it is understood that integration with 
> user policy is required to support these pages obtaining executable 
> permission. The plan is to handle user policy integration in a series 
> that follows this core SGX2 enabling.

Are you ok with the strategy to support modification of enclave page 
permissions?

> 
>> it needs to be possible to make a page that starts out R (or RW or 
>> whatever) but nonetheless has max_perm=RWX so that the enclave can use 
>> a combination of EMODPE and (ioctl-based) EMODPR to do JIT.  So I 
>> think you should make it possible to set up pages like this, but I see 
>> no reason to couple the PTE and the EPCM permissions.
>>
>>>
>>> Could you please elaborate how you envision PTEs should be managed in 
>>> this implementation?
>>
>> As above: PTE permissions may not exceed max_perm, and EPCM is 
>> entirely separate except to the extent needed for ABI compatibility 
>> with SGX1 runtimes.
> 
> ok, so if I understand correctly you, since PTE permissions may not 
> exceed max_perm and EPCM are separate, this seems to get back to your 
> previous question of "What's wrong with an RW PTE for a read-only 
> enclave page?"
> 
> This is indeed something that we could allow but not doing so (that is 
> PTEs not exceeding EPCM permissions) would better support the SGX 
> runtime. That is why I separated out the addition of the pfn_mkwrite() 
> callback in the previous patch (04/25). Like in your example, there is a 
> RW mapping of a read-only enclave page that first results in a RW PTE 
> for the read-only enclave page. That would result in a #PF with the SGX 
> flag set (0x8007). If the PTE matches the enclave permissions the page 
> fault would have familiar 0x7 error code.
> 
> In either case user space would encounter a #PF so technically there is 
> nothing "wrong" with allowing this - even so, as motivated in the 
> previous patch: accurate exception information supports the SGX runtime, 
> which is virtually always implemented inside a shared library, by 
> providing accurate information in support of its management of the SGX 
> enclave.

Are you ok with managing PTEs in this way? It matches your requirement 
that PTE permissions may not exceed max_perm and ABI is compatible with 
SGX1. Additionally, PTEs are not allowed to exceed EPCM permissions, 
which is not an ABI change since it was not a consideration during SGX1 
where EPCM permissions could not change.


>> [0] I'm not sure anyone actually has a system set up like this or that 
>> the necessary LSM support is in the kernel.  But it's supposed to be 
>> possible without changing the ABI.
>>

Thank you very much

Reinette
