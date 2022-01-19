Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D40494211
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiASUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:47:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:46977 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiASUrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642625252; x=1674161252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=moc/OfTwsfxdMmXprnz/FMz4OsNVHxnJQB6osEP99mI=;
  b=HcADAzZSeB4A6w/8xMvRhfKZjV/x7riZCm/TpLtJLIKg2YJlXk36Ro/D
   afQn4zGVBNWbdcfYo79jQHBo1f87T3q/7gPWkZ8OA9CyD8kTTz9+03dMk
   4aIG1ihuwpgqRLSpFezwvPsqVl51ZzLPhl0nZvjvYfmlQwFk/jAk8x/rX
   oH/2kUwOFIY+klqC0Lk3NPgmKdFM0+UBdSp1rvB+Gg2fpMVwez8qdpphJ
   k5ju0dfGfkH9xNooBM426zq0+vHJczWLBcthZVGasw/BZoxUq4wclo1RL
   aDxK/wjIYTbfaV961tsev695SN5fLH9lAPq2OzQThfYMz4MhkPeYbE7Nz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305921181"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="305921181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="765080723"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2022 12:47:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 12:47:31 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 12:47:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 12:47:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 12:47:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTM9DMRH7/dfxtj429HfWt2MJLnYNVfx4sEDHH91ZYR3mrF+MjfjmIDAkA+Iaf4HZkJXUDVD6GmT6PyN+RE1ER2t4AAblqIuEYw2oZmapRvdRVQinfFFFZ5KozLJRLxhB+PlGP1GzbEeqbkZEEKCVhPaNhIvacPz6LIv9sOCOrrNeS9WEOyu8nQNIt0sioxnp7V/tAf5ZyOFR0KU15fVdlzKriE5zYbCrYaW1qztzQM3TbH3WqZoQr7diRtfZvBG5/gwJG8MeRL5sx97yevmfsA5nquGf/JArzRw9I2vXonYJwD/AA05d09ohrcM6eyyrW9eMuVbQDSk3ID845za+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gV5t7czgFXnmMhdZ+nBQLTpUXs09MwD7KWb8sCCqjU=;
 b=bcAkknoSvzJNOqdY/vKokmJRRr5gLTQkPAMVTxgekr6IYjsdpxbCmBQpFtxvGCKeSCa7NR3v+lje4e9kDyvxodm9iOkndYURvdiW7+fRMVAb18ebsadZyLdUTMXJGQGwNwFYSqycc2LYJQZzwiTYiemi7o8kQfuHkCKBFm40BFLrvgUy/xofj/dGHPPHD6ybnPgoGi6AlCiyTg8NzXrCEzbFD4DlpujnZVNn5Kecvyx3YKkMTA5baUbj/fhx/zVMgxWlC0WZaGp6uNEthYmP4M839WBfXHzbaJcUNWON5Fu/5eklI/TzwOR4s9JGOmcFc7uzPAnlbBzFuwCE+RFZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 20:47:26 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 20:47:26 +0000
Message-ID: <effafec4-affc-297b-4b0e-aeca1884fa4f@intel.com>
Date:   Wed, 19 Jan 2022 12:47:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/sgx: Add poison handling to reclaimer
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <tony.luck@intel.com>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
 <9cefa244-9830-c158-6112-b2c61a464632@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9cefa244-9830-c158-6112-b2c61a464632@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd61c68-dd1c-4c48-e2c0-08d9db8ce6bd
