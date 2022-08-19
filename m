Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0C599629
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiHSHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347102AbiHSHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:40:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6B1F2CF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660894859; x=1692430859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=33LJGkN7Y2fXeUbnJzgYkXqsUHf3To+bNBHWLDByKHI=;
  b=UfxFtuVOkiFwPlARCSaRU5Xv2ll6sxuduyA+MIC8nJ6lvOxuR43EpvUj
   Um5AeTiyKZK9d9fkK3uQgCh9WtoOVZJ+PjtRZAOXckoB9zXOSWhND4cyO
   O1KLe6O5Zn9i2oYMWMRUr6jJMQnPXE0WSvANSLvrgKTKFrb0Up4i+iXpp
   Xcy6R/uqcKefUeWHdqyEOoWLwTlzSs/exhSfu7sYyf5y9GOaj7V14jOly
   yuOS18tnlBWUtZD7awFeYjm6uQIdlBkZFu1KKlSA0csa/Mcai8k4DMQGS
   ejfH+IRwiSXmxxofvwOgHsXSQQtDiKNf6lgk9t8o8DO+RFqpaepRqrstd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="379253204"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="379253204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 00:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="641169079"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2022 00:40:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 00:40:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 00:40:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 00:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm6bePcKIct2SgDdI+k7PprCiSqfIJK4lWJmxQvxwdVpwG8dWPa0SUbH/ZZSXwLkk8bvZtvBcQveNZh8/JfUxrN2+f4NH0vYalBoIktF1Fc7q17RycjAfe7ZvRAs15Uu8ii+J5nK+rEmYA02yiEpSTZJ7ue89YABLj2RsXinjnskSoS5Iy1/9d7bC5WnpAYdeqBHDMHzPBx+eQaDlxE9ObO0cjQWz6Zzj4N5gpiHrK+4lbpDOj1YC/zNK6lqZUKTyUtsD2JsG8j7o2+uS99aFv7fs0YfOwmd1/x4TDNXcNeaDC3clbzyuw42qBZHBvP1ZOKkHEo0wyrZlcMMKZnxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDUO8Z5LhALV9UKaxE3yyQ+7hrjn9+cYBnkzADB8PDk=;
 b=joOTrJP+lzrWG+sarGhfQXI79UOmcvTMI8+wH0F9spqhBqncqLaPkqajEW4L5blDRZe1WeM4ShP8ZQQL5hScvwofi2LFIimLfY0bAHrhMbulrrp0R7TN73zlg1wL13Ay7gruRoMZL1eecc33hkQaVxxxkk6DHoQCL7rus99x+TGmhP5bZUyaw7UEQW0r7+kTWQ6hDoxOavsqi2IkWIfcwhy7iJ03DG5TWzVPZYKaEZNdZ3XPddbP0f2HFwZatILa8o8LlgA5iJ/u5YujQZzIAGmRSbFb6imEFXu6aJVp+BTWzP+R92GcMWQzz6yLegujoo9SLavjpsllFYWk/7rI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 07:40:53 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 07:40:53 +0000
