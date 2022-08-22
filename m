Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD8659CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiHVWyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:54:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CC2B245;
        Mon, 22 Aug 2022 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661208842; x=1692744842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=epXUFiUvmD1AJ0/ifXtF/P3EA/jbtCN2edHyA2AwGP0=;
  b=gbI2YEMQN19gi///HlE5jKJk8PfERrWhF+3UOuDDIDGRkDtyUxkLCd+L
   9yIlCVkigKnAybWIy887ZOuf/M5dvc7B0FvIzclMcc0U0g5yKKLVYzp2W
   SrPatsC5Yxmggdc83FleEhmNZNqGiPdn1m3E1PXCS1Ons11Hy9zdzqXxD
   8EuZc+2i+4GNV2wci6/2K81dWhfNci5XbGiKz00Fe+UwQG6QZeokrg/IH
   EXMtcbOeKvs90lga0jHHPXkwQtyhzXTWI69hLgsw77QDmOyWD++yedaXg
   SFrM/Pi1+IaDoIlbQwPJdoVFx3tZ/mSboVP93ehoo3g471Zv36RiDRRja
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291095180"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="291095180"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669751570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2022 15:54:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 15:54:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 15:54:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 15:54:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 15:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi8v9kzeVzfySIZQx7oByi12p0pfpEzvhM5CRmurqxKxRjLla8SBICHskvP4lIfEQgfy2BVKePRFI2B91ysVuaMn+JNVapQu2DGeY9Fp8f0kKZW2yDJUx/dzbxyToe4H8RQrP0FPraABt2WsuvtPsW3YxhboL/97A2EJ2diAxUSaI64B/aZ8HzLqUNgLrX0Hw/ITFaa1MymYKkKJVjc/sPBa3BLVTC+o73koiBr1Wwg4W/42d6zjWWZqIjoCvtQACU2YlWLD+j6Ft0EeNKOTzgS2rKhgCTbooiZEJoEu/mu7esM3faJDaf9MJruOqCm7baElOGo9ewNRb9T1QrauLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw4PVuMi+R+QyavNMAj0YFs0eyYQepgFiDlekJ4IMjQ=;
 b=A7Ba70gOrbAKdpgOcM52SCRo5Z2DXv29I4ZgSunC32PwU3rcXx9STMtwaBDozFiGtD5rjNCUSiGaYauUxpOOjcbvV16H+UBYzGuZChAHRjvRQkAWQzE0w/2Qd25acBszrkkAkY6cUvWW/RXq7hL+o59sEHHmsFcrmOuwsAIvCkzOdRU8gB1hx8pky68JorNXcODRI1KL9QGWSu7G1ZhzscuOau7VHAdGKzrKU6bCNdACZcLgbgA5RVtwF5HCHafUBfGg6ayRtwXJAwjizmSNp7zAOJBbDo8iSdUaX9Yzd1h/3DPrPMa/3KTdbUq8DGERF25xkEtw1oebuW9WAYZyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 22:53:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 22:53:58 +0000
