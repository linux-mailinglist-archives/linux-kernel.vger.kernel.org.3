Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A915A008A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiHXRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXRjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:39:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27805582;
        Wed, 24 Aug 2022 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661362788; x=1692898788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i5sSNPCqE8CcVS/Z9sRIB4Hg/BngYSUMDZWZPtu9j5M=;
  b=Z3P2b03yQUUluKmcKi8H34irHClNQhAi14Wl3AX+meLzeCkExAF03P9P
   pDtivqFiF8gEFh83NQdQvd/kJFWag1MwAaMJ8ERUXq7nnar7Ewv0Illsz
   nQvBnBVWTdkLTydB5wIECRCvmT+ycDqq4ilJg0x0QKgqb9o8DOeSb9Yxh
   EDG/38cNjTbB262zSSlQnZobbJ2O3VW1PmfqsickesMHeaMvhRosBemBo
   qAgPOZViNCFoUn11aYP/nACTNs+rk+F6HBhcbHU7bt3QFLGsS79eFgQgJ
   jUFcZI1qS4xdMTEQaXJ+QHg0lBc22rQwSuOclcjeih+QsM6qiS3Az1/Hp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="281004947"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="281004947"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="612872930"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2022 10:39:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 10:39:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 10:39:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 10:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvNEKZ5QHzKBHDEZILHGF6r5Q/fdS2Nxl4De4179zaAVDWWpJZZ13RI6BfbkNtOm/e1A+bGPbqoZJM/WuAXj0dZEdo19GQ0+g8198+I0DQtRguuPDC64Xmj48v9RGFiNWRD+WTE7SNzHxxQtc4lSr51lZ9PtznrIb6l6YXq6W9rsg8QsvNZxM6GOKrRgk/yneWmMOkAugQOCIHlsSR9uX+VI+1iH1R9kIPeaS5DDw2s1/m7V/b5DjF8SQCPJlBgNbMou3w09/H0L0aOZ4Shn6lPqNicIdEKioW1KSq4Gou64UOFPbgTjV/XRIioN2YwNxhpv/tsNSaYRhz7H5T3S1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z2OPk+UeG3aJ1ZIwzEsjWqdBTTCBjy2xp/T2ndzZ4A=;
 b=DRhPktmp1WP8DcW/8ZLU/zSHcSxr8Y5C0LJV55kyssdHP4zDYOccdX/XvyKFpQN3VmJl/AGOOisyW9laFbp25sp1PEpKeRgpaFHtwlCekRjEe0IxPgs9Ro5hJz+hKLCSOL4Mwk00Kvj7nW53mTGjiK/7AjdrNPCCLOOGDb0fHbx9V/psAJNuvXJLigprr3i2f8CapKtXJFVZA7lry+BMXYxC7g3y+jkM+oTg8D9RmTh0sF+1H/oSNcLzVIJb9BAu8s3rwywIoRJGj3/V7rc3rFHOwNz2ofLvnvkoIoUvqmk6uMTtuEqUwTNXYw2OKdxoTHjGUkMBid0IGGXsN0GWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 17:39:44 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 17:39:44 +0000