Date:   Fri, 19 Aug 2022 15:40:31 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Message-ID: <Yv8+bxiZ8+Rw+wu3@ziqianlu-Dell-Optiplex7000>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <CAC=cRTN=vbrgOsH7PNNMV+Coyabp=H_XF99MUL00kfET=K-32w@mail.gmail.com>
 <578084e8-bdc3-6e4e-f390-4202a8bc7c1d@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <578084e8-bdc3-6e4e-f390-4202a8bc7c1d@huawei.com>
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c772bd5-7173-4f58-5aca-08da81b624f5
X-MS-TrafficTypeDiagnostic: DM6PR11MB2876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhI6ufc46KehCYTtzdkP6fMLzGOmunQgVhJarlxAAgiVwInFI7BQ5t9HEJsYYZK4ODi9PiWXOwq/PCDsRfV8SGvte7u1PBRblstCH/FHvzUcZdbwdjOkRj7+J1GFIcq+XiGm3TT52BBqFUYxX3BQN4FxLz67AgoEjjVdDcgI+cQedqSzOv8/HNIWzC67ehwLj2y9VmQhmgoY58J4P7jYPljpP2hpYvlPVIEJjTGBAajDf4GtqVS5wBkEgAXDHMbSuwEagYX7lxBlJB/LiR9AvG4pKFdkWlBF2e4VzWAPqXkBontbB5uBNOkdvZCEOUsTIsW4sLbpumsXLu5evVNsvLgworxCpMUs9b3fMH2VsLby2ZuBQmVO3Eftz/dIV3pXZV4BzAuKw3+RtYfF0gQNeVXYsFFjvlfOueaCpUlSJA/GszW+Tu896j2BZYbitcpHSWfUrHhzNZHR+YFgP/6rlWsoGpquKXW0zR9CJ6GmCZqIoQnjmlD6NWsD4AEL7FmsHK95vPVgDgpHjGfnTe3IGEtwz17tGTCv9N3WZJP4PgYWAtb80LUQ1302bu9xApKy/b8Pn8cbhS9yh4IMGqIW74bqCihC9UVwh3/BXwPCdUnU3yMZsGo1UIS4qlt7mCqVVPqKY4hmo5qk5YEWnrx4GpX4X/BQ15cS+nxJqpDompoeD2m9TAt6brRbUeNm29ZgGRKjA3oF0M7F682J1nqYMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(5660300002)(66946007)(66556008)(186003)(38100700002)(83380400001)(66476007)(107886003)(54906003)(6916009)(4326008)(8676002)(8936002)(316002)(82960400001)(6486002)(2906002)(44832011)(26005)(86362001)(9686003)(6506007)(6512007)(53546011)(33716001)(6666004)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDVMooLLCJ7si5GBk70Nd1hqhJsXhdYMhvBHjJmtvQ9DrYo+ofcmAzQO0R4o?=
 =?us-ascii?Q?FZ0k8hTgZHHrws80F3m0eMPWGr0f5qRKYYOInKwTSIRE+4H8ojOgbDJtSK80?=
 =?us-ascii?Q?ueSFYKIgRbhhNxclRC8i0SyeABEeSPQpniKsK3x7Af1cpio1sCnM3uKpm9v2?=
 =?us-ascii?Q?q3tXIDTKOJM08UTQZAtk+YYER3iMIvnYaXKItL2JxDTdnoKSWdmn8qmXJ/Ej?=
 =?us-ascii?Q?Hx5+s4OMkssAomfS9WRTYycZmw/rmfKDz5dBC8AUwFHiPzyzUmo9FnwCcc9U?=
 =?us-ascii?Q?CxWMLQUnAJY1spg3nALTN5A+YBKYjNfAxpUTmrkmyQGSwe1iAigkfzv91DNx?=
 =?us-ascii?Q?sQ6Mwc/Lzi03HGKfL/zBS5HoZ4d3YuVYnQEOxltR851cRjEXR45RY8yJ31TI?=
 =?us-ascii?Q?sbL0MrWTFIro8/aV/h6Lr6IMSD9KeaobWbZhp0PZbzpQyawAYi2N+4FDA6fD?=
 =?us-ascii?Q?5uhNy4ppP6onAZ8OdYw5NDoXzdX8WD8Bt/XbDzEp+WSBsxGB2nyUJRixAzAO?=
 =?us-ascii?Q?DkkC6bU9XcEOy5qbA32J3z6qSnyYUIKYCYjx8QDtpzDGMoMNvHF9h3NM4yYi?=
 =?us-ascii?Q?4bXkKi8yN40748md4r25CUe7zOa3Lk21bO8oFgjboostxWEO3ie1SI5P7Fb0?=
 =?us-ascii?Q?boojzorJipUmRb05N2j9q0ocu+2FMXfs2BEw133YGvIqDcOBXG7eLozSfRtM?=
 =?us-ascii?Q?RN0E5OpK5cPzanT5c0oblpzOxfiNCngSl6DNczG0p9ng76mezR7DmT5oXxv/?=
 =?us-ascii?Q?LF06ol9IZAWTJ3+vYHcIbzJZqdczzzSlP8A4fUiTdyJyNr1z3cnTfL3NFnRZ?=
 =?us-ascii?Q?2Xfdfs+h4SkTUsJ3UklEj/tq5NiWJUJicktL403WQbCF9Q0/H5NMak7xrzHZ?=
 =?us-ascii?Q?arhgTYgcEfpIuPAUSxPUdrS9xge4o/mpl8ZdTsfzgo4PwyHeTUFmZY/7jjTs?=
 =?us-ascii?Q?CGzfIKIlcHjO9f7efGDgR6iW58VIR/VIUoZ06QO2hQcvhKXKeRdChhLwiZ9U?=
 =?us-ascii?Q?UzEBWjRT47YKeR3slNt9J4zTpq6NBTVjQftWCCMC4RjHnwz1x5/HKmvOoane?=
 =?us-ascii?Q?7NxqyAw234xNJ42Jf2V9Kp4XtmS9mvoTe1xOayBZdYmPkQOhWKHWsFO7saap?=
 =?us-ascii?Q?xzLZO/DYMoxS+8bpkbU82YgfEXI+1fRbWWEGtc6kCK9bXpkmpygrnYoJOECN?=
 =?us-ascii?Q?Muzbd+2icOhFSiXve339503f2Q4wxci08g9Q35VYeGYOzw+g4H25zwYwpxdd?=
 =?us-ascii?Q?CIR/gT93NVhqGDFiVKeM2wVT42rDCWAPXitKLCnINJYbZRR+aTD6q4i6Zs37?=
 =?us-ascii?Q?rltRoqWfxaktiRUWmQw03DB2J0TvWusxk6+m9VZ+skIo7/Myutgwl9Oz4V1Z?=
 =?us-ascii?Q?uygm/Q+a4ZXzI9o4NQG+fKS2xWFW3XQz4OohNgjA10dEUFkhX7N2WtJ7aRQ5?=
 =?us-ascii?Q?bDg5c93mVvM+oIbG6GvTbv7CLBB6ZlZuwPzZ9pL/uY6uWmgfAhAyVnKxVHjK?=
 =?us-ascii?Q?M5l9451dmpY/VaFjNzXz2AFn5Uzx10/zmisVi1XkPJcHMe/ysDpzFUNg3JKM?=
 =?us-ascii?Q?zC6ZLhrAvoKCumhWbhP107HHfeTXVdCXAwPU8gWG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c772bd5-7173-4f58-5aca-08da81b624f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:40:53.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5vO96HO01wtiSOYWnbYW0mjz2sgcvYfabWNt4sG0+tJodPcMMMOfHw507/+R7EZvgs2J8cpWMTsXdPSAlQCsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:24:07PM +0800, Kefeng Wang wrote:
