Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD04DBA54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbiCPVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiCPVvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:51:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F3B17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467420; x=1679003420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n+mqnDfGI9lgIc4nIob2tmOMRHzxlwfSxj65NYWlM/A=;
  b=YpqMTu3uDoZQzKucLfap1/mj7DfiLvz31DoCqX0161h1bld+rWkvipWU
   1bR0MBxTkSYQA8D+jZOxkGOkY/5QVOL3w0CuAMP1XZaHo33LXJqVXyOO8
   CsHLZx8TpoeNS7Hg2M429B7qIJ7TzD89sM0PV3KXN140jQcnNu5EitYvx
   gxhmodYzb5eC1Q1tUx9PkAqZl3XvmEKQZIRxhGY8KMcrCamMirZHw2vsj
   ovJ7A8UPOeR9NGpaTzD6rMgtUeP8nuzCRkFt0Fqbt22JNuyrRKYVwd/ND
   Bdg6LeP7HcDB0r67ZW0ntsia1foYIDiJ9LZHFqRrGEegujHGBVAqxE8mk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256909444"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256909444"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="820975004"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2022 14:50:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:50:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 14:50:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 14:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0JGJYFG6PZIFy+0Mey3cB0tfVN/rHO9hiOMDThH8bfoFk1Vk9wMJheptHq69MAiRTECmz5GFN0aQb0znFC/nk0WUE9AjRqBwq8ACxKiVqeQVnMLvLGWBGGmBHqRmuoR0Q1nOxOJvQpk+PDUjEhB2TEpuvdgeMhJi+3IT3QVp8VGLqDb/4Shsp93b1yN7KLpJ8Md//lhmfIZnY3OqJ57ghHbGHau4rAQMXKyJESdBPsn53xll6AUPfZ2BqdMvvS2NX/y6MKj9wRGMv30nKQKL46PEGrWpUcSyN0aLTcMY5tNl0jIdXXTroZQ3J/jPmcAoUUMhiyfkuzN5iz7HMnqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxHCO8roka0wcLCncZ3pXrPYMFZjOLaZnM3C63HxBlI=;
 b=MVxIkTDZB+4Sioy7D9oQMDAiwu/0ElRsWq6qXrMCMS4XbYrTQAG1cMT9WIbUJqpys63LBMIrUtqvrmtW+pJLE6H/6qc3yemvek4BLcZEC1Nk8zZ0KqtKSpt+e289TwBzFqnV4Y68P39tUuOJik6zcP+gKr6MdZtecaa1uvrG+zYonUuBR9kPIiIXJ9ugmtfMdZQpbrusKZhD5RJHzEdbHswZBN6O5d3xWGQw1yoAiCZOth8WTzmHStqVAyi26DFcxJAoUMyjSx7lPPknNoTKdml19nEgl1iExWck8qcIZPfrEgCY7jv7xzyNWSnUYyp5ZngrAuDqtEXXpABs71QRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SJ0PR11MB5149.namprd11.prod.outlook.com (2603:10b6:a03:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 21:50:16 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 21:50:16 +0000
Message-ID: <01651414-9d4a-409d-9db7-b4b6dde72829@intel.com>
Date:   Wed, 16 Mar 2022 14:50:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc70a270-bb30-454c-18c7-08da0796f501
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5149:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5149BDB91A55EA7B98F0EEFCF8119@SJ0PR11MB5149.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDzn3LQuQyZB3ukk2bKFX8U2q/9IFu1vR5xJcyw8LJQ2MZ0GakzwW5jRrnw7YsirvuwSZo1EU7he/J/MxG8WQtpzYDbNQgkzwjXnLfDHaj4T6hxk7HHxHQiiT1sfhkhQw5duR7uQmzKGh63f9s2OgyrF2bMdmJ1Cje4sKRrTeBUH7wgSne4+uN7RalELw78/gyzDC5/hiPna+EaE7DYCXPsPGzhPnu7lpHzjAJ8Encm2rTt4NESq4399AP55bUNIBGHr921hIShmYKjQ7FF8bhqM0YNrpY7TV/tPNCjV0YMmUsdFI6RYWYsiF5NCuyAjZVF5PJg9qsmgoDbBk+AA7LJqOzlBRRWYIxThmz3x0oRvufXOWAaVUg88bTN74fWdxaWXTVwcNgSUJENtnf6YH4UtD9ov+rwWR6rdQ2LvlEwMPjNtXfaDTlesxFzXcaU54MrSRg9n48k8/FQJ1w8KLMAnWVlEgjORywh/Zy/6DIhrw5iG+AzfZQrifA1MSD3+2PnI/oIlQwrWDqPq1W74O4VW93lkKGsJbcCeNIf1fAZBp/Run9+05pkOBL/Yoy4Fz1+fwZTS9ANvpQHbMQc6jNYVECdNPAiL+Xmf1yjakzW4S+Pq2X8Z1nVhz1PQtB4LLktzr5P4ZB6jKoaVCdMGtaUYK9TvWEEocSGQSNX7c6XtkoVl8H4TCnInw9R1RAFd1BY8v+CNsNUG/Japay46cWuouHcUMaT26eOe6TmU7rkK6kN2+JoVQ8OHnmHXcmqD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(54906003)(82960400001)(31686004)(31696002)(316002)(83380400001)(36756003)(26005)(186003)(66476007)(8936002)(66556008)(66946007)(8676002)(4326008)(6486002)(508600001)(6666004)(53546011)(6512007)(2616005)(6506007)(44832011)(5660300002)(38100700002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDIrcUw5dzRUMXV5Mk14MEpJQThlMldZMjQxR0dDT3lCTjdOUTdBQmFMVGFi?=
 =?utf-8?B?ZVJVUG1MYVRLQURtSlJiTGdkbSszaUNNaWFaYzVsZHBsZTh0RjFPbHZ6andQ?=
 =?utf-8?B?eUFwYWtCOVRDWTdQNlI4MXA2NW5Vb2F4a2NBMTU1ZEJod1ZUem52YlkxT3pN?=
 =?utf-8?B?c1pUc3NwTExjRXNtdGlXUk5rL2IwZnJySWtRM0dFMENVNTJUWElFYzJJNFcy?=
 =?utf-8?B?K3BVUDBOZ1V1Zmc4L2VrR09oYW14TXlERmxFbklVbmtnT2N4dE9yYkkxSGxq?=
 =?utf-8?B?Nk04aXVLNFkxTVV0ZitPcCt4VVNIUVJWMmlSSVFZVUlQSFZ6S1A0cDBBdyt6?=
 =?utf-8?B?cTBuTDdwcmNTc2N6Uy80Yjk1Rjcvekh4cjVFRWprWDBIcTJHSHlzWmVyUS9y?=
 =?utf-8?B?bm9LY1Rja1h6dGczcTV0STV4WTRsNXNmYUhGL0FZc3VIclZQdHBxN3FWT0F2?=
 =?utf-8?B?TDNwODdVaURPNDRnMFlZM3BRWWhTdU5WNU9SNHNGVjRYZXVRUEo1UXFDL2tn?=
 =?utf-8?B?Ty9oK1pXQWFyTE8xYkp2Ukh1UmN0YkxGNUUvYjlibk9jRFJoTitaWEcrNDVk?=
 =?utf-8?B?Sk5VYlk5WlJsK1hCbzdBWllhYXBJd1FvanVEblNQdUxFZlBNU1cvQ0tXbCtz?=
 =?utf-8?B?bjNSdlQ1aldmbzloejJMS28rRnJ4WlJ5U1IwT2dVTFVCWkNhRDFrZ1NKUFZN?=
 =?utf-8?B?RndCSXR1Zk1TQUgxbFBUdzB3ZXZWRDVSVy84MjFiTVBRYWJBMlI3eXNTTnFh?=
 =?utf-8?B?amhZdnpPS2dhR0VGRCs2S0dJLytHd1l5T0VoSldVMFFCRFJ4VmtySmdXNlF2?=
 =?utf-8?B?L2dFZjlJbWFzL2xwVlFFTkNERkNPcEFYWmZrZno0citEUzR5NGw5UzNHa2VX?=
 =?utf-8?B?Smk1dVlrSEN1dks0Z0FJMzduRDV6a1hLZkVqZEM0ZGU1b2puckxYQmVDZzdv?=
 =?utf-8?B?L01KTHNhL0JsV3dJanQ1N3FlUkRlOCtMYlYwTzNjYUpVV2RoZjFBZlFCcUFH?=
 =?utf-8?B?ZnM3SHR5R09aRkM0aTk4cUoyb1U1U29ITUdTWmdteCtTd3lCNGxHNWdQT2VN?=
 =?utf-8?B?dXlGa1hPSWpmS3h6Uk1PaGtxR3NJVHVGQk5vSEpUMjl3enVIODBCem9SSHNr?=
 =?utf-8?B?KzhibmdOa1pielc5RkF4MWtWbHVxKzB1WG0zdFRpbWVMRVFEK21YM3g3WXBY?=
 =?utf-8?B?VW1rVjl0cUJBK2FDR25DL1dCSFRVZXNPL1lhWU1sZU1jdzZ0Vk9vZ1VhSUI2?=
 =?utf-8?B?Rmo2dFhGcjIwNHBWSVc2blA1UCtvTHNMUjlzYXcxZ1B3U0hOV2V0OU9aa1FG?=
 =?utf-8?B?T2FsRlM2ckVobFRrSS96c25LMlgwaUdRek5nS1E0VFBvWjczc1Zxek1OaG5a?=
 =?utf-8?B?V2RRZkV2SXZ6MVh6N25NaS9BSTMzY0FWRUlCZ0NpNEI5SGg2azYvTDRtSmoz?=
 =?utf-8?B?cm5vNmk3TVV6TWs0Mnh4Q3E4SEEzeUhxWDBoK2M1dmU3VXgvbW9xZ3lSL3VT?=
 =?utf-8?B?Q2ZUVzhkcldmKzhIcHFUSHA5cXZIMEhXclBTMUJSdCtXNHg4U25rMEIwNDJO?=
 =?utf-8?B?S3ZCQTV5TUJaUllvWVlTNC9FdjJheitjbGVCRG5OZ0lGa2t4TkFOSDlyQk56?=
 =?utf-8?B?NVdXb2J5akRqY3FiVFRCanRCOEk5WXMyc1JHaUNrbG5IQXRuOWJWbGpFTm10?=
 =?utf-8?B?dXIxaUpiL2RoandVY3JUeHkwSzUzNFJJaGJMQmlJcXFDVlREZVB2TThlcjR5?=
 =?utf-8?B?N3VrcDJuYkVZS3U4dC9FL3VJMTltQ2U4bTZ4NlovTjdHdk5Gb1R5NmljQ25B?=
 =?utf-8?B?TnU4ZWsvTFpwRGdhbGVGRkJ5dDByUTdwd3NSbVptY2lkczJFZHNoTUh3SWNi?=
 =?utf-8?B?UUtxQ3liOENzQllnMmdXeG96akZCZ3IxMFh6KzhuOVg2Sy84RTB6WFdXZk5N?=
 =?utf-8?B?V2daMnpjZVphajFTYlJOWm1BRnRBQnltb1JBZmwvNjVSVHpKMWh5MW1iZlBx?=
 =?utf-8?B?L0NWQ3Z1ODh3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70a270-bb30-454c-18c7-08da0796f501
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:50:16.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6ubzD5SX4nF7COxY0roryU4drsh/HEkFJqclwrhCReKhETbIdWg6s/DALbyXT11lDrvcge2U/iHBABCEXYc5d2bVm2dV1aOeCC/fYuz460=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5149
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I tried out this work and encountered a null pointer de-reference that
seems related to this patch. After digging into that it is not
clear to me how this is expected to work.

I encounter the issue just by attempting to mount with "-o mba_MBps" which is
the way to enable the mba_sc and exactly what this patch aims to address.

More below ...

On 2/17/2022 10:20 AM, James Morse wrote:
> To support resctrl's MBA software controller, the architecture must provide
> a second configuration array to hold the mbps_val[] from user-space.
> 
> This complicates the interface between the architecture specific code and
> the filesystem portions of resctrl that will move to /fs/, to allow
> multiple architectures to support resctrl.
> 
> Make the filesystem parts of resctrl create an array for the mba_sc
> values when is_mba_sc() is set to true. The software controller
> can be changed to use this, allowing the architecture code to only
> consider the values configured in hardware.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

...

>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 794a84ba9097..e4313f907eb6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1889,6 +1889,30 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  		l3_qos_cfg_update(&hw_res->cdp_enabled);
>  }
>  
> +static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> +				   GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mbps_val)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_closid; i++)
> +		d->mbps_val[i] = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +

