Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CED4DD1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiCRANK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiCRANJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:13:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089B13F8FE;
        Thu, 17 Mar 2022 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647562310; x=1679098310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XsCczeilhT4SkMhJPJKqLyMp8i0stkvicdB1yzelAm0=;
  b=IwH7IOUQcvW7nZHONS+EjBWUGb7GsTIx2ZXCZY3+nvB99BsJIr6PkpjJ
   Sn7xkIAFfZqD+DnQYiO3i1X8zXNVirXSpDM3Dfv+CcN6Q+mMUv2ENkm/d
   xj4tEM6aUBLKdLeC8hIv0+QRe+xTCOy3VhCGqd8p7OoKUt5Pbl02ThE+m
   JiWLUdTaVEYS7/ofkf4wSim4UVwgKhytvZy69NCnEHw3XEefywzd9xnhj
   Vy53CJrDrAoF05NWu5DtgQgLYAwE1Z/CIDM9Gp7PqEHvPXYzQl2bvLKXk
   zGPHLVCoL2sfLu4MWUQNooIUdLDtxCpAr8ukAHfG3cLyBnJ9knOVW/Biy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317730202"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="317730202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647246205"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 17:11:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 17:11:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 17:11:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 17:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf2msrdHja7jCBQV4/IiKinDUU1kFB8aJoDtBd1h4L8dhThqr8y3uwmNZCTaZrgIN6Xd3ThVkxc19vGpOQYEomRxiKyCn94tBcKFdtdOUueLLdfFpgECyzwnj+idmUtIXrSWDoehWa8wx4xq/zdYHmQbmjKBIQu2aYDP6tX2XJITnWcU2MILaqmmm0BBreJ52+y4J//ewimVv5lDDkUhXaBRBPCsZe9XHL8pXwYKloGc50R74Ws3T5MweGFE2NOxiwkcTSBT9W5POB+WR+nPusSIdxsHrh5h9JxGSy82buidqDjEfWAEZgcc6qIXGXtnujgvCrFMx4UwFVsU8VZ7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3wGp6IHbxkAfNDeaOIpM299wN/A1COsiwEKliM1SoQ=;
 b=lFVmzlxTl7QHYPCEbj1YZHFLBZhvutyHQLPb2Z4YQrZ9t/HmgUHXPKtTkbJ5URAgX2dbfcFau5fA1SBfBWIks9Yw44h2ugNxK6+mGRUdCLSY0WfXZ0VlYknqweGwZBDuX3HDau4efOYw1ryW0jOOZatYm7GGJQXpgYc0y82ORmnWdLClw1EaRmGHgrytqRZzGKvXiW6BtNvbq0GTRE7tv3Bfg6jnGSOgrl6RSEQywjOi7JYLx8Bpjn90ROgAvwfRPAUchGkTn/WyByc0gCXyiAA/SbdnfNKmXZipoYNAEzcbjTdHgzmg6//t3o4QFywWiAjUlvp8nZMzjuFtpaW+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1425.namprd11.prod.outlook.com (2603:10b6:405:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Fri, 18 Mar
 2022 00:11:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 00:11:46 +0000
Message-ID: <c4133781-ed3c-4a8b-eef4-96894399cf4d@intel.com>
Date:   Thu, 17 Mar 2022 17:11:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
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
References: <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com> <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com> <YjK5ZWJRQX+lyUxS@iki.fi>
 <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com> <YjO7WWEbGPbPCe3/@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YjO7WWEbGPbPCe3/@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:300:117::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9856d0-b01e-43ae-843d-08da0873e36c
