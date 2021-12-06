Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3246AA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352105AbhLFVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:40:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:9834 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352080AbhLFVkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:40:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224665651"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224665651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="502293768"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 13:36:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:36:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:36:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:36:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT9q1mgGE3lWumRK2emYHUmI9tWTU+fzMHk1R0DlfqsNRC3D7+KVzHpSI3/zCz8n4p9d3AJ0NahM5lh9rLL37Mv8nLF7SbxjhhwNaryWtPicA3z/YgkRJfz+edTS4nj7ngGR5SUvKLeSQp9jhHyo8nuYq1qYdW80ZyaWHnAjriBSFIA3+GEhhBwZVj55FdwqEwhpDNgyOyL+cMVBJ24XD9rXbfg/AcQIOqlLIibSr2IBNqnd1OVXpLet5JmnU7Aq1FLWHTftU7d/MJioJndgV2dEo+O79566hSPKXo+n1zG/H0yYzOLyyWq1UHKcul4hsdaT9HiCaFMos2+le6wekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ABT1Yr6DUyJ140344yja9xy4Dh/KdxGD0MvAhZUj4E=;
 b=BqyPczDrmVRo3G2adoA8g7Ao2A+hhTNOfgi4cKnCCHWaguhDPsyzRHsPj3kW1DKyAKrguzgijGWieCeyZ40+c0S7Wefup0F1McG8bgJK4fwEbBzCabbZIOgVW9FgouCmHXF1Ijw6GsqSicRmXMnnBR5YPAeL6oc+3LY9PQSCZdb3ChpUziQdYfQW/HQSps9uGWMGhacFPbtPxUykbmXxvG2xBQhJsNgsgjIHvsG/UPUZjJQDSnVd/uAAVWDF70slzVLhx3ZQ3RkN5g8rDDGMsIvQPlv1JDxDRSQAh5vdZ6Ci6p4A4wcDKDq+V/s4TnKgSZKiA1bgVLVNRNDscfVk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ABT1Yr6DUyJ140344yja9xy4Dh/KdxGD0MvAhZUj4E=;
 b=RH8U9rXdCwz89R2M+5f2i6sv/yt00+ScXNVHZ9s7u64WmZpuBMsclWO0YXAPYH2xV89OMYSXv6HnB9Vmv7xe3U6vX7n2RN02cY7L3zdF4ZN0yw0lK8MsKp2NCIWiitrFenMjc29sXWT1HD7c2q0vDQkXDPqDLCSmleablZa3uP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3636.namprd11.prod.outlook.com (2603:10b6:408:8c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 21:36:54 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:36:54 +0000
Message-ID: <bda9f351-6820-5978-44c5-0ca48fe7f31a@intel.com>
Date:   Mon, 6 Dec 2021 13:36:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 08/25] x86/sgx: Make SGX IPI callback available internally
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
 <d4c030fd6bc8d5a618204abaea4b97489f137cc9.1638381245.git.reinette.chatre@intel.com>
 <YavzKF3LooOmj3Un@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YavzKF3LooOmj3Un@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 21:36:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960b2167-0c24-4da0-beb0-08d9b90085c2
