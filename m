Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6237C5A4390
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH2HLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2HLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:11:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BA64D805
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661757097; x=1693293097;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P+ziSV0eNsbG54hR38sKcS0QaLKEmyHHJjA208177EM=;
  b=TBY/L33D4KSqzDVJLzyIJHycraH19xg/cvuqP7JOfEQmmRFTNjW7H+th
   0qJwgZ48ojbCDbycNTrAwEzhOJvK+Phm281uNd2SUzWy8rmtDO8K78/Bc
   fcxBaP3CVaPP9nAhcMvXLgO88GgRN2mcgvoyeX3DzqfGBT8hFUlc66DRN
   j3wP6UKT4/1zqoHqj2TXWo+kZDZS2+rqNcpsyrwQmTinNA3d1PwvutS6R
   O86O+C4gwKR+grtCjQL2fMTYBTIsl5jVCDHmSskxhlgNVYpBDCGZ8C19n
   3WkPix9gYttd9pSuvDG64b4yaSqZaStQH20gP8QnsTcOpLMqjEdvcqste
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293572687"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="293572687"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="700484932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2022 00:11:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 00:11:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 00:11:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 00:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWxoXE/opvSt9hO+RP8pOK7ZhzjYRfsp5iSV7LhULmjMGmfc+uvObBnX7BLrqjK0Vw+QwuekWrWFhFEO7HgsbMC5qSJLXyr0a9lqd6AQXfdBvN+i3EagZy1pF4oWXnNDN3qykRIzJRP3kcOvnr2p5wUi7DyLPRImE8lK1fBErf0I6oZPzDjabrAAZHa7CuQCq0FJKRqwsN/lEDuCyEBfyuH92yRYIdFUY2yDJmUX0DnY+rl3GlX3tVna8gC0Dxu4XtD/oYK+wO+Q/7iwkJVUkCRUkx88kAdYZriqMvw6R7gnAQVO8SHi8TkojyhBeNSMk0qo/7IsF3IstsnEweoLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkK+aHY9ugGk/MHi/AxWIw2QQ1+d8lEUQJ1NS9VN+PE=;
 b=FMPRHOmPRlUnwTQGEejsATtR0x5IN9DTKcSoq+0ihNP7DHHQJZIV71OXr2P+dJ+r1rusiGdFfeQkZnc10vYwHAvpY3PIle+rT+P1m0xWwvB3x1Yv4AjpCSpB+zp1VxtCAFC31mQFmlLhSuWGhO+/Vl7qGBKWRNbuszJCpZTjnW0bMbcGpQEgtJiUjfK4l07Ys9jvKtbHp8no6J+b30T95BTxTCvjqHfih4mrG+usIMMoy4T7SXpCHmEmnJUUKlhHnrJG8IgB+q3wfUebi5yRYNNQEImRQNONMQtXiEF51OtxKyFA4mz9sQ1UUJZ2/PGfKDdF87Zyz1H3nb+izDhf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by MWHPR11MB1454.namprd11.prod.outlook.com (2603:10b6:301:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 07:11:35 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 07:11:34 +0000
Message-ID: <d74b6fc8-7d4e-89d1-1c29-843b98a30112@intel.com>
Date:   Mon, 29 Aug 2022 15:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] tools/libs/slab.c: fix compiling mistakes of
 uatomic_inc/uatomic_dec
Content-Language: en-US
To:     Song Chen <chensong_2000@189.cn>, <karolinadrobnik@gmail.com>,
        <rppt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1661755121-3286-1-git-send-email-chensong_2000@189.cn>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <1661755121-3286-1-git-send-email-chensong_2000@189.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fb4baf4-667a-43eb-3f73-08da898db4bf