X-MS-TrafficTypeDiagnostic: BN6PR11MB1425:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1425534C2F7A1A695435DB43F8139@BN6PR11MB1425.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9HgUD+v/Mq6uO+zR1wm6Kl7w6oJoygUt563Sbc2LtR4HzxwF4zcMH/bdHWTjAFiZ+bygAiQkmwvfF6zLAynuFIEVAERB/8ldVmYGB5no55jgcxxFJneMGFHiJRmDe79J97zc20KKDJJtFl2XhMFfwLIPnbIlF6D+uVbnA9m5U5KNgRh8PoHt5nE16mAaHtjXz8W6p955owfnJczGKTpAa8fpPpwmjBp8yczXYcAjC1b47FKiI2YC+2SeAA5RI4WcW/9u0FByEV3NqsbLd6jv5TZ7V1B18yX/C2IhImecfnICPmnrSeuBVmLAlt2AI1nZB7imXBQ1sqNaYZMLCTg7jReNLcq+ChA5qBQMyXaled2j9MWbVyLtUpzL3IYGscGmzE4J3YQ878DvrBDRMWjm88CeD8MZn7FLN1ZHpI6QMAWVKjtB2jEqScNSTgu/OOGmQIwvjPcjYwCMQGOLi87ndi6W0jepepuXpxVrEmTHpFS2SnZczEXZGyB6atmWzw0PqmE7F+Iqxl7WmZC5dfqHrumE+T1nCHiZ+siyy8+ZW3YQFWdjhrP3LsnICf5JH5LKb9T+gYY6QGGRYcb3rMeoO7bTdqpTmTO1RbRZX4xW3E54Hhs4BdGXk/1RdfxZeHMevHs1AFYZ3vbXVIK+ZE2VZ4xXFhx3t72HaedeNTTK+0zmv9azFa6vWLt4DHW2na7Pmhn0oj7qHqGO3/Jjw9kf6nLlEI3yHbPiA+tuFe4mMvSnCfwNmc10XB3JeJ8Fcqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(26005)(186003)(5660300002)(38100700002)(82960400001)(54906003)(6666004)(86362001)(36756003)(31696002)(31686004)(508600001)(44832011)(66946007)(8936002)(30864003)(7416002)(2906002)(6512007)(8676002)(6506007)(53546011)(6916009)(6486002)(66476007)(2616005)(4326008)(66556008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tvb3Z3Uy9EYUdsODhvdFRxRXAzMUt0RUtFVzg5UVJoNE1SbjJxTjdJMEk5?=
 =?utf-8?B?cVdXZWdpUXFRL1cxQkNlNFJFeUJkNWkwWXlEZmhmdkR6WnVwZWxHa2ZmdTEy?=
 =?utf-8?B?cnNkS2YzY3g2TVM5dytuRW9IallUR3FsNm1hQmppWVRMMEZVT2Q1cnNKdy85?=
 =?utf-8?B?M1pTc3duYTFqS2l0aE1ENTR0eGM3WDEwNEw1L0JGNlJ3MzRueW5ld2RVeUtG?=
 =?utf-8?B?NUhTdWhJc1RNb1FEMW5WWXdMRjVOK3B6citLQTkrU3puSkNxbWFxWjlzTWRa?=
 =?utf-8?B?VjBOS3hqdmo2NE1HS0M5TjF6MmQ4S2ZodWlFaUQvWlljZE5yclI4ME5uNUEv?=
 =?utf-8?B?anNGQkU3ZFZYZk12c2ZXZE5YRG9RTTBReHlvQ1ZXK1llb0pNUzZESER5dUNv?=
 =?utf-8?B?T1NtUGN1WGtielF0TGtldGlxM3VxMXYwa0lwUUtDQkQ1UDQrajdrOXVnQkdn?=
 =?utf-8?B?ekkzWXVQbm12ZmwxbjRGcmRDN0RjY2NGRVRIbXJDSFRRZWdEcXpBWU1XYnh5?=
 =?utf-8?B?VC95NEN1MmNvY000bUVTY210cnJFQlZhNHcxUG4wZmJJVmMxejFFS1ZCREZT?=
 =?utf-8?B?VFNKV0tnNWN2eGRJZU9yb2tGaFZ5U3lCb2tXMXl5QmlKZWZrTTZ6U3kvcHhx?=
 =?utf-8?B?OHY2MTVKandEUi81VWVxb09iZU5LdmJCbldVdXJ2YVUzSThueURtbFFBZ2po?=
 =?utf-8?B?SXYwdTB0L3JsbmVqUTFuTmFZRVBDYmxoOFdmejRLWE4ybDlZN0tFWWVWWGRV?=
 =?utf-8?B?OUZWRkRvWWVJUmQ3YTRqcllVNElITElrOHlWeDNGbkQ2WHlabTJibk9Gekl4?=
 =?utf-8?B?UkxrNXlIV3FvN00zb29RQ2o5ZXZRVjV4L0FvdUtBcjBWclB4OEt6SmpOUUJv?=
 =?utf-8?B?YTRlTFgwOFppSXRMT2FUWFhFcDF0T2sycTVaSG9Zb29ncGY4dG5pcnpEa2Vu?=
 =?utf-8?B?Y1d5Sk5qOHBldDUxdnJITmdpU1lYM1U3YlcvSDJwcDdjbVVwK0ZpM1JyLzJz?=
 =?utf-8?B?clkrQUIyRXlLbzgvaGgvQkp0QWwzYVpxQUlPTEFTcFpyQzhPU3ViazgyU3BZ?=
 =?utf-8?B?Mm10MGZ3TmNJQ24weXlndHhaMUNpdTB2dW82clRoanduUysvMjBub0g0VEpK?=
 =?utf-8?B?RG9jcGxhWnV5SElhNWwzWkJXQTJyWE5Wb0RUcmRxR2swVyt3aStiVkZBSnE0?=
 =?utf-8?B?UDY1TnlJRDRub2ZHM1NmNGZwMHMxWmVZSjAwNGRDdEZKWWpMYWRBY1pqeFBx?=
 =?utf-8?B?eWRVcUlTYU9zSFYxNFZBMXV4cnVGL1pjT1Z4WkF4RktuaVVNcjBGUnhvRm1K?=
 =?utf-8?B?NVptY3RHOG9NWGQ5TFhEZlc1VThTUi9qRDNhZHc4R3diRVE0TlpaaHpHTXFm?=
 =?utf-8?B?QWtUaVFLVUpkNTIwc2FmRGVTTWt3WkxIbnhNZWFTU2J5cjk0Y082M1hpSFM5?=
 =?utf-8?B?MFVGWXZZdzJsaUgzRjRpY0crN04wWE1QNDF1K1p1WFlqdWk5UUhHWmh4WVVX?=
 =?utf-8?B?ZHRzWjlSTmtwTExGMHl6bEpnRE4rQW41YzAwK2pFZTg2SCsxNmptcnNUdFNR?=
 =?utf-8?B?bnVLRzQ3M3E1YVdDZ2lvejZZUWd3WGhDelpkYUwxaE1CZ0hKS3gvcThrRW9Q?=
 =?utf-8?B?SGZqOGppQTJkckpabUEycTBlQ1JzTEt4dCtxUU9KYnh4OFhTVUszaGRCMjRD?=
 =?utf-8?B?blRYSjBUMS9kTHlLeTBvMFRYQTRYOE9RTit0SVZNQ0g0SjV4NDRjMmRVU3pD?=
 =?utf-8?B?bGNGMi8rNEJaOW92bFkrK2hjWWtZRTNTR2t1QlMvY21oUWhWTGs1MHVoamtK?=
 =?utf-8?B?RDlqbzVCYzdWVWJHZFQwaTQvWHBoYzh4NnR3UUZac1kwWjdma28zZXJCTU0y?=
 =?utf-8?B?ZVJJOFRRcjAvSnlyYVBqeWd6dklIcTdEOG1pbmVscU4wcDhUdGh6TkdzSVQ2?=
 =?utf-8?B?TUVUMTAwcy9YdHM0WGF3YnlJSFBvNmF5RSsrbGs4UGk3Y0ZrUExwOFliU1RT?=
 =?utf-8?B?aDcxSVhxckZRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9856d0-b01e-43ae-843d-08da0873e36c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 00:11:45.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKjDsVVtLqf+OteuNlnyLQpfZ2FkbU8eNtFLW5AKHQ8UBHKjby7iMjFmULi7vEczLFz/A8oCFDiloQZTS0/jHwCGvutZte+4fU+5r41jeA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/17/2022 3:51 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 17, 2022 at 03:08:04PM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/16/2022 9:30 PM, Jarkko Sakkinen wrote:
>>> On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
>>>>> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
>>>>>> Supporting permission restriction in an ioctl() enables the runtime to manage
>>>>>> the enclave memory without needing to map it.
>>>>>
>>>>> Which is opposite what you do in EAUG. You can also augment pages without
>>>>> needing the map them. Sure you get that capability, but it is quite useless
>>>>> in practice.
>>>>>
>>>>>> I have considered the idea of supporting the permission restriction with
>>>>>> mprotect() but as you can see in this response I did not find it to be
>>>>>> practical.
>>>>>
>>>>> Where is it practical? What is your application? How is it practical to
>>>>> delegate the concurrency management of a split mprotect() to user space?
>>>>> How do we get rid off a useless up-call to the host?
>>>>>
>>>>
>>>> The email you responded to contained many obstacles against using mprotect()
>>>> but you chose to ignore them and snipped them all from your response. Could
>>>> you please address the issues instead of dismissing them? 
>>>
>>> I did read the whole email but did not see anything that would make a case
>>> for fully exposed EMODPR, or having asymmetrical towards how EAUG works.
>>
>> I believe that on its own each obstacle I shared with you is significant enough
>> to not follow that approach. You simply respond that I am just not making a
>> case without acknowledging any obstacle or providing a reason why the obstacles
>> are not valid.
>>
>> To help me understand your view, could you please respond to each of the
>> obstacles I list below and how it is not an issue?
>>
>>
>> 1) ABI change:
>>    mprotect() is currently supported to modify VMA permissions
>>    irrespective of EPCM permissions. Supporting EPCM permission
>>    changes with mprotect() would change this behavior.
>>    For example, currently it is possible to have RW enclave
>>    memory and support multiple tasks accessing the memory. Two
>>    tasks can map the memory RW and later one can run mprotect()
>>    to reduce the VMA permissions to read-only without impacting
>>    the access of the other task.
>>    By moving EPCM permission changes to mprotect() this usage
>>    will no longer be supported and current behavior will change.
> 
> Your concurrency scenario is somewhat artificial. Obviously you need to
> synchronize somehow, and breaking something that could be done with one
> system call into two separates is not going to help with that. On the
> contrary, it will add a yet one more difficulty layer.

