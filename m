Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E114154FC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383364AbiFQR5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383290AbiFQR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:57:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72AC58;
        Fri, 17 Jun 2022 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655488654; x=1687024654;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xjgLxqXTi0wF5EO3j6CAq0FP5o+ki1lB0fWycXIPoh8=;
  b=aHv6ALScFrqX1ANP+IrntYwXyPsXxRj7/XsfL4ue99sM+sCEl5MmbEyJ
   yAapXViDEGGQNRAzX7ueQmrVqRe4yQ24xhCH5ZHsODNpIkt9OuxE3M3Yc
   wEOlB+xMFs2mkT9Pbx6exX1lPsi5suMwrIncRuoIPufNU5lcsFGGqGmJU
   8zpwviXWziykKhnsTAV93IYcmOffS1T+8s9A84dLGEIfAkwOu9amXrCxN
   6IPyxnuVTaJG/u/dmPczQNSYxq6TOrGDOkeAM3jsuWoVdJW2vVC/Lw99Z
   VZQtv9a+IcX2DWlIA8bpbwtAEYJahgtGCPLdIhPkMYQpHWx1gC7JaSutY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343535891"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343535891"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 10:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642120462"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2022 10:52:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 10:52:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 10:52:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 10:52:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 10:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzFcsFVj7fuDfj/C4DSaFppOigdhzzzgy7wBJ+hCA+IDEwPFBuevmHfFStQ7JBWUUMHg/I4QOuzDtJ6E1aH4YFdcLO5YN6jsk1UB+SNnafdGW1TmQnPxdM/gKXLEVvnR8LLgs71JY5P7600k37m4QzZo3wNgtJm5pF4OtjkMf4Ih7szwbtT2S18bA8BDpKsrGz/lY2TYILsQ8eJdbm6ciTVUGWiZTJ8UdeMLQq11eSMVX/bdPkg7/oAlVLHzH5JUox+nNG4GqDFbsiob2KDlBqB3qT0gvj5lUYNLH8kw18Ux+zqYbtsOJPyRj64denO7xthwS/J9Hrqiee4mO04F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsbZmgN8k2ynvawiQVpQrCsz7+r2tVj/X8ZIiPqEm84=;
 b=CVhTIEw2hwXVar9DZeeey9fSKTkRA4OrQIaDwWZAksiCFyK6dBW9tpJ985eFUj9DKpjIXY8uYeCInZtCCT1T5apfCI6aCCN/8+nU5gk3FzF6hw3r6X4Lyp7sx0NJr1U/XffVg0sb8Q8aGs7Z11BwZeGBtj4Z8kFx0+APn4qZ0PNPVH13AMonkvc82fKvbk3R/CtTGF1AMROpkE47Ob9aN7QQNnfHtvX34+HoQ7QtqYzd0oYiXToJM5HRyMof71Xxjm7MQCGmHyjD3PRDJ3cU66jpgZQJYDQ8X4rkqZ3yNP5GvQqP8swO+HOkA8U+9Jc98lSofabFT363RU1D486h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4671.namprd11.prod.outlook.com
 (2603:10b6:806:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 17:52:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 17:52:51 +0000
Date:   Fri, 17 Jun 2022 10:52:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] CXL Poison List Retrieval & Tracing
Message-ID: <62acbf713bf0b_81c5e29463@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MWHPR2201CA0044.namprd22.prod.outlook.com
 (2603:10b6:301:16::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 861ff092-0a80-4304-4af5-08da508a3264
X-MS-TrafficTypeDiagnostic: SA0PR11MB4671:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA0PR11MB467141AE8A1A7267C0BA68BDC6AF9@SA0PR11MB4671.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXWxio9nFOcIitLFAlJvFbjY6pnS626MvOgUmH/h4OJ1oEjyyYm8dDYeeOD7CESGoqt3jVqNDXO429gEf06voS/Mj/O51Gc+hJRy527SoZ2QErrSJcPO1VVqwIBgJjzzpTPJiVtnNa74AfwJTOBbjB8FpRMMCnKgsxkMFV7J/x/rB0fkzeWIJzFwtjna3Cm9maeycYJeqe8mI88UfifYUHIM1u9RMDJg6vRuoX5SKLl0ooxYNcH5XzgmkiwHD8pGetrbDrkpLDimtEIbkzZIA0fezeLP/afUQMb6ujr8YpaCJt1SNkQ2HXjvPsLHgYFYgT2OBEdjAFNjpKNSAmURGae1kHj1l2Ad2sfKwPilACCsYQW47y1yUxUn57ejcDghFCa2umoSOj1F+XvY8WtzfEUP/GQhaV3Lt67KJIT3QaVQcO1UpW4c/0bgLiyVunWBYBAZJf1c2At+sh4wa48AbvK9SeQoGsL2/B4Tuzv6if4EE9U2lprdMMR2A3TQFTg0i8pzMcRwbmhvB05FtV7Xh7ht0DyNCV8D8f5yEtQAOy60LJaq3OwlZKZWnB6oSZEjzbTi0Kg1ElbBmfKa+6nEHz2C0O0XgWn2+JkIR4KLqA9CwqH+0B7H9EXgKqoS2NLMq7wO3VIF1MJRi1IgUi7L6Z2vb4Ivg8s8uf/KfCL80yz9kYRMCB5dZc95iYSO7S4+Jw+3uMjCsnV+ajKiipxLPN5evsDkwbRiUAi+Q6yrshU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(86362001)(186003)(6512007)(9686003)(66476007)(6506007)(82960400001)(8936002)(83380400001)(8676002)(4326008)(2906002)(5660300002)(110136005)(6486002)(966005)(66556008)(316002)(66946007)(498600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69U/FluxOSbT6j//xtViMv/DW+5EPjHKUcKtHsn6wfFoE/iwS9/e3zpbV1ir?=
 =?us-ascii?Q?aqyZ1cFffoZczw6XBrj1ENqyp3TsfdG014z8BujFjEawUtqNEr1WlGR7sw9w?=
 =?us-ascii?Q?SYRXT72uQiRA+wxRhQb7VQdUIDdQcmuAFrKCN2uccqFx2eXewLOe2t7HT1Et?=
 =?us-ascii?Q?PDh+d0cIzOl/3jcJDVxYWfx2h3Sukzkx80vOmf4M5CG8bVsyXGfymzyqLLuO?=
 =?us-ascii?Q?nq5R2nHmtgK3VcTr2AADpy6XCEcPv/Q7BpxZhAZY5ldvKg4Xsa5CgryE/m2R?=
 =?us-ascii?Q?5490OiUbVqfyF1o2pUCik0VnozpyHROLBDPQ1YOGb4+ux8uuFpqJTb+aeC6U?=
 =?us-ascii?Q?zkEVcyiYzJu++Z0hqcgXaC6biSoj3kQ+nPy9ney49NXGy0hEgk4/q0REbq1u?=
 =?us-ascii?Q?OxbfmdqI56Sfn3EvRsgYzF5XZAiFIAvFjocMtzqLY8mx40gDbKbAopqz136X?=
 =?us-ascii?Q?kD1gNNlAYeGOya1mF7U+GtImcj0EENYO/vzf+omt/+/2cVZl/nXm71l8qFah?=
 =?us-ascii?Q?hqoDmmpUqpMT1NLfX+bvvZyJHKUYpyQ9//aBB+MB0Mki6e/82uJ9l5SZCJ6n?=
 =?us-ascii?Q?6xS7YhbPjMu31yA519awtSm1CcyS89Fa9XTURsiv1BE5K2NICayWB+qEqkCj?=
 =?us-ascii?Q?VOtq1Fq5/HeKewofwzGvt0AJbOohZcvxqQgbI+JIEwut/r4JCo2NUu2tPlna?=
 =?us-ascii?Q?GqK1pF4rywZdRikCN+hNGn9EFJZ+TD0zEMm3VsOsm8eNc74w1rq1ayq/DcMB?=
 =?us-ascii?Q?PAvaL8bigszjJ/WJpNJAk3hx8sNB4EZoKy3rjr2QhfPaqKQhrRPABBG+mApO?=
 =?us-ascii?Q?GyTuUdMvOfSrcPylFcFP91WVmO+ChFs/Y6Y7Qi74+MfojRb/9tmW2pPO7lt1?=
 =?us-ascii?Q?LyVyaj1BnD1N4H/xBxK8pX/YudIHKjSyiPf5H26sgdu9NL3xzTFtVJ8TKqPY?=
 =?us-ascii?Q?weJ5iQ9/KREMSEFZCUII61WLv1psOf0pIFoQjGAhs7g5hJW6JyESMra7o+vl?=
 =?us-ascii?Q?2TjXHoae1jtzVNy7AbZTDqDkUjB8Xw7UHVNMn5KaZQ8rDTcj13bgB0K39VXY?=
 =?us-ascii?Q?mfmFu+jaMy+RD+JpKcbaRfPyBpvZcJwob1DotNWzI5CIQzT8yitMu4IDulnN?=
 =?us-ascii?Q?3qJx/GgGqjW8klsW/VjPr4VnMPex1DlX+STzdxyu8ky021YDSGEbpKeGN2Xe?=
 =?us-ascii?Q?rqrke4vAEq4Txu5aNEJ/wrvZqd9kkwzPiiTfjU1uh8vCZFgcz3QwV4FUxSaW?=
 =?us-ascii?Q?D646IQeXusA8mDIs62AwvwN5qczQTSPBjT37CmzMLuj4hMVzg7P8O6qf4tg+?=
 =?us-ascii?Q?aarMSrt3isafwY0jRb27rBrf5r6iAvpJ/sBtsbCzppZKaNskrdYVgh7tPhv9?=
 =?us-ascii?Q?rbqhVTQ/xuwgRw+VyCXph/D0CiTI1dL6wjYoagZpq0MDtaP8AwEIUVtxMFR1?=
 =?us-ascii?Q?WfAonbDOds4Wy9MP0c+j1J8WnNCkTltAFSqKCqogCf10pbCWcO/3xrmLxB8t?=
 =?us-ascii?Q?lUq7W10auIQ34O2P6hrP0eTQa2141bytXh4sReM45xCQtrSfVxIcjO3cpsJ/?=
 =?us-ascii?Q?VWLhgID9RQUfZiCJkXmFKuP9glSVlZHvVCf05LWJ+5tTV6tBlIwMCaZRRMdJ?=
 =?us-ascii?Q?ywAWty7aCn8Sj6kuhtqtB5jXg6n6Dw16W5s7XijQMPk7mlhmKCQTq0fEUn5j?=
 =?us-ascii?Q?oTzz0/+ZQls+rTAkJ3R70O97TbzM0WEd0wXr8GjPoCotfavwF4ZPRHgSVmj8?=
 =?us-ascii?Q?ZaO+7NSpck/eUCwBuAWReTn8RSJQBGs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 861ff092-0a80-4304-4af5-08da508a3264
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 17:52:50.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTZA2fHgYDA1qHUfNK/GS+wdKjwWb+l98Wwfi0/I6lPKbsBbmFgy2dOxEF/X/D9epm7aGkeuwn7AM68DoNeWYWZS9kcMDlmluUB7P5c+Mqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introducing the first piece of support for CXL Media Errors,
> offering the ability to retrieve a devices poison list and
> store the returned error records as kernel trace events.
> 
> The handling of the poison list is guided by the CXL 2.0 Spec
> Section 8.2.9.5.4.1. [1] The usage of Trace Events to store the
> Media Error records is a first look at the proposed handling
> of CXL ARS events.

Nice! Thanks for getting this started.

> 
> Example command line usage:
> 
> $ trace-cmd record -e cxl_poison_list
> $ echo 1 > /sys/bus/cxl/devices/mem1/get_poison

Perhaps call this 'trace_poison_cached', and later call the one that
does scan_media 'trace_poison'? Otherwise it is odd that an attribute
named "get" is write-only and returns nothing but an error code.


> $ trace-cmd report trace.dat
> 
> cxl_poison_list:	memdev: mem3 source EXTERNAL start 0x41 length 0x2

Perhaps just make the source the raw number value so there is no need to
go change the kernel if that reserved field grows more definitions, or
if userspace grows knowledge of what values 0x4, 0x5, and 0x6 mean for a
given device.

> cxl_poison_list:	memdev: mem3 source INTERNAL start 0xc2 length 0x3

I wonder if this wants to eventually be unified into a common format
with the General Media Event record? The idea being that there will be
multiple sources and triggers for CXL subsystem trace events. Lets take
the scenario of poison being written to a device by a DMA agent. In that
case the device may fire a General Media Event with the Uncorrectable
indicator and the DPA. Userspace will want to distinguish that from the
Media Error record, but probably benefits from using similar event
parsing. The trace event could be modified with something like an
"origin" key to say whether the event was asynchronously generated by
the device, or synchronously requested by a given process. Something
like: "origin:<device|pid>".

> cxl_poison_list:	memdev: mem3 source INJECTED start 0x183 length 0x4
> cxl_poison_list:	memdev: mem3 source INVALID start 0x284 length 0x5
> cxl_poison_list:	memdev: mem3 source VENDOR start 0x707 length 0x8

From a parsing perspective should these be consistent about the usage of
":" to delineate keys vs values? I.e.: 

cxl_poison_list:	memdev:mem3 source:VENDOR start:0x707 length:0x8

...that way if this format changes tooling will be prepared to tolerate
new keys injected at any position. I have not looked at how
libtraceevent identifies fields and backwards compatibility.

> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> 
> Alison Schofield (3):
>   trace, cxl: Introduce a TRACE_EVENT for CXL Poison Records
>   cxl/mbox: Add GET_POISON_LIST mailbox command support
>   cxl/core: Add sysfs attribute get_poison for list retrieval
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++
>  drivers/cxl/cxlmem.h                    | 43 ++++++++++++++
>  include/trace/events/cxl.h              | 60 ++++++++++++++++++++
>  drivers/cxl/core/mbox.c                 | 75 +++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               | 32 +++++++++++
>  5 files changed, 223 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> 
> base-commit: 2263e9ed65887cc7c6e977f372596199d2c9f4af
> -- 
> 2.31.1
> 
