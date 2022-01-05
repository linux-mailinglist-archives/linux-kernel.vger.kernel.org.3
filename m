Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240F14852FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiAEMrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:47:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:42303 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234767AbiAEMrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386862; x=1672922862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TNBwkN6/burfvMMuTUgEO4lq8narqymk0wntUn53edQ=;
  b=nPcl+4xTWYz2SEHsoE5OVQBluCuTSXaisUm5pcfsuyGzSeFlghc0ezah
   ie1ir385aDXxD4mq3PcVHvJx2PlbRYaPBBxZ6o2xQcWGJGiypKLRX5qYs
   eX/lFIk3o8K7jGfJIII4X3J8eIPVoMMXOEqThZ/XxU+zLzn9TZRsTqgMC
   1SMfWKhTkPF8f+FGkSfIWHc1GJ5MuILiMFQMriiFqz/Lnn62z+1sEvK6A
   W+y7aCQ+InAtOd4tG00q9eatBibTUZ+01gl3mAuKCmyRDgE7gp4/t5K+z
   de3Q58pVupGpGHTvjAcYGPRfHElL+dNO4/7lyys7ypuaXlbvzs0lWhgv5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223113063"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="223113063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="621027277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 04:47:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 04:47:41 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 04:47:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 04:47:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 04:47:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAcgrW4aNXdSX2UQD7gce3mb6VvjWJeqhb71ii+zwr3YNZVhgfECnJkWRL/tOrn4RVc6ZpO0dnN00tVH1XxlmNSA06eWBK8EHxaZyOd6k3nyPOeVnO03jIo9tt+rwO54C+pAMJOdTslQbcWdxXIYVN65h9nfzQaPDOiDtlF19KtHHHGAOs6brEwjjJ/oZsVwyCK1c1VUqJSZJxlUDKxPY8SLKO5Rfp/JDaFahfty/Qt/dK+MHc0LIUqogtfzwwLB2i31JXa0jEMsKY5M0y/5iJ7Z1w3ewjP8XzZex1bwOoFfd0NNLZ8pwW5ELeJte4dRCkotY1FPpEPz5E3svptFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuRdYweyNrqjG9neMd+4slwSYDKLxnvHrKUiCuTdqo=;
 b=gdt6qPYQo1tKU/PX8L0+WyzWjSTpDPycV9fFTnCnc5jZMy7m9xamvxiXWqVZL/NoE3cY9Wf9yqnttzOU9FWYD6abFBa4KDDNQqHEDr7yVpVAY0PobMwGEDtTkAeOxc2bYs6vamk5+uX/ytojoZbSxOq8vSauLbBKa7zWTtpMDGLP6H1/ZqHwI2FCinBxFnfHcIlRkmHEGuGMvccPbTkiw+au0HGY7jyHK4YYhfpz+i9CphM/rEdur5INz5z9HHqSepxVUXxy7R7anPdvC3axuOK0OqYvphQ0xh5hN28ddBAWLekgNRyWiCOwpt62Zf1UN9JDB9foP3yW0XAG7kWjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB1295.namprd11.prod.outlook.com (2603:10b6:300:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 12:47:36 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%7]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 12:47:36 +0000
Message-ID: <fa2f7d50-5226-726d-a9ad-2c42cb5c4054@intel.com>
Date:   Wed, 5 Jan 2022 20:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>
CC:     Marco Elver <elver@google.com>, Carel Si <beibei.si@intel.com>,
        "Joerg Roedel" <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com> <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com> <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
 <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
 <YcHxKzB3WPurKlZ9@zn.tnic> <a5cb8140-5834-7649-e629-f2775cf5b9a9@intel.com>
 <YdWCstlEW6k45+hH@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <YdWCstlEW6k45+hH@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27aaa4ad-6634-4673-31cb-08d9d0498cf0