X-MS-TrafficTypeDiagnostic: MWHPR11MB1454:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riltiPF75x+TgYpON7jsjnMitdhyEb0lgYVIxAlDv7fDFIao5fddkm1kOPLoNptEEP4Hpnrn8vPLHqAd/bsh4ZeFvL8y2KR9u3Sy63P4OvRewadWzMADcKM7Wjfp6GjG9KFePq2+JvgzifuJpzGI6GMYxZM1FukfDPGDlKIG8e5PQQKPNQzEblqTw2jMHdgN4W/iqsI4eJblFVJR+CeVcUZ8ZC0FahKVc2dMhE0gUVcPbXC6UC1aMrHDDp0+IjPVe3ILgpYAA+7hlG7vkpZm0ZPm4QMhlk5qxkcTmPI+Oxz4eeOfdtN7Rz/PsikRunLLvahEehhBQt9jjY5uzqC0VeuXye3Crgi7RwEyyru5siCyyysSZYQwT5Y6wP73jfUPSHad6wqLou2OHPwnVoMGi4JyeC0ok6JGNAN81e18qySOKqiwgPDCIo8PmR8gxndR+8VzqL+4jN7JLDRPo0gFIaEcm4XZqlgQ24WXrtTEg3JyDuhH9ot8oIMl60RuRjYy5T5B+hbpeGzKqdAnRQ/We3tWlh1J8KPN9CYfb0dsbqPJeD1u8aMfkdyLypuZhdxfINQxPq8bhep7hSO3ygfsivvzLWN9aoS5++dcOlGqJhFlvSejgI9IQ1r83FI+sdz36cU6JjlSEkcnTzXq3ySXKt/RTzhbqB1pfUF5Re5g3CGjaqzMH06PJcazagLzG0egMtB89rLDMomlymuKRK+D1RFnhId08CqyTEYFCIi48VJWoYn2X6OoLwIarMi7/WStXuDjAyyeMDpwdMjpdblBrkmNocCzFq9bXjqbvF3qDdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(376002)(366004)(31686004)(2906002)(4326008)(6666004)(66946007)(8676002)(66556008)(66476007)(53546011)(6506007)(6512007)(316002)(26005)(41300700001)(6486002)(478600001)(8936002)(86362001)(186003)(2616005)(83380400001)(36756003)(5660300002)(31696002)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dEaHlJaU1nSitDcWRrUHhsaVk0TGJJQTlwNUhDMWRKd0RMRkNIMG9VRzdj?=
 =?utf-8?B?RlBYbUpYbmVIVytteDZidGZFcHVnRGlmL2NYR0dBQmJubGc1bDNROHJpQ3lS?=
 =?utf-8?B?dnJDNWF6VWhWbU9xOFdLaHNPbnRMdnBkOTlVUkJQTWRWcHNpOVVMeDJpTnQ2?=
 =?utf-8?B?WWp2NFRjalFHc1VUTjVYSTg3M3pqTE1nRjRCTXBxQWpKNjIzVFkvdUZjOHla?=
 =?utf-8?B?dmVJUGVJVHdnNVl3WnZMcDFUZGJ0cjBwZEl4M3NibDB1N0tNbXdZcGZZRjE0?=
 =?utf-8?B?Zlk3YWFLWjMrbXM2UUJ5N1BnRXRSNXpBcjVqNDlSMGlhbUpWbWFua1AvTXkz?=
 =?utf-8?B?MDdybU5LcmdFV0RVTWdIMEZTT3h0UWJYWVpxMXBHM2xpN3NMNGVXcXdWa1Ny?=
 =?utf-8?B?a0Q4bGFCeWZBSURqTjhpNkZjbFBqeU1BT0xWQUdlUWtVZDFoSWh0UTZsZzdV?=
 =?utf-8?B?Tkl5NFJscG54bkQrczJDblFqNVR2SGJPcE00Vi9UeloybFFxK2xrWklXMUZD?=
 =?utf-8?B?SCtoMTQzOWs3RmJVZUM2Z3dtcUV5anI0MjQ5di9zb0FIaGZ5VnRoYjMrTjVD?=
 =?utf-8?B?UlJwQXFueGd2bk43VDFFdWtXa3B1cW1icnZGdFAxWjZRMkFHdGU3dGVjRTYz?=
 =?utf-8?B?YmpJaGo4a3M0M2g0L0UxR3k2ZmcrNk9VSlNWMTlHbDd1b3RvZWpoR29ZVlNu?=
 =?utf-8?B?aUszSDNIUHBvdW1zcGt1SmZQK1daWElDREFlRWNLYk5HdzFBT0lpSytRam5T?=
 =?utf-8?B?b091eGpYakpGUWhQZUpaaGFBZEh1R3l0UGtwOFVXTVVlYVorbGQ1RGFkMzE5?=
 =?utf-8?B?OVJ6UHhLRUxGUXJ2WmJ4WVFtUjI2RUpHYkZjNGNPL0lESnFlWmJhbmQwME90?=
 =?utf-8?B?ekMwOGtYaDR3U0liVGlsQzZnTXlQNGJ6bHp3VlduQVF6RzlOS2JGd2o0WWV5?=
 =?utf-8?B?aXFKOWF4NnRjNWZPaUQ0eFB2LzRrQ2E3TXluM3l6VTQ2cEZBRGpyaVBGUkVE?=
 =?utf-8?B?V3JsTzZMdTFaNngwdnpxSzFQRUJreDVtbGVURFpKZTlPTitoWmt3czF2Qkd3?=
 =?utf-8?B?SDhWV1htS0pyR2kxN1hUS2h6UWY1U0JUNzJZc3VFK0FaQnNBVk1qblBSYitX?=
 =?utf-8?B?Y3duK05hVG9iNDBtL1o4dDJDb1RDbnVBdEpyNGRIVHhvZDZWcnpsdDVtTzlI?=
 =?utf-8?B?R3hjb1MxeXNBZGRLOGlkTUNjYWd3THgyWW04N2ZVaHEwSzlPeFdac2pMeFZl?=
 =?utf-8?B?MHBSRklGRm11aElkM2lFVmp2NS8yamFWVWJLOFZ3eG1rWjE2RUEwRk5tTCtG?=
 =?utf-8?B?WlV1MTVBYVA1d0VsT3Z5QlZTZzQ4MnFZbmtDS0tnVVFKWHBxZ2NIb1R4Y2ZB?=
 =?utf-8?B?Yy9qakszL3dZenl5bkk1M2lvbkF6NjlIYXg2b2RFcTBmcEt5OURKd3BLenNm?=
 =?utf-8?B?SnhLSFhpUFczVWRTM3hQbGdWYmZpWGkvNmJSQytpbjJEYzgyTHdwdDMrbzhB?=
 =?utf-8?B?bS9UQXZ2RDlTTUR0ektzMlJhdm5zTXVod21KSWRFV0ppZE9SbGtmd09uWVlw?=
 =?utf-8?B?M2dac0F3VEtLY0FVUldZYlo0VGp6UitSd2pQS2UycG9Gd2ExelVEai90MXcz?=
 =?utf-8?B?RmtVTFdnTU5pZDkyVUs2MjM4WGgyVFNaMVB5YTdSMTRUZXo2VFZTWHlUbjFQ?=
 =?utf-8?B?dEh6NEN1SkJ3b1RnbmVwSldEQzBucnNVSzdxMTBGQmVCbHBnVEczMXdVazNk?=
 =?utf-8?B?YTRGQ092ZkxyOTdmNFhUVTJjdHBWTXVpN0dQUC9XdVB0VTdGbTNkN0cyK3gy?=
 =?utf-8?B?UlQxaCtUeGF2dklZaGF5TFV2Z0FTQnJxamszRFdRb0hMTlpHRUVhbjJVdnRj?=
 =?utf-8?B?REN3LzBaazVLMmNSaFB0Y0NqQ0Q1cGs2UGJXbCtlUUdtd0ErVjlxNWU1NG1t?=
 =?utf-8?B?RVRyWmtUWjVZeGZSbXVDWjZhTngrOEY0eDNvWmN5VlFRTDJBbmZISkZITVNw?=
 =?utf-8?B?Q1R4VExrSU54Q0J1Q0g1a2MvanA2bUtGZ1dGbE1icHNFY2FaWGY1L3BGMlR5?=
 =?utf-8?B?RlE1SzA0clFybGFpM0drTGpLN2hJby9pYVBLcDhPT0tWZnhmQWVtM081TEJP?=
 =?utf-8?B?NVNQbDVNY0Z4YVVubGEvK1NoQ21DNnBUZkgvcFZHZ29tL0pYdVVEWEVVcGlK?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4baf4-667a-43eb-3f73-08da898db4bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 07:11:34.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+3TD3kDuHM3xbWTKV1zAJoF724Qn3P5jDhSWv4AU1v+47+rxqrjaLBvlqNkuEcRqn5I2PgEL32/39hBZIrnCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
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

