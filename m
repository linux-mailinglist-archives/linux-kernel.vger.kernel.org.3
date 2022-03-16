Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB84DBA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358172AbiCPVx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiCPVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:53:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308E11A2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467531; x=1679003531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Ez0CxZOvpfwSQafeZ1kg4P6cDLJsR6RD2tuelT5jjI=;
  b=R/gSzIjhslkZ/k72eo7eVCUVhn+LnF62SDCyzFsqBbA+HgX1UXa0oTyw
   2CSkAMOgEGz0lee4+3yd2g/tFc+m3nxGq2jN1aCI1f+agA1NzFML5og/E
   dUMwYHO1f5HEBduj4l9GDwAhaFXO2lE9W7wAva1j8TJ5AKOrRQ7lxRPmm
   9HLDAlLzdpsvoW7Uf3gapb+brAnksRTN3fvXyeYbfFGt+P/Yj9U6NDk3u
   /0Xihgw41WoLAW0d7nPGpeTMPQ5XBqdDtHLm0WpdV7ALyJ3x+a2/1IIK8
   dRaYxt1jXP3htuks400a3EHQ2rikXB4u8xlELCgORdBP7fcMiiF0A6z8l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237327880"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="237327880"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="635144225"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2022 14:52:10 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:52:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 14:52:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 14:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGnj/0DXM/kuf9UT3X0tyZReSnya24xYycNlTNfEB1xsVXDlp2WbSYWbFPW4kLeMN+lXr22+cx3ujd5TSB7BAqIBJ4p3WKCwLqKbgwkwcKiMIKj81TOVjaOAqpofPoDbVMZhXSvCbaDF7Y9Uxr4BxTZbObXd2QUwUb5n9E31X0XW7/kTLMgwx/EeZSS2lfV9Ot93FIOOSw9Vdk4pqTGlIvlnf3CBAhC78iLnPaZfClNdzNzaOfFITW5oUCc5W6eeat9DSt4Nn2lM8DbxqshbOQLyGYVGrqY9n9G2uxVM6SOMMXYOWTjoUpy1IuJEW/A3ON9/V1/CJgoXM5MVczzvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLaFn/zRMxj2fAa2RTKYVTCQoUyP+5YQ+xRTllKzvWw=;
 b=M5kwnXy6vpwDDo/QJeWybdcPmKLCWgniltcb9bHvFZwbE8nL1D8JMcwDi+AHJQhsx+D8PCZYaMgHFY87uw88iKhZbalS5ErlhUH7I3Nwdn/k4GkO/EdNfc/bP1ihrUSPeUg1GDffuWlezMDpDCEVk9TysI62iiPf7/R+0PaqEsv72VVs9+xB84XK4A4xSHReFaMZq7kFCW5JX5SracTqlkZq+AJ4dp3z9H5YbIYWbYQGCfA0Hwbv9PUn85K9H2Lau8qNnjdIejRsExMtN8VbrrNR5iy+SROcmmmOWdnGyThlZyD/gCkK1DdxgaTiDF58ir703MpNTwro3Q0SbA3Gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB3038.namprd11.prod.outlook.com (2603:10b6:805:cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 21:52:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 21:52:08 +0000
Message-ID: <853b9cfd-504d-0dcb-2a2c-8b8df75a9b60@intel.com>
Date:   Wed, 16 Mar 2022 14:52:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 15/21] x86/resctrl: Abstract __rmid_read()
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
 <20220217182110.7176-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aabff12-c64e-4f1d-d6d7-08da079737be