X-MS-TrafficTypeDiagnostic: PH0PR11MB5577:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH0PR11MB5577942A502C4F409EC302EAF8599@PH0PR11MB5577.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TQ0ih6qCMn0kEYu58XYouQ2If2cQvfLFcnGqDok68JRIvTCMhvD6ccCli6Q+CqCXCJnhrXrMR9EyrRL012txXuM4j2aiqmGhJxdaHhoNY64I1xTe81PIjw9Cahnph+TpSkkSILD8vaNCkTcCLjyHPQ8DbI9MAG0aSTf2UvOBOH4k5jRNMTsBpClKkPN6Bj22yvY7Qp77wjSwVbbkmuH50ulUqFeIy8/lOGf7nX939/yn8M9l9RfMiUSFtABbKx2NG3BUYXfMqcPz9ydOm/inzd6CGtfuoBRgFBgwYIirKKWbpTHmL6PHxWgbA48Rj2Du3tZPVOwoTwrWk9zpjIFJxOHVcqhae8UbipB9YjEf/Tszrg32GYLoYQcW+m8mOuZ3M9e+hYp5RkSdTEWKYvc3K1eqaCPFoHNcbVhNXNXMihV8UK4aV/sSHk1nSzAxb9PzC4prCp7sWjdwTgvDP27/0B+Lj4nmMRnCXm7xgHA+l5cvUdwydTcrQKXe5kvL9qA9lzSObq9iURa84kfMeMZOjFoMy+Ysb3xssgsOb5vqgmJItHbinmV/fKgWKIBsztt9EEllTQRrzeGVTzOqUK8dh5LY2EHc2FtTOsCB/pGj/sRoswyuRv5Tls/1RZb/UbEBlhV9pj3lSIdq1JezTNQSOl1fZc1MWdQnlaOqqUIk9z6ebMK2RaT01YLUBDWi3H+u75BKszC3Hv3yKt0mS3QmTYc+1JolRl6EUWreU5l+lmn44/EEs9Gfs33oXdux5Ry
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(4326008)(83380400001)(186003)(316002)(2906002)(53546011)(6506007)(5660300002)(86362001)(8676002)(82960400001)(66946007)(508600001)(921005)(31696002)(8936002)(66556008)(66476007)(44832011)(26005)(38100700002)(6486002)(6666004)(6512007)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdBcU9oNXY1VTdGWUFQZFNRazdQMGpLaGtiRis3Z3hnVlA5a2hHbDBEdWdF?=
 =?utf-8?B?TytabFFra01FUmpuV0I0N3lCVkxjU1Fyb09DSHl1VC92cTlLUTRFa3FpYmVW?=
 =?utf-8?B?ZHJ5YllicGRIZWZLWmlraEw2KzZmNmJQMjB2a1lGZzNWeGw2bmdZMnRmZnAr?=
 =?utf-8?B?QTh3RU81b1BKK0h2S3RrQlVyNVo1dDdYaGpDdmtzVjh5dXhDRzYvN1h6YkJV?=
 =?utf-8?B?UXR5Yzl0WFZlM3U3Z3JTVUx1MmxURm9sVzVmUEVwYXpGK0xZT29LdUhBU1lo?=
 =?utf-8?B?ZENCc0JVWUtNa0V6cGhUM2l6MFVpSThJYWNMNFRuTnlKT0cxNWdSaXdlTmtw?=
 =?utf-8?B?UmVUdE53akduazlTcG5CRFpBYnVIZStBWDJDQ1pFZDErVm9OQXJhY3BkaXhQ?=
 =?utf-8?B?ckw3b1BIUWJBT0tZYUlsSnZBSlg1NDFtTmg2MW82anh5UW52UkhyWGk5dGtK?=
 =?utf-8?B?bnd0UVh1VnU5MWk5ZjNZUFI1KzZyYVkzMytIaFZWMEVsdzY0RFRqSERISDRL?=
 =?utf-8?B?U2xtZ241eXNHYUIrQ2RSTjQ5eDJyT2t6WXc2QWJRTWZFWGRkVFhOUmVSV2Y5?=
 =?utf-8?B?dnZkRk8xcEwvd2M0eWgza2dwTEhTMUYxSTV4Z2gzN1pVVDJJQUF1VFZJUzda?=
 =?utf-8?B?cEg4OUg0ZmY4Zy9GclpWZlNNcDVBSlhxMFJKT0RjK2Q5K0tOWlp0aGFzdTlk?=
 =?utf-8?B?cXJXS0k5VlRXVXBORWFsU3FkRkFSRjhSL2w1b0x0TEdkZUdlZUxjNHRmcVJE?=
 =?utf-8?B?ai8rUk5nbUpyblp4RU5YT1B1alEwUlljanRyK2UwMnFIbE16aVVyOGFuckdk?=
 =?utf-8?B?aDV6RGc0ZlFzMzVlRG9nZGo5RS9rNlFqbDZjYjczVmdEcFNHL0hqQ0wzL1JO?=
 =?utf-8?B?YlQwZDBIV1VSdktBOXJvTWdFd0VOdnFwaHVSTU5YY1FNaEpTdHhMWnhudks5?=
 =?utf-8?B?Z1RYcWFMVnM5VnBSaVNkOW9uOU53KzNiRWZ2M0RGbFVXNEFWS2ZzQUxHcWF1?=
 =?utf-8?B?NGNCcjZaMEJ3RDdOemd5eXEwVWprV1FRcWUvM3o5Ti85aEdNdkNNT1R1aVRW?=
 =?utf-8?B?dHJGemlsWWVBUzkrS09wVE9wcGxDNTRZZHRldmt3enJvRGl5Tk84WUl6WFhJ?=
 =?utf-8?B?OWZtTWFGOGROa2pEa3I1RXhUL3FFbU92MFFncW1ST2lpQitrc3doM2RoNWFK?=
 =?utf-8?B?WEFGUWFKOFpWdUJMNXA4Vm1zL01RaFhtM3FSUThEWnBqajJiOUZUWlFDS1lG?=
 =?utf-8?B?SFJBcjJGRUVoSFEzMDhRalN0Yit0RHBYYU5lY3U3K3J4bFdqRytMQjV0Tzli?=
 =?utf-8?B?MGNESTkxdXltYmR5NjJkSlI0ZjNoeUVIa3dINlU2TDR5RktiZ3JqaWJFcVdr?=
 =?utf-8?B?QmZUR3dvQmovU1dhb1g5WmxxYi9rUzZaa3dEL3pmcnpIL0xYTmlpTHNPS2Iz?=
 =?utf-8?B?K080aG8vOW43TFhXT3d2cHpCdmlTV3lnSnA0cllFeFlyVm80WTdTNzUxZGNB?=
 =?utf-8?B?T3BQUDkzSG5Tb1crSlRtNlY4MTJJcUNudXNSdkt2QURsL1ZFeEREbFFCZnVn?=
 =?utf-8?B?ZTZVUGIxWTdtSWdSWExMSi9lNEZjYnNSK3FWa0lHS2piOE83NXFyVzhyY2FW?=
 =?utf-8?B?alBuUEFrb1JOZitpK0hrRDFqWndnRisxVTNLbVRYdkFtaUhDdXJsTUhXMi9x?=
 =?utf-8?B?Y05Qc1FoeUIrOFl4eFVpSUR3ZE1RcGhEOEh5K0FZTSs2bmNTZTVONmZEOGFz?=
 =?utf-8?B?Wk5Ocit2TUpGNnhQbElQQyt6RzhzUUJaS25MN3lJY3hYYzBzSGw4ak9NcTlJ?=
 =?utf-8?B?dGlNZGM4WU5IQ2phSGMybzBqWmVlNzNCblBmdDRJY3dFWHVlcXoyUUtsbUlx?=
 =?utf-8?B?blpUTHpUc1NsL01zR1o3MmZBcmJoNDUyTUZ1UVh1SjJDWXh4TG5OTVBaZGg5?=
 =?utf-8?B?Nm1TTXk0UU5PLzhwd1greG1vbDhhZFBlVUlSVEJWK1RTSzBPclZwbzBYSzlZ?=
 =?utf-8?B?UGJIelUrSnJhTUY5N2JjZzVxcm5NYnlMVENGZ3NWdEhOOTg2Z2NvaTNyUWxX?=
 =?utf-8?B?bTVEa1FLQUdMeHpPSUpMUm5mYTA5Uk5qdGpmdnJGb0FxVzhBTUErT1gvb0gv?=
 =?utf-8?B?MzNTS3JPVnE1TWswbHVsUEVDUFVXYStYUlZabXlkVGl6aDIwempOY0hZRzVv?=
 =?utf-8?B?QWEwSkhYYjVmMWlkV0JnVFQvemUzdTJSdHNhc2FMeTNKRURGZHJNUC9BYlpa?=
 =?utf-8?B?eGZwcExKZ3hVYVl2TkV6bkhpcFRBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd61c68-dd1c-4c48-e2c0-08d9db8ce6bd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 20:47:26.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuPpxbhA2IwLHqhlALv96b+eyi8tzRAZyqAMGJhliekScClB8prxhKi+Ux5rkO1kKkntbvS7jpoToZR+3hE8kSz8q269mPIK12JoIyDgUVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 1/19/2022 11:51 AM, Dave Hansen wrote:
