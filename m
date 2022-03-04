Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B64CCAEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiCDAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCDAtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:49:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA304ECC7;
        Thu,  3 Mar 2022 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646354897; x=1677890897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e3fLgA7eOHXR2lm8V2jW7t8R1PVGR1cQGSBw2PqGpyk=;
  b=QwSUp+PT6wQZFM/QhRldTrxHOWM+x29yeD/5Ugr33GRmqzhEMxy1Sxg3
   +S0olWJeFAe9s76ZN0mApJoYpDVafhnEvQ2cACzy7R0e4k/mWwSqqoPQG
   jZDMMiOoFhKAOz6N7aeIV190+Xit/OHJ16OrF9jraU6byouqwGPmtJv4a
   TKsOe2RWfrmYiPWrfcF3m9W/QAv2c4qCY+tUOaUX7zue60pHg5T6H0KEl
   4oQWnz2rMzDgwQtKmD8l/45gl4Y+lEHfMyhSXO3N9h1lf4Wf5Wa79xu3D
   8GkRedFTcOcv+lqvZprmR3yvpS1NE/VepCxnkH36XyZfvoFdDJmWmP3R1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="340289164"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="340289164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 16:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="576713186"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 16:48:16 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:48:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 16:48:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 16:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ6quHeddCUcL3ASH4O4hMjtOC4Fn2sSILqiPgQl8UFYMHvFCXxewTJb30PzLOUue+1tpiPdX7Xr6psYwsdltDy86OXgT6MJWG1lJ0QN1cWkLlLUjSKyDF18ZfML01SCUjys+yTEBFfTZ5DPAlzxuNZj6Pi6u4pn8IW2xg1b1Mqw/ji1YkAUTepNJYyeEnNUrUu/TrbKh1dqOATw5U8TzX3htffjtq6QGdWEZ6ns+R06/eaMCKCTw1f5hDLvpVGpyJ/0TTBbH94XiTrpZJxq7JVvrbe7QoX1YKgmYHBMEcsiGlfHtfkHeZXaa4RLaiHkk+VdnPHbtqr7yBibHRLC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7lR2v7YsJmbOBBZbbj3pprDMBS+wPSjUaZrwlylbjU=;
 b=QOLKO3ps+KiXSX01PkFZ0dcVmIGR8xP7ZHqKi/sWMPyJrVLjKM9KALEjK54lttZJXORcnGUugelhjgH3XovND5GrNNsojPlu8KS/6z3wmirjAojerl4DfbwcUDBtmJeqolMagGFJvDoc3W/a7lfNBKvJ3eZBgG0i7IjpUCSkcIZkf5IU2vHw6C6F0KRithLZ2lrlhqgwMzDVyshgDtQbU6baL0Wu7SI32gKIIsScPyGO9NZaKjC63ivmbI612K7hoSo5qn0ocw7Pkx/fIDyDdWcAHbo2nGKPYmhD+H1xqPyWMed63PyI6ChWnLQl8H2xvy5NK3uyEjNZ5tDkAU3XJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1591.namprd11.prod.outlook.com (2603:10b6:910:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 00:48:12 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 00:48:12 +0000
Message-ID: <7a0790e1-18aa-31c5-c2c7-0f37133fa098@intel.com>
Date:   Thu, 3 Mar 2022 16:48:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com> <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com> <YiFLXABTitx85sfj@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiFLXABTitx85sfj@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0090.namprd15.prod.outlook.com
 (2603:10b6:101:20::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b119f1bf-3179-4b85-f332-08d9fd78a91f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1591:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB159139F08A34772AAA0559F9F8059@CY4PR11MB1591.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JYafWE8YQpmyii8B5az8J68gMRIj5P9JMyCuEvR0cyoAEFbr8KEJ4fre4+smiNMClM1rbGeTnD9EIuBuZZpIemRaHl+iYDIqgcbt2cYI5nqX2TAJyb8km43iO6w0U0MCT2Btsh/KECGJWZtrJcnmz7lg8ncXDNyTLw5kIceieDCkeQliUnScCvsX4W3BDLsn1zdB8AhleTtGFmzDqzW6dgmw/feZ3YwUAEevQImKFrcltcGHdifQQflN08Ch46p5tu5Czr2zGSNG0a5ulDX8plbaY3b9yajKW8teZQ7ddWWChd3sSwy0XXswxPbjuuxe0TYZi/k/6I4ADCiOT9xQkbvOLLDY4HPnPn/INQxd3CpQ2y8Pz4yWe6Lc8tgcBbK/PPBXpuYHy44xxAbjAjHRci3ZBC5eGjQztrGTYmzy1nlwVpovbxN01V+MfXxsYZYI1GCxWtSeAyZ6+B0Dtuu9GGnlYQknbu2vk47s6VHox1++IGFzwymBqpZ5bO4p+ZMjhGY1UC/7I9pLsZaPtn/u1lyELPIaF1+dlZ5co3Fp+JlDfvyqtwoFIlPtIfbVEMZs0IqRKILITEzSbMzR+DYrOPqiFiSR0IJt5W+SVcZK9eCcJWNsERjLFuqemjo5ZHKYTbYFR+U0FKkFAwz/4qAGw5ftgfCXgF3GRJr1jrI9lKQ0HX+g3c7aQw0Ondf0byy5GyIMT6wE+CXXez6Uua+qAqdyRsjMGNfxuCaYHZ1aQXJ7xRGFTv94/+qCUD7oFrP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(83380400001)(186003)(26005)(5660300002)(36756003)(38100700002)(31686004)(2906002)(44832011)(7416002)(8936002)(508600001)(66556008)(31696002)(86362001)(66476007)(6486002)(53546011)(66946007)(2616005)(316002)(8676002)(4326008)(6512007)(6916009)(54906003)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJERk5XWGhORVBDZVZMelRQN25vT1l1NE81RkZWbWlKUVpGS0ZmOGNYckQz?=
 =?utf-8?B?U0NCWE11a1lhYStZeFc4MTN5L204UkRQd243b2c1ODUza245c0M5SVpGRGtI?=
 =?utf-8?B?anhhWGxRVEV3VWlVZXlMU09RTXJnbWxVZGFqNkpiZUoyS05CV1JpTUdjeWJE?=
 =?utf-8?B?ekQ4bHlnNzhFYkY5d29nUEQ0STUrSkZEU1lVWEd3SHA2eXdqMVBDU1B5TXl3?=
 =?utf-8?B?SWltRk9sc0E0dFlNUEdwUDZFTm9DaUR6RXFxR2ROSWhpYWZJWnVFcGJQRmZr?=
 =?utf-8?B?TDZZajRWWm1kdnRSOU5jUnZMVk5memxDSktNZGtKSGNhR2t6blZHTjN5ejVJ?=
 =?utf-8?B?MjlIdUVYdjRmNzBMSFlmZEZ5dFRZeGJaOTUrdGVDV0xKK0tpVkVpNEUwa3ZI?=
 =?utf-8?B?b3dVUEU2RHRwZXZrOU43WEFIU2hyWkZ1YnV2azRQNXVLb0hPcjMwTkZla2lS?=
 =?utf-8?B?VVFCTXlncTU5MTFlN3BJdDEwQTh2ZXJDN3M0dXBkd2o3TnRhVDlRY01BVGZH?=
 =?utf-8?B?RHdXNU9YQmRjVHdDOWU4TWEyemplZGtDU1pXcVBvZ3ZDOC9KaGlzR3B1VklZ?=
 =?utf-8?B?NUpMalRTa3hkNmsrYlpwVTB5L1p6Ynh5aWNtRzJrKzArdkNYMWIxVXNwZmZL?=
 =?utf-8?B?T1dLb0o2amFpVzBrN3NPVVRod2xpZU9jQnFPeTloZVZHN3UvaGVTbWlaUzND?=
 =?utf-8?B?dWkycWRpOWx0cDhNSnA0Mzg5N1VxbWsrZUY4cWxPQXpPaEtSNHUzSm9VN1gy?=
 =?utf-8?B?K2x2UURnUG5tcnZjNHdHSFlhS0dGdHU4aGQ3UVNVN2ZFS1k1ZzhlVEQ1ZlIx?=
 =?utf-8?B?ckZtZGJNRUVud2VTdUFGbm5KMEpLR1VoSGRRRUU3akNyMzhiTElqN1ExRHhs?=
 =?utf-8?B?RzAzNXByZi9jaDYyT2s0WG1CeFVtQnhOb2lEanBsUzJOeWtFejh3SWdUQjg1?=
 =?utf-8?B?UXJkeUJHaFdnZHBOR25CUis3bExHeTdvSDRvOXBNR2hZdWZlNUlzdDBlNDBL?=
 =?utf-8?B?cmNHSGQ1eUJHS294SkdCbytqRXNOQ1hiT3BBQ1hpK0xIOGt5eUJ4NVlscFk0?=
 =?utf-8?B?d1BjZ1dMOUVyU3dtaXp4QU1UWXhObU9uZ0FldmlFbXVHYU1UVkU5ZW1hZ1lv?=
 =?utf-8?B?V0pGVktTUEZVTjFMWjFHdnZ5VTlHZVplNE5oUk9mY00yaTRYSWpqeXpTdEJm?=
 =?utf-8?B?VGVkYS9FTEJpOEVMcWRPTU1haE5rNHlQejF5UVVmd016Q1ZIQ3RxcStybEw3?=
 =?utf-8?B?dis0YXM1YjV6eXlKUGJNdk14d21tclM5ZlpMZU1QSU9NSk56a2pLLzZKby9D?=
 =?utf-8?B?eUhmTHB1TktxZDVwcjR0WTF0cEpBTjY4WVBJbml1RHhWdXlqMmVFR3JjNmdY?=
 =?utf-8?B?VzZqdkpoenNlY0ovaGkwOTM4cHYyNzQ2Q0swVkZudmRBQTlKQURPS0xpSVJU?=
 =?utf-8?B?Zmc2b1VwbjY5L21hK2xVa2lKVjUvT29mdCtpUXEwalkxRzBGSVlLb0dsK1BM?=
 =?utf-8?B?TXBCTXkrZzNJcTBRTDVFMUh0eW5qNTUrMWhuQWZ1NlZoSk5aNXVhMVJ0dzJI?=
 =?utf-8?B?RGxIVk1aTExTaGZhSUUwUWZDUWs2MW1LMkl3YXB1RXI2Y2Nxa2FoSlJqY0Fw?=
 =?utf-8?B?SHF0eFFBWGZMUlRvWmh6UXZrbEZTSmFxYmNrQjk0ejVMV1hjaWJtQlBMbFU2?=
 =?utf-8?B?OCtHTC9OYVRoZG5jcnpkajRDQTZVMkN5dEhGUlFnUldvejVOakVWTTBOdUVw?=
 =?utf-8?B?Wmc4NlgzMXVWOFhCV2V5UDNTUU5kdVN1WkpmOGhTcERERUNBV3dISHZ1ZFAz?=
 =?utf-8?B?Qjk0OFRrUVlEM2dxa2pWUnppMzBDczJxWXVHMVZLME1MYW5zWTdqVUI3UUU2?=
 =?utf-8?B?N2hNZk1oQWZjTHcwQmxIbzc0YytSanEzeFhxOUp1MGJ2Wkl2R0R0K24zdUor?=
 =?utf-8?B?SkJoNnRoQXU5N2hBaDNvTjZaUFZyQUJsVlZmOXIyNkJuN0o3QjJ2VzIvYnVp?=
 =?utf-8?B?V1Q5TlkxelhLOXhHZUpXSHZxdEk0K0hCRVFESDRERTdpcDdGb0E5Tk5yalRa?=
 =?utf-8?B?Q2hzMFA0SXArNWl1TEN3TkQ2RlZiN2lUMG50dXZISVNEakdSV3VFZ2RabUpF?=
 =?utf-8?B?ZlhObFd5YW1CdWdtbXBQa09MOHNsbmVBeTM2VzhqK3p1eTYzd2tvR0wrbjZG?=
 =?utf-8?B?WUVTcEtrTlBmZnpRTHJBWjVCM1JQWk5kV3o4K1V5MnV4bVRSdThMQnQwQlYr?=
 =?utf-8?Q?i37V8dyQ8NNKJJZ35yOBOgpJHhYr3dtsYMDCooAqPU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b119f1bf-3179-4b85-f332-08d9fd78a91f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 00:48:12.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9Ocu/OSMgIojYe5rvfr1smqBpbTZ4H871jVEClY5725As9npighBOIwgXmcPAJ3GBgOq3yYU9EaV/RKoSuV/m1pA681f1bq0hH2mDYUs9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1591
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/3/2022 3:12 PM, Jarkko Sakkinen wrote:
> On Wed, Mar 02, 2022 at 02:57:45PM -0800, Reinette Chatre wrote:
>>> What do you mean by "user space policy" anyway exactly? I'm sorry but I
>>> just don't fully understand this.
>>
>> My apologies - I just assumed that you would need no reminder about this contentious
>> part of SGX history. Essentially it means that, yes, the kernel could theoretically
>> permit any kind of access to any file/page, but some accesses are known to generally
>> be a bad idea - like making memory executable as well as writable - and thus there
>> are additional checks based on what user space permits before the kernel allows
>> such accesses.
> 
> The device files are limited by a GID (in systemd upstream), which is a
> "user policy".
> 
> What you want to add and why augmentation cannot be made complete before
> the unknown factor is added to the access control?

After studying this part of SGX history I learned that unfortunately none of the
existing user policy controls have been found to be a perfect fit for enclaves.
Current user policy type permissions are associated with files and processes and
enclaves have properties of both. One process can execute multiple enclaves and
only one/some of those enclaves may require to execute dirty pages. Associating
a permission to execute dirty pages with the process, and thus giving that ability
to all of its enclaves, is not ideal. Similarly, the file /dev/sgx_enclave can
represent multiple enclaves used by multiple processes and a file permission is
similarly too broad.

What I was planning to propose and discuss after the SGX2 core enabling was
an ability for user space to uniquely identify enclaves that require the
ability to execute dirty pages. This identification can be specified by using
enclave properties like MRENCLAVE and MRSIGNER. Executing dirty pages would
only be allowed for these specific enclaves identified to require this ability.
A solution like this is possible using the kernel's keys subsystem by introducing
a new "enclave_execdirty" key that contains these properties. I have this working
as a PoC.

Perhaps the SGX_IOC_ENCLAVE_AUGMENT_PAGES what you propose can also be seen as
a solution to support user space policy ... instead that it is more fine grained
in that it is used to identify specific memory ranges within specific enclaves that
are allowed to execute dirty pages. What do you think?

>>>>> I think the best way to move forward would be to do EAUG's explicitly with
>>>>> an ioctl that could also include secinfo for permissions. Then you can
>>>>> easily do the rest with EACCEPTCOPY inside the enclave.
>>>>
>>>> SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
>>>> this purpose. It already includes SECINFO which may also be useful if
>>>> needing to later support EAUG of PT_SS* pages.
>>>
>>> You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it a day.
>>
>> I could, yes.
> 
> And this enables EACCEPTCOPY pattern nicely.
> 
> E.g. you can implement mmap() with EAUG and then EACCEPTCOPY feeded with
> permissions and a zero page:
> 
> 1. enclave calls back to host to do mmap()
> 2. host does eaug on given range and enter back to enclave.
> 3. enclave does eacceptcopy with given permissions and a zero page.
> 
>>> I don't like this type of re-use of the existing API.
>>
>> I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is consensus after
>> considering the user policy question (above) and performance trade-off (more below).
> 
> Ok.
> 
> If adding this would be a bottleneck it would be already persistent int
> "add pages", so whatever limitation there might be, it already exist.

Currently this checking is built in as part of "add pages", for example, user
space is prevented from circumventing existing protections on the source pages
with the "vma->vm_flags & VM_MAYEXEC" check in __sgx_encl_add_page().

Further, there is trust here in that the pages added before enclave
initialization are accompanied by their secinfo with the permissions of
the pages and those values are included in the measurement (MRENCLAVE) of
the final enclave. The maximum permissions any enclave page
specified during "add pages" may have is "locked down" during this time.

Permissions of EAUG pages are not included in the MRENCLAVE of the enclave
and there is no backing memory that can be referenced to learn what is already
allowed.

It is possible that some of the code dynamically loaded into the enclave
could indeed be buggy or malicious so effort should be made to only allow
executing of dirty pages to those enclaves specified to require the ability.

> Thus, logically, that could be safely added without worrying about user
> policies all that much...
> 
>>
>>>
>>>> The big question is whether communicating user policy after enclave initialization
>>>> via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
>>>> appreciate a confirmation on this direction considering the significant history
>>>> behind this topic.
>>>
>>> I have no idea because I don't know what is user space policy.
>>
>> This discussion is about some enclave usages needing RWX permissions
>> on dynamically added enclave pages. RWX permissions on dynamically added pages is
> 
> I'm not sure if that is actually necessary, if you use EAUG-EACCEPTCOPY
> type of pattern. Please correct if I'm wrong.

This only takes EPCM permissions into account. The issue comes in when the kernel
needs to determine whether it should allow the PTEs pointing to these pages to be 
executable.

To elaborate your example, to use dynamically added RWX pages 
EAUG->EACCEPTCOPY->SGX_IOC_ENCLAVE_RELAX_PERMISSIONS is required and 
SGX_IOC_ENCLAVE_RELAX_PERMISSIONS will only allow PTEs that are allowed. In the
driver sgx_encl_page->vm_max_prot_bits dictates what permissions are allowed
and SGX_IOC_ENCLAVE_RELAX_PERMISSIONS will return EPERM if an attempt is made
to relax permissions beyond that.

When considering the user space policy integration, sgx_encl_page->vm_max_prot_bits
will be initialized to reflect allowed permissions, RWX if the enclave is so allowed,
in this way EAUG pages can be made executable using SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.
 
>> not something that should blindly be allowed for all SGX enclaves but instead the user
>> needs to explicitly allow specific enclaves to have such ability. This is equivalent
>> to (but not the same as) what exists in Linux today with LSM. As seen in
>> mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect() Linux is able to make
>> files and memory be both writable and executable, but it would only do so for those
>> files and memory that the LSM (which is how user policy is communicated, like SELinux)
>> indicates it is allowed, not blindly do so for all files and all memory.
> 
> We could also potentially make LSM hooks to ioctls, if that is ever needed.

Could you please elaborate?

> 
> And as I said earlier, EAUG ioctl does not make things any worse they might
> be.

I hope my earlier comments noting the differences with adding pages shine some light here.

> 
>>>>> Putting EAUG to the #PF handler and implicitly call it just too flakky and
>>>>> hard to make deterministic for e.g. JIT compiler in our use case (not to
>>>>> mention that JIT is not possible at all because inability to do RX pages).
>>
>> I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more deterministic but from
>> what I understand it would have a performance impact since it would require all memory
>> that may be needed by the enclave be pre-allocated from outside the enclave and not
>> just dynamically allocated from within the enclave at the time it is needed.
>>
>> Would such a performance impact be acceptable?
> 
> IMHO yes because bad behaving enclave can cause the same issue anyway,
> and more indeterministic manner.

With EAUG pages supported in the page fault handler it is possible to support
both usages. Especially now that Dave provided guidance on how to
support MAP_POPULATE. As I understand, when MAP_POPULATE is supported a usage
needing deterministic behavior can pre-fault all the EAUG pages while those
usages mapping a lot of memory that mostly will go unused are also supported.


Reinette