> 
> On 2022/8/16 16:48, huang ying wrote:
> > On Tue, Aug 16, 2022 at 4:38 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > From: Liu Shixin <liushixin2@huawei.com>
> > > 
> > > The page on pcplist could be used, but not counted into memory free or
> > > avaliable, and pcp_free is only showed by show_mem(). Since commit
> > > d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> > > significant decrease in the display of free memory, with a large number
> > > of cpus and nodes, the number of pages in the percpu list can be very
> > > large, so it is better to let user to know the pcp count.
> > Can you show some data?
> 
> 80M+ with 72cpus/2node
> 

80M+ for a 2 node system doesn't sound like a significant number.

> > 
> > Another choice is to count PCP free pages in MemFree.  Is that OK for
> > your use case too?
> 
> Yes, the user will make policy according to MemFree, we think count PCP free
> pages
> 
> in MemFree is better, but don't know whether it is right way.
> 

Is there a real problem where user makes a sub-optimal policy due to the
not accounted 80M+ free memory?

Counting PCP pages as free seems natural, since they are indeed free
pages. One concern is, there might be much more calls of
__mod_zone_freepage_state() if you do free page counting for PCP pages,
not sure if that would hurt performance. Also, you will need to
differentiate in __free_one_page() whether counting for free pages are
still needed since some pages are freed through PCP(and thus already
counted) while some are not.

