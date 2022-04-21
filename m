Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4C50A1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389047AbiDUOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiDUOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:15:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26773A5C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650550317; x=1682086317;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+LqE0l3ILNeXl6HvOC9gsuOf/SZQbw9Y0W03M5KdHqU=;
  b=esfOfP+XFzOOxgRCXCMoqsrUgKrsWjcqoA6qbAcd9tbjP8fULcSkgkn/
   AQqxoi5DSIipkSm2hSiK2BVlgxKqIfunDlTottEliRVPLvKW0XjLgjjcx
   1nm4p5miuK1n69n0QcgndqO6xZJg5Wmg7UiptYlbMqlngEt901ZgY05ah
   kIUSL7EtG9GNYDiTmCVMa1D3OYfRe3VWDd5EIaCMeKwu4QBpXBPi3gK/V
   bWgB30Czy9f482xFHc/6Udz/nLNaU89vbNqKTNMlvZn0Xs0W3+CsbzX8H
   +ppHO2NUT7Owq812cNR9EZj7W0G2ZgaRPgIIRJhw/t+l01m/BsINvE2Iq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324804962"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="324804962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="728006895"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2022 07:11:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 07:11:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 07:11:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 07:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X065yu1Gh9wM67JIL3GczE5O0hwpRDaSly6dlAPRZEIGhFdWs755Yll9C3xp36ZL74Pvg2nLExwCcZwvXycIvp/IBeGeIwPaH9wJ9+Nl7SkadsqkrrbV4V5BCS/3Sr7tVhnj58Acu0LrauBcl8QvaJQyEkXAx+mZy5clEqajHD5Qf+iXneeLURoKZCCOyENzAUAVWH5hAw5wwUZ6pZ/A6J4xPDiH4oyVFUXyB9sqXyeiJpqstMQhZ8gf9e7i3TSwRUAfJF0lSOQ9yPbNVCq7BQ4xNBCwGu4QfiASii0JP2BjDdmQvAsyu0w3BFPyVfdSp4bSdXv0bYcCiyBBQc0gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJRWNAkFIMlGX1ear7wSRXgWovA8OkHNRFg/+z4Z3pQ=;
 b=irIT2KB1yDK/L1FogGI3GidOwTj2SzypJfbkTjaUprtLVjL7zca3O+u9mawcfFOQp0nN2jGZi5o187UkKniLa/VgG8lycPxQCy2uZug7TzJNYmGG8UGeuVUERFgvRfs6rQkXuRqQRbYHG9OkhJAH8aue/qTIQk4zpjQRT0Cl7bgaGPed4mMB2SmKbenty1qETCxWlVg4x7WaqZfvRFds/+N5UyTFgKJUX1tUsgx7q43QUfbfUCR2QLGaSiEQ4nTAMWqEmcMfxydvzHPrO7w5UGNQNMUhJbrtxniZkuFzFLStuFZgEsCAhD9IV5pJzwDxdyDgtqMhysHzihHtKXkAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BYAPR11MB2744.namprd11.prod.outlook.com (2603:10b6:a02:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 14:11:53 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977%6]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 14:11:53 +0000
