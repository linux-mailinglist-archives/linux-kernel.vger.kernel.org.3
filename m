Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B735952B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiHPGkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHPGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:40:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDCEE6B0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660613123; x=1692149123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v0PTOihVtJoPTekA+8dnFPyFrIEVu53QrxOrI9b/C1A=;
  b=dPTWpWsV9HatD4tHb/hJ0C+OCxo6SThQF6Cex2z1yqBha+3tnO/z6mdV
   hBbeNP9MkItYox7HLIo+62uThr2B/fdz5/7spoGJ4UXmFtCUyocgaZg4Z
   YVXDNl1V8s89M3j1Z763MaqFwW6ULxflg1QVArY0sukkN6wCeL9pQn1GE
   OWH4iun1OtRWFgDraCesZwDOs46diu/AluusHH8k5jeg/dT/gtSRH22dV
   S4DuPjMwaiVmQXXbaAaGQBu54LvRYoaftrdXJ+Itgn08/i4OcRNlVdt++
   kCfs3NrU02jLAwTfx1/ee0EhvPXIMqmIETF/h2ZaVzYFQ0v4ttikEBq6w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378388111"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="378388111"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 18:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="666888504"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 18:25:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:25:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 18:25:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 18:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaqAUUjxNsnHy8OR7DliZVBHLyQFb1EcA513DA5Boi6OTlLsyxQgYE8M3f9OBBBxuu+OA0D7epj2Vp702psLR4OwlI6vgERdJ62nZyZdrCQn9V6jPxa9AMgkbhYq0mrbRUlbfrv8cn8SS5iEYvmo4KWmq7ogQ3YcOY3o4koSC+bWCwsDl002/PgcO+/mQkRMn0p1yHnqIH5oHrgLrN1MpdSKN4fnR58WUdlrYPrIL+Xyrp8NpmPXw/XiXX1yYZXyTwZyZDqt6l53cTJ3u6foiWsqVoGVTYaZ5+pEhXRXHv3vo+YgrL1Y/o5DPT9U3sRw+wz+6R1TBy7oLNdYtnt5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in6UCRHiW5gA/oUfWEiN84FNXRAcIPWZn9tH/k8yoDI=;
 b=Z7fAQpZ923vV/PtPLYrHYo09fw5ipeQr2VzCv09QqhvhtNDgGkzl9vosDYYzMRQjcNXBWGDpJB2VcERaT03wqlKmaQ16dfsr9f9KwY11kkQjbt3Stpzu8/m6do4Y91436xAYidIOJkgHMRKlpS/yWl38zqE7iath9u9453Py9BSu8dhujC6FHbB1EveN2canzcOeJVa/qtr4mDRRLJMPyaAjuGS1f506xbsoVEGOgeydJgc1rZhLUcjyYm8UUGsrY2mCUZbQqo92SJPdRPfer6Yy8qNMu3rdh0xlQVWZmiCISZbBzQgip8jkHVjrixO+IqM/H2hH7Y162vO5gfeh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BYAPR11MB3143.namprd11.prod.outlook.com (2603:10b6:a03:92::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 01:25:03 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 01:25:03 +0000
Message-ID: <b9bf1263-5862-5bb5-eaf1-399904717c49@intel.com>
Date:   Tue, 16 Aug 2022 09:24:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 6/8] memblock tests: update alloc_nid_api to test
 memblock_alloc_try_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <4c9b416480a5070f18c3933a1a03296f32c2091b.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <4c9b416480a5070f18c3933a1a03296f32c2091b.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3fae44c-26be-4c9d-37f5-08da7f26249a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55o4tSrij8AkvmnsIUeUwK1IEiWOJM91uUtHy7P4KSlS6hzBcRXkWCH60ljgcYG5g9Qw4GiRxHqF8U/7aiTqsI3pNyFTZ3lBdK89/vKwsfk5l3E60zpZSSik3U5eidisFGi8lRfwdN2Ggduib2XzhUQZaToczQMrXDh1kdyZeKp8b/YxrBaSuod64KJ2zXS2vX6TtQzJJOAgpO6CJ1uscNtMlYX2LyLa4+oAXUtuWMWDpE8OZfTL7WUKo2icDsWGj7I8gdCSztRZ7vCMjkPLx7EwlR7rsPSTJOqYD/9qm1Sl9lU2wBFX3I4LGaPf3p1+dZGzBwIBSeX7wInM2ma0dmI2ZA5hwtcyTRWjBsUGoH76q18Yyx3MfcmOzzyoNr94ESiqt//WfMSZVW6jHswWiD6yvHGwsYhT5xpDoVekVF0+s7nL28+GOkQlcJb/RWjtMgoCSmGuDSSnQfD2Y1qbdjvRsh/71sywMAR0bEu5vxvmC6xAJWAiZJpPBIN7zBNVZ/hSyV+8Exuo1L29yifdn48soq8k7k8+X0SDbseffMPTvJS4QSISzGg9eIr/ctlQtlQ4oXnXhRpzHBu035wh2RtIik7ads0bK9hog9yUA6Whym4QVON12fmvP82dEaVotFPiWiclnkWLXS+/6sb0gmQM2hAzyElnP/ZFdp5cF6oe8g98I7SF3gdbHPw/zO4BoW4ZtlCeOwtQot1ynMVoYHiMO/Ti9yyEBHIOIA4KToaXnIf+N4kRjys18fvxlvhpjs4VhjX4Wk/OaSN9XN41UQrqEpkMdAbfoDKtWPQbsbrdabHZEz8EsXZ0z/JPIBPXIl3IFL2KnNJSt3cd1v2Wtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(376002)(39860400002)(38100700002)(82960400001)(36756003)(31686004)(86362001)(6506007)(31696002)(26005)(41300700001)(186003)(53546011)(6666004)(6512007)(66476007)(66556008)(2616005)(110136005)(83380400001)(316002)(6486002)(5660300002)(66946007)(8936002)(4326008)(15650500001)(8676002)(2906002)(478600001)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2d0MC8rZ2cwemRlNGl4OWkrWHZKNTV3YTR2UjllcUhhWFZIRGZLb29YbTZi?=
 =?utf-8?B?OFpaS04rTWRScWJSV2Jwa051M1JXSFN3cWFTN1plZjZRanpveENiTUpGVGFI?=
 =?utf-8?B?VTA4ZnR1NDlaWXpXWTBybkpKWUtvT0RLUXJhblcxeFNsbzUvc0xzMStST2lx?=
 =?utf-8?B?SnppYmgxQkk2SC8yR2x0S1d1eWt4cHVFMnJiWU5qYk1qaGhzVGdjY3RQTXV4?=
 =?utf-8?B?WlFJUUhEam0xc2FpdFNkdkZXaE56MFJNZm5uQXpmQUVNVitXYW5XZUJxNFVT?=
 =?utf-8?B?TU1BRkZqZDV6UFNLVEVBbnloalNWU1FiTGRUNzFmeGpEWDNTSGFRZUpzdm9I?=
 =?utf-8?B?VWVSZmVNcFVzc3VpLzZvRVRHTHh1anp0RERGWVAzcFdrRHEweW5XaW9hRHIv?=
 =?utf-8?B?RHVDbUxWODl0Sy9KRVk3Z2xVMFhPNGxsVE1jT0VudzFFcmZuS1Q3OUZ2UGJu?=
 =?utf-8?B?NGZHSDF6ZzZLb1Z2RktmNzZUZEliZnlyTU9sMUhRUXB4aUpFUFFZUXhqeEly?=
 =?utf-8?B?bGJDREpiT0N3RjVxSENORTdFSHFnblNldnI1U0NqeDdpN1hZKzRBbDRDdG40?=
 =?utf-8?B?UmNTY0hadGJ1NW9BbVV1a0pwQnB5bmxzdlhCZlN6K09xMEhtSXpwNU1XYVVx?=
 =?utf-8?B?aHljUkMyMjZEL1I5TGViWTVQaVRRY3BoUDRxS21wb3FlNHVpRGxLa3A0TTk3?=
 =?utf-8?B?Y0ZaOWs4dzZOcGZxR2dZc1NoUzRCaVZTZ0hqb0FiZklaajZPMVUyaEhSMHVY?=
 =?utf-8?B?U2JyTjArZW9WWnlFdHFDbEZuTUczc20zUEFOQTNtQXpjT1VMUFA0Z04zNHRM?=
 =?utf-8?B?QzV6enNRNmpkbVFPYXUwWFc2OUxSVnpyRVJ2d0tsRCt3SEhpd0ZQVGhZWWhX?=
 =?utf-8?B?REVFRGVwdi9kbmhvUmdoMlFSVjhGR25uTHAxbEVMb1Z3aWhxSlpwMFNhYXpi?=
 =?utf-8?B?VHBBaHFnNFowcXlPOXdtUlQ5bWtHOTNZQ2NvdXVZQkNuOXc2NjYzUHNtUm8w?=
 =?utf-8?B?a3kxOTdjMXB0eHVjWnp5bTVDSHRVNGJaWXBuM2x3UTE3cHFaQkdqc3VQN3NT?=
 =?utf-8?B?d243Q0pJMEVFQnRidzU4bGRVd0tjbWtzQWpkaFhtMTdRSEc1WHB4MUxLS0NU?=
 =?utf-8?B?OEs3ZWp1Zk1NdTVXSkJvT2xYaEduVzMrNnlXOURJN1grSmFmOThJb0pIdXly?=
 =?utf-8?B?WHZ1WGZKU1M5OGg4ODlpQXdWZjNGdWhhZVhhV04wV05zclBLMUsrWXo3OHdw?=
 =?utf-8?B?WE9Hd3dsQnQvdzlVbWdRRy8ybkNSVm4zenBmNVo5S0drcXRwclJzanVjczBF?=
 =?utf-8?B?ODg5dXF4Z0c4cko4VGtyLzdiMlR6c0ZxR3doejltM2owM0daK2s1cnhEdmJV?=
 =?utf-8?B?c0Q5N21Wc28wKzlOV0xmb3NUcFNLTndWWW9UR3dHOU5OSmRWQWFUeDVhRitB?=
 =?utf-8?B?Y3dCZWNYcTVVRTIvUDZib01pR2k0Ri9Cb2o4WllISnZjK0xYM1FMVlBjamhK?=
 =?utf-8?B?UGdnUy91Q01TTkhtbnBmci8rLzN5MnBSdEpYTDNobWdXTmRGSzM3WVNzZ0FW?=
 =?utf-8?B?RndBRU53MHR2a3RjcUo3RFdHOXZPK3h4RFZqaUNocEdDdEhndkhFbyt2WTNY?=
 =?utf-8?B?RldPcXkybndMRnZUd0ZobUNSV0dvbzE2Y3lnK3Jza1R2bzZmcGgveDVvaEVG?=
 =?utf-8?B?YWJXMkdYTWluMGtmcHhYZ1J3eUlTTGMzNFA2QWZyd2lWYVVQZ1hTVjgvaUxj?=
 =?utf-8?B?bngzTkpnUDNsRk5EVmxFSHBrZlNSSHhiMXFYejZtN0tZbXdLY1J4ckYrK2Nt?=
 =?utf-8?B?TnVPT3diWlRXOEUzdkVyTmsxUVZYWWRGcU45bldML2JwaGVRNFcwTElQU0px?=
 =?utf-8?B?RmtrSm41cnA5aXVsTTNDQUtSRzhaZWpYVGI1TjBoRG42SmZMWkJmZDdydUhv?=
 =?utf-8?B?Si9FdHNWeUhMV0JUTTdDZGdtbXRVaDZXOVc0bGZwZ2s0cU93WGh2cjB0Y1dD?=
 =?utf-8?B?bGtlQ2pieThSTCtlVVYrQzJvbytTOFNUK1JaYjQzQ0ZTM1pMTG1wblVyRUIv?=
 =?utf-8?B?dTFpRmtEMHRnU0pDbGttZXBEVHZWb1kxRnZGa1Rmd3FBUUpiOFVoczMxWVJM?=
 =?utf-8?B?cXdPSmVUc0FJYUZ5L2Y4WkhsMzFCSlJDbThEQTBCWDVTUFJTeE5Wc2NJdnNm?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fae44c-26be-4c9d-37f5-08da7f26249a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 01:25:03.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cmwWhC7FeDV2Xjmiw1xEXBZP/FfPJKG7QvdGnByJlMIbVnJJrPJdyMSS9vWB+fomp51+dWqhdih78cHQITT8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3143
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