...

> @@ -1905,6 +1932,11 @@ static int set_mba_sc(bool mba_sc)
>  
>  	r->membw.mba_sc = mba_sc;
>  
> +	list_for_each_entry(d, &r->domains, list) {
> +		for (i = 0; i < num_closid; i++)
> +			d->mbps_val[i] = MBA_MAX_MBPS;
> +	}
> +
>  	return 0;
>  }
>  

...

> @@ -3309,6 +3344,12 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (err)
>  		return err;
>  
> +	err = mba_sc_domain_allocate(r, d);
> +	if (err) {
> +		domain_destroy_mon_state(d);
> +		return err;
> +	}
> +

Before the above snippet there is a check if the resource is capable of monitoring:

resctrl_online_domain()
{
	...
	if (!r->mon_capable)
		return 0;

	...
	err = mba_sc_domain_allocate(r, d);
	...
}

Thus, the rdt_domain->mbps_val array will only exist in those resources that
support monitoring.
	
Taking a look at where mon_capable is set we see it is done in 
get_rdt_mon_resources() and as you can see it is only done for RDT_RESOURCE_L3.

get_rdt_mon_resources()
{
	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

	...

	return !rdt_get_mon_l3_config(r); /* mon_capable is set within */
}

Based on the above the rdt_domain->mbps_val array can only exist for those
domains that belong to resource RDT_RESOURCE_L3 (if it is capable of monitoring).

Now, looking at set_mba_sc() changed here, it only interacts with RDT_RESOURCE_MBA:

set_mba_sc() 
{
	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;

	...

	list_for_each_entry(d, &r->domains, list) {
		for (i = 0; i < num_closid; i++)
			d->mbps_val[i] = MBA_MAX_MBPS;
	}
}
	
Considering that no domain belonging to RDT_RESOURCE_MBA will have this array this
always ends up being a null pointer de-reference.

Reinette
