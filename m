Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203C59EAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiHWSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiHWSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:25:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E29D7E30F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661272971; x=1692808971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z/Dcz23TPmOmmi97xWPiO8SuH8cRjYr8OLDWN21/69k=;
  b=f3RCvw2zmc5VT0t/o+95mUx4Y3ZotUhx18IK/10lAtNXnvzcpJVkqScb
   uiSTHRBBDG43EiiSzE4gSYwbsryrZLYls3F5Rk4osE02ZUNIPRg0cKsRP
   kQ6fmfdaaNz++ojz0DUjUak/b5BStWfzuVrZdsbyTqUP63n63UX5Lg5nP
   VCz514rmtSnBGWMXK8kO6dtrJ6QM4VxGfNlvmaAB7bwom6ug3mNRcWRsT
   2WQ7IggF/wNM57+OV8JvHsLH7cDaH2M08p7+oPuY++XI7rhgavf3zDS+A
   rk7oCbt/DljHdFt0KUZ0PexUdSXU201L49kOum/1DPGr3ij3XLCNNZVIv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="274128424"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="274128424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="785311617"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2022 09:42:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 09:42:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 09:42:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 09:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+Xg8J5Jw6gam9Wgqo7brRv8ON04oD16SfEJeW3njDCPGxs5KvSZcEQblmbMhjDVgOP57XmgNO1np081eysXU1TGgMYDmdeETbK7FeG/bjbJ/pBfiLUeds3cXUEJEqcxWvMCIleQQ9xUpXb0qnmTE4e+8aQHvIu16aBh6rM/FtfhcIeibYwRRKt3LmrW7TY9lt0Tn6EioM0sNQxwVB93IPPzdgqM2A4rXqs2ZXRrREv3JZSFKZAXk3khMXWFWxzi5DtNLzc4TYdIasH0hzu1uIn53l3lbHY/Lk6FNUjGVL9KSoE0ogGaJ4yqNVzGPGzE3jJttEbxE+2TH6zrlw50eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKzc9AH1bjmE6aPQ/fxrYKlR3uznyvhoei1bP4lmB3Y=;
 b=G3XaYVNiKAwv/ffZuAthjIli6um4iHsMe1EwJFPSqbhNzsd/jbK2kBviPLpjS35AfbISoPVmV1HKnAh1nLAonwPeKHVW0FHI/F4ZklPNBNtSi/lkfAt8lyZZW7/2Ei321ygiQ+UXMBGppu9qh8RhfksZtru8qZN+VgjG0XbLK/GxjUo4VG0ovmBBt/OoDvQXe1dQACtkZ7CXIyG+tfBitF3mt5FszoVxqmXkIJx5bDZ4nFsgKCcVQB7jEmN3pdt9BfaMRR3Xsovx2+06Q7UKNyTisunl4JSBZ+NZ/GuKkZfNzzYP7gw8XDnKyBU7SgOiILU4Ej3dLw9W/RpM68MnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN6PR11MB1377.namprd11.prod.outlook.com (2603:10b6:404:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 16:42:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 16:42:41 +0000
Message-ID: <3b19ca17-e56c-0be3-f14d-d5485c5fb020@intel.com>
Date:   Tue, 23 Aug 2022 09:42:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v5 07/21] x86/resctrl: Abstract and use
 supports_mba_mbps()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220622164629.20795-1-james.morse@arm.com>
 <20220622164629.20795-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220622164629.20795-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b3dd2c-2903-45cf-e8bc-08da85267eae
