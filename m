Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995D94DBC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354876AbiCQBN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbiCQBNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:13:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A51D314
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647479559; x=1679015559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vFLXrT1Qh09HcCVDgaATLYKdPqRdy8c/h1Y4dJI6Imw=;
  b=fgZ6hIjunO+ewh3Qyv63eypfdHXCx+Dk6ILhL8LRhDzclkm1XqJWZInN
   m2zNyZ2vzXp9e1O1NxttG4Dn4jX5uawLwe8l6xWuzCSY2BS3RPnce5F58
   2mDOdmfoYWP46a0EE8MyNLJMW4PavC+pI0/QcJVKJIoofu/AP2HULSnbj
   +zLFgaitGIGFuJsChGXOIJI+31eMkubknXRy2qNTxwn6EOUrgUE08Z6Dg
   0OrOfC/2M4Y1hV2BSndk+Bf+p6uGw2PFC/HxLXKvLqtHMZoda0+ctwVVA
   5nyQdbn1YoXQ3EdB6VDYy4xxGKclVdtgCCWJvykHJecAtoMFjG/dzRA2p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238916655"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="238916655"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="821087209"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2022 18:12:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 18:12:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 18:12:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 18:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3YctdogQTzN/PWZ0TpcifYF5yIHoml+GAK3DnQckBmELm4fM7MLgIp7DOpLGQhPTZDj+/ZaDZolg8rohxOmTS9si+V3IzkYaoyfbGZZAvaf3KmGM/2aup6TsnCsJu/7M3gUAko+n8B6KIjFnyXPw6Eg8FYMt6jknN51/XrSMKtfP4VjVVqysqaseEslQAFxJtV1AHQQKvkJcbkgn9hrxmpfZQauglykvmqSu0gJKMNlhRPdB7EDgu66zhuP8OhNUdW09p8HznhUbbPdFdqvEyxN9+hI2UvZ8LZmJG6jqj4iuHSa8XTFoqk0dr6fmEHy/LNXFF5A4H0iXFDHhGxwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3GbS/5IMeaBH1Gb3OPUEqFiOtLMRmnfP0xqeR5jF+o=;
 b=QaZR0XU1/zpkTqqdLo6h4WOMC9l/6aOCOisHJ3kNVm/WfZNenerqNYiWUZtcyrEJbnO+8yWe1Iu0NHnaOJdVWZeyeFe2FjV2djC3w+aNuR1EChHX8bQYvDJHq9sslJbEb3AyJh4ChEhLv0SDt8VB3DRNs4Oo8z1cyyMC9owf4VuMoe5OXMDTXzO6LPXN8fcVUScc3l35e0QLKhY+O6p2lsN3xWLY930EJ05X2XwjwnwymLPUaogE6sWBMTGuUP3mA0c3r2VW1IaemOvMgAFCHYA3DAMoYT0rBkkqfbvZ9bCovAXZKrbjnePZjLQi7Xw8ovq2Tq3hyTdQ/pEOnfZChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 MWHPR11MB1629.namprd11.prod.outlook.com (2603:10b6:301:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 01:11:56 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%4]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 01:11:56 +0000
Message-ID: <34a38062-cf2f-f76a-cf49-1e59f8a81e2c@intel.com>
Date:   Wed, 16 Mar 2022 18:11:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH v11 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
 <20220315131157.3972238-2-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220315131157.3972238-2-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4149baf-1483-4d70-167b-08da07b3211b