BTW, since commit b92ca18e8ca59("mm/page_alloc: disassociate the pcp->high
from pcp->batch"), pcp size is no longer associated with batch size. Is
it that you are testing on an older kernel?

Thanks,
Aaron

> > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   drivers/base/node.c | 14 +++++++++++++-
> > >   fs/proc/meminfo.c   |  9 +++++++++
> > >   2 files changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index eb0f43784c2b..846864e45db6 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >          struct sysinfo i;
> > >          unsigned long sreclaimable, sunreclaimable;
> > >          unsigned long swapcached = 0;
> > > +       unsigned long free_pcp = 0;
> > > +       struct zone *zone;
> > > +       int cpu;
> > > 
> > >          si_meminfo_node(&i, nid);
> > >          sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> > > @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >   #ifdef CONFIG_SWAP
> > >          swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
> > >   #endif
> > > +       for_each_populated_zone(zone) {
> > > +               if (zone_to_nid(zone) != nid)
> > > +                       continue;
> > > +               for_each_online_cpu(cpu)
> > > +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> > > +       }
> > > +
> > >          len = sysfs_emit_at(buf, len,
> > >                              "Node %d MemTotal:       %8lu kB\n"
> > >                              "Node %d MemFree:        %8lu kB\n"
> > > +                           "Node %d PcpFree:        %8lu kB\n"
> > >                              "Node %d MemUsed:        %8lu kB\n"
> > >                              "Node %d SwapCached:     %8lu kB\n"
> > >                              "Node %d Active:         %8lu kB\n"
> > > @@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >                              "Node %d Mlocked:        %8lu kB\n",
> > >                              nid, K(i.totalram),
> > >                              nid, K(i.freeram),
> > > -                           nid, K(i.totalram - i.freeram),
> > > +                           nid, K(free_pcp),
> > > +                           nid, K(i.totalram - i.freeram - free_pcp),
> > >                              nid, K(swapcached),
> > >                              nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
> > >                                     node_page_state(pgdat, NR_ACTIVE_FILE)),
> > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > index 6e89f0e2fd20..672c784dfc8a 100644
> > > --- a/fs/proc/meminfo.c
> > > +++ b/fs/proc/meminfo.c
> > > @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >          unsigned long pages[NR_LRU_LISTS];
> > >          unsigned long sreclaimable, sunreclaim;
> > >          int lru;
> > > +       unsigned long free_pcp = 0;
> > > +       struct zone *zone;
> > > +       int cpu;
> > > 
> > >          si_meminfo(&i);
> > >          si_swapinfo(&i);
> > > @@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >          sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> > >          sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> > > 
> > > +       for_each_populated_zone(zone) {
> > > +               for_each_online_cpu(cpu)
> > > +                       free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> > > +       }
> > > +
> > >          show_val_kb(m, "MemTotal:       ", i.totalram);
> > >          show_val_kb(m, "MemFree:        ", i.freeram);
> > > +       show_val_kb(m, "PcpFree:        ", free_pcp);
> > >          show_val_kb(m, "MemAvailable:   ", available);
> > >          show_val_kb(m, "Buffers:        ", i.bufferram);
> > >          show_val_kb(m, "Cached:         ", cached);
> > > --
> > > 2.35.3
> > > 
> > > 
> > .
