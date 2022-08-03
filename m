Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC65588CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiHCNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiHCNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:10:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6F638D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659532244; x=1691068244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gvdfXIpDR9U0X3BkONhDfNxBY0dzFfmMfpLsESnTgKg=;
  b=Oyy7mX5JHWaTgCYYt32qDe5QOn+uPJ/f+Cg68V3ee0Nm4mHrE5MwIc+4
   dapTpZhtrvnTkJjDFU6kVMh2NvTFfJTha8sVdB83qwXajcRFcD4CqUd3Q
   InnKK3jiPRn8CpoKmkL1Y25aJDd1BxOxpxD/ruoKfKVvja+n2+1ROJqRR
   jRfGroSwIjdJ6+oZFUwOQBLp8p8tcn+buO7unoCE527c8u0cHZ2peoYRQ
   RU+T3AihwhjbitHiT8o3eNr8PexFdt7RiW8pT0qJOhezpkmKQzVw8Epq6
   /PPAjXJZDKBmjhOF+WG4gwStss+hkkHjvIXwy7NoBGt+IUliGeqFxRIcE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="315527828"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="315527828"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 06:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631142976"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 06:10:43 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 06:10:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 06:10:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 06:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKs2sUDQC9g6nBWrTZCtzbESI/SvwboLNiuSsml+xZH5KywwB5OxXt+eDd8Kl7RaSWgVME4zWi/QR4PNjgl0ndEWdXVoX1I22oFxvf5VZ+APiFiHEHCTD9NJSFgK+zU5p29rJDe5OGe0ADWoAdLfbVkGJzhNWHRTbjsm7dXRg6LRI8q3Crv724nCuPlR3O7mNfD/BZ56XwfHZMN8RHVB0WvRSSkdbEnySOfUO0Sw4AQxRXjxhIu+Y4uaTPb5y2BVxFbdubbKSfMkRSAju9yEbo+CNFmI9ERDo0gMKEmgTgZA/MchR7dLXKCcKuWyLdT8IGZr+7RisPww+m+63slLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWa1jZj8UqnnARY85bdW3AgiUN1E0ILfUb3R2Bl6IrU=;
 b=m4l7gCJjrmn0v814IN2xdn6nomZ/ATYe2LnvU4fZG3LPS54htvsFlDJihZpMeO4WXfRs+NDbqM+JG9CCK36Q+4n29NAldYasngB+MoOxecPnolk3Gx/8dcoKRNXZFSJXnRoDrXbrQxV4xm9phO6vMcD1dxxEsMS6HChGcU26AYwVBlxz7RsG7uDmBBn47Y1aEPOCR8k+sCJhtwnWkMmK7OWbz4ydVNOBVaJalSBh3R6d4HHgZo7eCDRivwPNtY8nk86KjlvyE8/8iHgR+zXW41tKZBAJCv+xgRJOn7TSvYj5pr7IcpFKIl71SF8yiJfhnJm/Y4ljQHXiBpqmKtIijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 13:10:40 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Wed, 3 Aug 2022
 13:10:40 +0000
Date:   Thu, 4 Aug 2022 05:08:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <Yurj0sOXgGf40AJE@feng-clx>
References: <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
 <Yurd2iYp4XMIYM7T@feng-clx>
 <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b96cafcb-75b2-4a88-062c-08da75519019