X-MS-TrafficTypeDiagnostic: BN6PR11MB1377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IqzM6TobfOeYMFNtTBNwqN/5M+Wwzdul8ajbDDSNL/y4BG5y82SnG2NiAcZhcWEu5PPACFD9ErQEI7zUeHdVXNKs2tqBSK59l9d53WQ10AP7cqadMe/koYz0UHRM4xfNB9VnO9h+h8WzTRrqdE2uaAjIupp+miuC0oyDtgKHU6yzyCsALYh9SY/W9wXaErVWcx6NY423B4dLhAN/Fbue8peFOdNlgOEnf0AYtz6BBdEf0sbHKn8bkzXsL6Qa6v+8eKWW12LI5t/51F16p5GO/8Cm0ntd2NASokajNsdzuyUBXzWLCwBhBrdMrAhb1iKQjRhX5gBVhJhzTbrcVKAzLBOm37qNu89REjek8fFxaKOST39w0rM3Mnq+dZ0OmpGKkKLMqvLcnh38+pegg+X1Ly0Va5Ud7hVNva6nZcv574HzWihf0ELkMMdJ4ZOX6MwXwJacVi6ShV6YsAgh4TlK96B6frxH73iJOW3B/AmGfg9Hcv1Oo+auwcMigiwZ033uKR+gUbI0uO8RWXs5NnijyFDzNmjJusVdWeMOekNgqgu2CQLxY6mHIVDAQ2sJ/s+2rp1556ivkZz5Ohvhy8osJCAFCky/2T5FO9QOQ0a3zRPMMofkjHul/JwdArHhLHE6y9Tzun0ODGnK84neuJq9IeoDA9nCcUuAD4J4ymoXRXRB/DKpA5WRDvcQOpH+s2t2rGtoWNJoaX6sXJU9LedDuOvLytUndr+eyuVHGIGMu36ZD8McRmPe2h5O9MW6KbW4eBg0PKFP5ouRAkqgw/Blacf8szyH3vJcN+byQBlbrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(376002)(346002)(6486002)(44832011)(316002)(5660300002)(478600001)(8936002)(82960400001)(41300700001)(66556008)(66476007)(4326008)(8676002)(6666004)(66946007)(7416002)(36756003)(54906003)(31686004)(6506007)(2906002)(6512007)(26005)(53546011)(38100700002)(31696002)(2616005)(86362001)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENadmFmaDRtVy90dXN3aHd3NW9iSmcxVFJhTlBuUitBLzlyVUNLaVZIaDkv?=
 =?utf-8?B?Wi92UjlYYjRXZ3B2amVETDg3cGU4ZnBLZENiRVBRM0QwWGwwZFkrcHc1bHV6?=
 =?utf-8?B?NGZTejFERm9NWGRaaExzU0o5MzFrQ2JzWHRqd2UxQWtBMEVXbTdpdCtmbElT?=
 =?utf-8?B?a3pxQVcyOHNNeCt4OTBoMlNpbURwSTE0Qzdscit6RjlOMmxRakJyMlhOL24w?=
 =?utf-8?B?Z3JFNkhFL01IUnF3ZUJNMkpnSUtHckUxVEZTOS9FSGd0dHpLclNUZS9XUENX?=
 =?utf-8?B?OVI2MFJ2NmZHUHB6UkRpNWNOSURhNEl6bjQzOURoc1l1emk2dVlZelVybUhl?=
 =?utf-8?B?NHFSaGxtOGJrd3VhU1pXb1BFM1hZWHN0M1hZaTEwcFNrV0ZVYUtxWWhtdjRZ?=
 =?utf-8?B?QlIrSzJ6d0NIQ3gwNkNNbEwrdDJXMlNGNkhLTldnY3FLWWI3VkZmWkt3RW9i?=
 =?utf-8?B?Y1VRMnpFYUtWenJtZGdKR2d2dWxKZnM5Z3JIeThwa2d6bVgwOXorZ0hCZkpp?=
 =?utf-8?B?QXJrbEppcnJjMWdGUnVBSkJVYnpvaWs3aXFPNFU2TDJ4WDNuYjFpSE50YjIx?=
 =?utf-8?B?N3RtNjNIYjJsVlVBWHJZQkdsRmZ0QTF1T2NxNzZmd1VaQTBDZE1XeW83dEhM?=
 =?utf-8?B?ZmE4UERST2lDUEZ1OFlQYm1Tajg1Zmo4cmZzZGI2NlB5RTQwSW00ZU43N3NT?=
 =?utf-8?B?azV6SG9HUUdjb0I5YS80V3ZFUUtLNUF0S2UzcHdxWUx2RHNKVlM5eFFiTWlt?=
 =?utf-8?B?UlBzQktBRmxNcEwxSFdrNWkwdGNqUTBQc3NiODM3cGY2VVU3TkhwQzYrQUJn?=
 =?utf-8?B?eDZRNjlFRnRsUlM5ODNuQWFnWXlSWnJkcG5XZDlCT252Lzg0NzhuMWVHR0sw?=
 =?utf-8?B?VzN6aGQwU3UwQi9PUytSMzBGT2hFR1FPenVhNUJ2UVZLMHk3KyszZG1Fd2Ev?=
 =?utf-8?B?SGVmbldncWYzMUtGdDM4Q3o1bGJ2dk44WFhEQXBMUjFoYkcrWEx0UlVzeTlp?=
 =?utf-8?B?VjFWUWx3UjZyTVU4aEJ1TC9xOU5vVnBMbFB6S0tjcjdoVTJuTVVaQ0pqcGxV?=
 =?utf-8?B?REZZREcvdi9UNms4RDVXS2NnNTV6cGNNRGdRUUdsMkdUZ1RzZ01EcEt0SG9Z?=
 =?utf-8?B?bXlBMk5ERGx2TW5vRXdjaUdKVDZOWFRvUnNHdUsyOUZKWmJzT0tUSnp6Sk5Z?=
 =?utf-8?B?OGc1VHBrekgvWmQ0UFgxRXZOUFV2SjhzSkd6emlxd1BEWVVPRkZZV0x3V1gz?=
 =?utf-8?B?Q0ZsMDNtcCs2TXBsc1ZENGlVQnp2dlFzOUxiaXZOT2pXQTRnMyt2MU5VSmFG?=
 =?utf-8?B?anRwbkszOFQvZDE2S3dQYWx0ZDNsb1d1NUZyRWZXTDBoRW1tdUpFZW5PR2xQ?=
 =?utf-8?B?by9QbUdqcjZVRVVwempPY21hSmpRNXVvdzdXUGpUR296NktCK1c0bTZwcGFh?=
 =?utf-8?B?QUNjTVpnZWhQOGpMRDAyb3dCYUx5VUpMditoekxzcENnSUJwWW9xQXV0SXBI?=
 =?utf-8?B?ajBuTFBwWkpBN3pYa1g2Mk82NTFnMExuNk9uUjNEUldCeVFWUlRueUd5Rk5M?=
 =?utf-8?B?eXRNcm54RWt5UWpLSzk1c3FYUkJUY0FhckRwU3B5UWNhTnUvWGFvNFJiR3lh?=
 =?utf-8?B?dk1lYmhDc3N1bTJpN1hPanpVL2E4L1pCYjFSbVhxYWpMdzh4MzF1eFhzMW1q?=
 =?utf-8?B?QUE1b0EySFJ4dlgrRW9vRnJseUZIcFFTMlZNc1ErT3VWM3FLQkY4cE1sUHJz?=
 =?utf-8?B?V3UzZmFHcTRKamhUNTViV3gzSVZJWnlQUHZPYzVpU1N4MmF4eURVRlFaYTVC?=
 =?utf-8?B?V3p0YVd0a3gyRkNhdTF3S3JaUHF6WlJOZWR1SFJIemVBeVhYcnNkMEJaVU1v?=
 =?utf-8?B?NHE5VUFicGRqMTRkUjFaK2pjRnE4M0pDeG9VaHpXSVU0dk1STlkxVEYvVFBi?=
 =?utf-8?B?b2tEeUNxNU5DbndsSUdFSXR0NUhLNm1zL29ZL2VxOG1UWDNERGR5TlNwSjFQ?=
 =?utf-8?B?OEZQcjk2bW5xNmZ4OFVIaGV1VlhXaElOWThzdWFxL2ljYVFLQmVleW1BWlFW?=
 =?utf-8?B?THdqeUJkK1dtdGV1QmhBWUlmTEcrWEdsSXVnVUhVNmRoN0NCVHdOQUFsUGE4?=
 =?utf-8?B?dDIyejNEK1dieW1adzR5WlJDY1c0UlNsM3Q3SnpTV2Z6MTEwNkI2Z3pSMmZt?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b3dd2c-2903-45cf-e8bc-08da85267eae
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 16:42:40.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksf+0qjiiITNhw3fzDEGTWoIzwr5kzfMM3DZ7JtF+CTtJ8LE0Q1j5R8HhkjFPTLLNyAjukrRKpWO6GRHliwAExHInJIjkpbwTGmDLXtQfYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1377
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/22/2022 9:46 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b32ceff8325a..49d9e2c3c743 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1890,17 +1890,26 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  }
>  
>  /*
> - * Enable or disable the MBA software controller
> - * which helps user specify bandwidth in MBps.
>   * MBA software controller is supported only if
>   * MBM is supported and MBA is in linear scale.
>   */
> +static bool supports_mba_mbps(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
> +	return (is_mbm_enabled() &&
> +		r->alloc_capable && is_mba_linear());
> +}
> +
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + */
>  static int set_mba_sc(bool mba_sc)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>  
> -	if (!is_mbm_enabled() || !is_mba_linear() ||
> -	    mba_sc == is_mba_sc(r))
> +	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
>  		return -EINVAL;
>  
>  	r->membw.mba_sc = mba_sc;


It seems that this change is propagating an issue that exists
in the current implementation (not introduced by this work).

The supports_mba_mbps() test uses is_mbm_enabled() which is:
	(is_mbm_total_enabled() || is_mbm_local_enabled())

That is not accurate since the software controller is only called
when MBM local is enabled:
	mbm_update()
	{
		...
		if (is_mbm_local_enabled()) {
			...
			if (is_mba_sc(NULL))
				mbm_bw_count(rmid, &rr);
		}
	}
			

Could the "is_mbm_enabled()" in the new supports_mba_mbps() introduced
here be changed to use "is_mbm_local_enabled()" instead? It does not seem
an issue for existing hardware (that supports total and local) but
the kernel parameters do enable users to boot with "rdt=!mbmlocal" to
trigger problematic scenarios.

Reinette