On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Update memblock_alloc_try_nid() tests so that they test either
> memblock_alloc_try_nid() or memblock_alloc_try_nid_raw() depending on the
> value of alloc_nid_test_flags. Run through all the existing tests in
> alloc_nid_api twice: once for memblock_alloc_try_nid() and once for
> memblock_alloc_try_nid_raw().
> 
> When the tests run memblock_alloc_try_nid(), they test that the entire
> memory region is zero. When the tests run memblock_alloc_try_nid_raw(),
> they test that the entire memory region is nonzero.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_nid_api.c | 196 ++++++++++++-------
>   1 file changed, 127 insertions(+), 69 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 82fa8ea36320..e16106d8446b 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -1,6 +1,42 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   #include "alloc_nid_api.h"
>   
> +static const char * const func_testing[] = {
> +	"memblock_alloc_try_nid",
> +	"memblock_alloc_try_nid_raw"
> +};
> +
> +static int alloc_nid_test_flags = TEST_ZEROED;
> +
> +static inline const char * const get_func_testing(int flags)
> +{
> +	if (flags & TEST_RAW)
> +		return func_testing[1];
> +	else
> +		return func_testing[0];
> +}
> +
> +static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
> +					       phys_addr_t align,
> +					       phys_addr_t min_addr,
> +					       phys_addr_t max_addr, int nid)
> +{
> +	if (alloc_nid_test_flags & TEST_RAW)
> +		return memblock_alloc_try_nid_raw(size, align, min_addr,
> +						  max_addr, nid);
> +	else
> +		return memblock_alloc_try_nid(size, align, min_addr,
> +					      max_addr, nid);
> +}
> +
> +static inline void verify_mem_content(void *mem, int size)
> +{
> +	if (alloc_nid_test_flags & TEST_RAW)
> +		ASSERT_MEM_NE((char *)mem, 0, size);
> +	else
> +		ASSERT_MEM_EQ((char *)mem, 0, size);
> +}
> +

