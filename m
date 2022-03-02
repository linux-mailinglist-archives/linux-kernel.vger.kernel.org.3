Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C544C9F48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiCBId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiCBIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:33:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F593BA7C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646209991; x=1677745991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oui4n8lGmF/MoFM+iiGkoNYH16T5RdswDifc7f47oJs=;
  b=X9YB4+BukPRzToTl6/PalX9YkXjK06HfV0z0qhx/GMSePZ6mwfAlGEDc
   niyp6/+gpuQEBQwNoeoPEubjgW73CQ8d+noql3ufGvCUlP5NvelUeJmKX
   K9UCZdvEBKmLojXurXzYdpZn7ohTCwZz2Xal81L+h9OkCOmzMri6Y1XlV
   fbYLNixM1Yw+6wF3upNSsxgnXxER+K+Tp24WbW6BpZPXEtAlOPw6LaTC5
   sj0oDsbxIG7ZhKMJZZPzq4+hYBB8gzfE/Na8qc5VQWph6WfEantDoQ0ek
   yrYqGczs3tgbh8FzQT5E2atQl4ZEYR1cXql1wytzfXRdLfW73Y3svh18e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233960523"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="233960523"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="686062520"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2022 00:33:10 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 00:33:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 00:33:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 00:33:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM8inHXPg+p1zxho8l03OCGXQTF4Kc99xqbDNxMa4kCL53BcfbQRW9BEvx3uGCOjxZ+0xRMzQdKVtWnXJ6PUtg0ByTxAut1ajKqtq/YocpALbJzcFoQBmLdGPUzs7SLHXpyyL4xOzlAmUYa1XZPiYPri9FhehzDbQqCIIBpp7jsXwEofkivzV2dmcgeXYOZlYDDfxRkFKoDm/fDwI9Ll3FZXXzdZSH13frmNdTMYpK5K7u9yDVbKehs03SirQXMPAUMBPD/0ycrd5FZQTaiK/vqsskPbQ8CY4ahmDMyl4LNLYP0jFycpTmIdjycGI8kpwYnvFSPLruOlfxRKfyiJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGaGf+ddceTyzuH0gw8DMRIriamnw07d5YQp9Bwqe0g=;
 b=YgMZNcLNJGwAt6G5enhD1MsW6b1i8Gy2fAAd++Wi5wOumrtQftd3P3lmn6+GPb2IfrU2XU24NRjc9EMuYOSOVnR8b/d9ppskvsHBiLl2TSlYzMZdg8JpZ5yOZ6c902faLZ8N7n49MN9hjJqnx8GlSy65RZSe5yc6XrY6EcA5PzoT+znuluvx97EsjVGKHN+MpYJDw0rP/elLLrL9cwmj8O3dDZyhm+kTUyDCX9onK4oghXJzlVhrYPpNvDyBHIx9x4k7koKS+oZ5tEGySjpnQb/ozg+xipWRAGfeBpSht1RMcRVNhVgZpH1iuIqnlMsy0bS34ey+6xDtZeg8uVCHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM6PR11MB4444.namprd11.prod.outlook.com (2603:10b6:5:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 08:32:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8%2]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 08:32:58 +0000
