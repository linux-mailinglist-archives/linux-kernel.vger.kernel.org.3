Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1048DFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiAMVnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:43:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:19849 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbiAMVnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642110180; x=1673646180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y82/x414NO1DUGXZaFR4YcWiwcoS5mYGnVrlc8/zieU=;
  b=M39GT1h+anErmSY5BXpyHvY2nEqvi5CiVoxLP2XvN8BJtpH8Em23wqxt
   TF1NsMgAcA7XYp63byMwVvO1t1AvYVLeW8yOs1tkjo/KpL92uH59uKHkI
   Dl8kwAhJP+rOWPOAwSWZvGFkMzyipQkUIBjLfHVEvd0UWlVv29vWLGIOQ
   RjsWnBs820rG8XtOtpVrASxG+JDcc63BRKqFI+nHdF43s5QXbV0eYnaxE
   x3flP9f4DdPSH1rPceA/Jra1ZKucXTzbitB0wTIdu7DCKJoBE3t3tyhie
   L+15gmNZKAK2wCmq+cow0VlqV9spP/ielhBTpTtPtWfPKQ1U4/hEuKhu7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243915934"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="243915934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 13:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="670652070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2022 13:42:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 13:42:59 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 13:42:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 13 Jan 2022 13:42:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 13 Jan 2022 13:42:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWhT/y8AD1RqQOdwXlayZgsGQwGBxCe2WbMLeaVTsb4zGrBq1S/zj50QWdjLB9G1ciU3a1YLf/4cyY+Awjzj7/ibLtnf8rRjTMuNBYBjeo/QjqiQUY1T2ZeDMTVk6SZ1G6F5I7ufHnO3I6arVgF7hwf1W41tfqsWgLlV8EMuGpcHYv5mkjBPqOVUINepK20Q4czFn0w+UGluF0GadE7FTFaBQ+0ZDB4CtXez4moCutGGWYwT/JEZBUf1g63tkStx0jug23uhYFs+c5kLrj0aULKVkcAfnpot4PDpN/zb4KtTnLH2m5zdEGm8+2j1PNZNI0TYZ9iM2cwdozP7WhbmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRv6+ZCPZtVNxEl14Z3DXo+5PYiLnfyE415PYBl9e24=;
 b=DUi3csnpCvJNcvVVSzt7gbaNHszQMfpGbwbZarK2qJM2vxLsg6WWzEvAwoymJnifIueDQvRzAXW9PGcia09ByornyPSPTWRYx1GnqGFmsYicuWSTpwR9F5wRNvmMaRsCm8KY/P2UmGfqAbj6UMVpacJXnQS7+xJ6tnqbFiwdbxLXUSb5g0qaYfmdwKB3lVjIhQHVVAgYBZnFHJi1u7ZsHiVFTHL1v3XaX4xRNPab0QmqmQdHUW9PkyeDS50v8U15Pr92K2PWtEjNbRCHaOWOsIyhrtcv+I9+aPnp4P3PgFYKN8YmfaOOSVyBalrHF5jYuVTTaB96WCI0BcwZz/R4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 21:42:55 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 21:42:55 +0000
