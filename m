Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B14952A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377121AbiATQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:52:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:13175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346704AbiATQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642697559; x=1674233559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=68wI2PBIzRXFGO+upGe4zPHq48bDcAT929Nh8Sc2RK4=;
  b=c0Ktp9mnqreX7hwALrDZ9waKKp+5kRKJ50w/MlbAVMeIF8+eVPbq5iNR
   axk3f6LcoOMh0Xz19GFYY7JaWKr/q/pFM1zxZxBczc45eNv/RilA48Occ
   /UIkyX/LeDq3Q5+YF9OUV5IBfcVSBkZIQ7MJNBreA/DeUDtLEq1IG5N3n
   8yXCXlFzg/oN/NW8Np7KMKtLB8sqwS0eW118Y6VLSeDMfQqA5uhmYvn0/
   e4BEP3iW1XHULZo4fw5kdPI0b6c9Oy1xEPNBsAZlInnGR37mvprTOkTdy
   iY60728BCZCIYUFmRI8XRtBFIp6HdJmeD2MxigGX7dY7e/4VAOuzQsKrw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="242960888"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="242960888"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 08:52:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="579257927"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2022 08:52:38 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 08:52:38 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 08:52:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 20 Jan 2022 08:52:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 20 Jan 2022 08:52:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB+wotdF0A+qvAqDFo65devcAtTKt6MIfUpc1B+7l0Sudd2wG3Aj8eSu9+KlUwrgC4YCCo9nm8VCsAPLoMVi8tnZc7V1L+t8LeWMD6+a+qGeg1y07+lAW9V+Zu1Ivo0k22dTNUO3ZMuEJiSSsoUcQzSAMpn0pOKf0v7Qm85yOWc8O4xZG7VOd2J2BjaAso5apoWcI67BdUhkE9sYt47wZ5dp76n8bQMEItQWvW9J8BZQD5y6te+2yvgdfo95MLKAhnfhOX8focQ+sxHA7oKxGkzDLITAj3lOolMtM4muq7ekgVJFQTJsfSto+YfNSblvLrKtRyDEIFZRI+hUUYgtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APtj1n5FrZtSPukLsq7n9bHORf0qkf8D27ByZtBiti8=;
 b=T8XVxN8DVBaV/fHa6bEoWmBzVaLaTMQBvosyG7Ivg2OLwg0n93VTnUNjRMyFeHnVL736VEtx0GNUUkkKrBK0oXNeShg7nexhEVAPBMNgZS3sUzQP29zciwkyX6cy0BXMfmyvug5nd5feC3lBWSP58siEa/QqhYDJ++Nic51F1tCaB7lmujxLgcyf00sjHoJHQSsFAMMefU6WaURlSE/+TILCkkm+4JkndltrI6RxcKvBmGDgL2scH3OO4pOQXkJm0yruwtnY8vyRPj678UoaveOrHApRGkxjW3J64iE7pwR/cgVo42jR/U9qbdcwip/I/vEZ+mnryreukvBemIeioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1800.namprd11.prod.outlook.com (2603:10b6:903:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 16:52:34 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 16:52:34 +0000
Message-ID: <41ae95bb-45c8-24f9-1e57-617f28ed4f24@intel.com>
Date:   Thu, 20 Jan 2022 08:52:28 -0800
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
 <eb696213-b066-0b6f-19ff-dd655b13209c@intel.com>
 <04761b2b4a77bda145a1fdb975da50da18c9d2d0.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <04761b2b4a77bda145a1fdb975da50da18c9d2d0.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR19CA0083.namprd19.prod.outlook.com
 (2603:10b6:320:1f::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e69116f-6c79-4d06-a082-08d9dc354198
X-MS-TrafficTypeDiagnostic: CY4PR11MB1800:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB18002E10380F3233393A159AF85A9@CY4PR11MB1800.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyZMpxjsl8rfQx0PGMwQtz43FQGWOmx0qK8RbOQ1JjCq02raSs6vimoWII9jZfjlwvVFuKTXPDO256yI2pj/PPgdEzomUzr+Hj0pKkgcePw2R3cmJaSxpn8s9+bnMqx/yq73jvGhTA7ukDl9qGktd+8gSIPtq475mTMNmVAiQoede8Ti+GgLRA/y+W8qCnLG8+VePPeelzcqhyGEIezK/LHMd6QHUWZgdBtP4DfG1dUcH1u4knStTqnvH/QdBsXgonR0QSu6XuZlCfXDeQOQ9kh27uWRQR1g+BrxezUV399g8JBOFk43IG72h8R4XgkzoW0NXzs5OCSF2byI4dwH9g0VtzZurvgHD/8K8Jp/EelCAXqQmqVtRR5+jFfpdl93LiEcVIorIPlPs3fUi9qOVD8pps3JWpN6S3S2nKxWB4EDBMM9GwCJsWaax/QMXsjYAJPjaoTcDmcPQ5SV4y+/ZVVJSoivaH+5dcmd+XBebmJSU2ldhIJ5Xavly6zcnUj0iHapA9qlBSGAxXdW7Kt6LyYHLJP9cGNT9quOTxhZ/FFo2N8Y6i8TB/YY9cjFk2xl8Z4YCcWTweQ72ENLX/SgOF/9oFSyOZ38/krZ+w9LEyY0nD5RaJ9K4i1iEsPDHjJnifgqg6yYAMesQsdOK9Y+zXXSWs+2CmFwSXJouDx0lacYxp6kGyIqvyPtQNJoESVSTHHswvirt0t8lKCEXnSnZm26qW+6FGg+B4I251wUlf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(4326008)(8676002)(110136005)(2906002)(2616005)(31686004)(6666004)(7416002)(186003)(44832011)(8936002)(6506007)(53546011)(66946007)(26005)(6512007)(83380400001)(38100700002)(66556008)(66476007)(508600001)(316002)(82960400001)(54906003)(36756003)(86362001)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhOQzBycUlTKzlFMVBmcEdMSDJRM1VZVU4rdGNJWk1NQ1crODFTRGQrVFlj?=
 =?utf-8?B?c0hHbHh4ODFicGhOSGZaOUpqRGFramZpQ1VlYjFKNjB6S0hsTVZOZkYwdGZT?=
 =?utf-8?B?bGdxZlVQVVRqbjJsd0pYNUQzNWVJejVJZHRqV1RkSkcrQTVxRzlNOGVFdGdv?=
 =?utf-8?B?KzZJMUE0ZGJPanBDQjBzTkFPNGJkRThEcXkzYUVVWFM0eUM2N1kwQmpoSVlK?=
 =?utf-8?B?SisyQ3QwYjBCaVAxbHgwbnQzQjcyK29xMjVPQmQyeVpYUWFpdTlOMmFrTzRF?=
 =?utf-8?B?MEI5N25WRGRYRlpwTDBQc2dYSGRxSXpGTTNwUkJiYk1KQXNpbEhDVmRJdUFr?=
 =?utf-8?B?cmloNW1GS2pzaENPeW85Mit0OVgxdXR6VkF2MlJMNFZLZGFKUzVTaDJra3ky?=
 =?utf-8?B?a05SNXQ1dHNsWEVmaFhnNzFpMVJicTh3QkhLNjl0d05CK2FHajhOV3Y1TEZp?=
 =?utf-8?B?Z0d2V1VESGVNS0JQbnlmSEFCemlHK0FFY2d1eGlkTkoyNUdTeHR6blJ6bDZt?=
 =?utf-8?B?VG8va1phaUYwZHdCWHFWTGY1aHRDRnBXaitNVSt2eVBxWllWOFJJdjcwM05P?=
 =?utf-8?B?eHYyeE5ESmx4ZkV2SUJoNlpNaUZya0NNeHMzLzNSY2JPL3hwNnZkMUVtVXBY?=
 =?utf-8?B?TUdKRGN2KzU5emJFcjcvbzZSWnF1ejFrZ1ZjMmhmSlpYK1RJMWovaUpOc0xZ?=
 =?utf-8?B?eVByUG5hU1dRb2k2RklFaDV0LzZEVXprMGlQc0RtdWUyU0IrSUhZYXlIMzBl?=
 =?utf-8?B?NmFCbTV5Y3p1MWlVZ08wZjdhQmQxYjdEZkNGMXkrUEk1bVVDZWdLZW15MDNF?=
 =?utf-8?B?UnJHdmRMdlZaRkV2NEQ5akQwYkJoaGp0TEM1c0cwb1NNY2NibVF3TWRhMUZl?=
 =?utf-8?B?QWliRm9uOVZiOGdrNjJZRXR1SzRNM21RUy9oYkw5WmpBMHN2R014Z3ZQemNt?=
 =?utf-8?B?K3lQMEF2U0FvUm45Umc1YTFVQTdIQjREaFExNUZvUEJyZm5jZ2pGZ09xcGRw?=
 =?utf-8?B?disvUjlrYmMySHdJK0w4Zi92aVpzZWVHU3dGSVh0Y2NQblpJd2t1NTVWV0Nt?=
 =?utf-8?B?anBmUmo0NDRCcmkvbm82Q2hDSDNreUU2R05WSW1ubFBTZDhBM0pNWVphY3dD?=
 =?utf-8?B?eW9ncVZucEg4ZGZKTVIvWGYzWjlieXMzM2NUOFlrRGVtSXpXZytHTVhPem9K?=
 =?utf-8?B?eG1nTWQ0QW5jdXFnblBxNDFJSmdBSWxINU1LeHZLUE9aWEhhOU5TaDlsYlFW?=
 =?utf-8?B?OXl1dWh2WFBaNGVWenE3TXpVZ2laRW00U3N4RGtMRTNaUUJFV0lDVGk4YzJH?=
 =?utf-8?B?aks3OW4yVENhaE9wMkpPQyt0Z3pIaXM1QTZZczhzc0xVZERJTFZ5SElkZ05t?=
 =?utf-8?B?NE5hVFlsdHRNL1lUcFBnN2wxTGdKRkhLTWtWVGpvblE0VGFZM0N2Ukh1Ti9w?=
 =?utf-8?B?S2FOMHhXV1N2cDlOVG93aU1mOHpYMEgyeVdGdHhBZmFMYjQ2Znp0QjhvS280?=
 =?utf-8?B?MTNRYUNHNDUyTEI0ejB2NkFNeHJGR3BEVWRoTjcvR2ZZMG5KNWpsSFBXYUR2?=
 =?utf-8?B?Z0t5Y0hzMkpSWUlwTjZPV2Z3NnF3Uyt4MC9LWlNnbEIrVzFwaXg4Z1REaWJa?=
 =?utf-8?B?bnhOejJoVXdYSlR5bWN3OUV5V2ZxZG9STVhVVmFsc3FadTcydVdYaVRmbjNv?=
 =?utf-8?B?ekNaV2RhUVJaQjhsS2tOQllabXFJdGkzbWpsY29td0xueU1NR3FPTzc5cG1B?=
 =?utf-8?B?cWJxSmJQNXRwMXFzWGI1Y0VDNGJBanRMck1sYjk1UEpHWjlqRm8xM1dXRnVj?=
 =?utf-8?B?aFk0bDlaeHBjNnFFTFBxZ3VOVTJyMmwzTDNqWUI5Z1JiY1hyeVN6RDBmMDRW?=
 =?utf-8?B?cmo4enJZYmZ6Q0F0MXpwQ2pYaUFKemVHZ0JWQ0t2dmpYaFlvNklpWGllbTFp?=
 =?utf-8?B?RVBqWDFtTkZnVFA5Z2FRNnBqeHNEelRtN05nWC9NK3hKMFV0SHJZamVwUFEy?=
 =?utf-8?B?aEQvVzllOFBRMFFRWi9kQzl4L2NlQTFoWHF5R3V5WG1nOTVTakVqRU1sZE0y?=
 =?utf-8?B?czFoTnc2elZQOGswRUUrQ1BQa1ZURUNHUU84ZWFtWUtOMTY1cmY2MVhqR3JX?=
 =?utf-8?B?TkNjVDVEaFhjdUxna1pkYVY3QVAxWk5MdnhUMUpIQUdYdlF1ZlFnWmZ4ZVg1?=
 =?utf-8?B?dldvYm9mSlorMFpzcnU4b3pXdG9rc1llS2VEN3N0NXVhUk1oOW9KckQ3ZTVj?=
 =?utf-8?Q?eW539YXWlsQl9XgFJS0DuR2Y+e5pF1R54T45e642EI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69116f-6c79-4d06-a082-08d9dc354198
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 16:52:34.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJe7TP3FkicaGH2dkb2BKPoCPqHVlV2vR6OO/e43a6YI5c4LIgrQpuy7QKgnIjoDQ+mE9Q/EIRLvvCfxZBmCohPkEHAb+Q819CZq4MR5Wtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1800
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/20/2022 4:53 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-01-18 at 12:59 -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 1/17/2022 6:22 PM, Jarkko Sakkinen wrote:
>>> On Tue, Jan 18, 2022 at 03:59:29AM +0200, Jarkko Sakkinen wrote:
>>>> On Mon, Jan 17, 2022 at 08:13:32AM -0500, Nathaniel McCallum
>>>> wrote:
>>>>> On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen
>>>>> <jarkko@kernel.org> wrote:
>>>>>>
>>>>>> On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen
>>>>>> wrote:
>>>>>>> On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre
>>>>>>> wrote:
>>>>>>>> Hi Jarkko,
>>>>>>>>
>>>>>>>> On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
>>>>>>>>> On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette
>>>>>>>>> Chatre wrote:
>>>>>>>>>> Hi Jarkko,
>>>>>>>>>>
>>>>>>>>>> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
>>>>>>>>>>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette
>>>>>>>>>>> Chatre wrote:
>>>>>>>>>>>> Hi Jarkko,
>>>>>>>>>>>
>>>>>>>>>>> How enclave can check a page range that EPCM has
>>>>>>>>>>> the expected permissions?
>>>>>>>>>>
>>>>>>>>>> Only way to change EPCM permissions from outside
>>>>>>>>>> enclave is to run ENCLS[EMODPR]
>>>>>>>>>> that needs to be accepted from within the enclave via
>>>>>>>>>> ENCLU[EACCEPT]. At that
>>>>>>>>>> time the enclave provides the expected permissions
>>>>>>>>>> and that will fail
>>>>>>>>>> if there is a mismatch with the EPCM permissions
>>>>>>>>>> (SGX_PAGE_ATTRIBUTES_MISMATCH).
>>>>>>>>>
>>>>>>>>> This is a very valid point but that does make the
>>>>>>>>> introspection possible
>>>>>>>>> only at the time of EACCEPT.
>>>>>>>>>
>>>>>>>>> It does not give tools for enclave to make sure that
>>>>>>>>> EMODPR-ETRACK dance
>>>>>>>>> was ever exercised.
>>>>>>>>
>>>>>>>> Could you please elaborate? EACCEPT is available to the
>>>>>>>> enclave as a tool
>>>>>>>> and it would fail if ETRACK was not completed (error
>>>>>>>> SGX_NOT_TRACKED).
>>>>>>>>
>>>>>>>> Here is the relevant snippet from the SDM from the
>>>>>>>> section where it
>>>>>>>> describes EACCEPT:
>>>>>>>>
>>>>>>>> IF (Tracking not correct)
>>>>>>>>     THEN
>>>>>>>>         RFLAGS.ZF := 1;
>>>>>>>>         RAX := SGX_NOT_TRACKED;
>>>>>>>>         GOTO DONE;
>>>>>>>> FI;
>>>>>>>>
>>>>>>>> Reinette
>>>>>>>
>>>>>>> Yes, if enclave calls EACCEPT it does the necessary
>>>>>>> introspection and makes
>>>>>>> sure that ETRACK is completed. I have trouble understanding
>>>>>>> how enclave
>>>>>>> makes sure that EACCEPT was called.
>>>>>>
>>>>>> I'm not concerned of anything going wrong once EMODPR has
>>>>>> been started.
>>>>>>
>>>>>> The problem nails down to that the whole EMODPR process is
>>>>>> spawned by
>>>>>> the entity that is not trusted so maybe that should further
>>>>>> broke down
>>>>>> to three roles:
>>>>>>
>>>>>> 1. Build process B
>>>>>> 2. Runner process R.
>>>>>> 3. Enclave E.
>>>>>>
>>>>>> And to the costraint that we trust B *more* than R. Once B
>>>>>> has done all the
>>>>>> needed EMODPR calls it would send the file descriptor to R.
>>>>>> Even if R would
>>>>>> have full access to /dev/sgx_enclave, it would not matter,
>>>>>> since B has done
>>>>>> EMODPR-EACCEPT dance with E.
>>>>>>
>>>>>> So what you can achieve with EMODPR is not protection against
>>>>>> mistrusted
>>>>>> *OS*. There's absolutely no chance you could use it for that
>>>>>> purpose
>>>>>> because mistrusted OS controls the whole process.
>>>>>>
>>>>>> EMODPR is to help to protect enclave against mistrusted
>>>>>> *process*, i.e.
>>>>>> in the above scenario R.
>>>>>
>>>>> There are two general cases that I can see. Both are valid.
>>>>>
>>>>> 1. The OS moves from a trusted to an untrusted state. This
>>>>> could be
>>>>> the multi-process system you've described. But it could also be
>>>>> that
>>>>> the kernel becomes compromised after the enclave is fully
>>>>> initialized.
>>>>>
>>>>> 2. The OS is untrustworthy from the start.
>>>>>
>>>>> The second case is the stronger one and if you can solve it,
>>>>> the first
>>>>> one is solved implicitly. And our end goal is that if the OS
>>>>> does
>>>>> anything malicious we will crash in a controlled way.
>>>>>
>>>>> A defensive enclave will always want to have the least number
>>>>> of
>>>>> privileges for the maximum protection. Therefore, the enclave
>>>>> will
>>>>> want the OS to call EMODPR. If that were it, the host could
>>>>> just lie.
>>>>> But the enclave also verifies that the EMODPR operation was, in
>>>>> fact,
>>>>> executed by doing EACCEPT. When the enclave calls EACCEPT, if
>>>>> the
>>>>> kernel hasn't restricted permissions then we get a controlled
>>>>> crash.
>>>>> Therefore, we have solved the second case.
>>>>
>>>> So you're referring to this part of the SDM pseude code in the
>>>> SDM:
>>>>
>>>> (* Check the destination EPC page for concurrency *)
>>>> IF ( EPC page in use )
>>>>     THEN #GP(0); FI;
>>>>
>>>> I wonder does "EPC page in use" unconditionally trigger when
>>>> EACCEPT
>>>> is invoked for a page for which all of these conditions hold:
>>>>
>>>> - .PR := 0 (no EMODPR in progress)
>>>> - .MODIFIED := 0 (no EMODT in progress)
>>>> - .PENDING := 0 (no EMODPR in progress)
>>>>
>>>> I don't know the exact scope and scale of "EPC page in use".
>>>>
>>>> Then, yes, EACCEPT could be at least used to validate that one of
>>>> the
>>>> three operations above was requested. However, enclave thread
>>>> cannot say
>>>> which one was it, so it is guesswork.
>>>
>>> OK, I got it, and this last paragraph is not true. SECINFO given
>>> EACCEPT
>>> will lock in rest of the details and make the operation
>>> deterministic.
>>
>> Indeed - so the SDM pseudo code that is relevant here can be found
>> under
>> the "(* Verify that accept request matches current EPC page settings
>> *)"
>> comment where the enclave can verify that all EPCM values are as they
>> should
>> and would fail with SGX_PAGE_ATTRIBUTES_MISMATCH if there is anything
>> amiss.
>>
>>>
>>> The only question mark then is the condition when no requests are
>>> active.
>>
>> Could you please elaborate what you mean with this question? If no
>> request
>> is active then I understand that to mean that no request has started.
> 
> My issue was that when:
> 
> - .PR := 0 (no EMODPR in progress)
> - .MODIFIED := 0 (no EMODT in progress)
> - .PENDING := 0 (no EMODPR in progress)
> 
> Does this trigger #GP when you call EACCEPT?

From what I understand a #GP would be triggered if the EACCEPT does not
specify at least one of these. That would be a problem with the EACCEPT
instruction as opposed to the EPCM contents or OS flow though. This
can be found under the following comment in the SDM pseudo code:

(* Check that the combination of requested PT, PENDING and MODIFIED is legal *)

As far as the actual checking of EPCM values goes, it would not result
in a #GP but for an unexpected value of MODIFIED or PENDING the EACCEPT
will fail with SGX_PAGE_ATTRIBUTES_MISMATCH. EACCEPT does not enforce the PR
bit but it _does_ enforce the individual permission bits.

> I don't think the answer matters that much tho sice if e.g. EMODPR was never
> done, and enclave expected a change, #GP would trigger eventually in SECINFO
> validation.

Similar here as I understand it will not be a #GP but EACCEPT failure with
error SGX_PAGE_ATTRIBUTES_MISMATCH. The relevant pseudo-code in the SDM is
below and you can see how MODIFIED and PENDING are matched but PR not (while
the individual permission bits are):

(* Verify that accept request matches current EPC page settings *)
IF ( (EPCM(DS:RCX).ENCLAVEADDRESS ≠ DS:RCX) or (EPCM(DS:RCX).PENDING ≠ SCRATCH_SECINFO.FLAGS.PENDING) or
(EPCM(DS:RCX).MODIFIED ≠ SCRATCH_SECINFO.FLAGS.MODIFIED) or (EPCM(DS:RCX).R ≠ SCRATCH_SECINFO.FLAGS.R) or
(EPCM(DS:RCX).W ≠ SCRATCH_SECINFO.FLAGS.W) or (EPCM(DS:RCX).X ≠ SCRATCH_SECINFO.FLAGS.X) or
(EPCM(DS:RCX).PT ≠ SCRATCH_SECINFO.FLAGS.PT) )
THEN
     RFLAGS.ZF := 1;
     RAX := SGX_PAGE_ATTRIBUTES_MISMATCH;
     GOTO DONE;
FI;


> 
> The way I look at EACCEPT is a memory verification tool it does the same at
> run-time as EINIT does before run-time.

Indeed.

Reinette

