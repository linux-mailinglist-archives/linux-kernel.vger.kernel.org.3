Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5043E4FC6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbiDKVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiDKVc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:32:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AE2B263
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649712640; x=1681248640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mk4o3IxQwx/KbBI8ULbvb0RU56DkwcAucpFW/AD+c2k=;
  b=Ea5mXQWcy+0lXeJ08J+Ex1JqsPP4JZP80DzsAxGpKislDzYQJaoZhU0k
   3ZB5Y7ArEwGCwi544hhHiqwanGBVST0LIfI2clerEt4oyWHBs4uDOEJnO
   j4dJ9+t4mcoQbe6LNpBOywt6YE3ocrv+PO2Afi0GWcbM7F3x5SnjkRd9r
   n6qmhyogLHChjNROKCbWNSpL8ZQAV6Vcae8rRWasiXFTn9xnDqOFM8yr6
   ehOeMlL2ksOWcP9fyqoyT/WL3WeJt3Io4HTrgliQiIn00q6eZMcf1m3BK
   NbYOb+eKKtD5N429eaaSyPszM/Smk310kb32yw5Ad8yx8COCtNKF9pD+h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287231441"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="287231441"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 14:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526158817"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 14:30:39 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 14:30:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 14:30:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 14:30:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekTm4O4A1eZi7LQPXljHuxMb7ZLqOM/4S2QZPpwizT8CR4hGPUxBdtIcg+Vvh4c7GrnHagiKofkMDhoG1hKI4k/NLt1UoKi9UPVjdp8VfQMus3D41Y2gZztTfZD2IxAaa20jB4vjS7azGHamoNflcGLLmt1U2Yw9G6X307L30csZjXjpbLMy71q4UpFjYuz+73Y/Z0PJfTiCtv2Gl0zaYwEmRcuzhE9X7r2sWbf+m27fe7/+Pg/e8wfqZJWlpD39F7zCA069/5xCpLWss/eMq9xtpYNqlRS6HjL+U3kHEt9PnAkfyNPZ1w3pO34R1whbeoEWO6sP9mxCry5oc2Bo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxCu6eq4SeekvqPGqrmu9+JLO72R0yuWJzDcrbParuc=;
 b=D4u/SDVNRsLGzghPTNMV0SfG9YDnl1G2jAZOqZBIQJOYCoHGCNvm6301ZxgmOY+eGtI4k5Zb+dKsVLDMbZ05vULpCnwkYQ/HFEGhpHhFJdmP1PQIweyEGP3GBWiH0/IX4QUEJh6oOXcmpGeE85BLrGVpT5ljfIa58zP6EM4xgei8eMd1OSgeP0sUqY5mc/yWFsoCnFyUNIgMR6vl4wmjZ25uJVa11REqdvBFTefgSDOZqvZuarSoLcISoWCybfXSSl71Zq8ojR0UGpbDUhqCUYJND6rColujdorAdq1+B/mhSvfspjwl+q/iDLN/Py9l8lKvGI2dU7sSGKhf/J8iVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 BYAPR11MB3445.namprd11.prod.outlook.com (2603:10b6:a03:77::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 21:30:36 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:30:35 +0000
Message-ID: <796c188e-615d-0027-125c-484b11c85e9d@intel.com>
Date:   Mon, 11 Apr 2022 14:30:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH 07/20] drm/i915/gsc: skip irq initialization
 if using polling
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
 <20220407125839.1479249-8-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220407125839.1479249-8-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47816b97-c9ac-41c4-e586-08da1c0283f9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3445:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3445145ED614F27D7DD8589CF4EA9@BYAPR11MB3445.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLQam8t6OKZZkOxU7JYX7WZ2yuWMP8JVgKCLp80YDln1xGZoJuMFyfEpI8lI1z2/UmXpOPR2yxy+O3xkGNUCmXff9anP9fLeaS61NyJlhzvPAOobhnNg9hGBk40cQU0APY+AhdRfPoRr19kTrLzyMIxeLQRG8ux+HrHrcazYsGUalLssBrqvQa/7OotIeAHTQnin0ThZ/x1pFNRr5vPGVnqmfzCs9a08tOM0xNCsDPN0Gb5S+D5qwZgbUNgEQLqBqP+S6Xze3S4qGIbRjr9eQGZ88yZ1uXft0MQP5pAFiJo74991249HJX1eFk6+kSqKX6QKdPuGOu9rWmRxc3LER4qg7ttHa4GXq297yscQuJtGwLP3mFsRo6/gwS6E73Ggk3MAbvj1ASzhGi0szpzYK98C3Gf9362xMU8MQCcyv7Ln40A0xnOn1kgp+UUq17yMM8HqeferaqJdrfcTG3W0DnsZqyTb01lmkJpuRqmuw/CSA8oqWWlEbJy0igfH7FYWdchAiKUcM/M7tssC6f5GuLkhZQTukNotWMEYGc5NgnLcNNxYxfpEMNKHJFM26OuCU7FHixcQmpYVlce4nBIAaW21tDow9pZo4VJxIGw+fnhSZlF5Ki0L3ez9zXnXgzcQa2Nz4KoeWywrCTBxdf8bnTNpZS1vifJNbFWL2HkCYtu3ZnkMxKloKR+DjcRfd7inZDLHI094Fnau1p3p/6o3t/Rsq2G9pJbagp0E0B0Bfei/mna+9xElCqON97LqWNau
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(36756003)(66946007)(66556008)(6486002)(83380400001)(86362001)(31696002)(316002)(82960400001)(4326008)(8676002)(38100700002)(2906002)(508600001)(66476007)(8936002)(5660300002)(186003)(53546011)(26005)(6506007)(6512007)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVLNHVUa0oxNzhnb0F3cnJpVmdlL25EYXUyYlZXT01OWGVQTkhxVjM4cHBm?=
 =?utf-8?B?WVdGVkRYOWhObVltNjhJRFNGdGRVa2dVWWVzZFVHT09waENzSVRxQXZ4L1hk?=
 =?utf-8?B?N0liNndoWGw3VHQ0clk5SjNZRTZUd0ZQZDBNaFgzVkRZWTR4UDRMOHpXWmRO?=
 =?utf-8?B?RE4xTmtxMmEwTnBrZncvMUN1dWdUL3hueW01dllBdHgzUkJtUlpJTWhKZHlT?=
 =?utf-8?B?dkk1bVZvSTV6SXVWUTJ0MEwwMUh5U3dHOEdPLzBhWG05VHNmM3lWNEwzWUZr?=
 =?utf-8?B?NlQ0OS9Ja3hLYXhrZzhZekFpZHZob3ZHbUt6M3VJMWFQQVRKQ3p4T3JOdUJx?=
 =?utf-8?B?MGc4Y2tvbUIrQ3NDTit0bzlmRkwrY2tJYzdxbm1aMDZCQURIeG5DK245N29i?=
 =?utf-8?B?OU9wamx1Z0ZOdGNtQjRCcDhwR1ArWC83eHBiVE8rZmJKYmt2c3RISU9uejZz?=
 =?utf-8?B?OTdGTlovd09NMndocjBsQ1crYURiUW5POVU0RnR5WkhleUJaTXc3R0dqVkl6?=
 =?utf-8?B?N0pSN0EwNHloRHQ3OHJVeUpMczlwbWdja3poTHpLTmYxMStSa1FhR3E0UmFC?=
 =?utf-8?B?K21lMGh6Q25tTUg0bVVwTnJ2aG11R3VvTldxc2RyT3l6cXlicktiekVadWpv?=
 =?utf-8?B?WW9ZNnFkUTZJY21WSVZvMlpycTVRMFFrd3dwdTIzclo3SUdBK3lkWENoTWtZ?=
 =?utf-8?B?cTBIbHRNcHNyWW0yaUJnZ2RrU0FYUDQzenBzYkVkckoxUENScDF4eUhzME1V?=
 =?utf-8?B?Z29PMThjVURaT2Z6UE41cVdSREU2blRONjd5K2o0UHJmb0xTbTYvMFhiSDFT?=
 =?utf-8?B?K0pMSEU2cUhEK0w0cmtjMW90NkhHSk9VcTJYMWE5TUVmVW1ERFNuOE9NYzhu?=
 =?utf-8?B?VmFlUVI5NU1RVU5IazdRTEdKclJQdDU0dUhIVXFXUUZydStScXExUk56d0VW?=
 =?utf-8?B?NCt5RmV2aUlSNVhzdDJTT1BSQ1JPLzJMdnVsdGNDS1ErcFgvcVYvV2E5VitL?=
 =?utf-8?B?eXg1akowZVlqVllXV2xkdHdPZWxZMURSRFBFT2x2TkIvemxVbllYU0ZjYlR4?=
 =?utf-8?B?azlBaFRHSm9jU3ZQMjZhcy96MzZrNUI1OXBLbzkrd0xrZVVadDFUd1oxcTFC?=
 =?utf-8?B?d0VEMDczUVRla2lDSDV3M1lEL3ZuRVhQek0xY0NVREVxNXJoSTVzRDYyZEFL?=
 =?utf-8?B?YzhoT1g3a1ZvY09QNjNUT1FQNDVCNEZpMWxSNjhsSU5NdjJUaWlJUTlKdGEw?=
 =?utf-8?B?bldlUC8yVk9Nc0dXWWlGVzdQUk9TUUNtRld6R3Zqckp3RnI4eVpLN3hFR1Nm?=
 =?utf-8?B?U015TXlTZHV0NGd4M0V6S21mMW11S3cxS3BLNW5HbUNIOVNrcnBjZnZKN3Y2?=
 =?utf-8?B?dTBBQU52VldsdlI3M0hEdGIvRDVpMVRmNC93L0M0ZmxjRVFKMTVZWHkvdUo5?=
 =?utf-8?B?NWpVekcyVzg2cnVCVEowT1BiaTNxeXg3Y3BzSlZqWm9PR2NtY2MyTDFkMm9B?=
 =?utf-8?B?QytsRVEvSGtTeFY4SkRiaG1HZHdmZUJwSE9uMm50VFBGeWJ3L3JtckRjS1hE?=
 =?utf-8?B?d1d4K2JGSFVySUppQ2xrNmN2ZWRkUTQ3cC81TUh6Qyt0aVY0QW9IaUM0cGJZ?=
 =?utf-8?B?MEMrbmVvc09Kc2FvdDBaa0h6N0x0L0h4aTZldVpIcWl3cXd5K1I1VjJZSFNs?=
 =?utf-8?B?SmNpSldXNk1WOFhMLzlmcnBhdDRuTnZJZ2hZaWhxdERHRGxMd2trM3dLU0k0?=
 =?utf-8?B?U0ZRNHNTajJ0dVNSMTlHUDBnL0g3eG91VUNEZDhPMGRqa0tzTkFTaUVJMHVu?=
 =?utf-8?B?TTBlUnc5T05KcHlQeXg4YjFSdGREait1d1JVS2o3N3YzcnVZUy91RnJ5Y0FR?=
 =?utf-8?B?KzRCaHJoMnNocmFMeTNXMURhY3VKanNwaU1IUisza0FWbE1QT3R6amt1ZHZJ?=
 =?utf-8?B?SmQxTEdQWGNDck8zdDhLRU4vQ2tEMXk3K0pZRlRDYXg1cUV3YjhlclgyblVl?=
 =?utf-8?B?cHpNYXFlQjJzUHRSY3ViUzcwUzFJb0JhbnBObmNyQUxMb0hLTGhnQ3N5c2JR?=
 =?utf-8?B?bDY0SXViclVUcTNocEpYUUwrTDl4TXFPY0pnYms0OGF3dzczL0ZVdW12aVBJ?=
 =?utf-8?B?cU03Z0UwNlV2VWE0MkZWTnRMNDF5Q3VVMVpDak1EcTFzWndWY0p0bTBBQ0dX?=
 =?utf-8?B?UnBBTGdFS0hCRW5TOE5VaVZzWlI2Y21SZE9uSHJSYWsvT2tsbUF0N3F1cjNS?=
 =?utf-8?B?U3VJOGpidFh0aWNyVVFLZjZuSGcwVCtHZGVsNzdrbHZRR1JqeXU3L1NRQTFE?=
 =?utf-8?B?KzZOMk1mVGFORHg1RzRLQjNrdG13QXhxVDY5ODdXaGhJSTVpYXlIOTc2U09M?=
 =?utf-8?Q?e0FKw69LSZsHZdSxBVSZD2f9DBNFzhNWASjQh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47816b97-c9ac-41c4-e586-08da1c0283f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 21:30:35.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxx9sn2yzCx8ynoqv+afVVW/2+L2nx0rDK0EDCrg6hYwupQjUQVBNuJ0SCDOgJxoNnbuqD4gL6l0zSwaKthyyRHTA/mje5i8SRUoipI42dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2022 5:58 AM, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> If we use polling instead of interrupts,
