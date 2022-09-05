Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7285AC8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiIECzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIECzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:55:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75423BF0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662346543; x=1693882543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=betv8YrBn42I9aJhy8zLTdPyl/JR5185P9/Iel7YPIc=;
  b=aLftVM8wY8Z6wEqOClb9/90uNilORQBU66lNUicHd5SLB/VOtWQtO4dj
   wpm0M70Et09b9soHaHAGeQU4bdWgjFjEivk0lB6BRqIE8j8BJkYD2i3O0
   BHoamX9g1/Xfc+dlFJXthp5bOPPY2alcvb3bAJfftjXyuTkgPXUh/VH+9
   vbeAG5qNlaSsZM67KJIcS8+kpRq7Uhp/FNsY3Vh1BcbjseIjb1+HkzJDE
   q5A9Yf6/w4zDrsNxEpqcyz+U/C7V5FPW+xnEiMvZwBdqNxihEA1VSHru8
   xUwEjwPF07zqCDJpNXGJ2Qcsnbz3Z1Q64jLyQQbxyU9vd6Z6P0vSYuMpg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276035244"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="276035244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="616262688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2022 19:55:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 19:55:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 4 Sep 2022 19:55:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 4 Sep 2022 19:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euT8A0EUv4KLNps4qnYkxcZT82oRsD1mFV6osBCK5UCG59uxWEEfkh7GO87HJACfEnMj6gprnsR7oGzRH/6tgj9vYhAiXgTN6R/PDg6IR3d0MQJgdNjmcw6+I5JgsPgVW7Ivzai4xen3/8pjiNAlk+uf4jxJ+DzFi1BkTJmNaZTOIA7omkjvUtSsFrbhcVFgdBGrdEXCxyRY8xDmIxAnpmk6skWUKGWUXIyAk3iC+ReL1nyK0QZDGQZj3yWV4dcjXmJy4McYGrEPX7MX3vkdV0TSD3pNrjRjmBCvrRGgaJJxCQn4DCxf6YVHeFFXTOv/kiAmjVd3jUMx4lS0io7eRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzqnMg9t3VdHG3ZjORpT667lP6P0TeJRrTdcvEHUppE=;
 b=TkSiitZF41O3P79WXB2V067h+OBwSbVlEDd0oW4u8V4sXli07S7xy/LRe3LaR3ZzII6MrOPpkoe0SXv88FJNKgQKQqaCaVv8BEeeMPxYrAvpRMdFUBhsnw+H+b7TURqD8H4pGX5nwehfXEOvmJPIeY3fTNIFplrga4pmZ4d5VwV2uKTGm2n8JcVOri1iQ26XTDC2syrduL/NkCS3oXE/fiioAYrOfnTQ/HVcZ4K/vty36ZE/UTIc7VcfHVwab5AtIH9c9JQlK7xQXHSUAdaFZrIFuPxAbNMyD4j1B+AsUgr/YhCA00aZezeQjD+sD93xiY5Ns7bzpATa+wHbCEgrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4191.namprd11.prod.outlook.com (2603:10b6:208:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 02:55:40 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 02:55:40 +0000
Date:   Mon, 5 Sep 2022 10:55:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxVlB/YRj7SNLqml@feng-clx>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx>
 <YxSE6XmHl3itv4JY@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxSE6XmHl3itv4JY@hyeyoo>
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c2ccbb5-3370-480a-79e3-08da8eea1e05
X-MS-TrafficTypeDiagnostic: MN2PR11MB4191:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWX5vVzktqp4q5q6AhLfprs/ZotCfHeayHS1C9YZu2p1IyJBCP7bL+FFufVOIjJFn/5Yed1hGExAVvh5KlEe/UC2WyBktcCsLzFE/uNGHJfjOGFUn7VMSZd2qiglUuTI1igYGkOZvQSzI+mEPLhbpdx3ntO2KWL4gUpTYCPjmyR9r2l5DIWIURyl3bUEJpfWpZ+Mq5Lybzuq3G2tN2LdtFGkmDR4lyXQm63ySHbOhmCSWAIAAB3dXL8NM4w7qoyFQq1H2o5C7LkEmWJpMf55Bf0zE6ZMNSffiWONKq+6HmtVm0FwO/My+x216CPJJZoBpDgOIcJG9Hn6oQ9CjMpXh4jwhpEX7NjBIZsDs0NMRpzzxEqSZ8C4Bx9QpV28M8i5s7C6K0ydsr+Gjs7PmrZFTLXnn6hAYvdHwvPh3HY1+fbjcSLz2whYS1jL5MfDYXksjjbzFFdhYF585zypubAS5i025k9o6gZgGoF+nNVcqNCtmcAy+9Fery/pbsWRGg8QkIYD9Iahjffi0cWJrYVkDNRcCLtMK5f95WKIhFJwOo+KSfe5SFS7iHuG051JqwJSU/9kUJV6OQx3CALp2z077CqcX8tUxoQzhSOcVdf3XKLtijqGy3CR1CJ6F0tJfGXl+u8eAidWE68BkdiUJJazHGnRvIdUoJCI6t6Pbe6hfxvFTIULTkurq39RbkR9tsl6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(2906002)(6486002)(66476007)(478600001)(66556008)(66946007)(44832011)(4326008)(86362001)(83380400001)(6666004)(7416002)(8676002)(6506007)(6512007)(26005)(9686003)(186003)(8936002)(5660300002)(54906003)(316002)(41300700001)(38100700002)(82960400001)(6916009)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6Dn6q5Tjca0nRWOXQy4/XzBlw1VNKJz3RvRezrV3Sk3gV7hK5N4C79zaK11?=
 =?us-ascii?Q?NJP4kivFcrxnMErObxC36iFuQq2xMeGnWXF1eb9fC1KZMwOJjeFv07Y52bXh?=
 =?us-ascii?Q?ZYxF05ofqM4qbaeP3S/TS/5dfNtMGSNmuLogO4GvNhNFj45u+X+8/BqHtMuZ?=
 =?us-ascii?Q?2HPH8Zp8WQO8MRbReLuWRf6wLNusohF0odJEsZcsUqRCHoy+6AuZYjj9XxAp?=
 =?us-ascii?Q?VYUYxSMXy1uaBbiNbxTCvcP13nttp4+R99ZG+1D7B9v+/kxdnqdOVbU2c2Qu?=
 =?us-ascii?Q?PbtBeB7KujUkKqpyM4+N/qNLr7BfOZYk9rUgkOVSRm/Oc/AzYVigo+B3POhi?=
 =?us-ascii?Q?rap1PJ0FS6w+ns3w+iyqdS751CK0QZCuHATaFXwGZH6cFUGazXLCbIoyJ42X?=
 =?us-ascii?Q?moy+P4uqjxCjF60ntNisNkudtELLjmg6pF/+/K51lDCSWjTYaLU/PqZHl1FB?=
 =?us-ascii?Q?pODvLHi4bJX9SxGQ8HUZQ/vIh2FlJYTXlj2XA6G1mdFMGlf2yg06bIuQVDdk?=
 =?us-ascii?Q?T58/k3syoQ1Tam5YhoBNBjrM1shCPhu6kSOFkltDu2FC2bspmvCR5vNZj9yb?=
 =?us-ascii?Q?3gp8Mqj5N9g16WCph7D6lI9hg7zXtfSljpQZxilFJSMmsPMhNpcJEQRIR4Jj?=
 =?us-ascii?Q?x1EFXllLA6aKtudx9D/zNoJJHjtivDvIgedUE87NfIn7dHNc4nY7Pa7Rw7Bo?=
 =?us-ascii?Q?Iv07K3mcJ9J56HOajWCoc0jMsdToXp0swnj7IO4Q7ifFYtIfcFJLFUvgAXsi?=
 =?us-ascii?Q?44BWeYLvUUnxmcbV38xTphfmzqko4vW7gz1g2JnT6mJ1J0QBfL18tJ3I+4Jr?=
 =?us-ascii?Q?GuV2lkOdzNROeYC72ABxX0e7C3QRl6oawecP6vu/VW6F9Wjup1u4F41VAK/9?=
 =?us-ascii?Q?mT6PEBmwnpHmAn55T9SgmI4eBbL/4Y/d9+wMfDhx8chQFEX3LX081TQt87/d?=
 =?us-ascii?Q?+pROIKyysyXZIFkMi8cH3sXRmjktjBaS1DPWLK2mR+dHyb84lYcNy5Quet3e?=
 =?us-ascii?Q?Kr1loz0t8/NNHWYGa8nvFqUgyJDR2y3+3SqWhIYsiA5b8As06UY7/Z859avu?=
 =?us-ascii?Q?fntho+YofVhRV2m8213UcNJcUxo5P4KJZmH3Dnv6moeQTwJHRb2fVL6Xuvpt?=
 =?us-ascii?Q?bv4i8xdSFMX3Ph14bOlpRLPCY4a6qntE8ZnzeFKmXCTNOFYVvJJttMXmpXqO?=
 =?us-ascii?Q?uxMWBAQ4IfNZEz36cBgrqp4EFN4VRkrdKvPyattYdzN4bxhCAf7ShZHommHt?=
 =?us-ascii?Q?W6WKTuyBITuY+Und/2VvLzdnSLUTtyazrB0JRYlZ1H3BzvKfl8VAl+tAbni8?=
 =?us-ascii?Q?y/SANcaNEvKsk4rAhlpD+g4ULeixTbfl3OUXkkdgTaJfmUGVJe/Nj66JD3e6?=
 =?us-ascii?Q?qfCG5L/woBDaXlHas7+s/4JGi42hocW8k3vZGZZVWTKn2noNo2176g4VulBX?=
 =?us-ascii?Q?SdJ+RHNlUmjHGhrop9AtaPsM+1puhTCOnMPQ1WHvhVe5sNthBbt7Pdol9F/H?=
 =?us-ascii?Q?W+5Xn61fv3jpNztPxYCO1knfaWRHHufrDxYQ+5FZFxzjv8aLw04d3T5eVBwX?=
 =?us-ascii?Q?ikHOPVoRrF5BHwrDtUy84L01pL2UlYKbXBE2gSHO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2ccbb5-3370-480a-79e3-08da8eea1e05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 02:55:40.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWS5roB9zrS9N0tvzZdhUHhLiDjQ0rNSdpmWW/XxFZeIWN+As7Hf0CIzv/fqvRv6Pwdt8nOonLsJWXDQgvdMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 06:58:49PM +0800, Hyeonggon Yoo wrote:
> On Sun, Sep 04, 2022 at 05:42:33PM +0800, Feng Tang wrote:
> > On Sun, Sep 04, 2022 at 05:03:34PM +0800, Hyeonggon Yoo wrote:
> > [...]
> > > > > 
> > > > > This patch is okay but with patch 4, init_object() initializes redzone/poison area
> > > > > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> > > > > Why not do it in init_object() in the first time?
> > > > > 
> > > > > Also, updating redzone/poison area after alloc_single_from_new_slab()
> > > > > (outside list_lock, after adding slab to list) will introduce races with validation.
> > > > > 
> > > > > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
> > > > 
> > > > Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
> > > > done in alloc_debug_processing() (through init_object()). When
> > > > rebasing to v4, I met the classical problem: how to pass 'orig_size'
> > > > parameter :)
> > > > 
> > > > In latest 'for-next' branch, one call path for alloc_debug_processing()
> > > > is
> > > >   ___slab_alloc
> > > >     get_partial
> > > >       get_any_partial
> > > >         get_partial_node
> > > >           alloc_debug_processing
> > > > 
> > > > Adding 'orig_size' paramter to all these function looks horrible, and
> > > > I couldn't figure out a good way and chosed to put those ops after
> > > > 'set_track()'
> > > 
> > > IMO adding a parameter to them isn't too horrible...
> > > I don't see better solution than adding a parameter with current implementation.
> > > (Yeah, the code is quite complicated...)
> > > 
> > > It won't affect performance to meaningful degree as most of
> > > allocations will be served from cpu slab or percpu partial list. 
> > 
> > Thanks for the suggestion! I'm fine with it and just afraid other
> > developers may dislike the extra parameter. 
> > 
> > The race condition you mentioned is a valid concern, and I have thought
> > about it, one way is moving the set_orig_size() after the redzone/poision
> > setup, and in 'check_object()' we can detect whether the 'orig_size' is
> > set, and skip that check if it's not set yet. As the manual validate_slab
> > triggered from sysfs interface is a rare debug activity, I think skipping
> > one object shouldn't hurt much.
> 
> That will require smp_wmb()/smp_rmb() pair to make sure that
> effects of set_orig_size() to be visible after redzone/poison setup.

Yes, synchronization is needed here.

> Isn't it simpler to add a parameter?

OK, I can go this way in v5 if other developers are fine. thanks

- Feng