X-MS-TrafficTypeDiagnostic: SN6PR11MB3038:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB30382C2F132510B578AC1A56F8119@SN6PR11MB3038.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCOSqyN2wGZWtWVlnv2pgU8uBRavu/fUITBwH7rg7KDeOTXdzkfLFbNGJI7iVuFwlcOTviSQKhD+b4EZgHV6Q1GioId3G3+m5EvJ0iZDw5zZIk+OKTQ5nFyqrom+ioCJaQ3o7+G63r41FGhQEnn9M2k6tvCKk+/jGAsBxaOPbEtCXxL4YoG0jfQqsj1S16uaf5+TOn67oOK4Nl7ckP/dgMTwEYydDFiT2xePHw5kQn3+06xPheA74J/fyaiiemoCIb5l3GDznHXgtNMjoLYmFB3Oan681ise41vndlP7Me3Ba3MAx6vdVCYqFwSGD/09vuRTBIOtFJ3gE2oX0+c4r0w+QTrmJrtSeGm8P69pOOPqvgwmT/sLNnsKJsr2X40xJK6Br8VnJ5W+Ve2Z7EFvkoJVIELtq30ZIyBU1axcj55SOfwfSN+ab3qDPS2poC+CWUikMY0Z7IOYFUIUqj5opfrKfLc3Cv26hw+WzyYu+0nk1x9PP/cMGByJVsrG5qeyuxy3Bk3jqlojdqHZzS6w7kzuqFUh5Er/LSnSZq79nf7qYBBGCVe4hnj2qSa4UiY/TdxzpBmY4FWQIi7YH64yo4v/Y1ykAWuFcX9ZKXhKT6vEXDmA0ZiDyNE9uUTuaw23JZ8kcmS2IewNe6bg6dzuwjezXfqK4PJ165caJ+/L7QQ6ooK+kR2agV7uRiLaGV/ZVJv04NhTId3rRbWDVByU45QSpcspj419+LMfl5VzSO4VrbQaNnWKGXvnjWmJRoMz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(53546011)(6506007)(2616005)(6512007)(316002)(54906003)(6666004)(508600001)(6486002)(38100700002)(82960400001)(83380400001)(86362001)(31696002)(7416002)(31686004)(8676002)(36756003)(5660300002)(66946007)(66556008)(2906002)(66476007)(44832011)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pQN1dBTHhCdEQxT3BrYlc0cGM5YTI3Y0RSTDZvVVgydEpraUV1ejNXK2FS?=
 =?utf-8?B?a2ZrdHFMblR5OFdSTktNSHo1N1N3WXFSSENaWnliOS9SMnEyNVNMSEJUZnl6?=
 =?utf-8?B?YWRqemFtUTlEc0JwS01ZaEJXanIxYk4vZzlmT1dxaWsyWGtKaDZ6OHJyV2RX?=
 =?utf-8?B?VTQ2U0xyOUFhWHpQSHJVbUlYWDBXWVhJODhqZlArdktsSXprSHBPSUYyN3VW?=
 =?utf-8?B?VDFqQUs2eHBGK3UxL3BmV0txZ29xMVFqMFNQUWVGVUZCdE9FdnNZWk00V2FM?=
 =?utf-8?B?S0ErWXgyaGpzWXZkMGZiZ09tYzJoYVFtWVN3eVJjRjIxbUxmMFJsQ3o1YVBv?=
 =?utf-8?B?d0JibjZRZVhBY0lMNHRHcFh4dE12OFZYdHoxM09Qb0RROTZFUGd4enMyQUpX?=
 =?utf-8?B?THIycStmM3U5L21CZ0J3VmErdGduS0FsUFd3d0JkcTR0MDNUVkdnZXZKTWpy?=
 =?utf-8?B?NlBRWmk4RVd2RlB5VUhIRlpyMzdwWm90WnB5dlVXdWZ2UzcwUTUyQVV4K3BE?=
 =?utf-8?B?MlQxR2lCeHU0N21XUmRMc1Yvd3VTVHFnMkdFV0NadGNrcTM3dVdyZzFYbzhL?=
 =?utf-8?B?c25VRC9hTms0Z0lEVVJVYzh6K3U3REFPSDhyRFpWT3BNcHMvN3hLZWpSREp5?=
 =?utf-8?B?VW85TjUvWFlsUDNjaVd6U3FLUUR1SjdwQk8wQjZqVEZ3R0FrOVZqU3dEU3FK?=
 =?utf-8?B?Sk5GcFA5YWRxRUxuNEhxM3VVcjBIYzFGS1dkSjQzdThySGVVSmwwbHFnRS9S?=
 =?utf-8?B?bUliTkFTdjh4c2ZmTXlMUGhxRTg1NCtWZEpPNHBHQk5XVUZ5NDFCS1hmR2pT?=
 =?utf-8?B?Y09RNFdzbU1JVVk0NC85ZDYrekozV2VQSUhLUm4zODdFbVM2WERtREh6bDhQ?=
 =?utf-8?B?dTZXSGFITUpaVkIzOXM4S2YvR3VkUXU0YURxT1dMZ3JYdUsrWnpTM2xYc3ZT?=
 =?utf-8?B?c1lSdlRUaTJhcU1CM2FrcEluUmJSWThKWjQxS3Fad3lPOTM4a2s3VG05bEts?=
 =?utf-8?B?cFRmUE5mU0x6WjAwMTJiaW1XWURQUGs2THpVSGd3WmxTTUJVeUcxSVJjSEdh?=
 =?utf-8?B?YVZZTzNCc0RyYjN6VWZJaWZld2o1YWhHYS9tREp6NEhzTTZSVlVEa0FYUGt1?=
 =?utf-8?B?MWp6d1l1NTl4d3h1c2dnUlBkazhjQ3VPUDMwS1NPT3FORmlSVjdLVTRJSmlx?=
 =?utf-8?B?M0I4TThEdEgvdGMyOTI3STd4QnhPejRsV1JBc2JkNGtyN1ZjT2I4RkFTaW90?=
 =?utf-8?B?Rkl6clE1L3JFRGp5OWVEVXVUdHByMXltOUdQWmptUnFjZTVSQ0dXdm5Rdm5l?=
 =?utf-8?B?WkwyOHI4azRBSklRZTE3R2o1MWp4ejF3RnB1Tk9RSnk1RTVkaDZjWDlnZXV0?=
 =?utf-8?B?cHoyVEl6bnVGZjlueDBEQXZEUytkbDgySW9yb0U4bmpKRTdvNktEQWI3SkVU?=
 =?utf-8?B?N1dPRkZYL3VtYmxDWXN2UGVSWWdlUGlKVmdIdGF5ZW1tTzNHdzNIamVnMXM2?=
 =?utf-8?B?MkIwNmtXOGZISk5FZ3U5amNMSGZwUC9oN3VpSDZFN2RwaFg2M0pzREs5U2E3?=
 =?utf-8?B?T2hmemNNOTIrczRQckEybncrTWFMQ1JnZHkxT2VSdjFtelAyTkp5QWFVeHI1?=
 =?utf-8?B?SytTUnlaT2x6SFFyWS9aSTZrS3EvMi9oYUs3WldjWWFIYlJSNlZSNVVtNXJx?=
 =?utf-8?B?UFJuZmdEUDQzdmIrdm0zZFBiQ2RYakppOXlISzhLTUpOOGVpS3lCS0RiRmJy?=
 =?utf-8?B?WndUeE9ZZXRKQkhGcTl4b3dQTjB1M21mcTNrTHM3dld0QS9UQkJxdkVIWGlq?=
 =?utf-8?B?SUYzODdrellZN0EyVHJ1MEliVmk1U0p4d3NPSzdtZXQxbDVtMWV4SW0rRVBx?=
 =?utf-8?B?MUg4dkEyd2ZEUEhSdlUxRjRlZWNKemtyUGY0UzBScHRhbU5ndXBpN3NtRk1o?=
 =?utf-8?B?MURKREMyWXc0dzk4eTBlWnpRWmthdWtkd09yS3NZOThDcUJqd2trdHlmVEJm?=
 =?utf-8?B?NEdzNGh5RDhnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aabff12-c64e-4f1d-d6d7-08da079737be
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:52:08.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAI87cgtGrgQXYUeD4CLBqogNe8fbKcYFbD0KqaspjSf+KvHlFjfRZ6HNK+0/THRBn5+FxR83BHu9icpKxoQ5ulXAP5t42xDlWlt68xwtaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/17/2022 10:21 AM, James Morse wrote:
> __rmid_read() selects the specified eventid and returns the counter
> value from the MSR. The error handling is architecture specific, and
> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
> 
> Error handling should be handled by architecture specific code, as
> a different architecture may have different requirements. MPAM's
> counters can report that they are 'not ready', requiring a second
> read after a short delay. This should be hidden from resctrl.
> 
> Make __rmid_read() the architecture specific function for reading
> a counter. Rename it resctrl_arch_rmid_read() and move the error
> handling into it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