Date:   Mon, 22 Aug 2022 15:53:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] CXL: Read and clear event logs
Message-ID: <YwQJAqThYczUHhOB@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220822161802.h47v7yfrqufeltqt@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220822161802.h47v7yfrqufeltqt@offworld>
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16715a4a-984d-40b8-5b61-08da849132d7
X-MS-TrafficTypeDiagnostic: BN6PR11MB4049:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cV6TrvvpA1y8xfmm1lifHl5LC02nL1FaplXNnldnq9IA1Rtut49hrZZaDA95ZU4xpkfJm8QfDnYPUCEBbeIHn8m2VIv5BG3Jb2j7nEXQ5PXaG1rJcegDHE5yXzmblGem3X9Fl/i35EwkCJ5FwqGiZ1+aLosPQnpQE/vL+fjjQIgXGX+ncG6C/cAcO4sIETrOvFkT6lh4WOSvXWx6t3EOf6oRgdqL+Dtt+bAUjZCOf4LvQsP6CF5+7iPbCGitQN0wMYLFNuB4Dx+DlsnX6Vn0zsnLbplSou0OSWx30DuROfO1kfQCNCZsfkLMs/sBETM9cEpJBpapNDFuO+65pdXnIL/XEauDM6WFTjZZrDP//Idoh/xa5VlK/2ghydDUytaLshL8ptLC82ih7wpExWL1XD8iEy484l87g4hM7Gw4keVE11BKmpV6YGKjzfvkasFk3CrT4bjmsL/WfOayGx9CY6Iqfv0x+y3MlPcZeAoJ8bY+jWpsAsZQzSSKF1AInFNUT6OVySySQ0X7+aT5IM9gICRoTVnazq14mouOvxZ6niTEqb1cqXICR4QxZxmmyLzhN9NM+hESWDfUjQyp/HQUkmTn5Yes6SwlTAFWXsbiw2z1dmo1jNEjUOnXf4gJdUISCXTKNwMU4ZyMMUwF+QM5DJ/2T/lJKf0radIyqpWqkFR7o5OzoeORxVxNmKhpZBpxNz16IfSzE4MXosy651GdlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(6666004)(33716001)(82960400001)(2906002)(478600001)(6486002)(5660300002)(66556008)(4326008)(9686003)(6512007)(66476007)(26005)(66946007)(8676002)(6916009)(316002)(38100700002)(41300700001)(44832011)(86362001)(6506007)(186003)(8936002)(83380400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAnBDB1Qqv5H0fUQCzuiPVQWwNic8ejePQUACNqX2G1tjPLQEzu+Ly6OOyQ1?=
 =?us-ascii?Q?d+8K0n4nKiGyNucZIJJX1b92Oi+sq7e5Wo3SQfcFWzD3VKXqr09Gr3xYKoOi?=
 =?us-ascii?Q?+Y10CAfcPwQuh0tshWmArS8HbRPfd9b+v0vH34g1UXsf5TsC0CKTbKTuamht?=
 =?us-ascii?Q?l0+DftZ+AvNaH608p+V33L0I9MKMCoVu6a/X/uI5uOOcF/SXnADxrWuWkPQi?=
 =?us-ascii?Q?7VvxxEpsV+KONNIUSnNg/mY2BzkfNPDFHHzCubplrR3w+kgtPNAWh+LJLT+I?=
 =?us-ascii?Q?aqGZ2aDKJbklRNicdjgUT8MPo+t3MfGloQcYthtMluKGJE42svZCPp/7EsoK?=
 =?us-ascii?Q?R5dxaOazQJeOtmUCL0XCaMCwdxUCkqKp5lAkJzKaksRFoHxtWCOORsk7ydoj?=
 =?us-ascii?Q?jE2aoRp6OfMb9HTJIiT2GHsRYpk+7iNrj0WfOyLaAV6qMoIyAdAuYSqSzJ0B?=
 =?us-ascii?Q?lhh/UTTUObQx/B4fmBfWr88oFLsNaJpInUkQcnb5UXYBPoquSugiECb5rpkN?=
 =?us-ascii?Q?QfiaoETwQYpPv1oOORONFTtBg2GrqoHeA7C2An5Hnt8qYbqUFbjc7vMOOBtL?=
 =?us-ascii?Q?WBaIDUgnkFyIjEJIlrIAASDhO/SHzuWFjkPuD8ci1DHKhGOUbeqgzFHw/1O4?=
 =?us-ascii?Q?wXzStsiBdbrAIXfkIK0VssB6cEkqyc7c0PgEfcUopzhMHN5+GX01iNwI1E8Y?=
 =?us-ascii?Q?vH4PnILX4WXqDrjwmyVFUeJBuaR3wNs9G31R7LugCeJJCJ8zO/MorebxrN3w?=
 =?us-ascii?Q?G71PVVlqnpAWhc7uTVhNUt96pboQ0wpppzFnIpuaMu4Za19g+UchxIkE0S85?=
 =?us-ascii?Q?n1123Axr6h0kOLxuEnP6evMOLg+Wk69zeQjo2alSSvm0h9t3LgvcHlD/9VXi?=
 =?us-ascii?Q?JnAusFI2NdysbqR5+0iwX2avXXMYSq0ne8Z+JvwIuDXIAxlPXYJPlIA8Jgyo?=
 =?us-ascii?Q?YBPsSEQA+QKNQt/VylFW+Mzt82W1SXK9Ci7xiVuNZUvHYXO+LzLxWgd9EYKz?=
 =?us-ascii?Q?c6WcKYyDdjKOPkJsejjUysEM/pI+rlg1o5i2VioI7fD/yxYnVTtre6cIvfcz?=
 =?us-ascii?Q?YFplSmQmIB1RmK7+JdATtPqdr5oRJvDYXrdXjoee4FXDr7L3yV9osE/INYme?=
 =?us-ascii?Q?Vr6ONBVDD9R0vuPBU7sLvpQISKfKhEyi6ortqXN6hEOCYelSUDTzUJwiIXV1?=
 =?us-ascii?Q?NQTKhzpGLnj+la3larAVg89+9wm4VwJBSz+9c5jrpKqFdxW59f+VFFRj7wjt?=
 =?us-ascii?Q?vmjvJAuwb34ZAz2PVvAsNUcxLXMZXJaY/R+2GWJ6Hia/AVU4MrOkYZpWXqFW?=
 =?us-ascii?Q?MfMCgHoBOnkFc9tIh0iiA9Bv8gQ0UjuFHpKONkqXzdiFlcr2vsOX4BlYQEyu?=
 =?us-ascii?Q?1Gs/l/Vnm8uC6qz4L4wywjE1zFYAajAueo3UZLIPNlCZsDSB1TfLH61UL44o?=
 =?us-ascii?Q?n/bZFKpQ9VXfbJW4t++gUJEkcQBkiq0Vzk7SsGDHDcCWJkU5GYWfeif/82U3?=
 =?us-ascii?Q?6PprAp3lzZZsAXhtzIa5v4xGjjkFFwdGRnt9eTGS5cfCDMVpkg7cAsuzPEKP?=
 =?us-ascii?Q?8iSpt1WNK004j7s8Ml/eZjzU4b+xU3rJr7a7mDB5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16715a4a-984d-40b8-5b61-08da849132d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 22:53:58.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYgtKyiyTYRvT2YHgSyFvQ+YiDpXE4rBucR1NC7Z7TTvGAKKHoRgDTszdcok2nb6haVa4u/52dFrHVw+T0i8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:18:02AM -0700, Davidlohr Bueso wrote:
