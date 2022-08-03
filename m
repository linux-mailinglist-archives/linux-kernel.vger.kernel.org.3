Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B36588C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiHCMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHCMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:45:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063936560
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659530743; x=1691066743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hmlzu7YTbn6XxNCvMHhqeXqjM8wiUh3c211y1eedi+s=;
  b=ZRVsUatzRhb/VW4TMwWghHLPwitPlOfPmStMBulFIJ+6FvYPDkuFbLif
   CLVpNyiIHxEeve2qNL6Me7Gkj5/E64dFOL+wQ5F4PYe8yWGcAS2g5uEo9
   WjvkA0V3thxWFIkFw6J855aVfFthP4yomK5q65rhL3opkSA+jevZu0xVC
   uc+G9gkABCRaOLCi6jXRkuttwkYx5nRT5M6MnTl9ORkL/AB9mMPCoaZX+
   Y1+n+UpTt/zQQqvcZspcvztHYYiRkZTkpDXij7wrMQTMLRJUZUvB1IZ3w
   bH1RWmU8FzELNU7kn7jZRPT/Xiwm2nNcHIsPd2G5lraDuG4KBZ36cbXY6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289672263"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="289672263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 05:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631134274"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 05:45:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 05:45:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 05:45:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 05:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1UaOPv9eHeFhDb4v6h63dVJU5s0ycJaUEcegE3eVKq0xFxMSOjQsifODcIsmLgfHF3n0GkI56IVCpdUywuCqDnye2eokQLTE+Kw26IpD5Vwh4l+R7B+oQU2R+hxYc1/QaIQ50dpQ6eLObqM9aExA4yLvpQXCazrrmu52c8pr6vp8UtrCkqJ7pqb8Ea8DJaDyX34L2HvOKs+JCefS7WP3/alcQ7FXptIo2H/dYVBPH+dZ9xcB01zQMOFZH7bOjLNmW1fpuE54zScR+oDOPX12J9ayN/+/Qt7WsNMSOyfvqJYiHkI1pJenZ1O3DkUxSWsetvbjxkxQzy+ehbCkYQvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L/i7odiCPkAs7aQiAk5BsAFFJcmUBaputx3YxOLdu8=;
 b=dW7Xda8eLR1hni4tyGgZW0LaRYcnmaNFlCaHHiRo4dmqmy02dbwDIgCQ53JWIidqfR86K5GdZuMFKdXW7547/RoTUybR2v3Szr9j2GbyeWm6jtz418XnqdjjnIND6LD1R95C8M/WFdTX7T13niVKmX2jYazKjZppwOCQSz9tW1LUxNVhbCpjg5ZnD5jFFoI0Vma+kkhwxnOTbPOyY61kYqTlHn+XTGr64nSegZB1/09ws3N6UT7bSVLHHwKhi3xxRAmPmQN2c2Qyx/VLgFVadwdBLXLPZOucYHKluFAgaOajrzZ/ykKWS1S8Z9LOCAFMijjgJ5SQxnZvfUMRnN3Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY4PR11MB1638.namprd11.prod.outlook.com (2603:10b6:910:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 12:45:26 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Wed, 3 Aug 2022
 12:45:26 +0000
Date:   Thu, 4 Aug 2022 04:43:06 +0800
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
Message-ID: <Yurd2iYp4XMIYM7T@feng-clx>
References: <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc16bd0-5efc-4873-ad4f-08da754e09d8
X-MS-TrafficTypeDiagnostic: CY4PR11MB1638:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgd9Hsk9PM7s1Fi1W6bKhCppeVDf9c46EETfJUJsN1FxVJlCQYLdiu84DBiMOa+Y10ESgl/WIANeBn+Uu9tE0jkAuVTTEJ1BFW+5Qw5keaHxuO+GtnbZWoX9jNfmTosokfpz0XIoDcOGAzQ7+lMsQYmcpnLmyf2I5K7anFIa2GF7V3PX66p9VRkSJnIcrmrbBa7FDdqAF0zyBwVjPkXbdMBB0GiHo02tb5YdJ9Q9j8iJzMSHQyiro91uiE0lFN51r0txydaNFidxL59IJHHZ7qAjEV7RsiVmPwB3J5760nKrQbnNaM0iYSq3Hnr5QlTFJbfbA1QN+FDegq16IXY6/jshUplg6lshE30UYnmbEOF5Wgl9F1E2oYjTicy43IzU0W47rqjOqeon5vCkLuqZf5LxmU0pA3X0gNVxzOZInW5lyB/6qOF6a3bUaYtuQ9YhTZXGD9aUsG5tEpUgLsZGGe6kj0T8nSGQCZgNx+vBF0apeXLmKGSN5W1f1UjJkbsEcvek0jQtFIprcPEoazHTZfPLdufl5WuAgpYZWQZFyff2QguWjg8LkiNQ1IY/N3meCBDjGOGgUU9RcBI3YasdONOjz9UPUyXvQ0B3DwOEd7WCVWcfG+pi3K7Wq0oxR4bAZclSYxySjy4DHd3GXnOszUFet2rFXBx9I8CzHNjrqxttHcPFbsoZsJ0pmeDvxys9Smt9MOMWfbV2RQxTzRKGcEMstcA0rD8MW+6nb3COjQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(366004)(39860400002)(346002)(136003)(6666004)(66476007)(38100700002)(316002)(66556008)(66946007)(44832011)(4326008)(8676002)(82960400001)(41300700001)(2906002)(8936002)(6486002)(86362001)(83380400001)(478600001)(6512007)(186003)(5660300002)(26005)(9686003)(6916009)(54906003)(33716001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oOug88UKotP+UPWo3LHkxMwVmz8YhBaoNyCsTqfg3y0DEhfkb2ds0BZhj5Rm?=
 =?us-ascii?Q?75I8YzbL9k5OI23fG5hXY0er/pvuxFiq6F88UxM8DTkiuXXUEUg/L5HutABr?=
 =?us-ascii?Q?m+jFkewkI1eTWwtFIaQ6Di1Bl2E0al46HtZTKswimDUoEKcYDdAGSBtQeAip?=
 =?us-ascii?Q?49PnvIak+EAW5hkF7EcOlaLGPELNKSwFTB9YBXTv4qNYawdWzaVnEE3c+/qu?=
 =?us-ascii?Q?FTwQbV1d+92z+yTQ53PjlNyZBiiY9NNLKscirtJpW6nl0RaBjeUzGpNzHqR/?=
 =?us-ascii?Q?W1JA18Q/t79k/fMUSmTGAigdLL9OLv57BYTglZocJTPpWwdyvtuHGfSL4kMR?=
 =?us-ascii?Q?L/1ZDQa5b6BzW82UrvLiwI1GhTCpQVnZhGwcBOEjDOVkxAje/CR7uG1dFriD?=
 =?us-ascii?Q?Q5Fmygkg67eilYutFWZ3ngpzz2ofO1j/eUt9Q1Zwwx69/gWNq2BWe+QShbcj?=
 =?us-ascii?Q?AEk8jshfHatMH8C4QysHl52/Fub0WDZeJbuNxv3viJA2NiC1An6U6LhHMHFl?=
 =?us-ascii?Q?+LJO7uT+/QThHdOBOAQ4I8bQf2dzwMSXGvxEk1grP+cUdLEJ194RCg0Ny7B8?=
 =?us-ascii?Q?nBvNb7xW+zXVmdMyg3K54yhcKKOOpkDshILnqREkZgMn0J1Kzl4GuGKlDzic?=
 =?us-ascii?Q?z1DsSl9fTF3P7pnY70ywlk9AyIM8tMZbFErvEeryUudxCwogt4LGjkbfHdf7?=
 =?us-ascii?Q?c1xZgJXaE9JtPZsnB9Jz7q7tp0dvZSl/VS7p+Sst6xJDC8R3cSQ0FZ6zpOdH?=
 =?us-ascii?Q?1Sgtwupv7Ti2DjjTvTIOFWhZxSptwJifIjot/baLw4DhNXxU6r+Idr+mNQsa?=
 =?us-ascii?Q?Y1M8N47h5hJ/ODJL+pJbUPjAfJoqFPQkqbDgnImHkegLDk5SthItkrpMlsEF?=
 =?us-ascii?Q?v3yx+zyVHQ6wNhQY8T+FfrWo8aa6hEjyk0f2lAWJHOuXP7PbDhu+V0yWaPZ5?=
 =?us-ascii?Q?VFG2U5bVToHdChDKXsVxYUeO/FVnG3Rw5gmECyCzfz2g22Arw/CRSLwUIbT3?=
 =?us-ascii?Q?rRmZQOLkvlhZNvOm7BFFqge6SHvq+uYVPWcnq+uXAHsAU6IOxxjubyp8RSMf?=
 =?us-ascii?Q?iUZfO0VOerRnmrYkj6J4N1+DKLCT46B1fd1aHb7oF+n6e6qPZlHsSzjjAOcL?=
 =?us-ascii?Q?p8MNFVx41ZuaIPFty441gzS2A7R/AQyrvl0MDBHqieVsOpMQyiHgVS1X8Tu8?=
 =?us-ascii?Q?CLm2LiO/Rwvtv1pk8ImIWitsTHE/W7mlgURN2m3kBbkFrZMzO2gLMlFtGAzk?=
 =?us-ascii?Q?GZvEca4YlS6Z6IA7C7FidLaiynn6dmiST+hmAoJzMl1XyXygrmIObdjHa3St?=
 =?us-ascii?Q?IeW0xiPsPElme9nEvRHzC/43WHL0jwBxEHSEC4jkIYHDI9jMuZJ5zXxdDrN5?=
 =?us-ascii?Q?XdnDgu0T5i8JKopPCcNBVJR/FlrGfZZns9iDUFh2gwl891MNSsudnz9vF3Kc?=
 =?us-ascii?Q?IAki9Jny2DYZmwCdWMAEvysX9A9wTzf0o5V50Q1ZVYhbkkZEMiXZIU9dGw/z?=
 =?us-ascii?Q?3nivkc2OAY258jV0sHNcJ3bs/nX4V8xSo22L2LH3Solst5ri//eoPr4yqDGo?=
 =?us-ascii?Q?z2bAv+Xy9K09fW2E9h+Mbur4EC+giW2XB1PEB96h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc16bd0-5efc-4873-ad4f-08da754e09d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:45:26.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpXFhJ2b+QJtXgGygMd1l2CB8ADu9sqB89TQOPbz47vb2FFZsfM6ROQvrtg9DoWMXdS05qJhXNEY0liQPxxaiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:28:59PM +0800, Michal Hocko wrote:
> On Thu 04-08-22 01:14:32, Feng Tang wrote:
> [...]
> > Ok, I change it as below:
> 
> Wouldn't it be better to make this allowed_mems_nr specific to be
> explicit about the intention?
 
Yes, it is.

> Not that I feel strongly about that.
> 
> > ---
> >  mm/hugetlb.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> Not even compile tested
>  include/linux/mempolicy.h | 12 ------------
>  mm/hugetlb.c              | 24 ++++++++++++++++++++----
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 668389b4b53d..e38b0ef20b8b 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -151,13 +151,6 @@ extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  				const nodemask_t *mask);
>  extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
>  
> -static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> -{
> -	struct mempolicy *mpol = get_task_policy(current);
> -
> -	return policy_nodemask(gfp, mpol);
> -}
> -
>  extern unsigned int mempolicy_slab_node(void);
>  
>  extern enum zone_type policy_zone;
> @@ -294,11 +287,6 @@ static inline void mpol_put_task_policy(struct task_struct *task)
>  {
>  }
>  
> -static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> -{
> -	return NULL;
> -}
> -
>  static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  {
>  	return  false;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a18c071c294e..6cacbc9b15a1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4330,18 +4330,34 @@ static int __init default_hugepagesz_setup(char *s)
>  }
>  __setup("default_hugepagesz=", default_hugepagesz_setup);
>  
> +struct mempolicy *policy_mbind_nodemask(gfp_t gfp)
> +{
> +#ifdef CONFIG_MEMPOLICY
> +	struct mempolicy *mpol = get_task_policy(current);
> +
> +	/*
> +	 * only enforce MBIND which overlaps with cpuset policy (from policy_nodemask)
> +	 * specifically for hugetlb case
> +	 */
> +	if (mpol->mode == MPOL_BIND &&
> +		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
> +		 cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> +		return &mpol->nodes;
> +#endif
> +	return NULL;

I saw the logic is not changed, and it confused me that if there is
no qualified node, it will still return NULL which effectively equals
node_states[N_MEMORY], while I think it should return a all zero
nodemasks.

Thanks,
Feng

> +}
> +
>  static unsigned int allowed_mems_nr(struct hstate *h)
>  {
>  	int node;
>  	unsigned int nr = 0;
> -	nodemask_t *mpol_allowed;
> +	nodemask_t *mbind_nodemask;
>  	unsigned int *array = h->free_huge_pages_node;
>  	gfp_t gfp_mask = htlb_alloc_mask(h);
>  
> -	mpol_allowed = policy_nodemask_current(gfp_mask);
> -
> +	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
>  	for_each_node_mask(node, cpuset_current_mems_allowed) {
> -		if (!mpol_allowed || node_isset(node, *mpol_allowed))
> +		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
>  			nr += array[node];
>  	}
>  
> -- 
> Michal Hocko
> SUSE Labs
