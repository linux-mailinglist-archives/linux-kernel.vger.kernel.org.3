Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4847373A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbhLMWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:07:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:54248 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243438AbhLMWHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433222; x=1670969222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iWT4YWgm7X5rGA1KlMZHMMj50sz4Qc61hNV075SKNSA=;
  b=EluRB4kXWj8XpFz6FsMFyxhu7fb9eC4dbriAhvurD2woJRGChxBKvCIh
   BlRRmg2Pps0NK4eiGZtlqRAjEx9h17D48JcEjhXmvdSe82ev+IhftL++H
   FtLzwiAv69fyV5JUfsY+JWqzvMDt5wntKihjODjdbl3Y58Nnnh21oqNHs
   s6HV/hY1ktvytIa0AEcNx0KMt46cnzlJ3AivkDrrrhdhSt6mIhVcs5HQU
   kx3zaMbbA1X7MBABMPXN9VpXNeYwOM2I/JQmsFotsuAgDpP6vkc5g89LH
   8NZGG33qCBXcUQDgpntdZ08kUt1O6GW9ontQxwUYulPd7SZTzR7jynX9V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299621049"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="299621049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464817794"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 14:07:01 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:07:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:07:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:07:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI7z0UPin+UQ2x9bUhdXAeZXNhwmXaTnEeZWMglJuMH7f6i4vwFJGh4pdpg5QJVze/Pr1Uq6qvVoTsQMZgE8M5OjRVg3Va7Yw1V+pVZbC7fyXDXtXwFk8ZGJNEA0exSnviBFzkUuiGDqYnS1uHnd+aIap87OFSmdC6zs8Nvpr4VDsddH4Ycecdq4KueuUzcS3jURXi2BiomxekDV32Ot7Z3C4zhSkAa7wuc7CnjZJ5ZCChNuTtPDCDRTyt1ubfqksUFJzlO47xE58qziQlnTf3dpcGPuolZ1K4qxUuCa8B0XTWksOBMOXUtfL+qdTB8okOmGTDHKLhJUxM1z+836Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5Rb6qPqzNt9YkMcKrBsCcU7iy1mcE5dndzmQVK8+lM=;
 b=R5IWlVSsFYYLstwKiDRWr7hsP4Glv+aNbefBR3jhyILZdxJMWommI2R7+CD0SUxdy96lKN17lcYVKIbZC8juzwxfn8WkmnuU/98VMn2Cd3iswm/UlmxGz5X1UvTCzEfuFxVk21qdKDyGLiiA+14Wx+Vyp/bZy7zciP3dunaOHL4gnGSfQ4ho8bOTv5OUEPgbs2/KcAOlehA6+Kcbkg1jUAgs16rpUgV/iOz6kdkjPisfdv1jkmD7sj0SzOpoSEhadFl0AdgYtXrfuLPdf3Z19HqdnSNgY40w1QyF45Wa+FhmEvlSlTcocqZrHWWckfqI2NNtDqMYffcW50q/lYhuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5Rb6qPqzNt9YkMcKrBsCcU7iy1mcE5dndzmQVK8+lM=;
 b=pBUNF/L18ehIRPc54B+Q5K9Mbb7rO2ImFrFw16L3Cv3rto2cMniiFKIBVMAbWsUmbg0F7lb2t57Z3ChThoJHSsd2X60sztr1AYnlpafFyu25wq9khklCw3z8VxO/yc5vTVe2eQIkCx3wIBiwuWdq6zsXRCQnxtzgQTEXWwc7LHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 22:06:53 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:06:53 +0000
Message-ID: <298da104-14ee-45dd-0919-fb847fd34354@intel.com>
Date:   Mon, 13 Dec 2021 14:06:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 01/25] x86/sgx: Add shortlog descriptions to ENCLS
 wrappers
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
 <YauzxOEmmpeGF/K3@iki.fi> <b49ee68b-63c5-f8f8-ca2b-31663c3150f6@intel.com>
 <b6eeb67d3be33767a4d52d8e2009817a90d91224.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b6eeb67d3be33767a4d52d8e2009817a90d91224.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:104:4::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ad116e-efe3-4f34-cf12-08d9be84deea