> On 1/18/22 3:05 PM, Reinette Chatre wrote:
>> The machine check recovery handling in SGX added the changes
>> listed below to the freeing of pages in sgx_free_epc_page().
>> The SGX reclaimer contains an open coded version of
>> sgx_free_epc_page() and thus did not obtain the changes in
>> support of poison handling.
> 
> I was trying to decide if this is an urgent fix or not.  A more crisp
> problem statement might have helped in the changelog.
> 
> But, from what I can tell, the most probable troublesome scenario here
> would be something like:
> 
>  1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
>  2. arch_memory_failure() called is eventually
>  3. (SGX) page->poison set to 1
>  4. Page is reclaimed
>  5. Page added to normal free lists by sgx_reclaim_pages()
>     ^ This is the bug
>  6. Page is reallocated by some innocent enclave, a second (synchronous)
>     in-kernel #MC is induced, probably during EADD instruction.
>     ^ This is the fallout from the bug
> 
> #6 is unfortunate and can be avoided if this patch is applied.
> 
> Basically, this patch ensures that a bad enclave page is isolated
> quickly and causes a minimal amount of collateral damage.  Is this a
> valid summary?
> 
> 	The SGX reclaimer code lacks page poison handling in its free
> 	path.  This can lead to completely avoidable machine checks if a
> 	poisoned page is freed and reallocated instead of being
> 	isolated.

As I understand this code it does look like a valid summary to me. One
detail is that the poison page handling is currently done for SECS pages
when they are freed by the reclaimer (via sgx_reclaimer_write()).

Thank you very much for the detailed analysis. Should I resend with
an improved commit message that contains your scenario description
and summary?

Reinette