Hi, your two patches are not in one thread. Don't send it separately, 
Please send it together. Or others can't download your all patches from 
this message-id.

On 8/29/2022 2:38 PM, Song Chen wrote:
> I tried to build tools/test/memblock and got such message:
> 
> /usr/bin/ld: slab.o: in function `kmalloc':
> slab.c:(.text+0x2b): undefined reference to `uatomic_inc'
> /usr/bin/ld: slab.o: in function `kfree':
> slab.c:(.text+0x97): undefined reference to `uatomic_dec'
> collect2: error: ld returned 1 exit status
> 
> I could find any definition or inplememtation of uatomic_inc/uatomic_dec
> in anywhere of the code base. So I use atomic_inc/atomic_dec_and_test
> to replace like other tests underneath tools/test, it works.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>   tools/lib/slab.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/slab.c b/tools/lib/slab.c
> index 959997fb0652..8a5a8d536e35 100644
> --- a/tools/lib/slab.c
> +++ b/tools/lib/slab.c
> @@ -3,7 +3,7 @@
>   #include <stdio.h>
>   #include <string.h>
>   
> -#include <urcu/uatomic.h>
> +#include <linux/atomic.h>
>   #include <linux/slab.h>
>   #include <malloc.h>
>   #include <linux/gfp.h>
> @@ -19,7 +19,7 @@ void *kmalloc(size_t size, gfp_t gfp)
>   		return NULL;
>   
>   	ret = malloc(size);
> -	uatomic_inc(&kmalloc_nr_allocated);
> +	atomic_inc(&kmalloc_nr_allocated);
>   	if (kmalloc_verbose)
>   		printf("Allocating %p from malloc\n", ret);
>   	if (gfp & __GFP_ZERO)
> @@ -31,7 +31,7 @@ void kfree(void *p)
>   {
>   	if (!p)
>   		return;
> -	uatomic_dec(&kmalloc_nr_allocated);
> +	atomic_dec_and_test(&kmalloc_nr_allocated);
>   	if (kmalloc_verbose)
>   		printf("Freeing %p to malloc\n", p);
>   	free(p);
