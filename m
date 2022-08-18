Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97602597AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiHRBPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242544AbiHRBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:15:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C982D3D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660785332; x=1692321332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lUYwMs3b/l/q3QUwbCIlIMtSlii1toC2Lts8UkeE2YQ=;
  b=D1Gs6PQwd2xFDd2mJtu0OfJOgJHMyuUUwJ4ClesrTTYRcgvvmWzojY2G
   fIKlpydZZ9GFFCJWnZoNilxqOW7LrAWtER8xqOLWDEWHca5mIIyx6uQEJ
   p9ZeL1eBiR7sSYYpFgKRjwrGRa/fejAsHI04vmQCjC7uaa5DNPMXMEBCd
   1i4FZcXzkXcuAmr/WT+9dZLcs2g83X4yI8Ikq2ZsyQOt+bzQy58yz5eHQ
   5EhoZannY2Rq3cTrp0bRUktEJ/pYdlzeaZuJ/jPVaanN3WdGBDtHK65aN
   +J567b3Tp/yvIWULoYK5X/shu5aQGGugMej4sgI5gwNfilT3yHkfC8M/Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290206494"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="290206494"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="583996410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 18:15:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 18:15:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 18:15:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 18:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpt1CmXprje09xLsY3TeQMO7sIsOWV0Kon7jiPCQ0vtAgX8WvCUHaXP68WIWOqUkHyKZqcxJNq9ZuDBoQvoRIfvDPwGeYIuN+ukVSG1l+o0+5RU/Uz4auqrNe2C/ezS57NOicuykmD9TGdUU16CrOLDC5NNmz9UqGRKzKf5mkdaxq1BTZro+4JmWG4Uc89AFwTd5m1aMPEFLEscRa7EA1ezWFe6M4ga164gvrqUB49A7UlZIC3qHmrRDK9isQEQTvnYtY4HW1IqJ7lm5ELRWOgcIu2/8/m8cft4L49MelVPkmNhcVKixhf8c8LqOFaLaU4FDxXoFZe2VqfRCu3JXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+BKx0OFVgfGSwkdVAPQT8g/X93+VVfu2rxPRqCgbaM=;
 b=YFtOaVKS9nS0f29r+vWYS+omIO8bZtblpN/GNSsCqDrJEFpasU/j5nZCFKyVf3vfjpjMuX39WX0nnYerWg3FRaSVncVjauqCKSMd1BgYOkqHfGR/lG7T75qXWEhvZL7YjkUH/x+lgZ8VyLParYx1bziNNWCOVc9DMpPC7g+Ap6z9sg1/jO7eW6QgwzuveOdyFKb1vIscFUiueLmMOZSvCgBl6odcVpKgdWW7DCw63Cl+xuqQUSDcetHGxUhUU4aKdNMVOEOTuhTfGaXYPegrGRbvnyE/kEaYeDKEIu0au0itiQcqmLZpMwZMhIQcSoM+YzPchvFK9tGvceuiO9n3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 01:15:29 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:15:29 +0000
