Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4657D7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiGVAoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:44:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080695C1C;
        Thu, 21 Jul 2022 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658450656; x=1689986656;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nKh/ft1BV4Uc+0NERv7ztSvptEyqgq7t2bWk8rDiJvo=;
  b=hx7BS5pOZyqX8A++bM5mK1aGnPVuxy7bd4UPi5IG1WvOHxZqsBnd9jEw
   FchA6Lo6u+1YjITG6yzHQgHWn2DTuvYg0O3FxoR14J2sQT/9ukH9hLDHf
   XVD5kWKSOXGo0S1863rAlpVR1fDFVNcAd277zwgxQ48oXhjMIiLIAod0F
   VNRIfo3RPIl4ceBCQg5nb8eVFhre4KUzHueYfawO3WGNUXjIxNTm/BCe7
   rs8G82NM/qQzcSsLroD7xq0j9mQjfjnjW5TnERUqVo5I4zgAhrsK9G0Dy
   0GfNVYkU/LhOt460QpQlrBh384QUm0VctgXXdnpl2ZcF48AST5mjvw6vP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287961789"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287961789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="925870120"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 17:44:15 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 17:44:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 17:44:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 17:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvdwYXwDGIYfgqAFjzXq+eQ+FTpUIhdXk6WCkjEBPtqwvdRliUKHKz5o67zisiu9+b6mBDu9aJb3lsN3ZtU2RwNzRRzNXvhJkwNNxGRepp6oCyu43yJb0RzOuMNtshx0bY0amFiZgMCkztuZkQQzdcGoNYZo6Zd0Qv96g65l0u+6fDQUF0INiAOtwLCfZBWmFWSRyZt5WSXj266Z/iA6+A1fYT5H4zpvj8WS2p07kfNMZkA8XCM9lQilUlukDNdAPNVNfct9tm636Jcb4FhXVG4j5A4l5OQTnM/3aX1jTkGOBfQ2mr71MtRt4lPek3dSxr75YE2Qg2XRZhjd+2llNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VnJHRfqZVPvF7hkf/abWVhUf5gBgglVBDsUZZK1Mvs=;
 b=SGx54mtxttmx+1jknuGH3tUJg5dtU5QrRjkafLn+7ciFinwXTXl7ehGXWyZYy/55UnhkYS11t5bTtCoEySaW2+YHGm9xidX2ajZ8IQ9+wt/BgWucSlNJuk3G+lw4kO/EDrsLg+ODtjLnv5fn3B3y/K0UuGmuaSNdLNmxfDq9hmbN4esbMsCw7mw5tF94HD+1N7d1r1agV2eqtleQt+9kW39o6ylPBbyP9Ga6N8Ic8zDyvmcPIEKg1zBpVU1Velkl4nYpVKAXvJvowKtwKRZKlVqC+/E/jJJ+2A8TZttpnOQO1/BAGwO4QzwWu4YTZrdkO5OEc/p2d34pDJk5o6BW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 22 Jul
 2022 00:44:13 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Fri, 22 Jul 2022
 00:44:13 +0000
Date:   Thu, 21 Jul 2022 17:44:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/7] Documentation/mm: Don't kmap*() pages which can't
 come from HIGHMEM