Date:   Thu, 21 Apr 2022 22:11:59 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmFmL42W+OrORElV@ziqianlu-nuc9qn>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
X-ClientProxiedBy: HK2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:202:2e::27) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e7dee00-2338-4eaa-f621-08da23a0e22b
X-MS-TrafficTypeDiagnostic: BYAPR11MB2744:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB274470934E03E0CC54C36FBC8BF49@BYAPR11MB2744.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOVh8Md8wsDd0ZPSOFpscVunMt9qmLF9DdHXOv25rpzhYiRnNlBkWGfaC1IdzcUTFotovDm4633Y4vQk7cHJTQaoPq8vYlxwsfMZLVO84S8vZ2Mhk+tK76kVNE8Erc5dWK3DH7rgll2oQKDsBHlGRcHwtliabz97S481k4jLlFzu6iQSxBI1reTMB4x2Ak3GlTJAfcuSq+Oph8Da+f2rC3UcomG4ePWcbxpFqFaWob4RJiFkmCq7jUXgWz6oIf5OUYs4PocGm7pDYPfk9ltzhUJRhLL2wQLzA5HDjgGESZvh0GQ8HYCfuVOqEcJ7F+l4TK+PIaMUT4bf1UiXAY/Tam1LpRLk8I3BP0s4buQIU58EvdRjPfhf0rDFqkWUjLOFqPkjAiyX2o9mFXXrIUoJNik8UguHzcJVdHwk5VKjhlKWBe4j8J4GjYuLmSqvg5txZdbqvfINFtO11amTSrBN6JbsnkToaOGUKhjNk5Mmik9cYcwHtWyOJqYku9FhEwNXqlZUQmVxMgg3J2FsiLrUxKA9o8d50OdnoVoZhyT2z6tGkqooQAzflyKMZilmUb5CEbWkfDljCPCgvd+/xObOiw0F3mJn3ZIjeuezfmEuqbRfDnK1v0mV0CqogkbWuWrtK3rNChyjTpo2hTCqosnQb6TG5Zv1wTsWMGBqLOwYiHovx5XvF1fmGqBpnxw9oNYxejHWETQo6exARxzJMUmrler6vRLgKME9bhS8F3zgFpZvSKToKr/wMaO0WypZeyb26DQTyDO4QfAN6dHaX/ldJK5l1c4vaxgDdni8i+C+qd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(8676002)(66556008)(6862004)(186003)(4326008)(6636002)(54906003)(66946007)(9686003)(26005)(6512007)(83380400001)(53546011)(6506007)(82960400001)(38100700002)(33716001)(86362001)(2906002)(316002)(44832011)(8936002)(508600001)(5660300002)(966005)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bsZdlq1SJmWM2g9s6m0u6lnNHJtJILpmxE8snaNYnnEXWdQF+8gQp3Zmfr?=
 =?iso-8859-1?Q?UsFUruz2Xp0J7u5RmO4MffRuzDjJm/o4TPuZaxXI8KKynDeiGYEHu2m9b8?=
 =?iso-8859-1?Q?TxZxOU0uHJTKn9uL9nYIbvXIXgL09gJAE9IEQQxSqAEiOgABgCl5sweFZF?=
 =?iso-8859-1?Q?o7tAayQlkV/+t4Ydphp3M+sYYc6W3RNgpuWX4fc3INSQWGovdAZ/hWUHIY?=
 =?iso-8859-1?Q?xGnjO1uaSAg3KpoBTiqY8PLMU2mLJALRXih5VUebdZHK2dCTRb6ZkgmUL2?=
 =?iso-8859-1?Q?3pXi9wTKm1RZxxm7APt9Im6D1HwQlo7R6oocsHF6XULHJuB5WF8UgxeQli?=
 =?iso-8859-1?Q?c2COjwXD7jMwHWp79qWBXMvF+a1qhQKWoufGR+am7PvKlYtDJ6EuW9aEFA?=
 =?iso-8859-1?Q?fw9HfWi7ooOOy7aEsjuyRARf+rBxlu1skA91ST2lIPW9sH6tkTUNXNdqVw?=
 =?iso-8859-1?Q?WR/FlGYB7ah/fxCA2IzXKclq1dnUj2nLp/SUeOFuxsC0T6EBU+J3fkpzpF?=
 =?iso-8859-1?Q?uq+pg8oG+Y228MUUuZvvEQQPVHqWo+hPtUL3oXPKI5NBC8yBmr52eWZGhL?=
 =?iso-8859-1?Q?gZd1zQPj9TzavvC7A1Um3Lv183J+4sicIdmUdc5DS+1IQTLXpDxFDljz12?=
 =?iso-8859-1?Q?N8MdI4Qp+15y3kfciupBINI26sDqANuOFTTa6z9bPIIoYanYOfgxZb/VHM?=
 =?iso-8859-1?Q?GAXv0GcBQJ+NrDWNBJGm1PCbhric+AIn2r8zNj+SlRMEntP97q98ocRxbb?=
 =?iso-8859-1?Q?9FgFI7qYjd2pzfH8EoXswGt8/UsnUYEHHryafEA9dMQOF/uoUv9SsOIZ77?=
 =?iso-8859-1?Q?tHUNAep+4PG/1CjZGZtKVLk7dSkykbn5VJ48bVFf8850bO1r1819TJpKrh?=
 =?iso-8859-1?Q?wI7rMH0AOovsAxmrIEs8pNbHjes8yAjvqUTsF3qY31Pp0RFsyOTik/wdY9?=
 =?iso-8859-1?Q?x8Cirj6qtMfbbPrznZFtlBMNSf6bjKMAICm1eA5e0u4h5SW0fu8c/LqXog?=
 =?iso-8859-1?Q?Jlwsd7jFWht3ajklvMHZpC4rFTQ4kvzzEa6eaSRt3VKScrzcGDfvAvGtU0?=
 =?iso-8859-1?Q?6Mz8/ZiiSpkq+cINjPJNdi5CO1q7T9KuWjrgv6qODY3ga0wbeQbY2xBf5u?=
 =?iso-8859-1?Q?A2sZN5nqMDeHYvApSWYuDB0w+H3RPhtR8tugSAbXOqxUWqHxjk/P5oxM9f?=
 =?iso-8859-1?Q?SngurioMBwSSV7JTq0S+JpWjpAgeeh+c5bB3DbgUydTSMO0+J6R2d0wfEc?=
 =?iso-8859-1?Q?Mmsfwhx7mM1i9zu7odPnsrp8gdb0gBN8UHIWhyYGndMBNA6kggT5p0fFYI?=
 =?iso-8859-1?Q?6FdJEO3l/9Bz2Zqn6wKaKpslhhkgTzTr699q3Z5kAhFtZoDOXBiHWWNxw5?=
 =?iso-8859-1?Q?P2Z77c3x4lBsSGaoEbCjpPfTg77N/k2txrVKrPMg8XrRcYsl7opOquQ5JG?=
 =?iso-8859-1?Q?+tU2xgTsqys2p/dOChcCdwKpEqYH5NzfXLdWYKezi9EWgOMXrjd8voNzfs?=
 =?iso-8859-1?Q?l1UmVMgPhscYjeIsewQMhYhs3mNHFe0Hhv5A1CfRsdjnGhVoFgoVAtoggS?=
 =?iso-8859-1?Q?P5EjGPXFeLKZnkfQAjPpoG+Q9kZDU90oYZbm8JftPhQWp98sOcq6fXsJtI?=
 =?iso-8859-1?Q?Y3CXZ7cypTskLkooK8EqMc16aQd8BfGW/hzJw0EwVdbObMEI6CoA78ggz9?=
 =?iso-8859-1?Q?zvuVfRLwlnCBC1andpIDGrGnkRRpQa3SiGkOdxz3S4WHOwonRPkJTlmjSi?=
 =?iso-8859-1?Q?1n7oCqwY355ap6OKwP/ud9OHD3arM6j+NGrYWg9Yh9zTsf0tHBG6Q3RC1T?=
 =?iso-8859-1?Q?aiqdnWzeCw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7dee00-2338-4eaa-f621-08da23a0e22b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:11:53.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZy3xn/BLWTxFQuLXqHlsXPmGl5cocgL0in6A90qbTFlRd2nlxyRvp004isl9ERiuE/P89ss5sv2oAENKsnYZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> On Wed, 2022-04-20 at 16:33 +0800, Aaron Lu wrote:
> > On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > > 
> > > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > > The swap devices are linked to per node priority lists, the swap device
> > > > > closer to the node has higher priority on that node's priority list.
> > > > > This is supposed to improve I/O latency, particularly for some fast
> > > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > > actually returns the nid that the reclaimer is running on instead of the
> > > > > nid that the page belongs to.
> > > > > 
> > > > 
> > > > Right.
> > > > 
> > > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > > the page's node, but it may be overkilling. So keep using the current
> > > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > > so it is not sure how much improvement could be achieved due to lack of
> > > > > suitable testing device.  But anyway the current code does violate the
> > > > > design.
> > > > > 
> > > > 
> > > > I intentionally used the reclaimer's nid because I think when swapping
> > > > out to a device, it is faster when the device is on the same node as
> > > > the cpu.
> > > 
> > > OK, the offline discussion with Huang Ying showed the design was to
> > > have page's nid in order to achieve better I/O performance (more
> > > noticeable on faster devices) since the reclaimer may be running on a
> > > different node from the reclaimed page.
> > > 
> > > > 
> > > > Anyway, I think I can make a test case where the workload allocates all
> > > > its memory on the remote node and its workingset memory is larger then
> > > > the available memory so swap is triggered, then we can see which way
> > > > achieves better performance. Sounds reasonable to you?
> > > 
> > > Yeah, definitely, thank you so much. I don't have a fast enough device
> > > by hand to show the difference right now. If you could get some data
> > > it would be perfect.
> > > 
> > 
> > Failed to find a test box that has two NVMe disks attached to different
> > nodes and since Shanghai is locked down right now, we couldn't install
> > another NVMe on the box so I figured it might be OK to test on a box that
> > has a single NVMe attached to node 0 like this:
> > 
> > 1) restrict the test processes to run on node 0 and allocate on node 1;
> > 2) restrict the test processes to run on node 1 and allocate on node 0.
> > 
> > In case 1), the reclaimer's node id is the same as the swap device's so
> > it's the same as current behaviour and in case 2), the page's node id is
> > the same as the swap device's so it's what your patch proposed.
> > 
> > The test I used is vm-scalability/case-swap-w-rand:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> > which spawns $nr_task processes and each will mmap $size and then
> > randomly write to that area. I set nr_task=32 and $size=4G, so a total
> > of 128G memory will be needed and I used memory.limit_in_bytes to
> > restrict the available memory to 64G, to make sure swap is triggered.
> > 
> > The reason why cgroup is used is to avoid waking up the per-node kswapd
> > which can trigger swapping with reclaimer/page/swap device all having the
> > same node id.
> > 
> > And I don't see a measuable difference from the result:
> > case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> > 
> > My interpretation of the result is, when reclaiming a remote page, it
> > doesn't matter much which swap device to use if the swap device is a IO
> > device.
> > 
> > Later Ying reminded me we have test box that has optane installed on
> > different nodes so I also tested there: Icelake 2 sockets server with 2
> > optane installed on each node. I did the test there like this:
> > 1) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem0, which is the optane backed swap device on node 0;
> > 2) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem1, which is the optane backed swap device on node 1.
> > 
> > So case 1) is current behaviour and case 2) is what your patch proposed.
> > 
> > With the same test and the same nr_task/size, the result is:
> > case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> > 
> 
> The per-node swap device support is more about swap-in latency than
> swap-out throughput.  I suspect the test case is more about swap-out
> throughput.  perf profiling can show this.
>

On another thought, swap out can very well affect swap in latency:
since swap is involved, the available memory is in short supply and swap
in may very likely need to reclaim a page and that reclaim can involve a
swap out, so swap out performance can also affect swap in latency.

> For swap-in latency, we can use pmbench, which can output latency
> information.
> 
> Best Regards,
> Huang, Ying
> 
> 
> [snip]
> 
