Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1AC572A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiGMAs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGMAsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:48:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4712AEF60
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657673302; x=1689209302;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=9VkG19+im7+GASEzfadZHpDRffIOZJMivA6iwyRe5S0=;
  b=RFSg+QDLdGpkvoYij1Zc+TSF0zDAz9qoSg1IN0cZklYaq1A6R0MiPvVD
   z189LLilfnB4qrsZT9taHzAL6DjubTrgn2+JwL4IJuifJXSgHGk0jL23Y
   BPEvnWI3bWXTOZgfmkjSiLTT5IY4SmH+WvoBafoJK6C5OHhbU3SnhWOiK
   QRp1d2GgFih6Mnh0oDim3KNHHFi6/TYSlMUhFcWoBFfxBKN6qyUKWJSjw
   nt8tsFm/2wkWPLET9ImJgvgPgdP+bcU7tkDkMmUyXAa3PvLlvSQnQB1lA
   ITJqPxV4J1Ap0aWUCPfJv4B4ApdVaa2sRJRauOuCkDAlAKQYUfLMOV85V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268113367"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="268113367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 17:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="653137328"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2022 17:48:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 17:48:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 17:48:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 17:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfY53uC71AhH1w48lTS6SORqjbv6xDxWYRMLFlcpuSFTc0IMSdT1suymXHrghiOsa5hwu+lLKTzNktTXAgqU728qIhTM2YQnVBRhhG80My7sqx9Mx2WIsin+YrONk16Iug3DlP2I+7Luth+v0KlYcisVQvIMXNj1KT1epohDzdggvYH7QImlzqYsgTxE84kMNwEnBjEnMoLMKIDgsczjpQN0rLxtZ+gL/8jo/ZOnfc05wgMupccHWkhV+hF+7gVELEqMr3wyi9Wk0LfNN5c9+7aCNBreZV+NQEWIKHaMLXDwljNNk6JBD3C8z8ZbSfLJm/jNy7HAm2ESzjqn74SuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAxxsPLKB7BpvrQunlcOuTbpRzlKFEDjzYmHN+8OYic=;
 b=XhCO3p41UnvclmqmvcZROEjoZ620xrKpfy/WCZNG2d5AIEqIM064xu13Swm23Qm+utPhzXKRME8TRPWXT1r2G1hCPLggLHYEDUlQOjde9X7qVhiy6n0M18aGwqhfR2ZgdSF8w2oKiJorTZCIpq27qswqBo9wQF/w19dAjFIWUVMFGE/vJ5zQFhRALfxzZ4DBujLKEgmwEDlsT2cEOd/ZIuUi2dc3MaToVaoTy1+jP0vPzSEQacVtFHjP6tQxXPSxxCvIO7cO9j/NgNXL38Xz5nZB9gTRImtNZ3LX0L1KmCwtpa6E5dVkCRws5CBwSVc42lKgAW1tSvfzsgDB+hezfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH2PR11MB4456.namprd11.prod.outlook.com
 (2603:10b6:610:48::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 00:48:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Wed, 13 Jul
 2022 00:48:19 +0000
Date:   Tue, 12 Jul 2022 17:48:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <dan.j.williams@intel.com>,
        <hch@infradead.org>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] acpi/nfit: badrange report spill over to clean range