X-MS-TrafficTypeDiagnostic: MWHPR11MB1629:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1629AA552924B0BC1CB99FF1F4129@MWHPR11MB1629.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYDev+cocm6sy2tdiqi+EBbgbBVWI/41x+beXSLeS6swnTIvPfS79H+46vZWtRlxulQUazvDbGs5xJ4HGw0Pt2y7P44DHTdqcHo6RSLeHuR6P+3feKkIDtWszHoo6DmBCzFIdV+UYQlsm9swlq0MCNEVKzkmz+rL+iybjT60BCy7Ccip5HCwB8YNJP1hYWGMxUQHN00/BZ2Oy+U/OTN7GHfl881+vv5giDFMtOnA7wvJkI0HFe8hSQb6eJgmL5hAI4Ba1fRsWnNZ0TO7WFbjl9gpSwSaHQpKxJkBlOBJ7Tl36227Huqay0omaQdpOwFuoYBwSW/cywFYs6kio5Ta/NJMK9uC4DDZjKBVQHOTnzqpq+sDyWcysYe5uDj0WUhKSAreyLMxVMC8etJz8Dd8+riqjKJz3uS0dIh8krcghrIviP4GQ15ll/EBpJXQ7JYDTmFXayDmQNukBbsufzjES1hCfjJj6QaRUOibJ8owPf4ZjQxZGbYTh06FJI1Tqbrymqo7X6NNOFHQmi/9MO2PhRotcpKhTpPJj2Fmx1tZCAyTXn0oStAgtSvqLyvzBJRs3K+8PzwSHWvpNA9DqdMFB6g9pUE5I4tVl/x1zfBX7ywfTgTr6K3A/6QmeUeNlFqK+qsw30OJEVjL9CSq7WAiChILFl14PwsiRPd7rpQOya/8NIk3CndbnOxRgiUC65mcsqEoICsf3koLtMqUPzlXNFCAkD9RKpbcqGXLSwczThw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2616005)(31696002)(26005)(186003)(6512007)(2906002)(8936002)(38100700002)(6486002)(36756003)(82960400001)(508600001)(5660300002)(54906003)(6666004)(83380400001)(110136005)(316002)(31686004)(66476007)(4326008)(66556008)(8676002)(66946007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTY4NEs4WkNQamZOa1gzcE9IQkRPTFlaYkRWeERzYjFHakprVFg4RlFyZVNw?=
 =?utf-8?B?aXlWb3N1a0ZrTkR1Z0JFZmw0Q1ZKdXNqVHhVM25HczRVeEJuY2FSZXpOdzRm?=
 =?utf-8?B?czdyUHpRMitRL0o3N0xRV3FSdFB3RGNiM3Bia1o4eG0rbEprWU1SMFlaQ2pG?=
 =?utf-8?B?Y3FTNnFMb1IzM1YzVmt4V09DRkZzYXQwYjV3MEtNVlRkL1ppZ0w2QlVKTTVC?=
 =?utf-8?B?L09BTWJYNndRVDIxVVoyeFhncVo2Z05LOWdFYnRsVjlWM1Q5ZnVJQ2VDbCtP?=
 =?utf-8?B?dDZkRGZtc1BJZ0NucUh3T2FoR1d5SXJuamZHaStyNGVZc3VxQTh4am43SUFm?=
 =?utf-8?B?eFBRWTFPYk5nTjBleWlkaW9yY01SMTMwSVFFTFBwQ1ZOOVQvRDJ6WExEMmpJ?=
 =?utf-8?B?OEovRk1GaUdHYk5KZUI5S0hvZlcxcDBKWlZpbFpBbmpTSlplMm83SjZMd3E0?=
 =?utf-8?B?aGdxUEsvTTM4Y08rSDdkRXd2QnRTQlErUWkycjUraFg3Qm1FNzhhYlk0U2x1?=
 =?utf-8?B?WE5LYkJDQUNZbW42MkVLNXZkdzZlMC9GbXlyZW5rSFBHenpYaFB2QjUveElp?=
 =?utf-8?B?MnF1Vld0aHZSLzkzUmZaVkQxSysxVkpWekRuclBOQVROYTJoemRLWG1QT1BP?=
 =?utf-8?B?M013bzhsZUdZRm04cU1FTC9DdXVGSDBLVVBOQ2o5WVJkUkVNazJETURtNjhZ?=
 =?utf-8?B?MGo2c0JRTjFFWjgxaVBHNldiMHM0dG5MUXZQRUhLVlp5RlhtdzdTM0FMcE9J?=
 =?utf-8?B?QnBOdUc0RUluejFUMmZPL2VRNTM4NllmcGRabGJaN09IeVM0TCtHcEdlNC8v?=
 =?utf-8?B?M3phSjlyTmlmaUEzM2MrcG5aak9ibURVcmVaa3pZN0Q4bFUyT29HeDU5VUhx?=
 =?utf-8?B?L0xkVUs4d1JZZXF3WFVIeDJzLzMyMmM3ZmNZZ3hzUVRIM1p2TmVBOGNpdHNQ?=
 =?utf-8?B?UkgrbGlGZ0crY1B0YjZJN3hweEdGYTJlTG8zanYzZ2pvaVVickZHRnpXSE9P?=
 =?utf-8?B?UDdyOGwveExLTEhFS2IzNHhwZjdRQzVwM05aUitOd3MwK2laTGxSUHd3aVQz?=
 =?utf-8?B?VjFCOHc3VUNObG94c3VLR3dQZVNCQUU0WkxGSVFwZExRUFJMRlJtSEM0K0l5?=
 =?utf-8?B?cGN3QmpKYkgzSnNrTmJ2N09McUkveGg5YW5qd0JTOEFqM1l3NTVNMnNCbTRo?=
 =?utf-8?B?STBhNGg0TnIvTHZoVDgvZkRUbUlnNG00a3ZVMk9CUXY3c1Z5Kzdqb00zWUZR?=
 =?utf-8?B?ZGJHNktUNWhsQm9WMHhZa29XeVl6L2VJOXUwTWJqQis1QWFnSGhZb01TMU9P?=
 =?utf-8?B?MXlSVFgxZXVyZ0VmaWJBNUJ2U0lXZTdkbCtXbjUrU2tmM3FEWXRPd0hLdzFU?=
 =?utf-8?B?ZHdFcjFra0Z5SEJ0eU1YcThIRDR6WXJ5OHg1UUs4OWJtSS9oS2xybGNod3ZG?=
 =?utf-8?B?VEZNa0RlQXpkV3Z2ZEpueUdVUG9ibmlIT2F4UnJ6aFZLSDZRZitVRXgzeERw?=
 =?utf-8?B?NzI1dDFwSEZFZ1orSE1GWTRjRjBUV0pEeDd0eWp3b1BPSTdIN2Q5UUJMY2tI?=
 =?utf-8?B?bEhwY1hhdlZQVWVRL1I3dmdIQW9aZFZLOUN5ZisvQURXTGlrWmswSHlXY3F0?=
 =?utf-8?B?Z1VMbWVZQm5XdEZSYzVocGdTVkorc2gzcWxhc1JHSy9DdFFhcTNlMFpQTUhG?=
 =?utf-8?B?U0FXMFFNMTZoL3lSamRBd1hGMW1aVnNReG1uK0ZPc2QwbXgzSzZTc1VhRGZo?=
 =?utf-8?B?ZGVNUWtvZEFqaHBYRUtHcHFwWlZYQ285Q2VGMGZ2V1dVcElSUVhIbDRnQzhs?=
 =?utf-8?B?WExpR08wOWhLbjBoQWEzc0JsSVlwOTIzRE0vVTZBd1VncjVKRTQ2NHpxTm4z?=
 =?utf-8?B?Z0Nqait3WmdUZ1B3WFByVnVpTm5rc1prbmsvS2tnQTAwNjJoYWxjb2xIZEtP?=
 =?utf-8?B?YytIK1hndWdEV1JsVW9vdlhvdmFSWTIxeis1b3NZV291VTIxVFlxZXFBQ3Fj?=
 =?utf-8?Q?sZJNTERXJh4WqQXOehCjUnYhEHuYIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4149baf-1483-4d70-167b-08da07b3211b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:11:56.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8riAQFTSsCt9mDzdO/WkSVvcrjgXBK+6BOxYnwDA8smpouxknAAgaYG3Ekh1ktshneiP9IGFwkWJu5I2t5a5Z2CPaqWJMg1ESr1DoL3KtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index ddbc7a685a50..63c56d668963 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -976,6 +976,8 @@
>   #define GEN12_COMPUTE2_RING_BASE	0x1e000
>   #define GEN12_COMPUTE3_RING_BASE	0x26000
>   #define BLT_RING_BASE		0x22000
> +#define DG1_GSC_HECI1_BASE	0x00258000
> +#define DG1_GSC_HECI2_BASE	0x00259000

You ended up keeping the HECI1 define. Not a blocker, so:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

>   
>   
>   
> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
> index f9b955810593..576d15a04c9e 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.h
> +++ b/drivers/gpu/drm/i915/intel_device_info.h
> @@ -141,6 +141,8 @@ enum intel_ppgtt_type {
>   	func(has_flat_ccs); \
>   	func(has_global_mocs); \
>   	func(has_gt_uc); \
> +	func(has_heci_pxp); \
> +	func(has_heci_gscfi); \
>   	func(has_guc_deprivilege); \
>   	func(has_l3_dpf); \
>   	func(has_llc); \
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> new file mode 100644
> index 000000000000..587f25128848
> --- /dev/null
> +++ b/include/linux/mei_aux.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, Intel Corporation. All rights reserved.
> + */
> +#ifndef _LINUX_MEI_AUX_H
> +#define _LINUX_MEI_AUX_H
> +
> +#include <linux/auxiliary_bus.h>
> +
> +struct mei_aux_device {
> +	struct auxiliary_device aux_dev;
> +	int irq;
> +	struct resource bar;
> +};
> +
> +#define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
> +	container_of(auxiliary_dev, struct mei_aux_device, aux_dev)
> +
> +#endif /* _LINUX_MEI_AUX_H */

