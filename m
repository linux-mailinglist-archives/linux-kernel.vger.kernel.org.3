Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBF5876E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiHBFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBFwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:52:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5E47BA6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659419561; x=1690955561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y8R9OD5YaXqNfiMllxG+s9LDEo1cHmJGkx24z7/0+Ow=;
  b=cvssQXovrLtt9vb7xkUTCfDMF/FTvAhtLQM+6DElUdBRvGbdcuSP4aYw
   ZaOPnLltrF4joNHzT2dUrvWKWy8l6kTZ6sFYO8kKDUBtrQosDvqoe8GHz
   CwdhkgaqpWAMEgKObC06k5EoyeJjQU0Ig0fSCoGw1ilpEOiaZwNszH8js
   4TQGkGeAnyhlY+netDFMOVaRfjxoYORgw7CPBelnFIXUP/4XAu92mPcTM
   kfEEJxeoA5fcW2g7Hv6cnb21twpiFXlqnjIoWg1VoFvapoi2rZNWjS921
   ySqaOQF96SVX+9hJLAONPKjFyz3rkvbuDdJ2A+cZLrqqPF8nd1WAFIzZw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269708357"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269708357"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 22:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="599185372"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2022 22:52:41 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 22:52:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 22:52:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 22:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIb/bQGcOCK1uapUadC/SoE94qBohwH5T5IHer7JuOvfppxg2S5ebRtSB3zSEfNCZiubWI/DqVeS17h/xlIN/Nskfgf23fzk3/VT5CPIjvJbx1y2JJroKsWQZTHQGuuJEuoD0FU2HZV363HhOSef5eD7wX96eAWwaHpXsoy7xMGYOB9KbWlMsWxjRluIVv0UTIb0TtYNrvySOPHds6dtRqQJqBPt1Se7ZJaKqAeAk+b+UIpsaaR06FhwZZRW1hsa15+8ZmoSP64bRQo/OLm8XoJF9kntHZNTlM7yiNPTekXcPsAfgzZRGsNEZariuaBSRUxFAYESA2Qe3YEi/xUDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxMByLRjhtVGfpdfVRf0ZF8f+UQmJvmnqWRIpIexszk=;
 b=mplqGloLdhQ4O4AfqiqJSsSvCMHCk0FPr+38ugu7gwRVT0hsDzgCjzvgK9o1lLFaPPC4XyuEhxNuf3CRAzPNKdNk4huecCiBqdFzha5WCTKU0Hrbyzi6HStO/UNXMcBcLLK3R0EApwUHKgc6DXZ9PkZ6A9T+6MT0IHm399rRV/1MPbKS1xKo6gLMzq6T7ohm5Xi8sbrtT5xOeO18Dmn3LhVSogapEsPgwEZ9pLIStpLpd2SI39ZNxFXUJnbw5wSkTkoYXCtIYu/HhFtWDG1FoPWISFXCOgm9P76v+kfqD05V4udohOTVp3NJfdT8pAvVmJTWw7AvDkVmB4xi+mJU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BY5PR11MB4385.namprd11.prod.outlook.com (2603:10b6:a03:1c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 05:52:37 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 05:52:36 +0000
Date:   Tue, 2 Aug 2022 13:52:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <Yui7hWZYMX31ktOr@feng-skl>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b1473e-fa1e-4af2-d804-08da744b33bb
X-MS-TrafficTypeDiagnostic: BY5PR11MB4385:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGDsHyBKgkZaOK7Qbf/0AsfC4u7rOkXgVNdOwIyL2fvsdTIhhdpzj7BUNftm1p51VSDvdYFEh2XkGq13ciuEWQjSiMu/mm46raLC1dLYf5HsqDbph4QYM9j5fnz55x/Y2syQjwi0FhyIPT/XpnpS35VgATfVWsGpbzTwpxjHjiGDGoupITJDIDNkFmpIpC2SMYA0v0tPwa8bvbflEac2IC/N7SKidtZGS/BHW6bBVx166kdKzJkV+kc5z01olOqMc1/jBRffuzVxfoIHgKsmixn7QyUEo5zCBFaToJ4eNhRPHr2BBpxSW/P1RzeksNBLhCp1MnmjaVLpSPUsskM5RBSYmwZm50BV/D89vTUwe3oaHvAfbA5NXYhva/BMdHzLLqgbZwSmNmDSfqYk94J0q/Kd58E7dgDZkMZMioiDyGD2CNpGBp0cgQRCOPyyWbQlC/O10k6R6esonlw/r58Ws4R12jEckAqUHGfPO4iJBjy/sHGBRRoX7Txlbv2anpm50LTlw+fQK6Hi5pqKvr+qIREVhV4/xr8Qr/sUHHQabsDpBEkRCCgkhoCgAds1RKrcP16wLZ8gKiBk84wq/uk1v2yQ1UBcmZ4q8PqA++MuuZckQCJHVr2NVauxeNlLNISNpGdlgn44wGvDIs75ZiEcsG06KRqh0hx2ppGsxmXZCuAT2f4wL+4OqCEEJhWz6EO6mVnOdhnZXRaGrYma3Mwwa9yT2f76jpjyR6b5qeoatslJdyAicqSc8GWEe55WAzsV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(6916009)(33716001)(54906003)(6506007)(44832011)(38100700002)(8936002)(26005)(9686003)(66946007)(6512007)(86362001)(186003)(8676002)(66556008)(66476007)(316002)(4326008)(82960400001)(83380400001)(6666004)(41300700001)(5660300002)(2906002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?td0JosObEyhgQmq2CVqT2smVGRE0WxgHlFS88+Qz5a+ar7J4JoD3J+BE4Lb5?=
 =?us-ascii?Q?5qQMCEd7wozU7Da5hRN0xJ2Dej2h+QPiSISomsnPWBKsXVgxwcNvrYTkoTq+?=
 =?us-ascii?Q?ok0ONEJqODh7Y63BKYdAbgMkZjnjA74UHrAap+Fy8Uis7Xz3X8oi1X2w6IZk?=
 =?us-ascii?Q?gVU//D6wgxiw2oEI1rmWj0GslxuKUJ5hk/perYaLUqKwPm/zldnD4rpl0KqP?=
 =?us-ascii?Q?AxKO3hYsGTMd2tlnpKQpC9+edqn+V7s2VpcQUDS7O8XX59D6AmMNm54UOLYW?=
 =?us-ascii?Q?cbvRVSVQmuSYNXO110AWFwc4Sa9ZwJJXLVo32RFZrEfeCul4ePYaB12tAMl0?=
 =?us-ascii?Q?fpBLTbMlP9CcS7Mh2TCduvl60RCQeb0IXidppalWJxYTptDPzaUD3bwopcg3?=
 =?us-ascii?Q?h/9nhDHQwdTVMu+NImDGYGXDlNOhdlxvHDDj+gazkhUnmts7FpoMMRfxzJa6?=
 =?us-ascii?Q?rTmQKa1Hy3Js2dWzlNPgfO5xidw+bM144gHP67mquqmIWHjWwZHO1Vg4keTO?=
 =?us-ascii?Q?Kbxqc3MJqZdhhlvtGBvgxLA8sR8jqcme5Jn/T5S1RvHYfW5J3eNZX2W3qfr/?=
 =?us-ascii?Q?bg0BRrPTThHSNLoVdxnPDW9MQr5rOMN6PJJJJWbLn13daEy5UExVeXTkeDEW?=
 =?us-ascii?Q?pM5M9OXAUY/MGAjvYyMoZOShKjtAIHIwTQFsY6jqDNIYoW/lD7fZ7zLmk4cV?=
 =?us-ascii?Q?1h+kD0jCrKWawkOfs4rYfnV4ZdJHyN05rdWlmIy0LhgQ5Af4dPmTJE5lqYZo?=
 =?us-ascii?Q?GwQKY8feea8lJh3v4/oVntn0Vh1N5tdbTb5A73617LkJUfQBwvAhkAscK1eN?=
 =?us-ascii?Q?7GIwUOIbYAhkNbDMCtfw2b2u0/fdWowuqEjomW74Ths4SszO338x8AL5ouHe?=
 =?us-ascii?Q?fSw3RYh9QVsmauTy0gJ+3sY2togz8La/IvRuuWVj66iLfxTardt3DjgLPl2v?=
 =?us-ascii?Q?5+NGAvQfgyPSxLTSm+L0rJktHAaCGPixCvdsPfMtkSdHBPhoVuRya1QUYXSE?=
 =?us-ascii?Q?QR/U2xgerFpF4/Nu8RsSY20PEnzLtXoT5AVklBhTBjmvauEQAIVVj1etcVwG?=
 =?us-ascii?Q?CBYxJ2R6Lo857b+D5TC3GnuTsUgQh8/si0abQtRQFGf9UdCzgWz/UdaZt+Gb?=
 =?us-ascii?Q?o9nEnbZIjLGRq0jOvolmBYXtsZY8wLpr2fratYn2W+ZaVToN6QvlIb5UrYQ6?=
 =?us-ascii?Q?wymLuFLRJutFhjd+GuGl0jHtTTz2xlqczPwM1u1Cae5cKPJuBRMYza9X7P8Y?=
 =?us-ascii?Q?/GHfj6taLxs862SUHEWJJCf0qmsNTo6dznWXKpyFsFJmX2+C6HHXIIAmDnyN?=
 =?us-ascii?Q?mZpO4ceDmn/EaSrIL67sfpI1A2ega8u/oP2ziBcUdpsbSCqDCoaqKIonI6fU?=
 =?us-ascii?Q?pnzlvTjmKpYjL4bCNFb3T3yLdGOdza2j8INIWMqjMoqUZCu6FMkabcjSZHRR?=
 =?us-ascii?Q?P4IYsHT/Gf+ocxPHcFCbBpnhZVHylLg0biNnQ7axOM09A+UJE0aHMwI6gxXv?=
 =?us-ascii?Q?0Eu46g0W7b0jiJWQ8huNTDKnbsyVxZ4Y9WQRY+r0gEyXNRAI+aBS5TnE7n1k?=
 =?us-ascii?Q?QTHpkOen2c7e0/LyhXuaoEO+HxtZBVSebUdfLymZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b1473e-fa1e-4af2-d804-08da744b33bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 05:52:36.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /skIWV6rIdIQB1zMIcCPFYcuCEDNkbCuU0aVCW3qDNY89k3vcyyHlErbiltIuzWSrLtnZB8S1HplXCkOQQZgeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:42:52AM +0800, Muchun Song wrote:
> On Mon, Aug 01, 2022 at 05:26:23PM +0800, Feng Tang wrote:
> > On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> > > On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > > > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > > > for filtering nodes for page allocation, which is a hard restriction (see the user
> > > > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > > > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > > > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > > > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > > > calling it.  BTW, it is found by code inspection.
> > > 
> > > I am not sure this is the right fix. It is quite true that
> > > policy_nodemask is a tricky function to use. It pretends to have a
> > > higher level logic but all existing users are expected to be policy
> > > aware and they special case allocation for each policy. That would mean
> > > that hugetlb should do the same.
> > 
> > Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
> > confused about policy_nodemask(), as it is never a 'strict' one as
> > the old code is:
> > 
> > 	if (unlikely(mode == MPOL_BIND) &&
> > 		apply_policy_zone(policy, gfp_zone(gfp)) &&
> > 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > 		return &policy->nodes;
> > 
> > 	return NULL
> > 
> > Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
> > still return NULL (equals all nodes).
> >
> 
> Well, I agree policy_nodemask() is really confusing because of the
> shortage of comments and the weird logic.
> 
> > From the semantics of allowed_mems_nr(), I think it does get changed
> > a little by b27abaccf8e8. And to enforce the 'strict' semantic for
> > 'allowed', we may need a more strict nodemask API for it.
> >
> 
> Maybe this is a good idea to fix this, e.g. introducing a new helper
> to return the strict allowed nodemask.

Yep. 

I had another thought to add one global all-zero nodemask, for API like
policy_nodemask(), it has 2 types of return value:
* a nodemask with some bits set
* NULL (means all nodes)

Here a new type of zero nodemask (a gloabl variable)can be created to
indicate no qualified node.

> > > I haven't checked the actual behavior implications for hugetlb here. Is
> > > MPOL_PREFERRED_MANY even supported for hugetlb? Does this change make it
> > > work? From a quick look this just ignores MPOL_PREFERRED_MANY
> > > completely.
> > 
> > IIRC, the hugetlb will hornor MPOL_PREFERRED_MANY. And I can double
> > check and report back if otherwise.
> >
> > > > Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/mempolicy.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 6c27acb6cd63..4deec7e598c6 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > >  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > >  		return &policy->nodes;
> > > >  
> > > > -	if (mode == MPOL_PREFERRED_MANY)
> > > > -		return &policy->nodes;
> > 
> > I think it will make MPOL_PREFERRED_MANY not usable.
> >
> 
> Sorry, I didn't got what you mean here. Could you explain more details
> about why it is not usable?
 
I thought alloc_pages() will rely on policy_nodemask(), which was wrong
as I forgot the MPOL_PREFERRED_MANY has a dedicated function
alloc_pages_preferred_many() to handle it. Sorry for the confusion.

Thanks,
Feng

> Thanks.
> 
> > Thanks,
> > Feng
> > 
> > > > -
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > -- 
> > > > 2.11.0
> > > 
> > > -- 
> > > Michal Hocko
> > > SUSE Labs
> > 
> 