Message-ID: <191b6d46-cb8d-4e5d-8c4c-9dae91e32a45@intel.com>
Date:   Wed, 2 Mar 2022 16:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [xfs] 6191cf3ad5: stress-ng.rename.ops_per_sec -73.5% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Brian Foster <bfoster@redhat.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>
References: <20220131154927.GF16385@xsang-OptiPlex-9020>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20220131154927.GF16385@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d215d4c-1c29-4442-d9e5-08d9fc274187
X-MS-TrafficTypeDiagnostic: DM6PR11MB4444:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4444ACD01B26928D105435C9EE039@DM6PR11MB4444.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Rnplk8OLiDjis9pD5j7H/G08xR8VYL2yg1imdKlHf3A81dohszulRuNwva30tGo45hX8BQ/BUsT3vaVj2rYJSoR9zmZnC/0duj+81pIhqP13Yelqu7hALn9ZqKOYbJnAQwxX3vMZn/4fd7u9w2PRdyh63qzFnJU/bLff057MX95zA1HUIDpgxwE//fcDzpiZ/yOAcOnBvQ7wiXUdKPUA03HcBbplUBa/E+GP88ElL/ZD4R8r9BexDOnqtKU/X61Gl+9yLLmrrtPEYYXiiFgsK605MZkuM2qLTzpg/d+Glc1vccjw5qrptIsif1r5Xu0cn1zx8A4mZViOvp+O5UR3Kg5xcaJZ2Tzgei6MjBCHaUvUr455PgmuSMGiEJ0M24nAVJle9QIMZbA7BDqzuAZSN0zhKGH+0ysy8A63DROA+hanavn+W2mNNOPubPCXIMDiK+vB7BwV4jHf48ylGnh4al47oHcBB4wlZi7fg13TDKX4dJ83CX8/anqKyk/xyQQutt7f2+geHSy6zdSF2+Zfv5/cItmS/AL11ZdgdGBWTHv7HFgAjtElRXM3L00dGXvUMKCpwW+jCA6p5JmtZsRuf2aaShmLzhso2NLrC1x0ZWy8aRE4UdtoSJQgnlcZrHnEU+l3OI9TKofIgO9JAYoEhJOfKXfAF1vFelR3CCbhfRFUa9fNQDO9bnCVKJj0n/41frC8lSTTCNJpQMdqOBuN9i62ibKyjTOEgXCEFb2Q5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6486002)(6506007)(6666004)(508600001)(2616005)(53546011)(110136005)(2906002)(86362001)(66946007)(66556008)(66476007)(4326008)(186003)(8936002)(8676002)(4744005)(5660300002)(26005)(83380400001)(82960400001)(316002)(38100700002)(31686004)(36756003)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1AxaE9PQ0gwMkNiYUU1S2NSaEgyYXh2dTRTTW9EU1lOM1ZQZHIvRjBLVmZU?=
 =?utf-8?B?NDdpMWx6SThCamxGVGdSYTdLK1FiblVJMFhHcUd2aWlHeitkRk1IMzVQOHh2?=
 =?utf-8?B?T3J0Sm9PSVg2OGVYTTljRkh5NEtadnFRSFdZY21UVFZQaUY0aFJ2bldCcDh0?=
 =?utf-8?B?WW9lV2I1ZXNQVjJHM293YVVoRDVrYVRsbnJxRzhlSjdmdWZyY0tmbUFBdXA0?=
 =?utf-8?B?dzlZS1FGRVN3TXNPWFEzbmE4U2QwUDZqVTkvTlFGTEJKV0FqVmR5N2NUZVNF?=
 =?utf-8?B?OGdKL211dDdaK2xLMTJrbVlkaWpIY0RjbFA5MkxPTTRZdEVxaXYvTEhBWFk2?=
 =?utf-8?B?amx5MTZyTFRTTjZoTnJGUGt1Tkk2QVFCckt0ZVVYQkVnUitsVnBjb2ZiL2ZM?=
 =?utf-8?B?a0VwczdhWWs4eHVoWnlyZ0grb2pvR0V3RFU1SjBxNUdyN1RmaHhNb0pNMlNi?=
 =?utf-8?B?L0lJYzNoSHlPRlRpRk90eVErT1loTml1c2p3RUZTZFlYc1dyRHdydmZENThi?=
 =?utf-8?B?Z1EzbENHL01KeXBLcFJPZk50bVluWEZFWmlkam9wUm12VHdCTFZ3Q00yMW9v?=
 =?utf-8?B?WkRaK2xpeG1mQ0czVHJwbmZ1WVROSVVmUytZVzl3YnBiK2RzbzN2NHVxSWFu?=
 =?utf-8?B?SVpOYUMwMnZiSTZvVHd3NDNZWjlSREN5aTdML0dwbUhrVFZmY05CS0Z2ai9p?=
 =?utf-8?B?THFTUGRQVFVxQ1R4Vmd4aGgveHhSQStBcEJGdWF5SndYWGZmb001dVljbTg3?=
 =?utf-8?B?REhjeVJIUmpUNGVGb0RNYlNLeVYvb3loNGJoVEJLcm56bkJXUzRPZUxjWktI?=
 =?utf-8?B?bkc4SmRGeVJ2K1VselNmMWpmZVA0SnhmTzkwY1hUYkVWVk5RT240dEJFZkJ2?=
 =?utf-8?B?cGpHWThzL01aR0lvYUhGb0lYK0V4cG5sUi9vTFBFdysvS1hrc1kwQXpSdlFU?=
 =?utf-8?B?dS90dHpETGpMVU9LMlRZcWNuejFLYkpLNWZSMDJ6dWZMRk9SY2NQUlBCMith?=
 =?utf-8?B?OGZmRCs5MEg3bUUwdWlyNnU5Z3ZwWXJiMXM1dStGQVk2enlsU3lZNHJTVmdH?=
 =?utf-8?B?T21JK3d6R0NXVUlrYzZia05pNElxNWROcUdNeW4vTkl1bEdHdWJ5cjZodGw0?=
 =?utf-8?B?cmRGa2w5YnN5WWJkVUdIZmhOOEdpV2pFZm5jbmd2dnJjSFI1UzhMU0JBWFh3?=
 =?utf-8?B?UmhYNmgzelIvRldzMlZFdnorQUQ4MGU5dDFTTHoraTZRRHFSTjVsT0Q4T2pS?=
 =?utf-8?B?Q25NbFFLeXhaWDZ6UmV6Tnl3endPVFVWUHhUandKKzhwMG91aWFUdW9VU1dI?=
 =?utf-8?B?ckRtQ25UWEpsN2dmK0lEanBweHdCRWVKVnJnRyt0TTdxRG92ZjhGL2Fta1JJ?=
 =?utf-8?B?ZTJKcTNLWm1KSU1FSTBndFVyNitvOENxWWFyYjlMdFFjNEF2ZVczc0JsUC92?=
 =?utf-8?B?bDFsUXBWWU5hUFRxQU5Qak9aMGJCZmlsK3ZjT1gzc0JDMktqVzhWUWkyZmF2?=
 =?utf-8?B?N3VLZXdYekN0aFNIbGlGWGNWaHlmazZXTFg4K2Q1NytOU0x0S2ZWVlFjS2o0?=
 =?utf-8?B?SUQxOVdpcE54eXRtNVF4WXdhb0p3T2xCc1hsSEozT2lXbGV2T3UyeGM0dFlP?=
 =?utf-8?B?d0ttcThkWkFWTGpTQ3laZ01tRnN1L3Ftd085MnFsRDlteGRwbnN4OHZGcWlB?=
 =?utf-8?B?WWtJbGJJNThWbnRndEFjQUVoVU8yT1dZTCt5RllMM2hsMUdyV2g1UG81RlE3?=
 =?utf-8?B?cUIybm14U2VFUU4raHBpSUFGMDM4SnJ5bUJSNGJvaTBTNDB5T3hLcGlnVFVI?=
 =?utf-8?B?SlRLR2VjYVdaRzIrMWVxN09HUFVSUVRBTnZPVjlWNWs0K1I2c3BERnBhL3hn?=
 =?utf-8?B?bmJIV0RoVjIzNzFhTXJFTHllZzhLMXgrV3IrbW85b2c5cVhwYVNqYldFYkho?=
 =?utf-8?B?R3ArWnZzV3JDOXJtT1VUVkVXWm9tSC9BNXR0eFJ2VjJ3V210ajZUdW4yMmE4?=
 =?utf-8?B?WDVRUTlQWWpsVEVOVFl3QXNpcDBrbUl0cWZSYytMVEdRaldsaG5ZWTEwNEhh?=
 =?utf-8?B?WXF5cllwempTT0wwM2t2TmRKck1wQVd3bTVlbUhiTnNxcGZwSTNsM292L1cz?=
 =?utf-8?B?WHhRY0tZTzFSbUZ2OXhGeHV1ZElGNldKbHQ5MWF1R1RIVkNzOC9PZDNGWFN4?=
 =?utf-8?Q?V8sUyl1ctJWOTr8fIH4nSNg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d215d4c-1c29-4442-d9e5-08d9fc274187
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:32:58.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtTQX0KHIAmjVxCFRx3p2A/r38xaoTe80PGz9bg0aSMQ1z5HF7UnoSDvOLKoUxe1JsAQsr0140ofq5BIuxYoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/1/31 23:49, kernel test robot wrote:
>        0.00           +59.8       59.78        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.flush_workqueue.xfs_fs_statfs.statfs_by_dentry
>       23.44 ±  2%     +61.0       84.49        perf-profile.calltrace.cycles-pp.vfs_statfs.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       23.40 ±  2%     +61.1       84.47        perf-profile.calltrace.cycles-pp.statfs_by_dentry.vfs_statfs.user_statfs.__do_sys_statfs.do_syscall_64

We did further check of the perf data. From above three lines,
the patch brought higher lock content (+59.8) in this extreme cases.

Regarding the patch could fix race issue, we will not tracking this
report. Let us know if you have any comments. Thanks.


Regards
Yin, Fengwei

