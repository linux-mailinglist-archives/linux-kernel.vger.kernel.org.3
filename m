Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F5561F37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiF3P1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiF3P1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:27:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97E3D4B4;
        Thu, 30 Jun 2022 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656602820; x=1688138820;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GENfcM2oa8BUQu8vWbSCuMozYUdbkWIY7Pm0Ye91X7M=;
  b=YF023ThI6xxuI3J5HUZBpYInQ1sug/u2KaKjOUZsCorsigNBo/N8jIKS
   DPeSH3twTxkxdDx4+IstbiwdoDHjvL8puFgJyKofNP3Enn1nTrZLXLtAw
   jJgGqeAgmFjgtVwDhOZHbtQne+8e/WbStyCuQoLEP3+BAoyu6sgywH1LZ
   dWlaLK0xRD8Kn6Lh2g2SeAuZDIE5AHu+6OgrDDafIIw17C7on2Wupy8k6
   4UccoOu0Iu9pMXM8JbaypLLrr6UFoYYeapdx5+1/JuHxutp0RoTWZtMe5
   gHsloYdm5BvR8bIytGhcDrHDShkCTK+Jn7sMYRrwGWXxq2pPEsEAVwD1Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279924489"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="279924489"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="588796615"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 08:26:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:26:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:26:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiATHERvUg36n5UUGw06EFXgpFDPmM/LVsZMffaFeoa9WTHPFVwZ4U+awH3fE0SwerfrCU8eUVED/6xSiqA0UvxyycZPAH2dPO8BKx9mzP/XY4OMXJr3Qbyn4Ft7OWg0clIbTt7cZI+4bixW15+jlaq93TDvlUfM1+Pb002o/vLWObi1cj+KV+Jd3gaDKGO5v5AQMvV2kZ/bN8z3cK6LsZ5m0HqzNbBrWyt3YLGuf8dzSq1uZPqV/J6Y6H+omBQsvCZKL+qs8dK4P3wBwBAEvrG8RIBt8ntg+V3yyaDwea1p5NJItVJJPJdpViylGSfjg6Sm9Y0FOXmRSkhLtNdoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVJ3ISfVcDMgDm8/rH51WoZ5HjaVLjCe2keEUiPQw4o=;
 b=EYj0EBT8/X8FGnnpoBd39MIgpIpf3VrA9VqmN+oVeILCBWS6hDuxwWoUjr+PKXp9kaE1aIN8cH7KmKRWAp8Psksb8500gUleEHv5HFPtRWHDvzp/B7E3VknC9sdwh/R1x9c36q4UtE0n37raclejpBWMAKvTRvNUAVK5f79tU5VIT49xTsXA+gFOJ98z/TKS8tcwrZZZskrOD6vtUzXIQc7Ew7IND5QBdH3Yg0puj2K7hYMiAGrCVt6MWC7R+GjXQ37iMMEprh6ZgVFmWQK/z2YOnAjIqRLj2/QYN1EZ0Idj7JAmZZtqVixXzqsE56aesKi9axQA+Fr47PldJn/cOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM5PR11MB1402.namprd11.prod.outlook.com (2603:10b6:3:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 15:26:57 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 15:26:56 +0000
Message-ID: <5c67d453-a162-b61d-4a27-c854f1ef3587@intel.com>
Date:   Thu, 30 Jun 2022 08:26:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
 <f01bb09a504240059a79a94c24ba4eba@intel.com>
Content-Language: en-CA
In-Reply-To: <f01bb09a504240059a79a94c24ba4eba@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79395295-582a-4366-7e8f-08da5aacf7e0
X-MS-TrafficTypeDiagnostic: DM5PR11MB1402:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7EZ8DlfILjZ/iBU7W2bIHg0lLmzl6m7gZgF5T0BDCBAHKb69pBZq4gKrlNQroK0/7iriOwr/464bWeVpfbnc3WTFaVgNNAaFeD6yNAzOG+q63TDEnLhDtl+b5yt1qaKJO+onS6GNIVviHH8W1wMRITPYynpQqQ4dNkEmMW9oCK/3AwIrKG0AG0IScZ5EbVqCGUICq/OiFcG2DfktrbeHL2KFyO9tKCFkGvW6wnwinDpDCMzTs37xR47LlgZG/nlHbOLz1Vb0FuYxqyFHo6gCznIJDO5s3M4uOsFOyKZgFYOg++49yUrZN95FOE1nLZa8wX71K9nYieJWFMn42xoW71i0HdZ74TQ61+tp34djOn1WE3D+Y1t5spdB0GQ9FTjw4Uq/mAeE7CzrycIOWHu+l8CesP5R9bydr4NCP1ewI6V9QBgVqn766MAkuhCOjgQhh1MFasarKt2rcUXGBlrZOmEd9/j8QCF82tf/GmFDbhlho17PUgzlUTbWV+u5w90ClEKTG6KLKfMJTmc0ZG1U4lQRVWQtP8TSAO/DsQh4UhCAGOUfje4q8ZTOz5hweR80QNyC7hBKqqtJTEmgo6/qzScCBnft+AwgH9593q5SMJNNIllnZYdVZvquZrQ7ErqlATkDev/oBcoFKeLCJ85cktgmqWO3jvo7wN+1hli1DEMcMoX8H7YKoFdpnLZEbBDJ3wXQPFagkLEINO3CULJOPc3spqJuQJa3z37ZeowUzGqu8d6pU8ZW9o7U35Oug9HXzQzLj5n495apj+1ryvPjb4u0a6q5eIv1jZTYxAVCQez5aGXwHhHewbq5fkMNzsZ7pMF/5C3edCVwE5Y/dOnOyMMBBlrkufd77j2al2RM24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(31686004)(316002)(26005)(6636002)(6512007)(36756003)(38100700002)(54906003)(83380400001)(31696002)(110136005)(478600001)(5660300002)(6506007)(86362001)(4326008)(186003)(66556008)(8676002)(66946007)(2906002)(2616005)(921005)(41300700001)(66476007)(82960400001)(6486002)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRxZE5rL0VQamJQUGJRdDRBWDNVTS9KaHk5OU1Pb2xkbElxQmREU3pWMXNx?=
 =?utf-8?B?ZUtiSmxwQWhMYzN3ZVZwS0tDajY1ZEhqVEVoYkxQYVl5S2VJYllaaGk3MXJ5?=
 =?utf-8?B?NHIxNnRmZmdaTlJVUlFxMmF6OXpCVzVqT3Bud3IwdjR6bkg0R3VQenRxNWlJ?=
 =?utf-8?B?UTJRUDQyRTFNTGwwL1lrYzg4QzNSWXZ1NC9mRWVDM3BBYXdmNzJlOUlJQWln?=
 =?utf-8?B?SnFZRnMvK1hPZ2dGcW9kcDlvMzNsdDVFVGxrcmNOL3oxZ0lxdjd5eDhGaUg2?=
 =?utf-8?B?QkxhOWdMQ2ZEbmQwMStoSElKSUlmMGdyWjV3dWhydWlzbFJ2U3dFSkRtK29W?=
 =?utf-8?B?bjZmdVgycDhZdnZpL3V2UVE0UDlQZHA4R1BuQk5UNHBaVStUM2psVXBiL0RH?=
 =?utf-8?B?RW5pVkYxZ3JvcjRaYlIxWmtkSmI1RDFpcG43MWI0YWNPMWdSbUJyeENvVFdu?=
 =?utf-8?B?d1c1Z1RaV2lsNDQzWHBDQWpCN2Q1YjJlUjNqMnJVamNQc0ozK3Q0ZGRBNmdr?=
 =?utf-8?B?d1FaL3VienhBV2MwOFRsd0JEeHB0ckxCNzR1a1dxaW1BTmxYdzFWajBGOXJJ?=
 =?utf-8?B?S3RsNWlhSWJXc0FoeHpLM3hWRlV1Y3JTTU40YWkxRjkyMm9BUGFVOW1HTkRs?=
 =?utf-8?B?QUpRRnc4MmRDNVFLalBFeC8zYzc5OUNZclBOMmRKWk1IZWVWZk9mRW80V0gr?=
 =?utf-8?B?aXNPM2hmUHBtZXRlNzdRalNPL2FWenRBbVR6VGdOdEt4UUFIbFNpRjZldzZJ?=
 =?utf-8?B?a3VUejBIQWI4S29wdmdoQzE4TGIwc01XTUtKZkdrNktCWDl3elZtdlVJZ2M0?=
 =?utf-8?B?U042RE1LbkRiSW1YWjFxSGNFbTl2K2hQLzgvcGR1RGJtbWZDRmNLSWpXdm9y?=
 =?utf-8?B?QVpSRTNEUDhIOFAvQnhsSDY5M1NUckVOUkM4VlhoNjVQMGRlMk1RL1I5RmtY?=
 =?utf-8?B?bTd1ZEJQME8zYUNmTTU5b3hPQUliSXQvY3YrZjFlNmRZZng4bEFvWkJwZEF6?=
 =?utf-8?B?QURaamM1a0Frdm81enF1S2xORkFZR1dIYXZJcG1aWlNOekhIVGVzSXAyc3Ro?=
 =?utf-8?B?bk5WOGdsemJmSFlpa3ZJYTBUUFlqUTVWNHNaTzJ4a3dNYWVnOURFKzJ0Vlov?=
 =?utf-8?B?WGhnSmVjenpLYkhmMkk1TDhQWXZUaTIvU3M1VjBJRlJqQzVMYXIxaXdWVUFO?=
 =?utf-8?B?RUcrNzJSREZ4RC8vT0NvZnpQVndJaEkzci9jMlFWM0dXRkRPMWl4L1dWTER5?=
 =?utf-8?B?K25pZzBUK1pOMUVNNjMwOXUzSDJ2Nm5xeHFWbTFvSnFkcThQS3VpQ1NhMEU0?=
 =?utf-8?B?cUZHMDBvMk0yRVpUUWtaTFI5WDh1aWRxNkJpWkMrMVA5N3hKUEZJWnFKNHZm?=
 =?utf-8?B?SDB2K0k1R3lZWXI4MEh6S1crZ3pxanhsdU9TWG44Q290VEUvOUozSEZXa3pj?=
 =?utf-8?B?dkxSeVBWWU5Pci9CbjV1bW8xd2V3ODlQa3RTU1BoWHhIVCt3d2wzbGVXS0t1?=
 =?utf-8?B?cU5JMm9UVVowdG5rRVBjQS82NlF4RjZObmdSRG5QQWJSb0ZHWlBxL0VrSGZ2?=
 =?utf-8?B?YThiTlE4dFZWeTZnMEh0Z3pEMVY1NzRUK2dTbDR5ZmFOWFJGckUyL0hmdDRW?=
 =?utf-8?B?VW5ydlMyRWRXUUlYUVcrK2VMS1UrM1lDSmtZODRjNzNuRUY5OG1Tc3JBMnVR?=
 =?utf-8?B?ZTZsMGJUVE1kSWxRa0lzUWQrTWxUcUZCbmZHZ3AzQkhXZEZOcjhhK1YwRlRF?=
 =?utf-8?B?MGd0RXJUWE5uVU9aTDl0LzNjT1pxaUM2eitxbTQvTGtBT0lmQ2hQRlNiNnJX?=
 =?utf-8?B?cmRJSGJDaEhzbEVldHJUWUFwa0NrODVJQlNvdzMvU1FQdjc4MDBndUVmak84?=
 =?utf-8?B?VlhRMjBrQ21sbFJ5cmJERTc0QWdZTUlCWXduMVZUcW1LdnlCSjdBcWw2cWxN?=
 =?utf-8?B?QTEyekRybXRIbUZHYml0bDBQMjRKRGtEZTBZMURHamJRZk1tYjZsQTFqNnNu?=
 =?utf-8?B?YW4vbE91c0M5OWJlWmJDZVVsZ3ViSmlvQ3hGdVIzNVFxNTdJVlkwNlBSVUtK?=
 =?utf-8?B?QVB4bG5JcWxmamZtTk1nNU1hdGRrU2RKV1JHV0E2YmhHR2d0ZDg5Y0FBVEJn?=
 =?utf-8?B?RTJwZ2hrTkF1RmljaEFRa25jWmpHZGc5UjY4alBSNi91Z2hJMVlnNy9MU1I4?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79395295-582a-4366-7e8f-08da5aacf7e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:26:56.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au+EmHFm3nzTM8creVSAws8dsyaZaf/3YlN40fkdYdq+ng3f6gNdqPyCjon0BVFMUGQJ5WF17hYE0abM8HJudAAO9e8qoCIR6lFfdMBMSMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2022 4:30 PM, Luck, Tony wrote:
> +        #define ARCH_GET_XCOMP_SUPP  0x1021
> +
> +        #define XFEATURE_XTILECFG    17
> +        #define XFEATURE_XTILEDATA   18
> 
> What's the long-term plan for these #defines?  I see that ARCH_GET_XCOMP_SUPP
> is in arch/x86/include/uapi/asm/prctl.h ... so eventually that will show up in distribution
> /usr/include/asm/prctl.h courtesy of a glibc update.
> 
> But the XFEATURE bits aren't in a "uapi" file. They are an "enum" in:
> 
> arch/x86/include/asm/fpu/types.h
> 
> How will that get to /usr/include?

Perhaps I can think of something like this for AMX state:

diff --git a/arch/x86/include/uapi/asm/prctl.h 
b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..08b6c9155b8a 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
  #define ARCH_GET_XCOMP_GUEST_PERM      0x1024
  #define ARCH_REQ_XCOMP_GUEST_PERM      0x1025

+#define ARCH_XCOMP_XTILECFG            17
+#define ARCH_XCOMP_XTILEDATA           18
+
  #define ARCH_MAP_VDSO_X32              0x2001
  #define ARCH_MAP_VDSO_32               0x2002
  #define ARCH_MAP_VDSO_64               0x2003

But these state components are architectural. While this can help 
userspace anyway, saying "XSTATE component" here and on the man-page is 
probably it as they are already defined in the x86 spec.

Thanks,
Chang