Message-ID: <70ea9b8d-c1e1-5ab5-f001-7a81814dd8db@intel.com>
Date:   Thu, 18 Aug 2022 09:15:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20220816130553.31406-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2108be05-b3b3-417f-6648-08da80b723d9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvE9Uzfxk9EXqDPvv5GhvRmdHk10X3WN9XkaJbJUsE0B1b26sebO76NkjKvsULjZrfqG524m2dUvbVSwBm80sCD9Q09fo/f35l6yYVpPEWeAh2ulvNP4Quiunj9wBXE/HzkbEHWWSsZM+mcu1pNSWArcLLgA20WP7zSoepkX8lKYeO4O7OgpFhDousFmNPI2Y/807/4Jl1gNehgqSzR/UT4/+4hoSdw+ygLw9KlbSjDAVBcbuVS7znlexlZDwhZr1pze9YkWqBSIGgGhhu6N6gHOvS+Wwi4uFngCZ39f5ggfB6i+EJ85ScibX03niIgiKftuDoochRmAZNeYMBflgauXNg1T4N9tau/q5c9/0Y4XDNbze+sZwyCXFWxIz+rCztE3J7qWYxVOcZVd34TaL0do9Bayg/K6U0XsQ015ayES0eXObwMSMFRERWJWBRNhQt4OfUWbRcGwDq6CKWEbeJUT71vfSG1GBTXm1ErzQ1LGHMrYYnaB2mz17BE160xzvFkuMkewoKANxVURiqR1vESLPPyE7igtSN5K1w75xG4sQ3dcRXWCXd9AsDoa65SH6bOBDulCB3eSQkKTCYyyvB6wugC1c3YZz3H6eESlzMNbmB2KtgMsGSGVA+X4TVV+bPg2+yF9UytUKLeEvpPYkRzTqXzmJgNJbST+1+phlvXSZMLW1PU0X51HvXsR3ofIV9Kk8kmqCMDFjAUoA/cxeIXt8Ypv9CPmU8NHihwwfKP2IbydX8+mEobBz2eKCC2tnqdw2VhRdL2Zvi3WhUu5kCybXwUEmSHHXR/wb0oMkrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(39860400002)(376002)(5660300002)(38100700002)(8676002)(31686004)(66476007)(4326008)(66556008)(66946007)(36756003)(8936002)(2616005)(186003)(6506007)(478600001)(26005)(6512007)(82960400001)(86362001)(31696002)(2906002)(53546011)(4744005)(41300700001)(6666004)(316002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpkK0x6eUUvMDBaOUtYTmo2S0xtT243UjNLd3JlS2RCN1dxNERNNGlNZnpW?=
 =?utf-8?B?M0MzRUFEMTVwQkV1eEY3d2djdEswbjZFY2lzRG4yVGk4Yk5HV2Y4R2oycmho?=
 =?utf-8?B?TUlXdGdUT1Bqenk0YlFpSnh5Z0J4Y3BmMGYrSGdEQllCU3FRTEVjM1J6Vitp?=
 =?utf-8?B?K055bFVyM0hOVUl5U3FYaWhKMGtmNW1BcGJRR3prL2oxYkgzUmV3c2diODg4?=
 =?utf-8?B?djB1cTJIQ3lIdFdKVHlSaUZadTh2VW1rd3F0VWRpaDE4MkNXZEsyYTJCU2xk?=
 =?utf-8?B?ZENudys1aUtLbUo0WXFhdmZLM2loSjY2QnhjTWlyWGJTVGU5MnVLcm0zQ2ZF?=
 =?utf-8?B?c0d1VXY0ODN3T3VNUlcyTGZpMGJ2TFkxb3lGeEFyZzhsbkJSOGtvNGlpRWlV?=
 =?utf-8?B?blNMbDNvUG5TSlhtRi93a0RDWW1FYzltbnpOQTM4cjZsV3VuRXBCZHlFMExm?=
 =?utf-8?B?c2FjR25EY3dTMXNIcXNlWjBycXlSY1J6K2VRK1ZPZEVxc2ZNNkxaMDZYd0Mz?=
 =?utf-8?B?L3lnbU9TYzZTRURRU0RubjV2QnYvV2QzK1dUVFpQUlhoYTNBbDRkVzljK1R2?=
 =?utf-8?B?UzFvRlI2TXZvaTNwZjR0MEJISExhQVNmN3l2aVh6bk1aZDY0a01WdUt6SmxH?=
 =?utf-8?B?U0p1bHluT05DUk5jT1UrL0tiWHFCMlBaMW5IQXlyaVFwNmRMN0lMZStzRTM5?=
 =?utf-8?B?bUxYYzg3NHhkSVpJMFdXTytJQks4aUYxdWdWbUlPK2w4UXVidmtuVTZlblVB?=
 =?utf-8?B?UnJVZmlLNlI4OVA5VlZjSVEzQ1lzR2dmMkkvOU14MkNIQmx0QUhWZTQzSjlr?=
 =?utf-8?B?RHpSdXhzZXBnNlBPbmFFVlN3L3BvbTBkSk5PZDNzeFc4WnllQkpmWHluR3Fk?=
 =?utf-8?B?dDl0a1hiRjI2WURwWHd2YVFwOVlvWm9NQUtOblBGK0ZocjhsaVNWUDkvQWho?=
 =?utf-8?B?d1FEZ3VMOTZldUJhejFzNDhVVldWQ200dS9NeTA5eGFxdWZqcnZ2bFh5c3h0?=
 =?utf-8?B?STM0aXpYS0t4cnIyRTMrZmo3dnZZT2ZocEphZFU3OE9jMW5OdjZEVWRtTmtM?=
 =?utf-8?B?VStNdTRGQjh1YURtUW5xWFhuQVNnZXZTSkRLcVJGZ21BSzkvWUFFempOY2Zx?=
 =?utf-8?B?RlJDWVVVaitFcHMxMW9kcXk4R1FWdUtQK3pTUlVndmdnZ3J2UFBLTjcrZThh?=
 =?utf-8?B?VFZWVDNBY0FMcS9vZXdFeVlIYWZxYmM5VTN6dnVFZXR5OG45RjlvcDFOam0r?=
 =?utf-8?B?WTNlcUNYNnJqc0xGNnRDMGovY0NCYmx5b3p4NUlPQVZWWkRnRHhHdGNzQ2ox?=
 =?utf-8?B?U2tIbFV0V0FoZ1FIN2thOGZwUnRUeEdsZmJMWXd5RnZjdXhMTFJyN3hIKzZt?=
 =?utf-8?B?bzh2ZjZJSFZBRWdOVExncVpKUEQxUGVvZDR2RGNaNkZBQXNsZ1hNVGVIMkh5?=
 =?utf-8?B?V3psK3Nad3I1T0tJKzJWRUVpbkVTa1A0SUZiTDgya1ZUVGZ4d1JVeWVNcEdn?=
 =?utf-8?B?SUhWOCszZ1ZzRUp2emxVZTlwamREVG5DaW43YVE0ajZmRjUwVHVSaGsxdzNH?=
 =?utf-8?B?QllHTlR4cXpwN05ORWdZV1BkQmZyMVF4K3RkQ25tQ3pLT0JMZmxxdW11OGd6?=
 =?utf-8?B?WW8xQVFkc0NENWtzdHNCZ2VCN3UvRHBTT3BhNHZ5NENrTlFkbFVWT255RVph?=
 =?utf-8?B?TGhjc1ZvOHNkdU41Q1ZjODc5STBHckxuRThGeGNFRmQ5c1NvaXJtZUcxVE5y?=
 =?utf-8?B?b0dTS0w0dEJvSVF5VHA4cThEQzlHQkxaMXRhN2hja1hNVVJwaGp4RFc4TTFi?=
 =?utf-8?B?QXNscjlHZkhpNlBRK3hCTkhva21UVmMrbWxSVXhvRjNvT0dubVdoSXcvaDBa?=
 =?utf-8?B?Qyt5VHRoSUJLaEdjeHpUVWVLSUV0OFdwekZOUjdsZ0Q2UHc3eDZPbzBaYXVO?=
 =?utf-8?B?Sk1xODRaVWRIU3ByT21QT3dnYVZXYlZMWFZpaEg4ekdWNXg2Zy91dDU2cDRH?=
 =?utf-8?B?U0dEaFlQZlpLaFd4YmNSRFNZSDF3Q3BkbCsvQ2VuR2gzRTFnS3BZTFpqY0Zq?=
 =?utf-8?B?WGQ2cjU0QmVPbEpWcitpVk5JT216UVJJaG1IdDJEYWZiWGZaQXhvb05vMjdL?=
 =?utf-8?Q?t9EyUZAF53XUXonhV8fuBAfy6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2108be05-b3b3-417f-6648-08da80b723d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:15:29.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j359DpE0mgFDezdm8pDWzcWyqNxB0GoXJt9MUfKBalPG8AZJh6sEI93vBVDRISq+Aoof1kcQKq+ZhyD6rrDNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2022 9:05 PM, Miaohe Lin wrote:
> The memory barrier smp_wmb() is needed to make sure that preceding stores
> to the page contents become visible before the below set_pte_at() write.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Regards
Yin, Fengwei

> ---
>  mm/hugetlb_vmemmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 20f414c0379f..76b2d03a0d8d 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -287,6 +287,11 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>  	copy_page(to, (void *)walk->reuse_addr);
>  	reset_struct_pages(to);
>  
> +	/*
> +	 * Makes sure that preceding stores to the page contents become visible
> +	 * before the set_pte_at() write.
> +	 */
> +	smp_wmb();
>  	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>  }
>  