> On Fri, 12 Aug 2022, ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Event records inform the OS of various device events.  Events are not needed
> > for any kernel operation but various user level software will want to track
> > events.
> > 
> > Add event reporting through the trace event mechanism.  On driver load read and
> > clear all device events.
> > 
> > Normally interrupts will trigger new events to be reported as they occur.
> > Because the interrupt code is still being worked on this series provides a
> > cxl-test mechanism to create a series of events and trigger the reporting of
> > those events.
> 
> Where is this irq code being worked on? I've asked about this for async mbox
> commands, and Jonathan has also posted some code for the PMU implementation.

I'm still trying to work out how to share irq's between PCI and CXL.  Mainly
for DOE.

I thought that we could skip IRQ support for DOE completely and this would
support your proposal below.  But I just found that:

"A device may interrupt the host when CDAT content changes using the MSI
associated with this DOE Capability instance."

So I guess it needs to be supported at some point.

> 
> Could we not just start with an initial MSI/MSI-X support? Then gradually
> interested users can be added? So each "feature" would need to do implement
> it's "get message number" and to install the isr just do the standard:
> 
>      irq = pci_irq_vector(pdev, num);
>      irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s\n", dev_name(dev),
> 			       cxl_irq_cap_table[feature].name);
>      rc = devm_request_irq(dev, irq, isr_fn, IRQF_SHARED, irq_name, info);
> 
> The only complexity I see for this is to know the number of vectors to request
> apriori, for which we'd have to get the larges value of all CXL features that
> can support interrupts. Something like the following?

Generally it seems ok but I have questions below.

> One thing I have not
> considered in this is the DOE stuff.

I think this is the harder thing to support because of needing to allow both
the PCI layer and the CXL layer to create irqs.  Potentially at different
times.