This is about supporting multiple threads in a single enclave, they can
all have their own memory mappings based on the needs. This is currently
supported in mainline as part of SGX1.

> 
> mprotect() controls PTE permissions, not EPCM permissions. It is the corner
> stone to do any sort of confidential computing to have this division.
> That's why EACCEPT and EACCEPTCOPY exist.

Right, mprotect() controls PTE permissions but now you are requesting it
to control EPCM permissions also. 

There is only one permission field in the mprotect() API so this implies
that you request VMA and EPCM permissions to be in sync. This is new
behavior - different from the current mainline behavior.

> 
> There is no "current behaviour" yet because there is no mainline code, i.e.
> that is easy one to address.

What I described is the current behavior in mainline code. It is the
current SGX1 behavior. Running an environment as I described on a SGX2
system with the mprotect() behavior you propose will see new behavior
with some threads encountering page faults with SGX error
code when it could run without issue on SGX1 system.

I do consider this an ABI change. It should be addressed
before using mprotect() for EPCM permissions can be considered.

Please do provide your opinion about the ABI change.

>> 2) Only half EPCM permission management:
>>    Moving to mprotect() as a way to set EPCM permissions is
>>    not a clear interface for EPCM permission management because
>>    the kernel can only restrict permissions. Even so, the kernel
>>    has no insight into the current EPCM permissions and thus whether they
>>    actually need to be restricted so every mprotect() call,
>>    all except RWX, will need to be treated as a permission
>>    restriction with all the implementation obstacles
>>    that accompany it (more below).
>>
>> There are two possible ways to implement permission restriction
>> as triggered by mprotect(), (a) during the mprotect() call or
>> (b) during a subsequent #PF (as suggested by you), each has
>> its own obstacles.
> 
> I would have prefered also for EAUG to bundle it unconditionally to mmap()
> flow. I've merely said that I don't care whether it is a part of mprotect()
> flow or in the #PF handler, as long as the feature is not uncontrolled
> chaos. Probably at least in mprotect() case it is easier flow to implement
> it directly as part of mprotect().
> 
> Kernel is not the most trusted party in the confidential computing
> scenarios. It is one of the adversaries. And SGX is designed in the way
> that enclave controls EPCMD database and kernel PTEs. By trying to
> artificially limit this you don't bring security, other than trying to
> block implementing applications based on SGX2.