X-MS-TrafficTypeDiagnostic: BN9PR11MB5292:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB52927DC1E4E9B25FA4E710F5F8749@BN9PR11MB5292.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsxkcPi+OXWnC8r+GymWvs5206+eE+ZL3J43oyClJklBAEWX3sQq6BDYjfIgKTnr5Lq9U9a63ibVdbyhCJPpx46TfNJ4XqHl/2PG7MzjEFdypY17xsYMKOhK6CNUCwRvUB3SJtqXmTuv/1ifo4NSyppOHEZauKufkrG9qt8G8l3aQ1RDhxwW/+u4ag6KCpV0L1zIL43IL+mpWsg4aRDNkX2/UmbbrLKdtCcGn48CJdjFVBf6qfYDJu/pCIQuyD2BLsekSoW7++CZQ/fJuu7vDaeI2xnNpUIMnBmgVuGfiU9Jl2FWbE2WRQsWL/8OlDGCLZ/vJFLE3Y6amtnjyelXXjh0txP22PvNBeceX9cA0nlRVpI/BlHGBktyzvwiZuZMsxlG+L+u7y09rWKgdZlZDoujAw9Z1F6RcOe2Fq+ySfyMMWzNe64f6nG/m9FS0Dv6gmBpJ1MSjVZcftUzJhp3WzLRUpmnxJswA1kbomGaoWJpgCDGXXvokNIQcuKNU29IGUztG4l0P+2K9OMS+f9WY0E9QM4zzTwxZ90oGSngJ428+bnLYLU5DxJZKWEW1DC89wtlKnLngACCgu+z/J5wHXAYxuy87UU/wAbjxTy6ps7YFddZ7Xi83sOSIsZeWXUKzrJqwRPPGzoMp5RNUK+lvRNFhn8OT3xTQQweIr5gnRvQSb154qABc6eE31neTdfwgB0OrRZrE0FVan7zuMhlI+H8UO1ZIRzo+HX8N6kOuoQwW1A4fg/3xQdMaOfcpne3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(4326008)(31686004)(4744005)(8936002)(6506007)(6486002)(2616005)(508600001)(44832011)(6512007)(6666004)(66476007)(26005)(7416002)(82960400001)(8676002)(86362001)(2906002)(36756003)(6916009)(5660300002)(53546011)(31696002)(186003)(38100700002)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQ5QUgvaVBack8yOE1LdGZpT25lRU9YcVZiVnJ2aWV2c1p0cUd4TFQvR0JX?=
 =?utf-8?B?bnZ5bjVhTTFXYm5LMW4xV3BmbUJmcXFvZVZKQ3l5ZmZ4eXNrWTI4YmVCa3Zt?=
 =?utf-8?B?TTNZYzVOeGRnLyszZThKY3pSQkhiMmgrRVBSMDN5ZUNKajJSZCtkUDdDaFA3?=
 =?utf-8?B?U3B3VURleURLaCt1U3lObDV6THJ2WnlqTCtZZFVlZk5PQ2NIQytETWZzdFZa?=
 =?utf-8?B?bUtZZUFCU1ZJbEVDb1FHb2R6UEN5V1pXd3VVbzd5bTJCeWVvWThvcGZ1K3oz?=
 =?utf-8?B?S0ltZEVLK3hxZ0Q5WnpOS0x2aWtabUxieWIrRHFnYlY1b1JYSmJRV0dBT3Rj?=
 =?utf-8?B?TFRMY0t6Y0ZxRXRNK0J5aU83a3FaUGdOYitsUS84TG5OSXBOaGlnbDVFVzJT?=
 =?utf-8?B?dmtWZkxESUNob1VjNlNIaTBmVFovelJRNXlJcUthM082SGlQd3FDS0JHM2dD?=
 =?utf-8?B?enRoVXBqYVI5Q0p2L1h0RGdhbHFiSjNjZ2J0RGU4emlNUjREYktqTVVkdGZM?=
 =?utf-8?B?ZVFibGdGUjVsVjZwOTdpZ2paQVdTOFhXS05TcklTeHZUN3hKak55ZnF2WnVu?=
 =?utf-8?B?anpRWE9ac21DSHRZNCtkZkRjZ1VhQTRSZmRoU013ZllkYmxidmtWQ0ppRU03?=
 =?utf-8?B?WVpCZlZVNUw2TWQyazhVL2cvV3lIUU1JdEdjTUtvRXpDblhmcm9ZL09ublRI?=
 =?utf-8?B?L3R5L0lQWTJ0MHZiUzZXNWVDSG9uQXR1YTZ1VDlWVU80ZTI0RnNuMnVDWHVN?=
 =?utf-8?B?c05OSXoxTmI1by9RZ0ppcnVaNWlrZjdJM255SU84Mzg3c3YzL0kxYWxocm8x?=
 =?utf-8?B?MmtkOHRMYjF1SjY4Q1ZOekxlblVkREhSZXZoOGhsVFlzR2c5dnBDS2ZVd2s1?=
 =?utf-8?B?aUFaOGRlSmpYbktzM0Rhbkd3QWtxL0tUYWVZZUFPN0NYZTZ3TmNZNlE0K3ht?=
 =?utf-8?B?ZFZITG9WM1pRTER1T3FqanlnV3dpM1E1Y0xXUWMxRTZYNTZhbytvNjFVemxk?=
 =?utf-8?B?Z2RiSVlheS83ZUwyakpiWnNVZmRGd0Rjb29tY3V3UlE0REdxTnNhVnlIVVBS?=
 =?utf-8?B?WXN6RHFtOTB0TkJVa1B0bzJSV0NWTDJJWm9LdXRBU3pMNEpSUlR0MTdCUTF4?=
 =?utf-8?B?bmpraFFhbFBwNU1iUk5yVGt6aWc2Mno3UnJaZ3BzZ2ptUGg0Q2ZBdDFUVk1O?=
 =?utf-8?B?ZlZVVmlMdWNuQlRLOGkvWkdDQ1hqZ2FCMTVFVEFHd0ZuNEYxT2d2RHJpMzdQ?=
 =?utf-8?B?Tks1cnU3QVl0cWs5N1pocjU4UmxMYVdoQmJ6bEQ5R0pKVTJnUnhJN0tZdkRr?=
 =?utf-8?B?T1IyZUxZQkVDcnlVYWZqUjA4VlNOK1BiM2Z6TGdBMW9ETmtoN0pFNisyd3hR?=
 =?utf-8?B?NkVqdS9oVTYrbEhMdFQ4bVUwYm9rblQ2WWhQRjZPZXZ1aC93Y0lGOU9QUWdN?=
 =?utf-8?B?cTFUc0NjelBaUUZvMnhHRTJPQUl3OUppK1gzK0Rlcm1EamVaVFVNNjIzN1FF?=
 =?utf-8?B?b2JTV29uZ04zTmJjYWdOaTJJN3NWT1dyOTk2QmcydFlsejJiTWhFR01LSkVU?=
 =?utf-8?B?aVhnQjhJU3pEUFFxMTBuTE04SjBKVFlXam9qdWJKckhaT1owMDVERVNSMzJw?=
 =?utf-8?B?bm8ya2VwZmVZVzlWZ0ZRWXJ6NGZQek9ya0JPK2QxTzd1TXFYUng2L2RVRWxo?=
 =?utf-8?B?WDl4NldmVWRFTmJHd0pLYklEYWxoTVdjR2plNTlPS002YTBpeCt6NDNKa1ZP?=
 =?utf-8?B?VWVxSmVreUtsUm50alRxaFFML2oyVUpndnU5SHJzS1Y5WC9tc1Y1WGF5V2hO?=
 =?utf-8?B?MnIxV3VGWUplNVhYTmhVY0M5L2hSZmNiTHJaL1NVU0FLUnFRaHVIekpJTi9m?=
 =?utf-8?B?NUsrekxqSW5CdWVZRDZtbTNPZFpCbWxuVGx5K1NLVExFbGRMaitIaTVrWmJN?=
 =?utf-8?B?QnE1RnpzZHRTZ2E2cDhrRmlJNGJHYTF6YWZiMkdrQWh6S1Z2eTFGNUtTOU93?=
 =?utf-8?B?OTJpMndhK2NTM1lsRkVVcHY1OWo2VEowKzhveFh6b1BQREI5ajZQMHM5bWxK?=
 =?utf-8?B?Mnd3YjlaY1pzb0phcFNyYWFlOUNZVHJHSHBZVTJzYi9HTlpXczhrODMvTjhG?=
 =?utf-8?B?SUNmRjR0VTJuZkV3NXRYM0JST25TMEZZSzN2Z0JzN0c4T01ydWRNYWFyYXov?=
 =?utf-8?B?b1BHaTdsWm83bkc0VFNkZlpIcGZkelJxaU0yZnFkcWh0OCtyUGFOb0ZjZXcx?=
 =?utf-8?Q?R6hVq8Edcn/FSpKRnG4Bj9M7y4hrFWAD3Sa4+0vikc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ad116e-efe3-4f34-cf12-08d9be84deea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:06:53.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l18runVwDnChMA58blfUCacwScT6O6EhP6Q5GjY9ydPxjs+7dUFMjybGrjn49gtEsmeLRkZBBIKVaOvSwJSad7EFRqHYIFDnvvKzAMwBJAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 9:28 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:13 -0800, Reinette Chatre wrote:

...

>>
>> __eadd():
>> /* Copy a source page from non-enclave memory into the EPC. */
> 
> Perhaps:
> 
> /*
>   * Associate an EPC page to an enclave either as a REG or TCS page
>   * populated with the provided data.
>   */
> 
> This is more aligned with your description for __eremove().

I was trying to keep the descriptions as concise one-liners. I'll use 
the text you provide if you are ok with its line length being an exception.

...

>>
>> __eremove():
>> /* Disassociate EPC page from its enclave and mark it as unused. */

...

Reinette