> irq initialization should be skipped.

This needs at least a 1 line explanation if why we might need to use 
polling. Something like "some platforms require the host to poll on the 
GSC reply instead of relaying on the interrupts. For those platforms, 
irq initialization should be skipped."

>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/intel_gsc.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index 21e860861f0b..280dba4fd32d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -40,6 +40,7 @@ struct gsc_def {
>   	const char *name;
>   	unsigned long bar;
>   	size_t bar_size;
> +	bool use_polling;
>   };
>   
>   /* gsc resources and definitions (HECI1 and HECI2) */
> @@ -97,6 +98,10 @@ static void gsc_init_one(struct drm_i915_private *i915,
>   		return;
>   	}
>   
> +	/* skip irq initialization */
> +	if (def->use_polling)
> +		goto add_device;

We tend to limit the use of gotos to the error paths, so I'd prefer it 
if this was flipped to avoid it, i.e.:

         if (!def->use_polling) {
                 /* set up irqs */
                 [...]
         }

But not a blocker. With the commit message updated:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> +
>   	intf->irq = irq_alloc_desc(0);
>   	if (intf->irq < 0) {
>   		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
> @@ -109,6 +114,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
>   		goto fail;
>   	}
>   
> +add_device:
>   	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>   	if (!adev)
>   		goto fail;
> @@ -162,10 +168,8 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>   		return;
>   	}
>   
> -	if (gt->gsc.intf[intf_id].irq < 0) {
> -		drm_err_ratelimited(&gt->i915->drm, "GSC irq: irq not set");
> +	if (gt->gsc.intf[intf_id].irq < 0)
>   		return;
> -	}
>   
>   	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
>   	if (ret)