I do not follow your argument. How is implementing EPCM permission restriction
with an ioctl() limiting anything? 

> 
> We can ditch the whole SGX, if the point is that kernel controls what
> happens inside enclave. Normal VMAs are much more capable for that purpose,
> and kernel has full control over them with e.g. PTEs.
> 
>>
>> 3) mprotect() implementation 
>>
>>    When the user calls mprotect() the expectation is that the
>>    call will either succeed or fail. If the call fails the user
>>    expects the system to be unchanged. This is not possible if
>>    permission restriction is done as part of mprotect().
>>
>>    (a) mprotect() may span multiple VMAs and involves VMA splits
>>        that (from what I understand) cannot be undone. SGX memory
>>        does not support VMA merges. If any SGX function
>>        (EMODPR or ETRACK on any page) done after a VMA split fails
>>        then the user will be left with fragmented memory.
> 
> Oh well, SGX does not even support syscalls, if we go this level of
> arguments. And you are trying to sort this out with even more flakky
> interface, rather than stable EPCM reset to read state.

I did not find your answer on how to handle this obstacle. Are you
saying that leaving the user with fragmented memory and inconsistent
state is acceptable?

Could you please elaborate? I am trying to understand how to support
this permission restriction with mprotect() and I get stuck on the scenario
where VMAs need to be split - this has to be handled if we go this route.

