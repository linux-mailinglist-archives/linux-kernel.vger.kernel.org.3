Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630235B1532
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIHGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIHGxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:53:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3A86C77B;
        Wed,  7 Sep 2022 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662620020; x=1694156020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Df1hAXlY/+TEumfKg9m6+m6FSeTnccfOWYyHEMH9bA=;
  b=X3lfb6+JCp8JZsqW1dAJgKljXzMoSqkaO1KD9ibdAIFOfsEwIWFahFbX
   tr99bfGBtN0TeLCte1ImemvIxY9jkzhvJu4A0ukXyo1gfBXD11KLC51GJ
   M2/qiO7i0jcTOA/IOMj04gb0SCsbfKkdIp7Qu60lgv+s/Ilt297i7kLIr
   0C4tq3w8v8ogjVbaCCFbsnCJdAIUPCUoOxgTVXbFXeuurRh8f7xtDOITu
   NLjWyoSAgKU1o6+BrarF45PagOPJUTFc5xJw/r2K6qGNeKOuJqZ7qJJlN
   gIu3rUUWSQi7+HdmWEqjZAs16ZmcualCFwDBdbGu0ieUuGqe1Fc6gzsQ1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280114901"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="280114901"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="703896464"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 23:53:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:53:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:53:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:53:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDzviGyZT9K2CKNhVTCsjnwzjmSvM8T422wT4zSkulz7J0rL5dszZy43v3jP5YCinm6VNdPAPgP5n1vbg7Ffl0TSh1PUr3QUk6Nq0Kqxyl16Qtq/hMhv/980qlUWHM23pD4J+J6GdnXZcN4xZNcWEjBmnm2KstdX2yvaVLMLFlqVYpq/icNYuy0ebdCC11nc1hj8Y+oooCDQEUnmCFq16DRzaz5t1ca366p/E6dM+SaNk5ygEV2tTndzl7hrdIz9CLw+FQ+pFD6d1At7eOmUOJe3+8EutssMZwlxszVz4lvSCoXLyfnnf2w36c/X3VvyPH/QQ4gGmiP4NO015TrrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdHFqxG77KZgSv36bLBgHXOU8tPPTXPHelqTTdhjdrQ=;
 b=fExkqaTKANQsXSlpTxP2eiTPRVynnTJeGBi7MCl+ZO6ZizJTDNWhzCDunCTRxvC+DgaJn8w256gKKt5snVlrUOkAXbVj6pQx5xl8KOiaH2OZ2ZR+BN00Ubn6ytJZZI3eGUV7T8NrcxUXZZN9LXoM63KznseuEWu4Tj5G/sY4RzZ3Dam6WqyYcIuikQBvfznTf55xh2E6++0Rt7usOs+VpLKeje2I/o/WYKf6A9n2QNLse+e92uNRlSyiaqEguuqMUljnxjmtMUItm2MvGazLVGIsMV6v0TTXBNzUlv7mnRfD7TJ3z+4eeSeSE0OjhXDqRiGkQRsMdd40wkuKtAvjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4169.namprd11.prod.outlook.com
 (2603:10b6:5:19b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 06:53:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:53:34 +0000
Date:   Wed, 7 Sep 2022 23:53:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <6319916ba0f9d_5801629437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
 <20220907162245.5ddexpmibjbanrho@offworld>
 <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <YxlxAFgW65w8wgPy@nazgul.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxlxAFgW65w8wgPy@nazgul.tnic>
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b3b0e7-09b4-40f0-30a9-08da9166d949
X-MS-TrafficTypeDiagnostic: DM6PR11MB4169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmbv5Nh4Rg/B2f2VP+iwAppXJq03h3zSxNLehfawEdb6x1pqyWXagodbGzkjFwPJYqGJ2TH+b7Ee/2pa5yslJAn6LJcMS0ZtxVZEaXpucSGSCYNfkLhBIlx35RpWMw0FViIIQnW8lbKgS1aHPCeFLL1U2WsPw5D0G2rLRRsyDDwcspaJaYYu8U1WKA4F6xopkOMgTqLIHbk9SRqR++BPwTa5NIlUn+eiyk+4T5OwVFpGbbLWpxYlSmQIESoq6xC2XZWxU5CSH+40lA+Y0kg0p/oQxc2EjSlHYaxGSCxG96I3Q+syY6tiDVuP/dAi+0Ax8i5Cu6gZSU73AGxb10Yw4nMS0ldd0I+xPznGQKT80NNDeNAvCu9k+sPDYoam93fmKcYMwxVMQQdzAeqFFFP7Nxn0NtFS2rH9WcAdOCqzOeNBL1qY5ZQm2XKj9FIMwnEgmQmf1W6fgFrpRd8FabpPwIG9XNRUkj8/JKhhKnf7cwxT2TiJDtZg/kHptCW2OUqC4RSUOwrN8RHuPLS8AsUIHS2a/CkI4zpXjCCepwV6YwFxlQ3iKH/iTnNq+/LUjcFIaNBc6hxB7g+hgHjHaXZlBpZUncnFbIwJNWbP0RvFalfOs8JfShwsrfewb16Hkz7gejLtM+L/GIfOEFzGeO3Jh43wV5fhAz7Fc1khqZek6jiShwOz/WJjSGFvo+y4Ga4uXZtQq1MXTMsgK91KqNpTKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(366004)(136003)(8676002)(4326008)(6666004)(5660300002)(2906002)(66476007)(66946007)(8936002)(83380400001)(7416002)(66556008)(110136005)(316002)(186003)(41300700001)(478600001)(6486002)(6506007)(38100700002)(9686003)(26005)(6512007)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pdo1XfDaeVA8Lw7hCHwWA3FkCFlfQGNzPfCeSfVAhAQ+yPLUyPiHAW/E8k86?=
 =?us-ascii?Q?O0y+ZNV2+anN59RB/UOJDR+4teC9ZF10VC0p1IAo3z4cAw8ccf+M4rKMcn99?=
 =?us-ascii?Q?ey5d1Q2U/ti20QgBUQnRbtVrwoIytfU9KkspjolYJdr1xAssqXQu7ciI2QsY?=
 =?us-ascii?Q?jMvYu2BuN5tF4FnjNjXOJDK1uOCKH4lp4EWLb3fsgT8ReWFw+Vny9TEtRjf1?=
 =?us-ascii?Q?Qqi4f4HM3ndnzZ4VNChf5Ml4gsYjAnGntMz0RU+jdFOhTqWrt5HjSPGEldLV?=
 =?us-ascii?Q?bW/q+lpyMcZwK4bSUZiI1iSdHzYZjHrya097nRSiRxIrSjrmiFwn/fscdyZp?=
 =?us-ascii?Q?gS2S9LeqaduWWQL4WGrJ8eW12W/a7KoUvEQWQC+old5RJvHRsm45Br2qGKCZ?=
 =?us-ascii?Q?nF4+jYslc6sbpHGkb1moAXGlxD7a0nEM+Klg2ErUGZo4SHSosQyggV2KC1Os?=
 =?us-ascii?Q?FNLKR9s0umco1Nhed8HPuvYx8wnV6XlLN5blJWq3D4Vqvf+Em8+8yG97rVAa?=
 =?us-ascii?Q?Gh5CM1Pfe/cpFJZr7jScFuFVPaJiEB/OxotN18fR7Ayv0oOgE7HathadZveD?=
 =?us-ascii?Q?kRftIRZnYz/EpbOjxrDmTbKcK9tj477f61ysVLfYNFZYdpofeQ8bxfhQl7U9?=
 =?us-ascii?Q?cznZiP8rwlqn0Wl3xJcP3976bQwYDhD5kuTQBt8VZ1xF8iT5PM0ILuVWIUAJ?=
 =?us-ascii?Q?bVlxJo/Rj58pBdlVCsH6K3/gy8bd44OWOPbgUaObTzHI8YJBD2nGoH4t3Ozm?=
 =?us-ascii?Q?Z+8gB7z6bfOqbl6H0WW/dmTFOT4WukgayBKrY3zzuAft0/ZDCOSbtc0wyVkz?=
 =?us-ascii?Q?r1hx8igGVK6yhua/9A+Cc/csqZG87ivhRiZUoXdQ+JLH8Sju5RKCtGlQi7/W?=
 =?us-ascii?Q?FDG7xWQcnt9p1HseX58bIDWaOcrfo8zJiOOMe6xiyQBv8485MP8ZK7xJBN2s?=
 =?us-ascii?Q?tgcTukVLxmAdc2Bm+rKX5XVvmDkBHzcrvH0Ehafb1rVIbTPs3GLAHyv8JNmY?=
 =?us-ascii?Q?/eMUd082YftftaVhuxMYHum9umJ3b2PO3hLGWYY7JqNUYdQm3pfP3UqH4AP+?=
 =?us-ascii?Q?xRyEXR7qC1cdWGy4VqkpNycO02mO2AhtrRLJftnLTcD6TU1aSp+tWgTcl6aD?=
 =?us-ascii?Q?Cobi3Z/fgC1gPe8owOCjR31VYaVixLrHm4oNPpJ7ipkexbRNpOOIlL8+sNDw?=
 =?us-ascii?Q?0DIhiaSCBDrkbUuD8dXk/uNSK5EnoQgZlwH7aF/th9TzHV6UgA43srnfQ7IN?=
 =?us-ascii?Q?Dh51mLwjiW639sW1LXrpWcdSXkd6vQzq3KH71hnqzDZTXf9X5NtyvRjZv/DW?=
 =?us-ascii?Q?wbH08YtKtAg6KzhkFK95Qy0MeVrv9gxL8qJQYUeWf+gFUW4COEOulFj3PFKM?=
 =?us-ascii?Q?DdU8dCVimBLANXm+aqSA+IeqoXDcr2VRZHRvYPHJjVgJQq2aNB3TNlS29V8G?=
 =?us-ascii?Q?vR3DnA9SSj+XUAwO+wm+5NfdFyi63gjVfzesiD/J1G9N7ud04g+s4bORKawF?=
 =?us-ascii?Q?Iq3+YEtnZvXYDqqob7Zd4L57AnO2iLm8fzHCTBTzpdAxsdrk+N/K381ccBiq?=
 =?us-ascii?Q?LUzNxZoLgcvFPBa+VetMvuJ3JB01gW5++jpwRqIC5u2hr7VCVejpXzmI/giR?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b3b0e7-09b4-40f0-30a9-08da9166d949
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:53:34.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG6Xk11/jrPs6pZV4OEfB3RcJhQPS7+k7LxKUOi3Ckk9j7G0Z0WYvFS3EDJlbiESsWGNvdY726POxCzx9crPLBlxQ7XSuOhWy0neZsCgtKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> On Wed, Sep 07, 2022 at 09:52:17AM -0700, Dan Williams wrote:
> > To be clear nfit stuff and CXL does run in guests, but they do not
> > support secure-erase in a guest.
> > 
> > However, the QEMU CXL enabling is building the ability to do *guest
> > physical* address space management, but in that case the driver can be
> > paravirtualized to realize that it is not managing host-physical address
> > space and does not need to flush caches. That will need some indicator
> > to differentiate virtual CXL memory expanders from assigned devices.
> 
> Sounds to me like that check should be improved later to ask
> whether the kernel is managing host-physical address space, maybe
> arch_flush_memregion() should check whether the address it is supposed
> to flush is host-physical and exit early if not...

Even though I raised the possibility of guest passthrough of a CXL
memory expander, I do not think it could work in practice without it
being a gigantic security nightmare. So it is probably safe to just do
the hypervisor check and assume that there's no such thing as guest
management of host physical address space.
