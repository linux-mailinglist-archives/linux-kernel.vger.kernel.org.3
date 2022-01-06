Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9BC486909
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiAFRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:46:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:53419 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbiAFRqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641491177; x=1673027177;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YsDl5oeFOmER23BHK4zA3nwxDtRHLyImcAMvGmmdv1Y=;
  b=Xr/1Uq7KsQMA+ajQKTk+Eqn4OlVw2V01p9FOXyaD377dxO3/PStqjnVj
   2wpBiCG4CXmZX/W5s25E53UrerHZs/s92xmNpMchQVWB2Fm66YXg7W48D
   iJ+9wDf/YyDYi+qZlC6x9OnzkZxjp4cDBokwFPAMet8D2jcwVhaIkuY1z
   OQt9k9NGusOfG9yLGPnpouiSAONuXg5RuDOh4z5OVOmy/N32LoNuHQK9t
   m8H1wrqzCifkolfy+lDVzdNvrue1w9VuQA+l6Ow8FlxviWicmbvpaQbLN
   riXEH/5b373qTUfW4ZntNtwzoILGu8zHV6vN+3yrq3UyQjw9NUw+ZfTQt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241519370"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="241519370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="621591620"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 09:46:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:15 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 09:46:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 09:46:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnI7vRIMtWUnIlcN/M/nqMgOaKU5MC1+/h4M55GLhOfnVOC5d/iw3VX8dmR8/Vyp9wolYiRdaeZKmzC6tL/6kAZdOONWH+FDfAEThYe/EW+NvNmQQW5V7pthyfhE/a8HcQl+fbd/d3I9AazpsbQvYYnsfdcq/HVXfMZ29BcQYKNzU3RIS8evh3EjWHAz+3/ueWzASdvM3JDU1NAgiCfEnuIBHDsw2sGnd6kMNqr7skEdKXt7fGmjblLxKEK2wr8GsBQ5dkZR9Wg8hHx08V1Oj3m4A6UvgDhdu+fFT5L5UmD4yGcw6D9VnYEoXmkX3V0T5IVPN07UnLVXk56IfUeYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd8+XihyAYUkGUsbl0HmUtMV5DfDoJnJkYHwuUZ/76Q=;
 b=UA8Nwef++so0z1HPnGABPbvp+fQKTYcIm5mMygFlZh4oliyBeD63zdluUORdH+Z7hoYcsklifoHYek11IQf86PMQ3wfyBREgEpwGLiV6x5D48ITlHgRCqRPN1i1w1pJQoBMsD/i76aTtULbZsKqHBGHjI7FfS2q2tltWX5zxYo5p1/nWGwpKgLpAkH74HWa0EipFDLO+IFNYZ0O6lDxZmYmEs94qwXRHGCyYLZ4qg5CsuAVkdcFEKw3xgQDLV1OGiR5ALKBsf4Qh1DVNKJquN26u19bdK9QdNXPAfKU8B7MXGxPnlnE3obHskcDQpun5TYHniE16YcbLVk5/Pq1UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2738.namprd11.prod.outlook.com (2603:10b6:406:b3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 17:46:11 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 17:46:10 +0000
Message-ID: <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
Date:   Thu, 6 Jan 2022 09:46:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org> <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com> <YcsklLw1uFyppSji@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YcsklLw1uFyppSji@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:300:16::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14280606-b965-42d4-39b3-08d9d13c6cd6
X-MS-TrafficTypeDiagnostic: BN7PR11MB2738:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2738911BE15A891C1422520EF84C9@BN7PR11MB2738.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YA0KGZ5/BDr5fWqu2Bswrx0M2veE5bghlGBjclBLWpKTUnAc6IVDhSluHOvYPEXipWq5gXvuLx+fvIzmZrRF2llfZ1O8CZhe0qVhOTzAx1Rmqd9Am9Lltr5jGXp1WRnT3RXGNIF3nii20I7bIWTNNpv10E/8iE1y9h2KB++6LJYOYCtl2L3BRP3BfORE0pwEgLRcs2JuCGoko/NHrqNLTnMOiSYtd7G/aRvW5+lzEauCW8nOK8W9vktgQKXkDrxZtLFGUTce6V2Muenx1yfcXqvnSBWKKrNt4wINX6CStPRvrqUdeLb6Nbxazka5LC70tt66hG5NzKarrq7ycyvkkW2H8XCEiBaCT1BG2ZGuOZQ0OANSkWXlvrOC87A//Ksihu1tx87BUHROPvKVmH2l4EDtRIPXlq1QYDi1ewbFl+8qcswy9C3cy6GYM6jJrIO/Znt+S5P8fLmesb1C/9PW1Anrz7gubMa32+sObK0sLVxRf8fOfJk8nvvA4+F1kpJOurq9YrjaEOYTn0d6sAyMWrAcrx4CqUqWOz0Pv6PEF8U2voIN7hZsvai7ZJwHEbXDUygS5Q0nS/k0iVHLEySsY5acqnSgOOpGJkLEPa6uqxy2HGdX+vpmCHCU0n6doWEEDA4hFTJq8KhbXUzHMBAogvaE8WlyndFL/G7+p6licvt7khtGdbv0NiK9gP/8nK1g9z5Juiqvlf8pteQsq/cpJhqMsB+HlTLTRFQxHHZ71rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(8676002)(6512007)(508600001)(36756003)(66476007)(44832011)(26005)(2906002)(6666004)(86362001)(2616005)(5660300002)(53546011)(6486002)(6506007)(186003)(38100700002)(8936002)(4326008)(66946007)(6916009)(82960400001)(31696002)(66556008)(31686004)(316002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmV6ekVFQ21hUk80clBkOW5EMnFXTHRrbjBqSXRJTEF3K0xzazM2NzEzc29s?=
 =?utf-8?B?L2pLckd6U1U3WEhWaHJ2dGZHVmJTT1NhYVVBWEx5TmhyV3ZSdG85eEp3ZkV6?=
 =?utf-8?B?SXhYMGNxVkdQMTdnb01BcHNoKzR2SUdRdmhvdVBmbnZXMjZqVSs3L0VNdFJR?=
 =?utf-8?B?V3pjY3Z2UlBtaUNhaGc5bzdNclpwbTJqN2Y4NHMrektiUTh1bG9JUVYvUHQ2?=
 =?utf-8?B?RG41dzJPMmRqVVV6QkNHK082RStrbmFBcnFkTHBTWkwwdlJVZHlMbkFZaXRG?=
 =?utf-8?B?aUhvTHJWTUFicW5ueGRhREcrTzRCM2QvRlBMYndkMXVDMUtiNmx1NnA2VXl3?=
 =?utf-8?B?T2t5STNvNDRKck9wODVWbWtUbXN3MzJpWi9qWU0vOXB0a2Z6dUxFNlRPeXJE?=
 =?utf-8?B?OTZmT0pOR3hjNWlLeFhDZUZqUGhuWUxDbmtTRTEvaUtObFVkdmxEUTdzN0hJ?=
 =?utf-8?B?U1QwSkI2bEFSNUVDZzUrbmVrM3hRZDlyODdnYkEwaWZzZkFPVElWY0Eyd3gw?=
 =?utf-8?B?bzI5YWw4YTNHOFl1Z1dVbnk3SFQweHgwMDFvMGh4ZXZ0MmpyVlFtT0dWMHRV?=
 =?utf-8?B?UWdEMGQzWTdGZGxCUHRlbXlTSDJNRDQ2cHBVNGRtYlZBZTBMNHNwbGppMGZm?=
 =?utf-8?B?SGY3ZXpmbC8xYm1ablVXem0zbEhCZjdIN1prQTR3dmNUUzFjdnBBZ01qa2V4?=
 =?utf-8?B?MngyY2FuT2NRQklPaWE3TnlnS096b3RIcjRERGd3bEY4bmU5TDAwNVM5WXFK?=
 =?utf-8?B?dmFWTDRPZ1NjK2hQaDR0TWJGTm8yOEJXT2NCQWRHOTRmNnhudkdsaHRZenpu?=
 =?utf-8?B?Q3hTSlJjcWp2RElwWUVpRmMyNGN6ZHl6RDlxQmx0Q2E3dytvOGZNOXlKbWxx?=
 =?utf-8?B?N2RNeERpcjlsQ1V4RkU4WnJNTlhlK0RIQjNqSklndCtMNU03MmxvYTVleHhr?=
 =?utf-8?B?bFZrNUVRS1QvcC95YWxkZlgwcXdkaWxDQVlDM2U5T0o1OVZINlRlKzdld0NW?=
 =?utf-8?B?Uyt2YVV6b1U4bTBtTDlhaDFJY2Fmckl4NUVPYjlYb3ZWL1k4cWFBa3F1bFlh?=
 =?utf-8?B?bW8wUkJRR3JaaVdiWk0zdVcvMlliNzRJTHovVThuck1oNnBMZEsyR0dDZmM4?=
 =?utf-8?B?UzZXSG1hRVpSaUwyZFF2cE5ZZXJDUW1CcWdnTFo1Y0Vvei9BRTBWQVNyQlJ3?=
 =?utf-8?B?bGZzQ1B3TEZMUkZ0T0M3T1hnR2dZclRiY0R0WGR1YVRXb212ZGEwSEY2MzVZ?=
 =?utf-8?B?dzlubWZyV1dOU3pLRzdrdXk2a2U0VHB3MzNiVDFaT1lxU2pSS3FiOFYzYi85?=
 =?utf-8?B?SW9QZlpBdU9kRVJpcDhDYzdFYTk0aUxjdi9wSVRkN0l6a0VqSXowM29IdDNo?=
 =?utf-8?B?bWJGdG9wNzhJYUNqaDYwdndZYTF5d2h5aHZVK2grcmY4OUhTQWhjdUFRTHQw?=
 =?utf-8?B?djlaMGxGcTZVMEVidXp6OVRBdk45V0E3T2k3R1pRL01MUGEvb013Tks1eXpE?=
 =?utf-8?B?SEFwZzBzYU9PbjJWNlR5VDhkemFJT2R6MGlwZG42aktPQ3c2MWFzT01ZWWFl?=
 =?utf-8?B?MFl5U255YmlNSng3QXc2TnV5NC9NODVBVTdhSTVkUGVMdkdKS3EyZDdRQ1J2?=
 =?utf-8?B?SFVLeXIxZjhIMng2NC9pQkxIeHhpNll6VXdMdEVyQTlDWEtWRFFxdmV5S1BI?=
 =?utf-8?B?Y241U3NmQ1NZTjF4OGxhMHBsT0tJVm44TVdjUW5PZk9KQzVjYnZJQWt2K282?=
 =?utf-8?B?T3ZJUXppZUZacW10R2YyL2djZU5pL3hGLy9LVUczakQrM2VJZ2szUTZGaC81?=
 =?utf-8?B?T0FLNzNDaDlWWEQ5ZWxOVWQ4ZkJhTStlLzVMc3hpK0FkTDlXamd6VUpLOWFL?=
 =?utf-8?B?VlpydDJKeWh4L0ZOQlR2Z1luaE5SVllzNFFWRDNSeEhVK1QrcUxYNUlId2V4?=
 =?utf-8?B?YkhzUlRTQ0hpS0UraFlacktmdU45MVNFeEtWRGVDeHc0SFlxeTdEemJSenFF?=
 =?utf-8?B?NFludUpVT1UvSUdRYVVwa2gwS0tXZ2VDdVhRcVBHcWNnMHVWK1NGY1F1N1NG?=
 =?utf-8?B?eWlPMWcyUnN6K1V4VG1YdTJ0a0RSUnZnVUc0d0h0T2xJaU1RaFVNNFRqUFB0?=
 =?utf-8?B?MHFEeXpyQ0JqSDhEenFnYzkwY295Uk9aUithM0VaQ3ZzM1ZBeEx0T1BLLzNv?=
 =?utf-8?B?cmdrR28vQkV4M1g5VStTcmJIMG1aL2xlMW5ZczRlekVUT05kaEVFVlBrbDdr?=
 =?utf-8?B?SVVqQVNZdEtGeVdqc2p2ejNHMG9RPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14280606-b965-42d4-39b3-08d9d13c6cd6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:46:10.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMJDBdFLuk3uK2WmHEcI2o3vYAQn7EMdLipm39xydIpIG23EK90AlQCfnNLy6tVcH8aYV8SDVzAwFVTcz8iN48ubJjyvYG4kTR+CTBrF+I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2738
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/28/2021 6:52 AM, Jarkko Sakkinen wrote:
> On Mon, Dec 13, 2021 at 02:10:17PM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/10/2021 11:42 PM, Jarkko Sakkinen wrote:
>>> On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
>>>>> This is a valid question. Since EMODPE exists why not just make things for
>>>>> EMODPE, and ignore EMODPR altogether?
>>>>>
>>>>
>>>> I believe that we should support the best practice of principle of least
>>>> privilege - once a page no longer needs a particular permission there
>>>> should be a way to remove it (the unneeded permission).
>>>
>>> What if EMODPR was not used at all, since EMODPE is there anyway?
>>
>> EMODPR and EMODPE are not equivalent.
>>
>> EMODPE can only be used to "extend"/relax permissions while EMODPR can only
>> be used to restrict permissions.
>>
>> Notice in the EMODPE instruction reference of the SDM:
>>
>> (* Update EPCM permissions *)
>> EPCM(DS:RCX).R := EPCM(DS:RCX).R | SCRATCH_SECINFO.FLAGS.R;
>> EPCM(DS:RCX).W := EPCM(DS:RCX).W | SCRATCH_SECINFO.FLAGS.W;
>> EPCM(DS:RCX).X := EPCM(DS:RCX).X | SCRATCH_SECINFO.FLAGS.X;
>>
>> So, when using EMODPE it is only possible to add permissions, not remove
>> permissions.
>>
>> If a user wants to remove permissions from an EPCM page it is only possible
>> when using EMODPR. Notice in its instruction reference found in the SDM how
>> it in turn can only be used to restrict permissions:
>>
>> (* Update EPCM permissions *)
>> EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
>> EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
>> EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;
> 
> OK, so the question is: do we need both or would a mechanism just to extend
> permissions be sufficient?

I do believe that we need both in order to support pages having only
the permissions required to support their intended use during the time the
particular access is required. While technically it is possible to grant
pages all permissions they may need during their lifetime it is safer to
remove permissions when no longer required.

Reinette 