X-MS-TrafficTypeDiagnostic: BN8PR11MB3636:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB3636CD729E4A9BF8FC7560F1F86D9@BN8PR11MB3636.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EolXzjxvuQvvoqMRE4ITvlooePfn9CENSMgISJDOGK7jtqqBONXWE/dM2MRwIQtWQMPFDJvwp04dOA4Vc3ENm3dKgMhfGDqlnk2YG/IOdoTNj1SNMNeuUglOdIvGg5McptTwh1A7QmyixsrChfaiRb+gdJcS9Zuq64ZXkTTu2oy6BQdhiWeP3zuraxnvoELNiVL5T4ZPO/9psclmrFtHix4CjNuYKGfQO2lrDSO6sIWm+FP2wEdwwPv9oz/HFJ+eeMbpECmxRRDDVf8J/qKgrM3LRGt1NJBqX06cy8Sj264trQ6+TeXpmSWbMJtbkpAGU+Op4mIwgxABoJlXXCGdCgM9zXcq2FlZQ5wDRHgPAPuXDXlmD9f5jhPnkYOvm9a88hOOe40YBVYH+w2O16rKsZPClYGqJLdJ+G/KNQmMKPJks8qKF1HzTen5UUJ02pHWaY7c52PWfBCpJeT6U1ftMQI8VFeMFxGeINoBRD1iaq7i4mIVfjH8WEciQ59k+Y/CGo+BM3oFocsrdNCAVbQEMJb79LTKl5dclZ4HV3j5wOZe1XMH1k/nAXpHmmI4tAsEEL8173hwNq5yqxZ/JCQT/wSavBad+kjprsTJT72G0j4fGtjGCGneBtkgi4kA7t/gdD8DdNYgS5csGykDGu33ycHZvI1+is1ejg06kzhYE2oye2MlYWTS2U96T53Ur5/jEyBKSn3mYqdHhxQdLp7TlKtYtpeJDhKF0n8dKeRgrASUIK8My1o691Mqbu8Mmwi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(508600001)(186003)(66946007)(6666004)(38100700002)(6916009)(31686004)(26005)(5660300002)(86362001)(53546011)(66556008)(7416002)(2616005)(66476007)(956004)(36756003)(4744005)(6486002)(8936002)(16576012)(8676002)(4326008)(31696002)(316002)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhuSU84NG8rVnVPdnl4eTZGMUdWMWR6Y05TV3MvTGROTEFEZWpVYzl2c1lI?=
 =?utf-8?B?UlY2azhINElUVjh0NmRkazlONEV1L1FOZGh1bGMrdFdCVGsyMml6MEs3WUMx?=
 =?utf-8?B?VExxc2taZGlXMTAxTzJpYzlVUGlsSVhqeEdzL2gxc2hmSGltWGxpZGtLOHNP?=
 =?utf-8?B?TjFCby9pOE1EaG5KTTRHUGE5a29TNVkxWkRab1NIYmdQcGd1SlJqWGJRT1FR?=
 =?utf-8?B?aWdvbXdLWUQ4d3YyZENxTThGM0xJbmh0dEVqMk4yQ1p5ZFlTRENMZDN1YWY5?=
 =?utf-8?B?ak93d2IwMm90ZUg1YUtnWktiZlBsR1U4bFpQL3NaYnVnWGhWVEUzSTlKVFpx?=
 =?utf-8?B?U0NYTlJjVURnQ28ySy8rUFdORVU3WDlsTnZnNUJ0NG55ditWWTFxWUdMT0Iv?=
 =?utf-8?B?TnZqM3VsNldvZEV1MjNHZ0pPZnk1T2xHTlhCUGpHZUlVK2txalM4cjQraUdS?=
 =?utf-8?B?REtuRXR4R0FraWJIcGdqL2F1OGsrOTJ1bDhZZ2VzU0NpOXBIbGI3dWlWdExI?=
 =?utf-8?B?K1NRY0Npd1REUWpNanlsK0hlaGVGQnpqSjA5UmdhV04zZW5tS1lTUE9uK0Zk?=
 =?utf-8?B?dFU3M2xjZTRoeEFpSTR5NVNkck1GdVhLQjdqYUF2UWU4MWJiMkpuMDdNdGdz?=
 =?utf-8?B?MU5KcVRyWkd2d0hCVDNOODVaclpXK2hEODV2MGtpQXFhVmlXZ0N3VW1GaGpL?=
 =?utf-8?B?RXFBZU9Pd1gyZXV4T0JRMXhCL1M2S0NuTExqaXUxVWFldURXaEp4a0ZCYVZi?=
 =?utf-8?B?ZXFXN3NzbDFGV2xwS1o5eUlhVW1KeUE3V1ZaeDhUeXBMOVRMVmhINDBianpP?=
 =?utf-8?B?cHNTNWNTeWhrWTJGWW9GU0xRS0VsZy9PVnA4Yy8vUEdkVi9ibTYwMEdBMFUr?=
 =?utf-8?B?TTQrZmw0VEMvMUtLYkU3aXhWNjhGRStDV3dDdW5tRWQ3WHlDSm1lbU1TMHEr?=
 =?utf-8?B?K3hzR3NhbVZJcXJaSHB1SjA3bFhJKzBOVEp5N2xKQzRnT0pXc3QxM1dEVXg3?=
 =?utf-8?B?bjVXcFhRbXhTK1dMZGp5K0cyVFN6a3ZZM1c2cGJHRE1scGxFWStiVmpKczNr?=
 =?utf-8?B?ek1qY1FLRjJFbTY5MzNTbHpFZGZCMTNBcU9ucGl1YnV6OC9HSERkWkU4azY5?=
 =?utf-8?B?QXF0S2xwQTdFdUZUSUd5MXJ4d0pHY09MWFJuTHVCdkd5NU81L09kandxZXZt?=
 =?utf-8?B?K0MyZXhkSHd5UVVaRkZsM3VRcUlKVUVIYUwxYzdibTUwVXk5STc4blVGRHRP?=
 =?utf-8?B?VENGU0RVM0xXSVFSVEt6L0JxaG91MkRBSVRHTkZCcWtGOWtuc1dUdHNoYWtE?=
 =?utf-8?B?eTExSEIzU1laRS9WOEFCN3l6UlNKL0JWdUUvMVNoRjdFRytibDl3Z2h1ajJx?=
 =?utf-8?B?cVpIUzdrVFFqbVVoY2Zkb2tlbm96dnhRS085aFRGR1F6ZmxPaHBUWGpOaEJp?=
 =?utf-8?B?T1BUMVlvVkhsTkJJQXhMZTZncjRkS0hPWmpROTZwcGZxVjFYZFppZHN0Wi9C?=
 =?utf-8?B?U0J6dWhPcSszeUxud29VZU9SaFZLOC9qQi9Yd3V3eXBMME5aWWd2L0RIcDBH?=
 =?utf-8?B?Mk02RTljSG5QMFZiSk5hTXZsMEhUU1FkQ3Z4MU13SUlvNnpTTXZmT3M4cHFJ?=
 =?utf-8?B?OS9ycElNQzdLVmUrSzZXL3pYUmpZTjhINUVSRW1DSDJyem9BUmlHaUJOQjVa?=
 =?utf-8?B?bHRKOURVbWM1UXBtek9ndkRDYWxibGxNcHBNLzBZVGNCdVA4YjE4R21IOWhF?=
 =?utf-8?B?aFJ0UEVpbnNjRzViM3hBSy9pRHhRZ21EZ2RmYUt0UXJadG5qMzRTNnB4UGVw?=
 =?utf-8?B?L0ozaklPblVid3lIbk9uY1grL1NUaG55dXJSWm83THFvTkU3MzZqYWRYcldB?=
 =?utf-8?B?aDcrQ2JHeFNWc09JcUxYNU1aSVgwR2tHMGtLZ2o5MWdVMU1idHp6MXIzeW0v?=
 =?utf-8?B?Ty9zdTY2L3h2NFNnWVc3b0FLeklqemM3OGxWNmU5ckt2TlVHT3VMV2NOZkpw?=
 =?utf-8?B?MUV6VkpCUU9GTEFUWTgwU2JqWHJNb2NTZVlqWjFhWk5mZlJDa1JPVzJkdkVn?=
 =?utf-8?B?eWtuN3E0ejIwOVFVOHpmQ09VczAwWWxaK0FiNmFZcTNLenVSU1ZvZ0h5VTV5?=
 =?utf-8?B?dVhPVSt1cW4xWkhTdnhwUjRBbGFyWU5JZW5kdGJSVGhaZllpSkpmV2lmb2U4?=
 =?utf-8?B?R2QvZjR1b2VaRGdWUkJBdUZPVit2N21tS3QrSW94dHlUaDFyeWg0d2NrWjZL?=
 =?utf-8?Q?V8zlNWL8m8AwSrPGumbdB6R/RSlUrcUJvw9EUZQTuk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 960b2167-0c24-4da0-beb0-08d9b90085c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:36:54.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IUdj63XsLRuS147TRKrpWp2SJSUQsnrf5M/S59j7/YABmFj50DJtK/Z1zIAXyrTPIj5BAMvg8+6LGxdvsHwuNkg4Bgv7iaFDwc5PgF+LaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3636
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:00 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:06AM -0800, Reinette Chatre wrote:
>> The ETRACK instruction followed by an IPI to all CPUs within an enclave
>> is a common pattern with more frequent use in support of SGX2.
>>
>> Make the (empty) IPI callback function available internally in
>> preparation for more usages.
> 
> Please, just describe the usages that this is needed for so that
> there is zero guesswork required.

The reader is not required to guess. The first paragraph states that 
SGX2 also uses the ETRACK flow that relies on this function. What if I 
replace "for more usages" by "for usage by SGX2"?

Reinette