X-MS-TrafficTypeDiagnostic: MWHPR11MB1295:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1295A67EFDD02E92233C253EEE4B9@MWHPR11MB1295.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbR5kiDwx/QSUk5pbfpXOZM2Cd+O+HJqUvBZaxgZOEnUnKtgtKFYHqlf276062pxFY+4sr2172/eLBhbbfP4KvJSD+poc7FWY4ZKEvjzorfKQuDckAaCl4P3mi6pbXcZvdIAQPcPOBzTSfDa7xzoDpH3of8LXQe+N+YulseTx0Wx3OlaqYutqNxVBZJBOdgGQTlmIvv7CfJqXHiL+m64q1gpVyIW1lFJVXvLj78IJwI0fqlwZnHU7p10NLrq0C3ZZZOP8ER494wOCRzMckGJ4vTjbic8hTV+bQUL2n5JOJ4oKh6nliPKWSsD/yXxmIrNqEZujKSnyq43y45svOqIncSJfBLNPuBVdntx4txophJ7rmXe7KpciMQKw0jxMK3TVjabgtfQhe6duleAUXt59IHxpjTmTYHbh84KejUA/5vBHZ85CE1CJAjw/gB7ltlA6yURkwE3pzmit2Dm30KmKRV/WnrW1TNhUn1IqnKJPqN9IH8cEDBpaq8xuIqHwvWmU50fTaXM28PzXKPgdIbqVRkSHwQ/3/EQM1i6W9FKARBP/F6E7qgrC6pgrP/RF2h++2t06azsirxfGhRUnsK+Zvq8mgqAAccQ68ASvX9ltM+jPpWD1NNlQWxb/ebg1f/hDtJaoFunzZbONsbbVv5HwomvhlPNUABL/foG+QeRP4V+kZtX2JMsvs1nJ2awYmX50s/D37lF2ueag3/UGMAoW6HDxtnf4xvdmrjPI8u4So4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(54906003)(6916009)(53546011)(316002)(6666004)(6506007)(38100700002)(82960400001)(6486002)(4744005)(26005)(8676002)(36756003)(66946007)(6512007)(2616005)(31696002)(186003)(8936002)(31686004)(66556008)(66476007)(508600001)(86362001)(2906002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1kQ0prZjZtT001bWEzN0FXWm05M0o0b3RYT3VPMkhKRlRpYkZHNnVTR1RF?=
 =?utf-8?B?RkNRZ1FiM2s0dkRtdXFnVGo2SVE3YXExalpKbDR0T1N3OXJzUHV1QWFsRVVq?=
 =?utf-8?B?TktoeFZNd054UURYUkQ2a3ZIV0k5TEphV1M5YnRwbHgramFib003ODdnbUZS?=
 =?utf-8?B?OVdZZ0cyZkdOc3lDU0tNVENKY2tGMEx6VDlPcG5vZTJ0SGJpZk1DQzVtaHJC?=
 =?utf-8?B?R0drNFAzbzJRTWRyV3lyeGkzZzNCU3lFTnduRkhIWjU3ZGZDSXh1V2VCalox?=
 =?utf-8?B?cmJJRW9hb09zSnZSQnI1UGNUemVITGI1SXI4R1EzcVh6Q3lENkcydjAxRHdH?=
 =?utf-8?B?bWJlMkdYelh0Z1JXbGhMZ3R3bm1nK1N0enhmSy9LUjhLS2M3cGtWKzA1UFFM?=
 =?utf-8?B?OFd6Z2wzM2VxRHJuYkdETGIyTGZ5SVlrWU5WUzc2d2FMQUphK0FYRWxZMTAw?=
 =?utf-8?B?ZWEwYytwMXM4RkhscnVlUkdYci9ITlQwSVpSNXZEWjFEeW95VTJWREZTUzhY?=
 =?utf-8?B?Y0lBWmh3L2Y3bE1qNHRaVWxEdE9Kdmk1VTBKQUJ3VjVMNlBpaVNhWG1wTUxx?=
 =?utf-8?B?Y0tnTWp4dEF3V1gwOWRaQ0ZZWkhmVENneC81VmhGNDNVT2lnaSs0UkMrOHhX?=
 =?utf-8?B?ZDlQelp2czBITHY5dEgrbE1jK2hOYWpsczJlcU84aXNtK0JpL2lReGgvdE1E?=
 =?utf-8?B?WUo1dGtBR2c0YXU4dG5OK0JTMVFXaVYyUmpWRmNreFJPckZiUFRWc3dRemcy?=
 =?utf-8?B?UVhqN3JyaktSVDNrVithaHJwa1RWaDFIaTBHUjZxbkswWktIMnNCaUN4cVg3?=
 =?utf-8?B?M2UzY2crcU1rWm1RbDZXc0hiak15c3h4Z01MOVNvUDRwdVlZckZnUzJIZnU0?=
 =?utf-8?B?NFR3MTRITWZKZWVKNU5GZ2pIbGFJVDdIYzNHaEt5VHdYK1JEUmZ6T0ZQQzVv?=
 =?utf-8?B?eE90RVBnMUpPdEhRZFdEMEVDUzFhbWErOHArck1sK2h3RUQ1K0dSaUxvekJP?=
 =?utf-8?B?cVFDem1leXB1ZUpWOHhaZlFiakJWQlpEbFZBTnpnS0JnN3VBTVY4QnhmUVVs?=
 =?utf-8?B?RGZIcEZydll0N3ZhcHdrcGx4S3BBRkNPSEhBTzN6NW5DSy8zY21QK2NhZWRS?=
 =?utf-8?B?NG1mMk5WYjNEdy9ZekkzZDZJV0gvK0pvQldTMElpVVlPNUpNaGtCRjFpNXFq?=
 =?utf-8?B?Wm1zbXZvYm9rNW00MVRyL2ExSWNuODRVUCsyQXpFUHg4N1l1RmIwUDl6dlpB?=
 =?utf-8?B?Y2dRb1pRR1RvcEV3UDVHcDBiVnRKU2hmRFZlcERKUVpYR3NSakpYb1V2ckV2?=
 =?utf-8?B?R0JFc2w1QjMzNkpucUQwem5nTTRodDgzdHdjclMyTkxoWDJjSGVTMTFXeU5W?=
 =?utf-8?B?Ujl6TzNHQ3JEcWNnenQrQTlhdlNZdmdMck5rVmJ6VkxXQ3hEUWtnb2JKd2wz?=
 =?utf-8?B?a0d2WEZPNGFoRWxSa0VXVm81Q3ppa2pJelVZWG1oa3M0c2xuS1BHVzY4NFQ3?=
 =?utf-8?B?c3FPd3RsZzNFc1Btd2VJWHhXYXJ0ZldSYWFVUEF0Z1pVaGNCbExKTEt2U3Ru?=
 =?utf-8?B?dXQ0MTFpYUlpRHFFL1d2K3kvd1BUanpSZzhFQ3BkbXpWV1V6NjhIZStDVEE2?=
 =?utf-8?B?RzNzNEU2d2NwNnJJUWYweGlTNGJvTkxiTEhsUjRLcWt1ajkzRzJDWndjNEtU?=
 =?utf-8?B?NU1ZaGxYUk9wcmVKYlYxS0ZGLy80dFdkOWdtUTkvR1VpMjVTRnlQTmcwWldQ?=
 =?utf-8?B?c0ZTOU80VlRVRzc5bXNUUUZwem8vSzNmYWc4TzBsTUQ4TlEweUxNRkoxY0VU?=
 =?utf-8?B?TU1XZ3d6SFVoWjhqSHRKOWx5N3VrTEQya0syTzhiMHN5bmlKT0pLRDBVMEly?=
 =?utf-8?B?WXU3TEwzYW51UG1VbFhLQkxnc2VvLzVaNVR0dGhrdmRrYStLUzVTcmlYSndy?=
 =?utf-8?B?UzdrSk1ER0wwSDlVM0RtOGd3OVM3c1p1cGYrTWVuaFBXZm5LNVMxenF2NGpn?=
 =?utf-8?B?eXd2cnZQS21qQ3lCOHZzbXBYWkkwZUVia04zRGtqczlHMThZd2lzRVVHSHpw?=
 =?utf-8?B?Y0NaWUZrcUY3bmRXa1pWc0pIZ1I1Yld4T0FESUlFaStXQWpYR3FwWGh5ZWFo?=
 =?utf-8?B?QXlYOE9zaGxKVDluSXh0K1pCd2hEcU41ZWtuR3F5WEZaZlVmMk8vY29lNE5M?=
 =?utf-8?Q?zm9wutRuGOqy9m5e2mzVaTo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aaa4ad-6634-4673-31cb-08d9d0498cf0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 12:47:36.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tBlBfJXeIv9nCKPU5Q/eom5CEeE8VLK9Jkr1LfRXx4GSun0kcnW8VfyCPpuBHRKu49ECTuVlvPXyxVXQF1mMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2022 7:36 PM, Borislav Petkov wrote:
> On Wed, Jan 05, 2022 at 10:35:20AM +0800, Yin Fengwei wrote:
>> Did you get update from clang folks for this behavior? Thanks.
> 
> No. Why?
My understanding:
it's better that clang restore its behavior to clang-12. Or people
need to use __no_profile annotation if want to add function before
GCOV/KASAN is initialized. Thanks.


Regards
Yin, Fengwei

> 