Message-ID: <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220711232658.536064-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220711232658.536064-1-jane.chu@oracle.com>
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2ff655f-8418-4202-fd2c-08da64696165
X-MS-TrafficTypeDiagnostic: CH2PR11MB4456:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puXcqocNBpgPFa6PB/3E8H0s6WBB0eub84mI1DHNIdTRzr+cGEYlSOWPGTWudk+RS4bT+Ru8YZZ3l6ScBLWmCHFCI8I3byShTV0qob6rbEDmnQKjFX3NQ4vajBeBj36KRP3EF05VGkw/7kAh0iXRbKOfl8dQRYbPiSOVEwWUwjVW+Bz3WjuVqAwm3L6/HVp/lDShQqiloVWtkfkNq3wXtMxLnbfvc3I56drIlgOjw9iqQhglb3NNduFIaiUjamkAGISdFmqciuMLRgJ5XcBbrGzYE7V7NbuT0rIwUzjTSNP4zMGg8ScQgiAly1s+r3s90eltESm+zyf0rT9dgf03gn7O+XCYPDxaafbrEH4txsRlAE36QzALR+2LJGwE75ZMOH9HIDToi98LowN5W76zFNuwX6Khff2k9ScwxUGjarl03u4iNpQQ0teL86nQrEM+W9fRhre6NRLBFfpDlLDrmBK3h500qCBnfKMKGAQCkj8ynr+VfFcDtvbdIAFWj3iYRU2Twf/9uLHC2BiCqAnqAxbgierqGPqrR/ZsUBlnsaLgoZ2SGKMeKufCoEL9mefaUCVNDdzKlPZsxiNymdgTmwfoVQQRBEUJ+ZxtOZf4ZhoQEQqK/8H2ifB9/KR+CEtysKaleTiObxlmCV/ky8J+ON1r4FHovrCietv6wRL7Kw69rU1vRxeWmNAUsgctA+gXE/p14covJRJHjSxKfqhBJcTAkATgJw/Lx5wFpmGjgtywzMV0ynbGDmMPGsz054jnOjej9i/9kgm3RfN7AYMoy70N+o5pX49dPopPgMDTl7Z8hi6pWPt6KhCkQs1XzcbT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(346002)(366004)(39860400002)(41300700001)(316002)(5660300002)(8936002)(83380400001)(38100700002)(2906002)(66476007)(26005)(6506007)(6512007)(86362001)(186003)(8676002)(66556008)(82960400001)(6486002)(478600001)(66946007)(9686003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIDSuZEONUUNAY/kciutLDbCA54GzA2kubEOwSqRhohW9PE5NEvfan2FMnk6?=
 =?us-ascii?Q?pTBLV4yGrSZ3km8nCzjQxXfbnIWzkD6PBabI85ZrpWIpMwUIEhkSnLVACwJ0?=
 =?us-ascii?Q?zvnplBLOGIUntGYsFICBR1u5ASLXD7QpXTUjhEyqo4C1EvW45X1hULQbo/z1?=
 =?us-ascii?Q?2uzD3ni0SFJks/J2A3ameEPNoSi7furjHmIyb7kSa0cz0KVyJ7HiXEgI+H2/?=
 =?us-ascii?Q?S5uhxkYiyOqGUPkhRU8SrVNtX3sMXO/oQk0oFhjHQntlWOryV6GNUaR+PVxL?=
 =?us-ascii?Q?mpGr3huvgwU5tSNp3LxJx1qQlAEK10hP1rnwhirE+3azBv+lt7pydVQswR+T?=
 =?us-ascii?Q?MTll6ntV/ySKI0mOpuyRZWVDv73wMhIb9xII5WWLPXmb2yzZXVLVb4macpur?=
 =?us-ascii?Q?qFC8Sq4lSC5SDdwuPUqXXebicvoQU5Kx+HkZyjWCperRRiHRjuFz3+5RmU81?=
 =?us-ascii?Q?BRcWFnWh2dxacQqa+YOUQ5Fkr2r23NLoK/Y7IFGCkvwTDAOTKbQpT4kwkdxZ?=
 =?us-ascii?Q?5g6DOyRY6BTUVh6TzR7OtI5cItgKB0UjxpdrU98Kb4OAmZ3tua7/vUUnR2XZ?=
 =?us-ascii?Q?U02V1DbehvrRjdIPWDn/YrMoNyqZ7XhAFt2iAWI8ltIEz74jTbUWHrrkzTgV?=
 =?us-ascii?Q?zcEmPyuRSi7fXLocl/yETe78zZ3O2QeboiA1ZJi+B8CHqA3i9I0XEV6/CaPb?=
 =?us-ascii?Q?7KaULvtBotRFD1x3G014xkwAKDVZDplxZ9uISS3fK9fyNh68z2T+Wtq9Q8HU?=
 =?us-ascii?Q?PZljWJdHA4mCRFBNRWUsx6xlfp1DwlJp3He0rQezfgAZbGBDo5fIZcvyU1f6?=
 =?us-ascii?Q?peeDigi0WN/JzMeoAq7igPxjaAAA+bzCNzHyqEk7fNKLImdMvfzcPHFViDQi?=
 =?us-ascii?Q?trdQaWUP+DoPc/DYkztJ/0FD25u3iNZcpxOJzcK69BRtxmE1zC+r0z9t4Oga?=
 =?us-ascii?Q?/HZGE3zX4MpaZtXK7404inrXU5KXU4FwcL/3PqytvStM+wKuQre66KFMT1W8?=
 =?us-ascii?Q?zpFdt3cMWBzTMm+U598899VO0JKlsSo+VA0982ddG2YJLI23YRqtZ9aMBVTG?=
 =?us-ascii?Q?8m9zs+ezf2MLp/TTtonc7roakSKNFNMOYCpxSJ224MaGh74a5fmewpBQeaLh?=
 =?us-ascii?Q?ZpK4R6U1v05BNO/yz0KVy9PBKCrn+EvJ6VDJyNgT7BL+XwtwkeS+sGvwOyod?=
 =?us-ascii?Q?jt7SfwQ6RZjzyb3tYmLglGdaXE7vLr6QrOjlby5kVbMTgHRt/hflnYbaa9uH?=
 =?us-ascii?Q?vbOGxKUBETczxc4om7duBHZbZkRx0f4nVtCWBGOu8fQSFoujwF1J5EpDBqx+?=
 =?us-ascii?Q?fiXcaYPqerP71Z2P8Z7nZCRLR/2yRFeQ3SANDol0if2TKODnOshNjbyVpYm7?=
 =?us-ascii?Q?uiqJrbbicBlMiA9396Iy9yK9e7zK7bXpYqWb7WC6DnlfD5An26297TBQgaxw?=
 =?us-ascii?Q?IHixMUEsc80YSf7af3OeEP6lV/pKeT5pf79EIcyOW+VdRgV2UwKBbwVfKRZ6?=
 =?us-ascii?Q?aM8VAS1Ui1rtAvQc8NdVVmvwKlAKKSHvIr6Yh/gvVEsVEzUkQ6BFLaLN7bSV?=
 =?us-ascii?Q?FmlFitCqznjz9g4q8F17A4mriHN9B8aKJ/MaoBWaktD5KfCEnsHhPO0MS36O?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ff655f-8418-4202-fd2c-08da64696165
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 00:48:19.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/wEXRPZyKzDipsfcIJu2015XNesTFTXvUAmIhk0/mDUVbu+1B97ldeBGjyl2kXnhTly+G6Tm48x8WVQwMLsVslt/HmjoVWxtW+KGMLsJY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4456
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jane Chu wrote:
> Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison
> granularity") changed nfit_handle_mce() callback to report badrange for
> each poison at an alignment indicated by 1ULL << MCI_MISC_ADDR_LSB(mce->misc)
> instead of the hardcoded L1_CACHE_BYTES. However recently on a server
> populated with Intel DCPMEM v2 dimms, it appears that
> 1UL << MCI_MISC_ADDR_LSB(mce->misc) turns out is 4KiB, or 8 512-byte blocks.
> Consequently, injecting 2 back-to-back poisons via ndctl, and it reports
> 8 poisons.
> 
> [29076.590281] {3}[Hardware Error]:   physical_address: 0x00000040a0602400
> [..]
> [29076.619447] Memory failure: 0x40a0602: recovery action for dax page: Recovered
> [29076.627519] mce: [Hardware Error]: Machine check events logged
> [29076.634033] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> [29076.648805] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> [..]
> [29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600
> [..]
> [29079.595327] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
> [29079.610106] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
> [..]
> {
>   "dev":"namespace0.0",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":33820770304,
>   "uuid":"a1b0f07f-747f-40a8-bcd4-de1560a1ef75",
>   "sector_size":512,
>   "align":2097152,
>   "blockdev":"pmem0",
>   "badblock_count":8,
>   "badblocks":[
>     {
>       "offset":8208,
>       "length":8,
>       "dimms":[
>         "nmem0"
>       ]
>     }
>   ]
> }
> 
> So, 1UL << MCI_MISC_ADDR_LSB(mce->misc) is an unreliable indicator for poison
> radius and shouldn't be used.  More over, as each injected poison is being
> reported independently, any alignment under 512-byte appear works:
> L1_CACHE_BYTES (though inaccurate), or 256-bytes (as ars->length reports),
> or 512-byte.
> 
> To get around this issue, 512-bytes is chosen as the alignment because
>   a. it happens to be the badblock granularity,
>   b. ndctl inject-error cannot inject more than one poison to a 512-byte block,
>   c. architecture agnostic

I am failing to see the kernel bug? Yes, you injected less than 8
"badblocks" of poison and the hardware reported 8 blocks of poison, but
that's not the kernel's fault, that's the hardware. What happens when
hardware really does detect 8 blocks of consective poison and this
implementation decides to only record 1 at a time?

It seems the fix you want is for the hardware to report the precise
error bounds and that 1UL << MCI_MISC_ADDR_LSB(mce->misc) does not have
that precision in this case.

However, the ARS engine likely can return the precise error ranges so I
think the fix is to just use the address range indicated by 1UL <<
MCI_MISC_ADDR_LSB(mce->misc) to filter the results from a short ARS
scrub request to ask the device for the precise error list.