Message-ID: <a75fefb5-530d-c802-4670-3c8262e9abb8@intel.com>
Date:   Wed, 24 Aug 2022 10:39:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 03/10] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117578296.6695.6947071073613460712.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117578296.6695.6947071073613460712.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e9b834-4989-4f5d-3174-08da85f7a12a
X-MS-TrafficTypeDiagnostic: PH0PR11MB4903:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHDIfg6fyI3x8GMwGkNsVBkZxA1SlrlMpHjsLVVhcNTPB2YVikkmbwJOs/y2lvn+Ab6RsscpTuGwHBGMz/e30MeEqMyavycnzmDOOC33uq/SkOao6wOtWUG1QNNDR7U4tfxdUK7ZIAeysPTnCbMfB4tfVY5nqpU8aY6qavY+0BMLYFMkXIXGHTKj4YP6hSZ7Kj1nHcxA6D4+g09oy4cKr/Kn0iEVm+OUINe2X5pUy62FCnHL1xB/QbiUSyFE5MmZpE0jnXZ5V68msNx8UlcKGGYT70KzCeAo9UURcG1G/eN/5ddAYTVMBUhY6y46+1pKOhTMVAIFUBqqDQj4CTmBd8PKg1GrKIJPcTdtPUcR2EpAYvlF2MNMTwr8xsMwIu8sQmMiYcwYu/jK9skND1GPkej1ZY3+Pgncz6SMM3LOt/iLlt+RYgcL++QrXA1Le+LgHn+h1y4kJqOS+Y8lvMNTHIJ5pT9MYKxlCVvErgzNlS7rZWYr14zOMJDscVVYb9+Z+OHj/PkopG7Npii+TnRVHTC/y3Tx4BEy5tC/96L4N/gKo1wdhiF4IqqA0SAwUV7mpRV4FqhTk05erGFgORs0wBxzqqWa6fFHmI0Xt/1gFEHLVcA1QOF3O4/FtEaW7sZ8Er844s5btQxNOR+bAUTwa75Y6QTpnKeBYhumkGtmEi1SrpwH0lZk4Qv3qgU+fVqBiwT3milKwxpZwrzuLLzCybEpQgO0IzR8WhEp3xGnRvtF924iYVpG6UPJBbG0Paba2pT33JBpdcQZtvjF2EZW04CZ+7uV77611ryfHq5EyM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(346002)(136003)(26005)(6512007)(53546011)(6506007)(2616005)(83380400001)(38100700002)(186003)(478600001)(6486002)(7416002)(44832011)(31686004)(8936002)(6666004)(41300700001)(2906002)(36756003)(5660300002)(4326008)(66946007)(66556008)(86362001)(66476007)(31696002)(82960400001)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhEZVdhbnBaMEVaeXQwMzhMVm5LM01lekd6S2w2U3R1ai9OM0ZwVXBVNld1?=
 =?utf-8?B?anZIWFdwWWdRM1kyNFQwQnZQeEkwQldPRTVMYVNHOTFNOWUzd3phK1hjeXV4?=
 =?utf-8?B?bmhFL0FESWRMRXV1UGFPNVJtNHg3UFRtSk9iUHVSRktVL1V3VTErVk9aMjV3?=
 =?utf-8?B?TGZZSHVHc0NLRlVlZFViL3cxTDdXVmZEbGRQQlFiYXdGOEw4UUZYTDVKZm9n?=
 =?utf-8?B?RlE1VXZlVmhaSWxuUE9KNlh3NVgzL25iaDBHNVVKaGVpdkJKWEVzT1JCV3Ny?=
 =?utf-8?B?Z2VJQVZYUTlSWHNaQUFOOXBRTVpkMjdLMlM0ZWpOQThrdThBaUg5K3crUnBN?=
 =?utf-8?B?TU5GN2tXbkJmMVlQWU9FTTk2eUdvRlpNb05ZRnpnejNOc0VkTXZRcWdxTXEy?=
 =?utf-8?B?cmdqUXNOZTF1QmN4bHJoSlhVL3N6WHFBbCtMSWZFSlRlSytaZjN0SUZ0Vmdy?=
 =?utf-8?B?VmorZG5mTTNzbGMxUHMrNTJxcEwrMThDYXhmMFNiSTNMUkxWRkNGRmFqcGsr?=
 =?utf-8?B?QmZTZkhzKzU5dnh4SUpGUWkrTVgva2RxSmNEUS9VRVMwaVkwaGxua2ZQVnRY?=
 =?utf-8?B?UUM2L0doNDAwNzJ0YVJtZzJZTWpKVk9vY0JRck9VNDErbC92dE9yVW9nQlJI?=
 =?utf-8?B?RHh1QTY3dHVOcEszaDB5ZEdxOE0xdUIxVFhvcGh5cW95SUFQQjlTMU9PQXJS?=
 =?utf-8?B?WXBQQ1FkWE9JWDY0MytkNHVaaVZhY0xBNmwxd2RMWlJGdlpKNytYbit5ZFFF?=
 =?utf-8?B?MVBaTXd6Q0VMSjNBdWpoRm0yKy9CNDM0bkZTTG55ZzRqYVZ2V0J3dE91VU45?=
 =?utf-8?B?K0lWN0ZiQ0tJUDRrbmpUVDk0MzVZeFBNMDc5Q2ZQbFVQaSsvWlFKL1hGYWRs?=
 =?utf-8?B?c2hWeTFOS2psb2lET1VDak5xMUhxOWMvZ2owSlJKNDIyNlVhbVZRcmd6ZmRv?=
 =?utf-8?B?QlIzTkV0T2gyK2NhbDJlZXBvQXZmRld6bWQyMjBwZm1pNmNsanVuZXRGbkNn?=
 =?utf-8?B?VkFUV3dqMlBXcmFoWTI3cU8wa1VtSjRLcVRzYW9ZbCtzQm0zRHV6RXRzQWx5?=
 =?utf-8?B?QVFtQU56cVhBM2lxK2lKekt4N3BZcmhtVitmWnRiMWt4NkoyV1dGQ29ySUE1?=
 =?utf-8?B?ZmRxV2RWdFM2RjlxaC94elJIVjJWOXdCZHVhTXlRcTBMQ1Mzb1huNmFPNnk0?=
 =?utf-8?B?Qk5vay95WEtlOXRvMUZmUzhObnFnc1JvZXVRZXVGVFpMc2lGdzRQRjZTRnRC?=
 =?utf-8?B?NUhHK1kwU3dQMGx1YXZQRWdsNWhiUi9BMG9BMW1XSWV6aXhZWkhhWnNhbXFM?=
 =?utf-8?B?RjlWK3pEdm9kRWxkeFR5RlVFQ25zT2hEbkJvem9JaXJ2TXlIcVpRSFVtajk0?=
 =?utf-8?B?T0k0Z296OGNobzJsZ1dtQUpLNGZXVHdzUURSSS8rU2ZmQkIxcjFKMU1vdUwr?=
 =?utf-8?B?eGZnTWZYeGd0WFNLbXYyalIxY0c3WUdoRXZIc21tL2dpTTMwbXVpU3RDejI0?=
 =?utf-8?B?dnd6YmFaU2dVOWV6Y3FIbVlmUXBHRHRrb1VHQWQxYkFJemM2YXNTN0gxdFVq?=
 =?utf-8?B?bkM3Z0F1RjRuNDBuR2NtYVU5WjN6MUVLdEZqRDVuVGFHQ3JkaTM2NlRlZHh4?=
 =?utf-8?B?ZFVkVnZWKzE3SVVmSjdEMFVXVzZkUE5zbHZ3RE9NOVp2ZTBoeGJxS2pyL2p3?=
 =?utf-8?B?NERZZ1Bub2xOdlh1S1RrQnNqNXJNbXp1VHZ6VWJDemVheXFPRjdoNTg1MzVi?=
 =?utf-8?B?ZWcwNVdxWEh4Szc0UjRGV1NKL0x0WkYzcll6WVNsdUdBZ3lrc3g4L2RkeUFR?=
 =?utf-8?B?NUZoaHVza01hSFpKOFpRSTRkZkxmZ0hpaXgvVnFqOFlKZE5ISm5GWjZTZ2tV?=
 =?utf-8?B?V1EvdHd1WFY3ZzVTbkY1N3ZPQ1psd0VtUnNodG9hWnZzb2w0M2s5SWp6aTh1?=
 =?utf-8?B?eitXczZkL3dQRFRLUld3VjhKK2k5WHV2aWxGTDM0WHpPd3c4SzF5eER3dTd5?=
 =?utf-8?B?Y3pFeUx1bWRNbDFLRGkzQ1ZvYTFYMkJ4eldmc2lueEMwMExGOHNqanFMSVdX?=
 =?utf-8?B?KzZZZWVLZktsSVRNdGordEUxUjZMcEtDVFVYMThuaE12NUlzbi9xQ1hhUkFo?=
 =?utf-8?B?aWlLaGxNK2JNYXZONlZ5T0Y4VHdIdjRCWEtWMENQWnRaM1dxbDRzR0lDRGNL?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e9b834-4989-4f5d-3174-08da85f7a12a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:39:43.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csyjIX37YuTo/aqat43OQm2YN5j6jndXMPK4DfjBA/4ymdh94760obAuEBO5Ijf07vhDJfQN2QBTOtW9tPt6pKTIbsx+TXCLXDkwXZwY4ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:43 AM, Babu Moger wrote:
> Adds a new resource type RDT_RESOURCE_SMBA to handle the QoS
> enforcement policies on the external slow memory.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index a5c51a14fbce..6c38427b71a2 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_SMBA] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_SMBA,
> +			.name			= "SB",

This name seems very cryptic to me. I do not know how you picked this
name but thought it worth mentioning that names need not be limited to
two characters. There is already support to ensure fields are lined up
(see "max_name_width") in support of the longer "L2CODE", "L2DATA",
"L3CODE", and "L3DATA" resource names.

Reinette