These static functions seems the same with the PATCH5 did, have you 
considered to keep only one common function?

>   /*
>    * A simple test that tries to allocate a memory region within min_addr and
>    * max_addr range:
> @@ -32,12 +68,13 @@ static int alloc_try_nid_top_down_simple_check(void)
>   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
>   	max_addr = min_addr + SZ_512;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size);
> @@ -86,12 +123,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
>   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
>   	max_addr = min_addr + SZ_512 + misalign;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size - misalign);
> @@ -137,12 +175,13 @@ static int alloc_try_nid_exact_address_generic_check(void)
>   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
>   	max_addr = min_addr + size;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -189,11 +228,12 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
>   	min_addr = memblock_start_of_DRAM() + SZ_512;
>   	max_addr = min_addr + SMP_CACHE_BYTES;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size);
> @@ -241,8 +281,9 @@ static int alloc_try_nid_low_max_generic_check(void)
>   	min_addr = memblock_start_of_DRAM();
>   	max_addr = min_addr + SMP_CACHE_BYTES;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_EQ(allocated_ptr, NULL);
>   
> @@ -287,11 +328,12 @@ static int alloc_try_nid_min_reserved_generic_check(void)
>   
>   	memblock_reserve(reserved_base, r1_size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +	verify_mem_content(allocated_ptr, r2_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, reserved_base);
> @@ -338,11 +380,12 @@ static int alloc_try_nid_max_reserved_generic_check(void)
>   
>   	memblock_reserve(max_addr, r1_size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +	verify_mem_content(allocated_ptr, r2_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -402,11 +445,12 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +	verify_mem_content(allocated_ptr, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size + r3_size);
>   	ASSERT_EQ(rgn1->base, max_addr - r3_size);
> @@ -466,11 +510,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +	verify_mem_content(allocated_ptr, r3_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, r2.base);
> @@ -531,11 +576,12 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +	verify_mem_content(allocated_ptr, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, r1.base);
> @@ -597,8 +643,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_EQ(allocated_ptr, NULL);
>   
> @@ -628,11 +675,12 @@ static int alloc_try_nid_top_down_cap_max_check(void)
>   	min_addr = memblock_end_of_DRAM() - SZ_1K;
>   	max_addr = memblock_end_of_DRAM() + SZ_256;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> @@ -666,11 +714,12 @@ static int alloc_try_nid_top_down_cap_min_check(void)
>   	min_addr = memblock_start_of_DRAM() - SZ_256;
>   	max_addr = memblock_end_of_DRAM();
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr, NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> @@ -714,13 +763,13 @@ static int alloc_try_nid_bottom_up_simple_check(void)
>   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
>   	max_addr = min_addr + SZ_512;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -769,13 +818,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
>   	min_addr = memblock_start_of_DRAM() + misalign;
>   	max_addr = min_addr + SZ_512;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
> @@ -822,12 +871,12 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
>   	min_addr = memblock_start_of_DRAM() + SZ_512;
>   	max_addr = min_addr + SMP_CACHE_BYTES;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> @@ -887,12 +936,12 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +	verify_mem_content(allocated_ptr, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, max_addr);
> @@ -959,12 +1008,12 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +	verify_mem_content(allocated_ptr, r3_size);
>   
>   	ASSERT_EQ(rgn3->size, r3_size);
>   	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
> @@ -1004,12 +1053,12 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
>   	min_addr = memblock_start_of_DRAM() + SZ_1K;
>   	max_addr = memblock_end_of_DRAM() + SZ_256;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -1043,12 +1092,12 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   	min_addr = memblock_start_of_DRAM();
>   	max_addr = memblock_end_of_DRAM() - SZ_256;
>   
> -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> -					       min_addr, max_addr,
> -					       NUMA_NO_NODE);
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr,
> +						   NUMA_NO_NODE);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +	verify_mem_content(allocated_ptr, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> @@ -1193,13 +1242,14 @@ static int alloc_try_nid_low_max_check(void)
>   	return 0;
>   }
>   
> -int memblock_alloc_nid_checks(void)
> +static int memblock_alloc_nid_checks_internal(int flags)
>   {
> -	const char *func_testing = "memblock_alloc_try_nid";
> +	const char *func = get_func_testing(flags);
>   
> +	alloc_nid_test_flags = flags;
>   	prefix_reset();
> -	prefix_push(func_testing);
> -	test_print("Running %s tests...\n", func_testing);
> +	prefix_push(func);
> +	test_print("Running %s tests...\n", func);
>   
>   	reset_memblock_attributes();
>   	dummy_physical_memory_init();
> @@ -1225,3 +1275,11 @@ int memblock_alloc_nid_checks(void)
>   
>   	return 0;
>   }
> +
> +int memblock_alloc_nid_checks(void)
> +{
> +	memblock_alloc_nid_checks_internal(TEST_ZEROED);
> +	memblock_alloc_nid_checks_internal(TEST_RAW);
> +
> +	return 0;
> +}
