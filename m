Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032358A44E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiHEAt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiHEAt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:49:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28D50196;
        Thu,  4 Aug 2022 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659660566; x=1691196566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xCt8tVLkDXdDsM9H5nJJciDvVUnXT+SwV+SGzF3teMs=;
  b=GX4tfKAuR5JYyR7wQ/zIh7yApaQugc0/2CFxNPBu4EFnplgA8KKE2L33
   J/+4yLEkchBAgo/ND7sNHJCR2YpNfVUFFJe23uCxKT+stA1CkV+CarDIw
   TH26SKpyGGNzrFogrQlypXdp6pRfaMVwW5afiC5yCSRi+0hZbCBayryWr
   AipiwdBTYtmobDTCW0Bxjqv48JKeal1m2PP5u46gwxIGYkc+ojKVyUlBO
   Vn31+YB7H1oochrlJE6C6OwW2QFUqfBRR+7xr60Fp3BQBKidl7pQ6yUsn
   qNorNm9aQXUPeU5X7LE5JAkiTKsTxS8jEm9dHkB6OMOl+K2qIY/EzVuha
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="376388188"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376388188"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="692838273"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2022 17:48:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 17:48:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 17:48:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 17:48:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 17:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAa1p/SNJNb345pmui5HNCNivQzB2MaGw32XX6DB73EN+wqveciV/vQLNgJWg2mpEfSLZK7Il38BN8vkvaxLA3sVFXxNtl8py4H664KJTwtO2+nsIi+m/nbUjHORERxiDkWwkJd1gB8SaA/JqYp0Pi5iwNk0K5Shq3uweQ9kASyM1VvJR84LNytMceQUwmfEzB0wy+m5eOxXbwo+41Bxz0QWySKMJG3GcBO1fuWjUvp5j/TBPXA/zaVSOzcDAKWI1f9it1qwZVjLarU60LXphwNaSuUxuVAYVjSzjspj4ENIVe+MRIbRCFGMLQYAWYtsSy3P7ItG2tvI5FEc3boMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHnhwf0vbIQ0jZ45KqYVQMEWXNl7IxoN6z6xYmLP0fc=;
 b=RZ1HdF0bPgS/c+xhgNcVtms2bb+o9rakSg2r4obV5cRmUwHgF0+qm6Jpc9/R8tT8Z7vENGRO2PWJSNFgahWlI1xrWlvGhd9Asmi9Wql6nupMsya2IEsyx/x9j/xuGZ7hlSiYTKdvtXNcPsIiMw5U8+1kWkZEaDgfV/nYpW2ppPTuDhBDKlD5rKMsZONZk67gXIcrv/2u+MBpkPfL7Oene/rhEK3nR4MSlVXnuuAtfwlHxko6TqWN6gfMPJ6Tue+tBMyxx7jITnNm0OIDZGJ3m9VP2+JiQaHM/Iem+xg5G/AA3UEq6yQ1jIRNpKab3CPdseMi819I4U3khgcTuy61hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6209.namprd11.prod.outlook.com
 (2603:10b6:930:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 00:48:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 00:48:15 +0000
Date:   Thu, 4 Aug 2022 17:48:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-next@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: RE: [PATCH 0/3] cxl: documentation fixes
Message-ID: <62ec68cc4acc0_12f2222941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220804075448.98241-1-bagasdotme@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6af5c3-ec76-485c-243f-08da767c2e17
X-MS-TrafficTypeDiagnostic: CY5PR11MB6209:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0NXM71/IkaZY+JoPBWppsmgpRaUKK77fgM1gSI+LmJ9eRAJ32x6JZTtvdl3voQp9jZfHz5yLn0SYvruTHpYxW+En+JyNLddx2SlNizuCRGachXSa08syHCySCoVCSzf0JQat6XF86Vr7UYkb6wZFoS+oHEuBZ6qzbJCTrqKU3a8nIW0END09uJrXV441B3YQhgE+/pAIxQMOkE5ny1jaHcSjfBUUOR17mxwPIIIssclyUxnAn1zmKmGbLdu46CwYMmF/FfRuvsf9yT2JXb36NzE41utSwbfc3Yg4UMPW6hKFmc2r8pl1XRQJfb/Rg7Pc7h0fFeCOkQ7xdC3jy9diAxjyPZKSrCSLczYLm91JEtl7u2pb2SfST/Karr34SpDFyTAhVfSfpruqlzLoq0FCEKDjC6olL5MwUu26NjGK8EoNmL3HZrfFK5dpNEfeSUmgXiA/Z3EpYzRE5s6s8XLrOROWi8yy0VkfLmccZfLZZt533qaqMt5hUnZDyDnWJVt8vPQEAWYUIgYrG7ijNRgntPaZ8OKAgvDMYgmJnHIzvnGh2ZuErelrtaAbh16NGYAsZ5wCEomZDqv+tvCMcu/tDIQ7syJa2iHjHSObjJw5pO0ggkSGKKTAczPkVY+QO51tk8Yb/8e/Kt1wG7jrb2p9FMlSoQOV2FGU3qKpYBp7xlQhNtBwxZVb2T5Bx0tRvHPE5sMylxmG+bjMl73IOgVU0giRuq8v7f6uuOwgVdZ72FJfGs5FBfffh67BsVj3Pr6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(376002)(366004)(4744005)(478600001)(316002)(6512007)(86362001)(82960400001)(54906003)(2906002)(9686003)(6506007)(26005)(8676002)(41300700001)(8936002)(83380400001)(66946007)(66476007)(66556008)(186003)(38100700002)(6666004)(5660300002)(4326008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VrwGI2Eh34ZtN9UyFfNNHBu+wb7XmCK1se7WslnvJg9BdPVbdS7oXb3QY/8?=
 =?us-ascii?Q?iZsYhc9c/7UjG3W5RkcEhCxa0bEegkpE70zPitDRgYFcLPNeexvlNqWbZ2JE?=
 =?us-ascii?Q?ec9HtIHb8ithUuxJTXm7YLN0I+32Q9lnb8ZyzTb8gy6FmurERRkorbothb04?=
 =?us-ascii?Q?nOqFCR96Yw37UbvEG7ic+C9u/OjLf5UEhuazFuuJvcN+AkTOWE8K7wqH3chR?=
 =?us-ascii?Q?ejGhQkEVHb/wKNT0aFRlce5ZE5H4zogDasdI2FawyDGmkT/S9/gDyPcudwrS?=
 =?us-ascii?Q?MLVk/eRkMXhDDgG9zrKwqOcf+++/1wqV/d8jbigZNrZxF/JWhiOnSkZgbqx2?=
 =?us-ascii?Q?Lt2+BnzZZGg0zYspz0HijoyEuP2sxGk0K0UYNao/yE39H6iWTLvt+zSYIh8S?=
 =?us-ascii?Q?had4xnQtGg776EPWT/u/ra0ExTjl6qbahVcBFPW0C2cwNK1OsyEKdSXuVtBE?=
 =?us-ascii?Q?wOyk+wXw5zD8buZOMoG/JjItXtYAlo9e4udG4YtuaVQXsVxpgvyksszZevDz?=
 =?us-ascii?Q?6wfNH0ghVIdRKZSOoEDBBArk3K/YgPynU2fGBgDsYJC5vWT/sTEtNrQtQnGl?=
 =?us-ascii?Q?xF0OQFLYFwSVRIPhAH/RBMPBGSvEb8IpYFZj7yk7FR8U5tRyBmkymPc3VbAg?=
 =?us-ascii?Q?DN3S72zGnfYOy/y6xIGbldWep8YnhdfC4sG9QVa9xDSfidKhbPCqESDwHTbc?=
 =?us-ascii?Q?DMaGNS85e4GO87WQoyZwqfskp46en2pXKB1DUSZoFvFXuj0OlqdkmxTnr11c?=
 =?us-ascii?Q?ZmLd7QedO3yyRgUiV2VqnZhoxBcvPoH0BifDXaSgM/zfGt0lhUYzV90ThseO?=
 =?us-ascii?Q?E0wlMg3qeuEMHaaR0NzACwcCnW8mJAuaXrf1y519x9aXw28pL5C5R1RJtnrF?=
 =?us-ascii?Q?luUhNsyMF9v3+g0rEDP5EYqrvqx/tM7psGs9OSqMNNc/T77fj7z3eIEahKfs?=
 =?us-ascii?Q?Rr4gFTAB544eN5Szhrj0Ho+Bj0rEiwvxeBpxikPygyxjtxuQUJmuabAO1uhU?=
 =?us-ascii?Q?VlM9Uri0h7gPd6AqURxpQZ3jsY475G86PzeO3LyRllBGYtPFt/1Gi/4uwZ5d?=
 =?us-ascii?Q?9w5sX0v+D1JntGP5zrQ7hpLONdJoId2q1jU7senVa0QZVSX98hAxNp989OKO?=
 =?us-ascii?Q?lu1eWo6Kx80YVwqMqwbbzQT/ydLp5HY1pGVNOfpN4ZvYCKRQidPCvAJvDFmf?=
 =?us-ascii?Q?WWwvCk2oFbQuetduP/ikEoZi1D4f9pScXI43rVBcUBB5Fn53v6+6YE20m0xV?=
 =?us-ascii?Q?lkNYw/ZvpQgox7eq1uwspQ8YXsjH3HEKMFlVJ+8Ay+39CBx6uKZyoW7C6tWe?=
 =?us-ascii?Q?5+6f2H131IYELmessIWE0QeMZRSMrRTqTbjAa+tIqIU9b0P/fVV/eCM9MOwG?=
 =?us-ascii?Q?ioSjJzLdEurSXcNaf9d630PvR2nyQU8TU/OGhFyaCLgtk7yOI3YO4PRto+I9?=
 =?us-ascii?Q?o6KdrnTX7660Q+GnkFfLgID4rlgOZm3cr9zA8K/L3FpcoAl0vHzbL2xJ+vfa?=
 =?us-ascii?Q?fYEMeXzV8ok1ibcu11gxwY9bm24/GAsq9J3YkbRaQATS+ME5UWVGykCVeJKH?=
 =?us-ascii?Q?HDZ5bk5B/9PI9NhMfKCI+7iLd7I3gMd8i5+1urDu933FsV3bLMcjmL0u910u?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6af5c3-ec76-485c-243f-08da767c2e17
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 00:48:14.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfSdNW2fOZJViJStptvQK39BuJpZV0vFVbjIlan9+0uo3Lo8nh8wVYr7k1XUtFlQIcZwqiwiTrjmySWyBy94TImK7TfBY6dFe9N7w494CmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya wrote:
> Building htmldocs on next-20220803 (for which this series is based on),
> there are new warnings on cxl subsystem. The fixes below are
> self-explanatory.
> 
> Bagas Sanjaya (3):
>   cxl/regions: add padding for cxl_rr_ep_add nested lists
>   cxl/region: describe targets and nr_targets members of
>     cxl_region_params
>   Documentation: cxl: remove dangling kernel-doc reference
> 
>  Documentation/driver-api/cxl/memory-devices.rst | 3 ---
>  drivers/cxl/core/region.c                       | 3 +++
>  drivers/cxl/cxl.h                               | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)

Thanks, applied, and with Jonathan's Fixes: tag fixup.