...

> @@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  }
>  
> -static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
> +int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> -	u64 val;
> +	u64 msr_val;
>  
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>  	 * are error bits.
>  	 */
>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, val);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
> -	return val;
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +
> +	return 0;
>  }

From above we see that resctrl_arch_rmid_read() returns an int that could be
-EIO or -EINVAL ...

...

> @@ -319,15 +331,15 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>  	struct mbm_state *m;
> -	u64 chunks, tval;
> +	u64 chunks, tval = 0;
>  
>  	if (rr->first)
>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>  
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
> -		return tval;
> -	}
> +	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
> +	if (rr->err)
> +		return rr->err;
> +

Setting rr->err, an int, to the return of resctrl_arch_rmid_read() is ok and
can handle the negative error codes, but returning it here means that
__mon_event_count()'s return type should be changed,
it is currently u64.

>  	switch (rr->evtid) {
>  	case QOS_L3_OCCUP_EVENT_ID:
>  		rr->val += tval;
> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  		 * Code would never reach here because an invalid
>  		 * event id would fail the __rmid_read.
>  		 */
> -		return RMID_VAL_ERROR;
> +		return -EINVAL;

Same here ... __mon_event_count() is u64 still ...

>  	}
>  
>  	if (rr->first) {
> @@ -419,9 +431,14 @@ void mon_event_count(void *info)
>  		}
>  	}
>  

Also take care here ... ret_val in mon_event_count() is still u64 while
__mon_event_count() attempts to return negative errors.

> -	/* Report error if none of rmid_reads are successful */
> -	if (ret_val)
> -		rr->val = ret_val;
> +	/*
> +	 * __mon_event_count() calls for newly created monitor groups may
> +	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> +	 * If the first call for the control group succeed, discard any error
> +	 * set by reads of monitor groups.
> +	 */

Additionally, if the first call fails, but a following read of monitor group
succeeds then the first call's error is discarded.

How about if the last sentence is replaced with:
"Discard error if any of the monitor event reads succeeded."

> +	if (ret_val == 0)
> +		rr->err = 0;
>  }
>  
>  /*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0b48239f5920..70112dbfa128 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -219,6 +219,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid


Reinette