Message-ID: <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
Date:   Thu, 13 Jan 2022 13:42:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi> <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi> <YdmzDy1BOHgh8CII@iki.fi> <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net> <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com> <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0105.namprd15.prod.outlook.com
 (2603:10b6:101:21::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9304c7c3-a485-4594-b6d4-08d9d6dda864
X-MS-TrafficTypeDiagnostic: MW3PR11MB4747:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB474704AC3B8D061A80E2230DF8539@MW3PR11MB4747.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddDVggea7SvPODH5nu8tLmQ1yuywDps5DFA/82JFnUk0A1SckNuvIR7h94GTW61cL9JYNhZrUsS6TVSaO/pgD6jd9zke4WtjSxDxajscjekp7uWS2im61sY2dYgRKvyz+3Hh91OYY5qEzdZU43mznZAwVgZ5pE+twEtvOi1ij8K+sDaWmQnIIlkFmmRMVaq7Jy5KCcKYwbC3uuZ4JkpIDVR2p9B+HLnQiYHv35MQHox2ZdXr0PEgjCMrSsFdR2CwGldYG8SXAffDdNB7ePxHpu3IrdST5bP7U5zNY/eMuTTt5f7lZtgCcFJMVjjlLVPhhMZBCrc3jFPIFXTZle+8uqdii14E4xu1RuNAWvy+MUSFlxmBMvVlzdxZNL0HnVS8PnDhjWLQJquqRn47VDe7LwCeLyUl4Dv7SnQUEj4poEeRadLHWCWHh9Gntpz3sTYGRupRnfnCM8+Tj115Ht5yGiEdmeV9+e4nU2nmFxxjh0OK+q5wWEla0oTQjUFJQJ0ZC8CZeUv2aAp/rLSgtA5YZUOc0ryMd70LCW8I+3OdxdhU9BJ2ISCm3k5qSxht01nxFEQhL2hHoEzQ28ST1YSDKrL44Qzazgbu9y16CZdEvO15L20ji6h5phAAp0b+KwxdnoiZwKyut1HoiuZu6fLEFU43sWb2CfoEh0+ppIcoMZd0ViN7+RW750ozj1mJO63h+FvCdDMzJFS+kqNPg2C+uT274BCe9TUt5nGtTaTHVSlZ929BonnTQamdGbfck9u5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(110136005)(66556008)(6486002)(316002)(66476007)(6506007)(53546011)(8676002)(6666004)(66946007)(8936002)(26005)(508600001)(2906002)(7416002)(186003)(31686004)(86362001)(6512007)(82960400001)(83380400001)(38100700002)(4326008)(2616005)(5660300002)(44832011)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RitJTkdlNUFDUVpKR2R5SEFCb1F1ZER0UW9WVXp6KzVKVXViOUZvTTI1VWxO?=
 =?utf-8?B?blFlQ3g1dnBpc2RNSXhqUnRvMUEwcExISUNwYVFUUlhYU3NBdGRvQ2NlWHA2?=
 =?utf-8?B?Wmt0L1JlTjlkb0g5d3hOUENWQm53NitNcVNTM3U0MXlZcmVzaVc1bkZNbnB1?=
 =?utf-8?B?dC8rKytINnlYMy9iaS9laGluL0hIVENVcnVZeGFpSFo2M3c4ZS9GY2hSNHJ6?=
 =?utf-8?B?aUJYSVF2VzFZbTF4YkxuS3ZsMUYvTVd6OGxwZmlXRW9VY1BTaUxFVkFJR1dw?=
 =?utf-8?B?U3dJUWdXdTZucUdVS0dDekxNOXdPSTZ4TEJMVmhzWk5OOFpqM0IwQjl0dCtv?=
 =?utf-8?B?MEpXOHJ4Q1FzaWxXdUkyY2tyK3VUN01kNlpKVDhJSkhKV3JhektJM3JCTmti?=
 =?utf-8?B?Sit5N0ZyK3M3VTRCNzJRWStIY0wxZzRaR3JWSXptLzg3Z0hKdkVibGIxVW1Q?=
 =?utf-8?B?aDgxQUhRaHNvMk1DeWJQcXNLRzZYNDhaR3VHN0NGeWhBWDZ3a1B6VGZqMFNQ?=
 =?utf-8?B?MG1yeVp2VFp3RmFpK1RldW5QTXM5VmJDbjdkZGwvNFc1U2NjMWZ6eG13TFJl?=
 =?utf-8?B?eWxEbHFPeWxSMU93SW5FU0o4NWlnODhQQ1M4YkdWZTRrV1FGL0RJd2c4bnJ4?=
 =?utf-8?B?TktVY1ZBZTh1YnVhUUtvMGtNaWROMlk0ZzlXOVFhd1BQdXZFNnNPbHFSSDRz?=
 =?utf-8?B?MGJLc0JMSDkxcHhuN05pU0t3UEhBVXFxcHMwUS9ZOE1SS1AwRW5UUTVzNThi?=
 =?utf-8?B?b2psbVB2VDRVQlRTTmpFS2twVi9TM0luc3kraXloYlZkdlZqM25nWWkyYzhS?=
 =?utf-8?B?Mks3N0NKdUF5ZVBkZ2Z0YlEvVFUwbDFlTE9TdUFldDdxQXpvaFlsUElPSVJw?=
 =?utf-8?B?aGlBOFY2ZlNRWW1uTTNFMmFWSXVuVndPZVFOTXRSWFBBVnJ4WXRCVnlHT0tB?=
 =?utf-8?B?cEhybE93aHdQSW94ci9NUXh5Ri8vU1dXS1BMTlZURGZtd21aRXlpaHBmd05E?=
 =?utf-8?B?RDg3YTlzMVIyL291RU9kT0RSaVZ5dUtNZFU4czRsOGluNVA3MWFVOFdNeDFJ?=
 =?utf-8?B?WGdyRmd1WHdOZ0UwYWZiMFF6VURQVzVYMWFHbHR1WUpMVS8wRWtHRW1WSlVl?=
 =?utf-8?B?aUZTY1gwZ2hnQkY3RXZORXRSelJqcGVYNllIdkxKelg3aGhsdWxJUzNqRUIy?=
 =?utf-8?B?VFZwV2lJSnpMM1dtQXdnMTdUY2xIcTVPTHRUNkNCeWFrQmM2R1BacmRlRFh4?=
 =?utf-8?B?Z0g0aE5WcHk3a1J3WVExR1d6elB3NXlFQ2ROUmFwK3pNQTdDcjhSdUppQVdJ?=
 =?utf-8?B?b3BuU0dKaGRGUXIvekU4ZHNuVVcybG9EbjJVVVNpaUFRUjZZZHB4OHd5U05I?=
 =?utf-8?B?RVo0aDBxMWV1VHVpUjFDWlZ1SzFTL091eGVmU3hPNUZWMGwvTXFIYXdWMDVO?=
 =?utf-8?B?RXJURDQwVmpzRTVsMVZMYnFzZW9aL1hBTW5PeWFnc1VWMGJjcUtVMjJNVytS?=
 =?utf-8?B?NGdycCtPWEtaOEcvZStDenpVblhEaGZkUDRCa20zS0NTdnkrbGVDYWFiU2xy?=
 =?utf-8?B?K0FjSzRlL3ltNmhKem5ieERZUFE1T3RDenAzKzJlNGZyWURub00rN0dKQnRv?=
 =?utf-8?B?clcxUGI3SjBzUm5kTGRvNS9ZMHlwQkhPaGY1bzBGMnpzUmNFNUxud1dRY1U0?=
 =?utf-8?B?MCs4Z0szRTFMYm1aQTF2aFkzWUc2WjlnS29CYmRJSnIvSFZJa0lkazlHYTIz?=
 =?utf-8?B?cHlWVUFRWm9RMDNWdTdoVUUySUg2VXpPczR0ejc0VkZLcGprZ0VaMFJKdUh0?=
 =?utf-8?B?WWlDWXhKU09tbytQbXVUZy8waHN2MGhvcmRxZTZucnlBd01tanZDWlZDckNT?=
 =?utf-8?B?MXY2eFpYd0N5UnJoQnBUZmdkd01NekdGOGpiVEtlN2lCUjFnRTgzSk9BMmxP?=
 =?utf-8?B?a3B1QVQyRVpzakZFVWltdU1aeUNTSnFqM3FNYytmRGJTbkxQYkdBcUN4dHhP?=
 =?utf-8?B?aC9iN2NWbXkzZnJQbm12amVqQkJoVndMRVdlUHhnZXYyNXlEcXMrb1pYaUtl?=
 =?utf-8?B?b2FicmJZQnFQZHRMTjVHQkw3eGZTK1FhcVNMZGMvbGoxdmdmZUIxQUFSUDhz?=
 =?utf-8?B?ZHNESTBpaDNla0pnQm0vNHZYcHpXdkY4TXdIcnRBWTBoOUFnWStZTVBEamdR?=
 =?utf-8?B?SVJ2SWlLQS81eG5FRnNqR1B2a2NLdmZxYmszdjBsd0pJZ2NMTGNzT2trNnVj?=
 =?utf-8?Q?6qS8mpOZB99d5HPc0kpQoH6Mbmcc+30BDcRT3Wym0I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304c7c3-a485-4594-b6d4-08d9d6dda864
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 21:42:55.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR74qIcigJEtZYmvcxtYFlIEMfv1uwdCaM7+I1VIyo4rJvmzE8mXH+SlXCQb82ogF9k4W8iIKisUtAGizFi8DLw74U6UZXuv7/sH4OIhCds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko and Nathaniel,

On 1/13/2022 12:09 PM, Nathaniel McCallum wrote:
> On Wed, Jan 12, 2022 at 6:56 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>
>> On Thu, Jan 13, 2022 at 01:50:13AM +0200, Jarkko Sakkinen wrote:
>>> On Tue, Jan 11, 2022 at 09:13:27AM -0800, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
>>>>>> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>>>>>> wrote:
>>>>>>
>>>>>>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
>>>>>>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
>>>>>>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
>>>>>>>>>>>>> OK, so the question is: do we need both or would a
>>>>>>>> mechanism just
>>>>>>>>>>>> to extend
>>>>>>>>>>>>> permissions be sufficient?
>>>>>>>>>>>>
>>>>>>>>>>>> I do believe that we need both in order to support pages
>>>>>>>> having only
>>>>>>>>>>>> the permissions required to support their intended use
>>>>>>>> during the
>>>>>>>>>>>> time the
>>>>>>>>>>>> particular access is required. While technically it is
>>>>>>>> possible to grant
>>>>>>>>>>>> pages all permissions they may need during their lifetime it
>>>>>>>> is safer to
>>>>>>>>>>>> remove permissions when no longer required.
>>>>>>>>>>>
>>>>>>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
>>>>>>>> how using it
>>>>>>>>>>> would make things safer?
>>>>>>>>>>>
>>>>>>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
>>>>>>>>>> modifying both PTE and EPCM permissions to RX would be a good
>>>>>>>> defensive
>>>>>>>>>> measure. In that case, EMODPR is useful.
>>>>>>>>>
>>>>>>>>> What is the exact threat we are talking about?
>>>>>>>>
>>>>>>>> To add: it should be *significantly* critical thread, given that not
>>>>>>>> supporting only EAUG would leave us only one complex call pattern with
>>>>>>>> EACCEPT involvement.
>>>>>>>>
>>>>>>>> I'd even go to suggest to leave EMODPR out of the patch set, and
>>>>>>>> introduce
>>>>>>>> it when there is PoC code for any of the existing run-time that
>>>>>>>> demonstrates the demand for it. Right now this way too speculative.
>>>>>>>>
>>>>>>>> Supporting EMODPE is IMHO by factors more critical.
>>>>>>>
>>>>>>> At least it does not protected against enclave code because an enclave
>>>>>>> can
>>>>>>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
>>>>>>> confused here about the actual threat but also the potential adversary
>>>>>>> and
>>>>>>> target.
>>>>>>>
>>>>>> I'm not sure I follow your thoughts here. The sequence should be for enclave
>>>>>> to request  EMODPR in the first place through runtime to kernel, then to
>>>>>> verify with EACCEPT that the OS indeed has done EMODPR.
>>>>>> If enclave does not verify with EACCEPT, then its own code has
>>>>>> vulnerability. But this does not justify OS not providing the mechanism to
>>>>>> request EMODPR.
>>>>>
>>>>> The question is really simple: what is the threat scenario? In order to use
>>>>> the word "vulnerability", you would need one.
>>>>>
>>>>> Given the complexity of the whole dance with EMODPR it is mandatory to have
>>>>> one, in order to ack it to the mainline.
>>>>>
>>>>
>>>> Which complexity related to EMODPR are you concerned about? In a later message
>>>> you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
>>>> so it seems that you are perhaps concerned about the flow involving EACCEPT?
>>>> The OS does not require nor depend on EACCEPT being called as part of these flows
>>>> so a faulty or misbehaving user space omitting an EACCEPT call would not impact
>>>> these flows in the OS, but would of course impact the enclave.
>>>
>>> I'd say *any* complexity because I see no benefit of supporting it. E.g.
>>> EMODPR/EACCEPT/EMODPE sequence I mentioned to Haitao concerns me. How is
>>> EMODPR going to help with any sort of workload?
>>
>> I've even started think should we just always allow mmap()?
> 
> I suspect this may be the most ergonomic way forward. Instructions
> like EAUG/EMODPR/etc are really irrelevant implementation details to
> what the enclave wants, which is a memory mapping in the enclave. Why
> make the enclave runner do multiple context switches just to change
> the memory map of an enclave?

The enclave runner is not forced to make any changes to a memory mapping. To start,
this implementation supports and does not change the existing ABI where a new
memory mapping can only be created if its permissions are the same or weaker
than the EPCM permissions. After the memory mapping is created the EPCM permissions
can change (thanks to SGX2) and when they do there are no forced nor required
changes to the memory mapping - pages remain accessible where the memory mapping
and EPCM permissions agree. It is true that if an enclave chooses to relax permissions
to an enclave page (EMODPE) then the memory mapping may need to be changed as
should be expected to access a page with permissions that the memory mapping
did not previously allow.

Are you saying that the permissions of a new memory mapping should now be allowed
to exceed EPCM permissions and thus the enclave runner would not need to modify a
memory mapping when EPCM permissions are relaxed? As mentioned above this may be
considered a change in ABI but something we could support on SGX2 systems.

I would also like to highlight Haitao's earlier comment that a foundation of SGX is
that the OS is untrusted. The enclave owner does not trust the OS and needs EMODPR
and EMODPE to manage enclave page permissions.

Reinette