If it is possible to integrate with mprotect() then I can do so but I
do not see how to do so yet and here I mention one issue and you
again just dismiss it. If we are not able to handle this then it is
indeed mprotect() that will be the "flakky interface" and we should
stick with the ioctl().

 
> I've been implementing this exact feature lately and only realistic way to
> do it without many corner cases is first use the current ioctl to reset the
> range to READ in EPCM, and with EMODPE set the appropriate permissions.

This is supported in the current implementation with the
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl().

> 
> 
>>    (b) The EMODPR/ETRACK pair can fail on any of the pages provided
>>        by the mprotect() call. If there is a failure then the
>>        kernel cannot undo previously executed EMODPR since the kernel
>>        cannot run EMODPE. The EPCM permissions are thus left in inconsistent
>>        state since some of the pages would have changed EPCM permissions
>>        and mprotect() does not have mechanism to communicate
>>        partial success.
>>        The partial success is needed to communicate to user space
>>        (i) which pages need EACCEPT, (ii) which pages need to be
>>        in new request (although user space does not have information
>>        to help the new request succeed - see below).
> 
> It's true but how common is that?

The kernel needs to handle all scenarios, whether it is common or not.

> Return e.g. -EIO, and run-time will
> re-build the enclave. That anyway happens all the time with SGX for
> various reasons (e.g. VM migration, S3 and whatnot). It's only important
> that you know when this happens.

Please confirm: you support a user space implementation using mprotect()
that can leave the system in inconsistent state?


>>    (c) User space runtime has control over management of EPC memory
>>        and accurate failure information would help it to do so.
>>        Knowing the error code of the EMODPR failure would help
>>        user space to take appropriate action. For example, EMODPR
>>        can return "SGX_PAGE_NOT_MODIFIABLE" that helps the runtime
>>        to learn that it needs to run EACCEPT on that page before
>>        the EMODPR can succeed. Alternatively, if it learns that the
>>        return is "SGX_EPC_PAGE_CONFLICT" then it could determine
>>        that some other part of the runtime attempted an ENCLU 
>>        function on that page.
>>        It is not possible to provide such detailed errors to user
>>        space with mprotect().
> 
> Actually user space run-time is also an adversary. Kernel and user
> space can e.g. kill the enclave or limit it with PTEs but EPCM is
> beyond them *after* initialization. The whole point is to be able
> to put e.g. containers to untrusted cloud.

You seem to be saying that while the kernel could help the
runtime to manage the enclave it should not. Is this correct?

There may be scenarios where an enclave could repair itself during runtime,
for example by running EACCEPT on a page that had a PENDING bit set.
This information is provided to the runtime with the
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl(), but with this mprotect()
implementation the kernel cannot provide this information and thus
forces the enclave to be torn down and rebuilt to recover.

Is this (using mprotect()) the kernel implementation you prefer?

>> 4) #PF implementation
>>
>>    (a) There is more to restricting permissions than just running
>>        ENCLS[EMODPR]. After running ENCLS[EMODPR] the kernel should
>>        also initiate the ETRACK flow to ensure that any thread within
>>        the enclave is interrupted by sending an IPI to the CPU, 
>>        this includes the thread that just triggered the #PF.        
>>
>>    (b) Second consideration of the EMODPR and ETRACK flow is that
>>        this has a large "blast radius" in that any thread in the
>>        enclave needs to be interrupted. #PFs may arrive at any time
>>        so setting up a page range where a fault into any page in the
>>        page range will trigger enclave exits for all threads is
>>        a significant yet random impact. I believe it would be better
>>        to update all pages in the range at the same time and in this
>>        way contain the impact of this significant EMODPR/ETRACK/IPIs
>>        flow.
>>
>>    (c) How will the page fault handler know when EMODPR/ETRACK should
>>        be run? Consider that the page fault handler can be called
>>        significantly later than the mprotect() call and that
>>        user space can call EMODPE any time to extend permissions.
>>        This implies that EMODPR/ETRACK/IPIs should be run during
>>        *every* page fault, irrespective of mprotect().
>>
>>    (d) If a page is in pending or modified state then EMODPR will
>>        always fail. This is something that needs to be fixed by
>>        user space runtime but the page fault will not be able
>>        to communicate this.     
>>
>> Considering the above, could you please provide clear guidance on
>> how you envision permission restriction to be supported by mprotect()?
> 
> I'm not specifically driving #PF implementation but because it was so
> important for EAUG, I said that I'm fine with #PF based implementation.
> 
> Personally, I would do both EAUG and EMODPR as part of mmap() and
> mprotect() (e.g. to catch that partial success and return that -EIO)
> flow but either works for me. The API is more of a concern than the
> internals.

Are you now requesting EMODPR as part of mmap() also? Could you
please elaborate how mmap() and mprotect() can handle partial success? 

Reinette

