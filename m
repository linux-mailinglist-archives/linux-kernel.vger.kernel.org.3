Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146DE492FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349454AbiARU74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:59:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:55586 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234205AbiARU7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642539594; x=1674075594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fd++KKBLglQbNWG5s/wKD9/0w9mUvAkn1uVB38VJNBM=;
  b=lwIKYCn9HgiG+9v7ItkbCv0Rc14wN99mFOB64JOlfKJudF4k9L/LPOC1
   FrAmYJdlBpfbE2F+G+JTQvuBiF492ICEqWOEtnF5uShzx+xS6gq+vd0Hf
   WsmD9yINygWaNdi8s/pj3EbDMh615VsqHgxx6bxcKI68tYXxuOaNlLPJc
   +UeYq+Tp8+PNjnoMTuEx7jf4aii6t4OWYBJkoNb9el41S4MUmNL4+YTSU
   TOhio0KZK7mRJSqY68LXCCBtZnp9q6dM2LYNqj6yZXzzq2F/OJNFP9BEP
   zRiGAn+I+hFcxmR/ciwFMtLCNijIHUHz3+L/m2M3267tqgOeNU99D42V+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="224891323"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="224891323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625636433"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 12:59:53 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 12:59:52 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 12:59:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 12:59:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 12:59:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiTQJw760HTz8ZWiHd8CbZZzTaYuspihwA9BlkfjEQxG6AhE+xysUUHWhOxm681s4NDzZFYbXisdOIjnSgB4v+udj9PefdfHgwzBwkE+CyZ0+aCuxpjyj8mhRPTK1cyh9t1SUya3WYFLSWI7LIYObcz6IfRwNagnWfznmTAkjKSEYHX5NcFXjl32GVBVITlCeFTAXyQvBemHaSDIqMr9+LS2d6AEq/UybONN2BxYU8a4ckHoI57927CxBGXd/uMXDNoZ70wOwo4Oj/e1/gkDocHLqxRTLWz0K8fi22cJpJHsKLvru/2DKgoFXKwpMUrb+KZiDwvA2kJVXs9tU7xnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP9LFo0HWDaArGr2gt5Rw2JAVABvA0AP/QwjNGjctLc=;
 b=DKBoqFp0DxtjFtqRiDRH6HuKodwIBZKWwEzpM9HXyEvpr8bfX9CNKXaU25caXTyV1dTq8GoCT8w90sHWP3d1LjpGRSCAqDfVjHQeVjvX5LOtcrNRvZIJfezC+P1IErJSMavNy/ri2faBryqef/KpIvDsoBrqS5maXhp0d0mZPDkyC3nDi4EBjS9hgMNsjV/WmoNvSsCOnoeeBzINQDmxHaFzZU057uLjvEJ2n2Dv7HykPUbfqKy+lIM3Aa3PF/jXvwrob5ngRn6J5Lok5lSU8vU0Lc1OIqPKyH9oLpqb5Yeu2YfnXgIdoopMGHqsF++xj2aPyHtfU6ouiMfA9b7yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB3550.namprd11.prod.outlook.com (2603:10b6:208:ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 20:59:44 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 20:59:43 +0000
Message-ID: <eb696213-b066-0b6f-19ff-dd655b13209c@intel.com>
Date:   Tue, 18 Jan 2022 12:59:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nathaniel McCallum <nathaniel@profian.com>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com> <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com> <YeIgzLzPu0U8s0sh@iki.fi>
 <YeK2hFcy72tYL61S@iki.fi>
 <CAHAy0tT7+AwgQUtzndj1E99hVcHNmyk2xJ6wUSxa4oPYytAMzA@mail.gmail.com>
 <YeYe/gGQbtTAXxLe@iki.fi> <YeYkdUHt7/HsRsZq@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YeYkdUHt7/HsRsZq@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:303:2a::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b56cb4-186a-4fdc-3b6b-08d9dac573a8
X-MS-TrafficTypeDiagnostic: MN2PR11MB3550:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB35509F86022E4CAEC5B851A9F8589@MN2PR11MB3550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrIzhwFLfxpKmJmZbvpmYCRCLp6OB2y2SqWhSCBFOsDl7MSMsAuOdUqb+Qcbgkvh+z94u8EFTcKMUbbNgaS2wvyNW7FqyFD3721JiRPWuOnpi8IMSAu2tePFyFIZZegiCS5StzC0Hdb6zRuJQnKhFDP1XA94q6szCv/Bi3so30UcnOJQa0Zjj2nlvcaqeamrnO0T97fR1n2cDy+CLg+GPuHiiUCKqVqKsdfWrESXY85L9BOfEkmbQ6yjBMyfV/NERPSORsHimrr8bJaAYzaT5oIeU6BJY8FNqRxvvrTFePsXexrid0peQo4mFDebwjx+uXOshDg7B1GkKug+rjDy4Ffttfz3eXxmn5re+/IJhWD+II69+465pdm7Dv3V2WywFiqnMT+wXQWgSf/JBQSGEVC+FvZuDyF9W+T7barsbp3OLzwdyS73xW7etKTQNWlSq9WVjgtLtnjUqSm5K+3hWl6Rs7X3/ajCf1wBuexzXW2V1Ds8Ib7pnmHKfPMH95nvNhf09LnbfR3+MHI5PzTaF8jz0NfYlkn+/srSjofqC8K48YUCG6TCUAy1wI73Eoxq4NB64Ml2AWWcqD4fbgzJsxUlzfvFaUG1DsRwBevO16dOZZ2BV8HlE7m8HevtNEpxQ1xnAwVG+ebYcBl8PU9DgtUi3KMbVowK4OkLir0Aq5HrT8RUIbBUSa5sWr0DLPUsz2zdkFbAQp9Mpo02PuAz7IsF3PUCoty28D4MOzt9ZgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6506007)(66946007)(66476007)(31686004)(508600001)(86362001)(53546011)(4326008)(186003)(2616005)(6666004)(7416002)(6486002)(38100700002)(8936002)(44832011)(2906002)(36756003)(5660300002)(8676002)(26005)(6512007)(54906003)(66556008)(82960400001)(316002)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5zcnppeVlKaGdMS0diQU92ODRqQnAyTUFTdEdqdTVsVmk2bWpTazhIekVx?=
 =?utf-8?B?bWxNTDlGYS9ONzRaaklGZFZ3RGI4dG9JSGc3WmJycWI1U1FnLzRjUndhSVNK?=
 =?utf-8?B?Rk5KbGVvdzY5ZXR0WTdvcHc0OXFUcVlHL200bWpJdjBOWllkNEM0Qm8zUlNy?=
 =?utf-8?B?cDVXSlQwbUxTeXhQa1RpR3dkRGhXS2JrTUhSQnc5cGJWRFA1R1prSU9mZzZ6?=
 =?utf-8?B?R29TRGI3KytWY01veUJmdTQyN3J5VzVTYWRaNEFhYTRRb2EyMGc2UzUrVG5h?=
 =?utf-8?B?UmxBMVNHRG0wcFgxVUtvQlEyWFRHMnZDdVhBY01SVmdxNFJtc20wdjJKbWd1?=
 =?utf-8?B?T2Z1SEdTVjRtT3h2VVFpVVQ5S2xWN1VYeGFTRmhQZjlETzZObm1TVHdIUm84?=
 =?utf-8?B?YWloVlI4Mm9LS2lPa3JFUlJWWG10UldUa3g3RHhGZFllYzF2L2J6bzd0Ujd6?=
 =?utf-8?B?ZmRObTBWSDY3RmxsN0pLT3lxQUxsaWt4dXYyOHNtakdkTlhPUTNWN1hhdFFl?=
 =?utf-8?B?c2ZKYmVVRGttYyttSk5NdGJoc1lWbUdVRGRyVzhWVytQNzMyaHhCY1E3N2JC?=
 =?utf-8?B?bW45Zkt5V3VuRHplWjRCbERza0dMcXdaNHpBVnhOL0NqWW9veXkzT0J1Z00x?=
 =?utf-8?B?cjZMZlE5OFZYdTlXbkhtcXA0dHMvaDBhdUl4cFBlYVFRaHoyRTd1WCtGL1oz?=
 =?utf-8?B?ZVhMeFl3S1k4c2k4MlliK04wZktidjE0SldTS1B2aXNsbWhHM0VZeTFxNlBF?=
 =?utf-8?B?cHZqMkpFUXVNUDB1cGxsK2FNakdlcEZqVmJoTjBpS1dYeW9JWFpYbnlMOHR1?=
 =?utf-8?B?T0FhY1ZMU2ZWSjh6bFZjRTZaR29PSVBWREdhWHNWQlV2bXlpZGlDU1d6NFRv?=
 =?utf-8?B?NUtESVB4RkxhbTMxeE03U1lCRE1nUGxnbUVrWE5VT2hDUDJMQkJiNEwza25a?=
 =?utf-8?B?eXNOR2hRS2puWXdNSG12eFRmY3E1U3hOc2RuMUdnem4ya1M0MWlRWVFLaGVx?=
 =?utf-8?B?ZUxFSTdreFlReGxaRG1SVkNSZ1IrK2hHanlyNm1kZXFCQUl1UlFkYlNsOVBq?=
 =?utf-8?B?UklsQ2JaZnFTODNpSmNHeVZzVFVUcWMyc3FmQnpwbER4NldqUW5vYitvQWlV?=
 =?utf-8?B?OGV3MEtZOUVoTjZHaWlzOXh3UTFRVUlrOW95TGczVzlqb05OeXN2MmNZRGd6?=
 =?utf-8?B?WFMrUTZ1TGxvdGtVS1poY2lvclB6Sis5eWc0dXk4bXNYTEFrMmtTS1NZSU1P?=
 =?utf-8?B?VDllUFJaS3ZNcWtkcGdmNUN6UUJSTGw1dXpRZ1ZqaVlmWmJYdS9QL1hKOExk?=
 =?utf-8?B?QXk3RHI4N3VuWk9uczNYeTFrM0cyL1FoRW51VlRLMldDRGE3a0N3UHJES1Nx?=
 =?utf-8?B?Y2pOWGQ0SmpBUjk4cGg4eEo2WTdUY2VUZTFkMWRWRXhzTTQ1aUpIUk54NXdG?=
 =?utf-8?B?YmpxL1hBTDdLSjZORzhHWUpSNEdPMnpnSzlFWlBGVitCNEdTZUg1NjluWC9r?=
 =?utf-8?B?N0paK3dUQlFta2E5a0ExNGtTOGpJTkd6R0lrVDh6WXV4SFlDS2NRODRjVUpX?=
 =?utf-8?B?b0kxemZERHFOTHZRdGFvbjdGb1pjSHBDSmhXUDlSR3BmNEMzOGZnZWZyMXIr?=
 =?utf-8?B?YnArVXA3ak1NYlF4eDQ0Z1pmYm9tUGhRT29tR2ZpcXkxb2NJOWo2NVZzei80?=
 =?utf-8?B?V1k4MklDanVaL1RIcXdIZUUrdHd0T1htT0V1ckd6SzVadlVYNWI5cEovb2RT?=
 =?utf-8?B?MFYwaVhYb1ozMXIrcURGRGZzcGRaK0xKb0dKcjVudGQwUk9kR0xpRkF5VEll?=
 =?utf-8?B?WnZ4SXJPb2o3Q1p4OWNXVnRteTZMNmtOa2hwR01XY2tqRGp6YWdEK2ZzTzU2?=
 =?utf-8?B?eVVLV0ZNODk5MmlEbmREc1lJc2FTRjZzVUc0UFNoY0VZR2xnNEU5Z3NnTy8y?=
 =?utf-8?B?Y2tFVENpcG11bUdIOURnYlZmOGZXYXYwNzczVDZMOFVVdmJzR1U1MU9mSmhD?=
 =?utf-8?B?cWdCN3ZYcmhXdTA2TmxSRVliT1YvVGdDbGpZNnliUi9nQ3FuQUFnZm1Vc2tv?=
 =?utf-8?B?blkyV3pIc2NiamRzempReEFkNElKbjU0QThBbDVUR3RlYnpVWUtBOEZyRFFC?=
 =?utf-8?B?QUYxRjBHaHY3M1dmZ0dSY3hKc3FJcHV0NEprOUVPOExSVzZlZ2ViMlRkK05C?=
 =?utf-8?B?RDRsb2FTTzFDNG14KzF0RGxXTFlKRk50VStjMSs3eTJnSFVJcGJISkhoemhK?=
 =?utf-8?B?TmI3YWFzdm16ME9xTkR6amhBN3dRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b56cb4-186a-4fdc-3b6b-08d9dac573a8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 20:59:43.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnubZ56jKRWwerY/aaAzZThY4zTijFBf6s6ZsDUGGqdDBUU7g0+HHDVz2FAKxfrxCFoiuuArSlKAIOrtMGNpk/8ghJcIIQvBHSOJHGzXlJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/17/2022 6:22 PM, Jarkko Sakkinen wrote:
> On Tue, Jan 18, 2022 at 03:59:29AM +0200, Jarkko Sakkinen wrote:
>> On Mon, Jan 17, 2022 at 08:13:32AM -0500, Nathaniel McCallum wrote:
>>> On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>
>>>> On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen wrote:
>>>>> On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
>>>>>>> On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
>>>>>>>> Hi Jarkko,
>>>>>>>>
>>>>>>>> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
>>>>>>>>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
>>>>>>>>>> Hi Jarkko,
>>>>>>>>>
>>>>>>>>> How enclave can check a page range that EPCM has the expected permissions?
>>>>>>>>
>>>>>>>> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
>>>>>>>> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
>>>>>>>> time the enclave provides the expected permissions and that will fail
>>>>>>>> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
>>>>>>>
>>>>>>> This is a very valid point but that does make the introspection possible
>>>>>>> only at the time of EACCEPT.
>>>>>>>
>>>>>>> It does not give tools for enclave to make sure that EMODPR-ETRACK dance
>>>>>>> was ever exercised.
>>>>>>
>>>>>> Could you please elaborate? EACCEPT is available to the enclave as a tool
>>>>>> and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).
>>>>>>
>>>>>> Here is the relevant snippet from the SDM from the section where it
>>>>>> describes EACCEPT:
>>>>>>
>>>>>> IF (Tracking not correct)
>>>>>>     THEN
>>>>>>         RFLAGS.ZF := 1;
>>>>>>         RAX := SGX_NOT_TRACKED;
>>>>>>         GOTO DONE;
>>>>>> FI;
>>>>>>
>>>>>> Reinette
>>>>>
>>>>> Yes, if enclave calls EACCEPT it does the necessary introspection and makes
>>>>> sure that ETRACK is completed. I have trouble understanding how enclave
>>>>> makes sure that EACCEPT was called.
>>>>
>>>> I'm not concerned of anything going wrong once EMODPR has been started.
>>>>
>>>> The problem nails down to that the whole EMODPR process is spawned by
>>>> the entity that is not trusted so maybe that should further broke down
>>>> to three roles:
>>>>
>>>> 1. Build process B
>>>> 2. Runner process R.
>>>> 3. Enclave E.
>>>>
>>>> And to the costraint that we trust B *more* than R. Once B has done all the
>>>> needed EMODPR calls it would send the file descriptor to R. Even if R would
>>>> have full access to /dev/sgx_enclave, it would not matter, since B has done
>>>> EMODPR-EACCEPT dance with E.
>>>>
>>>> So what you can achieve with EMODPR is not protection against mistrusted
>>>> *OS*. There's absolutely no chance you could use it for that purpose
>>>> because mistrusted OS controls the whole process.
>>>>
>>>> EMODPR is to help to protect enclave against mistrusted *process*, i.e.
>>>> in the above scenario R.
>>>
>>> There are two general cases that I can see. Both are valid.
>>>
>>> 1. The OS moves from a trusted to an untrusted state. This could be
>>> the multi-process system you've described. But it could also be that
>>> the kernel becomes compromised after the enclave is fully initialized.
>>>
>>> 2. The OS is untrustworthy from the start.
>>>
>>> The second case is the stronger one and if you can solve it, the first
>>> one is solved implicitly. And our end goal is that if the OS does
>>> anything malicious we will crash in a controlled way.
>>>
>>> A defensive enclave will always want to have the least number of
>>> privileges for the maximum protection. Therefore, the enclave will
>>> want the OS to call EMODPR. If that were it, the host could just lie.
>>> But the enclave also verifies that the EMODPR operation was, in fact,
>>> executed by doing EACCEPT. When the enclave calls EACCEPT, if the
>>> kernel hasn't restricted permissions then we get a controlled crash.
>>> Therefore, we have solved the second case.
>>
>> So you're referring to this part of the SDM pseude code in the SDM:
>>
>> (* Check the destination EPC page for concurrency *)
>> IF ( EPC page in use )
>>     THEN #GP(0); FI;
>>
>> I wonder does "EPC page in use" unconditionally trigger when EACCEPT
>> is invoked for a page for which all of these conditions hold:
>>
>> - .PR := 0 (no EMODPR in progress)
>> - .MODIFIED := 0 (no EMODT in progress)
>> - .PENDING := 0 (no EMODPR in progress)
>>
>> I don't know the exact scope and scale of "EPC page in use".
>>
>> Then, yes, EACCEPT could be at least used to validate that one of the
>> three operations above was requested. However, enclave thread cannot say
>> which one was it, so it is guesswork.
> 
> OK, I got it, and this last paragraph is not true. SECINFO given EACCEPT
> will lock in rest of the details and make the operation deterministic.

Indeed - so the SDM pseudo code that is relevant here can be found under
the "(* Verify that accept request matches current EPC page settings *)"
comment where the enclave can verify that all EPCM values are as they should
and would fail with SGX_PAGE_ATTRIBUTES_MISMATCH if there is anything
amiss.

> 
> The only question mark then is the condition when no requests are active.

Could you please elaborate what you mean with this question? If no request
is active then I understand that to mean that no request has started. 

Reinette