X-MS-TrafficTypeDiagnostic: PH0PR11MB5830:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgnRpJq2YeeTSj1le2z6fsgzPvytS/2Dy0bZZ3TjRnw+CpM5ig8aMj19MH2zfCgnEJmCdzh0j8AaGHh6O534LUDCDeBiFzN66iiZci5IyUAfBOgq/jq4fKqi8pfAKNY0zuPjyQCmdBGsA//9XK5qtzyGHzF5x6x3Mn7cij6586Xv+KvqM0Ublvc3TKCTbRk98l0/ybx6nmwrcSlYTsrK/iJZJXm4WSZ2DiDmnvQDrn3wpb9KjUyhiKUPzLXSw0P1irdEnzNU1jy6rn9+tYrwA11++ulVmC3axVskfS0+G8OMSar9rGIJ44J+RzaWya8odwCjTRj5I6BG2HCLtfuNOF5ywPbSbph9RaVcxabBxdX94yl8M9AeRWMZ3OyEOP3ESGO6m4o4lZSo3JNv9f9htBvWd4yBh7dn7xIJOX717IoL/DklA8Bj/6yDmtbV5U1Ud7sPJNeY4JpggZX7l6nYRRjINuSsxBcS7W8xe/rWHJqIloBfdvfukCbHp++0r4oGP5o7xtwSDJSEIUi0KJgFLM4W5JhpRjSga+YMYVd7dzeLxXsCXncb4FvleKdxW2CeBJ1OzQzX0kAuMxAv0e1RQpvz2ouIAnreXyESHE0fCMW9Dd//MmvKMd2nIPKCL86XZyTfCmlkUA9wHYoqMn+fosZMWe3SGw0NeiJxNCN5X7WFYA7DLDyioJaq7qabA2DW1OqKTbyDij63xiedXod14XYoy02Qw0Tb03F4WMda4LVvgIgFTtTXRQRPHsGr48aq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(6666004)(41300700001)(6506007)(26005)(9686003)(6512007)(33716001)(478600001)(316002)(6916009)(86362001)(82960400001)(54906003)(6486002)(38100700002)(4326008)(186003)(44832011)(2906002)(5660300002)(8676002)(8936002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Ys3Tb8R/GfgNyWjoa+i5qrTbMqu0q5/2DyU3oH+29aScY4uDvCjj9JpLE0b?=
 =?us-ascii?Q?+SyhAkgrdzDZ85+K3fln1posxeH01Z+ombHuXoIXyLmCGS8S21pQGK0HVDAB?=
 =?us-ascii?Q?ti4GDDDMdaiIh7GdXf3VZ8olMfCXgHkTNSMVwRt3n8Z9LylqHbH6boqD2v2f?=
 =?us-ascii?Q?M+qZzC5PIWVierR00TvrAHwcQI4FZJhKeBfHn0pCWjuU6T23UKLPs0IQCrSY?=
 =?us-ascii?Q?NMZ63OsKMEwhYHVQHh4DI/FHXcQEuUzwMSX1WOoM8/Ad+gvDNmWOfrxyO/RB?=
 =?us-ascii?Q?f0zqhXUGTpE8y262wV0x2bYmuTbjhlJOTNtNu4DE/4EsEZNSFWIIv+Uz1A0V?=
 =?us-ascii?Q?t6dlMo1J5YaaSlZmyyCnOaTBzCkNIm6sInaMCZdSYg7WZfFk5Lt0jbaGi7U2?=
 =?us-ascii?Q?ANYJFH7VxWf/YTzJGMtPlcPMbSvU2IDZr1dAhtOXAx8MHXIOWbEKXCzVgWU+?=
 =?us-ascii?Q?JwJKM/AazdIkNgwRNPwhDQLB4SMDCMF3HXxKlSpRKTdmakAkeMu2QjQ3+Nix?=
 =?us-ascii?Q?hzYjxWkkYUPAY4t3zS2Yb5BrC+LDfmcDOqufJL4rSGsWjwC+Z4yfu94+wxA/?=
 =?us-ascii?Q?MJDuz2c12wBydFNVcZsa6t0TlBSZSPGl7yh5V1IHEkuNas8AtQxTrhqqdKJF?=
 =?us-ascii?Q?deDmoWz/6PuWsjzyuJgL7PFG956kszN0ky+7ZF+z+H+FpaQoI3MYnrPCM39U?=
 =?us-ascii?Q?4vkEjehO9n9PVojDXFjcsKG7EXc8XXjIHxlvtfzk4bTIWachUIGg20MxEVC6?=
 =?us-ascii?Q?zipNs0E4FEH+Mg/ZCO5n4GOT6xXVGavmQkzF+hmfygre7guahrR95cliCMy2?=
 =?us-ascii?Q?roq70FBZYIRDTkf+Lisl/N3gPnr1vrPFqndXvuHtBp2bummrObrsVZl4XARY?=
 =?us-ascii?Q?xeJpo7UD/AaY17Nndw9iZMssblqUe9J6NF4QaYXY+a3bIJEAvXYPPV463NYh?=
 =?us-ascii?Q?8pn2yp5tnR2E1EY3o/09DMXb+nDjuguBeTtDZmvbgBVVOwEHFiV3wEnP3Afa?=
 =?us-ascii?Q?jjY8APqb64dygTCFr9qxN/4aOIV+Bajb5iAi1xr7UQdh3rxTgmNbfCEpsnZh?=
 =?us-ascii?Q?Ez3cn40ux7HRMmoZehnalqfnJTVUyxT1vGjs0mb9jdjbkeMliSCnTIfZBCk+?=
 =?us-ascii?Q?qX7mYWvfzTv/KZPjX4T1mk6ovmulqiCkYsAxhsi8V3cRs63BchADtFd4iPFA?=
 =?us-ascii?Q?SYYc54Pn9uQmAHLWl9UT8VK5sqdUPKaA8Jv26E6akb1UNdIyNmVttJ7CIgGf?=
 =?us-ascii?Q?bweIXQY+GS6ZtIM7Jtes5Zpek6MOje64L+hZoGiD9vSOHrUUW+QQovBTBnBK?=
 =?us-ascii?Q?f/MrZAmAFK9WyK3SIcvWKdJlOVzS/kARBWzMwXTZFN9ADiOAdunE5XNuNSt4?=
 =?us-ascii?Q?bUtWhPZIn4EqWHtnEEAfeVKLIdrCMr+vh+rBmFbLCcEew5LvJmsXebHBPwSd?=
 =?us-ascii?Q?n1bjj/wLlNoZwBHtJheQ0jAIJMbGmSv3/NlqZkHxfD9zeXofVhvAeKdDEIb7?=
 =?us-ascii?Q?OvP8gfmmwCEkrt7QddYQ8tvqLAy/c6QLAMRwbmuAoJ6zpwuqFMOqayVb3OKQ?=
 =?us-ascii?Q?edFYqWF3FqxDD5dxkmA7bHSN+qqUXUF16pcpKKCj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b96cafcb-75b2-4a88-062c-08da75519019
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 13:10:39.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROmWV9yCbCmC8jMQJm2IgjC2V37Pgs83VStUgy1xmHBPrVLeTumTG2HXQY5U+hgEpk6YIHCsUgc/vgBbHED+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:56:44PM +0800, Michal Hocko wrote:
> On Thu 04-08-22 04:43:06, Feng Tang wrote:
> > On Wed, Aug 03, 2022 at 07:28:59PM +0800, Michal Hocko wrote:
> [...]
> > > +struct mempolicy *policy_mbind_nodemask(gfp_t gfp)
> > > +{
> > > +#ifdef CONFIG_MEMPOLICY
> > > +	struct mempolicy *mpol = get_task_policy(current);
> > > +
> > > +	/*
> > > +	 * only enforce MBIND which overlaps with cpuset policy (from policy_nodemask)
> > > +	 * specifically for hugetlb case
> > > +	 */
> > > +	if (mpol->mode == MPOL_BIND &&
> > > +		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
> > > +		 cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > +		return &mpol->nodes;
> > > +#endif
> > > +	return NULL;
> > 
> > I saw the logic is not changed, and it confused me that if there is
> > no qualified node, it will still return NULL which effectively equals
> > node_states[N_MEMORY], while I think it should return a all zero
> > nodemasks.
> 
> This is a separate thing and I have to admit that the existing code is
> rather non-intuitive or even broken. I guess we do not care all that
> much because MBIND with completely non-overlapping cpusets is just a
> broken configuration. I am not sure this case is interesting or even
> supported.

Fair enough, and moving the policy_mbind_nodemask() into hugetlb.c for
one single caller make it much less severe.

Do we still need the other nodemask API I proposed earlier which has
no parameter of gfp_flag, and used for __nr_hugepages_store_common?

Thanks,
Feng


> -- 
> Michal Hocko
> SUSE Labs
> 