> 
> Thanks,
> Davidlohr
> 
> ------
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..b334d2f497c1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -245,6 +245,8 @@ struct cxl_dev_state {
> 	resource_size_t component_reg_phys;
> 	u64 serial;
> 
> +	int irq_type; /* MSI-X, MSI */
> +
> 	struct xarray doe_mbs;
> 
> 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..95f4b91f43b1 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,15 +53,6 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> 
> -/* Register Block Identifier (RBI) */
> -enum cxl_regloc_type {
> -	CXL_REGLOC_RBI_EMPTY = 0,
> -	CXL_REGLOC_RBI_COMPONENT,
> -	CXL_REGLOC_RBI_VIRT,
> -	CXL_REGLOC_RBI_MEMDEV,
> -	CXL_REGLOC_RBI_TYPES
> -};

Why move this?

> -
>  static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> 						 struct cxl_register_map *map)
>  {
> @@ -75,4 +66,44 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
>  void read_cdat_data(struct cxl_port *port);
> +
> +#define CXL_IRQ_CAPABILITY_TABLE				\
> +	C(ISOLATION, "isolation", NULL),			\
> +	C(PMU, "pmu_overflow", NULL), /* per pmu instance */	\
> +	C(MBOX, "mailbox", NULL), /* primary-only */		\
> +	C(EVENT, "event", NULL),

This is defining get_max_msgnum to NULL right?

> +
> +#undef C
> +#define C(a, b, c) CXL_IRQ_CAPABILITY_##a
> +enum  { CXL_IRQ_CAPABILITY_TABLE };
> +#undef C
> +#define C(a, b, c) { b, c }
> +/**
> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> + *
> + * @name: Name of the device generating this interrupt.
> + * @get_max_msgnum: Get the feature's largest interrupt message number. In cases
> + *                  where there is only one instance it also indicates which
> + *                  MSI/MSI-X vector is used for the interrupt message generated
> + *                  in association with the feature. If the feature does not
> + *                  have the Interrupt Supported bit set, then return -1.
> + */
> +struct cxl_irq_cap {
> +	const char *name;
> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> +};
> +
> +static const
> +struct cxl_irq_cap cxl_irq_cap_table[] = { CXL_IRQ_CAPABILITY_TABLE };
> +#undef C

Why all this macro magic?

> +
> +/* Register Block Identifier (RBI) */
> +enum cxl_regloc_type {
> +	CXL_REGLOC_RBI_EMPTY = 0,
> +	CXL_REGLOC_RBI_COMPONENT,
> +	CXL_REGLOC_RBI_VIRT,
> +	CXL_REGLOC_RBI_MEMDEV,
> +	CXL_REGLOC_RBI_TYPES
> +};
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..c0fe78e0559b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -387,6 +387,52 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> 	return rc;
>  }
> 
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc, i, vectors = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> +		int irq;
> +
> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> +			continue;
> +
> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> +		vectors = max_t(int, irq, vectors);
> +	}
> +
> +	if (vectors == -1)
> +		return -EINVAL; /* no irq support whatsoever */
> +
> +	vectors++;

This is pretty much what earlier versions of the DOE code did with the
exception of only have 1 get_max_msgnum() calls defined (for DOE).  But there
was a lot of debate about how to share vectors with the PCI layer.  And
eventually we got rid of it.  I'm still trying to figure it out.  Sorry for
being slow.

Perhaps we do this for this series.  However, won't we have an issue if we want
to support switch events?

Ira

> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> +	if (rc < 0) {
> +		rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI);
> +		if (rc < 0)
> +			return rc;
> +
> +		cxlds->irq_type = PCI_IRQ_MSI;
> +	} else {
> +		cxlds->irq_type = PCI_IRQ_MSIX;
> +	}
> +
> +	if (rc != vectors) {
> +		pci_err(pdev, "Not enough interrupts; use polling where supported\n");
> +		/* Some got allocated; clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
> +
>  static void cxl_pci_destroy_doe(void *mbs)
>  {
> 	xa_destroy(mbs);
> @@ -476,6 +522,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> 
> +	if (cxl_pci_alloc_irq_vectors(cxlds))
> +		cxlds->irq_type = 0;
> +
> 	devm_cxl_pci_create_doe(cxlds);
> 
> 	rc = cxl_pci_setup_mailbox(cxlds);