Message-ID: <Ytny132kWjXvu1Ql@iweiny-desk3>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
 <20220721210206.13774-4-fmdefrancesco@gmail.com>
 <87czdykw4j.fsf@meer.lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87czdykw4j.fsf@meer.lwn.net>
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1e293f-b8a4-47f1-fe0e-08da6b7b4c47
X-MS-TrafficTypeDiagnostic: BN9PR11MB5258:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etF3lujgWrXWnJZEkzAyOEHXBB6vqVLnKe2sIBmOMJPq9vjPkuWoO6BTjmAv4HqmAq+Bb7vMI6kLT3g/+S3J8bBzH4BuhQUMgqklCAZQy1eDf/4FtBz1p3Nv1D1FLrWyJoZNYOeOQ1UOVkr0X9pHyk2sK5iC2uZXhnPRXThqh1rEb6ewE1CpvJyWRYffQneDKRFlv+oW5Tkrx0imJpxD+g5sJU7QDi91l95YWC3rbuF0Rmjs9kur65tzb/l+YduqCukfiSIQVbp285PoEop5GVYhEZNClkPCctWAsBoNfhbHhFA0fVZG5tKmGa9tdi2lSEkjtTU7pUGuVH0Berq+ILnsSdIgNfsnExV+rFQHh3yJTy/fkyH072Th7g3qYNBTkjtoTPpvP1RNPjO1Rm6lPssWm42Va+tZKqBP1cyViLI/MubjzqkIq2lLOlvO6hqEa2tCWcLC/0v9pvSnrZQkmTMCXeQbTcIJGEz8mkHePBBgUoAjLJWE2Yl3R/0bmouwnTnZSLxnoiS9a7MQb9NJm4qq3rISOj3BvDGNeDSxeQYHrqaa/BL8shvS4QjGGAdXW/Nnqbt03YWMmWbH7mSm0m2uUGSGex8dBW2Ocgw1f2gLbvj52OjAy+VH7VE6QXFPamEhHuTNEoo+jIuPdRu/Wyz8LtoHr9eNz5hCAyQ24zamnXsqcf6+8dRoMoXzmR4FZ8z8l4jEUo5YYmzSZlJwDygyX9CBBBTg/v09XyaJS9Fr0OI8zxpxd5lvZoj6JUPEZhTG+vgWtRdKhAYAudifkEk21jUpFvYPtyb0cCp6U3l5rNfS88s4BC0JPIQ4GTmi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(6506007)(41300700001)(7416002)(6486002)(54906003)(478600001)(26005)(83380400001)(966005)(186003)(9686003)(6512007)(33716001)(66476007)(2906002)(66946007)(6666004)(66556008)(4326008)(8936002)(8676002)(6916009)(44832011)(82960400001)(38100700002)(5660300002)(86362001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCrD9Yawli9hrlmp1y0AAosvBoeyKNgO0Rr38XteiQ3RpZbIR/DI9CXCzpay?=
 =?us-ascii?Q?3JuvmeQiZx9o5Ha/Ha5ksS3SijrLcdVlOfW1HcsKWjSAAMIQj6NDwkvZjO82?=
 =?us-ascii?Q?db5MRiHOkPujQGF54C2T4i08QImkPMVXjD8d5hoehyh89BMBQNqBWL3WlDLK?=
 =?us-ascii?Q?gMEocm0BTM6EiV7HPFar67wmSuezAh34dlicmpLLHWqhso48P51IzeasGsOE?=
 =?us-ascii?Q?VAJq8xWTllOrqbHRZsYugeEwu6Z1f1qFpfhgh+70xvW66U73MwqizGnEjnk0?=
 =?us-ascii?Q?eoH7yB7Ex9CZX/J/vqyDNwa8f/ko0g5kbGfAPGmaUt4ZoEMpg+RatmczXgbN?=
 =?us-ascii?Q?CaCoxdJrMvvf/lWirzB54BPDmibuhyR17vpf23VJu4h4PMawuSmbGHPYF6eI?=
 =?us-ascii?Q?hd/5NZcHLgSpxIvzJVtNxBWtZMUHTB5ZAZg2fHPX5pkBt9DKt4971ikD9jXi?=
 =?us-ascii?Q?nQryVp9dYtMFRWzaikdI2vo55UUZ8Qxl/9ZZchFq+Q57xNWKFXv4c2bzhMJQ?=
 =?us-ascii?Q?Oe7o6+wpOPZ9gayTF26pS2ahq6t1hH7jCmYEfsdTNjeuD5O5VlvhtoZqBztS?=
 =?us-ascii?Q?7goI/EvUPIHiiZC9DwVcRTQNmX00AkT7eU/UEUEDJTbDnFduqYbkPa8bXek6?=
 =?us-ascii?Q?S0l6vMJPTmWP3kM/sJ0usEpAg4bjQPEAGbzZ8zi2EFORHCQBzAm25mQVJz1l?=
 =?us-ascii?Q?e4ZufkOHkkSoSzNOnowzRgBWwvSpV6L8Hm+1jqQ5q42LYXJovjNm6s/wF8ES?=
 =?us-ascii?Q?++GqtvM0flHJYIAwWFE55ml94kZws6lfsBBn6NuQBgwqr/lvg/YJWdt8jGib?=
 =?us-ascii?Q?wmij/xqjpSNllxxOy0XTAjfrlKxJGKbadCjx0eH2Giwm/0vloqpT3ay6yWh8?=
 =?us-ascii?Q?RmL89neRU3q2vntIDBeba8b7VlcHM3LpZ4vQu+MydbN+X/zvbUjImXrBuvcC?=
 =?us-ascii?Q?ckN97Itd6RT/QoFmKqO8uagfUAAmoLE44Vrc65SHLGzaA3rcr6K4c1Mi32Wi?=
 =?us-ascii?Q?n+tmJFCgJwYyoxtYmW7Zo+ScZVeHz3nIS/TsVOI1qas/gMmkJaJ3zsYW+GsT?=
 =?us-ascii?Q?ZurVzP5Z1+mkda4v4qtEEfZF53b2J+4p/W1kRZNIFPQHRiDVrBNQD3NhcQNr?=
 =?us-ascii?Q?5gfwfJKcYvg5CVu1tAHvTtH0iqu1fcq/nnIR+Wk2OGxhgAknWXydbULA+y6B?=
 =?us-ascii?Q?SNhBt/bysUHdvX/OIULhldnsgciSeeZeoutbTKyKv61HHIxmle9m1p0pKUJU?=
 =?us-ascii?Q?bAVRgGBBbKpwnvSc9jkauKxIZONzPe/u8q0fbMfM2c47iURgeslB4eLLWwRg?=
 =?us-ascii?Q?OxVK2sQoMzkPtSIajHOZ3wjBER0IU6wVQwGaHFc8JxrT2jRDvu2F3X8dOO9I?=
 =?us-ascii?Q?l04h4hilwNge5yW9j0Ci8kTEGDJ70B2ihHEfnBnrGLZIKJMGDqRyRm/U/6/8?=
 =?us-ascii?Q?HpwGNqzk9ue2GgQfUYA+U/C03pTVdVcWHIAa0llgwYOSVOP21bVMvhvvYmj1?=
 =?us-ascii?Q?W6Es9JP0RlMwiM9ezoxpY7/KnqIpC8e/T9wLrJylpTFpggNozgVbEz0PktZt?=
 =?us-ascii?Q?7vAJMpC09jpSxChnF6mu/6B+n6Uq9J+YpGzfptYa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1e293f-b8a4-47f1-fe0e-08da6b7b4c47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 00:44:13.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6a8txGkm1OKJKo8uwO294v1tkbPw/ZPT3ntSfGx2IhrDWzxZULopXWvT09CyWPc2Yp3zd2kCObePs3w9cPhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:13:00PM -0600, Jonathan Corbet wrote:
> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
> 
> > There is no need to kmap*() pages which are guaranteed to come from
> > ZONE_NORMAL (or lower). Linux has currently several call sites of
> > kmap{,_atomic,_local_page}() on pages allocated, for instance, with
> > alloc_page(GFP_NOFS) and other similar allocations.
> >
> > Therefore, add a paragraph to highmem.rst, to explain better that a
> > plain page_address() should be used for getting the address of pages
> > which cannot come from ZONE_HIGHMEM.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  Documentation/vm/highmem.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> > index c9887f241c6c..f266354c82ab 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -71,6 +71,12 @@ list shows them in order of preference of use.
> >    kmap_local_page() always returns a valid virtual address and it is assumed
> >    that kunmap_local() will never fail.
> >  
> > +  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> > +  virtual address of the direct mapping. Only real highmem pages are
> > +  temporarily mapped. Therefore, users should instead call a plain
> > +  page_address() for getting the address of memory pages which, depending
> > +  on the GFP_* flags, cannot come from ZONE_HIGHMEM.
> > +
> 
> Is this good advice?  First, it requires developers to worry about
> whether their pages might be in highmem, which is kind of like worrying
> about having coins in your pocket in case you need a payphone.

This is a good point.  Perhaps this is better worded as:

	On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
	virtual address of the direct mapping. Only real highmem pages are
	temporarily mapped.  Therefore, users may call a plain page_address()
	for pages which are known to not come from ZONE_HIGHMEM.

	However, it is always safe to use kmap_local_page()/kunmap_local() and
	access through those calls will be as efficient as page_address() on
	most architectures.

> But it
> would also run afoul of other semantics for kmap*(), such as PKS, should
> that ever be merged:
> 
>   https://lwn.net/Articles/894531/

PKS is yet to be merged.  As of now, there is no good reason to force users to
use the kmap_local_page() if the page zone is known.

I believe that beyond PKS there will come a time when we need to change the
page_address() callers but currently this documentation is correct and does
allow callers to optimize for the corner case of a HIGHMEM system if they
desire.

As a reference, the use of kmap* vs page_address() was discussed recently in a
couple of places[1][2] and I can't fault the logic there at this time.

Thanks for the review,
Ira

[1] https://lore.kernel.org/linux-btrfs/20220621131521.GW20633@twin.jikos.cz/
[2] https://lore.kernel.org/lkml/CANn89iK6g+4Fy2VMV7=feUAOUDHu-J38be+oU76yp+zGH6xCJQ@mail.gmail.com/

> 
> Thanks,
> 
> jon
